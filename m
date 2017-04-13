Return-Path: <jthumshirn@suse.de>
Date: Thu, 13 Apr 2017 10:20:51 +0200
From: Johannes Thumshirn <jthumshirn@suse.de>
To: Christoph Hellwig <hch@lst.de>
Cc: axboe@kernel.dk, linux-block@vger.kernel.org
Subject: Re: [PATCH 1/3] block: remove blk_end_request_err and
 __blk_end_request_err
Message-ID: <20170413082051.GA6734@linux-x5ow.site>
References: <20170412101359.7633-1-hch@lst.de>
 <20170412101359.7633-2-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <20170412101359.7633-2-hch@lst.de>
List-ID: <linux-block@vger.kernel.org>

On Wed, Apr 12, 2017 at 12:13:57PM +0200, Christoph Hellwig wrote:
> Both functions are entirely unused.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---

Looks good,
Reviewed-by: Johannes Thumshirn <jthumshirn@suse.de>

-- 
Johannes Thumshirn                                          Storage
jthumshirn@suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N�rnberg
GF: Felix Imend�rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N�rnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
