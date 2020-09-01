Return-Path: <SRS0=kheS=CK=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C539DC433E2
	for <linux-block@archiver.kernel.org>; Tue,  1 Sep 2020 05:43:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9F3D82098B
	for <linux-block@archiver.kernel.org>; Tue,  1 Sep 2020 05:43:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="LGrO/pmz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726139AbgIAFnq (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 1 Sep 2020 01:43:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726006AbgIAFnp (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 1 Sep 2020 01:43:45 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EB76C0612A3
        for <linux-block@vger.kernel.org>; Mon, 31 Aug 2020 22:43:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=YEj7/wEPTlRCpYaq+WKOscUIlOCINKkL1exvna/yPWE=; b=LGrO/pmz4yKqNJAulmaLXI55Ro
        6NNaNcSr5/ck5T/zuyP2aaDjn6ceATxOUAlwe2xHqW8bs77wXh2OEa54zBwqFhRTXqT+6nPC/d7fC
        6K3VbiJPl3YpAKbf7kmdyTZdLoXpEvtgJsEf8Y0ix+eY+VbeZqGU/juKU6e/5+Pv1hSuqv6x7om+F
        jnBlybiYkozAL7nGBSEpWkDYzVBmJCasd3iufsowPbD1WrjKO9zwj1WqBV2vQxuV5jGsJKmD0MulZ
        XHxo/eo55hxMYy/7c28LxLGul+5FHVwxwXIKXoi187Cep9SWvYCnJKeGkDX4ixnR4X/ufzzMyQJH1
        tLcNgwFw==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kCz55-0007rh-Cl; Tue, 01 Sep 2020 05:43:43 +0000
Date:   Tue, 1 Sep 2020 06:43:43 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Subject: Re: [PATCH] block: ensure bdi->io_pages is always initialized
Message-ID: <20200901054343.GB29886@infradead.org>
References: <346e5bf5-b08e-84e8-7b0e-c6cb0c814f96@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <346e5bf5-b08e-84e8-7b0e-c6cb0c814f96@kernel.dk>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Aug 31, 2020 at 11:23:32AM -0600, Jens Axboe wrote:
> If a driver leaves the limit settings as the defaults, then we don't
> initialize bdi->io_pages. This means that file systems may need to
> work around bdi->io_pages == 0, which is somewhat messy.
> 
> Initialize the default value just like we do for ->ra_pages.
> 
> Cc: stable@vger.kernel.org

This should be a fixes for the commit originally adding ->io_pages
instead.

Otherwise looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
