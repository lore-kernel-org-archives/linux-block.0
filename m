Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71128C07E95
	for <linux-block@archiver.kernel.org>; Tue, 20 Jul 2021 07:17:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4F055610CC
	for <linux-block@archiver.kernel.org>; Tue, 20 Jul 2021 07:17:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229455AbhGTGhI (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 20 Jul 2021 02:37:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229726AbhGTGhB (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 20 Jul 2021 02:37:01 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A53A6C061574;
        Tue, 20 Jul 2021 00:17:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=nqlqdvq60YqR0ITsUfF5esvQsZ41hPM1Y9DdxWwsiu4=; b=ON/ceo/YwMyj/i7KQHuMZiTDg2
        hfpDBt+7kIzhZj2xykg/FHyv2Fs1NsPQbsboL10mjZR5Z4gBKt+E4fVxEMC43xDTzkHpy+RYhbHuy
        hVsxaP+sJc9QyXyO7WTKk3Fez31J5kAEF526hOJxJLag04WbLIDGoRFbG8X+DurQoJb+XNC66EjHU
        948504gSqQTfnchVd6ICbnixouv44ezwPPtGJ85qEK+SPwQAKo0DKYSNZhbpwtTXmCwVO1joIh9fp
        dLqJ+qKNc9+bY0peze4YQImsa9B6DVre6GRsHzH95fnQO5NygR1eis+TVSQWi1tJGYcbmgjpsekRT
        59Mzhkug==;
Received: from [2001:4bb8:193:7660:5612:5e3c:ba3d:2b3c] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m5jzf-007rWN-Dk; Tue, 20 Jul 2021 07:16:57 +0000
Date:   Tue, 20 Jul 2021 09:16:42 +0200
From:   Christoph Hellwig <hch@infradead.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-block@vger.kernel.org, "Darrick J . Wong" <djwong@kernel.org>
Subject: Re: [PATCH v15 14/17] iomap: Convert iomap_read_inline_data to take
 a folio
Message-ID: <YPZ4WrWDoivpF8jL@infradead.org>
References: <20210719184001.1750630-1-willy@infradead.org>
 <20210719184001.1750630-15-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210719184001.1750630-15-willy@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Jul 19, 2021 at 07:39:58PM +0100, Matthew Wilcox (Oracle) wrote:
> Inline data is restricted to being less than a page in size, so we
> don't need to handle multi-page folios.

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
