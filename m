Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH] block: Fix __bio_integrity_endio() documentation
To: Bart Van Assche <bart.vanassche@wdc.com>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>
References: <20180116183139.29777-1-bart.vanassche@wdc.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <ffb9de06-9d24-888f-7698-7b3307d16079@kernel.dk>
Date: Wed, 17 Jan 2018 09:59:47 -0700
MIME-Version: 1.0
In-Reply-To: <20180116183139.29777-1-bart.vanassche@wdc.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 1/16/18 11:31 AM, Bart Van Assche wrote:
> Fixes: 4246a0b63bd8 ("block: add a bi_error field to struct bio")
> Signed-off-by: Bart Van Assche <bart.vanassche@wdc.com>

Applied, thanks.

-- 
Jens Axboe
