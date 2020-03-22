Return-Path: <SRS0=AgPR=5H=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D5C5C4332B
	for <linux-block@archiver.kernel.org>; Sun, 22 Mar 2020 06:04:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFF8720753
	for <linux-block@archiver.kernel.org>; Sun, 22 Mar 2020 06:04:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726623AbgCVGE5 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 22 Mar 2020 02:04:57 -0400
Received: from mx2.suse.de ([195.135.220.15]:49096 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726502AbgCVGE5 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sun, 22 Mar 2020 02:04:57 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 8EC4EACA2;
        Sun, 22 Mar 2020 06:04:55 +0000 (UTC)
From:   Coly Li <colyli@suse.de>
To:     axboe@kernel.dk
Cc:     linux-bcache@vger.kernel.org, linux-block@vger.kernel.org,
        Davidlohr Bueso <dave@stgolabs.net>,
        Davidlohr Bueso <dbueso@suse.de>, Coly Li <colyli@suse.de>
Subject: [PATCH 6/7] bcache: optimize barrier usage for Rmw atomic bitops
Date:   Sun, 22 Mar 2020 14:03:04 +0800
Message-Id: <20200322060305.70637-7-colyli@suse.de>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200322060305.70637-1-colyli@suse.de>
References: <20200322060305.70637-1-colyli@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Davidlohr Bueso <dave@stgolabs.net>

We can avoid the unnecessary barrier on non LL/SC architectures,
such as x86. Instead, use the smp_mb__after_atomic().

Signed-off-by: Davidlohr Bueso <dbueso@suse.de>
Signed-off-by: Coly Li <colyli@suse.de>
---
 drivers/md/bcache/writeback.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/md/bcache/writeback.c b/drivers/md/bcache/writeback.c
index 6673a37c8bd2..72ba6d015786 100644
--- a/drivers/md/bcache/writeback.c
+++ b/drivers/md/bcache/writeback.c
@@ -183,7 +183,7 @@ static void update_writeback_rate(struct work_struct *work)
 	 */
 	set_bit(BCACHE_DEV_RATE_DW_RUNNING, &dc->disk.flags);
 	/* paired with where BCACHE_DEV_RATE_DW_RUNNING is tested */
-	smp_mb();
+	smp_mb__after_atomic();
 
 	/*
 	 * CACHE_SET_IO_DISABLE might be set via sysfs interface,
@@ -193,7 +193,7 @@ static void update_writeback_rate(struct work_struct *work)
 	    test_bit(CACHE_SET_IO_DISABLE, &c->flags)) {
 		clear_bit(BCACHE_DEV_RATE_DW_RUNNING, &dc->disk.flags);
 		/* paired with where BCACHE_DEV_RATE_DW_RUNNING is tested */
-		smp_mb();
+		smp_mb__after_atomic();
 		return;
 	}
 
@@ -229,7 +229,7 @@ static void update_writeback_rate(struct work_struct *work)
 	 */
 	clear_bit(BCACHE_DEV_RATE_DW_RUNNING, &dc->disk.flags);
 	/* paired with where BCACHE_DEV_RATE_DW_RUNNING is tested */
-	smp_mb();
+	smp_mb__after_atomic();
 }
 
 static unsigned int writeback_delay(struct cached_dev *dc,
-- 
2.25.0

