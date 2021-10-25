Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DECAC433F5
	for <linux-block@archiver.kernel.org>; Mon, 25 Oct 2021 07:31:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3F4DA60FBF
	for <linux-block@archiver.kernel.org>; Mon, 25 Oct 2021 07:31:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231727AbhJYHda (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 25 Oct 2021 03:33:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231716AbhJYHd3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 25 Oct 2021 03:33:29 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA0F3C061745
        for <linux-block@vger.kernel.org>; Mon, 25 Oct 2021 00:31:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=17b1R/JZKb8ERd4GeNHkYaPWfDhqXIS9GC9HoG8+jZY=; b=c6/efRSv1Y7JJUJS8bEEQ11fYl
        tB7e2yTXVYXS7NreZkTOyCCPwXZe+z/FWgTRkNAgfHLGKJ2/WalB5bJT1UADXrnUBdp3yi2OtZob+
        g2Ht/XzILvG2jW8V6atIYmpCz51gZlJe/4JE94t15ohFyqVvfCTm0F/GK3TRS0iRQv94yN7xam00q
        uLOg9OUNnrl2P46S6JMCgF0dS9J288qLQW43kjLblml372s3G6LLmlsgxjlIWLBpU88RSaNbsa4lj
        BMG3NPF85rLo+2SICslmxsMK7Wz30xxcJz19+EKLf23yTOanoYF7sW5u/mCE63rWtSb0p/IETyitC
        7AodUKzw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1meuRn-00FdN0-AC; Mon, 25 Oct 2021 07:31:07 +0000
Date:   Mon, 25 Oct 2021 00:31:07 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Pavel Begunkov <asml.silence@gmail.com>
Cc:     linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 2/5] block: refactor bio_iov_bvec_set()
Message-ID: <YXZdO7z/+lrh2PtN@infradead.org>
References: <cover.1635006010.git.asml.silence@gmail.com>
 <bcf1ac36fce769a514e19475f3623cd86a1d8b72.1635006010.git.asml.silence@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bcf1ac36fce769a514e19475f3623cd86a1d8b72.1635006010.git.asml.silence@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sat, Oct 23, 2021 at 05:21:33PM +0100, Pavel Begunkov wrote:
> Combine bio_iov_bvec_set() and bio_iov_bvec_set_append() and let the
> caller to do iov_iter_advance(). Also get rid of __bio_iov_bvec_set(),
> which was duplicated in the final binary, and replace a weird
> iov_iter_truncate() of a temporal iter copy with min() better reflecting
> the intention.
> 
> Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
