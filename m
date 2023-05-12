Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1623FC77B7C
	for <linux-block@archiver.kernel.org>; Fri, 12 May 2023 13:39:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241308AbjELNjQ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 12 May 2023 09:39:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241299AbjELNjP (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 12 May 2023 09:39:15 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B52E13849
        for <linux-block@vger.kernel.org>; Fri, 12 May 2023 06:39:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=Gj2Wd502pQDHiqj8CANv5yEndIaTV/kdLQgO7pk/8KY=; b=s9ZM7fKais/vc1b9jcvx9/XcmC
        m6JFHRmPaILNr1CDOIAfX290VxUy6YP87U2MzqnMxu70F594xJXZjKAyVtU8xDnTHvGm5eFvEhooM
        K/pb8A9bh5YNk8QYhte1sipiQlC7QZfQFIjz/lL9wuUTrc9upSg7HiP798WU/zJ6L2yKwEmCL0BNl
        cIAO2dr4Xzw740NaHmEX6ZMd17Z1dVvIt3RNuZu0KxJFw4CdR9YdS5YecGC5bNfyDU0nCEXk115dC
        l56hz4axgmf0tbxTZtaoexvnZNFwNm0cOA3js7l/7y/oz4JCOL8u/GhLc8g2AtiKzRkmiYSkWwMlR
        /l5CbV7g==;
Received: from [204.239.251.3] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pxSzI-00C2hC-2K;
        Fri, 12 May 2023 13:39:12 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Jinyoung Choi <j-young.choi@samsung.com>,
        linux-block@vger.kernel.org
Subject: rationalize the flow in bio_add_page and friends
Date:   Fri, 12 May 2023 06:38:53 -0700
Message-Id: <20230512133901.1053543-1-hch@lst.de>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Jens,

when reviewing v2 of Jinyoung's "Change the integrity configuration
method in block" series I noticed that someone made a complete mess of
the bio_add_page flow, so this untangles this to make the code better
reusable for adding integrity payloads.  (I'll also have a word with
younger me when I get the chance about this..)

Diffstat:
 bio.c |  123 ++++++++++++++++++++++++++++--------------------------------------
 1 file changed, 53 insertions(+), 70 deletions(-)
