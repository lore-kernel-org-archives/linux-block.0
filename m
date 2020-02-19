Return-Path: <SRS0=ya0H=4H=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33D95C34047
	for <linux-block@archiver.kernel.org>; Wed, 19 Feb 2020 16:34:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07BDC24671
	for <linux-block@archiver.kernel.org>; Wed, 19 Feb 2020 16:34:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Rdlyb6dG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726729AbgBSQeD (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 19 Feb 2020 11:34:03 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:34142 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726712AbgBSQeD (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 19 Feb 2020 11:34:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=kvvlMPs9AAhAXpaJ/VQKWKqR+Z43B+ioinocZAU646w=; b=Rdlyb6dGJGY7RmNXjZ5XMIRq7h
        Mg9k0tx88a+iQOS286IjD0Y0OZ4DmQkT5+bwZL0ukOLGrDzlKEBmJtWcwMIkdOAFLMsOtJquSjT59
        FTF9RSSXzqwsuTMY8MzCfPOA5KZA6U52dzLjEQWH1NLveZDt4N6m0MmrYtDyNN/38JYiO8NwBKwsS
        wbd9eyG093ic+5dbPCNeu4nnZ3gUs9vcC3J5rzXCIfBQ4DE0p/T6hvQIs4X+4PnQ7N+dFQ3Qg3svC
        j5mLfFNMMWP1h9Fba2tYrMrshKtoYQ+wOQHha6kiawN+3SdZKjv7mkIaqPLDg1VAfTCqwhkCoJylL
        YTjVvgTA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j4SIU-0005if-GC; Wed, 19 Feb 2020 16:34:02 +0000
Date:   Wed, 19 Feb 2020 08:34:02 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Alexey Dobriyan <adobriyan@gmail.com>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org, hare@suse.de
Subject: Re: [PATCH] block, zoned: fix integer overflow with BLKRESETZONE et
 al
Message-ID: <20200219163402.GC18377@infradead.org>
References: <20200212174027.GA3535@avx2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200212174027.GA3535@avx2>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>

Can you wire up your test for blktests?
