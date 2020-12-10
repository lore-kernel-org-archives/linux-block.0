Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C6C7C433FE
	for <linux-block@archiver.kernel.org>; Thu, 10 Dec 2020 07:56:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0035423D50
	for <linux-block@archiver.kernel.org>; Thu, 10 Dec 2020 07:56:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725953AbgLJH4a (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 10 Dec 2020 02:56:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733161AbgLJH4a (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 10 Dec 2020 02:56:30 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F55FC061793
        for <linux-block@vger.kernel.org>; Wed,  9 Dec 2020 23:55:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=ecVrKQAxwu8Wh+jkCCdnjMUBQ4mX9XPtiTmUI90wTaI=; b=l0wIT2UpTI4XaUlTInHssSYXgf
        PfmH3dDFX2VF8NvbI2Oiv2Lx3L89966Ov78kNkCuotBFIWDqMdSoJCnklHRcG6gK2zZPywQOctZ3x
        3hblJEaXQpm9hIKOeZ/vzT5D1tJiMAUOCwUzXJQwlov9CiWYYy21yL9parnPVf4xsLOH8WotM1WP9
        vXuchAVVmmmxJn+hJU5NzDbMEVkARo6+vEvXEa/PGZHWHVhy6JU/59KzsoVyOqaeVnCGZJgiklgiv
        smDR8MudN2GUJ+tuqVLWrQRkGuJsPO4fJlpHm9WHQaNhYvB5v1TJ1JnOCP4Xm5PTXTaYmeD0dkrQ2
        kRNJJx2A==;
Received: from [2001:4bb8:199:f14c:a24a:d231:8d9c:a947] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1knGnj-0002ZS-Pk; Thu, 10 Dec 2020 07:55:48 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org
Subject: [PATCH 2/3] block: remove a pointless self-reference in block_dev.c
Date:   Thu, 10 Dec 2020 08:55:43 +0100
Message-Id: <20201210075544.2715861-3-hch@lst.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201210075544.2715861-1-hch@lst.de>
References: <20201210075544.2715861-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

There is no point in duplicating the file name in the top of the file
comment.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/block_dev.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/fs/block_dev.c b/fs/block_dev.c
index 9e56ee1f265230..d2fa5009d5a481 100644
--- a/fs/block_dev.c
+++ b/fs/block_dev.c
@@ -1,7 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
- *  linux/fs/block_dev.c
- *
  *  Copyright (C) 1991, 1992  Linus Torvalds
  *  Copyright (C) 2001  Andrea Arcangeli <andrea@suse.de> SuSE
  */
-- 
2.29.2

