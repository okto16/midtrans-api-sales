<?php

namespace Database\Factories;

use Illuminate\Database\Eloquent\Factories\Factory;

/**
 * @extends \Illuminate\Database\Eloquent\Factories\Factory<\App\Models\Product>
 */
class ProductFactory extends Factory
{
    /**
     * Define the model's default state.
     *
     * @return array<string, mixed>
     */
    public function definition(): array
    {
        return [
            'product_name' => fake()->sentence(),
            'image' => fake()->imageUrl(300, 300),
            'price' => fake()->numberBetween(1000, 10000),
            'stock' => fake()->numberBetween(1, 100),
        ];
    }
}
