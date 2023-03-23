Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AC02C74A5B
	for <linux-block@archiver.kernel.org>; Thu, 23 Mar 2023 16:46:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232455AbjCWQqj (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 23 Mar 2023 12:46:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231804AbjCWQqW (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 23 Mar 2023 12:46:22 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABE1E3526F
        for <linux-block@vger.kernel.org>; Thu, 23 Mar 2023 09:45:37 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id r29so21289699wra.13
        for <linux-block@vger.kernel.org>; Thu, 23 Mar 2023 09:45:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1679589935;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GglKicPIARqjK50ePWIEou5wLn8UHWFeaeY7+rjXEwI=;
        b=qDusDQcIUB4xyGrh0Cy0pH4GJXpbd3dBvtD3xReDL20t/GutJptx7dOvT4vlZdqKI3
         f+fWp4deIzDbuOXho4jdEyhGJ09Xa27VcoxrPtkG5R0wKq0G7Q0d7rZYqyTfujICDJOz
         iuWKWXvAzM22e22natXMUpus3et4jQPBuPeOT3gbm0Mlyxjo/kxGQFoR4SGwQ3jKsTnT
         BTidcAWwLqvWaic+X/v0ffejNUKAS5lmND0yzPTIIy2pIZpPFUQvlsCES8MUG15SNwqZ
         fB6xcKWpDZezHntFyeWpTZwVIMFwjI9Nzh3eHR5yL9Q2SXI2A/gWdF3BMTOj6udQZDKZ
         wyQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679589935;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GglKicPIARqjK50ePWIEou5wLn8UHWFeaeY7+rjXEwI=;
        b=7bIRm9j7w2f5F6jlKg9co7N4QZWZl9JP+Y4fJTgPHAVdbYjviWcEP33OTd+Xa3Qw6+
         d3FN5ly2JcNY565YLHlvQMv84HFTNGD+0rB1pgE9MYkcAhjM4eeSuPtr9TA06MkUX5fY
         8y7wMnDhg2QfVjmu5MERrsIv0ssz9vhbZeUV/Ot1jQRE3Ke6aqUjBjRKminDS8lulTbt
         pNEuon9Otdx9aX977SyJx+On0LuVKq3u4ekp3B4rkPidGjgWWpQ2fSJZWJpXyKHKIR5/
         r6WynY9ix/jZavEtPYx0YneUfcMS+4DDIjGT+iAD2T5oSIlqwDvUNfv+r6tmOYww6VTk
         eFaw==
X-Gm-Message-State: AAQBX9d/vKO9DynBx9ULW/1sHSeffKA4dLsyNk2A4h80ShfzOArRCDxN
        d7GoMIKhblOgUSMFNv2u21rcN6c3wyUTBaifACSMAA==
X-Google-Smtp-Source: AKy350ZlSuPs5ToB6LO/yJNmvDf9+my4w0sgXcPgDet+2XYNHi3vh+JlZRxgO7wkE7KZJ50aT5NNg6E0z4j8xc76wLc=
X-Received: by 2002:adf:fd81:0:b0:2c7:1483:9479 with SMTP id
 d1-20020adffd81000000b002c714839479mr897523wrr.11.1679589935242; Thu, 23 Mar
 2023 09:45:35 -0700 (PDT)
MIME-Version: 1.0
References: <20230323040037.2389095-1-yosryahmed@google.com>
 <20230323040037.2389095-2-yosryahmed@google.com> <CALvZod7e7dMmkhKtXPAxmXjXQoTyeBf3Bht8HJC8AtWW93As3g@mail.gmail.com>
 <CAJD7tkbziGh+6hnMysHkoNr_HGBKU+s1rSGj=gZLki0ALT-jLg@mail.gmail.com>
 <CALvZod5GT=bZsLXsG500pNkEJpMB1o2KJau4=r0eHB-c8US53A@mail.gmail.com>
 <CAJD7tkY6Wf2OWja+f-JeFM5DdMCyLzbXxZ8KF0MjcYOKri-vtA@mail.gmail.com>
 <CALvZod5mJBAQ5adym7UNEruL-tOOOi+Y_ZiKsfOYqXPmGVPUEA@mail.gmail.com>
 <CAJD7tkYWo_aB7a4SHXNQDHwcaTELonOk_Vd8q0=x8vwGy2VkYg@mail.gmail.com>
 <CALvZod7f9Rejb_WrZ+Ajegz-NsQ7iPQegRDMdk5Ya0a0w=40kg@mail.gmail.com>
 <CALvZod7-6F84POkNetA2XJB-24wms=5q_s495NEthO8b63rL4A@mail.gmail.com>
 <CAJD7tkbGCgk9VkGdec0=AdHErds4XQs1LzJMhqVryXdjY5PVAg@mail.gmail.com>
 <CALvZod7saq910u4JxnuY4C7EwiK5vgNF=-Bv+236RprUOQdkjw@mail.gmail.com> <CAJD7tkb8oHoK5RW96tEXjY9iyJpMXfGAvnFw1rG-5Sr+Mpubdg@mail.gmail.com>
In-Reply-To: <CAJD7tkb8oHoK5RW96tEXjY9iyJpMXfGAvnFw1rG-5Sr+Mpubdg@mail.gmail.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Thu, 23 Mar 2023 09:45:20 -0700
Message-ID: <CALvZod5USCtNtnPuYRbRv_psBCNytQWWQ592TFsJLfrLpyLJmw@mail.gmail.com>
Subject: Re: [RFC PATCH 1/7] cgroup: rstat: only disable interrupts for the
 percpu lock
To:     Yosry Ahmed <yosryahmed@google.com>
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

On Thu, Mar 23, 2023 at 9:37=E2=80=AFAM Yosry Ahmed <yosryahmed@google.com>=
 wrote:
>
> On Thu, Mar 23, 2023 at 9:29=E2=80=AFAM Shakeel Butt <shakeelb@google.com=
> wrote:
> >
> > On Thu, Mar 23, 2023 at 9:18=E2=80=AFAM Yosry Ahmed <yosryahmed@google.=
com> wrote:
> > >
> > > On Thu, Mar 23, 2023 at 9:10=E2=80=AFAM Shakeel Butt <shakeelb@google=
.com> wrote:
> > > >
> > > > On Thu, Mar 23, 2023 at 8:46=E2=80=AFAM Shakeel Butt <shakeelb@goog=
le.com> wrote:
> > > > >
> > > > > On Thu, Mar 23, 2023 at 8:43=E2=80=AFAM Yosry Ahmed <yosryahmed@g=
oogle.com> wrote:
> > > > > >
> > > > > > On Thu, Mar 23, 2023 at 8:40=E2=80=AFAM Shakeel Butt <shakeelb@=
google.com> wrote:
> > > > > > >
> > > > > > > On Thu, Mar 23, 2023 at 6:36=E2=80=AFAM Yosry Ahmed <yosryahm=
ed@google.com> wrote:
> > > > > > > >
> > > > > > > [...]
> > > > > > > > > >
> > > > > > > > > > > 2. Are we really calling rstat flush in irq context?
> > > > > > > > > >
> > > > > > > > > > I think it is possible through the charge/uncharge path=
:
> > > > > > > > > > memcg_check_events()->mem_cgroup_threshold()->mem_cgrou=
p_usage(). I
> > > > > > > > > > added the protection against flushing in an interrupt c=
ontext for
> > > > > > > > > > future callers as well, as it may cause a deadlock if w=
e don't disable
> > > > > > > > > > interrupts when acquiring cgroup_rstat_lock.
> > > > > > > > > >
> > > > > > > > > > > 3. The mem_cgroup_flush_stats() call in mem_cgroup_us=
age() is only
> > > > > > > > > > > done for root memcg. Why is mem_cgroup_threshold() in=
terested in root
> > > > > > > > > > > memcg usage? Why not ignore root memcg in mem_cgroup_=
threshold() ?
> > > > > > > > > >
> > > > > > > > > > I am not sure, but the code looks like event notificati=
ons may be set
> > > > > > > > > > up on root memcg, which is why we need to check thresho=
lds.
> > > > > > > > >
> > > > > > > > > This is something we should deprecate as root memcg's usa=
ge is ill defined.
> > > > > > > >
> > > > > > > > Right, but I think this would be orthogonal to this patch s=
eries.
> > > > > > > >
> > > > > > >
> > > > > > > I don't think we can make cgroup_rstat_lock a non-irq-disabli=
ng lock
> > > > > > > without either breaking a link between mem_cgroup_threshold a=
nd
> > > > > > > cgroup_rstat_lock or make mem_cgroup_threshold work without d=
isabling
> > > > > > > irqs.
> > > > > > >
> > > > > > > So, this patch can not be applied before either of those two =
tasks are
> > > > > > > done (and we may find more such scenarios).
> > > > > >
> > > > > >
> > > > > > Could you elaborate why?
> > > > > >
> > > > > > My understanding is that with an in_task() check to make sure w=
e only
> > > > > > acquire cgroup_rstat_lock from non-irq context it should be fin=
e to
> > > > > > acquire cgroup_rstat_lock without disabling interrupts.
> > > > >
> > > > > From mem_cgroup_threshold() code path, cgroup_rstat_lock will be =
taken
> > > > > with irq disabled while other code paths will take cgroup_rstat_l=
ock
> > > > > with irq enabled. This is a potential deadlock hazard unless
> > > > > cgroup_rstat_lock is always taken with irq disabled.
> > > >
> > > > Oh you are making sure it is not taken in the irq context through
> > > > should_skip_flush(). Hmm seems like a hack. Normally it is recommen=
ded
> > > > to actually remove all such users instead of silently
> > > > ignoring/bypassing the functionality.
> > >
> > > It is a workaround, we simply accept to read stale stats in irq
> > > context instead of the expensive flush operation.
> > >
> > > >
> > > > So, how about removing mem_cgroup_flush_stats() from
> > > > mem_cgroup_usage(). It will break the known chain which is taking
> > > > cgroup_rstat_lock with irq disabled and you can add
> > > > WARN_ON_ONCE(!in_task()).
> > >
> > > This changes the behavior in a more obvious way because:
> > > 1. The memcg_check_events()->mem_cgroup_threshold()->mem_cgroup_usage=
()
> > > path is also exercised in a lot of paths outside irq context, this
> > > will change the behavior for any event thresholds on the root memcg.
> > > With proposed skipped flushing in irq context we only change the
> > > behavior in a small subset of cases.
> > >
> > > I think we can skip flushing in irq context for now, and separately
> > > deprecate threshold events for the root memcg. When that is done we
> > > can come back and remove should_skip_flush() and add a VM_BUG_ON or
> > > WARN_ON_ONCE instead. WDYT?
> > >
> > > 2. mem_cgroup_usage() is also used when reading usage from userspace.
> > > This should be an easy workaround though.
> >
> > This is a cgroup v1 behavior and to me it is totally reasonable to get
> > the 2 second stale root's usage. Even if you want to skip flushing in
> > irq, do that in the memcg code and keep VM_BUG_ON/WARN_ON_ONCE in the
> > rstat core code. This way we will know if other subsystems are doing
> > the same or not.
>
> We can do that. Basically in mem_cgroup_usage() have:
>
> /* Some useful comment */
> if (in_task())
>     mem_cgroup_flush_stats();
>
> and in cgroup_rstat_flush() have:
> WARN_ON_ONCE(!in_task());
>
> I am assuming VM_BUG_ON is not used outside mm code.
>
> The only thing that worries me is that if there is another unlikely
> path somewhere that flushes stats in irq context we may run into a
> deadlock. I am a little bit nervous about not skipping flushing if
> !in_task() in cgroup_rstat_flush().

I think it is a good thing. We will find such scenarios and fix those
instead of hiding them forever or keeping the door open for new such
scenarios.
