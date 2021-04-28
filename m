Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C511C43460
	for <linux-block@archiver.kernel.org>; Wed, 28 Apr 2021 16:51:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3772F61400
	for <linux-block@archiver.kernel.org>; Wed, 28 Apr 2021 16:51:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241320AbhD1Qvv (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 28 Apr 2021 12:51:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241291AbhD1Qvt (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 28 Apr 2021 12:51:49 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87231C061573
        for <linux-block@vger.kernel.org>; Wed, 28 Apr 2021 09:51:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=jjtZK79DrB4Nv89UYctUJuPuhcipyTFrzsVZ/GZ0Ev4=; b=J2OOKPpeqhw1nltO3lCAK4NsH2
        b7xi6CkdwAn8X9HtsmoDc/+1MIUnK7dHAsB4fz1C9kxOHvqlnQavCmVECojpgG+yDtUX7mL7uLRVh
        HWWn/ZwJfA+PpDvyPP0l7MpVSDs02GqwJeDiEXvPzuSdt3kOmwD5+Or1T+DA8Zv2NQEunxOPtYZuX
        W+I0V42qiZFgOmxTGfTyZlkyqymopd0h/kH9GbaVA7h9kbIxmzPnERB1QzQNcUPhwzZtBj19PZr27
        EPv9RjV1MPgkMi13mtpGwL5TzCKdKlEhM3S3a8ZeGySOGeHQB/TnHlfq1qzzjEcxoM1s18H1UHpQD
        qvM6JyhQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lbnOe-008ZGe-7p; Wed, 28 Apr 2021 16:50:49 +0000
Date:   Wed, 28 Apr 2021 17:50:44 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     linux-block@vger.kernel.org
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Subject: bio_add_folio argument order
Message-ID: <20210428165044.GB1847222@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

bio_add_page() has its arguments in the wrong order:

extern int bio_add_page(struct bio *, struct page *, unsigned int,unsigned int);

Oh, right, and the prototype commits the cardinal sin of just giving you
a pair of unsigned ints and doesn't bother to tell you what they mean.
I'll send a patch for that ... anyway:

int bio_add_page(struct bio *bio, struct page *page,
                 unsigned int len, unsigned int offset)

This fails to follow #4: https://ozlabs.org/~rusty/index.cgi/tech/2008-03-30.html

Here's what I want to do for the folio equivalent:

size_t bio_add_folio(struct bio *bio, struct folio *folio, size_t off,
                size_t len)

This will make the transition more painful, but it does remove an irritant
for the future.  Any objections?
