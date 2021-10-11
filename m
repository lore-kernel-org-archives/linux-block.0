Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 522A5C433EF
	for <linux-block@archiver.kernel.org>; Mon, 11 Oct 2021 08:34:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3BBB960EE3
	for <linux-block@archiver.kernel.org>; Mon, 11 Oct 2021 08:34:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235055AbhJKIgL (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 11 Oct 2021 04:36:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234985AbhJKIgK (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 11 Oct 2021 04:36:10 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14AACC061570;
        Mon, 11 Oct 2021 01:34:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=6yNA6WgIZDWyoNuRPs3i/c8qU8Td2KIoizBhLCmRuIA=; b=BEvmEAaEoe+LTIQva/1Bo04bTt
        0+769BNM2j5aCBN+SpvdisvKDcfdleBfocKK9rekY5lJZW9GFt07vXkTu+9lMES7AUtL7p2lR2Z+I
        WE3b+pk5eeVnqZuFnC/ZeVQDD7y5ulThg4JpBLPzpTpcQuH9ivlbTFw3XidkV0VLBb+J4RD0x6gA0
        QRTE7Mj0I8WGX8SyYtYtQp14Kx6TWKFkO8XydOXVp3rQwLHADysx3fjGBtWvaFXk5MG6hKnDEprJM
        KaWTRGUYdj8ZdoV+8OIrtFCIvxEXzwe76Z3h350wPHnuhOQUAPI0aFvsWYMovcwsHedXjDHcoDQC/
        DXPXtkDg==;
Received: from hch by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mZqjL-005NYg-47; Mon, 11 Oct 2021 08:32:58 +0000
Date:   Mon, 11 Oct 2021 09:32:19 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Pavel Begunkov <asml.silence@gmail.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/6] block: convert ->bd_inode to container_of()
Message-ID: <YWP2k4ffuOrO6NsX@infradead.org>
References: <cover.1633781740.git.asml.silence@gmail.com>
 <41af3da80d59b705eb2260f7f469955ad68a96d2.1633781740.git.asml.silence@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41af3da80d59b705eb2260f7f469955ad68a96d2.1633781740.git.asml.silence@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sat, Oct 09, 2021 at 01:25:43PM +0100, Pavel Begunkov wrote:
> +static inline struct inode *bdev_file_inode(struct file *file)
>  {
> +	struct block_device *bdev = blkdev_get_bdev(file);
> +
> +	return bdev_get_inode(bdev);
>  }

No need for this helper either.

> +static inline struct inode *bdev_get_inode(struct block_device *bdev)
> +{
> +	return &container_of(bdev, struct bdev_inode, bdev)->vfs_inode;
> +}

This is rather misnamed, not get anywhere in here.
