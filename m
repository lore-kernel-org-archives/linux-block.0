Return-Path: <SRS0=r6We=DC=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9FA5C4741F
	for <linux-block@archiver.kernel.org>; Fri, 25 Sep 2020 16:15:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 95ED92371F
	for <linux-block@archiver.kernel.org>; Fri, 25 Sep 2020 16:15:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="SgK+9JZN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729265AbgIYQPP (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 25 Sep 2020 12:15:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727812AbgIYQPP (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 25 Sep 2020 12:15:15 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DDFEC0613CE;
        Fri, 25 Sep 2020 09:15:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=ksfrL9PUo8uW/j8LPVqdwsfYx8+SSBCrVtr6+p+r9KQ=; b=SgK+9JZNLAPx2gh+FchgvYcJnh
        5IFktPQWzPjSWeFrOn/PKUGdFpr1nEa3x7/cq6qHgX6YizKcwjEt2FxQo2xy966enzwuDjL0gfiNL
        g31+MOemaBM8uhwxFYO1hAA2P6/EvigC5CFwSSKU/xnBmUx29dCvMHYQh2mfyXGVGfOeEEfrlxdu7
        yFuxnjgAISiwg0tciqg5YMvN9cBmTA6DDH/HKKhobkoD/DsxJl4fxMRDrf/gQdvieHeU8m1jbb0J6
        Vin3XmdmQz6FAcFaHeEQHgTWSV2zJLAS3ZWaSeXrFxogLp4RZrkDRGmwX38nNOWe7od3F1Lsx5Eor
        8aJUTC9g==;
Received: from [213.208.157.35] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kLqNI-00040Z-1x; Fri, 25 Sep 2020 16:15:08 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Tejun Heo <tj@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        Minho Ban <mhban@samsung.com>
Cc:     cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [PATCH 2/2] PM/hibernate: remove the bogus call to get_gendisk in software_resume
Date:   Fri, 25 Sep 2020 18:14:47 +0200
Message-Id: <20200925161447.1486883-3-hch@lst.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200925161447.1486883-1-hch@lst.de>
References: <20200925161447.1486883-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

get_gendisk grabs a reference on the disk and file operation, so this
code will leak both of them while having absolutely no use for the
gendisk itself.

This effectively reverts commit 2df83fa4bce421f
("PM / Hibernate: Use get_gendisk to verify partition if resume_file is integer format")

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 kernel/power/hibernate.c | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/kernel/power/hibernate.c b/kernel/power/hibernate.c
index e7aa57fb2fdc33..7d0b99d2e69631 100644
--- a/kernel/power/hibernate.c
+++ b/kernel/power/hibernate.c
@@ -948,17 +948,6 @@ static int software_resume(void)
 
 	/* Check if the device is there */
 	swsusp_resume_device = name_to_dev_t(resume_file);
-
-	/*
-	 * name_to_dev_t is ineffective to verify parition if resume_file is in
-	 * integer format. (e.g. major:minor)
-	 */
-	if (isdigit(resume_file[0]) && resume_wait) {
-		int partno;
-		while (!get_gendisk(swsusp_resume_device, &partno))
-			msleep(10);
-	}
-
 	if (!swsusp_resume_device) {
 		/*
 		 * Some device discovery might still be in progress; we need
-- 
2.28.0

