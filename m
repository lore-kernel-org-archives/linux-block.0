Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DB3AC433F5
	for <linux-block@archiver.kernel.org>; Tue, 12 Oct 2021 16:22:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 329C060F3A
	for <linux-block@archiver.kernel.org>; Tue, 12 Oct 2021 16:22:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231292AbhJLQYH (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 12 Oct 2021 12:24:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230389AbhJLQYG (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 12 Oct 2021 12:24:06 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EFA3C061570
        for <linux-block@vger.kernel.org>; Tue, 12 Oct 2021 09:22:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=CtwLJsTtcq/BFyHccuXymkLzRYEH77k6vfcOs0V4Q44=; b=pQibtr2I1O7pE6X+/piHcCHJy5
        ACZ9TDSNh8wimlroOO1CAHoCKuTqZvX6Jn0u9YMN2SgsANMeUQ7jZjQsEb4HRWs0OG0+dWPqFom1H
        a+yEWRs3S9qDopvapV3bCWhjUGt/eRLlr2yByoGOW/KrXC08PttJZe0WQkSIOPjlxGuN+zXLhZk/Q
        950tvIeBzC3fhjz7q/ijIiJ6jxLZzr+g+LoBwDzD3aoHcHp/9tOCgMA7eK9ZQA1D3blMgGvxmSTvd
        hoht5+aDutDIGy4h5kpyOuFf53LOBR0rmcZWaPznXbX4NGTUjyktTTZCUIgqeR1Ft/+XmptTk204V
        zxrMkMJw==;
Received: from [2001:4bb8:199:73c5:f5ed:58c2:719f:d965] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1maKWG-006e4S-Vj; Tue, 12 Oct 2021 16:21:05 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org
Subject: [PATCH 2/8] block: don't include <linux/ioprio.h> in <linux/bio.h>
Date:   Tue, 12 Oct 2021 18:17:58 +0200
Message-Id: <20211012161804.991559-3-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211012161804.991559-1-hch@lst.de>
References: <20211012161804.991559-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

bio.h doesn't need any of the definitions from ioprio.h.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 include/linux/bio.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/linux/bio.h b/include/linux/bio.h
index 65a356fa71109..ae94794d07c9d 100644
--- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@ -6,7 +6,6 @@
 #define __LINUX_BIO_H
 
 #include <linux/mempool.h>
-#include <linux/ioprio.h>
 /* struct bio, bio_vec and BIO_* flags are defined in blk_types.h */
 #include <linux/blk_types.h>
 #include <linux/uio.h>
-- 
2.30.2

