Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13FCFC6FD18
	for <linux-block@archiver.kernel.org>; Tue, 28 Mar 2023 19:02:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229573AbjC1TCk (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 28 Mar 2023 15:02:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229773AbjC1TCj (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 28 Mar 2023 15:02:39 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF0832728
        for <linux-block@vger.kernel.org>; Tue, 28 Mar 2023 12:02:37 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id r11so53834876edd.5
        for <linux-block@vger.kernel.org>; Tue, 28 Mar 2023 12:02:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680030156;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sg40HJuMXcACzrQyQIiyBgX+jk4GkAV6HLHPK6bGfcI=;
        b=F94AXc7U8n866HMI7L7KjxQgYXVxKEX1ufZhLwHPtFEsEhbsNJOSdVF8YWOeQ5aLM0
         HoT7pL2IYk/Ka8HSv4wRc8DPoT9LKGU6kC4eUXtYi4KUjsKzWtw4NZ0JaC2zi57+SF9k
         PZDqO2+41We+vRG0DYNvfpsaofVI5scLONmPNLIPDmXr/Foh6mQni79zrX9y5N5of5mh
         5ruvaxWuRzvpwbFzcBYAzS0m72Fpi2h8g9X9p1A8DJ19cKXspZUb0AuiRNq2QOi8K+0j
         Jqq1L/VZN5Xy8eCU5G6hlRGZ7juOLMyupEtnc+rDhXRk3QeAqm8+9lQ6D3XqDbxU9TST
         VUwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680030156;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sg40HJuMXcACzrQyQIiyBgX+jk4GkAV6HLHPK6bGfcI=;
        b=e0ihQ0USr/sIsVeR69M7uIPts5vi43siXPJPNzwmue2F+SdpAbyo7Bm8CAEtzRrBis
         GFzrrq3SQKsxuEDJUMgOMaScvKRZ24gJTAmGW3QWAnv1xcj1CvnH6RvnX4HKe9rsXUC0
         jXeoyoIM73r73f+WsGOYJBKsP8OI15VcTGP/SM7UWyUyrV4mSaoDK2cFfXPMYRLmFnzR
         PxClGVxpX9oOjTbRXRJCuHmKTqHRdvMKPVpqs8rdNDtpnBO2UToFhE65QbJpBThU6clD
         4C7te0Unl18uGxaD0vcKtrVlehbKPgS+9XVlUKct7ruwWFeVZ9UFvgnk5/wTrrsQaemT
         NkKw==
X-Gm-Message-State: AAQBX9cQ4npERmiSjhqpvWQ7PEBOfF55qsPllwKVaafcovuOjQY+nOD6
        40K+428tFXWsOmACHmVinFYwGm3WxGMWBbC1MxwvxQ==
X-Google-Smtp-Source: AKy350b9CmCnhINIvZWCyCyiJq5/yj1sR/7xu3MCLvibXTNZZv84Tr+hYeSE+IrQB4ragBIAsfNUY+4K5SHaoCEArvM=
X-Received: by 2002:a17:906:a86:b0:933:f6e8:26d9 with SMTP id
 y6-20020a1709060a8600b00933f6e826d9mr8602763ejf.15.1680030155943; Tue, 28 Mar
 2023 12:02:35 -0700 (PDT)
MIME-Version: 1.0
References: <20230328061638.203420-1-yosryahmed@google.com>
 <20230328061638.203420-9-yosryahmed@google.com> <CALvZod7wJ-e-dHEhMynquiqQWFU2j+05wUyUe_yv_rBqJLu2rw@mail.gmail.com>
In-Reply-To: <CALvZod7wJ-e-dHEhMynquiqQWFU2j+05wUyUe_yv_rBqJLu2rw@mail.gmail.com>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Tue, 28 Mar 2023 12:01:59 -0700
Message-ID: <CAJD7tkaKh4w3roqau4V93Q022BG280yzdsh1YSVenZCLm0qVow@mail.gmail.com>
Subject: Re: [PATCH v1 8/9] vmscan: memcg: sleep when flushing stats during reclaim
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Tejun Heo <tj@kernel.org>, Josef Bacik <josef@toxicpanda.com>,
        Jens Axboe <axboe@kernel.dk>,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
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

On Tue, Mar 28, 2023 at 8:19=E2=80=AFAM Shakeel Butt <shakeelb@google.com> =
wrote:
>
> On Mon, Mar 27, 2023 at 11:16=E2=80=AFPM Yosry Ahmed <yosryahmed@google.c=
om> wrote:
> >
> > Memory reclaim is a sleepable context. Allow sleeping when flushing
> > memcg stats to avoid unnecessarily performing a lot of work without
> > sleeping. This can slow down reclaim code if flushing stats is taking
> > too long, but there is already multiple cond_resched()'s in reclaim
> > code.
> >
> > Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
>
> Acked-by: Shakeel Butt <shakeelb@google.com>
>
> > ---
> >  mm/vmscan.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/mm/vmscan.c b/mm/vmscan.c
> > index a9511ccb936f..9c1c5e8b24b8 100644
> > --- a/mm/vmscan.c
> > +++ b/mm/vmscan.c
> > @@ -2845,7 +2845,7 @@ static void prepare_scan_count(pg_data_t *pgdat, =
struct scan_control *sc)
> >          * Flush the memory cgroup stats, so that we read accurate per-=
memcg
> >          * lruvec stats for heuristics.
> >          */
> > -       mem_cgroup_flush_stats_atomic();
> > +       mem_cgroup_flush_stats();
>
> I wonder if we should just replace this with
> mem_cgroup_flush_stats_ratelimited().

Thanks for taking a look!

I was hesitant about doing this because the flush call is inside the
retry loop, and it seems like we want to get fresh stats on each
retry. It seems very likely that we end up not flushing between
retries with mem_cgroup_flush_stats_ratelimited().

Maybe change it if we observe problems with non-atomic flushing?
