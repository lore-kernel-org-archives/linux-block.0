Return-Path: <jthumshirn@suse.de>
Date: Wed, 23 May 2018 14:42:42 +0200
From: Johannes Thumshirn <jthumshirn@suse.de>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Keith Busch <keith.busch@intel.com>,
	Bart Van Assche <bart.vanassche@wdc.com>,
	Ming Lei <ming.lei@redhat.com>, Josef Bacik <josef@toxicpanda.com>,
	Tejun Heo <tj@kernel.org>, Lee Duncan <lduncan@suse.com>,
	Chris Leech <cleech@redhat.com>,
	Rafael David Tinoco <rafael.tinoco@canonical.com>,
	linux-block@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: [PATCH 03/14] nvme: return BLK_EH_DONE from ->timeout
Message-ID: <20180523124242.ony4pgfrdlplcxhl@linux-x5ow.site>
References: <20180523121941.8632-1-hch@lst.de>
 <20180523121941.8632-4-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <20180523121941.8632-4-hch@lst.de>
List-ID: <linux-block@vger.kernel.org>

Looks good,
Reviewed-by: Johannes Thumshirn <jthumshirn@suse.de>
-- 
Johannes Thumshirn                                          Storage
jthumshirn@suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N�rnberg
GF: Felix Imend�rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N�rnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
