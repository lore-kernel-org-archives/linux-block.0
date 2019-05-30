Return-Path: <SRS0=WD2t=T6=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0381C28CC0
	for <linux-block@archiver.kernel.org>; Thu, 30 May 2019 02:28:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B740B24436
	for <linux-block@archiver.kernel.org>; Thu, 30 May 2019 02:28:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726859AbfE3C21 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 29 May 2019 22:28:27 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53222 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726483AbfE3C21 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 29 May 2019 22:28:27 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 6A8D283F4C;
        Thu, 30 May 2019 02:28:26 +0000 (UTC)
Received: from ming.t460p (ovpn-8-16.pek2.redhat.com [10.72.8.16])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 305FE5D704;
        Thu, 30 May 2019 02:28:15 +0000 (UTC)
Date:   Thu, 30 May 2019 10:28:11 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     John Garry <john.garry@huawei.com>
Cc:     Ming Lei <tom.leiming@gmail.com>, Jens Axboe <axboe@kernel.dk>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-block <linux-block@vger.kernel.org>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        Linux SCSI List <linux-scsi@vger.kernel.org>,
        Bart Van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.com>,
        Keith Busch <keith.busch@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Don Brace <don.brace@microsemi.com>,
        Kashyap Desai <kashyap.desai@broadcom.com>,
        Sathya Prakash <sathya.prakash@broadcom.com>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH V2 5/5] blk-mq: Wait for for hctx inflight requests on
 CPU unplug
Message-ID: <20190530022810.GA16730@ming.t460p>
References: <20190527150207.11372-1-ming.lei@redhat.com>
 <20190527150207.11372-6-ming.lei@redhat.com>
 <45daceb4-fb88-a835-8cc6-cd4c4d7cf42d@huawei.com>
 <20190529022852.GA21398@ming.t460p>
 <20190529024200.GC21398@ming.t460p>
 <5bc07fd5-9d2b-bf9c-eb77-b8cebadb9150@huawei.com>
 <20190529101028.GA15496@ming.t460p>
 <CACVXFVODeFDPHxWkdnY5CZoOJ0did4mi_ap-aXk0oo+Cp05aUQ@mail.gmail.com>
 <94964048-b867-8610-71ea-0275651f8b77@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <94964048-b867-8610-71ea-0275651f8b77@huawei.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Thu, 30 May 2019 02:28:26 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, May 29, 2019 at 05:10:38PM +0100, John Garry wrote:
> 
> > > 
> > > And we should be careful to handle the multiple reply queue case, given the queue
> > > shouldn't be stopped or quieseced because other reply queues are still active.
> > > 
> > > The new CPUHP state for blk-mq should be invoked after the to-be-offline
> > > CPU is quiesced and before it becomes offline.
> > 
> > Hi John,
> > 
> 
> Hi Ming,
> 
> > Thinking of this issue further, so far, one doable solution is to
> > expose reply queues
> > as blk-mq hw queues, as done by the following patchset:
> > 
> > https://lore.kernel.org/linux-block/20180205152035.15016-1-ming.lei@redhat.com/
> 
> I thought that this patchset had fundamental issues, in terms of working for
> all types of hosts. FYI, I did the backport of latest hisi_sas_v3 to v4.15

Could you explain it a bit about the fundamental issues for all types of
host?

It is just for hosts with multiple reply queues, such as hisi_sas v3,
megaraid_sas, mpt3sas and hpsa.

> with this patchset (as you may have noticed in my git send mistake), but we
> have not got to test it yet.
> 
> On a related topic, we did test exposing reply queues as blk-mq hw queues
> and generating the host-wide tag internally in the LLDD with sbitmap, and
> unfortunately we were experiencing a significant performance hit, like 2300K
> -> 1800K IOPs for 4K read.
> 
> We need to test this further. I don't understand why we get such a big hit.

The performance regression shouldn't have been introduced in theory, and it is
because blk_mq_queue_tag_busy_iter() iterates over the same duplicated tags multiple
times, which can be fixed easily.  

> 
> > 
> > In which global host-wide tags are shared for all blk-mq hw queues.
> > 
> > Also we can remove all the reply_map stuff in drivers, then solve the problem of
> > draining in-flight requests during unplugging CPU in a generic approach.
> 
> So you're saying that removing this reply queue stuff can make the solution
> to the problem more generic, but do you have an idea of the overall
> solution?

1) convert reply queue into blk-mq hw queue first

2) then all drivers are in same position wrt. handling requests vs.
unplugging CPU (shutdown managed IRQ)

The current handling in blk_mq_hctx_notify_dead() is actually wrong,
at that time, all CPUs on the hctx are dead, blk_mq_run_hw_queue()
still dispatches requests on driver's hw queue, and driver is invisible
to DEAD CPUs mapped to this hctx, and finally interrupt for these
requests on the hctx are lost.

Frankly speaking, the above 2nd problem is still hard to solve.

1) take_cpu_down() shutdown managed IRQ first, then run teardown callback
for states in [CPUHP_AP_ONLINE, CPUHP_AP_OFFLINE) on the to-be-offline
CPU

2) However, all runnable tasks are removed from the CPU in the teardown
callback for CPUHP_AP_SCHED_STARTING, which is run after managed IRQs
are shutdown. That said it is hard to avoid new request queued to
the hctx with all DEAD CPUs.

3) we don't support to freeze queue for specific hctx yet, or that way
may not be accepted because of extra cost in fast path

4) once request is allocated, it should be submitted to driver no matter
if CPU hotplug happens or not. Or free it and re-allocate new request
on proper sw/hw queue?

> 
> > 
> > Last time, it was reported that the patchset causes performance regression,
> > which is actually caused by duplicated io accounting in
> > blk_mq_queue_tag_busy_iter(),
> > which should be fixed easily.
> > 
> > What do you think of this approach?
> 
> It would still be good to have a forward port of this patchset for testing,
> if we're serious about it. Or at least this bug you mention fixed.

I plan to make this patchset workable on 5.2-rc for your test first.


Thanks,
Ming
