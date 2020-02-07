Return-Path: <SRS0=URwg=33=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6192C2BA83
	for <linux-block@archiver.kernel.org>; Fri,  7 Feb 2020 21:18:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A947222C2
	for <linux-block@archiver.kernel.org>; Fri,  7 Feb 2020 21:18:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chrisdown.name header.i=@chrisdown.name header.b="GfoGaC+/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726987AbgBGVSK (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 7 Feb 2020 16:18:10 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:38433 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726947AbgBGVSJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 7 Feb 2020 16:18:09 -0500
Received: by mail-wr1-f66.google.com with SMTP id y17so547164wrh.5
        for <linux-block@vger.kernel.org>; Fri, 07 Feb 2020 13:18:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=s3/+t3C/iGaUgSEBBn4UBiEXAA3Z2xiPjiTjCVmDGl8=;
        b=GfoGaC+/D2IbhwLnfJa3biAe5iPkr+OuRXLKcIZgOZFgYGtGR/dc32KDVeiUu1TXk0
         eWPSWbZikyLpSAEg8CB0va7Ozm1hhXJZLf0Y/bQn/fhxnQL9eZUGeWjN+xq/u9jl7qtc
         WAnaA0kz6pznkybaVC/dd561pV315aJX4mGaU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=s3/+t3C/iGaUgSEBBn4UBiEXAA3Z2xiPjiTjCVmDGl8=;
        b=KRaCvTWdvqDbzOrR4pAvKVNO4g4FPTHkWbgoFQ2f9KW+/4Hy/SJmNNL7Bk8PzjAF4A
         jyIWGpsikBqwrAWL61mmNKcPqWXKNqCj6OhXRHo1oSX/kwwQyfT96m7qcXquxT25U6ah
         m6GjvxyfBIiCiri7Yti4LWIi2SWN3Na3ZVu8Q9aAf9mOxg5TSsYowOQIAQFJ0tnYPDub
         8h9jNw/JHzFxjlanfm2eDs3LtVm3rpVNP8rlesj0NPiIhSfhkkC4C6EglTnzJ5eCgsBc
         /oly/wwu0CDjQbqzYmKkzlm7ytpFo6exMlyxAJtnu3N107gu8tO8PMUgyXfDLJ+/h3fN
         Qr2A==
X-Gm-Message-State: APjAAAWtFHBqFasSLjCqW4UDQqTV+IDT3V2QJDwsBPadJhg4Sdd5utbo
        LplJjS5AKbRhPt4xUokEXVhMnw==
X-Google-Smtp-Source: APXvYqxec00hS/YwBZ499yu47bZwrCh/oZd5f0f9T0ew/bFtZ3FCmODRG59pIZ1Nw2V66uA6cc49Eg==
X-Received: by 2002:adf:e88f:: with SMTP id d15mr912024wrm.186.1581110288231;
        Fri, 07 Feb 2020 13:18:08 -0800 (PST)
Received: from localhost ([2a01:4b00:8432:8a00:63de:dd93:20be:f460])
        by smtp.gmail.com with ESMTPSA id c9sm4672886wme.41.2020.02.07.13.18.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Feb 2020 13:18:07 -0800 (PST)
Date:   Fri, 7 Feb 2020 21:18:07 +0000
From:   Chris Down <chris@chrisdown.name>
To:     Dan Schatzberg <dschatzberg@fb.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>,
        Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <guro@fb.com>,
        Shakeel Butt <shakeelb@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "open list:BLOCK LAYER" <linux-block@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:CONTROL GROUP (CGROUP)" <cgroups@vger.kernel.org>,
        "open list:CONTROL GROUP - MEMORY RESOURCE CONTROLLER (MEMCG)" 
        <linux-mm@kvack.org>
Subject: Re: [PATCH v2 2/3] mm: Charge active memcg when no mm is set
Message-ID: <20200207211807.GA138184@chrisdown.name>
References: <cover.1581088326.git.dschatzberg@fb.com>
 <8e41630b9d1c5d00f92a00f998285fa6003af5eb.1581088326.git.dschatzberg@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <8e41630b9d1c5d00f92a00f998285fa6003af5eb.1581088326.git.dschatzberg@fb.com>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Dan Schatzberg writes:
>This is a dependency for 3/3

This can be omitted, since "3" won't mean anything in the change history (and 
patch series are generally considered as a unit unless there are explicit 
requests to split them out).

>memalloc_use_memcg() worked for kernel allocations but was silently
>ignored for user pages.
>
>This patch establishes a precedence order for who gets charged:
>
>1. If there is a memcg associated with the page already, that memcg is
>   charged. This happens during swapin.
>
>2. If an explicit mm is passed, mm->memcg is charged. This happens
>   during page faults, which can be triggered in remote VMs (eg gup).
>
>3. Otherwise consult the current process context. If it has configured
>   a current->active_memcg, use that. Otherwise, current->mm->memcg.
>
>Signed-off-by: Dan Schatzberg <dschatzberg@fb.com>
>Acked-by: Johannes Weiner <hannes@cmpxchg.org>

Thanks, this seems reasonable. One (minor and optional) suggestion would be to 
make the title more clear that this is a change in 
try_charge/memalloc_use_memcg behaviour overall rather than a charge site, 
since this wasn't what I expected to find when I saw the patch title :-)

I only have one other question about behaviour when there is no active_memcg 
and mm/memcg in try_charge are NULL below, but assuming that's been checked:

Acked-by: Chris Down <chris@chrisdown.name>

>---
> mm/memcontrol.c | 11 ++++++++---
> mm/shmem.c      |  2 +-
> 2 files changed, 9 insertions(+), 4 deletions(-)
>
>diff --git a/mm/memcontrol.c b/mm/memcontrol.c
>index f7da3ff135ed..69935d166bdb 100644
>--- a/mm/memcontrol.c
>+++ b/mm/memcontrol.c
>@@ -6812,7 +6812,8 @@ enum mem_cgroup_protection mem_cgroup_protected(struct mem_cgroup *root,
>  * @compound: charge the page as compound or small page
>  *
>  * Try to charge @page to the memcg that @mm belongs to, reclaiming
>- * pages according to @gfp_mask if necessary.
>+ * pages according to @gfp_mask if necessary. If @mm is NULL, try to
>+ * charge to the active memcg.
>  *
>  * Returns 0 on success, with *@memcgp pointing to the charged memcg.
>  * Otherwise, an error code is returned.
>@@ -6856,8 +6857,12 @@ int mem_cgroup_try_charge(struct page *page, struct mm_struct *mm,
> 		}
> 	}
>
>-	if (!memcg)
>-		memcg = get_mem_cgroup_from_mm(mm);
>+	if (!memcg) {
>+		if (!mm)
>+			memcg = get_mem_cgroup_from_current();
>+		else
>+			memcg = get_mem_cgroup_from_mm(mm);
>+	}

Just to do due diligence, did we double check whether this results in any 
unintentional shift in accounting for those passing in both mm and memcg as 
NULL with no current->active_memcg set, since previously we never even tried to 
consult current->mm and always used root_mem_cgroup in get_mem_cgroup_from_mm?

It's entirely possible that this results in exactly the same outcome as before 
just by different means, but with the number of try_charge callsites I'm not 
totally certain of that.

>
> 	ret = try_charge(memcg, gfp_mask, nr_pages, false);
>
>diff --git a/mm/shmem.c b/mm/shmem.c
>index ca74ede9e40b..70aabd9aba1a 100644
>--- a/mm/shmem.c
>+++ b/mm/shmem.c
>@@ -1748,7 +1748,7 @@ static int shmem_getpage_gfp(struct inode *inode, pgoff_t index,
> 	}
>
> 	sbinfo = SHMEM_SB(inode->i_sb);
>-	charge_mm = vma ? vma->vm_mm : current->mm;
>+	charge_mm = vma ? vma->vm_mm : NULL;
>
> 	page = find_lock_entry(mapping, index);
> 	if (xa_is_value(page)) {
>--
>2.17.1
>
