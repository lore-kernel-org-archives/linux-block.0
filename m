Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A19B6C6FD1C
	for <linux-block@archiver.kernel.org>; Thu, 23 Mar 2023 16:03:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231473AbjCWQDN (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 23 Mar 2023 12:03:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231229AbjCWQDL (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 23 Mar 2023 12:03:11 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 053664C0D
        for <linux-block@vger.kernel.org>; Thu, 23 Mar 2023 09:03:02 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id b20so55904047edd.1
        for <linux-block@vger.kernel.org>; Thu, 23 Mar 2023 09:03:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1679587382;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0qq4eAJlExkTdfdM7Y2EFZtPczMJ0l3cf4DT7uOI7JI=;
        b=b2L3krFnhws7f+p6hNHEuWxd6zHS4DqTuXhpP/rStBHvPGchFK0OAE51Mv5Gggdeva
         0g+X1gb+kxTGwE7MuENLR+hBwy5CJCvKIeflwI8gTeX7juPYoXVi6mToYkQu2jsd6VVK
         XkpNk/cz5nwC5XHfmfjMuww1FYcjHs0qPmGVGUo4z9Ghsk7Eb1tXZJTLTmpPar+FodLP
         ufTGqdkDyfaPIyftUYuOdlRHEhAF00xxGUsvAS7AFhZdslbx6UQqkV+Zc9Xvt9lR/pVo
         p0D8+Hc5PEtyv37lvNruiMQD1DsZALHgLLaWg+NZbdFcsLcZ3CNgbGpSXxz9y6+ZVaJt
         NXIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679587382;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0qq4eAJlExkTdfdM7Y2EFZtPczMJ0l3cf4DT7uOI7JI=;
        b=JOw3Ccu5+9PJ9bVINBgwBV/PP48Q6Rw/qBUOH6BCfBaaYfLCAsAQdzHt+NsNxs6U0V
         9odNOytrARJzvmKMmWErKRPYTSVrS8FilI50u1x9VA/FQpLsXlEW/Bg5oJXZlChlmo6F
         yYI6bpuMODVY7BkUG6Xzn87XGjSMqN5kXlqxStFtsWZgp4ulmBTCv9m4U6+UR/E1jO41
         x8e0SNfvKWGAcztaunNiHPtBklV8hy+egby0oGHa74ZJA9om9RBS8/CfkTpc1dOXaF1Z
         P0LRwcRnO8sLi4me03MGuvL0Q/v/bo5a8kpqa9ITrDvesmwaJhLqzKa6OK5dMQN83HRJ
         nxTQ==
X-Gm-Message-State: AO0yUKVzmw6rZ6kGjTQt2Vb0ZPiHtzv6FIxlEd3wogT9N+gNzyHLS6XO
        VqmadxrvJGS1XJ8vkm2KoLSnLNguJY49to1qvprVhg==
X-Google-Smtp-Source: AK7set/CTEwM+vAIIaFjtAYd2scGR7MdjQ8kvYZ6kSB1SLo+YTrn50F185ArhVjN2rVBhkCYuegGR8kNlO2/oWLc7XU=
X-Received: by 2002:a17:906:34cd:b0:8e5:411d:4d09 with SMTP id
 h13-20020a17090634cd00b008e5411d4d09mr5207827ejb.15.1679587382152; Thu, 23
 Mar 2023 09:03:02 -0700 (PDT)
MIME-Version: 1.0
References: <20230323040037.2389095-1-yosryahmed@google.com>
 <20230323040037.2389095-7-yosryahmed@google.com> <20230323160030.GD739026@cmpxchg.org>
In-Reply-To: <20230323160030.GD739026@cmpxchg.org>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Thu, 23 Mar 2023 09:02:25 -0700
Message-ID: <CAJD7tkZ2cOQ8fVRewxznYin6VgeRHiJAQMZbhhi6cT64xfRvqg@mail.gmail.com>
Subject: Re: [RFC PATCH 6/7] workingset: memcg: sleep when flushing stats in workingset_refault()
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

On Thu, Mar 23, 2023 at 9:00=E2=80=AFAM Johannes Weiner <hannes@cmpxchg.org=
> wrote:
>
> On Thu, Mar 23, 2023 at 04:00:36AM +0000, Yosry Ahmed wrote:
> > In workingset_refault(), we call mem_cgroup_flush_stats_delayed() to
> > flush stats within an RCU read section and with sleeping disallowed.
> > Move the call to mem_cgroup_flush_stats_delayed() above the RCU read
> > section and allow sleeping to avoid unnecessarily performing a lot of
> > work without sleeping.
> >
> > Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
> > ---
> >
> > A lot of code paths call into workingset_refault(), so I am not
> > generally sure at all whether it's okay to sleep in all contexts or not=
.
> > Feedback here would be very helpful.
> >
> > ---
> >  mm/workingset.c | 5 ++---
> >  1 file changed, 2 insertions(+), 3 deletions(-)
> >
> > diff --git a/mm/workingset.c b/mm/workingset.c
> > index 042eabbb43f6..410bc6684ea7 100644
> > --- a/mm/workingset.c
> > +++ b/mm/workingset.c
> > @@ -406,6 +406,8 @@ void workingset_refault(struct folio *folio, void *=
shadow)
> >       unpack_shadow(shadow, &memcgid, &pgdat, &eviction, &workingset);
> >       eviction <<=3D bucket_order;
> >
> > +     /* Flush stats (and potentially sleep) before holding RCU read lo=
ck */
> > +     mem_cgroup_flush_stats_delayed(true);
>
> Btw, it might be a good time to rename this while you're in the
> area. delayed suggests this is using a delayed_work, but this is
> actually sometimes flushing directly from the callsite.
>
> What it's doing is ratelimited calls. A better name would be:
>
>         mem_cgroup_flush_stats_ratelimited()

Agreed. Will do in the next version.
