Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDA68C433EF
	for <linux-block@archiver.kernel.org>; Fri, 21 Jan 2022 10:58:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380073AbiAUK6k (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 21 Jan 2022 05:58:40 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:52680 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240886AbiAUK6a (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 21 Jan 2022 05:58:30 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 9CF8E218F8;
        Fri, 21 Jan 2022 10:58:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1642762709; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GGsUQ/hPSyiyOJeoyLoLjFLV8ZyMIU42DdmYSePwxYc=;
        b=F8uxibmhlz6wGgIzCoiDw0rWzKulGytr1dSxMIhGQMv2vxRDIS3Gel686tqM/c2LxTjYUG
        k/Shk0hcMXCCACR9J3oXbVq/jEBSB338KgVyLXOHZ4n5+5zkICMN+7O1Fn4CuuA87PRNgL
        mjjwFK4MPRbeCNsSSYyhA9GbqyElP9A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1642762709;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GGsUQ/hPSyiyOJeoyLoLjFLV8ZyMIU42DdmYSePwxYc=;
        b=kBdKwYnYpcF9b6viwuK6ZkDQya2JIFv/U6Zms5ViXDLF3jEa9Xlljz3/BGMlH+/jNRUVtL
        VUdIArBc9DZES2Ag==
Received: from quack3.suse.cz (unknown [10.100.200.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 8D795A3BA2;
        Fri, 21 Jan 2022 10:58:29 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 618C3A05E4; Fri, 21 Jan 2022 11:58:29 +0100 (CET)
Date:   Fri, 21 Jan 2022 11:58:29 +0100
From:   Jan Kara <jack@suse.cz>
To:     "yukuai (C)" <yukuai3@huawei.com>
Cc:     Jan Kara <jack@suse.cz>, linux-block@vger.kernel.org,
        Paolo Valente <paolo.valente@linaro.org>,
        Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH 0/4 v4] bfq: Avoid use-after-free when moving processes
 between cgroups
Message-ID: <20220121105829.sjpbhj77rdhseat5@quack3.lan>
References: <20220114164215.28972-1-jack@suse.cz>
 <9ee09c05-13c4-ec9d-5859-ed91dea39e13@huawei.com>
 <20220117114510.x6yrhx4nlncso3vd@quack3.lan>
 <f6baffae-7105-556c-3785-7b4fed2bf39c@huawei.com>
 <20220117154632.5r6os2wbwf6xiqhc@quack3.lan>
 <2d9fbf51-a208-4d18-b8cb-1524ca4b80ba@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2d9fbf51-a208-4d18-b8cb-1524ca4b80ba@huawei.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue 18-01-22 11:00:43, yukuai (C) wrote:
> 在 2022/01/17 23:46, Jan Kara 写道:
> > On Mon 17-01-22 22:16:23, yukuai (C) wrote:
> > > 在 2022/01/17 19:45, Jan Kara 写道:
> > > > On Mon 17-01-22 16:13:09, yukuai (C) wrote:
> > > > > 在 2022/01/15 1:01, Jan Kara 写道:
> > > > > > Hello,
> > > > > > 
> > > > > > here is the third version of my patches to fix use-after-free issues in BFQ
> > > > > > when processes with merged queues get moved to different cgroups. The patches
> > > > > > have survived some beating in my test VM, but so far I fail to reproduce the
> > > > > > original KASAN reports so testing from people who can reproduce them is most
> > > > > > welcome. Kuai, can you please give these patches a run in your setup? Thanks
> > > > > > a lot for your help with fixing this!
> > > > > > 
> > > > > > Changes since v3:
> > > > > > * Changed handling of bfq group move to handle the case when target of the
> > > > > >      merge has moved.
> > > > > Hi, Jan
> > > > > 
> > > > > The problem can still be reporduced...
> > > > 
> > > > Drat. Thanks for testing.
> > > > 
> > > > > Do you implement this in patch 4? If so, I don't understand how you
> > > > > chieve this.
> > > > 
> > > > Yes, patch 4 should be handling this.
> > > > 
> > > > > For example: 3 bfqqs were merged:
> > > > > q1->q2->q3
> > > > > 
> > > > > If __bfq_bic_change_cgroup() is called with q2, the problem can be
> > > > > fixed. However, if __bfq_bic_change_cgroup() is called with q3, can
> > > > > the problem be fixed?
> > > > 
> > > > Maybe I'm missing something so let's walk through your example where the
> > > > bio is submitted for a task attached to q3. Bio is submitted,
> > > > __bfq_bic_change_cgroup() is called with sync_bfqq == q3, the loop
> > > > 
> > > >                  while (sync_bfqq->new_bfqq)
> > > >                          sync_bfqq = sync_bfqq->new_bfqq;
> > > > 
> > > > won't do anything. Then we check:
> > > > 
> > > >                  if (sync_bfqq->entity.sched_data != &bfqg->sched_data) {
> > > > 
> > > > This should be true because the task got moved and the bio is thus now
> > > > submitted for a different cgroup. Then we get to the condition:
> > > > 
> > > >                          if (orig_bfqq != sync_bfqq || bfq_bfqq_coop(sync_bfqq))
> > > > 
> > > > orig_bfqq == sync_bfqq so that won't help but the idea was that
> > > > bfq_bfqq_coop() would trigger in this case so we detach the process from q3
> > > > (through bic_set_bfqq(bic, NULL, 1)) and create new queue in the right
> > > > cgroup. Eventually, all the processes would detach from q3 and it would get
> > > > destroyed. So why do you think this scheme will not work?
> > > 
> > > Hi, Jan
> > > 
> > > I repoduced again with some debug info:
> > 
> > Thanks for your help with debugging!
> > 
> > > diff --git a/block/bfq-cgroup.c b/block/bfq-cgroup.c
> > > index f6f5f156b9f2..f62ebc4bbe56 100644
> > > --- a/block/bfq-cgroup.c
> > > +++ b/block/bfq-cgroup.c
> > > @@ -732,8 +732,11 @@ static struct bfq_group *__bfq_bic_change_cgroup(struct
> > > bfq_data *bfqd,
> > >                  struct bfq_queue *orig_bfqq = sync_bfqq;
> > > 
> > >                  /* Traverse the merge chain to bfqq we will be using */
> > > -               while (sync_bfqq->new_bfqq)
> > > +               while (sync_bfqq->new_bfqq) {
> > > +                       printk("%s: bfqq %px, new_bfqq %px\n", __func__,
> > > +                                       sync_bfqq, sync_bfqq->new_bfqq);
> > >                          sync_bfqq = sync_bfqq->new_bfqq;
> > > +               }
> > >                  /*
> > >                   * Target bfqq got moved to a different cgroup or this
> > > process
> > >                   * started submitting bios for different cgroup?
> > > @@ -756,6 +759,8 @@ static struct bfq_group *__bfq_bic_change_cgroup(struct
> > > bfq_data *bfqd,
> > >                                  bic_set_bfqq(bic, NULL, 1);
> > 
> > Maybe it would be nice to add a debug message here, saying we are detaching
> > the process from orig_bfqq. Just that we know that this branch executed.
> > 
> > >                                  return bfqg;
> > >                          }
> > > +                       printk("%s: bfqq %px move from %px to %px\n",
> > > __func__,
> > > +                               sync_bfqq, bfqq_group(sync_bfqq), bfqg);
> > >                          /* We are the only user of this bfqq, just move it
> > > */
> > >                          bfq_bfqq_move(bfqd, sync_bfqq, bfqg);
> > 
> > ...
> > 
> > > -       if (bfqq->new_bfqq)
> > > +       if (bfqq->new_bfqq) {
> > > +               if (bfqq->entity.parent != bfqq->new_bfqq->entity.parent) {
> > > +                       printk("%s: bfqq %px(%px) new_bfqq %px(%px)\n",
> > > __func__,
> > > +                               bfqq, bfqq_group(bfqq), bfqq->new_bfqq,
> > > +                               bfqq_group(bfqq->new_bfqq));
> > > +                       BUG_ON(1);
> > 
> > OK, so I can see why this triggered. We have:
> > 
> > Set new_bfqq for bfqq *eec0:
> > [   50.207263] bfq_setup_merge: set bfqq ffff88816b16eec0 new_bfqq ffff8881133e1340 parent ffff88814380b000/ffff88814380b000
> > Move new_bfqq to a root cgroup:
> > [   50.485933] bfq_reparent_leaf_entity: bfqq ffff8881133e1340 move from ffff88814380b000 to ffff88810b1f1000
> > Submit bio for root cgroup through *eec0:
> > [   50.519910] __bfq_bic_change_cgroup: bfqq ffff88816b16eec0, new_bfqq ffff8881133e1340
> > __bfq_bic_change_cgroup() does nothing as the bio is for the cgroup to which
> > target queue belongs.
> > [   50.520640] bfq_setup_cooperator: bfqq ffff88816b16eec0(ffff88814380b000) new_bfqq ffff8881133e1340(ffff88810b1f1000)
> > The BUG_ON trips.
> > 
> > So at this moment the BUG_ON was just too eager to trigger as we would be
> > submitting IO to a bfq queue belonging to an appropriate cgroup. But I
> > guess it does not make sence to keep unfinished merges over cgroup
> > migration and __bfq_bic_change_cgroup() should have detached task from its
> > bfqq anyway. Can you please try running with a new version of patch 4 which
> > is attached? And perhaps with your debug patch as well... Thanks!
> 
> Hi
> 
> I reporduced again with the following:
> 
> diff --git a/block/bfq-cgroup.c b/block/bfq-cgroup.c
> index f6f5f156b9f2..1afb9127ca84 100644
> --- a/block/bfq-cgroup.c
> +++ b/block/bfq-cgroup.c
> @@ -732,8 +732,11 @@ static struct bfq_group *__bfq_bic_change_cgroup(struct
> bfq_data *bfqd,
>                 struct bfq_queue *orig_bfqq = sync_bfqq;
> 
>                 /* Traverse the merge chain to bfqq we will be using */
> -               while (sync_bfqq->new_bfqq)
> +               if (sync_bfqq->new_bfqq) {
> +                       printk("%s: bfqq %px, new_bfqq %px\n", __func__,
> +                                       sync_bfqq, sync_bfqq->new_bfqq);
>                         sync_bfqq = sync_bfqq->new_bfqq;
> +               }
>                 /*
>                  * Target bfqq got moved to a different cgroup or this
> process
>                  * started submitting bios for different cgroup?
> @@ -754,8 +757,11 @@ static struct bfq_group *__bfq_bic_change_cgroup(struct
> bfq_data *bfqd,
>                                 bfq_put_cooperator(orig_bfqq);
>                                 bfq_release_process_ref(bfqd, orig_bfqq);
>                                 bic_set_bfqq(bic, NULL, 1);
> +                               printk("%s: bfqq %px detached\n", __func__,
> orig_bfqq);
>                                 return bfqg;
>                         }
> +                       printk("%s: bfqq %px move from %px to %px\n",
> __func__,
> +                               sync_bfqq, bfqq_group(sync_bfqq), bfqg);
>                         /* We are the only user of this bfqq, just move it
> */
>                         bfq_bfqq_move(bfqd, sync_bfqq, bfqg);
>                 }
> @@ -875,7 +881,10 @@ static void bfq_reparent_leaf_entity(struct bfq_data
> *bfqd,
>         }
> 
>         bfqq = bfq_entity_to_bfqq(child_entity);
> +       printk("%s: bfqq %px move from %px to %px\n", __func__,
> +                       bfqq, bfqq_group(bfqq), bfqd->root_group);
>         bfq_bfqq_move(bfqd, bfqq, bfqd->root_group);
> +
>  }
> 
>  /**
> diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
> index 07be51bc229b..c6b439df28ad 100644
> --- a/block/bfq-iosched.c
> +++ b/block/bfq-iosched.c
> @@ -2797,6 +2797,8 @@ bfq_setup_merge(struct bfq_queue *bfqq, struct
> bfq_queue *new_bfqq)
>          * are likely to increase the throughput.
>          */
>         bfqq->new_bfqq = new_bfqq;
> +       printk("%s: set bfqq %px new_bfqq %px parent %px/%px \n", __func__,
> bfqq,
> +                       new_bfqq, bfqq_group(bfqq), bfqq_group(new_bfqq));
>         new_bfqq->ref += process_refs;
>         return new_bfqq;
>  }
> @@ -2963,8 +2965,16 @@ bfq_setup_cooperator(struct bfq_data *bfqd, struct
> bfq_queue *bfqq,
>         if (bfq_too_late_for_merging(bfqq))
>                 return NULL;
> 
> -       if (bfqq->new_bfqq)
> +       if (bfqq->new_bfqq) {
> +               if (bfqq->entity.parent != bfqq->new_bfqq->entity.parent &&
> +                   bfqq_group(bfqq->new_bfqq) != bfqd->root_group) {
> +                       printk("%s: bfqq %px(%px) new_bfqq %px(%px)\n",
> __func__,
> +                               bfqq, bfqq_group(bfqq), bfqq->new_bfqq,
> +                               bfqq_group(bfqq->new_bfqq));
> +                       BUG_ON(1);
> +               }
>                 return bfqq->new_bfqq;
> +       }
> 
>         if (!io_struct || unlikely(bfqq == &bfqd->oom_bfqq))
>                 return NULL;
> @@ -6928,6 +6938,8 @@ static void __bfq_put_async_bfqq(struct bfq_data
> *bfqd,
> 
>         bfq_log(bfqd, "put_async_bfqq: %p", bfqq);
>         if (bfqq) {
> +               printk("%s: bfqq %px move from %px to %px\n", __func__,
> +                               bfqq, bfqq_group(bfqq), bfqd->root_group);
>                 bfq_bfqq_move(bfqd, bfqq, bfqd->root_group);
> 
>                 bfq_log_bfqq(bfqd, bfqq, "put_async_bfqq: putting %p, %d",

This was not exactly what I wanted but now I've realized I've sent you a
wrong patch. My fault and thanks for testing!

> The result is attached, one thing that is weird: the uaf is triggered
> before the BUG_ON.

Yes, that is interesting. The BUG_ON at the end indeed shows a case where
there was a longer chain of merges bfq_pd_offline() moved some of the
queues from the merge chain to the root cgroup but not all. The state was

ffff888169d57440 -> ffff88810b593180 -> ffff88812cfc9340
(root)              (root)              (orig cgroup)

Then something strange happened:

[   92.692545] __bfq_bic_change_cgroup: bfqq ffff888169d57440, new_bfqq ffff88810b593180
[   92.693374] bfq_setup_cooperator: bfqq ffff88810b593180(ffff88816d167000) new_bfqq ffff88812cfc9340(ffff88817ab36000)

We can see __bfq_bic_change_cgroup() got called for queue ffff888169d57440
but then not for ffff88810b593180 while bfq_setup_cooperator() got called
for ffff88810b593180. Not sure what happened inside the BFQ. Anyway, the
presence of these merge chains and the fact that bfq_pd_offline() can move
arbitrary subset to different cgroup shows that we should be more careful.
I've changed __bfq_bic_change_cgroup() to check the whole merge chain and
detach from bfqq if anything does not match. I'll send it as a new
revision. Can you please test it? Thanks!

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
