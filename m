Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47047C433F5
	for <linux-block@archiver.kernel.org>; Wed, 16 Feb 2022 21:58:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234063AbiBPV66 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 16 Feb 2022 16:58:58 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:51660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbiBPV65 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 16 Feb 2022 16:58:57 -0500
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E3C9C0877
        for <linux-block@vger.kernel.org>; Wed, 16 Feb 2022 13:58:41 -0800 (PST)
Received: by mail-io1-xd2e.google.com with SMTP id e79so1427086iof.13
        for <linux-block@vger.kernel.org>; Wed, 16 Feb 2022 13:58:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Zg/d65u19q38I3oM5Do2dldDuoJfPVh5cYcs6nK/ICM=;
        b=n8+DJL5853b/9UCZzm45z0yqXyySfIeRDb4HhDdX/Cg5Y1vql7KrhiE0iE9gVvwgO9
         9Dz4ggbWPb9uj4Ff1xMZDLiBefxciRYeB7gMFJdPIb9mlFfRHV6mZ5HwYNqY+m6gOu7C
         pXMwaRd2TIcGgHoG5fYFrzxMALPDUfHuUuOanOd5nptHrzMeiW1Qm2nwxEE1SMOiQjnS
         0rYYgBNnukmahimiakB0RugJUlyYJaBUiZ9IreimwnC7W9il3gITRBthUZ3+lLT4Teyf
         fQaX7vtRLi+mC88FdD6EZHbMJC1YXLif0MWhiIShfhCEunx9qAR1LXJcOHe53CS87iA3
         mI8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Zg/d65u19q38I3oM5Do2dldDuoJfPVh5cYcs6nK/ICM=;
        b=IfWp0+9ust8pMfCaqUQwVNyR2oNVGupczsUDmBwzgDXaty583IU21szyZ0q/D4ZXE7
         SHstvUToymf+Bk/3uZxPelqQsUHmIBfCRH6lChMxtgLm8K8pOBthPa2+pUjqNhRRthng
         tFANybupp1LyM7lAPJM+Y/gWEvDwanq6DvS/piUO0PjfOQZ7cKJVcSW4lyadKZ6MQXqd
         1hnfBTZlRUhBYlmDDFW8l0q8hAO5o9oacaim88sah9wQwSAZIEW2KxDKGLyih9MXAtml
         u7SIA/BR0+HDI1srryzUIISPN7OyCO3eyK8GdQGlzYKr3/Gtdntt30foa1fR0af15h23
         h47A==
X-Gm-Message-State: AOAM533tpqQdKMsyrBQkJmbD+71nzU7W5gGSXb64VAhE9pMLyo8pBXB8
        IExNkmyum/g4leqCLYJ948HB8Q==
X-Google-Smtp-Source: ABdhPJz0ybrl7XQJTJk3JKg4Baqd4O0CrHOQvFPWW+O5bFHdUZjNf89exYPbRwB7GSVSWUSGtnqdwA==
X-Received: by 2002:a02:8664:0:b0:30d:e657:7847 with SMTP id e91-20020a028664000000b0030de6577847mr2940845jai.283.1645048720329;
        Wed, 16 Feb 2022 13:58:40 -0800 (PST)
Received: from google.com ([2620:15c:183:200:5929:5114:bf56:ccb6])
        by smtp.gmail.com with ESMTPSA id o13sm645866iou.3.2022.02.16.13.58.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Feb 2022 13:58:39 -0800 (PST)
Date:   Wed, 16 Feb 2022 14:58:36 -0700
From:   Yu Zhao <yuzhao@google.com>
To:     "Huang, Ying" <ying.huang@intel.com>
Cc:     Mauricio Faria de Oliveira <mfo@canonical.com>,
        Minchan Kim <minchan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yang Shi <shy828301@gmail.com>,
        Miaohe Lin <linmiaohe@huawei.com>, linux-mm@kvack.org,
        linux-block@vger.kernel.org
Subject: Re: [PATCH v3] mm: fix race between MADV_FREE reclaim and blkdev
 direct IO read
Message-ID: <Yg1zjHkctX0zkF+o@google.com>
References: <20220131230255.789059-1-mfo@canonical.com>
 <Yfrh9F67ligMDUB7@google.com>
 <CAO9xwp3DNioiVPJNH9w-eXLxfVmTx9jBpOgq9eatpTFJTTg50Q@mail.gmail.com>
 <Yfr9UkEtLSHL2qhZ@google.com>
 <87o837cnnw.fsf@yhuang6-desk2.ccr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87o837cnnw.fsf@yhuang6-desk2.ccr.corp.intel.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Feb 16, 2022 at 02:48:19PM +0800, Huang, Ying wrote:
> Yu Zhao <yuzhao@google.com> writes:
> 
> > On Wed, Feb 02, 2022 at 06:27:47PM -0300, Mauricio Faria de Oliveira wrote:
> >> On Wed, Feb 2, 2022 at 4:56 PM Yu Zhao <yuzhao@google.com> wrote:
> >> >
> >> > On Mon, Jan 31, 2022 at 08:02:55PM -0300, Mauricio Faria de Oliveira wrote:
> >> > > Problem:
> >> > > =======
> >> >
> >> > Thanks for the update. A couple of quick questions:
> >> >
> >> > > Userspace might read the zero-page instead of actual data from a
> >> > > direct IO read on a block device if the buffers have been called
> >> > > madvise(MADV_FREE) on earlier (this is discussed below) due to a
> >> > > race between page reclaim on MADV_FREE and blkdev direct IO read.
> >> >
> >> > 1) would page migration be affected as well?
> >> 
> >> Could you please elaborate on the potential problem you considered?
> >> 
> >> I checked migrate_pages() -> try_to_migrate() holds the page lock,
> >> thus shouldn't race with shrink_page_list() -> with try_to_unmap()
> >> (where the issue with MADV_FREE is), but maybe I didn't get you
> >> correctly.
> >
> > Could the race exist between DIO and migration? While DIO is writing
> > to a page, could migration unmap it and copy the data from this page
> > to a new page?
> 
> Check the migrate_pages() code,
> 
>   migrate_pages
>     unmap_and_move
>       __unmap_and_move
>         try_to_migrate // set PTE to swap entry with PTL
>         move_to_new_page
>           migrate_page
>             folio_migrate_mapping
>               folio_ref_count(folio) != expected_count // check page ref count
>             folio_migrate_copy
> 
> The page ref count is checked after unmapping and before copying.  This
> is good, but it appears that we need a memory barrier between checking
> page ref count and copying page.

I didn't look into this but, off the top of head, this should be
similar if not identical to the DIO case. Therefore, it requires two
barriers -- before and after the refcnt check (which may or may not
exist).
