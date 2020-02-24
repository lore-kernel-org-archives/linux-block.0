Return-Path: <SRS0=9TSA=4M=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA76AC38BFA
	for <linux-block@archiver.kernel.org>; Mon, 24 Feb 2020 22:27:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D3B2222C2
	for <linux-block@archiver.kernel.org>; Mon, 24 Feb 2020 22:27:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jjb/ltj6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727459AbgBXW1G (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 24 Feb 2020 17:27:06 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:35532 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726651AbgBXW1F (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 24 Feb 2020 17:27:05 -0500
Received: by mail-pf1-f193.google.com with SMTP id i19so6090775pfa.2
        for <linux-block@vger.kernel.org>; Mon, 24 Feb 2020 14:27:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=N8uW5I9vM7M9dgZNeVW89oSVwdXb7JJspNMFnTdsIHM=;
        b=jjb/ltj6Dl/BLTImTnJOx8f83qe1X4RzfCIi0nAKuiuNm3I+v4BiMZM3nVaxBwTeMc
         l3pBEm+HLYafUv3VwQdccIkJfM7jJ17q2NBMff+Xrh7g8a2/wWd/VZqn0/VA0K9pVNrk
         2rvarsLrO+8NmUy3S4E0Tr8l1mM/QmYgVZlVIq2QZKbZI7ZAeWabBUvaEWdKlGaQ713s
         aLRbqW0JQ3aTtmT/yflWtlmiIFAfgGsy/8fRQUq3qM8XyzI/PWHF10BSbeQv/UVNyryi
         wI/S7mR3tpBOQY7dW143Gh5Rc1V8IlnUBh3Ec6i14WV6z65uFb3RZ+h9gU6MwghxdEmk
         tbaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=N8uW5I9vM7M9dgZNeVW89oSVwdXb7JJspNMFnTdsIHM=;
        b=FggDHq0qWwvArvGhK/GuinW6DGmDf4z2QgtZUT9E0sxl6IvefIPmdRHppSqZ6Hwnzz
         8iMJ+Aga6rFnUzDrRed8ieakQTfb9o1+7HMVgtP5yiMqczY+2MpBt9dHJMB0RaoI4XDN
         1ibDWbnkvpzhf5EvQcdQ89I5+HyfSl3U/luspVwCbXdimbNEfA8uYXgyURcvR3C+sxBh
         5mTdNBpHNyjt0OrFRjnojAkseLkjSWdZJkWyUjow4s+Ls6v0NXrv02PGO+5y7fe3Le+/
         y2p0KupBWp2XKpFtBDBmoxsA+h1B5Vgkl+kPKI+LAxwtL0dNuD+RB0/b5Nr73A7j9b74
         MZOQ==
X-Gm-Message-State: APjAAAVIlr7gO/aTFszBHYtS00DEjujzf9CcW4m6u/G670LmPi5R8pjH
        lWytVaM1r3/46AZ+5EhfCCNSCA==
X-Google-Smtp-Source: APXvYqzh5p4xJuU9VecvA+EavGY+LuUQ1KKByt917r/gAyMV0FwOD6sP6TJIudNiZHy7NfjhmNHCAQ==
X-Received: by 2002:a63:1a5b:: with SMTP id a27mr3598267pgm.249.1582583224197;
        Mon, 24 Feb 2020 14:27:04 -0800 (PST)
Received: from [100.112.92.218] ([104.133.9.106])
        by smtp.gmail.com with ESMTPSA id v25sm13820038pfe.147.2020.02.24.14.27.02
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 24 Feb 2020 14:27:03 -0800 (PST)
Date:   Mon, 24 Feb 2020 14:26:45 -0800 (PST)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@eggly.anvils
To:     Dan Schatzberg <schatzberg.dan@gmail.com>
cc:     Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>,
        Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>, Roman Gushchin <guro@fb.com>,
        Shakeel Butt <shakeelb@google.com>,
        Chris Down <chris@chrisdown.name>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "open list:BLOCK LAYER" <linux-block@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:CONTROL GROUP (CGROUP)" <cgroups@vger.kernel.org>,
        "open list:CONTROL GROUP - MEMORY RESOURCE CONTROLLER (MEMCG)" 
        <linux-mm@kvack.org>
Subject: Re: [PATCH v3 2/3] mm: Charge active memcg when no mm is set
In-Reply-To: <4456276af198412b2d41cd09d246cd20e0c6d22a.1582581887.git.schatzberg.dan@gmail.com>
Message-ID: <alpine.LSU.2.11.2002241425001.1576@eggly.anvils>
References: <cover.1582581887.git.schatzberg.dan@gmail.com> <4456276af198412b2d41cd09d246cd20e0c6d22a.1582581887.git.schatzberg.dan@gmail.com>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, 24 Feb 2020, Dan Schatzberg wrote:

> memalloc_use_memcg() worked for kernel allocations but was silently
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
> 3. Otherwise consult the current process context. If it has configured
>    a current->active_memcg, use that. Otherwise, current->mm->memcg.
> 
> Previously, if a NULL mm was passed to mem_cgroup_try_charge (case 3) it
> would always charge the root cgroup. Now it looks up the current
> active_memcg first (falling back to charging the root cgroup if not
> set).
> 
> Signed-off-by: Dan Schatzberg <schatzberg.dan@gmail.com>
> Acked-by: Johannes Weiner <hannes@cmpxchg.org>
> Acked-by: Tejun Heo <tj@kernel.org>
> Acked-by: Chris Down <chris@chrisdown.name>

Acked-by: Hugh Dickins <hughd@google.com>

> Reviewed-by: Shakeel Butt <shakeelb@google.com>
> Signed-off-by: Dan Schatzberg <schatzberg.dan@gmail.com>
> ---
>  mm/memcontrol.c | 11 ++++++++---
>  mm/shmem.c      |  4 ++--
>  2 files changed, 10 insertions(+), 5 deletions(-)
> 
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index d09776cd6e10..222e4aac0c85 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -6319,7 +6319,8 @@ enum mem_cgroup_protection mem_cgroup_protected(struct mem_cgroup *root,
>   * @compound: charge the page as compound or small page
>   *
>   * Try to charge @page to the memcg that @mm belongs to, reclaiming
> - * pages according to @gfp_mask if necessary.
> + * pages according to @gfp_mask if necessary. If @mm is NULL, try to
> + * charge to the active memcg.
>   *
>   * Returns 0 on success, with *@memcgp pointing to the charged memcg.
>   * Otherwise, an error code is returned.
> @@ -6363,8 +6364,12 @@ int mem_cgroup_try_charge(struct page *page, struct mm_struct *mm,
>  		}
>  	}
>  
> -	if (!memcg)
> -		memcg = get_mem_cgroup_from_mm(mm);
> +	if (!memcg) {
> +		if (!mm)
> +			memcg = get_mem_cgroup_from_current();
> +		else
> +			memcg = get_mem_cgroup_from_mm(mm);
> +	}
>  
>  	ret = try_charge(memcg, gfp_mask, nr_pages);
>  
> diff --git a/mm/shmem.c b/mm/shmem.c
> index c8f7540ef048..8664c97851f2 100644
> --- a/mm/shmem.c
> +++ b/mm/shmem.c
> @@ -1631,7 +1631,7 @@ static int shmem_swapin_page(struct inode *inode, pgoff_t index,
>  {
>  	struct address_space *mapping = inode->i_mapping;
>  	struct shmem_inode_info *info = SHMEM_I(inode);
> -	struct mm_struct *charge_mm = vma ? vma->vm_mm : current->mm;
> +	struct mm_struct *charge_mm = vma ? vma->vm_mm : NULL;
>  	struct mem_cgroup *memcg;
>  	struct page *page;
>  	swp_entry_t swap;
> @@ -1766,7 +1766,7 @@ static int shmem_getpage_gfp(struct inode *inode, pgoff_t index,
>  	}
>  
>  	sbinfo = SHMEM_SB(inode->i_sb);
> -	charge_mm = vma ? vma->vm_mm : current->mm;
> +	charge_mm = vma ? vma->vm_mm : NULL;
>  
>  	page = find_lock_entry(mapping, index);
>  	if (xa_is_value(page)) {
> -- 
> 2.17.1
