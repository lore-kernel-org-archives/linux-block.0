Return-Path: <SRS0=Oz1R=QV=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17A2BC43381
	for <linux-block@archiver.kernel.org>; Thu, 14 Feb 2019 12:44:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF843218FF
	for <linux-block@archiver.kernel.org>; Thu, 14 Feb 2019 12:44:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hXXiV77u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387819AbfBNMof (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 14 Feb 2019 07:44:35 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:36069 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389264AbfBNMoe (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 14 Feb 2019 07:44:34 -0500
Received: by mail-wm1-f68.google.com with SMTP id j125so5973179wmj.1
        for <linux-block@vger.kernel.org>; Thu, 14 Feb 2019 04:44:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=t+Zty1F5aTrD7tTlPaRLsEp+o/NlQ+u96UVFG1Oqnx8=;
        b=hXXiV77uU9DAc9KuYy+L4UUpRmLt9hYmuQepsfR3/v/qzE7h8xN3J5lkjHVe1aR4uM
         3OWdmR2HNcJXP7+hlKVXXI9C0xLYFX6RCd72ron5wc4P43uGEh/xhKuEghvVt5/Jvxm4
         FBUYEM46IOnaL+2aKsa/aJOnR3mbAWe0qJdqOIiRFIvE1OgmYn/94p4kKAYW2XG48qrj
         RTdX7PuQ5IZHX37ZcSfYgyyfS9w9KzFJJLc4ocCBFNXE+k3HOkyar6o+mxIArOo7HgAi
         XM56hyE0IIqR1amc7mVqx0EVfJ/PTT2QJtreI5clmjlMRjIhdh5h7ponWutGvpef2ARf
         ZWUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=t+Zty1F5aTrD7tTlPaRLsEp+o/NlQ+u96UVFG1Oqnx8=;
        b=fp/Vjwj5pbIhJ3Df/rZUAWQVJenXcqLfrU8IYbdAJaYCOTyDruyOpcwaQBS7lpj8Lv
         mqEGJQ+pVAHpsSK6yM7ZvfoiEDoushCK6GNxEegR419P9mfsfEBsokyELvN3PhkFEtmQ
         ISS91sBegSVdRRarJsPUw0iV0qcTt4nO532JpQjY3k6CSOeMa83XRc4cL+woXAOTEjmj
         0R4ydthfu9yscTFIVT0qfRg5ZOaMQY+j7h2jP3P4ajvDH9h64BrE8lNa+UKa/qEpWUu8
         5GGCuIBZbC6WFfZr1eTeaQY/QpnulT+op4jjZx7K229Psi52jlJE75HOS1ymjtK3/XPT
         w+MA==
X-Gm-Message-State: AHQUAuawv1Y6a9blvw5K9eUHUsW78zrQ5iTryz6BfXv3SsggqiQVwGjt
        QjoUaYDz1tCMatZSvIcfaoULGjQwQD+Rc+PXO04=
X-Google-Smtp-Source: AHgI3Iaqh8fI2msnn/zObNGaWPsNcsgR9WimNBr6ljT0jBE7I1CnhhztpUbmd+L5IVcPcID/lAfadTt37ssco+moMdY=
X-Received: by 2002:a1c:9692:: with SMTP id y140mr2692074wmd.67.1550148271377;
 Thu, 14 Feb 2019 04:44:31 -0800 (PST)
MIME-Version: 1.0
References: <20190212163137.GA7701@mit.edu> <CACVXFVNWK7QC+463cbMKE4T36O72Qvkx6AjbW2RZtJX3H4RM9g@mail.gmail.com>
 <1550079373.19311.55.camel@acm.org>
In-Reply-To: <1550079373.19311.55.camel@acm.org>
From:   Ming Lei <tom.leiming@gmail.com>
Date:   Thu, 14 Feb 2019 20:44:19 +0800
Message-ID: <CACVXFVP+MUgrk9z1uVHMZRWnxJAzs3VW+3ZOXEo+NPC0RaCLxg@mail.gmail.com>
Subject: Re: blktests nvme/012 triggering LOCKDEP warning
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     "Theodore Y. Ts'o" <tytso@mit.edu>,
        linux-block <linux-block@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Feb 14, 2019 at 1:36 AM Bart Van Assche <bvanassche@acm.org> wrote:
>
> On Wed, 2019-02-13 at 12:27 +0800, Ming Lei wrote:
> > On Wed, Feb 13, 2019 at 12:33 AM Theodore Y. Ts'o <tytso@mit.edu> wrote:
> > >
> > > Is this a known issue?  nvme/012 is triggering the following lockdep warning:
> > >
> > > Thanks,
> > >
> > >                                         - Ted
> > >
> > > [ 1964.751910] run blktests nvme/012 at 2019-02-11 20:58:31
> > > [ 1964.977624] nvmet: adding nsid 1 to subsystem blktests-subsystem-1
> > > [ 1965.006395] nvmet: creating controller 1 for subsystem blktests-subsystem-1 for NQN nqn.2014-08.org.nvmexpress:uuid:8a58b187-6d09-4c5d-bc03-593896d2d80d.
> > > [ 1965.011811] nvme nvme0: ANA group 1: optimized.
> > > [ 1965.011899] nvme nvme0: creating 2 I/O queues.
> > > [ 1965.013966] nvme nvme0: new ctrl: "blktests-subsystem-1"
> > >
> > > [ 1965.282478] ============================================
> > > [ 1965.287922] WARNING: possible recursive locking detected
> > > [ 1965.293364] 5.0.0-rc3-xfstests-00015-g1236f7d60242 #841 Not tainted
> > > [ 1965.299762] --------------------------------------------
> > > [ 1965.305207] ksoftirqd/1/16 is trying to acquire lock:
> > > [ 1965.310389] 000000000282032e (&(&fq->mq_flush_lock)->rlock){..-.}, at: flush_end_io+0x4e/0x1d0
> > > [ 1965.319146]
> > >                but task is already holding lock:
> > > [ 1965.325106] 00000000cbadcbc2 (&(&fq->mq_flush_lock)->rlock){..-.}, at: flush_end_io+0x4e/0x1d0
> > > [ 1965.333957]
> > >                other info that might help us debug this:
> > > [ 1965.340615]  Possible unsafe locking scenario:
> > >
> > > [ 1965.346664]        CPU0
> > > [ 1965.349248]        ----
> > > [ 1965.351820]   lock(&(&fq->mq_flush_lock)->rlock);
> > > [ 1965.356654]   lock(&(&fq->mq_flush_lock)->rlock);
> > > [ 1965.361490]
> > >                 *** DEADLOCK ***
> > >
> > > [ 1965.367541]  May be due to missing lock nesting notation
> > >
> > > [ 1965.374636] 1 lock held by ksoftirqd/1/16:
> > > [ 1965.378890]  #0: 00000000cbadcbc2 (&(&fq->mq_flush_lock)->rlock){..-.}, at: flush_end_io+0x4e/0x1d0
> > > [ 1965.388080]
> > >                stack backtrace:
> > > [ 1965.392570] CPU: 1 PID: 16 Comm: ksoftirqd/1 Not tainted 5.0.0-rc3-xfstests-00015-g1236f7d60242 #841
> > > [ 1965.402002] Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> > > [ 1965.411411] Call Trace:
> > > [ 1965.413996]  dump_stack+0x67/0x90
> > > [ 1965.417433]  __lock_acquire.cold.45+0x2b4/0x313
> > > [ 1965.422194]  lock_acquire+0x98/0x160
> > > [ 1965.425894]  ? flush_end_io+0x4e/0x1d0
> > > [ 1965.429817]  _raw_spin_lock_irqsave+0x3b/0x80
> > > [ 1965.434299]  ? flush_end_io+0x4e/0x1d0
> > > [ 1965.438162]  flush_end_io+0x4e/0x1d0
> > > [ 1965.441909]  blk_mq_complete_request+0x76/0x110
> > > [ 1965.446580]  nvmet_req_complete+0x15/0x110 [nvmet]
> > > [ 1965.452098]  nvmet_bio_done+0x27/0x50 [nvmet]
> > > [ 1965.456634]  blk_update_request+0xd7/0x2d0
> > > [ 1965.460869]  blk_mq_end_request+0x1a/0x100
> > > [ 1965.465091]  blk_flush_complete_seq+0xe5/0x350
> > > [ 1965.469660]  flush_end_io+0x12f/0x1d0
> > > [ 1965.473436]  blk_done_softirq+0x9f/0xd0
> > > [ 1965.477398]  __do_softirq+0xca/0x440
> > > [ 1965.481092]  ? smpboot_thread_fn+0x2f/0x1e0
> > > [ 1965.485512]  ? smpboot_thread_fn+0x74/0x1e0
> > > [ 1965.489813]  ? smpboot_thread_fn+0x118/0x1e0
> > > [ 1965.494379]  run_ksoftirqd+0x24/0x50
> > > [ 1965.498081]  smpboot_thread_fn+0x113/0x1e0
> > > [ 1965.502399]  ? sort_range+0x20/0x20
> > > [ 1965.506008]  kthread+0x121/0x140
> > > [ 1965.509395]  ? kthread_park+0x80/0x80
> > > [ 1965.513290]  ret_from_fork+0x3a/0x50
> > > [ 1965.527032] XFS (nvme0n1): Mounting V5 Filesystem
> > > [ 1965.541778] XFS (nvme0n1): Ending clean mount
> > > [ 2064.142830] XFS (nvme0n1): Unmounting Filesystem
> > > [ 2064.171432] nvme nvme0: Removing ctrl: NQN "blktests-subsystem-1"
> >
> > That is a false positive.
> >
> > It is caused by calling host request's completion handler from target
> > IO's completion
> > handler directly, and this way should be nvme-loop only.
> >
> > We may need to annotate the locks in .end_io of blk-flush for avoiding
> > this warning.
> >
> > BTW, this way of nvme-loop handling IO completion may trigger soft lockup too.
>
> Hi Ming,
>
> Can you clarify that last statement?

I mean it is easy to trigger soft lockup by the way of nested IO
completion, given
all are done in irq context.

>
> You may want to know that the patch below suppresses this lockdep complaint. I will
> include it in my "dynamic lockdep key" patch series.
>
>
> [PATCH] block: Suppress a false positive lockdep complaint
>
> Avoid that running test nvme/012 from the blktests suite triggers the
> following lockdep complaint:
>
> ============================================
> WARNING: possible recursive locking detected
> 5.0.0-rc3-xfstests-00015-g1236f7d60242 #841 Not tainted
> --------------------------------------------
> ksoftirqd/1/16 is trying to acquire lock:
> 000000000282032e (&(&fq->mq_flush_lock)->rlock){..-.}, at: flush_end_io+0x4e/0x1d0
>
> but task is already holding lock:
> 00000000cbadcbc2 (&(&fq->mq_flush_lock)->rlock){..-.}, at: flush_end_io+0x4e/0x1d0
>
> other info that might help us debug this:
>  Possible unsafe locking scenario:
>
>        CPU0
>        ----
>   lock(&(&fq->mq_flush_lock)->rlock);
>   lock(&(&fq->mq_flush_lock)->rlock);
>
>  *** DEADLOCK ***
>
>  May be due to missing lock nesting notation
>
> 1 lock held by ksoftirqd/1/16:
>  #0: 00000000cbadcbc2 (&(&fq->mq_flush_lock)->rlock){..-.}, at: flush_end_io+0x4e/0x1d0
>
> stack backtrace:
> CPU: 1 PID: 16 Comm: ksoftirqd/1 Not tainted 5.0.0-rc3-xfstests-00015-g1236f7d60242 #841
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> Call Trace:
>  dump_stack+0x67/0x90
>  __lock_acquire.cold.45+0x2b4/0x313
>  lock_acquire+0x98/0x160
>  _raw_spin_lock_irqsave+0x3b/0x80
>  flush_end_io+0x4e/0x1d0
>  blk_mq_complete_request+0x76/0x110
>  nvmet_req_complete+0x15/0x110 [nvmet]
>  nvmet_bio_done+0x27/0x50 [nvmet]
>  blk_update_request+0xd7/0x2d0
>  blk_mq_end_request+0x1a/0x100
>  blk_flush_complete_seq+0xe5/0x350
>  flush_end_io+0x12f/0x1d0
>  blk_done_softirq+0x9f/0xd0
>  __do_softirq+0xca/0x440
>  run_ksoftirqd+0x24/0x50
>  smpboot_thread_fn+0x113/0x1e0
>  kthread+0x121/0x140
>  ret_from_fork+0x3a/0x50
>
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
> ---
>  block/blk-flush.c | 4 +++-
>  block/blk.h       | 1 +
>  2 files changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/block/blk-flush.c b/block/blk-flush.c
> index 6e0f2d97fc6d..c4fa6dd73664 100644
> --- a/block/blk-flush.c
> +++ b/block/blk-flush.c
> @@ -472,7 +472,8 @@ struct blk_flush_queue *blk_alloc_flush_queue(struct request_queue *q,
>         if (!fq)
>                 goto fail;
>
> -       spin_lock_init(&fq->mq_flush_lock);
> +       lockdep_register_key(&fq->key);
> +       spin_lock_init_key(&fq->mq_flush_lock, &fq->key);
>
>         rq_sz = round_up(rq_sz + cmd_size, cache_line_size());
>         fq->flush_rq = kzalloc_node(rq_sz, flags, node);
> @@ -497,6 +498,7 @@ void blk_free_flush_queue(struct blk_flush_queue *fq)
>         if (!fq)
>                 return;
>
> +       lockdep_unregister_key(&fq->key);
>         kfree(fq->flush_rq);
>         kfree(fq);
>  }
> diff --git a/block/blk.h b/block/blk.h
> index 848278c52030..10f5e19aa4a1 100644
> --- a/block/blk.h
> +++ b/block/blk.h
> @@ -28,6 +28,7 @@ struct blk_flush_queue {
>          * at the same time
>          */
>         struct request          *orig_rq;
> +       struct lock_class_key   key;
>         spinlock_t              mq_flush_lock;
>  };

For this particular issue, seems it is over-kill to use per_flush_queue key,
and it should have been enough to use one independent class key for
nvme-loop's flush queue.

Thanks,
Ming Lei
