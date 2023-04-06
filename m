Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95F0BC77B6C
	for <linux-block@archiver.kernel.org>; Thu,  6 Apr 2023 22:58:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239368AbjDFW6R (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 6 Apr 2023 18:58:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239384AbjDFW6N (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 6 Apr 2023 18:58:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6E765FE1
        for <linux-block@vger.kernel.org>; Thu,  6 Apr 2023 15:58:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5601760F32
        for <linux-block@vger.kernel.org>; Thu,  6 Apr 2023 22:58:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9968DC433EF;
        Thu,  6 Apr 2023 22:58:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1680821891;
        bh=Yki3EO9+2qofkXWW1c2yr5dHn1MZvddDU65K/Lquusw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=IWefx2cJ3OBpD07GUQobWw0RjajKL39lRyjpiaGrASSMBWMpx7p11M1ReOfo/gCSI
         sAByx7DP5T+ON47uF8ZWpv+AWi+84pP0JB7MN8Ykc7RQK+NrECb+vm7R4IBL8Z4HX+
         necQWCd8PMEK8wzOJPHsOp37exEZCOzjttSdZi3Q=
Date:   Thu, 6 Apr 2023 15:58:10 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Minchan Kim <minchan@kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: Re: [PATCH 15/16] zram: fix synchronous reads
Message-Id: <20230406155810.abc9a2b5c72f43f03a5d5800@linux-foundation.org>
In-Reply-To: <ZC9CIsMcwCjYvbXX@google.com>
References: <20230406144102.149231-1-hch@lst.de>
        <20230406144102.149231-16-hch@lst.de>
        <ZC9CIsMcwCjYvbXX@google.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, 6 Apr 2023 15:05:22 -0700 Minchan Kim <minchan@kernel.org> wrote:

> On Thu, Apr 06, 2023 at 04:41:01PM +0200, Christoph Hellwig wrote:
> > Currently nothing waits for the synchronous reads before accessing
> > the data.  Switch them to an on-stack bio and submit_bio_wait to
> > make sure the I/O has actually completed when the work item has been
> > flushed.  This also removes the call to page_endio that would unlock
> > a page that has never been locked.
> > 
> > Drop the partial_io/sync flag, as chaining only makes sense for the
> > asynchronous reads of the entire page.
> > 
> > Signed-off-by: Christoph Hellwig <hch@lst.de>
> > Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>
> Acked-by: Minchan Kim <minchan@kernel.org>
> 
> So this fixes zram_rw_page + CONFIG_ZRAM_WRITEBACK feature on
> ppc some arch where PAGE_SIZE is not 4K.
> 
> IIRC, we didn't have any report since the writeback feature was
> introduced. Then, we may skip having the fix into stable?

Someone may develop such a use case in the future.  And backporting
this fix will be difficult, unless people backport all the other
patches, which is also difficult.

What are the user-visible effects of this bug?  It sounds like it will
give userspace access to unintialized kernel memory, which isn't good.
