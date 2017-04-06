Return-Path: <jthumshirn@suse.de>
Date: Thu, 6 Apr 2017 10:55:16 +0200
From: Johannes Thumshirn <jthumshirn@suse.de>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Keith Busch <keith.busch@intel.com>,
	Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: [PATCH 1/5] nvme: move ->retries setup to nvme_setup_cmd
Message-ID: <20170406085513.GC3768@linux-x5ow.site>
References: <20170405171812.19911-1-hch@lst.de>
 <20170405171812.19911-2-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <20170405171812.19911-2-hch@lst.de>
List-ID: <linux-block@vger.kernel.org>

On Wed, Apr 05, 2017 at 07:18:08PM +0200, Christoph Hellwig wrote:
> ->retries is counting the number of times a command is resubmitted, and
> be cleared on the first time we see the command.  We currently don't do
> that for non-PCIe command, which is easily fixed by moving the setup
> to common code.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---

Thanks a lot.

Reviewed-by: Johannes Thumshirn <jthumshirn@suse.de>

-- 
Johannes Thumshirn                                          Storage
jthumshirn@suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N�rnberg
GF: Felix Imend�rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N�rnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
