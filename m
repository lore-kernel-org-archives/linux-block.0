Return-Path: <linux-scsi-owner@vger.kernel.org>
Date: Tue, 27 Sep 2016 09:52:13 +0200
From: Johannes Thumshirn <jthumshirn@suse.de>
To: Hannes Reinecke <hare@suse.de>
Cc: Bart Van Assche <bart.vanassche@sandisk.com>,
        Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>,
        James Bottomley <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Doug Ledford <dledford@redhat.com>,
        Keith Busch <keith.busch@intel.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH 4/9] block: Move blk_freeze_queue() and
 blk_unfreeze_queue() code
Message-ID: <20160927075213.rkpulkbrbndm2wwr@linux-x5ow.site>
References: <7948dbb8-6333-dc62-2673-4da35b4dfdbc@sandisk.com>
 <f990694e-76ea-f6b1-10a4-c23b9a738b39@sandisk.com>
 <ffad7b3c-e7f5-56d7-0a75-574e65ac5b31@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <ffad7b3c-e7f5-56d7-0a75-574e65ac5b31@suse.de>
Sender: linux-scsi-owner@vger.kernel.org
List-ID: <linux-block@vger.kernel.org>

On Tue, Sep 27, 2016 at 08:26:19AM +0200, Hannes Reinecke wrote:
> On 09/26/2016 08:27 PM, Bart Van Assche wrote:
> > Move the blk_freeze_queue() and blk_unfreeze_queue() implementations
> > from block/blk-mq.c to block/blk-core.c. Drop "_mq" from the name of
> > the functions that have been moved.
> > 
> > Signed-off-by: Bart Van Assche <bart.vanassche@sandisk.com>
> > ---
> >  block/blk-core.c | 45 +++++++++++++++++++++++++++++++++++++++++++++
> >  block/blk-mq.c   | 41 +++--------------------------------------
> >  block/blk.h      |  3 +++
> >  3 files changed, 51 insertions(+), 38 deletions(-)
> > 
> > diff --git a/block/blk-core.c b/block/blk-core.c
> > index b75d688..8cc8006 100644
> > --- a/block/blk-core.c
> > +++ b/block/blk-core.c
> > @@ -682,6 +682,51 @@ static void blk_queue_usage_counter_release(struct percpu_ref *ref)
> >  	wake_up_all(&q->mq_freeze_wq);
> >  }
> >  
> > +void blk_freeze_queue_start(struct request_queue *q)
> > +{
> > +	int freeze_depth;
> > +
> > +	freeze_depth = atomic_inc_return(&q->mq_freeze_depth);
> > +	if (freeze_depth == 1) {
> > +		percpu_ref_kill(&q->q_usage_counter);
> > +		blk_mq_run_hw_queues(q, false);
> > +	}
> > +}
> > +
> As you dropped the 'mq_' prefix, maybe you should rename the counter to
> 'freeze_depth', to?

See PATCH 6/9

-- 
Johannes Thumshirn                                          Storage
jthumshirn@suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N�rnberg
GF: Felix Imend�rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N�rnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
