Return-Path: <hch@lst.de>
Date: Wed, 4 Oct 2017 09:06:00 +0200
From: Christoph Hellwig <hch@lst.de>
To: Bart Van Assche <bart.vanassche@wdc.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	=Oleksandr Natalenko <oleksandr@natalenko.name>,
	"Luis R . Rodriguez" <mcgrof@kernel.org>,
	Ming Lei <ming.lei@redhat.com>, Hannes Reinecke <hare@suse.com>,
	Johannes Thumshirn <jthumshirn@suse.de>
Subject: Re: [PATCH v5 7/8] scsi: Set QUEUE_FLAG_PREEMPT_ONLY while quiesced
Message-ID: <20171004070600.GE20879@lst.de>
References: <20171002225218.18548-1-bart.vanassche@wdc.com> <20171002225218.18548-8-bart.vanassche@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20171002225218.18548-8-bart.vanassche@wdc.com>
List-ID: <linux-block@vger.kernel.org>

> +	/*
> +	 * Ensure that the effect of blk_set_preempt_only() is globally
> +	 * visible before unfreezing the queue.
> +	 */
> +	if (err == 0)
> +		synchronize_rcu();

I don't understand why we'd need this.  The flag is set both under
a spinlock and a mutex that are unlocked right after.  That should
gurantee all the visibility we'll need.
