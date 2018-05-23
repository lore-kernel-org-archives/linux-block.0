Return-Path: <ming.lei@redhat.com>
Date: Wed, 23 May 2018 10:35:05 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: Bart Van Assche <Bart.VanAssche@wdc.com>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"israelr@mellanox.com" <israelr@mellanox.com>,
	"sagi@grimberg.me" <sagi@grimberg.me>, "hch@lst.de" <hch@lst.de>,
	"sebott@linux.ibm.com" <sebott@linux.ibm.com>,
	"jianchao.w.wang@oracle.com" <jianchao.w.wang@oracle.com>,
	"maxg@mellanox.com" <maxg@mellanox.com>,
	"tj@kernel.org" <tj@kernel.org>,
	"keith.busch@intel.com" <keith.busch@intel.com>
Subject: Re: [PATCH v13] blk-mq: Rework blk-mq timeout handling again
Message-ID: <20180523023503.GE31196@ming.t460p>
References: <20180522162515.20650-1-bart.vanassche@wdc.com>
 <bc1946d4-7627-3885-68c9-5db6c13b585c@kernel.dk>
 <fee466b8-8e39-adc6-efa4-e50ffa60a663@kernel.dk>
 <448d63e9-cfcd-0bc8-abf3-30296590f1d6@kernel.dk>
 <cd0693cc-a56d-665c-bc14-7e2653b91cb0@kernel.dk>
 <e414a6f8-79a9-0faa-e186-beb3b528acd5@kernel.dk>
 <256db3889953289d75b989dd589802ce8a756553.camel@wdc.com>
 <460909df-cff0-f56b-882e-eb1a96f7510a@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <460909df-cff0-f56b-882e-eb1a96f7510a@kernel.dk>
List-ID: <linux-block@vger.kernel.org>

On Tue, May 22, 2018 at 02:38:37PM -0600, Jens Axboe wrote:
> On 5/22/18 2:33 PM, Bart Van Assche wrote:
> > On Tue, 2018-05-22 at 13:38 -0600, Jens Axboe wrote:
> >> On 5/22/18 1:03 PM, Jens Axboe wrote:
> >>> On 5/22/18 12:47 PM, Jens Axboe wrote:
> >>>> Ran into this, running block/014 from blktests:
> >>>>
> >>>> [ 5744.949839] run blktests block/014 at 2018-05-22 12:41:25
> >>>> [ 5750.723000] null: rq 00000000ff68f103 timed out
> >>>> [ 5750.728181] WARNING: CPU: 45 PID: 2480 at block/blk-mq.c:585 __blk_mq_complete_request+0xa6/0x0
> >>>> [ 5750.738187] Modules linked in: null_blk(+) configfs nvme nvme_core sb_edac x86_pkg_temp_therma]
> >>>> [ 5750.765509] CPU: 45 PID: 2480 Comm: kworker/45:1H Not tainted 4.17.0-rc6+ #712
> >>>> [ 5750.774087] Hardware name: Dell Inc. PowerEdge T630/0NT78X, BIOS 2.3.4 11/09/2016
> >>>> [ 5750.783369] Workqueue: kblockd blk_mq_timeout_work
> >>>> [ 5750.789223] RIP: 0010:__blk_mq_complete_request+0xa6/0x110
> >>>> [ 5750.795850] RSP: 0018:ffff883ffb417d68 EFLAGS: 00010202
> >>>> [ 5750.802187] RAX: 0000000000000003 RBX: ffff881ff100d800 RCX: 0000000000000000
> >>>> [ 5750.810649] RDX: ffff88407fd9e040 RSI: ffff88407fd956b8 RDI: ffff881ff100d800
> >>>> [ 5750.819119] RBP: ffffe8ffffd91800 R08: 0000000000000000 R09: ffffffff82066eb8
> >>>> [ 5750.827588] R10: ffff883ffa386138 R11: ffff883ffa385900 R12: 0000000000000001
> >>>> [ 5750.836050] R13: ffff881fe7da6000 R14: 0000000000000020 R15: 0000000000000002
> >>>> [ 5750.844529] FS:  0000000000000000(0000) GS:ffff88407fd80000(0000) knlGS:0000000000000000
> >>>> [ 5750.854482] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> >>>> [ 5750.861397] CR2: 00007ffc92f97f68 CR3: 000000000201d005 CR4: 00000000003606e0
> >>>> [ 5750.869861] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> >>>> [ 5750.878333] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> >>>> [ 5750.886805] Call Trace:
> >>>> [ 5750.890033]  bt_iter+0x42/0x50
> >>>> [ 5750.894000]  blk_mq_queue_tag_busy_iter+0x12b/0x220
> >>>> [ 5750.899941]  ? blk_mq_tag_to_rq+0x20/0x20
> >>>> [ 5750.904913]  ? __rcu_read_unlock+0x50/0x50
> >>>> [ 5750.909978]  ? blk_mq_tag_to_rq+0x20/0x20
> >>>> [ 5750.914948]  blk_mq_timeout_work+0x14b/0x240
> >>>> [ 5750.920220]  process_one_work+0x21b/0x510
> >>>> [ 5750.925197]  worker_thread+0x3a/0x390
> >>>> [ 5750.929781]  ? process_one_work+0x510/0x510
> >>>> [ 5750.934944]  kthread+0x11c/0x140
> >>>> [ 5750.939028]  ? kthread_create_worker_on_cpu+0x50/0x50
> >>>> [ 5750.945169]  ret_from_fork+0x1f/0x30
> >>>> [ 5750.949656] Code: 48 02 00 00 80 e6 80 74 29 8b 95 80 00 00 00 44 39 e2 75 3b 48 89 df ff 90 2 
> >>>> [ 5750.972139] ---[ end trace 40065cb1764bf500 ]---
> >>>>
> >>>> which is this:
> >>>>
> >>>>         WARN_ON_ONCE(blk_mq_rq_state(rq) != MQ_RQ_COMPLETE);
> >>>
> >>> That check looks wrong, since TIMED_OUT -> COMPLETE is also a valid
> >>> state transition. So that check should be:
> >>>
> >>>         WARN_ON_ONCE(blk_mq_rq_state(rq) != MQ_RQ_COMPLETE &&
> >>>                      blk_mq_rq_state(rq) != MQ_RQ_TIMED_OUT);
> >>
> >> I guess it would be cleaner to actually do the transition, in
> >> blk_mq_rq_timed_out():
> >>
> >>         case BLK_EH_HANDLED:                                                    
> >>                 if (blk_mq_change_rq_state(req, MQ_RQ_TIMED_OUT,                
> >>                                                 MQ_RQ_COMPLETE))                
> >>                         __blk_mq_complete_request(req);                         
> >>                 break;        
> >>
> >> This works for me.
> > 
> > Hello Jens,
> > 
> > Thanks for having reported this. How about using the following change to suppress
> > that warning:
> > 
> > diff --git a/block/blk-mq.c b/block/blk-mq.c
> > index bb99c03e7a34..84e55ea55baf 100644
> > --- a/block/blk-mq.c
> > +++ b/block/blk-mq.c
> > @@ -844,6 +844,7 @@ static void blk_mq_rq_timed_out(struct request *req, bool reserved)
> >  
> >  	switch (ret) {
> >  	case BLK_EH_HANDLED:
> > +		blk_mq_change_rq_state(req, MQ_RQ_TIMED_OUT, MQ_RQ_COMPLETE);
> >  		__blk_mq_complete_request(req);
> >  		break;
> >  	case BLK_EH_RESET_TIMER:
> > 
> > I think this will work better than what was proposed in your last e-mail. I'm afraid
> > that with that change that a completion that occurs while the timeout handler is
> > running can be ignored.
> 
> What if that races with eg requeue? We get the completion from IRQ, decide we
> need to requeue/restart the request rather than complete it.

If drivers need to requeue this request, which should have been done
in its .complete.

But if the requeue is done via IRQ handler directly, that may be one
existed race between normal completion vs. timeout, and Bart's patch
doesn't change situation too.

thanks,
Ming
