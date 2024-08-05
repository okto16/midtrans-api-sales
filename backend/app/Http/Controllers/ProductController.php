<?php
namespace App\Http\Controllers;

use App\Models\Product;
use App\Models\Transaction;
use App\Models\TransactionDetail;
use App\Services\MidtransService;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Validator;
use Illuminate\Support\Str;

class ProductController extends Controller
{
    protected $midtransService;

    public function __construct(MidtransService $midtransService)
    {
        $this->midtransService = $midtransService;
    }
    public function index()
    {
        $products = Product::all();
        return response()->json(['products' => $products]);
    }

    public function getStatus($orderId)
    {
        $transaction = Transaction::find($orderId);

        if ($transaction) {
            return response()->json(['status' => $transaction->status]);
        }

        return response()->json(['message' => 'Transaction not found'], 404);
    }

    public function buy(Request $request)
    {
        $validator = Validator::make($request->all(), [
            'name' => 'required',
            'email' => 'required|email',
            'quantity' => 'required|int',
            'product_id' => 'required',
            'bank' => 'required|in:bca,bni,permata',
        ]);

        if ($validator->fails()) {
            return response()->json(['message' => 'invalid', 'data' => $validator->errors()], 400);
        }

        $product = DB::table('products')
            ->where('id', $request->product_id)
            ->first();

        if (!$product) {
            return response()->json(['message' => 'product not in database'], 422);
        }

        try {
            DB::beginTransaction();

            $orderId = Str::uuid()->toString();
            $grossAmount = $product->price * $request->quantity;

            $response = $this->midtransService->createCharge($orderId, $grossAmount, $request->bank, $request->email, $request->name);


            if ($response['status_code'] != '201') {
                return response()->json(['message' => $response['status_message']], 500);
            }

            $this->createTransaction($orderId, $request->name, $request->email, $grossAmount, $product, $request->quantity);

            DB::commit();

            return response()->json([
                'data' => [
                    'expiry_time' => $response['expiry_time'],
                    'total_amount' => $grossAmount,
                    'bank' => $request->bank,
                    'order_id' => $orderId,
                    'va' => $response['va_numbers'][0]['va_number'],
                ],
            ]);
        } catch (\Exception $e) {
            DB::rollBack();
            return response()->json(['message' => 'invalid', 'data' => $e->getMessage()], 400);
        }
    }
    private function createTransaction($orderId, $name, $email, $totalAmount, $product, $quantity)
    {
        Transaction::create([
            'id' => $orderId,
            'name' => $name,
            'email' => $email,
            'total_amount' => $totalAmount,
            'status' => 'BELUM DIBAYAR',
        ]);

        TransactionDetail::create([
            'transaction_id' => $orderId,
            'product_id' => $product->id,
            'quantity' => $quantity,
            'price' => $product->price,
            'subtotal' => $totalAmount,
        ]);

        Product::where('id', $product->id)
            ->decrement('stock', $quantity);
    }
}
