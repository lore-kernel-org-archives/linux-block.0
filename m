Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82562C6FD1C
	for <linux-block@archiver.kernel.org>; Thu, 23 Mar 2023 15:43:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231691AbjCWPnb (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 23 Mar 2023 11:43:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231845AbjCWPna (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 23 Mar 2023 11:43:30 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D730C20573
        for <linux-block@vger.kernel.org>; Thu, 23 Mar 2023 08:43:27 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id o12so88513819edb.9
        for <linux-block@vger.kernel.org>; Thu, 23 Mar 2023 08:43:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1679586206;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JR2t4YEAW/CeRYBS44zjBzatYGFGxBDqwLzXBK2rHQc=;
        b=mjV7iSriIwiO4+OfpDMCFGcMkE5baHrwNE3TxMhHuupoe7OY5sfpUjIAy9jfp0juHN
         /pXhTYEnznjOfzDEqepJdt682v9BCC3QD5/z3V3o+1LaxE4L8waApaTX8wJ0DLHuCpII
         k9D7Z/AW+t2hRm1js+bKTn9Ps7eJZKjX3oZRYHwev3rdVkR+l/zjwObTS8Hu7LHCLXXt
         GK1DiCG0DGQFtztUSWl6VpgCJRN8gYfMtzlsiBiMTdiYgtbvmU5ZLr0VxZ5SUC/Zd1av
         Ui902c+TDYhTFVkYsIXT6QTpRsMe43dC5CgPmaZMI7h/Y7guI1At2tAXKjXucHeU3gy3
         g39Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679586206;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JR2t4YEAW/CeRYBS44zjBzatYGFGxBDqwLzXBK2rHQc=;
        b=Gw9fTjU3jx5ZJbqsXATseraCvwWPgw/HU5Diay149o63ct1gB+Kzqqg5Uo5UwfF3Bb
         faxXzwZAYzV3xA0uUDTKXdodjDbLs2BXEzKGl7xO+/Xr8rviCUW4kOOwQUsaH0nAjIOm
         ofEJr6NIXiTQQ/v3e5sMwLxVkuDQonr31atHPk4UinUsNvVpXqDM3MOAOSPy1T/y+vLs
         FnA41niE12y+n0kXQXmje2rUgKOfkTRNZ0k16GSJuY7kz1R0KUKeKlgBrmGnwmuOB0P1
         n6CE5Lp4Wou6CRIodwZ8ZNkjHPId2pPGvZ7eD27i3QTl5QfZX8vcdvYfBQ8ws0scAXjN
         CF0g==
X-Gm-Message-State: AO0yUKVTYeCBwz3MJ9CZbn36Qu1DnLxBFi3iGmnf+upnsUbkrlZ7hcnB
        Ia5u1cTQ2r8gteNBdA645wJBUvSLAnyg0uxC4iechA==
X-Google-Smtp-Source: AK7set8kz0MWLhcNXCWXEz744MzHO0PUCEstY2sebI6T0KzDS6YrrtNuGsRqqUm+oeborFZ9E4tJ0nWAN20dU70XLb4=
X-Received: by 2002:a50:9b55:0:b0:4fc:473d:3308 with SMTP id
 a21-20020a509b55000000b004fc473d3308mr3325666edj.8.1679586206203; Thu, 23 Mar
 2023 08:43:26 -0700 (PDT)
MIME-Version: 1.0
References: <20230323040037.2389095-1-yosryahmed@google.com>
 <20230323040037.2389095-2-yosryahmed@google.com> <CALvZod7e7dMmkhKtXPAxmXjXQoTyeBf3Bht8HJC8AtWW93As3g@mail.gmail.com>
 <CAJD7tkbziGh+6hnMysHkoNr_HGBKU+s1rSGj=gZLki0ALT-jLg@mail.gmail.com>
 <CALvZod5GT=bZsLXsG500pNkEJpMB1o2KJau4=r0eHB-c8US53A@mail.gmail.com>
 <CAJD7tkY6Wf2OWja+f-JeFM5DdMCyLzbXxZ8KF0MjcYOKri-vtA@mail.gmail.com> <CALvZod5mJBAQ5adym7UNEruL-tOOOi+Y_ZiKsfOYqXPmGVPUEA@mail.gmail.com>
In-Reply-To: <CALvZod5mJBAQ5adym7UNEruL-tOOOi+Y_ZiKsfOYqXPmGVPUEA@mail.gmail.com>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Thu, 23 Mar 2023 08:42:50 -0700
Message-ID: <CAJD7tkYWo_aB7a4SHXNQDHwcaTELonOk_Vd8q0=x8vwGy2VkYg@mail.gmail.com>
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

On Thu, Mar 23, 2023 at 8:40=E2=80=AFAM Shakeel Butt <shakeelb@google.com> =
wrote:
>
> On Thu, Mar 23, 2023 at 6:36=E2=80=AFAM Yosry Ahmed <yosryahmed@google.co=
m> wrote:
> >
> [...]
> > > >
> > > > > 2. Are we really calling rstat flush in irq context?
> > > >
> > > > I think it is possible through the charge/uncharge path:
> > > > memcg_check_events()->mem_cgroup_threshold()->mem_cgroup_usage(). I
> > > > added the protection against flushing in an interrupt context for
> > > > future callers as well, as it may cause a deadlock if we don't disa=
ble
> > > > interrupts when acquiring cgroup_rstat_lock.
> > > >
> > > > > 3. The mem_cgroup_flush_stats() call in mem_cgroup_usage() is onl=
y
> > > > > done for root memcg. Why is mem_cgroup_threshold() interested in =
root
> > > > > memcg usage? Why not ignore root memcg in mem_cgroup_threshold() =
?
> > > >
> > > > I am not sure, but the code looks like event notifications may be s=
et
> > > > up on root memcg, which is why we need to check thresholds.
> > >
> > > This is something we should deprecate as root memcg's usage is ill de=
fined.
> >
> > Right, but I think this would be orthogonal to this patch series.
> >
>
> I don't think we can make cgroup_rstat_lock a non-irq-disabling lock
> without either breaking a link between mem_cgroup_threshold and
> cgroup_rstat_lock or make mem_cgroup_threshold work without disabling
> irqs.
>
> So, this patch can not be applied before either of those two tasks are
> done (and we may find more such scenarios).


Could you elaborate why?

My understanding is that with an in_task() check to make sure we only
acquire cgroup_rstat_lock from non-irq context it should be fine to
acquire cgroup_rstat_lock without disabling interrupts.
