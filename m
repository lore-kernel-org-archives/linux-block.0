Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1F04C433EF
	for <linux-block@archiver.kernel.org>; Wed,  2 Feb 2022 21:53:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347718AbiBBVx1 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 2 Feb 2022 16:53:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbiBBVx1 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 2 Feb 2022 16:53:27 -0500
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51660C061714
        for <linux-block@vger.kernel.org>; Wed,  2 Feb 2022 13:53:27 -0800 (PST)
Received: by mail-io1-xd2e.google.com with SMTP id w7so834413ioj.5
        for <linux-block@vger.kernel.org>; Wed, 02 Feb 2022 13:53:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=cP6a8V+TG3up9uQ72M6jJ3rO0BN/B9RvaaZdDPQqQ3Q=;
        b=HlpSMbh619MeZwBiBmh/8oN+kByjM6EkLuOV/kxtbG4kevQkM2pWOdbaIfXk59LAhc
         O4YJU1x/KaPVGUpypUnIZA9wUL8EPrfwVvmQr1EwxDkFM4SR6GC1aQvOCdAQWzipwwAt
         nZC6wXITpf9bnUaNkrsqq8OCMN8UhhboI+aWFiSZPbWOAZ9iKd1J9KTQ+hY2BXDQh8XU
         yhgTqtevqQYgRcxGm4qtNWxvZkO4MTAF11tGMjua9G6jBt009AArS2YoN+8Trc5mRaxg
         ullXf/ISHjCrmk1UwNQB/Z14XFQkfQKXC4G0Lj1q9WT00ppMUA+iPqGqdQknTS/qsADv
         zJEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=cP6a8V+TG3up9uQ72M6jJ3rO0BN/B9RvaaZdDPQqQ3Q=;
        b=wcTP4e5Ab0RjwL5bQFcJgzTtu4PonmbYe45RdW3WDrkOmnBQ9LiO3K40U9AbR0ZI4+
         kHbAQeKN5Gp4zzdtX1WuoptBhTeLGAblS7P68dWpwJRbfgn8sOT0kFp0Tw/JeNUre2F3
         pC/K9zHx+5F+iIl3qjdSRigcL54vlh69GUzdaMhOfTdbJ2JNoJ9D9AMLLOAi7/XwKyCK
         P5Zf3hgSF1JHfXkcxs/8uvE710DnkfKLcMc+AkD6ZpjbtXuVfD5bz+8kflYFcKn2sOIm
         FIcgzf3/I7s7rnGaJ3IvtiN9iBlArVIbcCqg5oRoC/wWCCnoFm7SuZ59IdAHCRK/Pt4U
         bhZA==
X-Gm-Message-State: AOAM531TTmu5l071j/9IOyqpZnyotIwuWtNNENOpgRQKLrmOIvBOjaYW
        2CJ6WdlUfILocJUgtVwmg5mXyQ==
X-Google-Smtp-Source: ABdhPJx7n33IlwAgOoXc9VJo9IWvTthJNyf9Bvol1fDrtnOq7fcdplTvGdVcnwWG4F/zWd8T6gah3Q==
X-Received: by 2002:a02:29cd:: with SMTP id p196mr16314874jap.82.1643838806619;
        Wed, 02 Feb 2022 13:53:26 -0800 (PST)
Received: from google.com ([2620:15c:183:200:a1e5:3cc4:4458:6ce8])
        by smtp.gmail.com with ESMTPSA id h3sm21898094ild.11.2022.02.02.13.53.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Feb 2022 13:53:26 -0800 (PST)
Date:   Wed, 2 Feb 2022 14:53:22 -0700
From:   Yu Zhao <yuzhao@google.com>
To:     Mauricio Faria de Oliveira <mfo@canonical.com>
Cc:     Minchan Kim <minchan@kernel.org>,
        "Huang, Ying" <ying.huang@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yang Shi <shy828301@gmail.com>,
        Miaohe Lin <linmiaohe@huawei.com>, linux-mm@kvack.org,
        linux-block@vger.kernel.org
Subject: Re: [PATCH v3] mm: fix race between MADV_FREE reclaim and blkdev
 direct IO read
Message-ID: <Yfr9UkEtLSHL2qhZ@google.com>
References: <20220131230255.789059-1-mfo@canonical.com>
 <Yfrh9F67ligMDUB7@google.com>
 <CAO9xwp3DNioiVPJNH9w-eXLxfVmTx9jBpOgq9eatpTFJTTg50Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAO9xwp3DNioiVPJNH9w-eXLxfVmTx9jBpOgq9eatpTFJTTg50Q@mail.gmail.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Feb 02, 2022 at 06:27:47PM -0300, Mauricio Faria de Oliveira wrote:
> On Wed, Feb 2, 2022 at 4:56 PM Yu Zhao <yuzhao@google.com> wrote:
> >
> > On Mon, Jan 31, 2022 at 08:02:55PM -0300, Mauricio Faria de Oliveira wrote:
> > > Problem:
> > > =======
> >
> > Thanks for the update. A couple of quick questions:
> >
> > > Userspace might read the zero-page instead of actual data from a
> > > direct IO read on a block device if the buffers have been called
> > > madvise(MADV_FREE) on earlier (this is discussed below) due to a
> > > race between page reclaim on MADV_FREE and blkdev direct IO read.
> >
> > 1) would page migration be affected as well?
> 
> Could you please elaborate on the potential problem you considered?
> 
> I checked migrate_pages() -> try_to_migrate() holds the page lock,
> thus shouldn't race with shrink_page_list() -> with try_to_unmap()
> (where the issue with MADV_FREE is), but maybe I didn't get you
> correctly.

Could the race exist between DIO and migration? While DIO is writing
to a page, could migration unmap it and copy the data from this page
to a new page?

> > > @@ -1599,7 +1599,30 @@ static bool try_to_unmap_one(struct page *page, struct vm_area_struct *vma,
> > >
> > >                       /* MADV_FREE page check */
> > >                       if (!PageSwapBacked(page)) {
> > > -                             if (!PageDirty(page)) {
> > > +                             int ref_count, map_count;
> > > +
> > > +                             /*
> > > +                              * Synchronize with gup_pte_range():
> > > +                              * - clear PTE; barrier; read refcount
> > > +                              * - inc refcount; barrier; read PTE
> > > +                              */
> > > +                             smp_mb();
> > > +
> > > +                             ref_count = page_count(page);
> > > +                             map_count = page_mapcount(page);
> > > +
> > > +                             /*
> > > +                              * Order reads for page refcount and dirty flag;
> > > +                              * see __remove_mapping().
> > > +                              */
> > > +                             smp_rmb();
> >
> > 2) why does it need to order against __remove_mapping()? It seems to
> >    me that here (called from the reclaim path) it can't race with
> >    __remove_mapping() because both lock the page.
> 
> I'll improve that comment in v4.  The ordering isn't against __remove_mapping(),
> but actually because of an issue described in __remove_mapping()'s comments
> (something else that doesn't hold the page lock, just has a page reference, that
> may clear the page dirty flag then drop the reference; thus check ref,
> then dirty).

Got it. IIRC, get_user_pages() doesn't imply a write barrier. If so,
there should be a smp_wmb() on the other side:

	 * get_user_pages(&page);

	smp_wmb()

	 * SetPageDirty(page);
	 * put_page(page);

(__remove_mapping() doesn't need smp_[rw]mb() on either side because
it relies on page refcnt freeze and retesting.)

Thanks.
