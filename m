Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B902C433EF
	for <linux-block@archiver.kernel.org>; Tue, 19 Oct 2021 06:00:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E3374611BF
	for <linux-block@archiver.kernel.org>; Tue, 19 Oct 2021 06:00:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233791AbhJSGDC (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 19 Oct 2021 02:03:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229649AbhJSGDC (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 19 Oct 2021 02:03:02 -0400
Received: from bombadil.infradead.org (unknown [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77645C06161C
        for <linux-block@vger.kernel.org>; Mon, 18 Oct 2021 23:00:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=GrdDfRzSSKqvxNvhxUREIyzAU2cMHypp4lzQrYAuPRk=; b=Mgl7wyibd6SUOHKGAZOw02hnMp
        nKGTYnRKIZG8WSspmm+7ONttvu+ZcRBOm4beu+KUG5n8rbaVUW2jyY4MObOvK6uMeh90AU8XcDOlc
        iW5SecE8gdtqUoiWvqT+CcNO3hwjsb3BSAHN55vbgXpqzdhf1xjvpBU4siXNs81p15hpoTLfcDmDb
        PTihfnZ4WNzDTY1reR6mHWUSc7pHJ6zBXfeY1FteIBIoo4KUiLexJ3r3EzT3JqT9loR2PCDkjgKsK
        WFjLBoBJS0JAZBjrTNOdbxG4BgPhDeVtg3I7Yc4w/qK0RzRqFTkUL5E0sTs+O0yoOvTPR+NNweQta
        /pfy/OHQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mciB8-000EDP-3y; Tue, 19 Oct 2021 06:00:50 +0000
Date:   Mon, 18 Oct 2021 23:00:50 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Pavel Begunkov <asml.silence@gmail.com>
Cc:     linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 2/3] block: blk_mq_rq_ctx_init cache ctx/q/hctx
Message-ID: <YW5fEpG+4G9XNuzy@infradead.org>
References: <cover.1634589262.git.asml.silence@gmail.com>
 <06a05d0b16a6504461502140c3d1e9c8cd91b862.1634589262.git.asml.silence@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <06a05d0b16a6504461502140c3d1e9c8cd91b862.1634589262.git.asml.silence@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Oct 18, 2021 at 09:37:28PM +0100, Pavel Begunkov wrote:
> We should have enough of registers in blk_mq_rq_ctx_init(), store them
> in local vars, so we don't keep reloading them.
> 
> note: keeping q->elevator may look unnecessary, but it's also used
> inside inlined blk_mq_tags_from_data().

Is this really making a difference?  I'd expect todays hyper-optimizing
compilers to not be tricked into specific register allocations just by
adding a local variable.
