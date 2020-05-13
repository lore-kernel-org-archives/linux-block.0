Return-Path: <SRS0=8+4U=63=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CB7BCA90AF
	for <linux-block@archiver.kernel.org>; Wed, 13 May 2020 11:04:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4624F20753
	for <linux-block@archiver.kernel.org>; Wed, 13 May 2020 11:04:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="LQ63f9Pr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730390AbgEMLEZ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 13 May 2020 07:04:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730214AbgEMLEZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 13 May 2020 07:04:25 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B788C061A0E
        for <linux-block@vger.kernel.org>; Wed, 13 May 2020 04:04:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=Wzj0BE24Orj82qvRKqxawxLi7MPwKCncErumtFghwV4=; b=LQ63f9PriiRssz6kuyhNEMPEYd
        pyrBa6l5+zCix6t4GwhMg/93DXySHreE2b7F/J45vBgKASaPpc7V34lF/OsDNgMVg9r1wqOojJcuW
        5P1P/VkzneMU5URgT4Pnfci8OL8J5K/MIAhpEFWuKOTOAV0L2YZm+cQ6A4R94F9S8vMEc8Q9VliFL
        VhBU4otXGanLkMxeFHzZou17qwuhx9GpL9WV2bXuamuzpJFqFp60tZi4WLgpOL34yyA+IEXCtB3y3
        RSDyOoRIRsvZ2F+AgyUZK/uY7KMuKQw23sHVIsslFJriK7UyEhW6F+BI+Xd36t7rSQnViK5TEGobJ
        12YCkb9A==;
Received: from [2001:4bb8:180:9d3f:c70:4a89:bc61:2] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jYpBW-0006i8-7c; Wed, 13 May 2020 11:04:22 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org
Subject: avoid a few q_usage_counter roundtrips
Date:   Wed, 13 May 2020 13:04:15 +0200
Message-Id: <20200513110419.2362556-1-hch@lst.de>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Jens,

the way we track reference on q_usage_counter is a little weird at the
moment, in that we often have to grab another reference in addition to
the current one.  This small series reshuffles that to avoid the extra
references in the normal I/O path.
