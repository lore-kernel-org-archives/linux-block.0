Return-Path: <SRS0=WD2t=T6=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22ED5C072B1
	for <linux-block@archiver.kernel.org>; Thu, 30 May 2019 04:11:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E55DC25177
	for <linux-block@archiver.kernel.org>; Thu, 30 May 2019 04:11:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hgCnqefD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726820AbfE3ELf (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 30 May 2019 00:11:35 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:36824 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726945AbfE3ELa (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 30 May 2019 00:11:30 -0400
Received: by mail-wr1-f66.google.com with SMTP id n4so100954wrs.3;
        Wed, 29 May 2019 21:11:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=h0T/MeUzCgmPrR3gk4K6fixpQQCnUhC4n3eE1p0lqFk=;
        b=hgCnqefDl/JBYEu4+rVNRoDQ7aPZCmlANqR5qlyPz6/nnL28KsHj+EQ+oreogGLjsr
         49zHHIs20aSdki49ikhvYEphqoaOKPHLxpS9QT0x0sDy0AvEZtAvUljqKxeG3GfnCQJO
         F0L0iaJYn6wWdW0OO7FgacQQZqgyTbfa5CRutqF0vO71aLqR2nvafmfuSLco9oiO7lLa
         xbdQhurZPhGnsa8IHWRD/fta8zBPRQfx6bHq9Nxs2/E2qmEf36Mtab55petXEO/xJsle
         QUp/GiiZ8KyeuZFDLjw7eEjCFRXgNrDOKf6bAS7eMAY5GLtOdkGssTqQZVUlotsPCTfQ
         axQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=h0T/MeUzCgmPrR3gk4K6fixpQQCnUhC4n3eE1p0lqFk=;
        b=feiRG1ykqG5Ity79nFKQI7VVAlIw+NVUeAoSFlTwz89YVFDFyPzVjNU5atcHaR9RSO
         OvKqy7bV/G4fXfh0KzKMy65Hacp0hIkkXii/ZLdMYTmPm7KBc2u2//oU8idXycQ8ZMwa
         1FRjCc7u06+EA8WZCqjfmdHeA+7/5xHeHYrcXYJhP2AljobUZlAC0XUgImGCO2t86ZER
         LaHbY4lITCBGM5Xz6MV4S5pPgLZb9Aa2nwkeTEI3c+3CKm5ySBLi+9NtgmQm4p5K6aNb
         iKBS/j8JPBH4Hn7CKP+PHfds8o5E1AGcVqzfvPUBnjmShHsrj+c3pM0v4pjqorAQg2PU
         mEKA==
X-Gm-Message-State: APjAAAVvBs9or7N9T8tcpksD907OSPdmbKkpcpTq4ykQbfaG8dBSSbJx
        YdGWANzPE/z2MoVwYz1Nq5zt2WbONNk9g0dd3AI=
X-Google-Smtp-Source: APXvYqygV+uOyMtAemWnhhiWiShh7/TIAUUBWaiU/a5IN+a5xO/PuxK6M2Z/CWDO1fezb5B4lXERYXzMhvkF61hJhQ8=
X-Received: by 2002:adf:fbc2:: with SMTP id d2mr947614wrs.334.1559189488864;
 Wed, 29 May 2019 21:11:28 -0700 (PDT)
MIME-Version: 1.0
References: <20190527150207.11372-1-ming.lei@redhat.com> <20190527150207.11372-6-ming.lei@redhat.com>
 <45daceb4-fb88-a835-8cc6-cd4c4d7cf42d@huawei.com> <20190529022852.GA21398@ming.t460p>
 <20190529024200.GC21398@ming.t460p> <5bc07fd5-9d2b-bf9c-eb77-b8cebadb9150@huawei.com>
 <20190529101028.GA15496@ming.t460p> <CACVXFVODeFDPHxWkdnY5CZoOJ0did4mi_ap-aXk0oo+Cp05aUQ@mail.gmail.com>
 <94964048-b867-8610-71ea-0275651f8b77@huawei.com> <20190530022810.GA16730@ming.t460p>
In-Reply-To: <20190530022810.GA16730@ming.t460p>
From:   Ming Lei <tom.leiming@gmail.com>
Date:   Thu, 30 May 2019 12:11:17 +0800
Message-ID: <CACVXFVN729SgFQGUgmu1iN7P6Mv5+puE78STz8hj9J5bS828Ng@mail.gmail.com>
Subject: Re: [PATCH V2 5/5] blk-mq: Wait for for hctx inflight requests on CPU unplug
To:     Ming Lei <ming.lei@redhat.com>
Cc:     John Garry <john.garry@huawei.com>, Jens Axboe <axboe@kernel.dk>,
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
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, May 30, 2019 at 10:28 AM Ming Lei <ming.lei@redhat.com> wrote:
>
> On Wed, May 29, 2019 at 05:10:38PM +0100, John Garry wrote:
> >
> > > >
> > > > And we should be careful to handle the multiple reply queue case, given the queue
> > > > shouldn't be stopped or quieseced because other reply queues are still active.
> > > >
> > > > The new CPUHP state for blk-mq should be invoked after the to-be-offline
> > > > CPU is quiesced and before it becomes offline.
> > >
> > > Hi John,
> > >
> >
> > Hi Ming,
> >
> > > Thinking of this issue further, so far, one doable solution is to
> > > expose reply queues
> > > as blk-mq hw queues, as done by the following patchset:
> > >
> > > https://lore.kernel.org/linux-block/20180205152035.15016-1-ming.lei@redhat.com/
> >
> > I thought that this patchset had fundamental issues, in terms of working for
> > all types of hosts. FYI, I did the backport of latest hisi_sas_v3 to v4.15
>
> Could you explain it a bit about the fundamental issues for all types of
> host?
>
> It is just for hosts with multiple reply queues, such as hisi_sas v3,
> megaraid_sas, mpt3sas and hpsa.
>
> > with this patchset (as you may have noticed in my git send mistake), but we
> > have not got to test it yet.
> >
> > On a related topic, we did test exposing reply queues as blk-mq hw queues
> > and generating the host-wide tag internally in the LLDD with sbitmap, and
> > unfortunately we were experiencing a significant performance hit, like 2300K
> > -> 1800K IOPs for 4K read.
> >
> > We need to test this further. I don't understand why we get such a big hit.
>
> The performance regression shouldn't have been introduced in theory, and it is
> because blk_mq_queue_tag_busy_iter() iterates over the same duplicated tags multiple
> times, which can be fixed easily.
>
> >
> > >
> > > In which global host-wide tags are shared for all blk-mq hw queues.
> > >
> > > Also we can remove all the reply_map stuff in drivers, then solve the problem of
> > > draining in-flight requests during unplugging CPU in a generic approach.
> >
> > So you're saying that removing this reply queue stuff can make the solution
> > to the problem more generic, but do you have an idea of the overall
> > solution?
>
> 1) convert reply queue into blk-mq hw queue first
>
> 2) then all drivers are in same position wrt. handling requests vs.
> unplugging CPU (shutdown managed IRQ)
>
> The current handling in blk_mq_hctx_notify_dead() is actually wrong,
> at that time, all CPUs on the hctx are dead, blk_mq_run_hw_queue()
> still dispatches requests on driver's hw queue, and driver is invisible
> to DEAD CPUs mapped to this hctx, and finally interrupt for these
> requests on the hctx are lost.
>
> Frankly speaking, the above 2nd problem is still hard to solve.
>
> 1) take_cpu_down() shutdown managed IRQ first, then run teardown callback
> for states in [CPUHP_AP_ONLINE, CPUHP_AP_OFFLINE) on the to-be-offline
> CPU
>
> 2) However, all runnable tasks are removed from the CPU in the teardown
> callback for CPUHP_AP_SCHED_STARTING, which is run after managed IRQs
> are shutdown. That said it is hard to avoid new request queued to
> the hctx with all DEAD CPUs.
>
> 3) we don't support to freeze queue for specific hctx yet, or that way
> may not be accepted because of extra cost in fast path
>
> 4) once request is allocated, it should be submitted to driver no matter
> if CPU hotplug happens or not. Or free it and re-allocate new request
> on proper sw/hw queue?

That looks doable, we may steal bios from the old in-queue request, then
re-submit them via generic_make_request(), and finally free the old request,
but RQF_DONTPREP has to be addressed via one new callback.

So follows the overall solution for waiting request vs. CPU hotplug,
which is done
in two stages:

1) in the teardown callback of new  CPUHP state of CPUHP_BLK_MQ_PREP,
which is run before CPUHP_AP_ONLINE_IDLE,  at that time the CPU & managed
IRQ is still alive:

- stopped the hctx
- wait in-flight requests from this hctx until all are completed

2) in the teardown callback of CPUHP_BLK_MQ_DEAD, which is run
after the CPU is dead

- dequeue request queued in sw queue or scheduler queue from this hctx
- steal bios from the dequeued request, and re-submit them via
generic_make_request()
- free the dequeued request, and need to free driver resource via new
callback for
RQF_DONTPREP, looks only SCSI needs it.
- restart this hctx


Thanks,
Ming Lei
