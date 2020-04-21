Return-Path: <SRS0=KmMx=6F=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18559C54FC9
	for <linux-block@archiver.kernel.org>; Tue, 21 Apr 2020 12:58:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F3FA92078C
	for <linux-block@archiver.kernel.org>; Tue, 21 Apr 2020 12:58:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728737AbgDUM6B (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 21 Apr 2020 08:58:01 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:39037 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726628AbgDUM6A (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 21 Apr 2020 08:58:00 -0400
Received: by mail-lj1-f193.google.com with SMTP id u6so13877273ljl.6;
        Tue, 21 Apr 2020 05:57:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EfnTedNe2IUpWuf+EJLADm5FOOxOv1WkovWVN+XtvOM=;
        b=AfnPk8bmCVXfbdt2Y41Zj1HmQQEebqhMn9XTIAZMPBsYEueK3ioFuSxVZiP68r7vKW
         4nl1h6fvLbK1R1+W9izqzENkYzbmm5mNw/QaX3OsJPAilG30kOTLbkYfGGRuZJav3M0T
         sQL2qUwuQgubioHFGLu2ZLz06EfBB3ROItjAlFl0Mgo1wmO52v1f7qM9Q5lZVB63u1wZ
         dRSw9KknPPGyjOmhCNM1k1M3WnZ5jLBOGtM8SNr/yPdVn82u6ZIT/UELfy/fzo7Xe12/
         y8XKFmpwIHNs5ummN4mbsB8L4ZVFvL+mwzdb7knlY9kb/k5hhe3BFAeW5reTh5zINyIq
         yYDQ==
X-Gm-Message-State: AGi0PuaO9K7o+1X8fb7miTGx8KoQzrOSBWHHZtQF/M6kRkwqmONmQWfg
        Db5F5E0jXixZOH5VuoO4Jav73JfwD0A=
X-Google-Smtp-Source: APiQypLeqH7AwrWoKi7mTMHXUx89vGDHJnaEr11yeF1ENryD4RV3FfN9wP7S7+gcwcYISExQMrNcLQ==
X-Received: by 2002:a2e:b00a:: with SMTP id y10mr12371417ljk.158.1587473877635;
        Tue, 21 Apr 2020 05:57:57 -0700 (PDT)
Received: from localhost.localdomain ([213.87.162.215])
        by smtp.googlemail.com with ESMTPSA id z7sm1902268ljc.17.2020.04.21.05.57.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2020 05:57:57 -0700 (PDT)
From:   Denis Efremov <efremov@linux.com>
To:     linux-block@vger.kernel.org
Cc:     Denis Efremov <efremov@linux.com>, Willy Tarreau <w@1wt.eu>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] floppy: add FD_AUTODETECT_SIZE define for struct floppy_drive_params
Date:   Tue, 21 Apr 2020 15:57:20 +0300
Message-Id: <20200421125722.58959-2-efremov@linux.com>
X-Mailer: git-send-email 2.25.3
In-Reply-To: <20200421125722.58959-1-efremov@linux.com>
References: <20200421125722.58959-1-efremov@linux.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Use FD_AUTODETECT_SIZE for autodetect buffer size in struct
floppy_drive_params instead of a magic number.

Signed-off-by: Denis Efremov <efremov@linux.com>
---
 drivers/block/floppy.c  | 9 +++++----
 include/uapi/linux/fd.h | 5 ++++-
 2 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/block/floppy.c b/drivers/block/floppy.c
index 2817170dd403..ac2023c757e3 100644
--- a/drivers/block/floppy.c
+++ b/drivers/block/floppy.c
@@ -2076,7 +2076,8 @@ static int next_valid_format(int drive)
 
 	probed_format = drive_state[drive].probed_format;
 	while (1) {
-		if (probed_format >= 8 || !drive_params[drive].autodetect[probed_format]) {
+		if (probed_format >= FD_AUTODETECT_SIZE ||
+			!drive_params[drive].autodetect[probed_format]) {
 			drive_state[drive].probed_format = 0;
 			return 1;
 		}
@@ -3445,13 +3446,13 @@ static int fd_getgeo(struct block_device *bdev, struct hd_geometry *geo)
 	return 0;
 }
 
-static bool valid_floppy_drive_params(const short autodetect[8],
+static bool valid_floppy_drive_params(const short autodetect[FD_AUTODETECT_SIZE],
 		int native_format)
 {
 	size_t floppy_type_size = ARRAY_SIZE(floppy_type);
 	size_t i = 0;
 
-	for (i = 0; i < 8; ++i) {
+	for (i = 0; i < FD_AUTODETECT_SIZE; ++i) {
 		if (autodetect[i] < 0 ||
 		    autodetect[i] >= floppy_type_size)
 			return false;
@@ -3676,7 +3677,7 @@ struct compat_floppy_drive_params {
 	struct floppy_max_errors max_errors;
 	char		flags;
 	char		read_track;
-	short		autodetect[8];
+	short		autodetect[FD_AUTODETECT_SIZE];
 	compat_int_t	checkfreq;
 	compat_int_t	native_format;
 };
diff --git a/include/uapi/linux/fd.h b/include/uapi/linux/fd.h
index 90fb94712c41..f5cb0aa8cebc 100644
--- a/include/uapi/linux/fd.h
+++ b/include/uapi/linux/fd.h
@@ -172,7 +172,10 @@ struct floppy_drive_params {
  * used in succession to try to read the disk. If the FDC cannot lock onto
  * the disk, the next format is tried. This uses the variable 'probing'.
  */
-	short autodetect[8];		/* autodetected formats */
+
+#define FD_AUTODETECT_SIZE 8
+
+	short autodetect[FD_AUTODETECT_SIZE];		/* autodetected formats */
 	
 	int checkfreq; /* how often should the drive be checked for disk 
 			* changes */
-- 
2.25.3

