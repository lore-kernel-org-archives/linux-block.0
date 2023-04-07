Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72891C6FD1D
	for <linux-block@archiver.kernel.org>; Fri,  7 Apr 2023 04:37:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230243AbjDGEht (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 7 Apr 2023 00:37:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbjDGEhs (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 7 Apr 2023 00:37:48 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90EC98A72
        for <linux-block@vger.kernel.org>; Thu,  6 Apr 2023 21:37:47 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 1A9AB67373; Fri,  7 Apr 2023 06:37:44 +0200 (CEST)
Date:   Fri, 7 Apr 2023 06:37:43 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Minchan Kim <minchan@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: Re: [PATCH 15/16] zram: fix synchronous reads
Message-ID: <20230407043743.GB5674@lst.de>
References: <20230406144102.149231-1-hch@lst.de> <20230406144102.149231-16-hch@lst.de> <ZC9CIsMcwCjYvbXX@google.com> <20230406155810.abc9a2b5c72f43f03a5d5800@linux-foundation.org> <ZC9il6lWSKEZxDUr@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZC9il6lWSKEZxDUr@google.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Apr 06, 2023 at 05:23:51PM -0700, Minchan Kim wrote:
> rw_page path so that bio comes next to serve the rw_page failure.
> In the case, zram will always do chained bio so we are fine with
> asynchronous IO.
> 
> diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
> index b8549c61ff2c..23fa0e03cdc1 100644
> --- a/drivers/block/zram/zram_drv.c
> +++ b/drivers/block/zram/zram_drv.c
> @@ -1264,6 +1264,8 @@ static int __zram_bvec_read(struct zram *zram, struct page *page, u32 index,
>                 struct bio_vec bvec;
> 
>                 zram_slot_unlock(zram, index);
> +               if (partial_io)
> +                       return -EAGAIN;
> 
>                 bvec.bv_page = page;
>                 bvec.bv_len = PAGE_SIZE;

What tree is this supposed to apply to?  6.2 already has the
zram_bvec_read_from_bdev helper.


But either way partial_io can be true when called from zram_bvec_write,
where we can't just -EAGAIN as ->submit_bio is not allowed to return
that except for REQ_NOWAIT bios, and even then it needs to be handle
them when submitted without REQ_NOWAIT.
