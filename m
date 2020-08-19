Return-Path: <SRS0=HYnl=B5=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 939A7C433DF
	for <linux-block@archiver.kernel.org>; Wed, 19 Aug 2020 07:35:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7374B20738
	for <linux-block@archiver.kernel.org>; Wed, 19 Aug 2020 07:35:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="L60iyXMp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726783AbgHSHfi (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 19 Aug 2020 03:35:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726752AbgHSHfi (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 19 Aug 2020 03:35:38 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7FF2C061389;
        Wed, 19 Aug 2020 00:35:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=ALN5kFDgzhB0DwooVpV2UYLktEkRB74xiD6k/l7xTy4=; b=L60iyXMpO68mfQyGPpHhjBg9KS
        5psJh/Y7ygSscpz4SpWA5lRjEYNEq199tLjyIC0Ug5AUqwTy8LRqO/Uiv3rxyWhWOB76QxNO7m87l
        cpaaN72oXAK+iDAEEASfLxj3sayOH4Z8iUJcJvsqdeSKqS/+MtpDMv/Zi2L+h2609gIRVLeZz/SBn
        xpafJ0zHkU3hI32FZ1ylLtYrTpO5ijWuHBNKmRhT6GrsGMoBU1PRdqnaCtQks0ESR6JKK+72mR7TA
        XqYYu5DyyVEHm67GzGjBTxWBfqU+5e5ur//7PWaPhO447CEDDKe4Lwm8tKEm1X1v9StSxCS1iI0ng
        akpP7wDQ==;
Received: from [2001:4bb8:198:f3b2:86b6:2277:f429:37a1] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k8IdD-00042v-RK; Wed, 19 Aug 2020 07:35:36 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] raw: deprecate the raw driver
Date:   Wed, 19 Aug 2020 09:35:33 +0200
Message-Id: <20200819073533.1808361-1-hch@lst.de>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The raw driver has been replaced by O_DIRECT support on the block device
in 2002.  Deprecate it to prepare for removal in a few kernel releases.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---

Jens, I wonder if we can sneak this into 5.9 to have a longer deprecation
period?

 drivers/char/raw.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/char/raw.c b/drivers/char/raw.c
index 380bf518338ef7..ccf5bd528642da 100644
--- a/drivers/char/raw.c
+++ b/drivers/char/raw.c
@@ -63,6 +63,11 @@ static int raw_open(struct inode *inode, struct file *filp)
 		return 0;
 	}
 
+	pr_warn_ratelimited(
+		"process %s (pid %d) is using the deprecated raw device\n"
+		"support will be removed in Linux 5.14.\n",
+		current->comm, current->pid);
+
 	mutex_lock(&raw_mutex);
 
 	/*
-- 
2.28.0

