Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10EA1C433EF
	for <linux-block@archiver.kernel.org>; Mon, 20 Sep 2021 12:40:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EE07B61040
	for <linux-block@archiver.kernel.org>; Mon, 20 Sep 2021 12:40:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231361AbhITMmV (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 20 Sep 2021 08:42:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233818AbhITMmV (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 20 Sep 2021 08:42:21 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 621A2C061760
        for <linux-block@vger.kernel.org>; Mon, 20 Sep 2021 05:40:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=eb1cMZHo+CU7OQx66iykkaGOuWhkW1Li7UWCzyYEOFs=; b=K9mE2LhQmMso8MXhybs0b92VT3
        VEkpC18sdDZa4qrdi/ZLYcVFhArCKwnZ9OO8ldX4SvTGaZI3psRvxEP3qN2oaAPe09HffpNQMrYgD
        ryfTE70La2gfpWv59NaMPg0e2vNT912l7HTqEdxK6ElDS1JgD94g+J7Jic1/NhdasDbtMMf8kNeCu
        N+wukswBZwMZ934E7q3dYk+eRxBl3jYcfnM6efmKIikhd7jfzk89wl+Q0Ude9HgkotpsGm03f2z48
        bkzaj17RHyZinwplnb+OJCn9XVdWDra+NF4K96laep3ZEUYVt2OWdaZhXP3nHvjlm1CynjLpbJCpQ
        lBvF1mOw==;
Received: from [2001:4bb8:184:72db:7ad9:14d9:8599:3025] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mSIam-002fKL-0q; Mon, 20 Sep 2021 12:40:37 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH 10/17] block: remove the cmd_size field from struct request_queue
Date:   Mon, 20 Sep 2021 14:33:21 +0200
Message-Id: <20210920123328.1399408-11-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210920123328.1399408-1-hch@lst.de>
References: <20210920123328.1399408-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Entirely unused.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 include/linux/blkdev.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 9e367509bea10..6737e484280d3 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -544,8 +544,6 @@ struct request_queue {
 
 	bool			mq_sysfs_init_done;
 
-	size_t			cmd_size;
-
 #define BLK_MAX_WRITE_HINTS	5
 	u64			write_hints[BLK_MAX_WRITE_HINTS];
 };
-- 
2.30.2

