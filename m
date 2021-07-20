Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0776DC07E9B
	for <linux-block@archiver.kernel.org>; Tue, 20 Jul 2021 07:09:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E37D361164
	for <linux-block@archiver.kernel.org>; Tue, 20 Jul 2021 07:09:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231605AbhGTG22 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 20 Jul 2021 02:28:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231929AbhGTG2Y (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 20 Jul 2021 02:28:24 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4C23C061574;
        Tue, 20 Jul 2021 00:09:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=8F0r0DjRKDYOrXeOgcM69rnDtS/zx4idTRfWz8eAFbk=; b=pEkQdlYZxAIacnuInGbXvuaK/g
        l18Up7CtpfPXLoeqceLUSIQ3Qw7tir7W4GcDKf5bOmx4a9mw4+m0bkr0gqU+/tearzbpVT3ReT7gQ
        1rxL7IM83Ddk99bzf/6oKBtdL2By65viEE1NvxOi1wvoWuAmwL7q8kqNEdDuhzGPmh4WOL+CyGtU7
        /oPMJurDYS2nDTWG916VNWVtay0hgn92Bwr/QX3kg7IkhtoYu34k7Sxnv4Nyask+9tuQonBdEmqfo
        3/BxWgrNhGG+kIeoET+DMiRvsFoFAnjqNsIYtAlmYoFGESRo3nXTgrocj23dgZl07tcypt3TNRQQB
        uLBAdOhg==;
Received: from [2001:4bb8:193:7660:5612:5e3c:ba3d:2b3c] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m5jrQ-007r8w-Se; Tue, 20 Jul 2021 07:08:20 +0000
Date:   Tue, 20 Jul 2021 09:08:12 +0200
From:   Christoph Hellwig <hch@infradead.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-block@vger.kernel.org, "Darrick J . Wong" <djwong@kernel.org>
Subject: Re: [PATCH v15 10/17] iomap: Convert bio completions to use folios
Message-ID: <YPZ2XID8L2t5Hkde@infradead.org>
References: <20210719184001.1750630-1-willy@infradead.org>
 <20210719184001.1750630-11-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210719184001.1750630-11-willy@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Jul 19, 2021 at 07:39:54PM +0100, Matthew Wilcox (Oracle) wrote:
> Use bio_for_each_folio() to iterate over each folio in the bio
> instead of iterating over each page.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Reviewed-by: Darrick J. Wong <djwong@kernel.org>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
