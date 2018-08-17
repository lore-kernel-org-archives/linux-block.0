Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH] block: remove duplicate initialization
To: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
 linux-block@vger.kernel.org
References: <20180816224529.3401-1-chaitanya.kulkarni@wdc.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <31baa80f-131e-537a-949a-94eabebc2655@kernel.dk>
Date: Fri, 17 Aug 2018 12:34:22 -0600
MIME-Version: 1.0
In-Reply-To: <20180816224529.3401-1-chaitanya.kulkarni@wdc.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 8/16/18 4:45 PM, Chaitanya Kulkarni wrote:
> This patch removes the duplicate initialization of q->queue_head
> in the blk_alloc_queue_node(). This removes the 2nd initialization
> so that we preserve the initialization order same as declaration
> present in struct request_queue.

Applied, thanks.

-- 
Jens Axboe
