Return-Path: <jthumshirn@suse.de>
Date: Wed, 5 Apr 2017 16:42:41 +0200
From: Johannes Thumshirn <jthumshirn@suse.de>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Keith Busch <keith.busch@intel.com>,
	Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: [PATCH 2/5] nvme: cleanup nvme_req_needs_retry
Message-ID: <20170405144241.GN3941@linux-x5ow.site>
References: <20170405141856.1862-1-hch@lst.de>
 <20170405141856.1862-3-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <20170405141856.1862-3-hch@lst.de>
List-ID: <linux-block@vger.kernel.org>

On Wed, Apr 05, 2017 at 04:18:53PM +0200, Christoph Hellwig wrote:
> Don't pass the status explicitly but derive it from the requeust,
> and unwind the complex condition to be more readable.
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
