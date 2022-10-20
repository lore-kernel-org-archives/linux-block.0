Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E802C4332F
	for <linux-block@archiver.kernel.org>; Thu, 20 Oct 2022 06:48:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229619AbiJTGsg (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 20 Oct 2022 02:48:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbiJTGsf (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 20 Oct 2022 02:48:35 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8579C33354
        for <linux-block@vger.kernel.org>; Wed, 19 Oct 2022 23:48:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=ITBbU0uJ9voVaKSv48/OCKmiQMEJAfzAq8k6md54cx8=; b=bVDs+IT9SCFggqL03WKsBufcL3
        zBa/aflD/dIsmeIcbUG6hlC6dZgQE7RuyHD6zPD4zYZrLKyz7nJFoiWzG6dZPfvYOBt1iOqZZorGg
        10q8wEYXAeu/eisp8NFv5GKwA4plyZu9gVN29ngz0OFRm/MK6tOPUPWBnP4UVcPEIhanrOKRFwYZu
        moO/w1cZ2PJ6aGhxRH4Eb2u375d/HO6wBGS9tk+GpJ8hSS1saslvfWCwwd+NXZ1p6QyB781hs1mjH
        bCc5UYH1T7vEm8TPOdJA0IahJY/sxwR6IXEt13d7Qr6LUJxmH3EXdqcjIzz3DEjDKVmmOE3ExcVOI
        J2XDArvQ==;
Received: from [88.128.92.141] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1olPLy-00BJdr-Ic; Thu, 20 Oct 2022 06:48:30 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Jinlong Chen <nickyc975@zju.edu.cn>, linux-block@vger.kernel.org
Subject: [PATCH 2/4] block: sanitize the elevator name before passing it to __elevator_change
Date:   Thu, 20 Oct 2022 08:48:17 +0200
Message-Id: <20221020064819.1469928-3-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221020064819.1469928-1-hch@lst.de>
References: <20221020064819.1469928-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The stripped name should also be used for the none check.  To do so
strip it in the caller and pass in the sanitized name.  Drop the pointless
__ prefix in the function name while we're at it.

Based on a patch from Jinlong Chen <nickyc975@zju.edu.cn>.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/elevator.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/block/elevator.c b/block/elevator.c
index 40ba43aa9ece0..b7f098f735b6b 100644
--- a/block/elevator.c
+++ b/block/elevator.c
@@ -738,9 +738,8 @@ int elevator_switch(struct request_queue *q, struct elevator_type *new_e)
 /*
  * Switch this queue to the given IO scheduler.
  */
-static int __elevator_change(struct request_queue *q, const char *name)
+static int elevator_change(struct request_queue *q, const char *elevator_name)
 {
-	char elevator_name[ELV_NAME_MAX];
 	struct elevator_type *e;
 
 	/* Make sure queue is not in the middle of being removed */
@@ -750,14 +749,13 @@ static int __elevator_change(struct request_queue *q, const char *name)
 	/*
 	 * Special case for mq, turn off scheduling
 	 */
-	if (!strncmp(name, "none", 4)) {
+	if (!strncmp(elevator_name, "none", 4)) {
 		if (!q->elevator)
 			return 0;
 		return elevator_switch(q, NULL);
 	}
 
-	strlcpy(elevator_name, name, sizeof(elevator_name));
-	e = elevator_get(q, strstrip(elevator_name), true);
+	e = elevator_get(q, elevator_name, true);
 	if (!e)
 		return -EINVAL;
 
@@ -770,18 +768,19 @@ static int __elevator_change(struct request_queue *q, const char *name)
 	return elevator_switch(q, e);
 }
 
-ssize_t elv_iosched_store(struct request_queue *q, const char *name,
+ssize_t elv_iosched_store(struct request_queue *q, const char *buf,
 			  size_t count)
 {
+	char elevator_name[ELV_NAME_MAX];
 	int ret;
 
 	if (!elv_support_iosched(q))
 		return count;
 
-	ret = __elevator_change(q, name);
+	strlcpy(elevator_name, buf, sizeof(elevator_name));
+	ret = elevator_change(q, strstrip(elevator_name));
 	if (!ret)
 		return count;
-
 	return ret;
 }
 
-- 
2.30.2

