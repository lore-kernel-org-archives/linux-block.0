Return-Path: <SRS0=zlmp=6K=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F48BC55194
	for <linux-block@archiver.kernel.org>; Sun, 26 Apr 2020 13:08:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 79D1D20700
	for <linux-block@archiver.kernel.org>; Sun, 26 Apr 2020 13:08:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725876AbgDZNIZ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 26 Apr 2020 09:08:25 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:35295 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726139AbgDZNIY (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 26 Apr 2020 09:08:24 -0400
Received: by mail-lj1-f193.google.com with SMTP id g4so14690234ljl.2;
        Sun, 26 Apr 2020 06:08:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KqhP1IZD0rJb6u6gP/e9HC5zJzCBcsPMyaLVpJZsqD4=;
        b=XjFqbMhTFw6I3hYRZYw6FS7AY8aYnqyv3bJ5EOqGvhlRJGDZqBpKdMmyyezBQ2ymXQ
         79ZlD43v7d0gZMcN2amZe89AFkFnYdAlFnMfiI2dvLdu/uJGr/CXyrXSS2OL/xzVWPBw
         Su3IDGEOqEL0ro4J2s4zvYjcGvgfYlWeNSO0VY8e51KsQvq/MYXknWn65SWIB/NEOf88
         YomfbrcO5JdFNf+tmtcXPSzydoEvkJeM2maVEAqZoADy2YSP7AMupbV1E4livSWUs0tZ
         OR2enSHgeqfX2pw1T6psACDbUL1qq/1GlNpQ1ge8Iutjb9Kbp9EA4D+4g4ffO7m0u0qb
         qEXA==
X-Gm-Message-State: AGi0PuZnLzwpY7UlfoYpZouSwetUYKX3fEgwrUMQC233oflPz3RGpLez
        1o8UIax5DzM5Vx+D1fPHjylBXBVkOHs=
X-Google-Smtp-Source: APiQypIvtjCdhzqmTqyRppstszegxNCVRgcToRc/Vivyyg1DLqbMx6EsxnfNe6CW7L0aif2WbYAQag==
X-Received: by 2002:a2e:2a82:: with SMTP id q124mr11975552ljq.155.1587906501607;
        Sun, 26 Apr 2020 06:08:21 -0700 (PDT)
Received: from localhost.localdomain ([213.87.147.211])
        by smtp.googlemail.com with ESMTPSA id l8sm7983371ljo.5.2020.04.26.06.08.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Apr 2020 06:08:21 -0700 (PDT)
From:   Denis Efremov <efremov@linux.com>
To:     linux-block@vger.kernel.org
Cc:     Denis Efremov <efremov@linux.com>, Willy Tarreau <w@1wt.eu>,
        Christoph Hellwig <hch@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/3] floppy: suppress UBSAN warning in setup_rw_floppy()
Date:   Sun, 26 Apr 2020 16:07:28 +0300
Message-Id: <20200426130728.63399-4-efremov@linux.com>
X-Mailer: git-send-email 2.25.3
In-Reply-To: <20200426130728.63399-1-efremov@linux.com>
References: <20200426130728.63399-1-efremov@linux.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

UBSAN: array-index-out-of-bounds in drivers/block/floppy.c:1521:45
index 16 is out of range for type 'unsigned char [16]'
Call Trace:
...
 setup_rw_floppy+0x5c3/0x7f0
 floppy_ready+0x2be/0x13b0
 process_one_work+0x2c1/0x5d0
 worker_thread+0x56/0x5e0
 kthread+0x122/0x170
 ret_from_fork+0x35/0x40

From include/uapi/linux/fd.h:
struct floppy_raw_cmd {
	...
	unsigned char cmd_count;
	unsigned char cmd[16];
	unsigned char reply_count;
	unsigned char reply[16];
	...
}

This out-of-bounds access is intentional. The command in struct
floppy_raw_cmd may take up the space initially intended for the reply
and the reply count. It is needed for long 82078 commands such as
RESTORE, which takes 17 command bytes. Initial cmd size is not enough
and since struct setup_rw_floppy is a part of uapi we check that
cmd_count is in [0:16+1+16] in raw_cmd_copyin().

The patch adds union with original cmd,reply_count,reply fields and
fullcmd field of equivalent size. The cmd accesses are turned to
fullcmd where appropriate to suppress UBSAN warning.

Signed-off-by: Denis Efremov <efremov@linux.com>
---
 drivers/block/floppy.c  |  4 ++--
 include/uapi/linux/fd.h | 11 ++++++++---
 2 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/block/floppy.c b/drivers/block/floppy.c
index 052ba457956e..1b22aab6cd9b 100644
--- a/drivers/block/floppy.c
+++ b/drivers/block/floppy.c
@@ -1072,7 +1072,7 @@ static void setup_DMA(void)
 
 		pr_info("zero dma transfer size:");
 		for (i = 0; i < raw_cmd->cmd_count; i++)
-			pr_cont("%x,", raw_cmd->cmd[i]);
+			pr_cont("%x,", raw_cmd->fullcmd[i]);
 		pr_cont("\n");
 		cont->done(0);
 		fdc_state[current_fdc].reset = 1;
@@ -1518,7 +1518,7 @@ static void setup_rw_floppy(void)
 
 	r = 0;
 	for (i = 0; i < raw_cmd->cmd_count; i++)
-		r |= output_byte(current_fdc, raw_cmd->cmd[i]);
+		r |= output_byte(current_fdc, raw_cmd->fullcmd[i]);
 
 	debugt(__func__, "rw_command");
 
diff --git a/include/uapi/linux/fd.h b/include/uapi/linux/fd.h
index 2e9c2c1c18e6..8b80c63b971c 100644
--- a/include/uapi/linux/fd.h
+++ b/include/uapi/linux/fd.h
@@ -371,9 +371,14 @@ struct floppy_raw_cmd {
 	 */
 
 	unsigned char cmd_count;
-	unsigned char cmd[FD_RAW_CMD_SIZE];
-	unsigned char reply_count;
-	unsigned char reply[FD_RAW_REPLY_SIZE];
+	union {
+		struct {
+			unsigned char cmd[FD_RAW_CMD_SIZE];
+			unsigned char reply_count;
+			unsigned char reply[FD_RAW_REPLY_SIZE];
+		};
+		unsigned char fullcmd[FD_RAW_CMD_FULLSIZE];
+	};
 	int track;
 	int resultcode;
 
-- 
2.25.3

