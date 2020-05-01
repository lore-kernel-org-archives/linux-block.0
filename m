Return-Path: <SRS0=jnOf=6P=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3DF8C47254
	for <linux-block@archiver.kernel.org>; Fri,  1 May 2020 13:46:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DB5C72495A
	for <linux-block@archiver.kernel.org>; Fri,  1 May 2020 13:46:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730350AbgEANqC (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 1 May 2020 09:46:02 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:34617 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731899AbgEANpQ (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 1 May 2020 09:45:16 -0400
Received: by mail-lj1-f196.google.com with SMTP id f11so2677317ljp.1;
        Fri, 01 May 2020 06:45:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=B1dBZygdOuEOVVgRDxzrxsbu/gYOSkCw10Yi3BStOb4=;
        b=nhF7S23Y/ZJo0T5XTS8G/hjloPB2T52myLZuRnIGr+uVidboPKqGYmLGRMYw3yTeX4
         D8MbshqU3fKZEFG3qXOuFzZcMeUbZWkQkwOhYAnS8Y6YTjTkRhFTIH8LsNCLf+djiI3C
         rXHo3jiJvCVPkk6TXbHgjCiK+5ZjlfEYeB8oRNjXXr9mz0i4487FxLcneML0ZkvIEgsH
         fPdy9V/37jDYvFPEXQeU5NFxyFh4kLl7RXRDYfoo+y7FFGLSN0kmF9sWlWdx1hubjVwQ
         m1j9RQHkHND1WsPaaCJIxMJVBaUBMYNivSl4KfmChn26+9Zmim48dxkwkQXLm+/UOpPr
         rxvQ==
X-Gm-Message-State: AGi0PubTuHdHGkr/U55JgAy0DSnQLP84qRm4AWyRSZ4pzttsw7sfYZuK
        uliy3LhSFmhf6s1cVJWA13X4Ars1zHg=
X-Google-Smtp-Source: APiQypInacq2l4k+DFDSlOyzVO50Ra94dXuWronVpuTuWv/pg1lpXsHb9rnMxjf94v3FqxocLu8ipQ==
X-Received: by 2002:a2e:731a:: with SMTP id o26mr2570638ljc.189.1588340714141;
        Fri, 01 May 2020 06:45:14 -0700 (PDT)
Received: from localhost.localdomain ([213.87.150.177])
        by smtp.googlemail.com with ESMTPSA id b2sm2269194lfi.14.2020.05.01.06.45.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 May 2020 06:45:13 -0700 (PDT)
From:   Denis Efremov <efremov@linux.com>
To:     linux-block@vger.kernel.org
Cc:     Denis Efremov <efremov@linux.com>, Willy Tarreau <w@1wt.eu>,
        Christoph Hellwig <hch@infradead.org>,
        Joe Perches <joe@perches.com>, linux-kernel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH v3 4/4] floppy: suppress UBSAN warning in setup_rw_floppy()
Date:   Fri,  1 May 2020 16:44:16 +0300
Message-Id: <20200501134416.72248-5-efremov@linux.com>
X-Mailer: git-send-email 2.25.3
In-Reply-To: <20200501134416.72248-1-efremov@linux.com>
References: <20200501134416.72248-1-efremov@linux.com>
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

Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Denis Efremov <efremov@linux.com>
---
 drivers/block/floppy.c  |  4 ++--
 include/uapi/linux/fd.h | 11 ++++++++---
 2 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/block/floppy.c b/drivers/block/floppy.c
index 9e098d53b046..064c1acb9f00 100644
--- a/drivers/block/floppy.c
+++ b/drivers/block/floppy.c
@@ -1070,7 +1070,7 @@ static void setup_DMA(void)
 	if (raw_cmd->length == 0) {
 		print_hex_dump(KERN_INFO, "zero dma transfer size: ",
 			       DUMP_PREFIX_NONE, 16, 1,
-			       raw_cmd->cmd, raw_cmd->cmd_count, false);
+			       raw_cmd->fullcmd, raw_cmd->cmd_count, false);
 		cont->done(0);
 		fdc_state[current_fdc].reset = 1;
 		return;
@@ -1515,7 +1515,7 @@ static void setup_rw_floppy(void)
 
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

