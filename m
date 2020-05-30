Return-Path: <SRS0=VeZL=7M=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05198C433E0
	for <linux-block@archiver.kernel.org>; Sat, 30 May 2020 09:08:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D29A1207BC
	for <linux-block@archiver.kernel.org>; Sat, 30 May 2020 09:08:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="cueUaioH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725912AbgE3JIB (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 30 May 2020 05:08:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725889AbgE3JIA (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 30 May 2020 05:08:00 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF27AC03E969
        for <linux-block@vger.kernel.org>; Sat, 30 May 2020 02:08:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ZuG6/NkOC3ivM8QhsDK/WEPd1SCpKM7ln0BlVc11PcY=; b=cueUaioHPDSF4Mw2TPT4vkCEGT
        N4fF80rvup22aDSbzTPOh5rcTH36ECAieIbehiCnJREj8dVWEBZGkDFFAV/jSbF3kYUnsIijbry14
        KXjsFt7MUnM6+2IsksgusHc0xmWlr2Ag15VZsawm6jdtKGLULXeTjp+6eOLd/xObrocoxRv5jS5wj
        9hPwb9jyQCfHHHoYqAIlPkgOsHOmOCxIbh604Oy6MgvWM4tCM93SkFRQ1m2gS0bd4kE8A98gub4E8
        fR+H6iQYnqUlRgALx4WUo5ItsIWu+UeYQN7k1ETO8z43lW4wOKwtjvqZd3SqNZO093OAlXIHcYbdt
        rstRnZAA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jexT0-0008W0-9P; Sat, 30 May 2020 09:07:46 +0000
Date:   Sat, 30 May 2020 02:07:46 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Zheng Bin <zhengbin13@huawei.com>
Cc:     axboe@kernel.dk, bvanassche@acm.org, jaegeuk@kernel.org,
        linux-block@vger.kernel.org, houtao1@huawei.com,
        yi.zhang@huawei.com
Subject: Re: [PATCH] loop: replace kill_bdev with invalidate_bdev
Message-ID: <20200530090746.GA32505@infradead.org>
References: <20200530034809.33610-1-zhengbin13@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200530034809.33610-1-zhengbin13@huawei.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sat, May 30, 2020 at 11:48:09AM +0800, Zheng Bin wrote:
> When a filesystem is mounting on a loop device and on a loop ioctl

s/mounting/mounted/ ?

> LOOP_SET_STATUS64, because of kill_bdev, buffer_head mappings are getting
> destroyed.
> kill_bdev
>   truncate_inode_pages
>     truncate_inode_pages_range
>       do_invalidatepage
>         block_invalidatepage
>           discard_buffer  -->clear BH_Mapped flag
> 
> sb_bread
>   __bread_gfp
>   bh = __getblk_gfp
>   -->discard_buffer clear BH_Mapped flag
>   __bread_slow
>     submit_bh
>       submit_bh_wbc
>         BUG_ON(!buffer_mapped(bh))  --> hit this BUG_ON
> 
> Fixes: 5db470e229e2 ("loop: drop caches if offset or block_size are changed")
> Signed-off-by: Zheng Bin <zhengbin13@huawei.com>

Otherwise this looks reasonable:

Reviewed-by: Christoph Hellwig <hch@lst.de>

Can you also add a patch to now mark kill_bdev static in block_dev.c,
as this removed the last external users?
