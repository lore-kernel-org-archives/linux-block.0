Return-Path: <ming.lei@redhat.com>
Date: Sat, 23 Jun 2018 07:36:33 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Ming Lei <tom.leiming@gmail.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block <linux-block@vger.kernel.org>,
	Andrew Jones <drjones@redhat.com>,
	Linux SCSI List <linux-scsi@vger.kernel.org>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH V2] blk-mq: avoid to synchronize rcu inside
 blk_cleanup_queue()
Message-ID: <20180622233632.GF2949@ming.t460p>
References: <20180622221219.6469-1-ming.lei@redhat.com>
 <b407dd42-363c-0006-0f1e-507f2d887b51@kernel.dk>
 <CACVXFVNNpB19hT_i2hmxvGSRhO+eEYN456sc-F+4Cg4YrT=xGg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CACVXFVNNpB19hT_i2hmxvGSRhO+eEYN456sc-F+4Cg4YrT=xGg@mail.gmail.com>
List-ID: <linux-block@vger.kernel.org>

On Sat, Jun 23, 2018 at 07:07:18AM +0800, Ming Lei wrote:
> On Sat, Jun 23, 2018 at 6:19 AM, Jens Axboe <axboe@kernel.dk> wrote:
> > On 6/22/18 4:12 PM, Ming Lei wrote:
> >> SCSI probing may synchronously create and destroy a lot of request_queues
> >> for non-existent devices. Any synchronize_rcu() in queue creation or
> >> destroy path may introduce long latency during booting, see detailed
> >> description in comment of blk_register_queue().
> >>
> >> This patch removes two synchronize_rcu() inside blk_cleanup_queue()
> >> for this case:
> >>
> >> 1) commit c2856ae2f315d75(blk-mq: quiesce queue before freeing queue)
> >> need synchronize_rcu() for implementing blk_mq_quiesce_queue(), but
> >> when queue isn't initialized, it isn't necessary to do that since
> >> only pass-through requests are involved, no original issue in
> >> scsi_execute() at all.
> >>
> >> 2) when only one request queue is attached to tags, no necessary to
> >> call synchronize_rcu() too.
> >>
> >> Without this patch, it may take more 20+ seconds for virtio-scsi to
> >> complete disk probe. With this patch, the time becomes less than 100ms.
> >>
> >> Reported-by: Andrew Jones <drjones@redhat.com>
> >> Cc: Andrew Jones <drjones@redhat.com>
> >> Cc: linux-scsi@vger.kernel.org
> >> Cc: "Martin K. Petersen" <martin.petersen@oracle.com>
> >> Cc: Christoph Hellwig <hch@lst.de>
> >> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> >> ---
> >>  block/blk-core.c | 8 ++++++--
> >>  block/blk-mq.c   | 5 ++++-
> >>  2 files changed, 10 insertions(+), 3 deletions(-)
> >>
> >> diff --git a/block/blk-core.c b/block/blk-core.c
> >> index cf0ee764b908..f0129e20b773 100644
> >> --- a/block/blk-core.c
> >> +++ b/block/blk-core.c
> >> @@ -766,9 +766,13 @@ void blk_cleanup_queue(struct request_queue *q)
> >>        * make sure all in-progress dispatch are completed because
> >>        * blk_freeze_queue() can only complete all requests, and
> >>        * dispatch may still be in-progress since we dispatch requests
> >> -      * from more than one contexts
> >> +      * from more than one contexts.
> >> +      *
> >> +      * No need to quiesce queue if it isn't initialized yet since
> >> +      * blk_freeze_queue() should be enough for cases of passthrough
> >> +      * request.
> >>        */
> >> -     if (q->mq_ops)
> >> +     if (q->mq_ops && blk_queue_init_done(q))
> >>               blk_mq_quiesce_queue(q);
> >>
> >>       /* for synchronous bio-based driver finish in-flight integrity i/o */
> >> diff --git a/block/blk-mq.c b/block/blk-mq.c
> >> index 70c65bb6c013..8a6771ac0adb 100644
> >> --- a/block/blk-mq.c
> >> +++ b/block/blk-mq.c
> >> @@ -2351,6 +2351,7 @@ static void blk_mq_update_tag_set_depth(struct blk_mq_tag_set *set,
> >>  static void blk_mq_del_queue_tag_set(struct request_queue *q)
> >>  {
> >>       struct blk_mq_tag_set *set = q->tag_set;
> >> +     bool shared;
> >>
> >>       mutex_lock(&set->tag_list_lock);
> >>       list_del_rcu(&q->tag_set_list);
> >> @@ -2360,8 +2361,10 @@ static void blk_mq_del_queue_tag_set(struct request_queue *q)
> >>               /* update existing queue */
> >>               blk_mq_update_tag_set_depth(set, false);
> >>       }
> >> +     shared = set->flags & BLK_MQ_F_TAG_SHARED;
> >>       mutex_unlock(&set->tag_list_lock);
> >> -     synchronize_rcu();
> >> +     if (shared)
> >> +             synchronize_rcu();
> >
> > Shouldn't this be set if it _was_ shared as well, not just if it's
> > still shared?
> 
> Yes, it need to be done for _was_ shared. But for the usual single lun case,
> the shared can be set for all the following probe suppose lun 0 is the real one,
> then this simple trick can't work any more.
> 
> Looks blk_queue_init_done() still need to be check here.

Thinking of this issue further, the only reason of synchronizing rcu
in blk_mq_del_queue_tag_set() is because blk_mq_sched_restart() needs
that.

Given we have fixed enough IO hang issues wrt. tag allocation, looks
it is time to remove it now as done in 358a3a6bccb74da9d63a. Otherwise,
not see an easy way to fix the slow probe issue.

Thanks,
Ming
