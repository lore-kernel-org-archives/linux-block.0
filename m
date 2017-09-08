Return-Path: <jthumshirn@suse.de>
Date: Fri, 8 Sep 2017 10:05:03 +0200
From: Johannes Thumshirn <jthumshirn@suse.de>
To: Damien Le Moal <damien.lemoal@wdc.com>
Cc: linux-scsi@vger.kernel.org,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Bart Van Assche <Bart.VanAssche@wdc.com>
Subject: Re: [PATCH V2 01/12] block: Fix declaration of blk-mq debugfs
 functions
Message-ID: <20170908080503.caywdsvmpxsvmhwa@linux-x5ow.site>
References: <20170907161640.30465-1-damien.lemoal@wdc.com>
 <20170907161640.30465-2-damien.lemoal@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <20170907161640.30465-2-damien.lemoal@wdc.com>
List-ID: <linux-block@vger.kernel.org>

On Fri, Sep 08, 2017 at 01:16:29AM +0900, Damien Le Moal wrote:
> __blk_mq_debugfs_rq_show() and blk_mq_debugfs_rq_show() are exported
> symbols but ar eonly declared in the block internal file
             are only

Otherwise this looks good to me,
Reviewed-by: Johannes Thumshirn <jthumshirn@suse.de>

-- 
Johannes Thumshirn                                          Storage
jthumshirn@suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N�rnberg
GF: Felix Imend�rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N�rnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
