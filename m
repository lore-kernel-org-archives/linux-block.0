Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD1CBC6FD1C
	for <linux-block@archiver.kernel.org>; Thu, 23 Mar 2023 16:18:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230211AbjCWQSO (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 23 Mar 2023 12:18:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229962AbjCWQSN (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 23 Mar 2023 12:18:13 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A25A1167C
        for <linux-block@vger.kernel.org>; Thu, 23 Mar 2023 09:18:11 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id cn12so43482714edb.4
        for <linux-block@vger.kernel.org>; Thu, 23 Mar 2023 09:18:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1679588290;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DxwPj9zc4wVERdaRm3UD6tbyjSI8uDBIlR3KTexXHNg=;
        b=XhO6nZVp3cJ6GYNnQ2ZPBd/bevteGrZU/HIt7rhk+LHiYXbwkTEIAA/Gm2lDHIMikg
         gfoYKiDCpNo8lnfMBlGGsI0PLQz5CrW36qepgWsG7uExChYhRpji3UqRtZum7cH/vdbZ
         nMqTsTLwMkfU7eqB6QIAZhzjzcr6MfIBsV9+Mh7lY8ajGfGMxL7VuLMDYbs0rNlH1Lgf
         iV6mh1620CTOr/soDFy1jiw2Cv+8sGb2vRKHlFpQOFPw708c41xBPfnbqLdjoqoACMXl
         o1UnaPMAjjFpYJ904SCgAI0gxQMgUnTxaQY+oMY7qneZ4HxyRULhAJKXlDXAWNrPcPJl
         8/jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679588290;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DxwPj9zc4wVERdaRm3UD6tbyjSI8uDBIlR3KTexXHNg=;
        b=wMhMUpx8YLGSHxUF0qn6G5JfJFUk4/7btl+QpiQYqTsHXTARTD+bFvBG6ALlkeqsRg
         BeJL0iY2xZ+2zdQGB3mEcvuOeVFLV9k4EGWrlUUiO2afRqD3b7dVzEoW7ectd/0go4gX
         HY5sp+q7wq02b9p2dZZaHiluacAICcNh/GWQ8b1lRWmDobi7QaO/N1MvPDkbwlG675Ts
         fcVWJKJ3qS6eFz2YM6/rw91Qc1Dd12ueuWSgf1R/R+yqrkFA8NYFHETynpk7e2vkuRDd
         fKmLn4B/kuVKqwB+3HfqUXEwnZ0F2jp94M7xnmvBBQUf0Q0OLeMBUYt3qfuEnvG5a01G
         oL/w==
X-Gm-Message-State: AO0yUKXq4ky3Tc5S5AUluf2b70U0bPNAlkEwCVzRmHZD+Ke6j9bzPDyf
        +nWZVcKlVkRY9uMx0iIe70GsnH/3pa1elpkp7qlzDg==
X-Google-Smtp-Source: AK7set/F5NNXvDsHcjBnswex17zee4ALhFHj/vmjoRRqfjUnNDh8XIbYrOkU+1HM87gBHlOIW8+AR+spBXumt/uarsQ=
X-Received: by 2002:a50:9b55:0:b0:4fc:473d:3308 with SMTP id
 a21-20020a509b55000000b004fc473d3308mr3392273edj.8.1679588289734; Thu, 23 Mar
 2023 09:18:09 -0700 (PDT)
MIME-Version: 1.0
References: <20230323040037.2389095-1-yosryahmed@google.com>
 <20230323040037.2389095-2-yosryahmed@google.com> <CALvZod7e7dMmkhKtXPAxmXjXQoTyeBf3Bht8HJC8AtWW93As3g@mail.gmail.com>
 <CAJD7tkbziGh+6hnMysHkoNr_HGBKU+s1rSGj=gZLki0ALT-jLg@mail.gmail.com>
 <CALvZod5GT=bZsLXsG500pNkEJpMB1o2KJau4=r0eHB-c8US53A@mail.gmail.com>
 <CAJD7tkY6Wf2OWja+f-JeFM5DdMCyLzbXxZ8KF0MjcYOKri-vtA@mail.gmail.com>
 <CALvZod5mJBAQ5adym7UNEruL-tOOOi+Y_ZiKsfOYqXPmGVPUEA@mail.gmail.com>
 <CAJD7tkYWo_aB7a4SHXNQDHwcaTELonOk_Vd8q0=x8vwGy2VkYg@mail.gmail.com>
 <CALvZod7f9Rejb_WrZ+Ajegz-NsQ7iPQegRDMdk5Ya0a0w=40kg@mail.gmail.com> <CALvZod7-6F84POkNetA2XJB-24wms=5q_s495NEthO8b63rL4A@mail.gmail.com>
In-Reply-To: <CALvZod7-6F84POkNetA2XJB-24wms=5q_s495NEthO8b63rL4A@mail.gmail.com>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Thu, 23 Mar 2023 09:17:33 -0700
Message-ID: <CAJD7tkbGCgk9VkGdec0=AdHErds4XQs1LzJMhqVryXdjY5PVAg@mail.gmail.com>
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

On Thu, Mar 23, 2023 at 9:10=E2=80=AFAM Shakeel Butt <shakeelb@google.com> =
wrote:
>
> On Thu, Mar 23, 2023 at 8:46=E2=80=AFAM Shakeel Butt <shakeelb@google.com=
> wrote:
> >
> > On Thu, Mar 23, 2023 at 8:43=E2=80=AFAM Yosry Ahmed <yosryahmed@google.=
com> wrote:
> > >
> > > On Thu, Mar 23, 2023 at 8:40=E2=80=AFAM Shakeel Butt <shakeelb@google=
.com> wrote:
> > > >
> > > > On Thu, Mar 23, 2023 at 6:36=E2=80=AFAM Yosry Ahmed <yosryahmed@goo=
gle.com> wrote:
> > > > >
> > > > [...]
> > > > > > >
> > > > > > > > 2. Are we really calling rstat flush in irq context?
> > > > > > >
> > > > > > > I think it is possible through the charge/uncharge path:
> > > > > > > memcg_check_events()->mem_cgroup_threshold()->mem_cgroup_usag=
e(). I
> > > > > > > added the protection against flushing in an interrupt context=
 for
> > > > > > > future callers as well, as it may cause a deadlock if we don'=
t disable
> > > > > > > interrupts when acquiring cgroup_rstat_lock.
> > > > > > >
> > > > > > > > 3. The mem_cgroup_flush_stats() call in mem_cgroup_usage() =
is only
> > > > > > > > done for root memcg. Why is mem_cgroup_threshold() interest=
ed in root
> > > > > > > > memcg usage? Why not ignore root memcg in mem_cgroup_thresh=
old() ?
> > > > > > >
> > > > > > > I am not sure, but the code looks like event notifications ma=
y be set
> > > > > > > up on root memcg, which is why we need to check thresholds.
> > > > > >
> > > > > > This is something we should deprecate as root memcg's usage is =
ill defined.
> > > > >
> > > > > Right, but I think this would be orthogonal to this patch series.
> > > > >
> > > >
> > > > I don't think we can make cgroup_rstat_lock a non-irq-disabling loc=
k
> > > > without either breaking a link between mem_cgroup_threshold and
> > > > cgroup_rstat_lock or make mem_cgroup_threshold work without disabli=
ng
> > > > irqs.
> > > >
> > > > So, this patch can not be applied before either of those two tasks =
are
> > > > done (and we may find more such scenarios).
> > >
> > >
> > > Could you elaborate why?
> > >
> > > My understanding is that with an in_task() check to make sure we only
> > > acquire cgroup_rstat_lock from non-irq context it should be fine to
> > > acquire cgroup_rstat_lock without disabling interrupts.
> >
> > From mem_cgroup_threshold() code path, cgroup_rstat_lock will be taken
> > with irq disabled while other code paths will take cgroup_rstat_lock
> > with irq enabled. This is a potential deadlock hazard unless
> > cgroup_rstat_lock is always taken with irq disabled.
>
> Oh you are making sure it is not taken in the irq context through
> should_skip_flush(). Hmm seems like a hack. Normally it is recommended
> to actually remove all such users instead of silently
> ignoring/bypassing the functionality.

It is a workaround, we simply accept to read stale stats in irq
context instead of the expensive flush operation.

>
> So, how about removing mem_cgroup_flush_stats() from
> mem_cgroup_usage(). It will break the known chain which is taking
> cgroup_rstat_lock with irq disabled and you can add
> WARN_ON_ONCE(!in_task()).

This changes the behavior in a more obvious way because:
1. The memcg_check_events()->mem_cgroup_threshold()->mem_cgroup_usage()
path is also exercised in a lot of paths outside irq context, this
will change the behavior for any event thresholds on the root memcg.
With proposed skipped flushing in irq context we only change the
behavior in a small subset of cases.

I think we can skip flushing in irq context for now, and separately
deprecate threshold events for the root memcg. When that is done we
can come back and remove should_skip_flush() and add a VM_BUG_ON or
WARN_ON_ONCE instead. WDYT?

2. mem_cgroup_usage() is also used when reading usage from userspace.
This should be an easy workaround though.
