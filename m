Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 636CBC4743C
	for <linux-block@archiver.kernel.org>; Mon, 21 Jun 2021 10:39:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 46E616023C
	for <linux-block@archiver.kernel.org>; Mon, 21 Jun 2021 10:39:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230225AbhFUKlj (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 21 Jun 2021 06:41:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230380AbhFUKlh (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 21 Jun 2021 06:41:37 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1705DC06175F
        for <linux-block@vger.kernel.org>; Mon, 21 Jun 2021 03:39:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=8DC+cLK5HJ7QsVGdSBUQEOFoPNsSLMqdpKgav0tDs1M=; b=Q2bk/9vSTSwnIZEDlcbNnuwRwx
        gEhQy8CDfBcEN2XCdxzvYZXZpYYx1r68k3KLJuIFxJMBvLDbtal40D4olLRLxJLAC8vJQYxFZxG20
        oauyGrMgmyb+ILBuq066e8p3ObFVwRXn69xSj+woiCti1szmFYeIYwi48gSEmeNpdHdmf/1OCm95+
        bpDQPFL3jYlS+c0S6zW6yPg99Gbf0dd8dNt+5a8Igt0sqYBBzSzJBLz0Jz7n8mt4uBqzqVEmgoJMm
        UzQw9qBpW87W758i48Dz/D1X21ImcikaKgUNebUHWJ9GJ2vdsTPKUqvtTcupo60te6oA8wF4LvBN2
        1gfReRbw==;
Received: from 089144193030.atnat0002.highway.a1.net ([89.144.193.30] helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lvHKJ-00CzcS-9s; Mon, 21 Jun 2021 10:38:51 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        linux-block@vger.kernel.org
Subject: [PATCH 8/9] loop: split loop_lookup
Date:   Mon, 21 Jun 2021 12:15:46 +0200
Message-Id: <20210621101547.3764003-9-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210621101547.3764003-1-hch@lst.de>
References: <20210621101547.3764003-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

loop_lookup has two callers - one wants to do the a find by index and the
other wants any unbound loop device.  Open code the respective
functionality in each caller.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/block/loop.c | 57 ++++++++++----------------------------------
 1 file changed, 12 insertions(+), 45 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 54e2551e339c..2ff5162bd28b 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -2184,44 +2184,6 @@ static void loop_remove(struct loop_device *lo)
 	kfree(lo);
 }
 
-static int find_free_cb(int id, void *ptr, void *data)
-{
-	struct loop_device *lo = ptr;
-	struct loop_device **l = data;
-
-	if (lo->lo_state == Lo_unbound) {
-		*l = lo;
-		return 1;
-	}
-	return 0;
-}
-
-static int loop_lookup(struct loop_device **l, int i)
-{
-	struct loop_device *lo;
-	int ret = -ENODEV;
-
-	if (i < 0) {
-		int err;
-
-		err = idr_for_each(&loop_index_idr, &find_free_cb, &lo);
-		if (err == 1) {
-			*l = lo;
-			ret = lo->lo_number;
-		}
-		goto out;
-	}
-
-	/* lookup and return a specific i */
-	lo = idr_find(&loop_index_idr, i);
-	if (lo) {
-		*l = lo;
-		ret = lo->lo_number;
-	}
-out:
-	return ret;
-}
-
 static void loop_probe(dev_t dev)
 {
 	int idx = MINOR(dev) >> part_shift;
@@ -2245,9 +2207,11 @@ static int loop_control_remove(int idx)
 	if (ret)
 		return ret;
 
-	ret = loop_lookup(&lo, idx);
-	if (ret < 0)
+	lo = idr_find(&loop_index_idr, idx);
+	if (!lo) {
+		ret = -ENODEV;
 		goto out_unlock_ctrl;
+	}
 
 	ret = mutex_lock_killable(&lo->lo_mutex);
 	if (ret)
@@ -2271,17 +2235,20 @@ static int loop_control_remove(int idx)
 static int loop_control_get_free(int idx)
 {
 	struct loop_device *lo;
-	int ret;
+	int id, ret;
 
 	ret = mutex_lock_killable(&loop_ctl_mutex);
 	if (ret)
 		return ret;
-	ret = loop_lookup(&lo, -1);
+	idr_for_each_entry(&loop_index_idr, lo, id) {
+		if (lo->lo_state == Lo_unbound)
+			goto found;
+	}
 	mutex_unlock(&loop_ctl_mutex);
-
-	if (ret >= 0)
-		return ret;
 	return loop_add(-1);
+found:
+	mutex_unlock(&loop_ctl_mutex);
+	return lo->lo_number;
 }
 
 static long loop_control_ioctl(struct file *file, unsigned int cmd,
-- 
2.30.2

