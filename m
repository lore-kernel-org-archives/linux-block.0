Return-Path: <SRS0=KmMx=6F=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44F02C55183
	for <linux-block@archiver.kernel.org>; Tue, 21 Apr 2020 12:58:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2B0042076C
	for <linux-block@archiver.kernel.org>; Tue, 21 Apr 2020 12:58:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728859AbgDUM6I (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 21 Apr 2020 08:58:08 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:44938 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726628AbgDUM6D (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 21 Apr 2020 08:58:03 -0400
Received: by mail-lj1-f196.google.com with SMTP id z26so13846269ljz.11;
        Tue, 21 Apr 2020 05:58:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0YlyCHUw312AmrzNw/IzEmeQ9OEPagxd5nkgVOWuL18=;
        b=oXL8gbvnut/7Feu4e7WVrga6hq+yJIpbapTIV468cy8dZo5CzBzzFngyxOyiRAgRCX
         eatJXii+IrkMGuSstC/k66JXY6yqsfk2CVnJ+95J4VKWXV9Zjv2rtVfyEt0gZoanT0bP
         N38/OW1L1LBXvqdo05iP6x9jcccEYPeFurEL1KmJT9WnSlwAy2xvVQ39Ifgan7Esk1+q
         04Z9igiwF9AWIPCIxH8ksTDPrQRfC8pKD5A0+9FgSoxKjvGfPtb6SjDu/o2k4AQ68f4w
         YpaH8tDn7AWHB6iN131Nr+97neJFVmvmrApoFdhorr2XkIfJ4p4vbquyYLWEvBTiHAW+
         Rp3Q==
X-Gm-Message-State: AGi0PuYkwbLhtF+K95OYPx/H8Rq4R0XaFUjQ402qZ1/19s8iLTD/bQTp
        L3rji+XH7agfZyYkETyuBvh4ljMOJGU=
X-Google-Smtp-Source: APiQypJTJzry8tRlksS0vJtcksH/Oki9gtXjnrTVHYsyPf2kz0qZgzLss6mvDTfpeIlG3bf/FNjDhQ==
X-Received: by 2002:a05:651c:1203:: with SMTP id i3mr1308011lja.181.1587473880617;
        Tue, 21 Apr 2020 05:58:00 -0700 (PDT)
Received: from localhost.localdomain ([213.87.162.215])
        by smtp.googlemail.com with ESMTPSA id z7sm1902268ljc.17.2020.04.21.05.57.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2020 05:58:00 -0700 (PDT)
From:   Denis Efremov <efremov@linux.com>
To:     linux-block@vger.kernel.org
Cc:     Denis Efremov <efremov@linux.com>, Willy Tarreau <w@1wt.eu>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] floppy: add defines for sizes of cmd & reply buffers of floppy_raw_cmd
Date:   Tue, 21 Apr 2020 15:57:21 +0300
Message-Id: <20200421125722.58959-3-efremov@linux.com>
X-Mailer: git-send-email 2.25.3
In-Reply-To: <20200421125722.58959-1-efremov@linux.com>
References: <20200421125722.58959-1-efremov@linux.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Use FD_RAW_CMD_SIZE, FD_RAW_REPLY_SIZE defines instead of magic numbers
for cmd & reply buffers of struct floppy_raw_cmd. Remove local to
floppy.c MAX_REPLIES define, as it is now FD_RAW_REPLY_SIZE.

Signed-off-by: Denis Efremov <efremov@linux.com>
---
 drivers/block/floppy.c  | 15 ++++++++-------
 include/uapi/linux/fd.h |  8 ++++++--
 2 files changed, 14 insertions(+), 9 deletions(-)

diff --git a/drivers/block/floppy.c b/drivers/block/floppy.c
index ac2023c757e3..2169df796d18 100644
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
@@ -3193,7 +3192,9 @@ static int raw_cmd_copyin(int cmd, void __user *param,
 	if (ret)
 		return -EFAULT;
 	param += sizeof(struct floppy_raw_cmd);
-	if (ptr->cmd_count > 33)
+	if (ptr->cmd_count > FD_RAW_CMD_SIZE +
+			     sizeof_field(struct floppy_raw_cmd, reply_count) +
+			     FD_RAW_REPLY_SIZE)
 			/* the command may now also take up the space
 			 * initially intended for the reply & the
 			 * reply count. Needed for long 82078 commands
@@ -3204,7 +3205,7 @@ static int raw_cmd_copyin(int cmd, void __user *param,
 			 */
 		return -EINVAL;
 
-	for (i = 0; i < 16; i++)
+	for (i = 0; i < FD_RAW_REPLY_SIZE; i++)
 		ptr->reply[i] = 0;
 	ptr->resultcode = 0;
 
diff --git a/include/uapi/linux/fd.h b/include/uapi/linux/fd.h
index f5cb0aa8cebc..d3961b52cb9a 100644
--- a/include/uapi/linux/fd.h
+++ b/include/uapi/linux/fd.h
@@ -360,10 +360,14 @@ struct floppy_raw_cmd {
 	int buffer_length; /* length of allocated buffer */
 
 	unsigned char rate;
+
+#define FD_RAW_CMD_SIZE 16
+#define FD_RAW_REPLY_SIZE 16
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

