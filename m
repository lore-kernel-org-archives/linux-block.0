Return-Path: <SRS0=N1jC=SE=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF2CDC43381
	for <linux-block@archiver.kernel.org>; Tue,  2 Apr 2019 02:20:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A34FD206B6
	for <linux-block@archiver.kernel.org>; Tue,  2 Apr 2019 02:20:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GIgCf1J3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726411AbfDBCUn (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 1 Apr 2019 22:20:43 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:51899 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726269AbfDBCUm (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 1 Apr 2019 22:20:42 -0400
Received: by mail-wm1-f67.google.com with SMTP id 4so1506110wmf.1;
        Mon, 01 Apr 2019 19:20:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0cVoGb+14sIQxfdZMK5iphVXYN/9k2nHTPOOkFdL57I=;
        b=GIgCf1J3t6j2zs1KPZ9FkHexf9i1mOGuROZCYjFT8L8a5RabjnHkc50CqsEQOqNflH
         Yi/Qt/Pj+N3C3v/1mcBQ3C4S7dYs3Dqm4jrbvQifALW/ub8fXNljVrOrRJLcnzHbpsUm
         vL8Chs1SpoygW9Fmxw/gk1lRr1qrrc79QnBK0+KOOMGwteMghdZNUPO4RMiU8KUb+gL+
         MEXn+GmwGlJ1aYFs5sqEoAml7GIelrfcgEhYlm+bUqwCf2SZiYEYsHelnXja3o09ECNA
         Aq60izUDBYYC8ZRN9nB9h/0hoos59uvZh15AjWiXTAi2eyTA5ya9ayTxMNpdBUb3YInd
         TD2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0cVoGb+14sIQxfdZMK5iphVXYN/9k2nHTPOOkFdL57I=;
        b=eYffwYF/KzIxQXtihJU8czzMm/Exf80LKTCSwmtjGWA20fbkusmaea8vbd0BiFJK3q
         ODWdhq482rIRNnDampLlqR/8tiYhpT9GktNkNKhItynHbcHPMlNMQoAdbN1b7EPSCRkM
         yphsMeDYq5KjqKnPKC+EYkzQ3c5f/e0vARgbDwrI1w+9PEZ7AZP21uSnOgsa2JG4w2JB
         LGn7BOS/CBbGzIeb4VKoJaNvuOusPM/19LV+iSxh3GjcaEIfkfxu3Ad++AWskg1mF390
         OLQ71eN9wmvd0aQMvyZeLvYMvT6Ls9kSFV594QxaL5PacCcgPbXxr4VPhzwmvah5gR0g
         fEzA==
X-Gm-Message-State: APjAAAWgfSYfO1UCcrCg2cfui5z6E/7GKHBfTnNC+jegluaaQx8K3eMv
        n21ycPVU6zQ63O5pHsB+Krij4tHPGSvZOAaUUjo=
X-Google-Smtp-Source: APXvYqypiwD81p19g2S2SjezXyV27DF0vOdDNLI05nRr6fsxe91Y9LeioRX9oe41mQ51t2J2hRmvlavKXvGW8/A+bCM=
X-Received: by 2002:a7b:c408:: with SMTP id k8mr1676807wmi.69.1554171640302;
 Mon, 01 Apr 2019 19:20:40 -0700 (PDT)
MIME-Version: 1.0
References: <20190331030954.22320-1-ming.lei@redhat.com> <10c8ed10-3c96-b73c-18d8-114773b1d675@acm.org>
 <20190401020036.GB30776@ming.t460p> <a64684d1-c3dc-b10a-1a03-0a8b2d01b331@acm.org>
 <20190401025237.GE30776@ming.t460p> <a6dc5d0e-8e51-0714-ac25-6cb6ab78fa18@oracle.com>
 <20190401051617.GH30776@ming.t460p> <a406da95-e351-9f28-14cc-9f83b83102eb@oracle.com>
 <CACVXFVOHOLHOPrxD9vOUcup2_TyKnHx9K1JMMomeoo_f49C6Ww@mail.gmail.com> <f7f8aee9-ab69-feae-2a83-c8c55291cb1d@oracle.com>
In-Reply-To: <f7f8aee9-ab69-feae-2a83-c8c55291cb1d@oracle.com>
From:   Ming Lei <tom.leiming@gmail.com>
Date:   Tue, 2 Apr 2019 10:20:28 +0800
Message-ID: <CACVXFVNO0yw7hemsi44mC_Od28cU13WaOvEkk9ToQ5zTbqQbqA@mail.gmail.com>
Subject: Re: [PATCH 0/5] blk-mq: allow to run queue if queue refcount is held
To:     Dongli Zhang <dongli.zhang@oracle.com>
Cc:     Ming Lei <ming.lei@redhat.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Jens Axboe <axboe@kernel.dk>,
        linux-block <linux-block@vger.kernel.org>,
        James Smart <james.smart@broadcom.com>,
        Bart Van Assche <bart.vanassche@wdc.com>,
        Linux SCSI List <linux-scsi@vger.kernel.org>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Christoph Hellwig <hch@lst.de>,
        "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>,
        jianchao wang <jianchao.w.wang@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Apr 2, 2019 at 10:06 AM Dongli Zhang <dongli.zhang@oracle.com> wrote:
>
>
>
> On 4/1/19 3:15 PM, Ming Lei wrote:
> > On Mon, Apr 1, 2019 at 1:27 PM Dongli Zhang <dongli.zhang@oracle.com> wrote:
> >>
> >>
> >>
> >> On 4/1/19 1:16 PM, Ming Lei wrote:
> >>> Hi Dongli,
> >>>
> >>> On Mon, Apr 01, 2019 at 01:05:46PM +0800, Dongli Zhang wrote:
> >>>>
> >>>>
> >>>> On 4/1/19 10:52 AM, Ming Lei wrote:
> >>>>> On Sun, Mar 31, 2019 at 07:39:17PM -0700, Bart Van Assche wrote:
> >>>>>> On 3/31/19 7:00 PM, Ming Lei wrote:
> >>>>>>> On Sun, Mar 31, 2019 at 08:27:35AM -0700, Bart Van Assche wrote:
> >>>>>>>> I'm not sure the approach of this patch series is really the direction we
> >>>>>>>> should pursue. There are many block driver that free resources immediately
> >>>>>>>
> >>>>>>> Please see scsi_run_queue(), and the queue refcount is always held
> >>>>>>> before run queue.
> >>>>>>
> >>>>>> That's not correct. There is no guarantee that q->q_usage_counter > 0 when
> >>>>>> scsi_run_queue() is called from inside scsi_requeue_run_queue().
> >>>>>
> >>>>> We don't need the guarantee of 'q->q_usage_counter > 0', I mean the
> >>>>> queue's kobj reference counter.
> >>>>>
> >>>>> What we need is to allow run queue to work correctly after queue is frozen
> >>>>> or cleaned up.
> >>>>>
> >>>>>>
> >>>>>>>> I'd like to avoid having to modify all block drivers that free resources
> >>>>>>>> immediately after blk_cleanup_queue() has returned. Have you considered to
> >>>>>>>> modify blk_mq_run_hw_queues() such that it becomes safe to call that
> >>>>>>>> function while blk_cleanup_queue() is in progress, e.g. by inserting a
> >>>>>>>> percpu_ref_tryget_live(&q->q_usage_counter) /
> >>>>>>>> percpu_ref_put(&q->q_usage_counter) pair?
> >>>>>>>
> >>>>>>> It can't work because blk_mq_run_hw_queues may happen after
> >>>>>>> percpu_ref_exit() is done.
> >>>>>>>
> >>>>>>> However, if we move percpu_ref_exit() into queue's release handler, we
> >>>>>>> don't need to grab q->q_usage_counter any more in blk_mq_run_hw_queues(),
> >>>>>>> and we still have to free hw queue resources in queue's release handler,
> >>>>>>> that is exactly what this patchset is doing.
> >>>>>>>
> >>>>>>> In short, getting q->q_usage_counter doesn't make a difference on this
> >>>>>>> issue.
> >>>>>>
> >>>>>> percpu_ref_tryget_live() fails if a per-cpu counter is in the "dead" state.
> >>>>>> percpu_ref_kill() changes the state of a per-cpu counter to the "dead"
> >>>>>> state. blk_freeze_queue_start() calls percpu_ref_kill(). blk_cleanup_queue()
> >>>>>> already calls blk_set_queue_dying() and that last function calls
> >>>>>> blk_freeze_queue_start(). So I think that what you wrote is not correct and
> >>>>>> that inserting a percpu_ref_tryget_live()/percpu_ref_put() pair in
> >>>>>> blk_mq_run_hw_queues() or blk_mq_run_hw_queue() would make a difference and
> >>>>>> also that moving the percpu_ref_exit() call into blk_release_queue() makes
> >>>>>> sense.
> >>>>>
> >>>>> If percpu_ref_exit() is moved to blk_release_queue(), we still need to
> >>>>> move freeing of hw queue's resource into blk_release_queue() like what
> >>>>> the patchset is doing.
> >>>>
> >>>> Hi Ming,
> >>>>
> >>>> Would you mind help explain why we still need to move freeing of hw queue's
> >>>> resource into blk_release_queue() like what the patchset is doing?
> >>>>
> >>>> Let's assume there is no deadlock when percpu_ref_tryget_live() is used,
> >>>
> >>> Could you explain why the assumption is true?
> >>>
> >>> We have to run queue after starting to freeze queue for draining
> >>> allocated requests and making forward progress. Inside blk_freeze_queue_start(),
> >>> percpu_ref_kill() marks this ref as DEAD, then percpu_ref_tryget_live() returns
> >>> false, then queue won't be run.
> >>
> >> Hi Ming,
> >>
> >> I understand the assumption is invalid and there is issue when using
> >> percpu_ref_tryget_live. And I also understand we have to run queue after
> >> starting to freeze queue for draining allocated requests and making forward
> >> progress.
> >
> > OK.
> >
> >>
> >>
> >> I am just wondering specifically on why "If percpu_ref_exit() is moved to
> >> blk_release_queue(), we still need to move freeing of hw queue's resource into
> >> blk_release_queue() like what the patchset is doing." based on below Bart's
> >> statement:
> >>
> >> "percpu_ref_tryget_live() fails if a per-cpu counter is in the "dead" state.
> >> percpu_ref_kill() changes the state of a per-cpu counter to the "dead" state.
> >> blk_freeze_queue_start() calls percpu_ref_kill(). blk_cleanup_queue() already
> >> calls blk_set_queue_dying() and that last function call
> >> blk_freeze_queue_start(). So I think that what you wrote is not correct and that
> >> inserting a percpu_ref_tryget_live()/percpu_ref_put() pair in
> >> blk_mq_run_hw_queues() or blk_mq_run_hw_queue() would make a difference and also
> >> that moving the percpu_ref_exit() call into blk_release_queue() makes sense."
> >
> > As you mentioned, percpu_ref_tryget_live() can't be used to avoid run queue
> > during cleanup, then run queue can come when queue is cleaned up.
> >
> >>
> >> That's is, what is penalty if we do not  move freeing of hw queue's resource
> >> into blk_release_queue() like what the patchset is doing in above situation?
> >
> > kernel oops as reported by James, because some fields of hctx will be used
> > by run queue, and they can be freed by blk_mq_free_queue() in
> > blk_cleanup_queue().
> >
> >>
> >> I ask this question just because I would like to better understand the source
> >> code. Does "hw queue's resource" indicate the below?
> >>
> >> +        if (hctx->flags & BLK_MQ_F_BLOCKING)
> >> +                cleanup_srcu_struct(hctx->srcu);
> >> +        blk_free_flush_queue(hctx->fq);
> >> +        sbitmap_free(&hctx->ctx_map);
> >
> > Right.
>
> Hi Ming,
>
> Thank you very much for the detailed explanation.
>
> I think maybe I misunderstood your message in the email.
>
> In another direction posted by Bart as below, regardless about which direction
> is better, that implementation does not move freeing of hw queue's resource into
> blk_release_queue(), although percpu_ref_exit() is moved to blk_release_queue().
> That's why I would like to confirm.
>
> https://lore.kernel.org/linux-block/20190401212014.192753-1-bvanassche@acm.org/
>
> In that direction, the more friendly percpu_ref_tryget(), which is suggested by
> Jianchao, is used. I would like just to confirm that there is no need to move
> freeing of hw queue's resource into blk_release_queue() when the get/put method
> is friendly and fair enough.

I don't think it is friendly to add such unnecessary stuff in the very
fast path.



Thanks,
Ming Lei
