Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8946C7619A
	for <linux-block@archiver.kernel.org>; Thu, 23 Mar 2023 06:34:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229796AbjCWGeL (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 23 Mar 2023 02:34:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229997AbjCWGeE (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 23 Mar 2023 02:34:04 -0400
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com [IPv6:2607:f8b0:4864:20::1131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E50FD2B9CE
        for <linux-block@vger.kernel.org>; Wed, 22 Mar 2023 23:33:58 -0700 (PDT)
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-54184571389so379223847b3.4
        for <linux-block@vger.kernel.org>; Wed, 22 Mar 2023 23:33:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1679553238;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4npRT0ZBm4ONH6zdpwhBbu8AXu0dsqmRu8iUAcRhwn4=;
        b=Jz1+PRu0n2E15Vf/qVjLQyMAiMh0wcsZxyHdXjjLSylh8kOTYeud4m+r7TyiYDDIwY
         AxsoBwLqHysKwhK8ZhCrxd++CTHeifnZx2H/a7f6897A8184FcTnA8nkSly0zpDgPi8l
         TKdXhZ2aJZmAatpzBOs+lBb7LUlbNYb+axNHN1pnyDXlerc97Ur9a03S8UXOF+Zd74k4
         gqkj6iLTsEnSJQbd2l4qo+JewrHaebREOudXM1ZFKVj+/O7sw5rZ7K4qyVJ/GRsIz6X7
         YYb2KoWhc8MlSNAC5BHhIQEHo2dus1NCcP6Sq5RMpw3G+MhaBbrd5GDjSKW2etMYFYuA
         FiEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679553238;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4npRT0ZBm4ONH6zdpwhBbu8AXu0dsqmRu8iUAcRhwn4=;
        b=F+GEoe07cGIIWeAhK8rnaB5nX1PzvSSmj8di9b4pJkuUVcRXF4MIt2Gh1ez6WZcOJe
         ywQsRHekDOCQYVVfn60CNHvKvGK/E9qUx1wjf3Bmr76jTkjAiXWs1jKm6nYaJx6OBAFn
         RD5NKIF/o6AnCZsZtYIBTnQyXvJzbi6fCxMNdlWGKqms9gitLiCzn2jGj+sgK7oomT9s
         3r5tlZ70ML4ERk/t3l3gk5Fa4QY5RYCGQ63zYsbfx6bWqXPME278kmy0FmOZaQLhJGw0
         mtuU9y+uCbCZUs/aSiwz9897lCJDh1voisEzUGzSrPUwppJR/lY3IGyo04NJ1XMqTcmw
         p6gg==
X-Gm-Message-State: AAQBX9eWuPQtcWNeerXWbmkWogXuqMRxxVoA0BGMtW8EIZzbnyduqpqS
        iUVcvlv/84tzggO8I3/watg25aR2Vp3gKE6HHGxqOA==
X-Google-Smtp-Source: AKy350aHHQKdZp4F3yh5LRMUAbDOYYx+U8YW/TWmS88VUzuhypP1degkbjLzws2GkQD3eUT2N+VpjDY6LDIYMpAhu5A=
X-Received: by 2002:a81:ae1c:0:b0:52e:e095:d840 with SMTP id
 m28-20020a81ae1c000000b0052ee095d840mr1330885ywh.0.1679553237698; Wed, 22 Mar
 2023 23:33:57 -0700 (PDT)
MIME-Version: 1.0
References: <20230323040037.2389095-1-yosryahmed@google.com>
 <20230323040037.2389095-2-yosryahmed@google.com> <CALvZod7e7dMmkhKtXPAxmXjXQoTyeBf3Bht8HJC8AtWW93As3g@mail.gmail.com>
 <CAJD7tkbziGh+6hnMysHkoNr_HGBKU+s1rSGj=gZLki0ALT-jLg@mail.gmail.com>
In-Reply-To: <CAJD7tkbziGh+6hnMysHkoNr_HGBKU+s1rSGj=gZLki0ALT-jLg@mail.gmail.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Wed, 22 Mar 2023 23:33:46 -0700
Message-ID: <CALvZod5GT=bZsLXsG500pNkEJpMB1o2KJau4=r0eHB-c8US53A@mail.gmail.com>
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

On Wed, Mar 22, 2023 at 10:15=E2=80=AFPM Yosry Ahmed <yosryahmed@google.com=
> wrote:
>
[...]
> > Couple of questions:
> >
> > 1. What exactly is cgroup_rstat_lock protecting? Can we just remove it
> > altogether?
>
> I believe it protects the global state variables that we flush into.
> For example, for memcg, it protects mem_cgroup->vmstats.
>
> I tried removing the lock and allowing concurrent flushing on
> different cpus, by changing mem_cgroup->vmstats to use atomics
> instead, but that turned out to be a little expensive. Also,
> cgroup_rstat_lock is already contended by different flushers
> (mitigated by stats_flush_lock on the memcg side). If we remove it,
> concurrent flushers contend on every single percpu lock instead, which
> also seems to be expensive.

We should add a comment on what it is protecting. I think block rstat
are fine but memcg and bpf would need this.

>
> > 2. Are we really calling rstat flush in irq context?
>
> I think it is possible through the charge/uncharge path:
> memcg_check_events()->mem_cgroup_threshold()->mem_cgroup_usage(). I
> added the protection against flushing in an interrupt context for
> future callers as well, as it may cause a deadlock if we don't disable
> interrupts when acquiring cgroup_rstat_lock.
>
> > 3. The mem_cgroup_flush_stats() call in mem_cgroup_usage() is only
> > done for root memcg. Why is mem_cgroup_threshold() interested in root
> > memcg usage? Why not ignore root memcg in mem_cgroup_threshold() ?
>
> I am not sure, but the code looks like event notifications may be set
> up on root memcg, which is why we need to check thresholds.

This is something we should deprecate as root memcg's usage is ill defined.

>
> Even if mem_cgroup_threshold() does not flush memcg stats, the purpose
> of this patch is to make sure the rstat flushing code itself is not
> disabling interrupts; which it currently does for any unsleepable
> context, even if it is interruptible.

Basically I am saying we should aim for VM_BUG_ON(!in_task()) in the
flush function rather than adding should_skip_flush() which does not
stop potential new irq flushers.
