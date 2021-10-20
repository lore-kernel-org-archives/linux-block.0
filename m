Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B58DC433F5
	for <linux-block@archiver.kernel.org>; Wed, 20 Oct 2021 06:13:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 38B816113D
	for <linux-block@archiver.kernel.org>; Wed, 20 Oct 2021 06:13:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229864AbhJTGPY (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 20 Oct 2021 02:15:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229789AbhJTGPX (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 20 Oct 2021 02:15:23 -0400
Received: from bombadil.infradead.org (unknown [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDA93C061746
        for <linux-block@vger.kernel.org>; Tue, 19 Oct 2021 23:13:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=a00R6d4TAEPF0XHBJyQJxJIVupGt+zm8a4/9/AYiVdQ=; b=PatQNs/7w270X1+i0UzNAQGyh8
        Gsaz2ShyPFwNvf5cDhrE9OW+KNmMD601G6aVZqC1sn/z67ruK2KGqRHiK/Obgq5Gt6O9zutZuX8SW
        3XcP5nTbVXPbQKLrVoc7RkJspJqd0Mavk2IFhM8MRrmCA/lcfjOByDFtTMxt4sawPDy0bhMzPW3NT
        EXiLIgKSHLVjTp8IiJkIdQ1JWDO7ZLhdH7TEOTLs8lI3yo7H8MT/vqf6JgcORA+gtMEzqpxgck/pX
        6QPaK57tx/S8teZSSrjR+FBrO4AvUqf3L88IZR2BdMxgjCXYS/bmI9rweYSiUA5JIRxBvXHuigd5t
        sfHKSQkw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1md4qb-003Scc-KI; Wed, 20 Oct 2021 06:13:09 +0000
Date:   Tue, 19 Oct 2021 23:13:09 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Pavel Begunkov <asml.silence@gmail.com>
Cc:     linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH 05/16] block: inline a part of bio_release_pages()
Message-ID: <YW+zdYMG2FUlzXWA@infradead.org>
References: <cover.1634676157.git.asml.silence@gmail.com>
 <c01c0d2c4d626eb1b63b196d98375a7e89d50db3.1634676157.git.asml.silence@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c01c0d2c4d626eb1b63b196d98375a7e89d50db3.1634676157.git.asml.silence@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Oct 19, 2021 at 10:24:14PM +0100, Pavel Begunkov wrote:
> Inline BIO_NO_PAGE_REF check of bio_release_pages() to avoid function
> call.

Fine with me, but it seems like we're really getting into benchmarketing
at some point..
