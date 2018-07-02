Return-Path: <loberman@redhat.com>
Return-Path: <loberman@redhat.com>
Message-ID: <1530531681.8954.1.camel@redhat.com>
Subject: Re: [PATCH V3 0/3] blk-mq: improve IO perf in case of none io sched
From: Laurence Oberman <loberman@redhat.com>
To: Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Kashyap Desai <kashyap.desai@broadcom.com>,
  Omar Sandoval <osandov@fb.com>, Christoph Hellwig <hch@lst.de>, Bart Van
 Assche <bart.vanassche@wdc.com>, Hannes Reinecke <hare@suse.de>
Date: Mon, 02 Jul 2018 07:41:21 -0400
In-Reply-To: <20180702093600.10315-1-ming.lei@redhat.com>
References: <20180702093600.10315-1-ming.lei@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

On Mon, 2018-07-02 at 17:35 +0800, Ming Lei wrote:
> Hi,
> 
> The 1st 2 patch improves ctx->lock uses, and it is observed that IOPS
> may be improved by ~5% in rand IO test on MegaRaid SAS run by
> Kashyap.
> 
> The 3rd patch fixes rand IO performance regression on MegaRaid SAS
> test, still reported by Kashyap.
> 
> V3:
> 	- export dispatch busy from debugfs as suggested by Jens
> 	- add comment on blk_mq_update_hctx_busy() as suggested by
> Christoph
> 
> V2:
> 	- fix list corruption in patch 1/3
> 
> 
> Ming Lei (3):
>   blk-mq: use list_splice_tail_init() to insert requests
>   blk-mq: only attempt to merge bio if there is rq in sw queue
>   blk-mq: dequeue request one by one from sw queue iff hctx is busy


> 
>  block/blk-mq-debugfs.c |  9 +++++++++
>  block/blk-mq-sched.c   | 14 ++++----------
>  block/blk-mq.c         | 44 ++++++++++++++++++++++++++++++++++++--
> ------
>  include/linux/blk-mq.h |  3 ++-
>  4 files changed, 51 insertions(+), 19 deletions(-)
> 
> Cc: Kashyap Desai <kashyap.desai@broadcom.com>
> Cc: Laurence Oberman <loberman@redhat.com>
> Cc: Omar Sandoval <osandov@fb.com>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Bart Van Assche <bart.vanassche@wdc.com>
> Cc: Hannes Reinecke <hare@suse.de>
> 

Thanks Ming, I repaired my MSA50 shelf so will functional test.
I have 6 SSD drives working in there now. 
I know its already been tested by Kashyap.

Regards
Laurence
