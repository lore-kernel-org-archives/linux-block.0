Return-Path: <SRS0=31JE=UY=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9629EC48BD5
	for <linux-block@archiver.kernel.org>; Tue, 25 Jun 2019 11:47:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6183C213F2
	for <linux-block@archiver.kernel.org>; Tue, 25 Jun 2019 11:47:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726996AbfFYLrl (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 25 Jun 2019 07:47:41 -0400
Received: from mailout2n.rrzn.uni-hannover.de ([130.75.2.113]:56312 "EHLO
        mailout2n.rrzn.uni-hannover.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728527AbfFYLrl (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 25 Jun 2019 07:47:41 -0400
X-Greylist: delayed 309 seconds by postgrey-1.27 at vger.kernel.org; Tue, 25 Jun 2019 07:47:40 EDT
Received: from lab-pc01.sra.uni-hannover.de (lab.sra.uni-hannover.de [130.75.33.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mailout2n.rrzn.uni-hannover.de (Postfix) with ESMTPSA id 267C51F3F6;
        Tue, 25 Jun 2019 13:42:30 +0200 (CEST)
From:   Florian Knauf <florian.knauf@stud.uni-hannover.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-kernel@i4.cs.fau.de, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Florian Knauf <florian.knauf@stud.uni-hannover.de>,
        Christian Ewert <christian.ewert@stud.uni-hannover.de>
Subject: [PATCH] drivers/block/loop: Remove deprecated function, range check for max_loop
Date:   Tue, 25 Jun 2019 13:40:56 +0200
Message-Id: <20190625114056.8706-1-florian.knauf@stud.uni-hannover.de>
X-Mailer: git-send-email 2.17.1
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This patch removes the deprecated simple_strtol function from the option
parsing logic in the loopback device driver. It also introduces a range
check for the max_loop parameter to ensure that negative and out-of-range
values (that cannot be represented by int max_loop) are ignored.

Signed-off-by: Florian Knauf <florian.knauf@stud.uni-hannover.de>
Signed-off-by: Christian Ewert <christian.ewert@stud.uni-hannover.de>
---
 drivers/block/loop.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 102d79575895..acdd028ed486 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -2289,7 +2289,17 @@ module_exit(loop_exit);
 #ifndef MODULE
 static int __init max_loop_setup(char *str)
 {
-	max_loop = simple_strtol(str, NULL, 0);
+	long max_loop_long = 0;
+
+	/*
+	 * Range check for max_loop: negative values and values not
+	 * representable by int are ignored.
+	 */
+	if (kstrtol(str, 0, &max_loop_long) == 0 &&
+			max_loop_long >= 0 &&
+			max_loop_long <= INT_MAX)
+		max_loop = (int) max_loop_long;
+
 	return 1;
 }
 
-- 
2.17.1

