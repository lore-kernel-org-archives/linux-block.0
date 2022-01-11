Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86D93C433EF
	for <linux-block@archiver.kernel.org>; Tue, 11 Jan 2022 18:54:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245171AbiAKSyN (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 11 Jan 2022 13:54:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243121AbiAKSyM (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 11 Jan 2022 13:54:12 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89EC5C06173F
        for <linux-block@vger.kernel.org>; Tue, 11 Jan 2022 10:54:12 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id r16-20020a17090a0ad000b001b276aa3aabso7087736pje.0
        for <linux-block@vger.kernel.org>; Tue, 11 Jan 2022 10:54:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=bwERjAnR0E8SZooIPfKQaM9IMhOZ/X6J9PXJ2PYB2W4=;
        b=X+HSsF3lEwmP2DUMlMwfhkC568VHYqa49c6EpGGf0TPOOP2Fh0B8GeJiC/oGwRf+EY
         T4YPAI5cgP7J7/RbbPaFT9wr1SL3l+SBOl5Ni3TipuT9+KCeJMDBQREemlM2x3rUu7gE
         XAnKop5vKlzUXc3r/53bUCZvxhDGsBp7FMHSwp2fFJTgwIYl8kYyElEKzHd/5ahJu+xv
         R38qjcBCj53z06E7r1Kgpwlnsestr1B6Wi1gBeyIjHUz6+CWychPUgfr+QJVugDL4M9b
         +wt2f6kf4a1eKHK10RGr+ul5Y3S+cQ7/rWxvxPzWoBkBTbxvYr6mG1y+cuw3SCi0xCVd
         Q6dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=bwERjAnR0E8SZooIPfKQaM9IMhOZ/X6J9PXJ2PYB2W4=;
        b=OL9w7cSNCA6aQeYC9XhAv8WWR/1bxLnO0am+YpxgF7Hs9ZPl1d/GuOrzrWXyqlfifU
         k6BWc2djMxuLaGzwzwkev/75g2nA9c2bpYOFxyoui0bsxUIgBSLjtgezqixAriXzK0bb
         +wdQWMDf9HKArJdPCFIROpi22B471sMwggQlbIgeuugLzeYBxH19H7OtAVEAHgDPXWyJ
         WZe0atWosItrPa7V/pcBLfnszhWdM49BDhdb+bKHAA3TJDRonPaiV8ELD3xbHWEVeFS+
         0Q9J+xYdOlni4baJ/pmbsLqtZ+AEd8fSnEI2M6WkmPSt2lZssK5OMnLAErVfk4QWETHw
         GwMA==
X-Gm-Message-State: AOAM5319dyJwMbpr9h63jltGzBVW4oniQ1sPaw7HOJxYVUd46Zvh2Y0m
        qyrl8sipWXwhU3OjLRAOeLc=
X-Google-Smtp-Source: ABdhPJzJsABTOD6BKQzdvZCLEq0qLqut3UGKMBl3QzPZX6WpUBi2lpe5kSt5q/I9beJKFV59g+5+Ew==
X-Received: by 2002:a17:902:ea07:b0:14a:45c0:78a7 with SMTP id s7-20020a170902ea0700b0014a45c078a7mr5725617plg.92.1641927251994;
        Tue, 11 Jan 2022 10:54:11 -0800 (PST)
Received: from google.com ([2620:15c:211:201:4f0e:ffc8:3f7b:ac89])
        by smtp.gmail.com with ESMTPSA id g11sm1124958pfv.136.2022.01.11.10.54.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jan 2022 10:54:11 -0800 (PST)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date:   Tue, 11 Jan 2022 10:54:09 -0800
From:   Minchan Kim <minchan@kernel.org>
To:     Yu Zhao <yuzhao@google.com>
Cc:     Mauricio Faria de Oliveira <mfo@canonical.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-block@vger.kernel.org, Huang Ying <ying.huang@intel.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Yang Shi <shy828301@gmail.com>,
        John Hubbard <jhubbard@nvidia.com>
Subject: Re: [PATCH v2] mm: fix race between MADV_FREE reclaim and blkdev
 direct IO read
Message-ID: <Yd3SUXVy7MbyBzFw@google.com>
References: <20220105233440.63361-1-mfo@canonical.com>
 <Yd0oLWtVAyAexyQc@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yd0oLWtVAyAexyQc@google.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Jan 10, 2022 at 11:48:13PM -0700, Yu Zhao wrote:
> On Wed, Jan 05, 2022 at 08:34:40PM -0300, Mauricio Faria de Oliveira wrote:
> > diff --git a/mm/rmap.c b/mm/rmap.c
> > index 163ac4e6bcee..8671de473c25 100644
> > --- a/mm/rmap.c
> > +++ b/mm/rmap.c
> > @@ -1570,7 +1570,20 @@ static bool try_to_unmap_one(struct page *page, struct vm_area_struct *vma,
> >  
> >  			/* MADV_FREE page check */
> >  			if (!PageSwapBacked(page)) {
> > -				if (!PageDirty(page)) {
> > +				int ref_count = page_ref_count(page);
> > +				int map_count = page_mapcount(page);
> > +
> > +				/*
> > +				 * The only page refs must be from the isolation
> > +				 * (checked by the caller shrink_page_list() too)
> > +				 * and one or more rmap's (dropped by discard:).
> > +				 *
> > +				 * Check the reference count before dirty flag
> > +				 * with memory barrier; see __remove_mapping().
> > +				 */
> > +				smp_rmb();
> > +				if ((ref_count - 1 == map_count) &&
> > +				    !PageDirty(page)) {
> >  					/* Invalidate as we cleared the pte */
> >  					mmu_notifier_invalidate_range(mm,
> >  						address, address + PAGE_SIZE);
> 
> Out of curiosity, how does it work with COW in terms of reordering?
> Specifically, it seems to me get_page() and page_dup_rmap() in
> copy_present_pte() can happen in any order, and if page_dup_rmap()
> is seen first, and direct io is holding a refcnt, this check can still
> pass?
> 

Hi Yu,

I think you're correct. I think we don't like memory barrier
there in page_dup_rmap. Then, how about make gup_fast is aware
of FOLL_TOUCH?

FOLL_TOUCH means it's going to write something so the page
should be dirty. Currently, get_user_pages works like that.
Howver, problem is get_user_pages_fast since it looks like
that lockless_pages_from_mm doesn't support FOLL_TOUCH.

So the idea is if param in internal_get_user_pages_fast
includes FOLL_TOUCH, gup_{pmd,pte}_range try to make the
page dirty under trylock_page(If the lock fails, it goes
slow path with __gup_longterm_unlocked and set_dirty_pages
for them).

This approach would solve other cases where map userspace
pages into kernel space and then write. Since the write
didn't go through with the process's page table, we will
lose the dirty bit in the page table of the process and
it turns out same problem. That's why I'd like to approach
this.

If it doesn't work, the other option to fix this specific
case is can't we make pages dirty in advance in DIO read-case?

When I look at DIO code, it's already doing in async case.
Could't we do the same thing for the other cases?
I guess the worst case we will see would be more page
writeback since the page becomes dirty unnecessary.
