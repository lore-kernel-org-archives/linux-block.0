Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44175C761AF
	for <linux-block@archiver.kernel.org>; Tue, 28 Mar 2023 15:22:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233252AbjC1PWQ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 28 Mar 2023 11:22:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232525AbjC1PV5 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 28 Mar 2023 11:21:57 -0400
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00FA4EF9B
        for <linux-block@vger.kernel.org>; Tue, 28 Mar 2023 08:20:18 -0700 (PDT)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-545e907790fso120226847b3.3
        for <linux-block@vger.kernel.org>; Tue, 28 Mar 2023 08:20:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680016784;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZcS8n/4+59b+VXd6eXMn877oxhRuuiSj8mRyLdeW/tM=;
        b=Ar4Zra7am34XuPMhOvIUcA5xD0kVon3c99ACx4qVdYKc7PvMpeZbPc7LV4yiktxx93
         ugQcjwZKj3vROoqeRauJSOBpb/R7U0idQKpJU7syI6uOUqxt1iBIF8l4r9F7EviaUoDi
         5eGZKwhRwKRZxVY+kApK4O0HT7InuJX8mw3M0HfrCXDYjBj5bNd8FOTKy3yI06ZWgwjO
         HPR0Gz42df+GFqUpBoW8UGumfJGgpC4TxJYcxJ2J6DfmavIUYu4J0xle/MsU2yYWX7OR
         ESI5YObo7wWB9KiZs8NeKzMtj5Q2PHwXIhtBG2Qb1iBMLwwQvMGYO3D8HHRZ3Q70iOfB
         d1KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680016784;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZcS8n/4+59b+VXd6eXMn877oxhRuuiSj8mRyLdeW/tM=;
        b=bZp7NCoudUBGM/W00fXsngm+8n8xHEB7xZFq1K/2om2W6F8biUc8ridqGvnUAFLXpJ
         4vWGYv6WoMyzOIQp8l9pBAE6qIatyujVFZ6qDvhE0dZk2x9cD5UOUE5YkfV5whdmN1MX
         yJdev2s/26qCedKtF4KSSZjR+pOTqbxMdbOrXf5mD6aXA2atHDqlx+ntxjV9QEFfHSrR
         s/FeIG8zRhA6CsfpLqKrh6D4KWvk7wFRYRVjtwIUYXNSMsERySkJlJgIoONwtSwZ6OYd
         Eh6y5AGyKGe6hFVl+XEdQvKAQ9LU3d3iDzBUiuQlsvJX2FyGkWWm+8Is62YpO7SOzBzY
         0TOQ==
X-Gm-Message-State: AAQBX9eGs2v4kfDrVFO9x6v/MO/cpewHdJIb979wAGcynRMBbhGmpVV8
        ogEW/FHB/EblxwjTXzrHD3X45DmSfaI513iKjlrhFw==
X-Google-Smtp-Source: AKy350Z9cmGM4H/7sFJEBekvmzlUQ1sUU694LWzJhS2SSks5o5zMh8yAhNT3YmusP5qBVLKJW5eonGGOovifhFPxfcU=
X-Received: by 2002:a81:4406:0:b0:546:63a:6e23 with SMTP id
 r6-20020a814406000000b00546063a6e23mr2281889ywa.0.1680016784433; Tue, 28 Mar
 2023 08:19:44 -0700 (PDT)
MIME-Version: 1.0
References: <20230328061638.203420-1-yosryahmed@google.com> <20230328061638.203420-9-yosryahmed@google.com>
In-Reply-To: <20230328061638.203420-9-yosryahmed@google.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Tue, 28 Mar 2023 08:19:33 -0700
Message-ID: <CALvZod7wJ-e-dHEhMynquiqQWFU2j+05wUyUe_yv_rBqJLu2rw@mail.gmail.com>
Subject: Re: [PATCH v1 8/9] vmscan: memcg: sleep when flushing stats during reclaim
To:     Yosry Ahmed <yosryahmed@google.com>
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

On Mon, Mar 27, 2023 at 11:16=E2=80=AFPM Yosry Ahmed <yosryahmed@google.com=
> wrote:
>
> Memory reclaim is a sleepable context. Allow sleeping when flushing
> memcg stats to avoid unnecessarily performing a lot of work without
> sleeping. This can slow down reclaim code if flushing stats is taking
> too long, but there is already multiple cond_resched()'s in reclaim
> code.
>
> Signed-off-by: Yosry Ahmed <yosryahmed@google.com>

Acked-by: Shakeel Butt <shakeelb@google.com>

> ---
>  mm/vmscan.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index a9511ccb936f..9c1c5e8b24b8 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -2845,7 +2845,7 @@ static void prepare_scan_count(pg_data_t *pgdat, st=
ruct scan_control *sc)
>          * Flush the memory cgroup stats, so that we read accurate per-me=
mcg
>          * lruvec stats for heuristics.
>          */
> -       mem_cgroup_flush_stats_atomic();
> +       mem_cgroup_flush_stats();

I wonder if we should just replace this with
mem_cgroup_flush_stats_ratelimited().
