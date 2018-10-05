Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH] blk-mq-debugfs: Also show requests that have not yet been
 started
To: Bart Van Assche <bvanassche@acm.org>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
 Ming Lei <ming.lei@redhat.com>, Hannes Reinecke <hare@suse.com>,
 Johannes Thumshirn <jthumshirn@suse.de>,
 "Martin K . Petersen" <martin.petersen@oracle.com>
References: <20181004173524.52712-1-bvanassche@acm.org>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <a3f6a55e-eaa5-6a65-8360-9d85c7566961@kernel.dk>
Date: Fri, 5 Oct 2018 08:18:00 -0600
MIME-Version: 1.0
In-Reply-To: <20181004173524.52712-1-bvanassche@acm.org>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 10/4/18 11:35 AM, Bart Van Assche wrote:
> When debugging e.g. the SCSI timeout handler it is important that
> requests that have not yet been started or that already have
> completed are also reported through debugfs.

Thanks, I like this better - applied. BTW, what's up with the
reverse ordering on this:

> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Ming Lei <ming.lei@redhat.com>
> Cc: Hannes Reinecke <hare@suse.com>
> Cc: Johannes Thumshirn <jthumshirn@suse.de>
> Cc: Martin K. Petersen <martin.petersen@oracle.com>

For some reason that really annoys me, and I see it in various
patches these days. IMHO the SOB should be last, with whatever
acks, reviews, CC, before that.

-- 
Jens Axboe
