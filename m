Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7871CC6FD18
	for <linux-block@archiver.kernel.org>; Tue, 28 Mar 2023 22:20:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229479AbjC1WU0 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 28 Mar 2023 18:20:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbjC1WUZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 28 Mar 2023 18:20:25 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9772330E1
        for <linux-block@vger.kernel.org>; Tue, 28 Mar 2023 15:19:53 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id ew6so55670306edb.7
        for <linux-block@vger.kernel.org>; Tue, 28 Mar 2023 15:19:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680041945;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wL4GcqYYIvPt1Pi6ck7hlX2oFSHc5TZT9/OZ5kAArQo=;
        b=ZC6EC0DFE1hHUTV2LBaIFnK+dTTA9H/SYOdOb0dhH00vk7KbwRxBEbTfOOdBRB86Rg
         jg44S7degscRQn7Sr3Wx0ShbNoWLNgtyWVzLTr9J/rMgQ0cWTowD4bfEmQX06+cuuYTr
         HuVqdAQMIhsByAw/q1S4YbnR52GCVi0abm/WefRvQ/pX3odeyr4l8J7PPCwpfNHEHsUn
         ZaK2Ex2ZdabfxXoUFAPPmjleoMH3gRvtZCtys7cEv9WMJSFpV2zbljOiJsAo5MHnFGbU
         ASJUQ6Kq8/VVtikM1hs1wkVX107ltZ305Vjzbe+0lVumZUAQFAFUKuOIpWqYW77w9swX
         l64w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680041945;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wL4GcqYYIvPt1Pi6ck7hlX2oFSHc5TZT9/OZ5kAArQo=;
        b=7YYZbHCfEaB6E7pehUdfOEoAkZpQNOqVDYYP/6NGCS4fToAjuFYsg6VDqBmOoSxaGm
         X/2V6EBIU0xg/7wrTMxWcvx1N5RE+TlHHS7x45wcSM8amQxDy5hz6ls8yM7Q57WjsS9W
         DMigeLLbBflfZPj967dBoNwg7/G8v+2dA06l8cz8PvwB07UcEe2Pd8qPXqNgFXECYkhi
         jNZv0B1O3u9VeGLfR1hjfIbgYANpi+0Pr3xLHZJH/VfAau9kp3VokobOf2Zu86u66h8x
         gRoRFTVDO2J+Ld8+3+Sjo3pB75QFnHqSOStb1hba9oK5wF6GSmumRB9UcH4wrFWLbPYT
         SDVQ==
X-Gm-Message-State: AAQBX9dGi5H3PWlUnGdoV9o32JkLbX/SVzEpPFriN6zKBUMrFh1Z3J/7
        ZuQ/YcNGt/2u4x9DE5WibaZCPbP6RQWQsKDc2+p3rw==
X-Google-Smtp-Source: AKy350Z4C/jI32HkAY9H/dgh0JWOOLFeqOZ+tvXMBkyhDXhXLrRjYAYqvUg43BMDuFvB7c8TpMkVsY1yKzKOXPlCFEo=
X-Received: by 2002:a50:d6d6:0:b0:4fb:9735:f915 with SMTP id
 l22-20020a50d6d6000000b004fb9735f915mr8284499edj.8.1680041945249; Tue, 28 Mar
 2023 15:19:05 -0700 (PDT)
MIME-Version: 1.0
References: <20230328061638.203420-1-yosryahmed@google.com>
 <20230328061638.203420-5-yosryahmed@google.com> <ZCMojk50vjiK6mBe@cmpxchg.org>
 <CAJD7tkYA=0rKSmtQzYQpZ2DuUoJq0bQcVqPgSpVEs0M4zAktnw@mail.gmail.com>
In-Reply-To: <CAJD7tkYA=0rKSmtQzYQpZ2DuUoJq0bQcVqPgSpVEs0M4zAktnw@mail.gmail.com>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Tue, 28 Mar 2023 15:18:28 -0700
Message-ID: <CAJD7tkbH8WQ8K-pQZVwnz9ZaJ=iHBE-LDnzpD7Dzd1zf_xMx4g@mail.gmail.com>
Subject: Re: [PATCH v1 4/9] cgroup: rstat: add WARN_ON_ONCE() if flushing
 outside task context
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Tejun Heo <tj@kernel.org>, Josef Bacik <josef@toxicpanda.com>,
        Jens Axboe <axboe@kernel.dk>,
        Zefan Li <lizefan.x@bytedance.com>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <muchun.song@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>,
        =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
        Vasily Averin <vasily.averin@linux.dev>,
        cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Mar 28, 2023 at 11:59=E2=80=AFAM Yosry Ahmed <yosryahmed@google.com=
> wrote:
>
> On Tue, Mar 28, 2023 at 10:49=E2=80=AFAM Johannes Weiner <hannes@cmpxchg.=
org> wrote:
> >
> > On Tue, Mar 28, 2023 at 06:16:33AM +0000, Yosry Ahmed wrote:
> > > rstat flushing is too expensive to perform in irq context.
> > > The previous patch removed the only context that may invoke an rstat
> > > flush from irq context, add a WARN_ON_ONCE() to detect future
> > > violations, or those that we are not aware of.
> > >
> > > Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
> > > ---
> > >  kernel/cgroup/rstat.c | 2 ++
> > >  1 file changed, 2 insertions(+)
> > >
> > > diff --git a/kernel/cgroup/rstat.c b/kernel/cgroup/rstat.c
> > > index d3252b0416b6..c2571939139f 100644
> > > --- a/kernel/cgroup/rstat.c
> > > +++ b/kernel/cgroup/rstat.c
> > > @@ -176,6 +176,8 @@ static void cgroup_rstat_flush_locked(struct cgro=
up *cgrp, bool may_sleep)
> > >  {
> > >       int cpu;
> > >
> > > +     /* rstat flushing is too expensive for irq context */
> > > +     WARN_ON_ONCE(!in_task());
> > >       lockdep_assert_held(&cgroup_rstat_lock);
> >
> > This seems a bit arbitrary. Why is an irq caller forbidden, but an
> > irq-disabled, non-preemptible section caller is allowed? The latency
> > impact on the system would be the same, right?
>
> Thanks for taking a look.
>
> So in the first patch series the initial purpose was to make sure
> cgroup_rstat_lock was never acquired in an irq context, so that we can
> stop disabling irqs while holding it. Tejun disagreed with this
> approach though.
>
> We currently have one caller that calls flushing with irqs disabled
> (mem_cgroup_usage()) -- so we cannot forbid such callers (yet), but I
> thought we can at least forbid callers from irq context now (or catch
> those that we are not aware of), and then maybe forbid irqs_disabled()
> contexts as well we can get rid of that callsite.
>
> WDYT?

I added more context in the commit log in the v2 respin [1]. Let me
know if you want me to change something else, rephrase the comment, or
drop the patch entirely.

[1]https://lore.kernel.org/linux-mm/20230328221644.803272-5-yosryahmed@goog=
le.com/
