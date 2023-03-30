Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24F07C761AF
	for <linux-block@archiver.kernel.org>; Thu, 30 Mar 2023 07:44:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229535AbjC3How (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 30 Mar 2023 03:44:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229609AbjC3Hou (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 30 Mar 2023 03:44:50 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 690C12111
        for <linux-block@vger.kernel.org>; Thu, 30 Mar 2023 00:44:48 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id b20so73001720edd.1
        for <linux-block@vger.kernel.org>; Thu, 30 Mar 2023 00:44:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680162287;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=28SBvYRFwm/SwjBANXWTAMmx79zC2hxmQLZYCOkhW7w=;
        b=XC/JQkgUrkQzY6HHF2NhZnpoRWT+0wS9HXMuIuwQTp9rKch4Ytd7OHq7B6ZlYzmoIN
         Xe41PjKT72i8B3/cXTSXEg1IQnDraLRQMJMHYetoWWGjFqE2CxvPrvXHNDWgl87bYMsh
         WdwVVICevoPuzBNIHuJDvQJT1mrphxjAYc2j6LK0KPxJhcnJrlmseiUrxuyv1lwNRTJp
         +FSGoMUedD4yHquuhjfw7Y6nZWzvHcf/ctNL4xVIvIW4rnVlbcVv+Of3qtdTGXL9EZos
         GIk26f60XOLEveR9GlABACeWhYk6kSbAGJ2+4SHw417+h1IQRhKDpuqZ5Zdtzx5YFgxE
         fTzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680162287;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=28SBvYRFwm/SwjBANXWTAMmx79zC2hxmQLZYCOkhW7w=;
        b=i0tfrWH/0W1ZNNYZyxdtSRi7Hm/ioMqXch7rprnITs9p1FPqAy8mERcXPECN1v4fgi
         ejZ4Yt76FXmlFAbFaOjS8micMERx05phrmWY0GPL27a33o86v6uwXZMsDkko8G1Lvs9V
         nyU9H1mhqa3oJ3VtQ8vGEV7p8QcCZqcdX8j8L7UaTlIMl0ql5uWmgQ77gb3k/aW4sx0A
         gzIP02/rh55YlKusP41gCWzya9LwOU6VTz/TB+Qm1BI/RwPr0fG9Uvq5MrjhZ+VcfFPZ
         8j6esVH21Fo2lN6cxEek0vq5mlpQE69w55/Qrrd0RKmvKDNFCSuF38Lg5LtaEyEzlB5i
         kFqA==
X-Gm-Message-State: AAQBX9fcHA6ZojsvLYD2NI6Z5owcNhfzVtPTpu4sqRd3JVs9QNwEijof
        otLsgJsP04dP9kVsYLSsb0EG+GpKQQCG08sS4pFCrg==
X-Google-Smtp-Source: AKy350Z2KiVhFd/82j7EL2NLG85NtAr3M5UdBgwY+5zjpWCG5Fmbo31OIzhdc+eigDSu41dkZqEu1wLkOLOe8mIznuc=
X-Received: by 2002:a17:906:a86:b0:933:f6e8:26d9 with SMTP id
 y6-20020a1709060a8600b00933f6e826d9mr11660266ejf.15.1680162286676; Thu, 30
 Mar 2023 00:44:46 -0700 (PDT)
MIME-Version: 1.0
References: <20230328221644.803272-1-yosryahmed@google.com>
 <20230328221644.803272-9-yosryahmed@google.com> <ZCU9ByZybEi5G5sl@dhcp22.suse.cz>
In-Reply-To: <ZCU9ByZybEi5G5sl@dhcp22.suse.cz>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Thu, 30 Mar 2023 00:44:10 -0700
Message-ID: <CAJD7tkZODvLZOfGaO3gjC2udKNg_G0mA2CT57djjJXrrHNEbbg@mail.gmail.com>
Subject: Re: [PATCH v2 8/9] vmscan: memcg: sleep when flushing stats during reclaim
To:     Michal Hocko <mhocko@suse.com>
Cc:     Tejun Heo <tj@kernel.org>, Josef Bacik <josef@toxicpanda.com>,
        Jens Axboe <axboe@kernel.dk>,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
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

On Thu, Mar 30, 2023 at 12:40=E2=80=AFAM Michal Hocko <mhocko@suse.com> wro=
te:
>
> On Tue 28-03-23 22:16:43, Yosry Ahmed wrote:
> > Memory reclaim is a sleepable context. Allow sleeping when flushing
> > memcg stats to avoid unnecessarily performing a lot of work without
> > sleeping. This can slow down reclaim code if flushing stats is taking
> > too long, but there is already multiple cond_resched()'s in reclaim
> > code.
>
> Why is this preferred? Memory reclaim is surely a slow path but what is
> the advantage of calling mem_cgroup_flush_stats here?

The purpose of this series is to limit calls to atomic flushing as
much as possible, as flushing can become really expensive on systems
with high cpu counts and a lot of cgroups, and performing such an
expensive operation atomically causes problems -- so we'd rather avoid
doing it atomically where possible.

>
> > Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
> > Acked-by: Shakeel Butt <shakeelb@google.com>
> > Acked-by: Johannes Weiner <hannes@cmpxchg.org>
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
> >        * Flush the memory cgroup stats, so that we read accurate per-me=
mcg
> >        * lruvec stats for heuristics.
> >        */
> > -     mem_cgroup_flush_stats_atomic();
> > +     mem_cgroup_flush_stats();
> >
> >       /*
> >        * Determine the scan balance between anon and file LRUs.
> > --
> > 2.40.0.348.gf938b09366-goog
>
> --
> Michal Hocko
> SUSE Labs
