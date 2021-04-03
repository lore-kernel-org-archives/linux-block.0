Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33B5FC43461
	for <linux-block@archiver.kernel.org>; Sat,  3 Apr 2021 05:48:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F14CF61166
	for <linux-block@archiver.kernel.org>; Sat,  3 Apr 2021 05:48:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233382AbhDCFrp (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 3 Apr 2021 01:47:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232157AbhDCFro (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sat, 3 Apr 2021 01:47:44 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADD23C061788
        for <linux-block@vger.kernel.org>; Fri,  2 Apr 2021 22:47:42 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id ay2so3362714plb.3
        for <linux-block@vger.kernel.org>; Fri, 02 Apr 2021 22:47:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=V+wFWYRFis43GOTN2XRu8TgjxNZOmO8IgF4gRsiv9cA=;
        b=pMd1FbuvZ5E2fr1ocmyqnh+uLdNieVu/k08bIWoaWboRu1GuMhWuxbxzopnRIIA9lc
         zKwlsLoFQIrvZO9+Oo5f16yHnpzmH+iue6MrfQZ68f+gsl7xZ5h4aANWgAt4AjBkOBIn
         LczolwaRoieF168IcrjESxGMivxeYdlo7Pm9SyQ/si7aRk4o9K2fQKJkVd7bDtift8BP
         irNQU99mPX+t2pMHMjigsm8Gc9ruDFKeFl/YCvdAbROCuItCoolqDlnbbTsjNsM8SmMt
         RqMuLSmnqc5b8HrGIBHt14Fxr9KQXLtRLhBl5pAV9AM5fVsGMKr2+SMyr/9c/sjy9u4c
         nEdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=V+wFWYRFis43GOTN2XRu8TgjxNZOmO8IgF4gRsiv9cA=;
        b=TJbKxosOQfZIRg5QY734d+EKQPMxpu9kmUo1WNgLUqpH+o/VFeGES22SM7/921pWR/
         twod+MTXU4/11RB3G1ve2SXJP4s6cbZAD5XC61JC/oiIhtCreznyBr7GXtruNVxm/vNE
         LHp8W0PMQdKEhghfVeTuyu6v9DhD78RZCQo98+zY2+zxMAvmh0A5NNJuxosNf8odEnCy
         D5zqoA5h/FNhLS7CHcw85O+v1BZVYG63YyFcv+5WyCqtjfDNH6ZU9CuCjFSiBeQ6g3db
         L33A6SbEl17A+Gg36L9VKujdDk6+HWUPg7wFNWLLmyy4ZCD4P8QG1KGc1rqrI6oIrThT
         6NZw==
X-Gm-Message-State: AOAM530e/h4/r3IusSMSufMKCvBDZXC6VJ1RpWEsi5aqChKw/zZj+sAR
        7KkYuMxWq60ONlSZZddp3jGNVZpb8LyczKJUZOHoew==
X-Google-Smtp-Source: ABdhPJzihZ9i7xdyKbcp25Pn/HT4uvsaH7n4VpVPtgIcyATKoF8snXQWFtthCIKS1/pr04vA/PHK/n8U/ZaD5DfL31I=
X-Received: by 2002:a17:90a:d991:: with SMTP id d17mr16762991pjv.229.1617428862110;
 Fri, 02 Apr 2021 22:47:42 -0700 (PDT)
MIME-Version: 1.0
References: <20210402191638.3249835-1-schatzberg.dan@gmail.com> <20210402191638.3249835-3-schatzberg.dan@gmail.com>
In-Reply-To: <20210402191638.3249835-3-schatzberg.dan@gmail.com>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Sat, 3 Apr 2021 13:47:05 +0800
Message-ID: <CAMZfGtVwxo-UMq8RD_2hpLAbhhYzSkDi_J7kQOJ3yzFz=-5USQ@mail.gmail.com>
Subject: Re: [External] [PATCH 2/3] mm: Charge active memcg when no mm is set
To:     Dan Schatzberg <schatzberg.dan@gmail.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Hugh Dickins <hughd@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        Roman Gushchin <guro@fb.com>, Yang Shi <shy828301@gmail.com>,
        Alex Shi <alex.shi@linux.alibaba.com>,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        Wei Yang <richard.weiyang@gmail.com>,
        "open list:BLOCK LAYER" <linux-block@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:CONTROL GROUP (CGROUP)" <cgroups@vger.kernel.org>,
        "open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>,
        Chris Down <chris@chrisdown.name>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sat, Apr 3, 2021 at 3:17 AM Dan Schatzberg <schatzberg.dan@gmail.com> wrote:
>
> set_active_memcg() worked for kernel allocations but was silently
> ignored for user pages.
>
> This patch establishes a precedence order for who gets charged:
>
> 1. If there is a memcg associated with the page already, that memcg is
>    charged. This happens during swapin.
>
> 2. If an explicit mm is passed, mm->memcg is charged. This happens
>    during page faults, which can be triggered in remote VMs (eg gup).
>
> 3. Otherwise consult the current process context. If there is an
>    active_memcg, use that. Otherwise, current->mm->memcg.
>
> Previously, if a NULL mm was passed to mem_cgroup_charge (case 3) it
> would always charge the root cgroup. Now it looks up the active_memcg
> first (falling back to charging the root cgroup if not set).
>
> Signed-off-by: Dan Schatzberg <schatzberg.dan@gmail.com>
> Acked-by: Johannes Weiner <hannes@cmpxchg.org>
> Acked-by: Tejun Heo <tj@kernel.org>
> Acked-by: Chris Down <chris@chrisdown.name>
> Reviewed-by: Shakeel Butt <shakeelb@google.com>

Reviewed-by: Muchun Song <songmuchun@bytedance.com>

Thanks.
