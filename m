Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AC0DC433F5
	for <linux-block@archiver.kernel.org>; Tue, 11 Jan 2022 20:20:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244129AbiAKUUX (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 11 Jan 2022 15:20:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244446AbiAKUUQ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 11 Jan 2022 15:20:16 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07A75C06173F
        for <linux-block@vger.kernel.org>; Tue, 11 Jan 2022 12:20:16 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id 59-20020a17090a09c100b001b34a13745eso7380143pjo.5
        for <linux-block@vger.kernel.org>; Tue, 11 Jan 2022 12:20:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=TPXSlVpb8cuHGEsGyiKONzqT5bPKyzPhdUShj2B9Kxc=;
        b=H3RzPboinSDxMqBn90H/lZ7SvPdcVqvqOvd29BvPYFIbeUQ84B4/cXoEiKURIbt0Wq
         IsP3qeI5vzVGCDmRZqordMamDrmLgpr2VV11B1LfNaYayo3K6dwsosqQIUN3IQjcCt/I
         fqj5VPIijLvs/CmqEIznMuV3jSbTTF0xZqnmJbAExShJpqqhOf4IfIgZd9APCEtHj/Zh
         m+wEiQoa2wGZkc2PI39t/FY6LS6Iu5UEycXjYLb/IuSgAoI7t+logN/6082csLdpaB/c
         FVb8NN/Y5pv3BoziPp3HZ6NdWO0a6f2z4FmMO0NOWw23FjuxOR6YNHcaS+7HFABVW4nQ
         chEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=TPXSlVpb8cuHGEsGyiKONzqT5bPKyzPhdUShj2B9Kxc=;
        b=Gj7JhM4oyhX9hnBhpbFx0nezvH6NtmmUZq1WonbAupcd39IV2QZ3jyEg/c4K4hfUGO
         wGJdHu2GNzc5BxWIZz0M9mkyBhguwKkxUL/WuQWw3TLlmf9w2KESm0/bmp8Xn8peKb8J
         WXE+rdAlhyWTKGHDjU6U97BCvnvxthI26LaZzyydS3qwZUe8AvRd9TFrd+AE/u64Dcbm
         aAR1cjyPJE9AkdbamL4iAQXenEFK1oJqLSQN2hZlUWc2+KviEIM7veqNpIxRn3OHWcB8
         lpZ6+qdKA2Nrr3HgVGoDe182xLfD5fwjTS5nhU0yzgEL6voIo975H+x3YiGqxj9IUzOU
         0ARg==
X-Gm-Message-State: AOAM532CMQEjOwtXQC/j2Wz16rTFRrgDMgnkF85KTISvoeT1z2KGeYAh
        GqfMdCQixR37qIBU4bTK8pQ5fRziGWI=
X-Google-Smtp-Source: ABdhPJwRSdmMAhgk9Mb18TUH7VG/+nMdR5/7HkQViDWyLjoIpdPsnwK5LOs5ZF8j3afOTK2UAXYqBQ==
X-Received: by 2002:a17:90b:3b92:: with SMTP id pc18mr5045237pjb.137.1641932415470;
        Tue, 11 Jan 2022 12:20:15 -0800 (PST)
Received: from google.com ([2620:15c:211:201:4f0e:ffc8:3f7b:ac89])
        by smtp.gmail.com with ESMTPSA id u20sm7559250pfi.220.2022.01.11.12.20.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jan 2022 12:20:15 -0800 (PST)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date:   Tue, 11 Jan 2022 12:20:13 -0800
From:   Minchan Kim <minchan@kernel.org>
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     Yu Zhao <yuzhao@google.com>,
        Mauricio Faria de Oliveira <mfo@canonical.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-block@vger.kernel.org, Huang Ying <ying.huang@intel.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Yang Shi <shy828301@gmail.com>
Subject: Re: [PATCH v2] mm: fix race between MADV_FREE reclaim and blkdev
 direct IO read
Message-ID: <Yd3mfROPwP72QPt3@google.com>
References: <20220105233440.63361-1-mfo@canonical.com>
 <Yd0oLWtVAyAexyQc@google.com>
 <Yd3SUXVy7MbyBzFw@google.com>
 <e75c8f37-782f-f4d4-b197-8fda18090b42@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e75c8f37-782f-f4d4-b197-8fda18090b42@nvidia.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Jan 11, 2022 at 11:29:36AM -0800, John Hubbard wrote:
> On 1/11/22 10:54, Minchan Kim wrote:
> ...
> > Hi Yu,
> > 
> > I think you're correct. I think we don't like memory barrier
> > there in page_dup_rmap. Then, how about make gup_fast is aware
> > of FOLL_TOUCH?
> > 
> > FOLL_TOUCH means it's going to write something so the page
> 
> Actually, my understanding of FOLL_TOUCH is that it does *not* mean that
> data will be written to the page. That is what FOLL_WRITE is for.
> FOLL_TOUCH means: update the "accessed" metadata, without actually
> writing to the memory that the page represents.

Exactly. I should have mentioned the FOLL_TOUCH with FOLL_WRITE.
What I wanted to hit with FOLL_TOUCH was 

follow_page_pte:

        if (flags & FOLL_TOUCH) {
                if ((flags & FOLL_WRITE) &&
                    !pte_dirty(pte) && !PageDirty(page))
                        set_page_dirty(page);
                mark_page_accessed(page);
        }

> 
> 
> > should be dirty. Currently, get_user_pages works like that.
> > Howver, problem is get_user_pages_fast since it looks like
> > that lockless_pages_from_mm doesn't support FOLL_TOUCH.
> > 
> > So the idea is if param in internal_get_user_pages_fast
> > includes FOLL_TOUCH, gup_{pmd,pte}_range try to make the
> > page dirty under trylock_page(If the lock fails, it goes
> 
> Marking a page dirty solely because FOLL_TOUCH is specified would
> be an API-level mistake. That's why it isn't "supported". Or at least,
> that's how I'm reading things.
> 
> Hope that helps!
> 
> > slow path with __gup_longterm_unlocked and set_dirty_pages
> > for them).
> > 
> > This approach would solve other cases where map userspace
> > pages into kernel space and then write. Since the write
> > didn't go through with the process's page table, we will
> > lose the dirty bit in the page table of the process and
> > it turns out same problem. That's why I'd like to approach
> > this.
> > 
> > If it doesn't work, the other option to fix this specific
> > case is can't we make pages dirty in advance in DIO read-case?
> > 
> > When I look at DIO code, it's already doing in async case.
> > Could't we do the same thing for the other cases?
> > I guess the worst case we will see would be more page
> > writeback since the page becomes dirty unnecessary.
> 
> Marking pages dirty after pinning them is a pre-existing area of
> problems. See the long-running LWN articles about get_user_pages() [1].

Oh, Do you mean marking page dirty in DIO path is already problems?
Let me read the pages in the link.
Thanks!

> 
> 
> [1] https://lwn.net/Kernel/Index/#Memory_management-get_user_pages
> 
> thanks,
> -- 
> John Hubbard
> NVIDIA
> 
