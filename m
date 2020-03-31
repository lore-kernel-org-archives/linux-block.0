Return-Path: <SRS0=+91Y=5Q=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8456C43331
	for <linux-block@archiver.kernel.org>; Tue, 31 Mar 2020 09:41:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 957BA208E0
	for <linux-block@archiver.kernel.org>; Tue, 31 Mar 2020 09:41:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730192AbgCaJl3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 31 Mar 2020 05:41:29 -0400
Received: from wtarreau.pck.nerim.net ([62.212.114.60]:34085 "EHLO 1wt.eu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730182AbgCaJl3 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 31 Mar 2020 05:41:29 -0400
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 02V9f4OA024509;
        Tue, 31 Mar 2020 11:41:04 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     Denis Efremov <efremov@linux.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, Willy Tarreau <w@1wt.eu>
Subject: [PATCH 02/23] floppy: add references to 82077's extra registers
Date:   Tue, 31 Mar 2020 11:40:33 +0200
Message-Id: <20200331094054.24441-3-w@1wt.eu>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <20200331094054.24441-1-w@1wt.eu>
References: <20200331094054.24441-1-w@1wt.eu>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This controller provides extra status registers SRA and SRB as well
as a tape drive register (TDR) and a data rate select register (DSR),
which are referenced in the sparc port, so let's have their symbolic
definitions centralized.

Signed-off-by: Willy Tarreau <w@1wt.eu>
---
 include/uapi/linux/fdreg.h | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/include/uapi/linux/fdreg.h b/include/uapi/linux/fdreg.h
index 1318881954e1..10d33632939d 100644
--- a/include/uapi/linux/fdreg.h
+++ b/include/uapi/linux/fdreg.h
@@ -7,13 +7,23 @@
  * Handbook", Sanches and Canton.
  */
 
+/* 82077's auxiliary status registers A & B (R) */
+#define FD_SRA		0
+#define FD_SRB		1
+
+/* Digital Output Register */
+#define FD_DOR		2
+
+/* 82077's tape drive register (R/W) */
+#define FD_TDR		3
+
+/* 82077's data rate select register (W) */
+#define FD_DSR		4
+
 /* Fd controller regs. S&C, about page 340 */
 #define FD_STATUS	4
 #define FD_DATA		5
 
-/* Digital Output Register */
-#define FD_DOR		2
-
 /* Digital Input Register (read) */
 #define FD_DIR		7
 
-- 
2.20.1

