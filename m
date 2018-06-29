Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH] drbd: Fix drbd_request_prepare() discard handling
To: Bart Van Assche <bart.vanassche@wdc.com>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
 Philipp Reisner <philipp.reisner@linbit.com>,
 Lars Ellenberg <lars.ellenberg@linbit.com>
References: <20180625225130.4447-1-bart.vanassche@wdc.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <b40eb75b-8035-341d-d14b-ac2ad073e8f1@kernel.dk>
Date: Fri, 29 Jun 2018 07:53:32 -0600
MIME-Version: 1.0
In-Reply-To: <20180625225130.4447-1-bart.vanassche@wdc.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 6/25/18 4:51 PM, Bart Van Assche wrote:
> Fix the test that verifies whether bio_op(bio) represents a discard
> or write zeroes operation. Compile-tested only.

Applied, thanks Bart.

-- 
Jens Axboe
