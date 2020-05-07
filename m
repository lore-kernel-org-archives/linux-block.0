Return-Path: <SRS0=Cb6v=6V=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 006E2C38A24
	for <linux-block@archiver.kernel.org>; Thu,  7 May 2020 06:11:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CBBE72075E
	for <linux-block@archiver.kernel.org>; Thu,  7 May 2020 06:11:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Gar+xYwi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726267AbgEGGLV (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 7 May 2020 02:11:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725783AbgEGGLU (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 7 May 2020 02:11:20 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E74D6C061A0F
        for <linux-block@vger.kernel.org>; Wed,  6 May 2020 23:11:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:To:From:Date:Sender:Reply-To:Cc:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=/CiE9/zPOJyS1AMdjnkgkhQNH3xvNAzyRJgwZEosfoE=; b=Gar+xYwiWejF0JGaDXdbGonNg/
        GJABLb6XwLt0dZnuZxeNeiQa1rKy/Iqi2G5grQDDkMm8Z659D8dJhcp7tLAZ9ilUxS0xwHADdy4r6
        26jUryIZD+DCc5AmxnnGmse+fSLcWpfCGhIx3/h7jphME/bn9EbwC1A/4rBpFFmC+r2FAnnYN9CWL
        A9Xpf2K/Q7Xr/Yeg0IfA9l1el+oEpEkETvYSlukwgHr3DW7mzf4pd7Q4NCaQbcVg9Q1WopDa5w8Yi
        3wD3nZu5W9mJDQ9VHuy2Qx/5UPiMqqJVVYj5PXZhyX1bNiPLZPhUYtx4umkc9cYg1zWDAnN3/V9ys
        LMXVELtQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jWZkd-00022n-HL; Thu, 07 May 2020 06:11:19 +0000
Date:   Wed, 6 May 2020 23:11:19 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     axboe@kernel.dk, tom.leiming@gmail.com, bvanassche@acm.org,
        linux-block@vger.kernel.org
Subject: Re: [PATCH v5 2/5] block: save previous hardware queue count before
 udpate
Message-ID: <20200507061119.GB23530@infradead.org>
References: <cover.1588660550.git.zhangweiping@didiglobal.com>
 <360dd293fa245d612b85a338a0f6577a9b5dcee8.1588660550.git.zhangweiping@didiglobal.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <360dd293fa245d612b85a338a0f6577a9b5dcee8.1588660550.git.zhangweiping@didiglobal.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, May 05, 2020 at 02:43:28PM +0800, Weiping Zhang wrote:
> blk_mq_realloc_tag_set_tags will update set->nr_hw_queues, so
> save old set->nr_hw_queues before call this function.
> 
> Reviewed-by: Bart Van Assche <bvanassche@acm.org>
> Reviewed-by: Ming Lei <ming.lei@redhat.com>
> Signed-off-by: Weiping Zhang <zhangweiping@didiglobal.com>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
