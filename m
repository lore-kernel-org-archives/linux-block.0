Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2CFEC433EF
	for <linux-block@archiver.kernel.org>; Mon, 18 Oct 2021 09:20:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A40566126A
	for <linux-block@archiver.kernel.org>; Mon, 18 Oct 2021 09:20:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231327AbhJRJWk (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 18 Oct 2021 05:22:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231149AbhJRJWk (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 18 Oct 2021 05:22:40 -0400
Received: from bombadil.infradead.org (unknown [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BE95C06161C
        for <linux-block@vger.kernel.org>; Mon, 18 Oct 2021 02:20:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=eG9blI9KtaBXoyg1vzpwsshEptyrqQim71SMwebbuqg=; b=YT+OFTaQI6N/zfapx3R1Q00lPa
        il8c9HjprFKFNINQ26UF1U4e2ukdW71gf2Ngzigq7lDSTasp3K6eoMmvcpUkNazOH06xzgurdpb0J
        grORXwGrb0m0QIz/qgpcrUiY/mSYjAgZ0xcLdWs/SmVZRkRHdzlbWjLNbAV11pQc/vDndFwuOcmk9
        UVg4noxEtrV/pzZelKYZ4QvkhQ/XOQSJkNFt9Y4rI9FVXGdnam+5U1sMf8m/C+1SbDx8RD2YwkSms
        zmKZA7I89ndv3eXXf+aLWj5Vr0TRBO0xwS5nTkkogzaurF6py87C78MIhjOy4HGzhkTDiBC28UFbz
        o/Ljv3hA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mcOom-00EmpN-WB; Mon, 18 Oct 2021 09:20:28 +0000
Date:   Mon, 18 Oct 2021 02:20:28 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org
Subject: Re: [PATCH 11/14] block: optimize blk_mq_rq_ctx_init()
Message-ID: <YW08XOurd+iv/xhz@infradead.org>
References: <20211017013748.76461-1-axboe@kernel.dk>
 <20211017013748.76461-12-axboe@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211017013748.76461-12-axboe@kernel.dk>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sat, Oct 16, 2021 at 07:37:45PM -0600, Jens Axboe wrote:
> This takes ~4.7% on a peak performance run, with this patch it brings it
> down to ~3.7%.
> 
> Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
> [axboe: rebase and move queuelist init]
> Signed-off-by: Jens Axboe <axboe@kernel.dk>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
