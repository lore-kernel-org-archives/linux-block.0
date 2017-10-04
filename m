Return-Path: <hch@lst.de>
Date: Wed, 4 Oct 2017 09:04:44 +0200
From: Christoph Hellwig <hch@lst.de>
To: Bart Van Assche <bart.vanassche@wdc.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	=Oleksandr Natalenko <oleksandr@natalenko.name>,
	"Luis R . Rodriguez" <mcgrof@kernel.org>,
	Ming Lei <ming.lei@redhat.com>, Hannes Reinecke <hare@suse.com>,
	Johannes Thumshirn <jthumshirn@suse.de>
Subject: Re: [PATCH v5 6/8] scsi: Reduce suspend latency
Message-ID: <20171004070444.GD20879@lst.de>
References: <20171002225218.18548-1-bart.vanassche@wdc.com> <20171002225218.18548-7-bart.vanassche@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20171002225218.18548-7-bart.vanassche@wdc.com>
List-ID: <linux-block@vger.kernel.org>

> +	/*
> +	 * Do not attempt to freeze the queue of an already quiesced device
> +	 * because that could result in a deadlock.
> +	 */
> +	freeze = sdev->sdev_state == SDEV_RUNNING;
> +	if (freeze)
> +		blk_mq_freeze_queue(q);
>  	err = scsi_device_set_state(sdev, SDEV_QUIESCE);

I don't really like this magic with a freeze inside the lock
and the magic dependency on the previous.  But I can't really come up
with a better idea either.
