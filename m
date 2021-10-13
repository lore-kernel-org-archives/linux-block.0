Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27757C433F5
	for <linux-block@archiver.kernel.org>; Wed, 13 Oct 2021 15:21:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F257960F21
	for <linux-block@archiver.kernel.org>; Wed, 13 Oct 2021 15:21:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229664AbhJMPXI (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 13 Oct 2021 11:23:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbhJMPXH (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 13 Oct 2021 11:23:07 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A557CC061570;
        Wed, 13 Oct 2021 08:21:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=psrbzzNStteeIA5Le6zm0EXP80lfcM53h7lHXruWevE=; b=rYB5DTCBgnVqGfIr1LYZoghQE3
        zOXw0BrarQbkcGFpp7Nl55vQmLnVMj5N79hC2VZPaTIbJ/1IgZOBxlxcttdkDN1rPYNRVq/YGV+Po
        fDs+NHAJ2bjrQp1rfM+FqSUWMdoACl6A1zWIOMoFAuh/1rK3tOwBbqQBvQgw9GoUj2JjZZeWTvv5v
        MRp3ypZArseAuu1OrR9gdSqJzzoq/ZADSRimQBu0v2Qso5hLl+MmV9NH2jM0z/1qMV1/Nz5z1Et2y
        6sxkEkCJRn7vXfjD3Gd72KevUMKux0Ile5yNdm5DWnRxJ3yJIADc6DgspofbIyjaFvuUS2nTW9rVN
        1049tKeA==;
Received: from hch by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mag2B-007YDH-3y; Wed, 13 Oct 2021 15:19:28 +0000
Date:   Wed, 13 Oct 2021 16:19:11 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Pavel Begunkov <asml.silence@gmail.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH v2 1/3] block: cache bdev in struct file for raw bdev IO
Message-ID: <YWb478zJALy7dmtN@infradead.org>
References: <cover.1634115360.git.asml.silence@gmail.com>
 <8415f9fe12e544b9da89593dfbca8de2b52efe03.1634115360.git.asml.silence@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8415f9fe12e544b9da89593dfbca8de2b52efe03.1634115360.git.asml.silence@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Oct 13, 2021 at 09:57:11AM +0100, Pavel Begunkov wrote:
> bdev = &BDEV_I(file->f_mapping->host)->bdev
> 
> Getting struct block_device from a file requires 2 memory dereferences
> as illustrated above, that takes a toll on performance, so cache it in
> yet unused file->private_data. That gives a noticeable peak performance
> improvement.
> 
> Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
> ---
>  block/fops.c | 29 +++++++++++++----------------
>  1 file changed, 13 insertions(+), 16 deletions(-)
> 
> diff --git a/block/fops.c b/block/fops.c
> index 7bb9581a146c..c71e91cd6bcb 100644
> --- a/block/fops.c
> +++ b/block/fops.c
> @@ -17,7 +17,7 @@
>  #include <linux/fs.h>
>  #include "blk.h"
>  
> -static struct inode *bdev_file_inode(struct file *file)
> +static inline struct inode *bdev_file_inode(struct file *file)
>  {
>  	return file->f_mapping->host;
>  }

This is unrelated to the rest.

But the actual described change looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
