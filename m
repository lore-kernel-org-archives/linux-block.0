Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5AF1C07E9B
	for <linux-block@archiver.kernel.org>; Tue, 20 Jul 2021 02:11:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BBFC7610D0
	for <linux-block@archiver.kernel.org>; Tue, 20 Jul 2021 02:11:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235105AbhGTB2r (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 19 Jul 2021 21:28:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236426AbhGTBTz (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 19 Jul 2021 21:19:55 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20934C061574;
        Mon, 19 Jul 2021 18:59:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=gfv4SWPihbOlBBgsVRjGneuLWlqOMg9RErJa6LM44n4=; b=TFrG9dDEmBB+ho8K4txKIUBGC9
        JcN8c6U2/2/L5TGOiENqd1zd8i1vxnIA4eEpbz6l/IPJnBK6i87BtCF9wftieoKEVNO1M7xSkIfzT
        ZslW+SL11HiZYRD40oKPtFD7hEhD/Ky2UlY38rcc+xyLPtrZGjtzAxdfskmQcTT12SlYENkwWHaR8
        PG5BRspTwpv/UJ8eiq8VCPnaaekyH1UGmNEqJcJ2wY8JHBaYdVyA7FoBC67Y3X7QWuPp2FWzPhohA
        a//uq+5RyKdDlw4SPh8zm/VoHmr+/x+15SMGCCn/ESPvy2S0vnuPSUj/T76a1ojR1u/SuHbhWhhKv
        mj6BxJ6w==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m5f2f-007gk1-3a; Tue, 20 Jul 2021 01:59:35 +0000
Date:   Tue, 20 Jul 2021 02:59:29 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-block@vger.kernel.org
Subject: Re: [PATCH v15 02/17] block: Add bio_for_each_folio_all()
Message-ID: <YPYuAQOs4QZSUoaL@casper.infradead.org>
References: <20210719184001.1750630-1-willy@infradead.org>
 <20210719184001.1750630-3-willy@infradead.org>
 <20210720012945.GO22357@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210720012945.GO22357@magnolia>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Jul 19, 2021 at 06:29:45PM -0700, Darrick J. Wong wrote:
> On Mon, Jul 19, 2021 at 07:39:46PM +0100, Matthew Wilcox (Oracle) wrote:
> > Allow callers to iterate over each folio instead of each page.  The
> > bio need not have been constructed using folios originally.
> > 
> > Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> 
> Whoops, I never did remember to circle back and ack this patch.
> Reviewed-by: Darrick J. Wong <djwong@kernel.org>

That's all good; it made me ask "What more can I do?" and "Add
documentation" as always a good answer ...
