Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E149BC636C8
	for <linux-block@archiver.kernel.org>; Tue, 20 Jul 2021 07:11:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 60A8B6113B
	for <linux-block@archiver.kernel.org>; Tue, 20 Jul 2021 07:11:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233066AbhGTGa3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 20 Jul 2021 02:30:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232211AbhGTGa3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 20 Jul 2021 02:30:29 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F22CC061574;
        Tue, 20 Jul 2021 00:11:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=UzAuDd83H6Ob7ClOmB94gVc3oTlSRnahgjr4O8IG0zg=; b=SOycqF7cgrJLCUjNMTSwR9+YS4
        osRPymF8NcnruFpA8nQTQpHaVdhCHhVm6botg1ahqnJ3N/sobVsRQvNiDXYyTS0dc3J4D4gUKPJ/k
        5HwKGhJMeW8XNi8wVfOFEWIM6/0apEytmmM5Yl92q2JiFaxywNIwWAoLpF3Y3TwoD0s03qgkvaWO+
        WAGcIulqgWTjyBekCbt3Z1jZo5Apmwul2GTHsi1r7ewn8YsvOrjOMG18eoHBkT26O/t2Zeuf8C858
        M3mCTnSJ9e48msCpZyIerHQ5Yf/JDY/jTk7kvric9w/fXkyYT9jH/jdPB44Qu+5PKhGyyXBeo5v83
        b9f41zQg==;
Received: from [2001:4bb8:193:7660:5612:5e3c:ba3d:2b3c] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m5jsk-007rBa-3I; Tue, 20 Jul 2021 07:09:59 +0000
Date:   Tue, 20 Jul 2021 09:09:33 +0200
From:   Christoph Hellwig <hch@infradead.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-block@vger.kernel.org, "Darrick J . Wong" <djwong@kernel.org>
Subject: Re: [PATCH v15 11/17] iomap: Convert readahead and readpage to use a
 folio
Message-ID: <YPZ2raTFeF1oEsLs@infradead.org>
References: <20210719184001.1750630-1-willy@infradead.org>
 <20210719184001.1750630-12-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210719184001.1750630-12-willy@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Jul 19, 2021 at 07:39:55PM +0100, Matthew Wilcox (Oracle) wrote:
> Handle folios of arbitrary size instead of working in PAGE_SIZE units.

Ok, this is a real conflict vs the iter work, but otherwise it looks
fine.
