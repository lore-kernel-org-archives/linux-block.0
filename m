Return-Path: <jthumshirn@suse.de>
Date: Thu, 20 Apr 2017 10:30:43 +0200
From: Johannes Thumshirn <jthumshirn@suse.de>
To: Bart Van Assche <bart.vanassche@sandisk.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Matias =?iso-8859-1?Q?Bj=F8rling?= <m@bjorling.me>,
	Adam Manzanares <adam.manzanares@wdc.com>
Subject: Re: [PATCH v2 3/5] lightnvm: Use blk_init_request_from_bio() instead
 of open-coding it
Message-ID: <20170420083043.GY6217@linux-x5ow.site>
References: <20170419210128.28374-1-bart.vanassche@sandisk.com>
 <20170419210128.28374-4-bart.vanassche@sandisk.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <20170419210128.28374-4-bart.vanassche@sandisk.com>
List-ID: <linux-block@vger.kernel.org>

On Wed, Apr 19, 2017 at 02:01:26PM -0700, Bart Van Assche wrote:
> This patch changes the behavior of the lightnvm driver as follows:
> * REQ_FAILFAST_MASK is set for read-ahead requests.
> * If no I/O priority has been set in the bio, the I/O priority is
>   copied from the I/O context.
> * The rq_disk member is initialized if bio->bi_bdev != NULL.
> * The bio sector offset is copied into req->__sector instead of
>   retaining the value -1 set by blk_mq_alloc_request().
> * req->errors is initialized to zero.
> 
> Signed-off-by: Bart Van Assche <bart.vanassche@sandisk.com>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Cc: Matias Bj�rling <m@bjorling.me>
> Cc: Adam Manzanares <adam.manzanares@wdc.com>
> ---

Reviewed-by: Johannes Thumshirn <jthumshirn@suse.de>
-- 
Johannes Thumshirn                                          Storage
jthumshirn@suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N�rnberg
GF: Felix Imend�rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N�rnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
