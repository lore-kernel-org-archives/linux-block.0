Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03FAEC56202
	for <linux-block@archiver.kernel.org>; Thu, 26 Nov 2020 10:01:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 870B52145D
	for <linux-block@archiver.kernel.org>; Thu, 26 Nov 2020 10:01:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="h0uDclPY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387541AbgKZKBE (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 26 Nov 2020 05:01:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733303AbgKZKBD (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 26 Nov 2020 05:01:03 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D829C0613D4
        for <linux-block@vger.kernel.org>; Thu, 26 Nov 2020 02:01:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=BRHFOTm+tQhdn1gNaiBOC8VeQJ5kEaz0qTCn1lo5kCI=; b=h0uDclPYF+Wcyqcdu91qu1MlQ2
        hEaxdMMm5qGuiV4cOr2DG8PLxhNNJr67wbR1WWXufWu/ZJ2w6E+RgtSnB6+BkOokgFp2Id4ALyN8e
        cZFlZogD5ZFHWR586B5uh4wuNzLDbSaSn9fPdB7/MrCFurPPzSFlkZ8Yg7gH9eSgwx7JDn1lHJFTX
        AqfmMc18zquIPd8FXFW+5XrRwOat4I8Gt/JHq0pMkVfa49+mcft8HTLvRmh+am8LHcNQChK578Y5b
        BeTTeAk4QCAjYy2eyoMpF+vVe8oNz+cL0eOgQn9WmhM3CRHN/O3k3XOKpJjPf2rzB2ZiCCjmsZOBn
        4NENdL/g==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kiE5D-0000XC-LL; Thu, 26 Nov 2020 10:00:59 +0000
Date:   Thu, 26 Nov 2020 10:00:59 +0000
From:   Christoph Hellwig <hch@infradead.org>
To:     Pavel Begunkov <asml.silence@gmail.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Ming Lei <ming.lei@redhat.com>,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 1/2] block: optimise for_each_bvec() advance
Message-ID: <20201126100059.GA949@infradead.org>
References: <cover.1606240077.git.asml.silence@gmail.com>
 <8a399fe52e05c5aece4424b4ce114ec4e5b40b99.1606240077.git.asml.silence@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8a399fe52e05c5aece4424b4ce114ec4e5b40b99.1606240077.git.asml.silence@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Nov 24, 2020 at 05:58:12PM +0000, Pavel Begunkov wrote:
> Because of how for_each_bvec() works it never advances across multiple
> entries at a time, so bvec_iter_advance() is an overkill. Add
> specialised bvec_iter_advance_single() that is faster. It also handles
> zero-len bvecs, so can kill bvec_iter_skip_zero_bvec().
> 
>    text    data     bss     dec     hex filename
> before:
>   23977     805       0   24782    60ce lib/iov_iter.o
> before, bvec_iter_advance() w/o WARN_ONCE()
>   22886     600       0   23486    5bbe ./lib/iov_iter.o
> after:
>   21862     600       0   22462    57be lib/iov_iter.o
> 
> Reviewed-by: Ming Lei <ming.lei@redhat.com>
> Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
