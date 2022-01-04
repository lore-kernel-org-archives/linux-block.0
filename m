Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92074C433F5
	for <linux-block@archiver.kernel.org>; Tue,  4 Jan 2022 23:06:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235835AbiADXGq (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 4 Jan 2022 18:06:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235297AbiADXGp (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 4 Jan 2022 18:06:45 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 828BEC061761
        for <linux-block@vger.kernel.org>; Tue,  4 Jan 2022 15:06:45 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id rj2-20020a17090b3e8200b001b1944bad25so4625250pjb.5
        for <linux-block@vger.kernel.org>; Tue, 04 Jan 2022 15:06:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=aDlLZnHmudf9NrX3hjs2z3OmxIT5b+djhfDaqcC0s3M=;
        b=LzT5CyHYSKbRldpldSZc5H7NPlvu0ZFzk+SkNbVkaR46uDe5iQnTfHE6R0v3MS5lyC
         551TnK6xPe6i3v9m3f4UhjJEtO9hQiPP2a51KMsYmWCsz0/1jOub4ZXZAJ8v8hTtVTzc
         Oer1AXFIH6MlbUp/Tk/n4MYKKkNIhRVu5rxFaA+tUoXyejmtprl3ubNmcHuu6usgs6iQ
         +Hc6Syf0h64mclfo7RHMpL+XBFt8aKlaE/PXg9vYfyOF0VZVcvOU9zliQUunqNYGy8SW
         5xmacHTLLkbe/wS+RmB5tob1V9HW7A98YUYxbsOi2J3gYGziKAn+EqetoMISO5hUefwK
         Vrzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=aDlLZnHmudf9NrX3hjs2z3OmxIT5b+djhfDaqcC0s3M=;
        b=cPA5Ob3EQ042lHKSmfYgTPFez3STroVmRNipxYFkBGXB61l4SSp1JAFhxY8kL1SMju
         tRb9+573Yp8Bkpu6ZFt41WVbSequLmbAAk5dgNzqjA7IE4MVWiQKq72Qnj6t+JUuCkdj
         CTfUbqF+3Oc22GGKdjYOXmkM6sfCnHwpqNRsT4JWOdCaGTWNk8On9bFkdtEtcMsS7dbZ
         wLENMCG6cBqC739YRLCP7WzH6pKPPW4+5S/Ksaebavz4m+wwsld8lKuJPWtI06TwvxRg
         r/sWwtBnf3Qz4g8P1/swOdZh7hxI3w+/anPckoYFOE4RMDbrkoiZKuazbmD4J3aZM+MA
         eDKg==
X-Gm-Message-State: AOAM531/PrfiWismDJVkYvMQN7ZiCwZHQVLZLeUoQKN2dyie0FOiayPD
        D0KzTACoGR1vyYuCBlFBrLk=
X-Google-Smtp-Source: ABdhPJwFfQpIdjuY68+YTpPsXZjd9VF/GslOfsZ4PEQ6o5yR5IDBFXXt9B1ZFYTSO1ilTRdugt43zw==
X-Received: by 2002:a17:90a:f196:: with SMTP id bv22mr726275pjb.155.1641337604956;
        Tue, 04 Jan 2022 15:06:44 -0800 (PST)
Received: from google.com ([2620:15c:211:201:ad4f:965f:32ca:b30])
        by smtp.gmail.com with ESMTPSA id l6sm327542pjt.54.2022.01.04.15.06.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jan 2022 15:06:44 -0800 (PST)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date:   Tue, 4 Jan 2022 15:06:42 -0800
From:   Minchan Kim <minchan@kernel.org>
To:     Mauricio Faria de Oliveira <mfo@canonical.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-block@vger.kernel.org, Huang Ying <ying.huang@intel.com>,
        Miaohe Lin <linmiaohe@huawei.com>
Subject: Re: [PATCH] mm: fix race between MADV_FREE reclaim and blkdev direct
 IO read
Message-ID: <YdTTAjfse0Zwl7eB@google.com>
References: <20211211022115.1547617-1-mfo@canonical.com>
 <YbuCvo12yVHiZgRE@google.com>
 <CAO9xwp32+izoL54iCWRMGttL_T9yJKcyDyqwqxoDBx8Z7d_ZKg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAO9xwp32+izoL54iCWRMGttL_T9yJKcyDyqwqxoDBx8Z7d_ZKg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Jan 04, 2022 at 08:46:17AM -0300, Mauricio Faria de Oliveira wrote:
> On Thu, Dec 16, 2021 at 3:17 PM Minchan Kim <minchan@kernel.org> wrote:
> ...
> > Hi Mauricio,
> >
> > Thanks for catching the bug. There is some comment before I would
> > look the problem in more detail. Please see below.
> >
> 
> Hey! Thanks for looking into this. Sorry for the delay; I've been out
> a few weeks.
> 
> > > diff --git a/mm/rmap.c b/mm/rmap.c
> > > index 163ac4e6bcee..f04151aae03b 100644
> > > --- a/mm/rmap.c
> > > +++ b/mm/rmap.c
> > > @@ -1570,7 +1570,18 @@ static bool try_to_unmap_one(struct page *page, struct vm_area_struct *vma,
> > >
> > >                       /* MADV_FREE page check */
> > >                       if (!PageSwapBacked(page)) {
> > > -                             if (!PageDirty(page)) {
> > > +                             int refcount = page_ref_count(page);
> > > +
> > > +                             /*
> > > +                              * The only page refs must be from the isolation
> > > +                              * (checked by the caller shrink_page_list() too)
> > > +                              * and the (single) rmap (dropped by discard:).
> > > +                              *
> > > +                              * Check the reference count before dirty flag
> > > +                              * with memory barrier; see __remove_mapping().
> > > +                              */
> > > +                             smp_rmb();
> > > +                             if (refcount == 2 && !PageDirty(page)) {
> >
> > A madv_free marked page could be mapped at several processes so
> > it wouldn't be refcount two all the time, I think.
> > Shouldn't we check it with page_mapcount with page_refcount?
> >
> >     page_ref_count(page) - 1  > page_mapcount(page)
> >
> 
> It's the other way around, isn't it? The madvise(MADV_FREE) call only clears
> the page dirty flag if page_mapcount() == 1 (ie not mapped by more processes).
> 
> @ madvise_free_pte_range()
> 
>                         /*
>                          * If page is shared with others, we couldn't clear
>                          * PG_dirty of the page.
>                          */
>                         if (page_mapcount(page) != 1) {
>                                 unlock_page(page);
>                                 continue;
>                         }
> ...
>                         ClearPageDirty(page);
>                         unlock_page(page);
> 
> 
> If that's right, the refcount of 2 should be OK (one from the isolation,
> another one from the single map/one process.)
> 
> Does that make sense?  I might be missing something.

A child process could be forked from parent after madvise so the page
mapcount of the hinted page could have elevated refcount.
