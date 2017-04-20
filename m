Return-Path: <jthumshirn@suse.de>
Date: Thu, 20 Apr 2017 10:31:20 +0200
From: Johannes Thumshirn <jthumshirn@suse.de>
To: Bart Van Assche <bart.vanassche@sandisk.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Matias =?iso-8859-1?Q?Bj=F8rling?= <m@bjorling.me>
Subject: Re: [PATCH v2 4/5] block: Inline blk_rq_set_prio()
Message-ID: <20170420083120.GZ6217@linux-x5ow.site>
References: <20170419210128.28374-1-bart.vanassche@sandisk.com>
 <20170419210128.28374-5-bart.vanassche@sandisk.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <20170419210128.28374-5-bart.vanassche@sandisk.com>
List-ID: <linux-block@vger.kernel.org>

On Wed, Apr 19, 2017 at 02:01:27PM -0700, Bart Van Assche wrote:
> Since only a single caller remains, inline blk_rq_set_prio(). Initialize
> req->ioprio even if no I/O priority has been set in the bio nor in the
> I/O context.
> 
> Signed-off-by: Bart Van Assche <bart.vanassche@sandisk.com>
> Reviewed-by: Adam Manzanares <adam.manzanares@wdc.com>
> Tested-by: Adam Manzanares <adam.manzanares@wdc.com>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Cc: Matias Bj�rling <m@bjorling.me>
> ---

Reviewed-by: Johannes Thumshirn <jthumshirn@suse.de>
-- 
Johannes Thumshirn                                          Storage
jthumshirn@suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N�rnberg
GF: Felix Imend�rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N�rnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
