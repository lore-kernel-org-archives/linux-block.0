Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4947CC6FA82
	for <linux-block@archiver.kernel.org>; Wed, 21 Sep 2022 18:05:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229560AbiIUSFK (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 21 Sep 2022 14:05:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229741AbiIUSFJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 21 Sep 2022 14:05:09 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6723F3A4BE
        for <linux-block@vger.kernel.org>; Wed, 21 Sep 2022 11:05:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=0zX0iowPidWaFfvqbhokWj0YdOeVLCAi6S9WZ0i/sgE=; b=HqRsVoq62njR92H9WScPSQ0Wpa
        RpTLrYLd7e4ISuJ7vDJurrhOZFN9WySm5Bhgv12TurPgmNGQQ+cA2H8HKySpKCGHlspPBNtdHsFFj
        O7dbUXlEnqBBM1xo4VCA0ixUPqQSG6XXL8JRzaj+8NpmwVuRvZoIfVGBO/rdCpT5fXoeUy494t1Tm
        DdVT2CrwUZnUUQbkMT7j/1MFnZ1jzm/PGC0VCdVBiAVjQ3qaCHt8Fso0yGdB8mD/zpFfDhxluPQSp
        LhsMXRm71bQgNJtJKrXzqg7TECYMSbz1VYFMeD5PledQ3VXHduGdE2JBQLqM7g13P6x9B9o88QpDY
        JvKTzoGA==;
Received: from ip4d15bec4.dynamic.kabel-deutschland.de ([77.21.190.196] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ob45r-00CGWA-1I; Wed, 21 Sep 2022 18:05:07 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Tejun Heo <tj@kernel.org>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org
Subject: [PATCH 01/17] blk-cgroup: fix error unwinding in blkcg_init_queue
Date:   Wed, 21 Sep 2022 20:04:45 +0200
Message-Id: <20220921180501.1539876-2-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220921180501.1539876-1-hch@lst.de>
References: <20220921180501.1539876-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

When blk_throtl_init fails, we need to call blk_ioprio_exit.  Switch to
proper goto based unwinding to fix this.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-cgroup.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index 869af9d72bcf8..3a88f8c011d27 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -1297,17 +1297,18 @@ int blkcg_init_queue(struct request_queue *q)
 
 	ret = blk_throtl_init(q);
 	if (ret)
-		goto err_destroy_all;
+		goto err_ioprio_exit;
 
 	ret = blk_iolatency_init(q);
-	if (ret) {
-		blk_throtl_exit(q);
-		blk_ioprio_exit(q);
-		goto err_destroy_all;
-	}
+	if (ret)
+		goto err_throtl_exit;
 
 	return 0;
 
+err_throtl_exit:
+	blk_throtl_exit(q);
+err_ioprio_exit:
+	blk_ioprio_exit(q);
 err_destroy_all:
 	blkg_destroy_all(q);
 	return ret;
-- 
2.30.2

