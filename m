Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 767D8C433F5
	for <linux-block@archiver.kernel.org>; Mon, 11 Oct 2021 08:23:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 504D460231
	for <linux-block@archiver.kernel.org>; Mon, 11 Oct 2021 08:23:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234924AbhJKIZn (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 11 Oct 2021 04:25:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234921AbhJKIZn (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 11 Oct 2021 04:25:43 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A69E1C061570;
        Mon, 11 Oct 2021 01:23:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=jlTofyJTto333xfjluOyWCno7/as7yxVCpySPhdYTIM=; b=BDZIIMMI/uKXwops3jbusG9neI
        0BPpPIeD5ZqeaUY52OugdagTDfgFXYmLFoOCQw2OnIvEwyaXC7ZE4j0IfC2vKC3/Har4vLvXJ41XS
        +8vHBp3wqmStT0igTWHO1xElp/aOTQNatLYYd3tt01ytICzn6GXQpujdoqfwDxtTaeQT+ewWZQFi5
        tfnS3LtsG3kJlWzeCIOB+XdP7970Rv3R4wnUsd1A9CZoYmoT509LlOD9ri6rXz2fCHEd3XmDx1nvg
        zZnLLh0EGp09rLojgWf31feA4tFG1p7NokBfLRHu0QIyFC+r8/e7xVQsfwy3/UNl9jcVtppPP1VuH
        Y7ci7JZQ==;
Received: from hch by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mZqY2-005MlO-3r; Mon, 11 Oct 2021 08:21:09 +0000
Date:   Mon, 11 Oct 2021 09:20:38 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Pavel Begunkov <asml.silence@gmail.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/6] block: inline BDEV_I and friends
Message-ID: <YWPz1io+ePaNSYt5@infradead.org>
References: <cover.1633781740.git.asml.silence@gmail.com>
 <7c112aa98c9268d3d488cbee8b2832dc707812f6.1633781740.git.asml.silence@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7c112aa98c9268d3d488cbee8b2832dc707812f6.1633781740.git.asml.silence@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sat, Oct 09, 2021 at 01:25:39PM +0100, Pavel Begunkov wrote:
> I_BDEV and BDEV_I are very simple, they worth a single arith instruction
> or can even be almost completely compiled out. Inline them.

I see the benefit, but this is moving in the wrong direction.

struct bdev_inode is private to hide the struct inode.  Which at
the momen is a bit pointless given the bd_inode pointer in struct
block_device.

So we have two choices here that make sense:

 1) remove struct bdev_inode and kill the illusion that the inode
    is a private implementation detail
 2) remove direct references to bd_inode entirely.  Most of them are
    to i_size which already has proper helpers that should be used,
    and the rest can probably be covered with a handful wrappes or
    is bogus anyway
