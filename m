Return-Path: <hch@lst.de>
Date: Mon, 2 Oct 2017 15:42:44 +0200
From: Christoph Hellwig <hch@lst.de>
To: Bart Van Assche <bart.vanassche@wdc.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	=Oleksandr Natalenko <oleksandr@natalenko.name>,
	Ming Lei <ming.lei@redhat.com>, Hannes Reinecke <hare@suse.com>,
	Johannes Thumshirn <jthumshirn@suse.de>
Subject: Re: [PATCH v4 3/7] block: Convert RQF_PREEMPT into REQ_PREEMPT
Message-ID: <20171002134244.GC7129@lst.de>
References: <20170925202924.16603-1-bart.vanassche@wdc.com> <20170925202924.16603-4-bart.vanassche@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170925202924.16603-4-bart.vanassche@wdc.com>
List-ID: <linux-block@vger.kernel.org>

This looks ok to me, or at least better than the version from Ming to
archive the same.  I kinda hate to add more REQ_* flags than
really nessecary though.  Maybe instead of the mapping to REQ_* as
suggested to ming blk_queue_enter should instead take the BLK_MQ_REQ_*
flags and we'll add BLK_MQ_REQ_PREEMPT, and pass those to
blk_get_request.  If it wasn't for Linus beeing angry due to block
churn I'd be very tempted to suggest that.
