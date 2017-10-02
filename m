Return-Path: <hch@lst.de>
Date: Mon, 2 Oct 2017 15:53:09 +0200
From: Christoph Hellwig <hch@lst.de>
To: Bart Van Assche <bart.vanassche@wdc.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	=Oleksandr Natalenko <oleksandr@natalenko.name>,
	Ming Lei <ming.lei@redhat.com>, Hannes Reinecke <hare@suse.com>,
	Johannes Thumshirn <jthumshirn@suse.de>
Subject: Re: [PATCH v4 6/7] scsi: Set QUEUE_FLAG_PREEMPT_ONLY while quiesced
Message-ID: <20171002135309.GB7571@lst.de>
References: <20170925202924.16603-1-bart.vanassche@wdc.com> <20170925202924.16603-7-bart.vanassche@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170925202924.16603-7-bart.vanassche@wdc.com>
List-ID: <linux-block@vger.kernel.org>

On Mon, Sep 25, 2017 at 01:29:23PM -0700, Bart Van Assche wrote:
> Make the quiesce state visible to the block layer for the next
> patch in this series.

This looks like the more correct version as everything is under
state_mutex.

Except for the fact that I'd like to get rid of the blk_set_preempt_only
helper this looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
