Return-Path: <SRS0=jnOf=6P=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC5DBC47253
	for <linux-block@archiver.kernel.org>; Fri,  1 May 2020 13:45:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B0D8C24956
	for <linux-block@archiver.kernel.org>; Fri,  1 May 2020 13:45:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731399AbgEANpP (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 1 May 2020 09:45:15 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:38531 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731541AbgEANpO (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 1 May 2020 09:45:14 -0400
Received: by mail-lf1-f67.google.com with SMTP id l11so3898611lfc.5;
        Fri, 01 May 2020 06:45:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=84T0pCv1NUHY99+EIUt2kRwIXnXQcTzPiOYLMrXMKNI=;
        b=uRd8skZcAgeL8fLulHY2Adc0M59m9MWJHiNj2jep4dlkDnmGVcXpA0r8BmEaYxt4EU
         DQyjapijaMBQZsh/bqKS+LmvEnZ8l5x+hkX2yjcYKeC/uRsWKSZRe6fPrGxzs+IOmcIl
         N0JIfdHus1VW+yxssKZn0UKHiJzG//fFNUJv+C9/ZK+3CA9yyzDHNxELX292WJd4KVG8
         LEePvZiC/xEzLMLY+K/pzZ5Mw3rwDeUP+PAAdWa7YiDff3va6Rd+T1wGLTe+laTzTeAe
         nvjEX10x7PxDpeSaR2TKOz9uuZ3SqBhWHhMCAdVsU4qgLh6/KET1YW7xk9Jvd+2Y0E6/
         N5EQ==
X-Gm-Message-State: AGi0PuZf+kcICSRUxTt7aJGpLMQTlRRm9owzZryy9MHfZABcVVz/houI
        EO3VLoZFCCLx0+BZfACndTFGPoKwFH4=
X-Google-Smtp-Source: APiQypI1EFhtVvq/oZA1yWy/XUHw1zB0+GFXJDQXQL3SsKS2vEbAEA1aHhauzMg8ygiv9o6vfRTvTA==
X-Received: by 2002:ac2:46f9:: with SMTP id q25mr2637273lfo.149.1588340710968;
        Fri, 01 May 2020 06:45:10 -0700 (PDT)
Received: from localhost.localdomain ([213.87.150.177])
        by smtp.googlemail.com with ESMTPSA id b2sm2269194lfi.14.2020.05.01.06.45.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 May 2020 06:45:10 -0700 (PDT)
From:   Denis Efremov <efremov@linux.com>
To:     linux-block@vger.kernel.org
Cc:     Denis Efremov <efremov@linux.com>, Willy Tarreau <w@1wt.eu>,
        Christoph Hellwig <hch@infradead.org>,
        Joe Perches <joe@perches.com>, linux-kernel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH v3 3/4] floppy: add defines for sizes of cmd & reply buffers of floppy_raw_cmd
Date:   Fri,  1 May 2020 16:44:15 +0300
Message-Id: <20200501134416.72248-4-efremov@linux.com>
X-Mailer: git-send-email 2.25.3
In-Reply-To: <20200501134416.72248-1-efremov@linux.com>
References: <20200501134416.72248-1-efremov@linux.com>
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

Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Denis Efremov <efremov@linux.com>
---
 drivers/block/floppy.c  | 19 +++++--------------
 include/uapi/linux/fd.h | 14 ++++++++++++--
 2 files changed, 17 insertions(+), 16 deletions(-)

diff --git a/drivers/block/floppy.c b/drivers/block/floppy.c
index b82b3d38b834..9e098d53b046 100644
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
@@ -1162,7 +1161,7 @@ static int result(int fdc)
 	int i;
 	int status = 0;
 
-	for (i = 0; i < MAX_REPLIES; i++) {
+	for (i = 0; i < FD_RAW_REPLY_SIZE; i++) {
 		status = wait_til_ready(fdc);
 		if (status < 0)
 			break;
@@ -3079,7 +3078,7 @@ static void raw_cmd_done(int flag)
 		raw_cmd->flags |= FD_RAW_HARDFAILURE;
 	} else {
 		raw_cmd->reply_count = inr;
-		if (raw_cmd->reply_count > MAX_REPLIES)
+		if (raw_cmd->reply_count > FD_RAW_REPLY_SIZE)
 			raw_cmd->reply_count = 0;
 		for (i = 0; i < raw_cmd->reply_count; i++)
 			raw_cmd->reply[i] = reply_buffer[i];
@@ -3190,18 +3189,10 @@ static int raw_cmd_copyin(int cmd, void __user *param,
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

