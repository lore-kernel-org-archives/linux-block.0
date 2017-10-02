Return-Path: <hch@lst.de>
Date: Mon, 2 Oct 2017 15:43:53 +0200
From: Christoph Hellwig <hch@lst.de>
To: Bart Van Assche <bart.vanassche@wdc.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	=Oleksandr Natalenko <oleksandr@natalenko.name>,
	Ming Lei <ming.lei@redhat.com>, Hannes Reinecke <hare@suse.com>,
	Johannes Thumshirn <jthumshirn@suse.de>
Subject: Re: [PATCH v4 3/7] block: Convert RQF_PREEMPT into REQ_PREEMPT
Message-ID: <20171002134353.GA7493@lst.de>
References: <20170925202924.16603-1-bart.vanassche@wdc.com> <20170925202924.16603-4-bart.vanassche@wdc.com> <20171002134244.GC7129@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20171002134244.GC7129@lst.de>
List-ID: <linux-block@vger.kernel.org>

On Mon, Oct 02, 2017 at 03:42:44PM +0200, Christoph Hellwig wrote:
> This looks ok to me, or at least better than the version from Ming to
> archive the same.  I kinda hate to add more REQ_* flags than
> really nessecary though.  Maybe instead of the mapping to REQ_* as
> suggested to ming blk_queue_enter should instead take the BLK_MQ_REQ_*
> flags and we'll add BLK_MQ_REQ_PREEMPT, and pass those to
> blk_get_request.  If it wasn't for Linus beeing angry due to block
> churn I'd be very tempted to suggest that.

Actually, based on the next patch in the series from Ming we could
add a blk_get_request_flags() or similar that takes the BLK_MQ_REQ_*
flags, which would be my preferred method.
