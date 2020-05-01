Return-Path: <SRS0=jnOf=6P=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38A5FC47258
	for <linux-block@archiver.kernel.org>; Fri,  1 May 2020 13:47:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 17DAA2051A
	for <linux-block@archiver.kernel.org>; Fri,  1 May 2020 13:47:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731086AbgEANrK (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 1 May 2020 09:47:10 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:38526 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730317AbgEANpK (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 1 May 2020 09:45:10 -0400
Received: by mail-lf1-f68.google.com with SMTP id l11so3898488lfc.5;
        Fri, 01 May 2020 06:45:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UjJIbG5PhVX5vmhqPNitT7lQ30lLq2zeuGUdDd0kBno=;
        b=ii/dZOXMNrZNV8QMGycWL5eYUUGhoDWQyGJfFF+Md4PHlDjqs9IoKTxeBSoxv1OB3D
         M/rWnP2+RWC/UswRA8h6ETXtWD77Ez3yy3j4GaslGVAaFof3LTG11tSvnIpJdoyjGdeS
         JoX0rFuw/F8/WOSXqAjolvu7g2cYU5hyW2V2j2N76LQqv+6DwDqnUsTJLqoDP+e3q8Iw
         FHMMwr/AhAZLQCjj8ZtRs9NfC+Vw5laAUxUngoTUFfO5VrtzGTO9joaryPpJx6Coxqa7
         CmyqiywphXgIoqK/CZM9ljSaYGXvjRqQLFpmO8Jc2F7DQX6cntrkjZjkeza48Fy7Uhju
         2mMg==
X-Gm-Message-State: AGi0PubXipHgTwZZ/C/nmzYIRCK3vPp9qHKgsJVbz3YR3Tom2n4qurVG
        iyJecKwZ9vTgM4u/vgTrVDtc1W+LdaU=
X-Google-Smtp-Source: APiQypLpRwyPk/YLnGS6RZt+lZLtIcEoigTyTI4Fv+U69ZYu+k+Kk5S8LgwaIbSQAROqdGz0bj8YNQ==
X-Received: by 2002:a19:42c3:: with SMTP id p186mr2590791lfa.194.1588340707226;
        Fri, 01 May 2020 06:45:07 -0700 (PDT)
Received: from localhost.localdomain ([213.87.150.177])
        by smtp.googlemail.com with ESMTPSA id b2sm2269194lfi.14.2020.05.01.06.45.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 May 2020 06:45:06 -0700 (PDT)
From:   Denis Efremov <efremov@linux.com>
To:     linux-block@vger.kernel.org
Cc:     Denis Efremov <efremov@linux.com>, Willy Tarreau <w@1wt.eu>,
        Christoph Hellwig <hch@infradead.org>,
        Joe Perches <joe@perches.com>, linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/4] floppy: add FD_AUTODETECT_SIZE define for struct floppy_drive_params
Date:   Fri,  1 May 2020 16:44:14 +0300
Message-Id: <20200501134416.72248-3-efremov@linux.com>
X-Mailer: git-send-email 2.25.3
In-Reply-To: <20200501134416.72248-1-efremov@linux.com>
References: <20200501134416.72248-1-efremov@linux.com>
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
index 3ab6e804b5ec..b82b3d38b834 100644
--- a/drivers/block/floppy.c
+++ b/drivers/block/floppy.c
@@ -2073,7 +2073,8 @@ static int next_valid_format(int drive)
 
 	probed_format = drive_state[drive].probed_format;
 	while (1) {
-		if (probed_format >= 8 || !drive_params[drive].autodetect[probed_format]) {
+		if (probed_format >= FD_AUTODETECT_SIZE ||
+		    !drive_params[drive].autodetect[probed_format]) {
 			drive_state[drive].probed_format = 0;
 			return 1;
 		}
@@ -3442,13 +3443,13 @@ static int fd_getgeo(struct block_device *bdev, struct hd_geometry *geo)
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
@@ -3673,7 +3674,7 @@ struct compat_floppy_drive_params {
 	struct floppy_max_errors max_errors;
 	char		flags;
 	char		read_track;
-	short		autodetect[8];
+	short		autodetect[FD_AUTODETECT_SIZE];
 	compat_int_t	checkfreq;
 	compat_int_t	native_format;
 };
diff --git a/include/uapi/linux/fd.h b/include/uapi/linux/fd.h
index 90fb94712c41..3f6b7be4c096 100644
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
+	short autodetect[FD_AUTODETECT_SIZE]; /* autodetected formats */
 	
 	int checkfreq; /* how often should the drive be checked for disk 
 			* changes */
-- 
2.25.3

