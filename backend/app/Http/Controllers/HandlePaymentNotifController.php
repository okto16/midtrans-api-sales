<?php

namespace App\Http\Controllers;

use App\Models\transaction;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Log;

class HandlePaymentNotifController extends Controller
{
    public function __invoke(Request $request)
    {
        $payload = $request->all();

        Log::info('Incoming-Midtrans', [
            'payload' => $payload,
        ]);

        $orderId = $payload['order_id'];
        $statusCode = $payload['status_code'];
        $grossAmount = $payload['gross_amount'];

        $reqSignature = $payload['signature_key'];

        $signature = hash('sha512', $orderId . $statusCode . $grossAmount . config('midtrans.server_key'));

        if ($signature != $reqSignature) {
            return response()->json([
                'message' => 'Invalid signature',
            ], 401);
        }

        $transactionStatus = $payload['transaction_status'];

        $order = transaction::find($orderId);
        if (!$order) {
            return response()->json([
                'message' => 'Transaction not found',
            ], 400);
        }

        if ($transactionStatus == 'settlement') {
            $order->status = 'PAID';
            $order->save();
        } else if ($transactionStatus == 'expire') {
            $order->status = 'EXPIRED';
            $order->save();
        }

        return response()->json(['message' => 'success'], 200);
    }
}
