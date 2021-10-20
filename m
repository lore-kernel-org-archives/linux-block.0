Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E77A4C433EF
	for <linux-block@archiver.kernel.org>; Wed, 20 Oct 2021 06:11:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C3E466115A
	for <linux-block@archiver.kernel.org>; Wed, 20 Oct 2021 06:11:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229817AbhJTGOL (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 20 Oct 2021 02:14:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbhJTGOK (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 20 Oct 2021 02:14:10 -0400
Received: from bombadil.infradead.org (unknown [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45C13C06161C
        for <linux-block@vger.kernel.org>; Tue, 19 Oct 2021 23:11:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=TugVBeLPDjtmSxwq3ydX+IeFcQdAtFLXirbtSKrzM1M=; b=W0qFvOJIHptUDM4TXFkNRgfvn5
        QPFhd2qIrkTyoVPaneoumnGsFSbDAM1Q/hEPTLfDTFf75mv5n2WL8BST+YNZ9aQLKE3ylKk6FNR1c
        k6pgv2nhJ2DjxrAEHwja1cK5uUkP5G4Psi319+TDxBLNBR3YYnGNgr6cqN/aC18624ueuoDvktwIf
        r7ub+5QDtQUDypcMf8Q/ZQTtOh5dG9OH7Njb8VQIZ2oRdh3dHNDPv1iAhL5jHqJ8dkleUHsWDOLTq
        Im9wxU3y4dmadz/HDTozFaNZ41Xc91jUK29EdmJNLCS9LKO/BUn139c3Ms03m4t8NVn4MLnll4SjD
        mPyfFRqg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1md4pR-003SZa-0B; Wed, 20 Oct 2021 06:11:57 +0000
Date:   Tue, 19 Oct 2021 23:11:56 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Pavel Begunkov <asml.silence@gmail.com>
Cc:     linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH 03/16] block: optimise req_bio_endio()
Message-ID: <YW+zLDehzbh5T5NV@infradead.org>
References: <cover.1634676157.git.asml.silence@gmail.com>
 <8061fa49096e1a0e44849aa204a0a1ae57c4423a.1634676157.git.asml.silence@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8061fa49096e1a0e44849aa204a0a1ae57c4423a.1634676157.git.asml.silence@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Oct 19, 2021 at 10:24:12PM +0100, Pavel Begunkov wrote:
> First, get rid of an extra branch and chain error checks. Also reshuffle
> it with bio_advance(), so it goes closer to the final check, with that
> the compiler loads rq->rq_flags only once, and also doesn't reload
> bio->bi_iter.bi_size if bio_advance() didn't actually advanced the iter.

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>

We should also probably look into killing the whole strange RQF_QUIET
to BIO_QUIET some day.
