Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9005C76196
	for <linux-block@archiver.kernel.org>; Tue, 28 Mar 2023 13:25:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232583AbjC1NZl (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 28 Mar 2023 09:25:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233079AbjC1NZf (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 28 Mar 2023 09:25:35 -0400
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FCF4B774
        for <linux-block@vger.kernel.org>; Tue, 28 Mar 2023 06:25:25 -0700 (PDT)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-53d277c1834so229112097b3.10
        for <linux-block@vger.kernel.org>; Tue, 28 Mar 2023 06:25:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680009924;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aKr9MaZxGZc9u8ZhIE9so1jdgqHxAOgc8JTrWbL9sqY=;
        b=i9jvfdCeB9SsJnyBiAbhdPLhoxjsfRopr7eARS5rGyPO0aOs26naUPy0TOlNDXReWF
         R5Ea79kbAr+glBAXFOfEsjm49+Nm5fB3G3LIqw9DO4pIhWqBfQICEKbBtdAas72TZMRa
         2naeIrUIfdDmFPzU0ieyV8VHQOarplR5OZFhsLhdFTJ17Qsili22215RkxE3w61P7NqR
         QN1VePuwazlq07Mx1/r+u1FhPyrqxDDF2mBmsHwUrqWufwHsPj0sdlguYWltwhWjNVjP
         5VKvQ0LXJosLvebPB+Yu1xwBQd5x8bAJlaPp08d3BXWvpGTaWuuE3u78gHSrMcThnKrJ
         Ve5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680009924;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aKr9MaZxGZc9u8ZhIE9so1jdgqHxAOgc8JTrWbL9sqY=;
        b=fot3zGPkwLsYctWXWadDdkvv+/Ia/WosNWC2AMB4Lno0p5F/W/PSV71fOM/tLdbYAP
         aFRnpkrh6DCD5hcxpYylcC88N+Li/vLUmuQ6iQAs6EOEuci4JqEgXufS8Alow6eLkZR+
         W8FCLOvIWt2rMJlsDNmb7uZwYzl4XSrRN5lgSrzsccvppWQmJb7TqvqaCAcjBcKvQVVq
         xnzww9j8pgHpmiTW8XXyNGIbYd/pbntGyFeYb/HRWkYPo487JReN3diGMC6XcBncMw4W
         wfcDclvkI75yVFlv0sPRuZ1UattoqvbVk/sipygztCrQ7sncH1e20jHm/RsFOSK8XHQh
         EObg==
X-Gm-Message-State: AAQBX9dpTQzLVujiFbUztVXderiXsDe2dCdb2w81Yzmgu8+jpRuSIaDt
        TFpmutNUOMfkfkfMK2OyAF2o2HFzE9hHoCSmdaJmwA==
X-Google-Smtp-Source: AKy350ZqnYLSmT7eJTq65fiNra/60hMVxVRo2NTN5O7ip/pdM6ESKQ/7QeIH3HPcBu0i1k4EPDQhyQj9uL9p9e2MRY0=
X-Received: by 2002:a81:e546:0:b0:546:1ef:54f9 with SMTP id
 c6-20020a81e546000000b0054601ef54f9mr2180958ywm.0.1680009924474; Tue, 28 Mar
 2023 06:25:24 -0700 (PDT)
MIME-Version: 1.0
References: <20230328061638.203420-1-yosryahmed@google.com> <20230328061638.203420-3-yosryahmed@google.com>
In-Reply-To: <20230328061638.203420-3-yosryahmed@google.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Tue, 28 Mar 2023 06:25:13 -0700
Message-ID: <CALvZod50Kh602rFii_=8q+_xdZTqHfDJyc_XNNTixGTqgcSDHA@mail.gmail.com>
Subject: Re: [PATCH v1 2/9] memcg: rename mem_cgroup_flush_stats_"delayed" to "ratelimited"
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
> mem_cgroup_flush_stats_delayed() suggests his is using a delayed_work,
> but this is actually sometimes flushing directly from the callsite.
>
> What it's doing is ratelimited calls. A better name would be
> mem_cgroup_flush_stats_ratelimited().
>
> Suggested-by: Johannes Weiner <hannes@cmpxchg.org>
> Signed-off-by: Yosry Ahmed <yosryahmed@google.com>

Acked-by: Shakeel Butt <shakeelb@google.com>
