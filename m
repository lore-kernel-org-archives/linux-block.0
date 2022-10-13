Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90153C43217
	for <linux-block@archiver.kernel.org>; Thu, 13 Oct 2022 12:48:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229573AbiJMMsN (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 13 Oct 2022 08:48:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbiJMMsM (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 13 Oct 2022 08:48:12 -0400
X-Greylist: delayed 578 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 13 Oct 2022 05:48:11 PDT
Received: from outbound-smtp14.blacknight.com (outbound-smtp14.blacknight.com [46.22.139.231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F64EFA00E
        for <linux-block@vger.kernel.org>; Thu, 13 Oct 2022 05:48:11 -0700 (PDT)
Received: from mail.blacknight.com (pemlinmail05.blacknight.ie [81.17.254.26])
        by outbound-smtp14.blacknight.com (Postfix) with ESMTPS id 08B141C4097
        for <linux-block@vger.kernel.org>; Thu, 13 Oct 2022 13:38:32 +0100 (IST)
Received: (qmail 16548 invoked from network); 13 Oct 2022 12:38:31 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.198.246])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 13 Oct 2022 12:38:31 -0000
Date:   Thu, 13 Oct 2022 13:38:30 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Yang Shi <shy828301@gmail.com>
Cc:     agk@redhat.com, snitzer@kernel.org, dm-devel@redhat.com,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] mm: mempool: introduce page bulk allocator
Message-ID: <20221013123830.opbulq4qad56kuev@techsingularity.net>
References: <20221005180341.1738796-1-shy828301@gmail.com>
 <20221005180341.1738796-3-shy828301@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20221005180341.1738796-3-shy828301@gmail.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Oct 05, 2022 at 11:03:39AM -0700, Yang Shi wrote:
> Since v5.13 the page bulk allocator was introduced to allocate order-0
> pages in bulk.  There are a few mempool allocator callers which does
> order-0 page allocation in a loop, for example, dm-crypt, f2fs compress,
> etc.  A mempool page bulk allocator seems useful.  So introduce the
> mempool page bulk allocator.
> 
> It introduces the below APIs:
>   - mempool_init_pages_bulk()
>   - mempool_create_pages_bulk()
> They initialize the mempool for page bulk allocator.  The pool is filled
> by alloc_page() in a loop.
> 
>   - mempool_alloc_pages_bulk_list()
>   - mempool_alloc_pages_bulk_array()
> They do bulk allocation from mempool.
> They do the below conceptually:
>   1. Call bulk page allocator
>   2. If the allocation is fulfilled then return otherwise try to
>      allocate the remaining pages from the mempool
>   3. If it is fulfilled then return otherwise retry from #1 with sleepable
>      gfp
>   4. If it is still failed, sleep for a while to wait for the mempool is
>      refilled, then retry from #1
> The populated pages will stay on the list or array until the callers
> consume them or free them.
> Since mempool allocator is guaranteed to success in the sleepable context,
> so the two APIs return true for success or false for fail.  It is the
> caller's responsibility to handle failure case (partial allocation), just
> like the page bulk allocator.
> 
> The mempool typically is an object agnostic allocator, but bulk allocation
> is only supported by pages, so the mempool bulk allocator is for page
> allocation only as well.
> 
> Signed-off-by: Yang Shi <shy828301@gmail.com>

Overall, I think it's an ok approach and certainly a good use case for
the bulk allocator.

The main concern that I have is that the dm-crypt use case doesn't really
want to use lists as such and it's just a means for collecting pages to pass
to bio_add_page(). bio_add_page() is working with arrays but you cannot
use that array directly as any change to how that array is populated will
then explode. Unfortunately, what you have is adding pages to a list to
take them off the list and put them in an array and that is inefficient.

How about this

1. Add a callback to __alloc_pages_bulk() that takes a page as a
   parameter like bulk_add_page() or whatever.

2. For page_list == NULL && page_array == NULL, the callback is used

3. Add alloc_pages_bulk_cb() that passes in the name of a callback
   function

4. In the dm-crypt case, use the callback to pass the page to bio_add_page
   for the new page allocated.

It's not free because there will be an additional function call for every
page bulk allocated but I suspect that's cheaper than adding a pile of
pages to a list just to take them off again. It also avoids adding a user
for the bulk allocator list interface that does not even want a list.

It might mean that there is additional cleanup work for __alloc_pages_bulk
to abstract away whether a list, array or cb is used but nothing
impossible.

-- 
Mel Gorman
SUSE Labs
