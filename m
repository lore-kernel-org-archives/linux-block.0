Return-Path: <jthumshirn@suse.de>
Date: Fri, 20 Jul 2018 08:52:58 +0200
From: Johannes Thumshirn <jthumshirn@suse.de>
To: Keith Busch <keith.busch@intel.com>
Cc: linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
	linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
	Jens Axboe <axboe@kernel.dk>,
	Jianchao Wang <jianchao.w.wang@oracle.com>,
	Bart Van Assche <bart.vanassche@wdc.com>
Subject: Re: [PATCH 2/2] scsi: set timed out out mq requests to complete
Message-ID: <20180720065258.cucvur7n5tugl75u@linux-x5ow.site>
References: <20180719212618.2406-1-keith.busch@intel.com>
 <20180719212618.2406-2-keith.busch@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <20180719212618.2406-2-keith.busch@intel.com>
List-ID: <linux-block@vger.kernel.org>

On Thu, Jul 19, 2018 at 03:26:18PM -0600, Keith Busch wrote:
> The scsi block layer requires requests claimed be the error handling be
> completed by the error handler. A previous commit allowed completions
> to proceed for blk-mq, breaking that assumption.

Ahm the first sentence is a bit hard to parse, sorry.
Did you mean something like:

"The scsi block later requires requests claimed by the error handling
to be completed by the error handler"?

-- 
Johannes Thumshirn                                          Storage
jthumshirn@suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N�rnberg
GF: Felix Imend�rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N�rnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
