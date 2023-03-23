Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F1DAC76196
	for <linux-block@archiver.kernel.org>; Thu, 23 Mar 2023 15:46:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231304AbjCWPqi (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 23 Mar 2023 11:46:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231183AbjCWPqh (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 23 Mar 2023 11:46:37 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 492D172B1
        for <linux-block@vger.kernel.org>; Thu, 23 Mar 2023 08:46:36 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id h8so88557205ede.8
        for <linux-block@vger.kernel.org>; Thu, 23 Mar 2023 08:46:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1679586395;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TIHMsdmfle7NugjLuFYQiNRPSMKIKN1rr5aYwFC8Kug=;
        b=NnpqzKnhqFnJAt8X+CKmsaMihz2+x72k0iSwes0Z93hrQCCmnIjykaTSGPeNQ5pFhH
         Ihrt+7xKrvcJ83OWSpM9YB5TzbUiwKAKedqLBMpOYu7VudORQSNlTrZ/sZVIouVytrmh
         8mRFg85soOgbowRyhrnI2fxNMftE7L06F70jdiEbEkgPyZZb1Gx9QEk58YI9QSl27zs1
         8nh6biODhrdfptWo85kOkztlCfF4i/Ih+hkxxrH/M9QQ9WDY2JEdbRrI10oZ7tKOl1RJ
         gthE+6pN8lZAyXxGbsbBwRN8FPh2O5R7OTCAdHVZyHYMghuAo6HWsZtEhTNsg344Cx3N
         ML3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679586395;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TIHMsdmfle7NugjLuFYQiNRPSMKIKN1rr5aYwFC8Kug=;
        b=xL8rxiMFX0L4+2DRGrgS3iLtn1Pv61dyPi/VyR41sm8jOoZskYYeuwG0+aZ/oXXxhx
         Z9fcSGk44hjsSnS+axwLE0Jbuqm+371DK4qrhwihB+CBvO04akYkQUaf1zWZKdvQwT28
         IQ8Ghvc1T4ImMgaKuye641tjyfYV4iyuhzvWhfD+kSR1Ep+rbzT+7ADrOLWxe+3Ye+ri
         tbXVJ3GX7kp2tupUuHXUkMlfl1hvLrMXySAG7+sevErKg1aiuAvivpyYJnkrqMXgFvgr
         Oo3FLa0ZDTU5s/57iuWmABSwjPyzsFnxoVF8Kp46f41Fm7OBP66McOFpJ973qVXuBBUZ
         8Vnw==
X-Gm-Message-State: AO0yUKU1cWmOwWof+uRVHFrlUAsAjqnMZL3dEryVHMlv+lKLkBVVxx2k
        98whtDv+MoQvFU/oCpWkN0OS3AJDg+6u6ugde2FCiw==
X-Google-Smtp-Source: AK7set9qvSPeDiywcKEkQlyr4PFl7U28fHGlCYplhrVevp0yQUPR3vcb0VJD03YLXfnBSRIguQiNqhK55JgXWj1sgmw=
X-Received: by 2002:a17:906:34cd:b0:8e5:411d:4d09 with SMTP id
 h13-20020a17090634cd00b008e5411d4d09mr5178971ejb.15.1679586394636; Thu, 23
 Mar 2023 08:46:34 -0700 (PDT)
MIME-Version: 1.0
References: <20230323040037.2389095-1-yosryahmed@google.com>
 <20230323040037.2389095-4-yosryahmed@google.com> <20230323154304.GA739026@cmpxchg.org>
In-Reply-To: <20230323154304.GA739026@cmpxchg.org>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Thu, 23 Mar 2023 08:45:58 -0700
Message-ID: <CAJD7tkYkVp31J-NRsJw2Hg0EPveyfr9KcA0OSEaMea0VchjqHw@mail.gmail.com>
Subject: Re: [RFC PATCH 3/7] cgroup: rstat: remove cgroup_rstat_flush_irqsafe()
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Tejun Heo <tj@kernel.org>, Josef Bacik <josef@toxicpanda.com>,
        Jens Axboe <axboe@kernel.dk>,
        Zefan Li <lizefan.x@bytedance.com>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <muchun.song@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vasily Averin <vasily.averin@linux.dev>,
        cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Mar 23, 2023 at 8:43=E2=80=AFAM Johannes Weiner <hannes@cmpxchg.org=
> wrote:
>
> On Thu, Mar 23, 2023 at 04:00:33AM +0000, Yosry Ahmed wrote:
> > The naming of cgroup_rstat_flush_irqsafe() can be confusing.
> > It can read like "irqsave", which means that it disables
> > interrupts throughout, but it actually doesn't. It is just "safe" to
> > call from contexts with interrupts disabled.
> >
> > Furthermore, this is only used today by mem_cgroup_flush_stats(), which
> > will be changed by a later patch to optionally allow sleeping. Simplify
> > the code and make it easier to reason about by instead passing in an
> > explicit @may_sleep argument to cgroup_rstat_flush(), which gets passed
> > directly to cgroup_rstat_flush_locked().
> >
> > Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
> > ---
> >  block/blk-cgroup.c     |  2 +-
> >  include/linux/cgroup.h |  3 +--
> >  kernel/cgroup/cgroup.c |  4 ++--
> >  kernel/cgroup/rstat.c  | 24 +++++-------------------
> >  mm/memcontrol.c        |  6 +++---
> >  5 files changed, 12 insertions(+), 27 deletions(-)
> >
> > diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
> > index bd50b55bdb61..3fe313ce5e6b 100644
> > --- a/block/blk-cgroup.c
> > +++ b/block/blk-cgroup.c
> > @@ -1043,7 +1043,7 @@ static int blkcg_print_stat(struct seq_file *sf, =
void *v)
> >       if (!seq_css(sf)->parent)
> >               blkcg_fill_root_iostats();
> >       else
> > -             cgroup_rstat_flush(blkcg->css.cgroup);
> > +             cgroup_rstat_flush(blkcg->css.cgroup, true);
> >
> >       rcu_read_lock();
> >       hlist_for_each_entry_rcu(blkg, &blkcg->blkg_list, blkcg_node) {
> > diff --git a/include/linux/cgroup.h b/include/linux/cgroup.h
> > index 3410aecffdb4..743c345b6a3f 100644
> > --- a/include/linux/cgroup.h
> > +++ b/include/linux/cgroup.h
> > @@ -691,8 +691,7 @@ static inline void cgroup_path_from_kernfs_id(u64 i=
d, char *buf, size_t buflen)
> >   * cgroup scalable recursive statistics.
> >   */
> >  void cgroup_rstat_updated(struct cgroup *cgrp, int cpu);
> > -void cgroup_rstat_flush(struct cgroup *cgrp);
> > -void cgroup_rstat_flush_irqsafe(struct cgroup *cgrp);
> > +void cgroup_rstat_flush(struct cgroup *cgrp, bool may_sleep);
> >  void cgroup_rstat_flush_hold(struct cgroup *cgrp);
> >  void cgroup_rstat_flush_release(void);
> >
> > diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
> > index 935e8121b21e..58df0fc379f6 100644
> > --- a/kernel/cgroup/cgroup.c
> > +++ b/kernel/cgroup/cgroup.c
> > @@ -5393,7 +5393,7 @@ static void css_release_work_fn(struct work_struc=
t *work)
> >       if (ss) {
> >               /* css release path */
> >               if (!list_empty(&css->rstat_css_node)) {
> > -                     cgroup_rstat_flush(cgrp);
> > +                     cgroup_rstat_flush(cgrp, true);
> >                       list_del_rcu(&css->rstat_css_node);
> >               }
> >
> > @@ -5406,7 +5406,7 @@ static void css_release_work_fn(struct work_struc=
t *work)
> >               /* cgroup release path */
> >               TRACE_CGROUP_PATH(release, cgrp);
> >
> > -             cgroup_rstat_flush(cgrp);
> > +             cgroup_rstat_flush(cgrp, true);
>
> This is an anti-pattern, please don't do this. Naked bool arguments
> are a pain to comprehend at the callsite and an easy vector for bugs.
>
> cgroup_rstat_flush_atomic() would be a better name for, well, atomic
> callsites.

Thanks for pointing this out. I will rename it to
cgroup_rstat_flush_atomic() in upcoming versions instead. I will also
do the same for mem_cgroup_flush_stats() as I introduce a similar
boolean argument for it in the following patch.

>
> > diff --git a/kernel/cgroup/rstat.c b/kernel/cgroup/rstat.c
> > index af11e28bd055..fe8690bb1e1c 100644
> > --- a/kernel/cgroup/rstat.c
> > +++ b/kernel/cgroup/rstat.c
> > @@ -243,30 +243,16 @@ static bool should_skip_flush(void)
> >   * This function is safe to call from contexts that disable interrupts=
, but
> >   * @may_sleep must be set to false, otherwise the function may block.
> >   */
> > -__bpf_kfunc void cgroup_rstat_flush(struct cgroup *cgrp)
> > +__bpf_kfunc void cgroup_rstat_flush(struct cgroup *cgrp, bool may_slee=
p)
> >  {
> >       if (should_skip_flush())
> >               return;
> >
> > -     might_sleep();
> > -     spin_lock(&cgroup_rstat_lock);
> > -     cgroup_rstat_flush_locked(cgrp, true);
> > -     spin_unlock(&cgroup_rstat_lock);
> > -}
> > -
> > -/**
> > - * cgroup_rstat_flush_irqsafe - irqsafe version of cgroup_rstat_flush(=
)
> > - * @cgrp: target cgroup
> > - *
> > - * This function can be called from any context.
> > - */
> > -void cgroup_rstat_flush_irqsafe(struct cgroup *cgrp)
> > -{
> > -     if (should_skip_flush())
> > -             return;
> > +     if (may_sleep)
> > +             might_sleep();
>
> might_sleep_if()

Thanks for pointing this out. I don't think it will be needed if we
keep cgroup_rstat_flush_irqsafe() and only rename it to
cgroup_rstat_flush_atomic(), but it is useful to know that it exists
for future reference.
