Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0DB3C433E6
	for <linux-block@archiver.kernel.org>; Tue, 16 Mar 2021 16:26:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 892E66508E
	for <linux-block@archiver.kernel.org>; Tue, 16 Mar 2021 16:26:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235497AbhCPQZl (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 16 Mar 2021 12:25:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238708AbhCPQZd (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 16 Mar 2021 12:25:33 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19C1CC06175F
        for <linux-block@vger.kernel.org>; Tue, 16 Mar 2021 09:25:33 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id q25so63362921lfc.8
        for <linux-block@vger.kernel.org>; Tue, 16 Mar 2021 09:25:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TPPV6ZX3Tdhvd5ax8oWrAMyN2NntSRwXfaI6WubILUM=;
        b=GqzIDfmCJYvYrFRGXeic57AzgBH3b1U4AAYEYp2J5pjfw4f/EnP9cLB/T6t1r6TAVg
         tMrVgaaocuUTM4D5JtLmSuQIu2yoT7UwXVom1It5Gr99hKftdLRf8bFHTTW90fpDcSxG
         LAklID4UlfQ5039uo09+40JkCw6EmElu4y5DRj8kxbylRlUp4Q2u5Vdg5DPlB9Pd0Bi2
         T4/d+1t2uvMESJRFgocJF9lvTDwHRjPJUtXR2rDn4rU3r5/Gp0EtxNgynOSacujSpjVU
         vmQw90Z074wG2SsY7t61SI+FYrKEojLMY+5Ts4h8dkCyGw/ZjTFaDaYPYDf/Dcb5Mjhn
         wp0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TPPV6ZX3Tdhvd5ax8oWrAMyN2NntSRwXfaI6WubILUM=;
        b=Z+NXHtSZx0xVabzkBAUJPohvi+SUFcCyiHVSxBTzZkahsV4OwGVkmqMllQJdMMbPFk
         C5E52IWymANnJD37+RRHn5XauF4IFF3otsnmgLMqz/UUbwhc9J6mHSAQ4SyS4gD/V6yZ
         QZWWll5lHKJSvHVAuk4ns+R0RLlTuRWSWNNPQqnchuWvCwbrGH/ftO2MWYZ1em1tJzzI
         T3xLWYMC/rJQDsLAc5Z3aAI9v/Sw/UCdr5SH7MF6+HtsW1TD9K5sA9ObyHn6QzIToZVS
         1mOXQKd/6LsRhK8d3/r7suhhGEvo93KYWHRhhlhhkIenCEh1Othr9dPfW4nr4qAFzwKR
         yvtQ==
X-Gm-Message-State: AOAM532MKrxvbhhx1bBLVAmGOVY9LrP4ROzQGPyhAgdQ29tMUT4FLKw6
        SlyDfzncEzsf3/pfHMhPRRhL+zknMB2Xuev+Lcwmsg==
X-Google-Smtp-Source: ABdhPJwQax98b9r+LloLeVzpURQWBJz/Z6VclirjaaFs0GEYtgmAXB7YpLkqvIrfK/L8srjer8T+p/MPbsW3QvkKVXk=
X-Received: by 2002:a19:f50e:: with SMTP id j14mr11828246lfb.299.1615911930635;
 Tue, 16 Mar 2021 09:25:30 -0700 (PDT)
MIME-Version: 1.0
References: <20210316153655.500806-1-schatzberg.dan@gmail.com> <20210316153655.500806-4-schatzberg.dan@gmail.com>
In-Reply-To: <20210316153655.500806-4-schatzberg.dan@gmail.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Tue, 16 Mar 2021 09:25:18 -0700
Message-ID: <CALvZod7tDf3vvspJmS551GkiNbSdCH9VWNgWMesmUi2Q3NkgKA@mail.gmail.com>
Subject: Re: [PATCH 3/3] loop: Charge i/o to mem and blk cg
To:     Dan Schatzberg <schatzberg.dan@gmail.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Hugh Dickins <hughd@google.com>, Roman Gushchin <guro@fb.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Alex Shi <alex.shi@linux.alibaba.com>,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        Chris Down <chris@chrisdown.name>,
        Yafang Shao <laoar.shao@gmail.com>,
        Wei Yang <richard.weiyang@gmail.com>,
        "open list:BLOCK LAYER" <linux-block@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:CONTROL GROUP (CGROUP)" <cgroups@vger.kernel.org>,
        "open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Mar 16, 2021 at 8:37 AM Dan Schatzberg <schatzberg.dan@gmail.com> wrote:
>
[...]
>
>  /* Support for loadable transfer modules */
> diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> index 0c04d39a7967..fd5dd961d01f 100644
> --- a/include/linux/memcontrol.h
> +++ b/include/linux/memcontrol.h
> @@ -1187,6 +1187,17 @@ static inline struct mem_cgroup *get_mem_cgroup_from_mm(struct mm_struct *mm)
>         return NULL;
>  }
>
> +static inline struct mem_cgroup *get_mem_cgroup_from_page(struct page *page)
> +{
> +       return NULL;
> +}

The above function has been removed.
