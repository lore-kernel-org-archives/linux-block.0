Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22364C761A6
	for <linux-block@archiver.kernel.org>; Tue,  4 Apr 2023 17:14:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235215AbjDDROG (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 4 Apr 2023 13:14:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235071AbjDDROB (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 4 Apr 2023 13:14:01 -0400
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B1FF10FA
        for <linux-block@vger.kernel.org>; Tue,  4 Apr 2023 10:13:59 -0700 (PDT)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-544787916d9so626352597b3.13
        for <linux-block@vger.kernel.org>; Tue, 04 Apr 2023 10:13:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680628438;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jB81HM7QxwklDvE39D9zGEd7EL3RK9tGsVExEctIF9g=;
        b=RTE9uUoI7XQ8R2+nrWW7Yx58+ErEPGeeDfqbJ/xGvvaIQ77F/wmkQ1JiRiLzfMk3ds
         aGgu1IiS++nn+phVSuzWXmhmnnCR/c6rjOJll7kCeyjgPiFt1rAHATUDSo6RV05Qzvc2
         xUkU5W+YitmDn4UuYTkJUwt6iLG7fqJ2JdKIaUoaN4I5bJucmRLBWHWQyYSLVRgj5Kb9
         YYRNr9aHII9yl6U38B61zDPm53mjPR6kWofIAAjQ+MEUUeIyy/AFwTH+9VuLtJzwYqJj
         tf1x0gtzBFYsSXZzhLN/ugTsZ4z2Nt+9QfJqs8jO0/JRmH/lPnHVRTX2DCl54PANUWGW
         Ny3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680628438;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jB81HM7QxwklDvE39D9zGEd7EL3RK9tGsVExEctIF9g=;
        b=v4vR2AhsyghHFSHPYWMcBXJir2xOQ8h7z1edlbd6HPU++GkeBGcB8s418W/vq6ve/r
         74koFiK/w/8LJcFBCS9O267aLf/wRtbPW5VeX96d3ZpmiPUGZUu+jWns7FaZkdeT+5qn
         TCJi4OjEaH7shgHmf8/zpHEBvPZGze5lnGf7J++d4mVSnn+Z2+ipFHkfpMCHvvuAqzM1
         ZbFYIp2K9PtG3/gJxwwMzim96b0EMsVSubQbCsikd87a1QhfVqWchWVoX7oMDby1Oq0u
         e40BA7SSvbT8BXphflb9cbwgaPxOXVrzA5U2qwfW461oEUwkfmcH0J8SyieLurxnOQP/
         F1KQ==
X-Gm-Message-State: AAQBX9eeFKmXfNjDVrWMKgqeT28ObZeRjcA3bW8hx4LUOMgq/p0qP3Q3
        MIs+xwUpc3MAmKJ9Ot19JeqzKBMLDCyvJatDbBmjYg==
X-Google-Smtp-Source: AKy350YfkE1yBZsZo/vuErzxwl0ifJq9+FUSZScFb3AOn/d315UWmv+qL4nxuP4OOnhzt5F3cFDZLFK9czXb9I4PiPQ=
X-Received: by 2002:a81:ac0d:0:b0:52b:fd10:4809 with SMTP id
 k13-20020a81ac0d000000b0052bfd104809mr1973994ywh.0.1680628438438; Tue, 04 Apr
 2023 10:13:58 -0700 (PDT)
MIME-Version: 1.0
References: <20230330191801.1967435-1-yosryahmed@google.com>
 <20230330191801.1967435-5-yosryahmed@google.com> <20230404165258.ie6ttxobbmgn62hs@blackpad>
In-Reply-To: <20230404165258.ie6ttxobbmgn62hs@blackpad>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Tue, 4 Apr 2023 10:13:47 -0700
Message-ID: <CALvZod5Y+quOS1XQvVBTvv7FRs3455j_79f0GoR+FqCFzbwkuA@mail.gmail.com>
Subject: Re: [PATCH v3 4/8] memcg: replace stats_flush_lock with an atomic
To:     =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>
Cc:     Yosry Ahmed <yosryahmed@google.com>, Tejun Heo <tj@kernel.org>,
        Josef Bacik <josef@toxicpanda.com>,
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
        bpf@vger.kernel.org, Michal Hocko <mhocko@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Apr 4, 2023 at 9:53=E2=80=AFAM Michal Koutn=C3=BD <mkoutny@suse.com=
> wrote:
>
> Hello.
>
> On Thu, Mar 30, 2023 at 07:17:57PM +0000, Yosry Ahmed <yosryahmed@google.=
com> wrote:
> >  static void __mem_cgroup_flush_stats(void)
> >  {
> > -     unsigned long flag;
> > -
> > -     if (!spin_trylock_irqsave(&stats_flush_lock, flag))
> > +     /*
> > +      * We always flush the entire tree, so concurrent flushers can ju=
st
> > +      * skip. This avoids a thundering herd problem on the rstat globa=
l lock
> > +      * from memcg flushers (e.g. reclaim, refault, etc).
> > +      */
> > +     if (atomic_read(&stats_flush_ongoing) ||
> > +         atomic_xchg(&stats_flush_ongoing, 1))
> >               return;
>
> I'm curious about why this instead of
>
>         if (atomic_xchg(&stats_flush_ongoing, 1))
>                 return;
>
> Is that some microarchitectural cleverness?
>

Yes indeed it is. Basically we want to avoid unconditional cache
dirtying. This pattern is also used at other places in the kernel like
qspinlock.
