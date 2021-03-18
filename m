Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC62FC433E0
	for <linux-block@archiver.kernel.org>; Thu, 18 Mar 2021 15:54:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A560964DFF
	for <linux-block@archiver.kernel.org>; Thu, 18 Mar 2021 15:54:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231992AbhCRPx5 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 18 Mar 2021 11:53:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232004AbhCRPxs (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 18 Mar 2021 11:53:48 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 963F1C06174A
        for <linux-block@vger.kernel.org>; Thu, 18 Mar 2021 08:53:47 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id u10so5349174lff.1
        for <linux-block@vger.kernel.org>; Thu, 18 Mar 2021 08:53:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pq/eBnxufGHS03GB6g8W63yjQMuRCa5QlbRp3PwKUEw=;
        b=bgdV4hZplv+94CUHWEbu9IHkjeAlUPO8LEb5m90TFIXf2m9HsOiO9yTkUsNDIdAL/2
         rBZTdVoEZ257H5o2v1HojtAp7qwdrf7q6Ii2ntKX7WkOrgSD01JG2StigU5YHcWoqSJZ
         bTXqHezszXCYygdvLZ/D4lwuJVAa88DpyGrABJ/xN9LlrHbBIre4dBG8nHgZCCo7PWaS
         YykPvxidGKJ7WFvtyyCMDgKpOdLSC7cUPueTA3LN63sNMlGVX/MIeRRWbisyCFlEdCpG
         VXqLfvbBzVRVVJY9HgvpGs9mCleH1KBcPG9F1+PKCOZB9CKurbXljzRWCaGovWH1biG9
         +hXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pq/eBnxufGHS03GB6g8W63yjQMuRCa5QlbRp3PwKUEw=;
        b=U3WmBYfIJEptE3oa90DIB6qhq0dO3phNEcwomAMUWciJwh05wbZbjHAz+Z7nqLtAmg
         uA4encCGGczn4kPxErtDoHrE57teYjSNj7r18oxFrQEA6OpKypvPx8BRLvi+2eBceQds
         Yqq58W67zBVt2ttFLPeHSBYfQ95LP/8yiSgY2DNxb4iDDQuuWIYjWXSEzu5qRHRkPTG7
         rnbIcqVOHDf37ZergU69QjcJRH6ciRnlNZxEHFYuqtVKueiXI9yakdhJ6SWpqe8Wv7sb
         uA6vNCcQPVvqgAl1sP7T3nqiTRTITiCFBeez7VGV5R3/+sy8TQtEA5vtFv02UwRETzIp
         EK9w==
X-Gm-Message-State: AOAM532pkJ3JvKP1WYEKBt2G4alnWWDdV3eGAaP3LhEou8znzU58KFxQ
        IsfDU3xojyAQyPn7KyQ/2oSF0qjdadPJTtU8y1B58A==
X-Google-Smtp-Source: ABdhPJxEgWeS33XZh839tg6ABZ5gTUZAm8ikQzXDtakEINgKM9uy1FMacx7hcnhzqgiPX7UJktfr+qQJhl78XhvdRtk=
X-Received: by 2002:a19:3804:: with SMTP id f4mr5990396lfa.117.1616082825932;
 Thu, 18 Mar 2021 08:53:45 -0700 (PDT)
MIME-Version: 1.0
References: <20210316153655.500806-1-schatzberg.dan@gmail.com> <7ca79335-026f-2511-2b58-0e9f32caa063@kernel.dk>
In-Reply-To: <7ca79335-026f-2511-2b58-0e9f32caa063@kernel.dk>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Thu, 18 Mar 2021 08:53:32 -0700
Message-ID: <CALvZod6tvrZ_sj=BnM4baQepexwvOPREx3qe5ZJrmqftrqwBEA@mail.gmail.com>
Subject: Re: [PATCH v10 0/3] Charge loop device i/o to issuing cgroup
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Dan Schatzberg <schatzberg.dan@gmail.com>,
        Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
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

On Wed, Mar 17, 2021 at 3:30 PM Jens Axboe <axboe@kernel.dk> wrote:
>
> On 3/16/21 9:36 AM, Dan Schatzberg wrote:
> > No major changes, just rebasing and resubmitting
>
> Applied for 5.13, thanks.
>

I have requested a couple of changes in the patch series. Can this
applied series still be changed or new patches are required?
