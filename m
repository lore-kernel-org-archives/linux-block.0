Return-Path: <jthumshirn@suse.de>
Date: Thu, 13 Apr 2017 10:22:25 +0200
From: Johannes Thumshirn <jthumshirn@suse.de>
To: Christoph Hellwig <hch@lst.de>
Cc: axboe@kernel.dk, linux-block@vger.kernel.org
Subject: Re: [PATCH 2/3] block: remove blk_end_request_cur
Message-ID: <20170413082224.GB6734@linux-x5ow.site>
References: <20170412101359.7633-1-hch@lst.de>
 <20170412101359.7633-3-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <20170412101359.7633-3-hch@lst.de>
List-ID: <linux-block@vger.kernel.org>

On Wed, Apr 12, 2017 at 12:13:58PM +0200, Christoph Hellwig wrote:
> This function is not used anywhere in the kernel.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
Looks good, though one could argue it can be merged into the last patch.
Reviewed-by: Johannes Thumshirn <jthumshirn@suse.de>

-- 
Johannes Thumshirn                                          Storage
jthumshirn@suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N�rnberg
GF: Felix Imend�rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N�rnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
