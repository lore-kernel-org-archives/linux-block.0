Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E350C77B73
	for <linux-block@archiver.kernel.org>; Thu, 25 May 2023 02:56:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229459AbjEYC4m (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 24 May 2023 22:56:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjEYC4l (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 24 May 2023 22:56:41 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8191A12F
        for <linux-block@vger.kernel.org>; Wed, 24 May 2023 19:56:37 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-96ff9c0a103so10250666b.0
        for <linux-block@vger.kernel.org>; Wed, 24 May 2023 19:56:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684983396; x=1687575396;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hHQ78Ur24GaVrBbvMykv1QqSrNiquzMfv+06ANc/YIs=;
        b=olYhiy4OtaRDJukEv4sPvMn/9kXQ+C3ClqXwQfgoWHQqzCa+w+JN+E7HeT50SF6HKj
         3Qtp4kaoslUigOq1TF2ciDxh2xpECMjWc8//VDTuy3bHRi6S6bZ0ldy+CvW5Tazl1y3w
         8ctKcxyGg6BAoiSvWO9P/+9x450JwUH9YCLUaBr1wbKaKVl0t5WQyB4vyHuRW22aN2m4
         UXsWxkEp8PM6r/doB77u89VEOcSdEbYU77NLR+mSqZfFpFM6fF4GTJ6pNWd7EqNK2Kw3
         R7LSX4MZVFksIXtmU0YvF/px9/+p52QN+19te5oDj99pE12ZheR3scyQVqdMiZ4gOPME
         JyVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684983396; x=1687575396;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hHQ78Ur24GaVrBbvMykv1QqSrNiquzMfv+06ANc/YIs=;
        b=if1UcIHFO7o7yVTg0mjBqur7J5KW+DeXffBT3G7YncSjX+GOAKIe1mC/SLu0VYQdlq
         M9ixlfe3YSBUaphTPEbo6cDAoYkKOXNc06AbkZPZXo6+DKjpAd8K1ZZtfJO6L6HklKIw
         aLCBSnQaCxYS6U0B0EguaDm6wT9lpuqWtza7lteF1D0lidXsSjHSs8j5SDo7r1D/bsTw
         UQE6FhEdybdX6hqOWL02NOqk1fmfbkBZfvaZc9Qh36C0k3pLDyB4r3fwRAbswX2cZgGV
         2FgPwduAAYClG9LQExvrppWq/gW/qct/kGFKGlU5INFmQ57J52anD2lMlpMu+WtN07UW
         YMeg==
X-Gm-Message-State: AC+VfDwE4mOj1+udFkv/t9EqB1tHRtrjdrT9yV8UOEv5S8Q0nFGhaJFK
        Eh6FbDuoUMSHMwfaCiNND041uetF9wq2IdZRIJnr/g==
X-Google-Smtp-Source: ACHHUZ4xaJTQxQg4URyJt+L7pyIF4CE634ZI4a02Z0u8pgx5KLAq5kdVtwPMT7gjBKxlv0dp9dwiHT7uyd2kQoaerQI=
X-Received: by 2002:a17:907:9814:b0:94f:395b:df1b with SMTP id
 ji20-20020a170907981400b0094f395bdf1bmr108241ejc.21.1684983395744; Wed, 24
 May 2023 19:56:35 -0700 (PDT)
MIME-Version: 1.0
References: <20230524035150.727407-1-ming.lei@redhat.com> <f2c10b18-8d83-91a5-bf22-03894bf3c910@redhat.com>
 <ZG2R+jYuAZMpx49d@ovpn-8-17.pek2.redhat.com> <76a863b4-112e-82ae-59e4-6326fff48ffc@redhat.com>
 <bde4174a-ace4-6e2a-6536-855fb18d0890@redhat.com> <ZG7CJtN7ATaYZ5Ao@ovpn-8-21.pek2.redhat.com>
 <7ffbb748-46e3-44b2-388d-9199f47dc9a7@redhat.com>
In-Reply-To: <7ffbb748-46e3-44b2-388d-9199f47dc9a7@redhat.com>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Wed, 24 May 2023 19:55:59 -0700
Message-ID: <CAJD7tkYfwVSNrTibnv5BpyAfbyY0dnK0Cp-HQK_-2nxHmveAxw@mail.gmail.com>
Subject: Re: [PATCH V2] blk-cgroup: Flush stats before releasing blkcg_gq
To:     Waiman Long <longman@redhat.com>
Cc:     Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org, Tejun Heo <tj@kernel.org>,
        mkoutny@suse.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, May 24, 2023 at 7:50=E2=80=AFPM Waiman Long <longman@redhat.com> wr=
ote:
>
> On 5/24/23 22:04, Ming Lei wrote:
> > On Wed, May 24, 2023 at 01:28:41PM -0400, Waiman Long wrote:
> >> On 5/24/23 11:43, Waiman Long wrote:
> >>> On 5/24/23 00:26, Ming Lei wrote:
> >>>> On Wed, May 24, 2023 at 12:19:57AM -0400, Waiman Long wrote:
> >>>>> On 5/23/23 23:51, Ming Lei wrote:
> >>>>>> As noted by Michal, the blkg_iostat_set's in the lockless list hol=
d
> >>>>>> reference to blkg's to protect against their removal. Those blkg's
> >>>>>> hold reference to blkcg. When a cgroup is being destroyed,
> >>>>>> cgroup_rstat_flush() is only called at css_release_work_fn() which
> >>>>>> is called when the blkcg reference count reaches 0. This circular
> >>>>>> dependency will prevent blkcg and some blkgs from being freed afte=
r
> >>>>>> they are made offline.
> >>>>>>
> >>>>>> It is less a problem if the cgroup to be destroyed also has other
> >>>>>> controllers like memory that will call cgroup_rstat_flush() which =
will
> >>>>>> clean up the reference count. If block is the only
> >>>>>> controller that uses
> >>>>>> rstat, these offline blkcg and blkgs may never be freed leaking mo=
re
> >>>>>> and more memory over time.
> >>>>>>
> >>>>>> To prevent this potential memory leak:
> >>>>>>
> >>>>>> - flush blkcg per-cpu stats list in __blkg_release(), when no new =
stat
> >>>>>> can be added
> >>>>>>
> >>>>>> - don't grab bio->bi_blkg reference when adding the stats into blk=
cg's
> >>>>>> per-cpu stat list since all stats are guaranteed to be consumed be=
fore
> >>>>>> releasing blkg instance, and grabbing blkg reference for stats was=
 the
> >>>>>> most fragile part of original patch
> >>>>>>
> >>>>>> Based on Waiman's patch:
> >>>>>>
> >>>>>> https://lore.kernel.org/linux-block/20221215033132.230023-3-longma=
n@redhat.com/
> >>>>>>
> >>>>>>
> >>>>>> Fixes: 3b8cc6298724 ("blk-cgroup: Optimize blkcg_rstat_flush()")
> >>>>>> Cc: Waiman Long <longman@redhat.com>
> >>>>>> Cc: Tejun Heo <tj@kernel.org>
> >>>>>> Cc: mkoutny@suse.com
> >>>>>> Cc: Yosry Ahmed <yosryahmed@google.com>
> >>>>>> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> >>>>>> ---
> >>>>>> V2:
> >>>>>>      - remove kernel/cgroup change, and call blkcg_rstat_flush()
> >>>>>>      to flush stat directly
> >>>>>>
> >>>>>>     block/blk-cgroup.c | 29 +++++++++++++++++++++--------
> >>>>>>     1 file changed, 21 insertions(+), 8 deletions(-)
> >>>>>>
> >>>>>> diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
> >>>>>> index 0ce64dd73cfe..ed0eb8896972 100644
> >>>>>> --- a/block/blk-cgroup.c
> >>>>>> +++ b/block/blk-cgroup.c
> >>>>>> @@ -34,6 +34,8 @@
> >>>>>>     #include "blk-ioprio.h"
> >>>>>>     #include "blk-throttle.h"
> >>>>>> +static void __blkcg_rstat_flush(struct blkcg *blkcg, int cpu);
> >>>>>> +
> >>>>>>     /*
> >>>>>>      * blkcg_pol_mutex protects blkcg_policy[] and policy
> >>>>>> [de]activation.
> >>>>>>      * blkcg_pol_register_mutex nests outside of it and
> >>>>>> synchronizes entire
> >>>>>> @@ -163,10 +165,21 @@ static void blkg_free(struct blkcg_gq *blkg)
> >>>>>>     static void __blkg_release(struct rcu_head *rcu)
> >>>>>>     {
> >>>>>>         struct blkcg_gq *blkg =3D container_of(rcu, struct
> >>>>>> blkcg_gq, rcu_head);
> >>>>>> +    struct blkcg *blkcg =3D blkg->blkcg;
> >>>>>> +    int cpu;
> >>>>>>     #ifdef CONFIG_BLK_CGROUP_PUNT_BIO
> >>>>>>         WARN_ON(!bio_list_empty(&blkg->async_bios));
> >>>>>>     #endif
> >>>>>> +    /*
> >>>>>> +     * Flush all the non-empty percpu lockless lists before relea=
sing
> >>>>>> +     * us, given these stat belongs to us.
> >>>>>> +     *
> >>>>>> +     * cgroup locks aren't needed here since __blkcg_rstat_flush =
just
> >>>>>> +     * propagates delta into blkg parent, which is live now.
> >>>>>> +     */
> >>>>>> +    for_each_possible_cpu(cpu)
> >>>>>> +        __blkcg_rstat_flush(blkcg, cpu);
> >>>>>>         /* release the blkcg and parent blkg refs this blkg
> >>>>>> has been holding */
> >>>>>>         css_put(&blkg->blkcg->css);
> >>>>>> @@ -951,17 +964,12 @@ static void blkcg_iostat_update(struct
> >>>>>> blkcg_gq *blkg, struct blkg_iostat *cur,
> >>>>>> u64_stats_update_end_irqrestore(&blkg->iostat.sync, flags);
> >>>>>>     }
> >>>>>> -static void blkcg_rstat_flush(struct cgroup_subsys_state
> >>>>>> *css, int cpu)
> >>>>>> +static void __blkcg_rstat_flush(struct blkcg *blkcg, int cpu)
> >>>>>>     {
> >>>>>> -    struct blkcg *blkcg =3D css_to_blkcg(css);
> >>>>>>         struct llist_head *lhead =3D per_cpu_ptr(blkcg->lhead, cpu=
);
> >>>>>>         struct llist_node *lnode;
> >>>>>>         struct blkg_iostat_set *bisc, *next_bisc;
> >>>>>> -    /* Root-level stats are sourced from system-wide IO stats */
> >>>>>> -    if (!cgroup_parent(css->cgroup))
> >>>>>> -        return;
> >>>>>> -
> >>>>>>         rcu_read_lock();
> >>>>>>         lnode =3D llist_del_all(lhead);
> >>>>>> @@ -991,13 +999,19 @@ static void blkcg_rstat_flush(struct
> >>>>>> cgroup_subsys_state *css, int cpu)
> >>>>>>             if (parent && parent->parent)
> >>>>>>                 blkcg_iostat_update(parent, &blkg->iostat.cur,
> >>>>>>                             &blkg->iostat.last);
> >>>>>> -        percpu_ref_put(&blkg->refcnt);
> >>>>>>         }
> >>>>>>     out:
> >>>>>>         rcu_read_unlock();
> >>>>>>     }
> >>>>>> +static void blkcg_rstat_flush(struct cgroup_subsys_state
> >>>>>> *css, int cpu)
> >>>>>> +{
> >>>>>> +    /* Root-level stats are sourced from system-wide IO stats */
> >>>>>> +    if (cgroup_parent(css->cgroup))
> >>>>>> +        __blkcg_rstat_flush(css_to_blkcg(css), cpu);
> >>>>>> +}
> >>>>>> +
> >>>>> I think it may not safe to call __blkcg_rstat_flus() directly
> >>>>> without taking
> >>>>> the cgroup_rstat_cpu_lock. That is why I added a helper to
> >>>>> kernel/cgroup/rstat.c in my patch to meet the locking requirement.
> >>>> All stats are removed from llist_del_all(), and the local list is
> >>>> iterated, then each blkg & its parent is touched in
> >>>> __blkcg_rstat_flus(), so
> >>>> can you explain it a bit why cgroup locks are needed? For protecting
> >>>> what?
> >>> You are right. The llist_del_all() call in blkcg_rstat_flush() is
> >>> atomic, so it is safe for concurrent execution which is what the
> >>> cgroup_rstat_cpu_lock protects against. That may not be the case for
> >>> rstat callbacks of other controllers. So I will suggest you to add a
> >>> comment to clarify that point. Other than that, you patch looks good =
to
> >>> me.
> >>>
> >>> Reviewed: Waiman Long <longman@redhat.com>
> >> After some more thought, I need to retract my reviewed-by tag for now.=
 There
> >> is a slight possibility that blkcg_iostat_update() in blkcg_rstat_flus=
h()
> >> can happen concurrently which will corrupt the sequence count.
> > llist_del_all() moves all 'bis' into one local list, and bis is one per=
cpu
> > variable of blkg, so in theory same bis won't be flushed at the same
> > time. And one bis should be touched in just one of stat flush code path
> > because of llist_del_all().
> >
> > So 'bis' still can be thought as being flushed in serialized way.
> >
> > However, blk_cgroup_bio_start() runs concurrently with blkcg_rstat_flus=
h(),
> > so once bis->lqueued is cleared in blkcg_rstat_flush(), this same bis
> > could be added to the percpu llist and __blkcg_rstat_flush() from blkg_=
release()
> > follows. This should be the only chance for concurrent stats update.
>
> That is why I have in mind. A __blkcg_rstat_flush() can be from
> blkg_release() and another one from the regular cgroup_rstat_flush*().
>
>
> >
> > But, blkg_release() is run in RCU callback, so the previous flush has
> > been done, but new flush can come, and other blkg's stat could be added
> > with same story above.
> >
> >> One way to
> >> avoid that is to synchronize it by cgroup_rstat_cpu_lock. Another way =
is to
> >> use the bisc->lqueued for synchronization.
> > I'd avoid the external cgroup lock here.
> >
> >> In that case, you need to move
> >> WRITE_ONCE(bisc->lqueued, false) in blkcg_rstat_flush() to the end aft=
er all
> >> the  blkcg_iostat_update() call with smp_store_release() and replace t=
he
> >> READ_ONCE(bis->lqueued) check in blk_cgroup_bio_start() with
> >> smp_load_acquire().
> > This way looks doable, but I guess it still can't avoid concurrent upda=
te on parent
> > stat, such as when  __blkcg_rstat_flush() from blkg_release() is
> > in-progress, another sibling blkg's bis is added, meantime
> > blkcg_rstat_flush() is called.
> I realized that the use of cgroup_rstat_cpu_lock or the alternative was
> not safe enough for preventing concurrent parent blkg rstat update.
> >
> > Another way is to add blkcg->stat_lock for covering __blkcg_rstat_flush=
(), what
> > do you think of this way?
>
> I am thinking of adding a raw spinlock into blkg and take it when doing
> blkcg_iostat_update(). This can guarantee no concurrent update to rstat
> data. It has to be a raw spinlock as it will be under the
> cgroup_rstat_cpu_lock raw spinlock.

Hi Waiman,

I don't have context about blkcg, but isn't this exactly what
cgroup_rstat_lock does? Is it too expensive to just call
cgroup_rstat_flush () here?

>
> The use of u64_stats_fetch_begin/u64_stats_fetch_retry in retrieving the
> rstat data from bisc can happen concurrently with update without further
> synchronization. However, there can be at most one update at any time.
>
> Cheers,
> Longman
>
> >
> >
> > Thanks,
> > Ming
> >
>
