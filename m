Return-Path: <SRS0=v1Da=O3=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85E4AC43387
	for <linux-block@archiver.kernel.org>; Tue, 18 Dec 2018 18:15:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4059121873
	for <linux-block@archiver.kernel.org>; Tue, 18 Dec 2018 18:15:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tower-research-com.20150623.gappssmtp.com header.i=@tower-research-com.20150623.gappssmtp.com header.b="lu1d3MRC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726812AbeLRSPg (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 18 Dec 2018 13:15:36 -0500
Received: from mail-wr1-f53.google.com ([209.85.221.53]:43089 "EHLO
        mail-wr1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726704AbeLRSPg (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 18 Dec 2018 13:15:36 -0500
Received: by mail-wr1-f53.google.com with SMTP id r10so16883684wrs.10
        for <linux-block@vger.kernel.org>; Tue, 18 Dec 2018 10:15:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tower-research-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nCYn6glFpaGhZT4Q8ebfOcGNIsGUAh+QsRc3YWIsXzQ=;
        b=lu1d3MRC08uWNY0MYOiaGPp/FIisyYydfJ86JHg0/inPXFDAHOOtmbkGyMVwf3HMhp
         +VMRRTB1lzhiPwOrW5X8ThRk6usfWmEK1eyM6u/smW6JGM1SaRn4FaH+JdVWG4SNWrIO
         cwW8rXagNBkDGApDK7IaBH2mt66M0yJNrnVuq0xHiAzDnOXpfoeJai9icyAtBAR/xwgJ
         2WDXqhmPol3QjIavQbc4UDw8K49rBkoTIm6oYC+NHiNPDj4zV0LBlMbSP6amioJKybrH
         +ryABSFI/vtBAedGwjS6/L+3b5NrDeYjwF1iN8vTNg2OkHpDRsEIJM5ivoiDnmuPiDtK
         5/6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nCYn6glFpaGhZT4Q8ebfOcGNIsGUAh+QsRc3YWIsXzQ=;
        b=axawYw6FVJEfzsRya0jZqbyAxdON0wGkkl86RyOU5oTMuAcXkFa5061/6IRYYQAjTw
         hFVMa/oCeTo54B3fnU7jbxAvsOWBcbBdPPyLjRWav2cUo+OuoYyveE3mJ2jX+LB5HCzB
         9dwdBi/pTffwHD5WUJ0YQr6AA+tF0+D/pjy8nJ/WPCZQ0n4UfvXFgRX0UJPtuVRZxS2h
         uGpi9c0zG0y1HrvmMgnUaq82HGP72G5YXIH8ghdD8zTPxZJ8oKE0vKxZOm9U55JkrvFv
         3qeuUtWGHXHEGYKbr1LBqBOt75c2llW5xIbM/rESeFgc01iZf08U9L3g+u2+1Yf0YyvN
         KVpw==
X-Gm-Message-State: AA+aEWZqmJpa8KSXM+q4tK+FsilJ5ACcE5Kk22pQNVC6LK6OzHnZD6GT
        E6/aQQ8oUqeE4NvuBj5jbdyavmheky0JsYpjO1c1Bg==
X-Google-Smtp-Source: AFSGD/XG70/TJlEkRXw90rS1Y9NIR6rhyGJDuhz/wMcxT+udqOWDYviBpL/xq5kdLQTolgpvroCS2Ixu6ditryYzUpA=
X-Received: by 2002:adf:8228:: with SMTP id 37mr15202022wrb.160.1545156931947;
 Tue, 18 Dec 2018 10:15:31 -0800 (PST)
MIME-Version: 1.0
References: <CA+XCsb-0M8PXB30zd22c_nmww5OvMs4mKEcsFahMR7jV+9+01g@mail.gmail.com>
 <8FCED0AE-6BE7-42EE-92ED-58E2B622A165@linaro.org> <CA+XCsb-0vY+x1+jSSRYcLdYz+U_T77QefQVWEoikSS5bfevjpg@mail.gmail.com>
 <C8B5F877-6F4B-46AD-9AC9-BAE91C754A5F@linaro.org> <CA+XCsb8eiq7w-W5ecPNdnqvrv1dU4Vkq=HfKCG=MoQi_CekPBg@mail.gmail.com>
 <255AD47C-65DD-4F22-9E64-8DF9DD81B83B@linaro.org>
In-Reply-To: <255AD47C-65DD-4F22-9E64-8DF9DD81B83B@linaro.org>
From:   Madhav Ancha <mancha@tower-research.com>
Date:   Tue, 18 Dec 2018 13:14:55 -0500
Message-ID: <CA+XCsb_WdbJTMJ2_kn0M1u08YZG6Sz4tXkPWR-oYGULVOqGVZg@mail.gmail.com>
Subject: Re: Unintuitive scheduling results using BFQ
To:     Paolo Valente <paolo.valente@linaro.org>
Cc:     linux-block <linux-block@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Paolo,

    Thanks a lot.
    The RT behavior you described is exactly how we would expect our
RT priority task to behave.
    We are on 4.14. Will test and write back soon.

Thanks,
-Madhav.


On Tue, Dec 18, 2018 at 1:04 PM Paolo Valente <paolo.valente@linaro.org> wrote:
>
>
>
> > Il giorno 14 dic 2018, alle ore 19:25, Madhav Ancha <mancha@tower-research.com> ha scritto:
> >
> > Hi Paolo,
> >
> >    Thanks a lot for your time and help.
> >
> >    I reset all the parameters for bfq and am now running with this
> > one change from the defaults.
> >    - low_latency is set to 0.
> >
> >    When tested with our applications, the IOPRIO_CLASS_RT (doing
> > direct I/O) task has no preference over the IOPRIO_CLASS_BE task (that
> > was using the kernel page cache)
> >
> >    When tested with dd, the IOPRIO_CLASS_RT task (with direct I/O)
> > was getting about 1/4th the bandwidth the IOPRIO_CLASS_BE task (with
> > buffered I/O) was getting.
> >        - RT task with direct I/O: ionice -c1 -n2 /bin/dd if=/dev/zero
> > of=/n/ssd1/ddtestRT bs=2M oflag=direct
> >        - BE task                       : /bin/dd if=/dev/zero
> > of=/n/ssd1/ddtestRT bs=2M
> >
> >    Please let me know if you want me to test more Paolo.
> >    Will look forward to hearing from you.
> >
>
> Ok, doubt confirmed: bfq didn't check properly whether mixed-class
> processes were doing I/O.  I've attached a tentative fix as a
> compressed file (to prevent my client from corrupting it).  You can
> also find the same diffs pasted below, if you want to have a look and
> comment.
>
> The patch should apply cleanly on top of current master.
>
> Let me know if it works.
>
> In particular, consider the following two facts about your RT process
> (i.e., your process with RT I/O-priority class):
> 1) When served in parallel with other I/O, your RT process cannot
> however reach a higher throughput than it reaches when served alone!
> I'm making this silly remark because you may get confused by the fact
> that modern, parallel drives usually reach a higher and higher
> throughput as the number of processes doing I/O grows.
> 2) If your RT process does I/O greedily, then it will monopolize the
> drive after this patch (if this patch works :) ).  This implies that,
> even if you have many processes doing I/O in parallel with your RT
> process, your drive will serve almost only your RT process while the
> latter is active.  Therefore parallelism may be reduced, and the total
> throughput of the drive may be lower than that reached without I/O
> control (I'm working on reducing this loss too, but it is really a
> non-trivial task).
>
> Here are the changes.
>
>  block/bfq-iosched.c | 86 ++++++++++++++++++++++++++++-------------------------
>  block/bfq-iosched.h |  8 +++--
>  block/bfq-wf2q.c    | 12 ++++++--
>  3 files changed, 59 insertions(+), 47 deletions(-)
>
> diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
> index 97337214bec4..d8d7a32ce64b 100644
> --- a/block/bfq-iosched.c
> +++ b/block/bfq-iosched.c
> @@ -623,26 +623,6 @@ void bfq_pos_tree_add_move(struct bfq_data *bfqd, struct bfq_queue *bfqq)
>                 bfqq->pos_root = NULL;
>  }
>
> -/*
> - * Tell whether there are active queues with different weights or
> - * active groups.
> - */
> -static bool bfq_varied_queue_weights_or_active_groups(struct bfq_data *bfqd)
> -{
> -       /*
> -        * For queue weights to differ, queue_weights_tree must contain
> -        * at least two nodes.
> -        */
> -       return (!RB_EMPTY_ROOT(&bfqd->queue_weights_tree) &&
> -               (bfqd->queue_weights_tree.rb_node->rb_left ||
> -                bfqd->queue_weights_tree.rb_node->rb_right)
> -#ifdef CONFIG_BFQ_GROUP_IOSCHED
> -              ) ||
> -               (bfqd->num_groups_with_pending_reqs > 0
> -#endif
> -              );
> -}
> -
>  /*
>   * The following function returns true if every queue must receive the
>   * same share of the throughput (this condition is used when deciding
> @@ -651,25 +631,48 @@ static bool bfq_varied_queue_weights_or_active_groups(struct bfq_data *bfqd)
>   *
>   * Such a scenario occurs when:
>   * 1) all active queues have the same weight,
> - * 2) all active groups at the same level in the groups tree have the same
> - *    weight,
> + * 2) all active queues belong to the same I/O-priority class,
>   * 3) all active groups at the same level in the groups tree have the same
> + *    weight,
> + * 4) all active groups at the same level in the groups tree have the same
>   *    number of children.
>   *
>   * Unfortunately, keeping the necessary state for evaluating exactly
>   * the last two symmetry sub-conditions above would be quite complex
> - * and time consuming.  Therefore this function evaluates, instead,
> - * only the following stronger two sub-conditions, for which it is
> + * and time consuming. Therefore this function evaluates, instead,
> + * only the following stronger three sub-conditions, for which it is
>   * much easier to maintain the needed state:
>   * 1) all active queues have the same weight,
> - * 2) there are no active groups.
> + * 2) all active queues belong to the same I/O-priority class,
> + * 3) there are no active groups.
>   * In particular, the last condition is always true if hierarchical
>   * support or the cgroups interface are not enabled, thus no state
>   * needs to be maintained in this case.
>   */
>  static bool bfq_symmetric_scenario(struct bfq_data *bfqd)
>  {
> -       return !bfq_varied_queue_weights_or_active_groups(bfqd);
> +       /*
> +        * For queue weights to differ, queue_weights_tree must contain
> +        * at least two nodes.
> +        */
> +       bool varied_queue_weights = !RB_EMPTY_ROOT(&bfqd->queue_weights_tree) &&
> +               (bfqd->queue_weights_tree.rb_node->rb_left ||
> +                bfqd->queue_weights_tree.rb_node->rb_right);
> +
> +       bool multiple_classes_busy =
> +               (bfqd->busy_queues[0] & bfqd->busy_queues[1]) |
> +               (bfqd->busy_queues[0] & bfqd->busy_queues[2]) |
> +               (bfqd->busy_queues[1] & bfqd->busy_queues[2]);
> +
> +       /*
> +        * For queue weights to differ, queue_weights_tree must contain
> +        * at least two nodes.
> +        */
> +       return !(varied_queue_weights || multiple_classes_busy
> +#ifdef BFQ_GROUP_IOSCHED_ENABLED
> +              || bfqd->num_groups_with_pending_reqs > 0
> +#endif
> +               );
>  }
>
>  /*
> @@ -728,15 +731,14 @@ void bfq_weights_tree_add(struct bfq_data *bfqd, struct bfq_queue *bfqq,
>         /*
>          * In the unlucky event of an allocation failure, we just
>          * exit. This will cause the weight of queue to not be
> -        * considered in bfq_varied_queue_weights_or_active_groups,
> -        * which, in its turn, causes the scenario to be deemed
> -        * wrongly symmetric in case bfqq's weight would have been
> -        * the only weight making the scenario asymmetric.  On the
> -        * bright side, no unbalance will however occur when bfqq
> -        * becomes inactive again (the invocation of this function
> -        * is triggered by an activation of queue).  In fact,
> -        * bfq_weights_tree_remove does nothing if
> -        * !bfqq->weight_counter.
> +        * considered in bfq_symmetric_scenario, which, in its turn,
> +        * causes the scenario to be deemed wrongly symmetric in case
> +        * bfqq's weight would have been the only weight making the
> +        * scenario asymmetric.  On the bright side, no unbalance will
> +        * however occur when bfqq becomes inactive again (the
> +        * invocation of this function is triggered by an activation
> +        * of queue).  In fact, bfq_weights_tree_remove does nothing
> +        * if !bfqq->weight_counter.
>          */
>         if (unlikely(!bfqq->weight_counter))
>                 return;
> @@ -2217,7 +2219,7 @@ bfq_setup_cooperator(struct bfq_data *bfqd, struct bfq_queue *bfqq,
>                 return NULL;
>
>         /* If there is only one backlogged queue, don't search. */
> -       if (bfqd->busy_queues == 1)
> +       if (bfq_tot_busy_queues(bfqd) == 1)
>                 return NULL;
>
>         in_service_bfqq = bfqd->in_service_queue;
> @@ -3655,7 +3657,8 @@ static bool bfq_better_to_idle(struct bfq_queue *bfqq)
>          * the requests already queued in the device have been served.
>          */
>         asymmetric_scenario = (bfqq->wr_coeff > 1 &&
> -                              bfqd->wr_busy_queues < bfqd->busy_queues) ||
> +                              bfqd->wr_busy_queues <
> +                              bfq_tot_busy_queues(bfqd)) ||
>                 !bfq_symmetric_scenario(bfqd);
>
>         /*
> @@ -3934,7 +3937,7 @@ static struct request *bfq_dispatch_rq_from_bfqq(struct bfq_data *bfqd,
>          * belongs to CLASS_IDLE and other queues are waiting for
>          * service.
>          */
> -       if (!(bfqd->busy_queues > 1 && bfq_class_idle(bfqq)))
> +       if (!(bfq_tot_busy_queues(bfqd) > 1 && bfq_class_idle(bfqq)))
>                 goto return_rq;
>
>         bfq_bfqq_expire(bfqd, bfqq, false, BFQQE_BUDGET_EXHAUSTED);
> @@ -3952,7 +3955,7 @@ static bool bfq_has_work(struct blk_mq_hw_ctx *hctx)
>          * most a call to dispatch for nothing
>          */
>         return !list_empty_careful(&bfqd->dispatch) ||
> -               bfqd->busy_queues > 0;
> +               bfq_tot_busy_queues(bfqd) > 0;
>  }
>
>  static struct request *__bfq_dispatch_request(struct blk_mq_hw_ctx *hctx)
> @@ -4006,9 +4009,10 @@ static struct request *__bfq_dispatch_request(struct blk_mq_hw_ctx *hctx)
>                 goto start_rq;
>         }
>
> -       bfq_log(bfqd, "dispatch requests: %d busy queues", bfqd->busy_queues);
> +       bfq_log(bfqd, "dispatch requests: %d busy queues",
> +               bfq_tot_busy_queues(bfqd));
>
> -       if (bfqd->busy_queues == 0)
> +       if (bfq_tot_busy_queues(bfqd) == 0)
>                 goto exit;
>
>         /*
> diff --git a/block/bfq-iosched.h b/block/bfq-iosched.h
> index 0b02bf302de0..30be669be465 100644
> --- a/block/bfq-iosched.h
> +++ b/block/bfq-iosched.h
> @@ -501,10 +501,11 @@ struct bfq_data {
>         unsigned int num_groups_with_pending_reqs;
>
>         /*
> -        * Number of bfq_queues containing requests (including the
> -        * queue in service, even if it is idling).
> +        * Per-class (RT, BE, IDLE) number of bfq_queues containing
> +        * requests (including the queue in service, even if it is
> +        * idling).
>          */
> -       int busy_queues;
> +       unsigned int busy_queues[3];
>         /* number of weight-raised busy @bfq_queues */
>         int wr_busy_queues;
>         /* number of queued requests */
> @@ -974,6 +975,7 @@ extern struct blkcg_policy blkcg_policy_bfq;
>
>  struct bfq_group *bfq_bfqq_to_bfqg(struct bfq_queue *bfqq);
>  struct bfq_queue *bfq_entity_to_bfqq(struct bfq_entity *entity);
> +unsigned int bfq_tot_busy_queues(struct bfq_data *bfqd);
>  struct bfq_service_tree *bfq_entity_service_tree(struct bfq_entity *entity);
>  struct bfq_entity *bfq_entity_of(struct rb_node *node);
>  unsigned short bfq_ioprio_to_weight(int ioprio);
> diff --git a/block/bfq-wf2q.c b/block/bfq-wf2q.c
> index 63e0f12be7c9..7119207cae3c 100644
> --- a/block/bfq-wf2q.c
> +++ b/block/bfq-wf2q.c
> @@ -44,6 +44,12 @@ static unsigned int bfq_class_idx(struct bfq_entity *entity)
>                 BFQ_DEFAULT_GRP_CLASS - 1;
>  }
>
> +unsigned int bfq_tot_busy_queues(struct bfq_data *bfqd)
> +{
> +       return bfqd->busy_queues[0] + bfqd->busy_queues[1] +
> +               bfqd->busy_queues[2];
> +}
> +
>  static struct bfq_entity *bfq_lookup_next_entity(struct bfq_sched_data *sd,
>                                                  bool expiration);
>
> @@ -1514,7 +1520,7 @@ struct bfq_queue *bfq_get_next_queue(struct bfq_data *bfqd)
>         struct bfq_sched_data *sd;
>         struct bfq_queue *bfqq;
>
> -       if (bfqd->busy_queues == 0)
> +       if (bfq_tot_busy_queues(bfqd) == 0)
>                 return NULL;
>
>         /*
> @@ -1666,7 +1672,7 @@ void bfq_del_bfqq_busy(struct bfq_data *bfqd, struct bfq_queue *bfqq,
>
>         bfq_clear_bfqq_busy(bfqq);
>
> -       bfqd->busy_queues--;
> +       bfqd->busy_queues[bfqq->ioprio_class - 1]--;
>
>         if (!bfqq->dispatched)
>                 bfq_weights_tree_remove(bfqd, bfqq);
> @@ -1689,7 +1695,7 @@ void bfq_add_bfqq_busy(struct bfq_data *bfqd, struct bfq_queue *bfqq)
>         bfq_activate_bfqq(bfqd, bfqq);
>
>         bfq_mark_bfqq_busy(bfqq);
> -       bfqd->busy_queues++;
> +       bfqd->busy_queues[bfqq->ioprio_class - 1]++;
>
>         if (!bfqq->dispatched)
>                 if (bfqq->wr_coeff == 1)
>
> Thanks,
> Paolo
>
>
>
> > Thanks,
> > Madhav.
> >
> >
> > On Fri, Dec 14, 2018 at 12:20 PM Paolo Valente <paolo.valente@linaro.org> wrote:
> >>
> >>
> >>
> >>> Il giorno 14 dic 2018, alle ore 14:55, Madhav Ancha <mancha@tower-research.com> ha scritto:
> >>>
> >>> Hi Paolo,
> >>>
> >>>   Thanks a lot for your work and your response to this email.
> >>>
> >>
> >> Thank you for trying bfq!
> >>
> >>>   Following your advise, I switched my real time application to direct I/O.
> >>>   We now have
> >>>
> >>>   Task1: Using ionice -c1, we run a RT IO/ O_DIRECT task that writes
> >>> to flood the NVME drive to its capacity.
> >>>   Task2: We run a normal (best-effort) IO/ asyn(page-cache buffered)
> >>> task that writes to flood the NVME drive to its capacity.
> >>>
> >>>   What we now see is that Task2 still ends up getting about 3/5th or
> >>> more of the NVMe bandwidth and Task1 ends up getting the rest of the
> >>> NVMe disk bandwidth. Could the kernel threads/buffering be
> >>> overpowering the RT priority of Task1?
> >>>
> >>>   What we desire is to loosely ensure that Task1 gets as much
> >>> bandwidth as it asks for in any iteration while Task2 and the
> >>> remaining tasks share the leftover bandwidth.
> >>>
> >>>   We are currently testing with these settings in BFQ.
> >>>   low_latency = 0 (to control the bandwidth allocation)
> >>
> >> This may be a good idea.  But, after we sort this out, you could try
> >> leaving low_latency enabled.  It should cause no harm (I'm trying to
> >> make bfq smarter and smarter).
> >>
> >>
> >>>   slice_idle = 0     (we are using a fast NVMe and if Task1 does not
> >>> have any requests and control goes to Task2, it seems to make sense we
> >>> get the control back to Task1 quickly)
> >>
> >> Unfortunately, this is not correct.  Setting slice_idle to 0 means
> >> losing completely control on I/O.  And in you case you need ...
> >> control :)
> >>
> >> So, you'd better leave slice_idle as it is.
> >>
> >> The actual problem is that, while thinking on whether it was
> >> reasonable to set slice_idle == 0, I realized that bfq is likely to fail
> >> even with slice_idle > 0.  In fact, I have not checked the respect of
> >> RT priority for probably a few years.  And I have changed lots of
> >> critical operations in these years.
> >>
> >> So, I'll wait for your feedback, which I do expect to be negative.
> >> Then, if it is actually negative, I'll work on the bug behind the
> >> failure.
> >>
> >>>   timeout_sync = 1 (Task1 does application level buffering and sends
> >>> the biggest chunk of data available (in high MB's) always)
> >>>
> >>
> >> Also for this one, things should go well even without touching it.
> >> But we will find out after discovering whether bfq is broken for your
> >> use case.
> >>
> >> Looking forward to your feedback,
> >> Paolo
> >>
> >>>   We are unable to make the leap to cpugroups at this time Paolo. Is
> >>> there anything we can tune in BFQ or change the way we generate
> >>> traffic in Task1 to ensure that Task1 gets the bandwidth it asks for?
> >>>
> >>>   A rough approximation to the Task1 and Task2 traffic we discussed
> >>> above seem to be these instantiations of dd.
> >>>   Task1: ionice -c1 -n2 /bin/dd if=/dev/zero of=/n/ssd1/ddtestRT1
> >>> bs=2M oflag=direct
> >>>   Task2: /bin/dd if=/dev/zero of=/n/ssd1/ddtestRT2   bs=2M
> >>>
> >>> Thanks again Paolo,
> >>> Madhav.
> >>>
> >>>
> >>>
> >>> On Fri, Dec 14, 2018 at 1:38 AM Paolo Valente <paolo.valente@linaro.org> wrote:
> >>>>
> >>>>
> >>>>
> >>>>> Il giorno 13 dic 2018, alle ore 21:34, Madhav Ancha <mancha@tower-research.com> ha scritto:
> >>>>>
> >>>>> In our setup, we have a task that writes to a NVMe SSD drive using the
> >>>>> page cache. (using ::write os calls). This task does application level
> >>>>> buffering and sends big (large MBs) chunks of data to ::write call.
> >>>>> Each instance of the task writes upto 10Gbps of data to the NVME SSD.
> >>>>>
> >>>>> We run two instances of this task as below.
> >>>>> Instance 1: Using ionice -c1, we run a RT IO instance of this task.
> >>>>> Instance 2: We run a normal (best-effort) IO instance of this task.
> >>>>>
> >>>>> Both the write task instances compete for NVMe bandwidth. We observe
> >>>>> that BFQ allocates equal bandwidth to both the task instances starting
> >>>>> a few seconds after they start up.
> >>>>>
> >>>>> What we expected is that Instance1 (IOPRIO_CLASS_RT scheduling class)
> >>>>> will be granted all the bandwidth it asked for while Instance2 will be
> >>>>> allowed to consume the remaining bandwidth.
> >>>>>
> >>>>> Could you please help us understand how we may be able to design to
> >>>>> get our expected behavior.
> >>>>>
> >>>>
> >>>> Hi,
> >>>> if you do async, in-memory writes, then your task instances just dirty
> >>>> vm pages.  Then different processes, the kworkers, will do the
> >>>> writeback of dirty pages asynchronously, according to the system
> >>>> writeback logic and configuration.  kworkers have their own priority,
> >>>> which is likely to be the same for each such process.  AFAICT this
> >>>> priority is not related to the priority you give to your processes.
> >>>>
> >>>> If you want to control I/O bandwidths for writes, go for direct I/O or
> >>>> use cgroups.  In case of cgroups, consider that there is still the
> >>>> oddity that bfq interface parameters are non standard.  We have
> >>>> proposed and are pushing for a solution to this problem [1].
> >>>>
> >>>> Thanks,
> >>>> Paolo
> >>>>
> >>>> [1] https://lkml.org/lkml/2018/11/19/366
> >>>>
> >>>>> Thanks
> >>>>
> >>
>
