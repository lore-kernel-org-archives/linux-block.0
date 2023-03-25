Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61725C6FD1C
	for <linux-block@archiver.kernel.org>; Sat, 25 Mar 2023 04:37:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231636AbjCYEhs (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 25 Mar 2023 00:37:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbjCYEhr (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 25 Mar 2023 00:37:47 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16CD6E1AE
        for <linux-block@vger.kernel.org>; Fri, 24 Mar 2023 21:37:46 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id er18so4132956edb.9
        for <linux-block@vger.kernel.org>; Fri, 24 Mar 2023 21:37:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1679719064;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NMuWO+eqM4F8nQZaJRTjXyqs2/5MQPRiPwC4jEGB2Rs=;
        b=L+/JPY/0iREVQLvI7pggvIU85qKWyZuwLse9KHVQy00x8LnQk15zEqQ2dItfbkf8Xc
         jinjmlAjwTxba/K+cbeiot0mNiIF15Oi4eDBVwxanGDJjspzMRs/QEKZhb3nTnGG20Qk
         VCIX3A1iKO2CtSUq+wB+uKNxtSvCDACGv/ulf6pILtz7hI/K1gI6rhNEP0DsLW0t3JSg
         AzhYalbZFDACojW1EW0rFcfP25ejlhpDyTw+3o3AN5EoMcU49k0QrbmBymzShyxBd/Kn
         HTBVcaYssSwFsoVs2gUZS47oZ5CUrOJQR6m1EZ/9EUrtjdiIBWvfQH4XA7Ier1JLOUtr
         7ZBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679719064;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NMuWO+eqM4F8nQZaJRTjXyqs2/5MQPRiPwC4jEGB2Rs=;
        b=NsLUT9qoF+SQ+Zj+FC+DzSOjDP1NSKbFp6rn7TfMOCVc9Z0l2IAFTtSx6j0tBe+3Q3
         Bx0k5Rpjd+WIqlRVHtP18cI44akFiaYF17T193f/uzxDQ1YXMK/wrcdOgN0o/ryiADvp
         hbIFm+TAMeAGjteTCGkJAACWtoKjxte1mplnCk1ymJJtpr5TgArWYOz7z8FSo79+cUZU
         hOLeOIlCg3ZBrMTn6NHdDAnuqZ9MGi/aioN9vb3Xrtc4F8qqUj0JdoymV++qknKKrYiL
         phmXh2tjppTrXjWbDXK7wGflyqYKHvjfi18ZSS8Yhmwd+smFMw79C3Mlbw1bP7k2rdjf
         97GA==
X-Gm-Message-State: AAQBX9e+m3T5eFd/PPczxyjc7ekkupB3wUUB4RGDWQBogB5AyHKii/kr
        jjIvqm9QWrnFlDabeHe05LCsMP1zsUBQxyNBtK+VrQ==
X-Google-Smtp-Source: AKy350ajeVEN1YL/A5LyBT3MNx+S9894fnEde+UlgHop0XZQuymsxOUauOZsMlfyTFFYpSAYAe/0Nmd3XOqUQC3RIck=
X-Received: by 2002:a17:907:1c09:b0:92f:b329:cb75 with SMTP id
 nc9-20020a1709071c0900b0092fb329cb75mr3153111ejc.5.1679719064436; Fri, 24 Mar
 2023 21:37:44 -0700 (PDT)
MIME-Version: 1.0
References: <20230323040037.2389095-1-yosryahmed@google.com>
 <20230323040037.2389095-2-yosryahmed@google.com> <ZBz/V5a7/6PZeM7S@slm.duckdns.org>
 <CAJD7tkYNZeEytm_Px9_73Y-AYJfHAxaoTmmnO71HW5hd1B5tPg@mail.gmail.com>
 <ZB5UalkjGngcBDEJ@slm.duckdns.org> <CAJD7tkYhyMkD8SFf8b8L1W9QUrLOdw-HJ2NUbENjw5dgFnH3Aw@mail.gmail.com>
 <CALvZod6rF0D21hcV7xnqD+oRkn=x5NLi5GOkPpyaPa859uDH+Q@mail.gmail.com>
In-Reply-To: <CALvZod6rF0D21hcV7xnqD+oRkn=x5NLi5GOkPpyaPa859uDH+Q@mail.gmail.com>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Fri, 24 Mar 2023 21:37:08 -0700
Message-ID: <CAJD7tkY_ESpMYMw72bsATpp6tPphv8qS6VbfEUjpKZW6vUqQSQ@mail.gmail.com>
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

On Fri, Mar 24, 2023 at 9:31=E2=80=AFPM Shakeel Butt <shakeelb@google.com> =
wrote:
>
> On Fri, Mar 24, 2023 at 7:18=E2=80=AFPM Yosry Ahmed <yosryahmed@google.co=
m> wrote:
> >
> [...]
> > Any ideas here are welcome!
> >
>
> Let's move forward. It seems like we are not going to reach an
> agreement on making cgroup_rstat_lock a non-irq lock. However there is
> agreement on the memcg code of not flushing in irq context and the
> cleanup Johannes has requested. Let's proceed with those for now. We
> can come back to cgroup_rstat_lock later if we still see issues in
> production.

Even if we do not flush from irq context, we still flush from atomic
contexts that will currently hold the lock with irqs disabled
throughout the entire flush sequence. A primary purpose of this reason
is to avoid that.

We can either:
(a) Proceed with the following approach of making cgroup_rstat_lock a
non-irq lock.
(b) Proceed with Tejun's suggestion of always releasing and
reacquiring the lock at CPU boundaries, even for atomic flushes (if
the spinlock needs a break ofc).
(c) Something else.

I am happy to proceed with any solution, but we need to address the
fact that interrupts are always disabled throughout the flush. My main
concern about Tejun's suggestion is atomic contexts having to contend
cgroup_rstat_lock much more than they do now, but it's still better
than what we have today.

>
> Tejun, do you have any concerns on adding WARN_ON_ONCE(!in_task()) in
> the rstat flushing code?
