Return-Path: <SRS0=9ToN=AL=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 638DEC433E0
	for <linux-block@archiver.kernel.org>; Tue, 30 Jun 2020 04:57:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3507C206BE
	for <linux-block@archiver.kernel.org>; Tue, 30 Jun 2020 04:57:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="s7Zy4uke"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726309AbgF3E55 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 30 Jun 2020 00:57:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725440AbgF3E55 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 30 Jun 2020 00:57:57 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 423EEC061755
        for <linux-block@vger.kernel.org>; Mon, 29 Jun 2020 21:57:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=dE0ErKdSmYksJtFi6tWH8wBsJ7I+gIRpC4L7vOGghhQ=; b=s7Zy4uke8nUYXWVCzxePlZ3uCF
        u8xLzOXUxWZsPkGV4F2gFgfyGg8URDXwIt3ifQcBc1WjoKLP0h6rj+nao/QYx2P4Jf1m0DGiONCSU
        4lzVp8+nMomboAvIoxcNoh1qDrTULirGkwmC1nhmVxwpGl54SPOaFmIrGHjiL7FHJwpsO91XJ9KUm
        sFiDxX1i521N75egUMmRhW7q5L2Lm81TfapyxNRfdlq5HnSJKWNkGX0k7EO9TpmcgGIS0IcqM2wnL
        kDqYNmG26knHB1jf7QswD+RXh+NPlBTT/c/1k2M+WXpPLeQ8K2WV5EWQbYaFCHR2Rij7J/uXp8py/
        tMJgMLLw==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jq8LD-0004tM-9U; Tue, 30 Jun 2020 04:57:55 +0000
Date:   Tue, 30 Jun 2020 05:57:55 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 1/3] blk-mq: move blk_mq_get_driver_tag into blk-mq.c
Message-ID: <20200630045755.GC17653@infradead.org>
References: <20200630022356.2149607-1-ming.lei@redhat.com>
 <20200630022356.2149607-2-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200630022356.2149607-2-ming.lei@redhat.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Jun 30, 2020 at 10:23:54AM +0800, Ming Lei wrote:
> blk_mq_get_driver_tag() is only used by blk-mq.c and is supposed to
> stay in blk-mq.c, so move it and preparing for cleanup code of
> get/put driver tag.
> 
> Meantime hctx_may_queue() is moved to header file and it is fine
> since it is defined as inline always.

hctx_may_queue looks pretty big for an inline function to start with.

But except for that this looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
