<?php

namespace App\Services;

use Illuminate\Support\Facades\Http;

class MidtransService
{
    protected $serverKey;

    public function __construct()
    {
        $this->serverKey = config('midtrans.server_key');
    }

    public function createCharge($orderId, $grossAmount, $bank, $email, $name)
    {
        $expiry = [
            'start_time' => now()->format('Y-m-d H:i:s T'),
            'unit' => 'hours',
            'duration' => 24,
        ];

        $response = Http::withBasicAuth($this->serverKey, '')
            ->post('https://api.sandbox.midtrans.com/v2/charge', [
                'payment_type' => 'bank_transfer',
                'transaction_details' => [
                    'order_id' => $orderId,
                    'gross_amount' => $grossAmount,
                ],
                'bank_transfer' => [
                    'bank' => $bank,
                ],
                'customer_details' => [
                    'email' => $email,
                    'first_name' => $name,
                ],
                'expiry' => $expiry,
            ]);

        if ($response->failed()) {
            throw new \Exception('Failed Charge');
        }

        return $response->json();
    }
}
