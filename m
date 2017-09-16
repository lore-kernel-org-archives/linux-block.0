Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:56224 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751121AbdIPBz4 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 15 Sep 2017 21:55:56 -0400
Date: Sat, 16 Sep 2017 09:55:35 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Omar Sandoval <osandov@fb.com>
Subject: Re: [PATCH 0/6] blk-mq: don't allocate driver tag beforehand for
 flush rq
Message-ID: <20170916015534.GB25757@ming.t460p>
References: <20170914164213.17859-1-ming.lei@redhat.com>
 <77beace7-6243-dbda-0c8e-245fe1a9bed9@kernel.dk>
 <20170915022052.GC19340@ming.t460p>
 <f9e0c7d5-7b82-6b32-2a59-1064caa632b6@kernel.dk>
 <12c343a4-8646-3776-9aa1-53decdf824d8@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <12c343a4-8646-3776-9aa1-53decdf824d8@kernel.dk>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Fri, Sep 15, 2017 at 12:06:41PM -0600, Jens Axboe wrote:
> On 09/15/2017 08:29 AM, Jens Axboe wrote:
> > On 09/14/2017 08:20 PM, Ming Lei wrote:
> >> On Thu, Sep 14, 2017 at 12:51:24PM -0600, Jens Axboe wrote:
> >>> On 09/14/2017 10:42 AM, Ming Lei wrote:
> >>>> Hi,
> >>>>
> >>>> This patchset avoids to allocate driver tag beforehand for flush rq
> >>>> in case of I/O scheduler, then flush rq isn't treated specially
> >>>> wrt. get/put driver tag, code gets cleanup much, such as,
> >>>> reorder_tags_to_front() is removed, and we needn't to worry
> >>>> about request order in dispatch list for avoiding I/O deadlock.
> >>>>
> >>>> 'dbench -t 30 -s -F 64' has been run on different devices(shared tag,
> >>>> multi-queue, singele queue, ...), and no issues are observed,
> >>>> even very low queue depth(1) test are run, debench still works
> >>>> well.
> >>>
> >>> Gave this a quick spin on the test box, and I get tons of spewage
> >>> on booting up:
> >>>
> >>> [    9.131290] WARNING: CPU: 2 PID: 337 at block/blk-mq-sched.c:274 blk_mq_sched_insert_request+0x15d/0x170
> >>
> >> Sorry, my fault.
> >>
> >> The WARN_ON() was inside 'if (has_sched)' actually, and could you
> >> please remove the WARN_ON() in blk_mq_sched_bypass_insert() and
> >> see if it works?
> > 
> > Putting it inside 'has_sched' makes it go away. I'll fire up some
> > testing of it here.
> 
> It still triggers for the requeue path, however:
> 
> [12403.280753] WARNING: CPU: 4 PID: 2279 at block/blk-mq-sched.c:275 blk_mq_sched_insert_request+0
> [12403.302465] Modules linked in: null_blk configfs crct10dif_generic crct10dif_common loop dm_mo]
> [12403.331762] CPU: 4 PID: 2279 Comm: kworker/4:1H Tainted: G        W       4.13.0+ #473
> [12403.341497] Hardware name: Dell Inc. PowerEdge T630/0NT78X, BIOS 2.3.4 11/09/2016
> [12403.350745] Workqueue: kblockd blk_mq_requeue_work
> [12403.356574] task: ffff881ff6c57000 task.stack: ffff881ff2acc000
> [12403.363667] RIP: 0010:blk_mq_sched_insert_request+0x15d/0x170
> [12403.370565] RSP: 0018:ffff881ff2acfdc0 EFLAGS: 00010213
> [12403.376878] RAX: ffff881ff2868000 RBX: ffff880c7677be00 RCX: 0000000000022003
> [12403.385333] RDX: ffff881ff32d8c00 RSI: 0000000000000001 RDI: ffff880c7677be00
> [12403.393790] RBP: ffff881ff2acfe08 R08: 0000000000000001 R09: ffff8809010d4000
> [12403.402240] R10: 0000000000000000 R11: 0000000000001000 R12: ffff881ff37b3800
> [12403.410695] R13: 0000000000000000 R14: 0000000000000000 R15: ffffe8dfffe86940
> [12403.419150] FS:  0000000000000000(0000) GS:ffff881fff680000(0000) knlGS:0000000000000000
> [12403.429065] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [12403.435961] CR2: 00007f13f4ce1000 CR3: 0000001ff357d002 CR4: 00000000003606e0
> [12403.444414] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [12403.452868] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> [12403.461316] Call Trace:
> [12403.464528]  ? __blk_mq_delay_run_hw_queue+0x84/0xa0
> [12403.470550]  blk_mq_requeue_work+0xc6/0x140
> [12403.475702]  process_one_work+0x18a/0x3e0
> [12403.480654]  worker_thread+0x48/0x3b0
> [12403.485313]  kthread+0x12a/0x140
> [12403.489390]  ? process_one_work+0x3e0/0x3e0
> [12403.494545]  ? kthread_create_on_node+0x40/0x40
> [12403.500078]  ret_from_fork+0x22/0x30
> [12403.504551] Code: c0 4c 89 fa e8 e5 97 02 00 48 8b 4d c0 84 c0 74 10 49 89 5f 08 4c 89 3b 48 8 
> [12403.526954] ---[ end trace 2eefb804292867b5 ]---
> 
> The code now looks like this:
> 
> if (has_sched) {                                                        
> 	WARN_ON(rq->tag != -1);                                         
> 	rq->rq_flags |= RQF_SORTED;                                     
> }

Yeah, requeue is one case I missed, since the request may
have a valid driver tag assigned at that time if the requeue
happens in completion path.

So I think we need to release driver tag in __blk_mq_requeue_request().

-- 
Ming
