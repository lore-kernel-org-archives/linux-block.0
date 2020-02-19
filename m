Return-Path: <SRS0=ya0H=4H=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF4E6C18E00
	for <linux-block@archiver.kernel.org>; Wed, 19 Feb 2020 19:37:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8185324654
	for <linux-block@archiver.kernel.org>; Wed, 19 Feb 2020 19:37:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="yaW/aMLv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726777AbgBSThR (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 19 Feb 2020 14:37:17 -0500
Received: from mail-qv1-f66.google.com ([209.85.219.66]:42034 "EHLO
        mail-qv1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726751AbgBSThQ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 19 Feb 2020 14:37:16 -0500
Received: by mail-qv1-f66.google.com with SMTP id dc14so733162qvb.9
        for <linux-block@vger.kernel.org>; Wed, 19 Feb 2020 11:37:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=DFD/PBmG0P7U1KLcfwxQ00ort/KIczMCNrbTAdH0j9g=;
        b=yaW/aMLvoyD72gqf9JCZfvj8P+9plgT82zxsbaIugjOxyXEvghFgPPkSW1TqZoFdOz
         4tr15KFItwTQfQhiWTeY+8Srat3gbX/RQ6Hgm8rIjfZHfqUEOtVpm0Q0y6F6cxJPlxus
         aT1ZO43r5M7YLtCgzwbt1D8ZnTuATju1/2pg5HZAfLmHpY1Yh/Z7A5oBPM+qsrjhzFYg
         06X+pEaoT5XF8PuErVI1qHsDU1VgFW1ysvMlUiI/+N+tGsYUStvrmG0W7bnou7gueZLc
         ihBEHv0EAdrzu6j9rSD6n8XlF0kXuGg2ShChO3x4tSekiZ9F5qExxRVGGzQojLOTDfO1
         jLJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=DFD/PBmG0P7U1KLcfwxQ00ort/KIczMCNrbTAdH0j9g=;
        b=E9MHfNfp89eT/AuCAlIeoz0mSkcn08x/Amfhj+3BeEtm5G1ksuQ4Bd1Yf7hZCeVlXV
         /lFaihUydW9yLUV7fX3pRJ2a4j+2Li+zhaYocXAIhh8KzVUkkwLhXK4e+bHtMjpKBZOU
         bsr08JAtUK/NacFO+EGpElBZcjHRcH/7cEem5mdcZZe7iKDXW0DXUC7qIGrzcnFehP6S
         TgJh3Xq8artzjmv5/UXCl6TsP2ipgOTGefez/Fc6s9S4Ngy6MLQtxFSGUV7yQOwLngzC
         Rs0ntRPmIlBHwFQ7FmDo/DCP2T+F+opWNfLx0nU2ty4TA8m8ePjnXYhPElZxIOYDMc4R
         7WjA==
X-Gm-Message-State: APjAAAVfek34iRNp3eiszkLk4ydqw6b/gWKhhmPMuP55sZLH4uLPF2G6
        5g7F8H5gq5yE9/Ku46J5qfI+Gg==
X-Google-Smtp-Source: APXvYqyfbQYqHz8jNbpOiu+R9QyUIIq8WOjAeGKUtgBcTkoS963BuB06JV4msDsxj+JkbPRZevPQmg==
X-Received: by 2002:a05:6214:50f:: with SMTP id v15mr22688159qvw.42.1582141032641;
        Wed, 19 Feb 2020 11:37:12 -0800 (PST)
Received: from localhost ([2620:10d:c091:500::2:3bde])
        by smtp.gmail.com with ESMTPSA id p2sm344987qkg.102.2020.02.19.11.37.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2020 11:37:12 -0800 (PST)
Date:   Wed, 19 Feb 2020 14:37:11 -0500
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Chris Down <chris@chrisdown.name>
Cc:     Dan Schatzberg <dschatzberg@fb.com>, Jens Axboe <axboe@kernel.dk>,
        Tejun Heo <tj@kernel.org>, Li Zefan <lizefan@huawei.com>,
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
Message-ID: <20200219193711.GC54486@cmpxchg.org>
References: <cover.1581088326.git.dschatzberg@fb.com>
 <8e41630b9d1c5d00f92a00f998285fa6003af5eb.1581088326.git.dschatzberg@fb.com>
 <20200207211807.GA138184@chrisdown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200207211807.GA138184@chrisdown.name>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Feb 07, 2020 at 09:18:07PM +0000, Chris Down wrote:
> > @@ -6856,8 +6857,12 @@ int mem_cgroup_try_charge(struct page *page, struct mm_struct *mm,
> > 		}
> > 	}
> > 
> > -	if (!memcg)
> > -		memcg = get_mem_cgroup_from_mm(mm);
> > +	if (!memcg) {
> > +		if (!mm)
> > +			memcg = get_mem_cgroup_from_current();
> > +		else
> > +			memcg = get_mem_cgroup_from_mm(mm);
> > +	}
> 
> Just to do due diligence, did we double check whether this results in any
> unintentional shift in accounting for those passing in both mm and memcg as
> NULL with no current->active_memcg set, since previously we never even tried
> to consult current->mm and always used root_mem_cgroup in
> get_mem_cgroup_from_mm?

Excellent question on a subtle issue.

But nobody actually passes NULL. They either pass current->mm (or a
destination mm) in syscalls, or vma->vm_mm in page faults.

The only times we end up with NULL is when kernel threads do something
and have !current->mm. We redirect those to root_mem_cgroup.

So this patch doesn't change those semantics.
