Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2D19C77B62
	for <linux-block@archiver.kernel.org>; Wed, 29 Mar 2023 19:21:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229950AbjC2TVH (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 29 Mar 2023 15:21:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229884AbjC2TVG (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 29 Mar 2023 15:21:06 -0400
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADFAF1BEC
        for <linux-block@vger.kernel.org>; Wed, 29 Mar 2023 12:21:01 -0700 (PDT)
Received: by mail-pf1-x44a.google.com with SMTP id c2-20020a62f842000000b0062d93664ad5so3663302pfm.19
        for <linux-block@vger.kernel.org>; Wed, 29 Mar 2023 12:21:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680117661;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rfZvqShst60fq0wp5Hd6CWbOA4VhTmutSDYPExlyEXg=;
        b=H0HTcxi+11KbmtI0NnZKken4gqGU30NVBIOXe5Ym+r94WHMk+Wdg4ZxVSslfqZDErA
         p1CffdA6GETpLvX14PamFdnEKbV9xc3/VVsGzXgOubwToOv1z9fKxdR258oxXyb1Hn+S
         PW255z7NeXKDaFqo1ZagUjan2SrzuPb1Hr4g+mCEJtrRouWKHIYvoBp7Q8iAwOZtRKxL
         WFy2wa6Ok5Amur24xaFxfEG41hDISgvMkbUR4OCW+qFTXIlmEqGHLlju9y5VD9RmOA7R
         2HrEviyteTp8gt3HE9qsKY0Fnvecb9R5YTTkbYtJvpDt4JanY8H9F9bnOgWPzZMZLKdf
         Gb/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680117661;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=rfZvqShst60fq0wp5Hd6CWbOA4VhTmutSDYPExlyEXg=;
        b=zqikN7AAuNNrgvUJ5g125FbC19mKLyec+dLl9a/Tuanh7Jykyu8KWPUGj2IXgOi14h
         l+eLe7NVtw11u0YtFmoJdMFuGc2GWIrG+z44ObnX8p8XTf3fWpnokTrdRH4p/4yZHvxf
         BbeIlUdAhzyawq69l5wlqD+XM9L5bSlYaoi/0GzZOBjXAjtPmx4sd+z6qGsawLZEldee
         i+p7Vh8kXR+/TcV2mvM4wRsOddkhIby3P/cjbRocD2USe2xyT1kMxik/heNM40EzqYxr
         FWxMEKzoOe6w26/+p+j2SThoASqttUX2oc5lpfXrDOQD7URpaVe2+ej76gcJkYxyTHdr
         uTdw==
X-Gm-Message-State: AAQBX9fhRugWKc+TB3GmAL+0Y2q9ImrieIQ5PaxeKaQsKyp17uvgx74P
        BtMbdoFEWQgwq9oSA54bD5Gegc7hMMyjLg==
X-Google-Smtp-Source: AKy350aWkfrvyoLQhQjt4Tg+Y9288yGqHXK9dFGy7vkq1HDy0mf04gx38HhyneMLDblIphokIDYOq6dlg8qWIQ==
X-Received: from shakeelb.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:262e])
 (user=shakeelb job=sendgmr) by 2002:a65:5c47:0:b0:513:3def:2c6d with SMTP id
 v7-20020a655c47000000b005133def2c6dmr4478026pgr.4.1680117661176; Wed, 29 Mar
 2023 12:21:01 -0700 (PDT)
Date:   Wed, 29 Mar 2023 19:20:59 +0000
In-Reply-To: <CAJD7tkb-UpKm2QbjYzB=B=oGk6Hyj9cbUviZUPC+7VsvBecH7g@mail.gmail.com>
Mime-Version: 1.0
References: <20230328221644.803272-1-yosryahmed@google.com>
 <20230328221644.803272-5-yosryahmed@google.com> <ZCQfZJFufkJ10o01@dhcp22.suse.cz>
 <CAJD7tkb-UpKm2QbjYzB=B=oGk6Hyj9cbUviZUPC+7VsvBecH7g@mail.gmail.com>
Message-ID: <20230329192059.2nlme5ubshzdbpg6@google.com>
Subject: Re: [PATCH v2 4/9] cgroup: rstat: add WARN_ON_ONCE() if flushing
 outside task context
From:   Shakeel Butt <shakeelb@google.com>
To:     Yosry Ahmed <yosryahmed@google.com>
Cc:     Michal Hocko <mhocko@suse.com>, Tejun Heo <tj@kernel.org>,
        Josef Bacik <josef@toxicpanda.com>,
        Jens Axboe <axboe@kernel.dk>,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Muchun Song <muchun.song@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Michal =?utf-8?Q?Koutn=C3=BD?=" <mkoutny@suse.com>,
        Vasily Averin <vasily.averin@linux.dev>,
        cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        bpf@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Mar 29, 2023 at 11:41:39AM -0700, Yosry Ahmed wrote:
> On Wed, Mar 29, 2023 at 4:22=E2=80=AFAM Michal Hocko <mhocko@suse.com> wr=
ote:
> >
> > On Tue 28-03-23 22:16:39, Yosry Ahmed wrote:
> > > rstat flushing is too expensive to perform in irq context.
> > > The previous patch removed the only context that may invoke an rstat
> > > flush from irq context, add a WARN_ON_ONCE() to detect future
> > > violations, or those that we are not aware of.
> > >
> > > Ideally, we wouldn't flush with irqs disabled either, but we have one
> > > context today that does so in mem_cgroup_usage(). Forbid callers from
> > > irq context for now, and hopefully we can also forbid callers with ir=
qs
> > > disabled in the future when we can get rid of this callsite.
> >
> > I am sorry to be late to the discussion. I wanted to follow up on
> > Johannes reply in the previous version but you are too fast ;)
> >
> > I do agree that this looks rather arbitrary. You do not explain how the
> > warning actually helps. Is the intention to be really verbose to the
> > kernel log when somebody uses this interface from the IRQ context and
> > get bug reports? What about configurations with panic on warn? Do we
> > really want to crash their systems for something like that?
>=20
> Thanks for taking a look, Michal!
>=20
> The ultimate goal is not to flush in irq context or with irqs
> disabled, as in some cases it causes irqs to be disabled for a long
> time, as flushing is an expensive operation. The previous patch in the
> series should have removed the only context that flushes in irq
> context, and the purpose of the WARN_ON_ONCE() is to catch future uses
> or uses that we might have missed.
>=20
> There is still one code path that flushes with irqs disabled (also
> mem_cgroup_usage()), and we cannot remove this just yet; we need to
> deprecate usage threshold events for root to do that. So we cannot
> enforce not flushing with irqs disabled yet.
>=20
> So basically the patch is trying to enforce what we have now, not
> flushing in irq context, and hopefully at some point we will also be
> able to enforce not flushing with irqs disabled.
>=20
> If WARN_ON_ONCE() is the wrong tool for this, please let me know.
>=20

If I understand Michal's concern, the question is should be start with
pr_warn_once() instead of WARN_ON_ONCE() and I think yes we should start
with pr_warn_once().

