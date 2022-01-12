Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D847FC4332F
	for <linux-block@archiver.kernel.org>; Wed, 12 Jan 2022 17:33:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355735AbiALRdu (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 12 Jan 2022 12:33:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355680AbiALRdf (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 12 Jan 2022 12:33:35 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3663DC06173F
        for <linux-block@vger.kernel.org>; Wed, 12 Jan 2022 09:33:35 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id n30-20020a17090a5aa100b001b2b6509685so6159739pji.3
        for <linux-block@vger.kernel.org>; Wed, 12 Jan 2022 09:33:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=QTT6XNlZaHloaWKh9RlDBcbi7e/Mx29t7wQ9qiCr9Wk=;
        b=McJ9rx6ho4q7bQA5UEc5Hl+SPzzXrSF17SbhpQ9arHbQBNEEZqy5jlQaRdedoCU+fb
         VU0nKy9XA71b2jesQEk9fGOzp7AddLJC4uxRqwulc2+EHQbNX8r3QdRtMnI4HuAk30HK
         NNsPKgd0VY9SEUP3yZnIy1nyo6rH9Vz0cfGe/nxlPBqipEB2RkFd5twZ5+QDnS6VTGO0
         p6wIEer4taQvMZJEbEsB26Z0OZiztq97Isph2FaOsF5lptQ3GnDlkv1dsDpCRYB3S98J
         kentlDg19ZSanmjpfQQsOIUnAINkHq4ylwi0oygiwnouXEzZJSo0jOHS88LVV5iBjTs8
         NUfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=QTT6XNlZaHloaWKh9RlDBcbi7e/Mx29t7wQ9qiCr9Wk=;
        b=iHsSN3omsz/J26Vvvx/W0BhbfPKwXgRxwETgUvKn4sz06RbDCFBTlKrPjE/TLXZvCW
         9m+Atff/MSoxBBb3RFi8/L4o5xwlNQGyn7DFKsQNzFogQppIbyI/UMbFjRbxABO8tU5Q
         UDqKhYwjES/zsrAX98aNhVXtje51vViwjk0kRONgUcakWHau+Du++1qiP2sSPo+m5fcx
         M5I+hjTRVRPv17p+T3ZbCuuLcRZj9tvoHGQx0HxqNoG9eZs/FTGvnjcWnYb294CkHJ+6
         M8w8Jdxvxttr8A4Ha1te39BTsQ30iZjpWGHt1y9VdarHjWDMYTMtpOl0ZyLLpzzhn87f
         ktmw==
X-Gm-Message-State: AOAM530iozIhvZP58PDLy/oH/G4CREYUwO9b6079dpT2ou0Bf88lH8dX
        W8ebyv66pUp2t6j6WC8FSj8=
X-Google-Smtp-Source: ABdhPJwKijslZUpfhxrNVx/g1iCkKFSqKCsY14+CZzSIGCrvJV9N8a5p2muRe42uf+WJol2H6N8G3g==
X-Received: by 2002:a17:90b:4a47:: with SMTP id lb7mr662190pjb.126.1642008814586;
        Wed, 12 Jan 2022 09:33:34 -0800 (PST)
Received: from google.com ([2620:15c:211:201:b6c7:c163:623d:56bc])
        by smtp.gmail.com with ESMTPSA id y31sm243277pfa.67.2022.01.12.09.33.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jan 2022 09:33:34 -0800 (PST)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date:   Wed, 12 Jan 2022 09:33:32 -0800
From:   Minchan Kim <minchan@kernel.org>
To:     "Huang, Ying" <ying.huang@intel.com>
Cc:     Yu Zhao <yuzhao@google.com>,
        Mauricio Faria de Oliveira <mfo@canonical.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-block@vger.kernel.org, Miaohe Lin <linmiaohe@huawei.com>,
        Yang Shi <shy828301@gmail.com>
Subject: Re: [PATCH v2] mm: fix race between MADV_FREE reclaim and blkdev
 direct IO read
Message-ID: <Yd8Q7Cplp5xLTYlV@google.com>
References: <20220105233440.63361-1-mfo@canonical.com>
 <Yd0oLWtVAyAexyQc@google.com>
 <87v8ypybdc.fsf@yhuang6-desk2.ccr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87v8ypybdc.fsf@yhuang6-desk2.ccr.corp.intel.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Jan 12, 2022 at 09:46:23AM +0800, Huang, Ying wrote:
> Yu Zhao <yuzhao@google.com> writes:
> 
> > On Wed, Jan 05, 2022 at 08:34:40PM -0300, Mauricio Faria de Oliveira wrote:
> >> diff --git a/mm/rmap.c b/mm/rmap.c
> >> index 163ac4e6bcee..8671de473c25 100644
> >> --- a/mm/rmap.c
> >> +++ b/mm/rmap.c
> >> @@ -1570,7 +1570,20 @@ static bool try_to_unmap_one(struct page *page, struct vm_area_struct *vma,
> >>  
> >>  			/* MADV_FREE page check */
> >>  			if (!PageSwapBacked(page)) {
> >> -				if (!PageDirty(page)) {
> >> +				int ref_count = page_ref_count(page);
> >> +				int map_count = page_mapcount(page);
> >> +
> >> +				/*
> >> +				 * The only page refs must be from the isolation
> >> +				 * (checked by the caller shrink_page_list() too)
> >> +				 * and one or more rmap's (dropped by discard:).
> >> +				 *
> >> +				 * Check the reference count before dirty flag
> >> +				 * with memory barrier; see __remove_mapping().
> >> +				 */
> >> +				smp_rmb();
> >> +				if ((ref_count - 1 == map_count) &&
> >> +				    !PageDirty(page)) {
> >>  					/* Invalidate as we cleared the pte */
> >>  					mmu_notifier_invalidate_range(mm,
> >>  						address, address + PAGE_SIZE);
> >
> > Out of curiosity, how does it work with COW in terms of reordering?
> > Specifically, it seems to me get_page() and page_dup_rmap() in
> > copy_present_pte() can happen in any order, and if page_dup_rmap()
> > is seen first, and direct io is holding a refcnt, this check can still
> > pass?
> 
> I think that you are correct.
> 
> After more thoughts, it appears very tricky to compare page count and
> map count.  Even if we have added smp_rmb() between page_ref_count() and
> page_mapcount(), an interrupt may happen between them.  During the
> interrupt, the page count and map count may be changed, for example,
> unmapped, or do_swap_page().

Yeah, it happens but what specific problem are you concerning from the
count change under race? The fork case Yu pointed out was already known
for breaking DIO so user should take care not to fork under DIO(Please
look at O_DIRECT section in man 2 open). If you could give a specific
example, it would be great to think over the issue.

I agree it's little tricky but it seems to be way other place has used
for a long time(Please look at write_protect_page in ksm.c).
So, here what we missing is tlb flush before the checking.

Something like this.

diff --git a/mm/rmap.c b/mm/rmap.c
index b0fd9dc19eba..b4ad9faa17b2 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -1599,18 +1599,8 @@ static bool try_to_unmap_one(struct page *page, struct vm_area_struct *vma,

                        /* MADV_FREE page check */
                        if (!PageSwapBacked(page)) {
-                               int refcount = page_ref_count(page);
-
-                               /*
-                                * The only page refs must be from the isolation
-                                * (checked by the caller shrink_page_list() too)
-                                * and the (single) rmap (dropped by discard:).
-                                *
-                                * Check the reference count before dirty flag
-                                * with memory barrier; see __remove_mapping().
-                                */
-                               smp_rmb();
-                               if (refcount == 2 && !PageDirty(page)) {
+                               if (!PageDirty(page) &&
+                                       page_mapcount(page) + 1 == page_count(page)) {
                                        /* Invalidate as we cleared the pte */
                                        mmu_notifier_invalidate_range(mm,
                                                address, address + PAGE_SIZE);
diff --git a/mm/vmscan.c b/mm/vmscan.c
index f3162a5724de..6454ff5c576f 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -1754,6 +1754,9 @@ static unsigned int shrink_page_list(struct list_head *page_list,
                        enum ttu_flags flags = TTU_BATCH_FLUSH;
                        bool was_swapbacked = PageSwapBacked(page);

+                       if (!was_swapbacked && PageAnon(page))
+                               flags &= ~TTU_BATCH_FLUSH;
+
                        if (unlikely(PageTransHuge(page)))
                                flags |= TTU_SPLIT_HUGE_PMD;






