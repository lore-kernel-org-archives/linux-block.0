Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 750E8C6FD1C
	for <linux-block@archiver.kernel.org>; Thu, 23 Mar 2023 18:10:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231271AbjCWSKL (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 23 Mar 2023 14:10:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231196AbjCWSKK (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 23 Mar 2023 14:10:10 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50FB711154
        for <linux-block@vger.kernel.org>; Thu, 23 Mar 2023 11:10:08 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id o12so90451877edb.9
        for <linux-block@vger.kernel.org>; Thu, 23 Mar 2023 11:10:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1679595007;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TG6r42DnDMDxeRAZYy//5B+CwRJPcnDTegQ6DfZfbA0=;
        b=lRkNETJE7iTItx4Oqh+NEjrOnfGYNHB2E7RmMla6GzKkIpwBLF9JrTmMnnasXhid+k
         4GkqmkFXqD/kFADNx1MsVLXYWkgn95RMlwtqftoBICvHYDRIbDVOLp63NhjUNEROXM26
         HENlsAwE1ibTbvJpzLEdF2luec/dHuzpc1xzDRetDxf7oeI0mlmlGL6AnXKlSsiN0V9a
         fkI7cVYLirYeR0xKgmG0B3pMlHl7NRM2QgUtb8qKGaaoz5Ty1xY2/kTy+5DFPQzsh5PD
         TtsaTo4siyBM23lo1jlLwtoGkyyzIpFokkg4XZiGVdC26hvQ6MBgzGvdKltKogoOZmS+
         lKeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679595007;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TG6r42DnDMDxeRAZYy//5B+CwRJPcnDTegQ6DfZfbA0=;
        b=QYeSsGm5fjsV8d+c82lUpobo0LLwChZZHze+2xGQnIhUZoDumZyEup9gkLvV1QOQx5
         hE6npyGtrcEKBDV0GMNTYjH0Vr7Yidi+endA1NWyRm3kz55B3hjX7g2126OXrJl8i440
         JNtS69HxlVv/Zo21eVR3cEqHHh8J0uu3jIk5ra2WbNO4Lzp5aRqfe8K0cfzMSgTKxxFR
         5TKA6kU3Fnfm1J0T/e6DiW0BHaXkF7fvLvvSZ0g3RjTsG6O9vAhQyww8TEaDUwwOxssg
         sRr+nCETCEkS3sBF83iIFs58F0Jv3JVVaviXZww4vt0GKi2ZOohErZWAQ8dYjgcbNFd2
         1Y9g==
X-Gm-Message-State: AO0yUKW8Gk6wBpEKFnqkKZcMm0xD9ng1Vs3rVILA2rHcLzQqzJLXOAjg
        Fh113t+mA3ewJZ18lLMM33wrRlf4aTdMGhhf+KDRew==
X-Google-Smtp-Source: AK7set8XblrKP6hJ5Y1r/+5NyekRYrhUe9w5X4pTSV4UO9N5ONeHg6GzjPn2UmtNPP+P1Ztc6jQ53G67XRmRVO03X+A=
X-Received: by 2002:a17:906:34cd:b0:8e5:411d:4d09 with SMTP id
 h13-20020a17090634cd00b008e5411d4d09mr5406251ejb.15.1679595006684; Thu, 23
 Mar 2023 11:10:06 -0700 (PDT)
MIME-Version: 1.0
References: <20230323040037.2389095-2-yosryahmed@google.com>
 <CALvZod7e7dMmkhKtXPAxmXjXQoTyeBf3Bht8HJC8AtWW93As3g@mail.gmail.com>
 <CAJD7tkbziGh+6hnMysHkoNr_HGBKU+s1rSGj=gZLki0ALT-jLg@mail.gmail.com>
 <CALvZod5GT=bZsLXsG500pNkEJpMB1o2KJau4=r0eHB-c8US53A@mail.gmail.com>
 <CAJD7tkY6Wf2OWja+f-JeFM5DdMCyLzbXxZ8KF0MjcYOKri-vtA@mail.gmail.com>
 <CALvZod5mJBAQ5adym7UNEruL-tOOOi+Y_ZiKsfOYqXPmGVPUEA@mail.gmail.com>
 <CAJD7tkYWo_aB7a4SHXNQDHwcaTELonOk_Vd8q0=x8vwGy2VkYg@mail.gmail.com>
 <CALvZod7f9Rejb_WrZ+Ajegz-NsQ7iPQegRDMdk5Ya0a0w=40kg@mail.gmail.com>
 <CALvZod7-6F84POkNetA2XJB-24wms=5q_s495NEthO8b63rL4A@mail.gmail.com>
 <CAJD7tkbGCgk9VkGdec0=AdHErds4XQs1LzJMhqVryXdjY5PVAg@mail.gmail.com> <20230323173343.GF739026@cmpxchg.org>
In-Reply-To: <20230323173343.GF739026@cmpxchg.org>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Thu, 23 Mar 2023 11:09:30 -0700
Message-ID: <CAJD7tkb_Zpp4PqFNBJ3__7t5eiYwuqaZc=08B1g=S_tMF+wgSQ@mail.gmail.com>
Subject: Re: [RFC PATCH 1/7] cgroup: rstat: only disable interrupts for the
 percpu lock
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Shakeel Butt <shakeelb@google.com>, Tejun Heo <tj@kernel.org>,
        Josef Bacik <josef@toxicpanda.com>,
        Jens Axboe <axboe@kernel.dk>,
        Zefan Li <lizefan.x@bytedance.com>,
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

On Thu, Mar 23, 2023 at 10:33=E2=80=AFAM Johannes Weiner <hannes@cmpxchg.or=
g> wrote:
>
> On Thu, Mar 23, 2023 at 09:17:33AM -0700, Yosry Ahmed wrote:
> > On Thu, Mar 23, 2023 at 9:10=E2=80=AFAM Shakeel Butt <shakeelb@google.c=
om> wrote:
> > >
> > > On Thu, Mar 23, 2023 at 8:46=E2=80=AFAM Shakeel Butt <shakeelb@google=
.com> wrote:
> > > >
> > > > On Thu, Mar 23, 2023 at 8:43=E2=80=AFAM Yosry Ahmed <yosryahmed@goo=
gle.com> wrote:
> > > > >
> > > > > On Thu, Mar 23, 2023 at 8:40=E2=80=AFAM Shakeel Butt <shakeelb@go=
ogle.com> wrote:
> > > > > >
> > > > > > On Thu, Mar 23, 2023 at 6:36=E2=80=AFAM Yosry Ahmed <yosryahmed=
@google.com> wrote:
> > > > > > >
> > > > > > [...]
> > > > > > > > >
> > > > > > > > > > 2. Are we really calling rstat flush in irq context?
> > > > > > > > >
> > > > > > > > > I think it is possible through the charge/uncharge path:
> > > > > > > > > memcg_check_events()->mem_cgroup_threshold()->mem_cgroup_=
usage(). I
> > > > > > > > > added the protection against flushing in an interrupt con=
text for
> > > > > > > > > future callers as well, as it may cause a deadlock if we =
don't disable
> > > > > > > > > interrupts when acquiring cgroup_rstat_lock.
> > > > > > > > >
> > > > > > > > > > 3. The mem_cgroup_flush_stats() call in mem_cgroup_usag=
e() is only
> > > > > > > > > > done for root memcg. Why is mem_cgroup_threshold() inte=
rested in root
> > > > > > > > > > memcg usage? Why not ignore root memcg in mem_cgroup_th=
reshold() ?
> > > > > > > > >
> > > > > > > > > I am not sure, but the code looks like event notification=
s may be set
> > > > > > > > > up on root memcg, which is why we need to check threshold=
s.
> > > > > > > >
> > > > > > > > This is something we should deprecate as root memcg's usage=
 is ill defined.
> > > > > > >
> > > > > > > Right, but I think this would be orthogonal to this patch ser=
ies.
> > > > > > >
> > > > > >
> > > > > > I don't think we can make cgroup_rstat_lock a non-irq-disabling=
 lock
> > > > > > without either breaking a link between mem_cgroup_threshold and
> > > > > > cgroup_rstat_lock or make mem_cgroup_threshold work without dis=
abling
> > > > > > irqs.
> > > > > >
> > > > > > So, this patch can not be applied before either of those two ta=
sks are
> > > > > > done (and we may find more such scenarios).
> > > > >
> > > > >
> > > > > Could you elaborate why?
> > > > >
> > > > > My understanding is that with an in_task() check to make sure we =
only
> > > > > acquire cgroup_rstat_lock from non-irq context it should be fine =
to
> > > > > acquire cgroup_rstat_lock without disabling interrupts.
> > > >
> > > > From mem_cgroup_threshold() code path, cgroup_rstat_lock will be ta=
ken
> > > > with irq disabled while other code paths will take cgroup_rstat_loc=
k
> > > > with irq enabled. This is a potential deadlock hazard unless
> > > > cgroup_rstat_lock is always taken with irq disabled.
> > >
> > > Oh you are making sure it is not taken in the irq context through
> > > should_skip_flush(). Hmm seems like a hack. Normally it is recommende=
d
> > > to actually remove all such users instead of silently
> > > ignoring/bypassing the functionality.
>
> +1
>
> It shouldn't silently skip the requested operation, rather it
> shouldn't be requested from an incompatible context.
>
> > > So, how about removing mem_cgroup_flush_stats() from
> > > mem_cgroup_usage(). It will break the known chain which is taking
> > > cgroup_rstat_lock with irq disabled and you can add
> > > WARN_ON_ONCE(!in_task()).
> >
> > This changes the behavior in a more obvious way because:
> > 1. The memcg_check_events()->mem_cgroup_threshold()->mem_cgroup_usage()
> > path is also exercised in a lot of paths outside irq context, this
> > will change the behavior for any event thresholds on the root memcg.
> > With proposed skipped flushing in irq context we only change the
> > behavior in a small subset of cases.
>
> Can you do
>
>         /* Note: stale usage data when called from irq context!! */
>         if (in_task())
>                 mem_cgroup_flush_stats()
>
> directly in the callsite? Maybe even include the whole callchain in
> the comment that's currently broken and needs fixing/removing.

Yeah, we can do that in mem_cgroup_usage(), which is the only context
that I am aware of that may flush from irq context. We can also add
WARN_ON_ONCE(!in_task()) in the rstat core flushing code to catch any
other code paths that we are not aware of -- which may result in a
deadlock, but hopefully if there is a violation it will be caught soon
enough.
