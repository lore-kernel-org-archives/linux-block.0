Return-Path: <linux-scsi-owner@vger.kernel.org>
Date: Fri, 1 Sep 2017 10:16:34 +0200
From: Johannes Thumshirn <jthumshirn@suse.de>
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@fb.com>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>,
        Bart Van Assche <bart.vanassche@sandisk.com>,
        linux-scsi@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>,
        Oleksandr Natalenko <oleksandr@natalenko.name>
Subject: Re: [PATCH 4/9] blk-mq: only run hw queues for blk-mq
Message-ID: <20170901081634.gliggrnp3wlrysrv@linux-x5ow.site>
References: <20170831172728.15817-1-ming.lei@redhat.com>
 <20170831172728.15817-5-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <20170831172728.15817-5-ming.lei@redhat.com>
Sender: linux-scsi-owner@vger.kernel.org
List-ID: <linux-block@vger.kernel.org>

Hi Ming,

On Fri, Sep 01, 2017 at 01:27:23AM +0800, Ming Lei wrote:
> -		blk_mq_run_hw_queues(q, false);
> +		if (q->mq_ops)
> +			blk_mq_run_hw_queues(q, false);

What speaks against putting the if (q->mq_ops) directly into
blk_mq_run_hw_queues() so we can't accidently call it from the sq path?

Just an idea, no hard preferences here.

Byte,
	Johannes

-- 
Johannes Thumshirn                                          Storage
jthumshirn@suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N�rnberg
GF: Felix Imend�rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N�rnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
