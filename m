Return-Path: <SRS0=zlmp=6K=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D2E0C55194
	for <linux-block@archiver.kernel.org>; Sun, 26 Apr 2020 13:08:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 549B12078E
	for <linux-block@archiver.kernel.org>; Sun, 26 Apr 2020 13:08:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726204AbgDZNIX (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 26 Apr 2020 09:08:23 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:38541 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725876AbgDZNIX (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 26 Apr 2020 09:08:23 -0400
Received: by mail-lf1-f68.google.com with SMTP id l11so11507701lfc.5;
        Sun, 26 Apr 2020 06:08:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CF3KyLIy2CcCqiBV6fft8p9lx2gIpZejdD8aG2l37ro=;
        b=AvTjr4M2bFz21JDBLfwRon3nrdYr+TZTLUtPjrSPV9IU0shbGGIDtPUbjIj9UGgNcz
         PFzFNR96Jq+bc455k2QA4xDlG2c0S9HgWiiNGeD6nSFbba1+iccnAS09iUZQzEi3U9cG
         I3ykygZPHiDyomEkEorw9CnZezVxR+MUBrjchv0nPRZXxPZ51/LLHqx8ujng/qICyU1M
         SbuzWVgrSv1gEjljzBB5R4h4TyyBDPnu2r+eflqPOdDvYCShKYtl3E5wb3uHC1H6AAiK
         7a2ezmvl7kI4x1L6ppPbD1VDQck9aBieNFdp1fmLudMeWVXDPTKPwxaC+v3x6fg1p+9w
         Z4Cg==
X-Gm-Message-State: AGi0PuZlvlhhJ97r0CTHZSYF1FVi43d767HkdrZbVZL7qmYMkAkM1lBL
        B+0Bpb/nFKfu1DDyJ2/cMJyljXWw8/8=
X-Google-Smtp-Source: APiQypKWNjm/xKK3C2eldFQ4dq8rpfu1ZFh2p59OPa3olR+/b1zPyeYu/FJW5k0jYCan/Fq1qbCOiw==
X-Received: by 2002:ac2:420c:: with SMTP id y12mr12410585lfh.26.1587906498806;
        Sun, 26 Apr 2020 06:08:18 -0700 (PDT)
Received: from localhost.localdomain ([213.87.147.211])
        by smtp.googlemail.com with ESMTPSA id l8sm7983371ljo.5.2020.04.26.06.08.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Apr 2020 06:08:18 -0700 (PDT)
From:   Denis Efremov <efremov@linux.com>
To:     linux-block@vger.kernel.org
Cc:     Denis Efremov <efremov@linux.com>, Willy Tarreau <w@1wt.eu>,
        Christoph Hellwig <hch@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/3] floppy: add defines for sizes of cmd & reply buffers of floppy_raw_cmd
Date:   Sun, 26 Apr 2020 16:07:27 +0300
Message-Id: <20200426130728.63399-3-efremov@linux.com>
X-Mailer: git-send-email 2.25.3
In-Reply-To: <20200426130728.63399-1-efremov@linux.com>
References: <20200426130728.63399-1-efremov@linux.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Use FD_RAW_CMD_SIZE, FD_RAW_REPLY_SIZE defines instead of magic numbers
for cmd & reply buffers of struct floppy_raw_cmd. Remove local to
floppy.c MAX_REPLIES define, as it is now FD_RAW_REPLY_SIZE.
FD_RAW_CMD_FULLSIZE added as we allow command to also fill reply_count
and reply fields.

Signed-off-by: Denis Efremov <efremov@linux.com>
---
 drivers/block/floppy.c  | 21 ++++++---------------
 include/uapi/linux/fd.h | 14 ++++++++++++--
 2 files changed, 18 insertions(+), 17 deletions(-)

diff --git a/drivers/block/floppy.c b/drivers/block/floppy.c
index ac2023c757e3..052ba457956e 100644
--- a/drivers/block/floppy.c
+++ b/drivers/block/floppy.c
@@ -337,8 +337,7 @@ static bool initialized;
 /*
  * globals used by 'result()'
  */
-#define MAX_REPLIES 16
-static unsigned char reply_buffer[MAX_REPLIES];
+static unsigned char reply_buffer[FD_RAW_REPLY_SIZE];
 static int inr;		/* size of reply buffer, when called from interrupt */
 #define ST0		0
 #define ST1		1
@@ -1165,7 +1164,7 @@ static int result(int fdc)
 	int i;
 	int status = 0;
 
-	for (i = 0; i < MAX_REPLIES; i++) {
+	for (i = 0; i < FD_RAW_REPLY_SIZE; i++) {
 		status = wait_til_ready(fdc);
 		if (status < 0)
 			break;
@@ -1847,7 +1846,7 @@ static void show_floppy(int fdc)
 			output_log[(i + output_log_pos) % OLOGSIZE].jiffies);
 	pr_info("last result at %lu\n", resultjiffies);
 	pr_info("last redo_fd_request at %lu\n", lastredo);
-	print_hex_dump(KERN_INFO, "", DUMP_PREFIX_NONE, 16, 1,
+	print_hex_dump(KERN_INFO, "", DUMP_PREFIX_NONE, FD_RAW_REPLY_SIZE, 1,
 		       reply_buffer, resultsize, true);
 
 	pr_info("status=%x\n", fdc_inb(fdc, FD_STATUS));
@@ -3082,7 +3081,7 @@ static void raw_cmd_done(int flag)
 		raw_cmd->flags |= FD_RAW_HARDFAILURE;
 	} else {
 		raw_cmd->reply_count = inr;
-		if (raw_cmd->reply_count > MAX_REPLIES)
+		if (raw_cmd->reply_count > FD_RAW_REPLY_SIZE)
 			raw_cmd->reply_count = 0;
 		for (i = 0; i < raw_cmd->reply_count; i++)
 			raw_cmd->reply[i] = reply_buffer[i];
@@ -3193,18 +3192,10 @@ static int raw_cmd_copyin(int cmd, void __user *param,
 	if (ret)
 		return -EFAULT;
 	param += sizeof(struct floppy_raw_cmd);
-	if (ptr->cmd_count > 33)
-			/* the command may now also take up the space
-			 * initially intended for the reply & the
-			 * reply count. Needed for long 82078 commands
-			 * such as RESTORE, which takes ... 17 command
-			 * bytes. Murphy's law #137: When you reserve
-			 * 16 bytes for a structure, you'll one day
-			 * discover that you really need 17...
-			 */
+	if (ptr->cmd_count > FD_RAW_CMD_FULLSIZE)
 		return -EINVAL;
 
-	for (i = 0; i < 16; i++)
+	for (i = 0; i < FD_RAW_REPLY_SIZE; i++)
 		ptr->reply[i] = 0;
 	ptr->resultcode = 0;
 
diff --git a/include/uapi/linux/fd.h b/include/uapi/linux/fd.h
index 3f6b7be4c096..2e9c2c1c18e6 100644
--- a/include/uapi/linux/fd.h
+++ b/include/uapi/linux/fd.h
@@ -360,10 +360,20 @@ struct floppy_raw_cmd {
 	int buffer_length; /* length of allocated buffer */
 
 	unsigned char rate;
+
+#define FD_RAW_CMD_SIZE 16
+#define FD_RAW_REPLY_SIZE 16
+#define FD_RAW_CMD_FULLSIZE (FD_RAW_CMD_SIZE + 1 + FD_RAW_REPLY_SIZE)
+
+	/* The command may take up the space initially intended for the reply
+	 * and the reply count. Needed for long 82078 commands such as RESTORE,
+	 * which takes 17 command bytes.
+	 */
+
 	unsigned char cmd_count;
-	unsigned char cmd[16];
+	unsigned char cmd[FD_RAW_CMD_SIZE];
 	unsigned char reply_count;
-	unsigned char reply[16];
+	unsigned char reply[FD_RAW_REPLY_SIZE];
 	int track;
 	int resultcode;
 
-- 
2.25.3

