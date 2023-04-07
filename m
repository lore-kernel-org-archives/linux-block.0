Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBB1AC761A6
	for <linux-block@archiver.kernel.org>; Fri,  7 Apr 2023 00:37:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232622AbjDGAhy (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 6 Apr 2023 20:37:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231171AbjDGAhy (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 6 Apr 2023 20:37:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE19A76AB
        for <linux-block@vger.kernel.org>; Thu,  6 Apr 2023 17:37:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8463E623F5
        for <linux-block@vger.kernel.org>; Fri,  7 Apr 2023 00:37:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3CDFC433EF;
        Fri,  7 Apr 2023 00:37:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1680827871;
        bh=4Zt39+nffm2iZkHEjZsxZDriJikDO7SUrcfYvnGFZo8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=rALOiWovKbxOq6OZNbFJo8HkpIsnE322HFcy1wNT+FxGcq7wXtdExrqVaJMBJUlqJ
         oSfaTSxC5G0E34LwkttZOslPsMSkShE2DpPiuP5sUozmVFKhGYq4/1CYC4NUzP7CkX
         80dikFk/smlxVCqSbqEG8I7rElXNb4mgCD5veQeI=
Date:   Thu, 6 Apr 2023 17:37:51 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Minchan Kim <minchan@kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: Re: [PATCH 15/16] zram: fix synchronous reads
Message-Id: <20230406173751.b96145c698e382ff2f1b1e08@linux-foundation.org>
In-Reply-To: <ZC9il6lWSKEZxDUr@google.com>
References: <20230406144102.149231-1-hch@lst.de>
        <20230406144102.149231-16-hch@lst.de>
        <ZC9CIsMcwCjYvbXX@google.com>
        <20230406155810.abc9a2b5c72f43f03a5d5800@linux-foundation.org>
        <ZC9il6lWSKEZxDUr@google.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, 6 Apr 2023 17:23:51 -0700 Minchan Kim <minchan@kernel.org> wrote:

> > Someone may develop such a use case in the future.  And backporting
> > this fix will be difficult, unless people backport all the other
> > patches, which is also difficult.
> 
> I think the simple fix is just bail out for partial IO case from
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
> 
> > 
> > What are the user-visible effects of this bug?  It sounds like it will
> > give userspace access to unintialized kernel memory, which isn't good.
> 
> It's true.
> 
> Without better suggestion or objections, I could cook the stable patch.

Sounds good to me.  Please don't forget to describe the user-visible
effects and the situation under which they will be observed, etc.

Then I can redo Chritoph's patches on top, so we end up with this
series as-is going forward.
