Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2102AC6FD1D
	for <linux-block@archiver.kernel.org>; Mon, 27 Mar 2023 23:24:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229789AbjC0XYN (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 27 Mar 2023 19:24:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229575AbjC0XXx (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 27 Mar 2023 19:23:53 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24EF210F
        for <linux-block@vger.kernel.org>; Mon, 27 Mar 2023 16:23:52 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id x3so42586180edb.10
        for <linux-block@vger.kernel.org>; Mon, 27 Mar 2023 16:23:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1679959430;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2sthNEXRrhXPflNLlQaZ/R6XYUJ5sFT3zFaO3Oj8iQU=;
        b=W+Tv96+pFUlhT5JOOrNtcy47rsqxINYX5Iydl2ZhOjD2ZICVF/srMD4pjGFArnDzTC
         kPELiLr2qm8nbVs2H3GBDurYFGHHHR4YppJMTiQgYYWDafqzi7oz9Du7VQA6lba1jKXq
         dwn2vZhC36MqALm/QJpx59PUuvFUdHNBjYQvAl4nTFdcu6Cb2GfBntbxfBbl6jFLwYkS
         xFSElExlWZVdm5acLMkTXu9+vioAED99Ij0oJd6h+lwLDOoAZY3FueFbhm3i8L+Th0Ha
         nQFF7w8Ehg6MPHtETaxtVvSE4I3f3hAepMquA1Zlg0t/TDXtMd7OTTczELyQE4Wsmo2Y
         0q3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679959430;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2sthNEXRrhXPflNLlQaZ/R6XYUJ5sFT3zFaO3Oj8iQU=;
        b=B/AeAuagyHTb4lqGtLXFnMOy4Fnr/39Yis3S307+fB/VO+gwaqhxWuEvlx1stUBf1d
         F85mGVk5Hwr3RWtREwN0eUx9NcOyHP6zEnWh7iF7QHGzvJiRIRN7goaTVrXnQYSkkyDR
         MaQLYoNyhdOqnUllLm1J0/EqlZ47fg+k38TxPQfMkx4zxPD3Lq2iKkEpxtN5BFgoJyDp
         VjMUZa9bYS9UddlQTr8Xi2LS8LSokQYgkS7BK4Ka9F7svyscA0bdc0s1DJNaS4/pEhcV
         m8rUjqQChp5eytMwlP2bnwCpMj2Bb3iTj/wygBIexpm3yBzmRlvKk4ahkmLoh22qYcmm
         zvDA==
X-Gm-Message-State: AAQBX9cil0qhCfr681O63ArZOeMWwOkFHyl2oK87hzGYII5J/deEnaYx
        /FgYUFfYgXm64l15Y14vd1jyr+MnEErJ8PiNbJuQPQ==
X-Google-Smtp-Source: AKy350axSMcFglrC9LKGtyy/jSyGyc9yKavwwCk6Ag/35Vw5JpZJlLk5zGZNXtD+EFFmpK2mYo3yPnkogMK64CtmxC8=
X-Received: by 2002:a50:8e0d:0:b0:4fc:473d:3308 with SMTP id
 13-20020a508e0d000000b004fc473d3308mr6749360edw.8.1679959430371; Mon, 27 Mar
 2023 16:23:50 -0700 (PDT)
MIME-Version: 1.0
References: <20230323040037.2389095-1-yosryahmed@google.com>
 <20230323040037.2389095-2-yosryahmed@google.com> <ZBz/V5a7/6PZeM7S@slm.duckdns.org>
 <CAJD7tkYNZeEytm_Px9_73Y-AYJfHAxaoTmmnO71HW5hd1B5tPg@mail.gmail.com>
 <ZB5UalkjGngcBDEJ@slm.duckdns.org> <CAJD7tkYhyMkD8SFf8b8L1W9QUrLOdw-HJ2NUbENjw5dgFnH3Aw@mail.gmail.com>
 <CALvZod6rF0D21hcV7xnqD+oRkn=x5NLi5GOkPpyaPa859uDH+Q@mail.gmail.com>
 <CAJD7tkY_ESpMYMw72bsATpp6tPphv8qS6VbfEUjpKZW6vUqQSQ@mail.gmail.com> <CALvZod41ecuCKmuFBNtAjoKJjQgWYzoe4_B8zRK37HYk-rYDkA@mail.gmail.com>
In-Reply-To: <CALvZod41ecuCKmuFBNtAjoKJjQgWYzoe4_B8zRK37HYk-rYDkA@mail.gmail.com>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Mon, 27 Mar 2023 16:23:13 -0700
Message-ID: <CAJD7tkZrp=4zWvjE9_010TAG1T_crCbf9P64UzJABspgcrGPKg@mail.gmail.com>
Subject: Re: [RFC PATCH 1/7] cgroup: rstat: only disable interrupts for the
 percpu lock
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Tejun Heo <tj@kernel.org>, Josef Bacik <josef@toxicpanda.com>,
        Jens Axboe <axboe@kernel.dk>,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
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

On Fri, Mar 24, 2023 at 9:46=E2=80=AFPM Shakeel Butt <shakeelb@google.com> =
wrote:
>
> On Fri, Mar 24, 2023 at 9:37=E2=80=AFPM Yosry Ahmed <yosryahmed@google.co=
m> wrote:
> >
> > On Fri, Mar 24, 2023 at 9:31=E2=80=AFPM Shakeel Butt <shakeelb@google.c=
om> wrote:
> > >
> > > On Fri, Mar 24, 2023 at 7:18=E2=80=AFPM Yosry Ahmed <yosryahmed@googl=
e.com> wrote:
> > > >
> > > [...]
> > > > Any ideas here are welcome!
> > > >
> > >
> > > Let's move forward. It seems like we are not going to reach an
> > > agreement on making cgroup_rstat_lock a non-irq lock. However there i=
s
> > > agreement on the memcg code of not flushing in irq context and the
> > > cleanup Johannes has requested. Let's proceed with those for now. We
> > > can come back to cgroup_rstat_lock later if we still see issues in
> > > production.
> >
> > Even if we do not flush from irq context, we still flush from atomic
> > contexts that will currently hold the lock with irqs disabled
> > throughout the entire flush sequence. A primary purpose of this reason
> > is to avoid that.
> >
> > We can either:
> > (a) Proceed with the following approach of making cgroup_rstat_lock a
> > non-irq lock.
> > (b) Proceed with Tejun's suggestion of always releasing and
> > reacquiring the lock at CPU boundaries, even for atomic flushes (if
> > the spinlock needs a break ofc).
> > (c) Something else.
>
> (d) keep the status quo regarding cgroup_rstat_lock
> (e) decouple the discussion of cgroup_rstat_lock from the agreed
> improvements. Send the patches for the agreed ones and continue
> discussing cgroup_rstat_lock.


Ah, I lost sight of the fact that the rest of the patch series does
not strictly depend on this patch. I will respin the rest of the patch
series separately. Thanks, Shakeel.

Meanwhile, it would be useful to reach an agreement here to stop
acquiring the cgroup_rstat_lock for a long time with irq disabled in
atomic contexts.

Tejun, if having the lock be non-irq is a non-starter for you, I can
send a patch that instead gives up the lock and reacquires it at every
CPU boundary unconditionally -- or perhaps every N CPU boundaries to
avoid excessively releasing and reacquiring the lock.

Something like:

static void cgroup_rstat_flush_locked(struct cgroup *cgrp, bool may_sleep)
{
    ...
    for_each_possible_cpu(cpu) {
        ...
        /* Always yield the at CPU boundaries to enable irqs */
        spin_unlock_irq(&cgroup_rstat_lock);

        /* if @may_sleep, play nice and yield if necessary */
        if (may_sleep)
            cond_resched();

        spin_lock_irq(&cgroup_rstat_lock);
    }
}

If you have other ideas to avoid disabling irq's for the entire flush
sequence I am also open to that.

Thanks!
