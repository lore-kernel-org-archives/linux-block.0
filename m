Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21155C43334
	for <linux-block@archiver.kernel.org>; Thu, 23 Jun 2022 19:01:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232020AbiFWTBU (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 23 Jun 2022 15:01:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229593AbiFWTBI (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 23 Jun 2022 15:01:08 -0400
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D1D210E65F
        for <linux-block@vger.kernel.org>; Thu, 23 Jun 2022 11:06:24 -0700 (PDT)
Received: by mail-pf1-f180.google.com with SMTP id 128so278471pfv.12
        for <linux-block@vger.kernel.org>; Thu, 23 Jun 2022 11:06:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8ec/YeJokhE0PwfOH5Ta6a/JptpB65lHBo+E6SkP32s=;
        b=b64K6PFlFS+oXWmE63k0LvUCpAtDuCQjHqFNHQVCJJshqgINqv55DTUHLOy4jb061b
         R0FfBKaGNaCrB2Y9qGipHY0dWqudi75+hywq6vrnHZFI8TuP2tyTUaLAwDBCzujjZrwx
         ZyxiOtmW8xQhbJ4I2FFM6E68KXw3D0uxawoRoaqgZNzaCcsUbDUmS6gO7zmRZK9OfxWZ
         y8M+hpTJv6PI5H5q5EevGEDGlAOR8B/8Gv9SVx6yAPhifTfi0XhqVKZdtKP4FHU9muRD
         k2WN2ZsmecF+BYW8TE5c0kDAAreqNU3SkxxR1/Byrx5GM8q4fNthwZ5837XzmIvBH1sY
         k2OQ==
X-Gm-Message-State: AJIora9z0EP6ngAUF/atTi+Ap7OLDxmuCbBpb4BBVjrKxepd2ZTEAXdY
        ugARyhmqNzK42LDcfi2yh4o=
X-Google-Smtp-Source: AGRyM1v8K5h7oPzlU4UvhBPQBbUG8gSEmXSXciDXi7/8VHEtjhgEpLPrFOCHL61I6KBkOubhHkV77Q==
X-Received: by 2002:a63:fc63:0:b0:405:34ac:920d with SMTP id r35-20020a63fc63000000b0040534ac920dmr8709424pgk.40.1656007583384;
        Thu, 23 Jun 2022 11:06:23 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:70af:1dc5:d20:a563])
        by smtp.gmail.com with ESMTPSA id a18-20020a056a000c9200b0051c4ecb0e3dsm16019967pfv.193.2022.06.23.11.06.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jun 2022 11:06:22 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        John Garry <john.garry@huawei.com>,
        Mike Christie <michael.christie@oracle.com>
Subject: [PATCH 31/51] scsi/core: Use the new blk_opf_t type
Date:   Thu, 23 Jun 2022 11:05:08 -0700
Message-Id: <20220623180528.3595304-32-bvanassche@acm.org>
X-Mailer: git-send-email 2.37.0.rc0.161.g10f37bed90-goog
In-Reply-To: <20220623180528.3595304-1-bvanassche@acm.org>
References: <20220623180528.3595304-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Use the new blk_opf_t type for arguments and variables that represent
request flags. Use the !! operator in scsi_noretry_cmd() to convert the
blk_opf_t type into a boolean. This patch does not change any functionality.

Cc: Martin K. Petersen <martin.petersen@oracle.com>
Cc: John Garry <john.garry@huawei.com>
Cc: Mike Christie <michael.christie@oracle.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/scsi/scsi_error.c  | 6 +++---
 drivers/scsi/scsi_lib.c    | 6 +++---
 include/scsi/scsi_device.h | 2 +-
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/scsi/scsi_error.c b/drivers/scsi/scsi_error.c
index 60bcb37acafd..4b8686162ddd 100644
--- a/drivers/scsi/scsi_error.c
+++ b/drivers/scsi/scsi_error.c
@@ -1789,15 +1789,15 @@ bool scsi_noretry_cmd(struct scsi_cmnd *scmd)
 	case DID_TIME_OUT:
 		goto check_type;
 	case DID_BUS_BUSY:
-		return req->cmd_flags & REQ_FAILFAST_TRANSPORT;
+		return !!(req->cmd_flags & REQ_FAILFAST_TRANSPORT);
 	case DID_PARITY:
-		return req->cmd_flags & REQ_FAILFAST_DEV;
+		return !!(req->cmd_flags & REQ_FAILFAST_DEV);
 	case DID_ERROR:
 		if (get_status_byte(scmd) == SAM_STAT_RESERVATION_CONFLICT)
 			return false;
 		fallthrough;
 	case DID_SOFT_ERROR:
-		return req->cmd_flags & REQ_FAILFAST_DRIVER;
+		return !!(req->cmd_flags & REQ_FAILFAST_DRIVER);
 	}
 
 	if (!scsi_status_is_check_condition(scmd->result))
diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
index 6b6a7a4b0950..beff0015258a 100644
--- a/drivers/scsi/scsi_lib.c
+++ b/drivers/scsi/scsi_lib.c
@@ -209,8 +209,8 @@ void scsi_queue_insert(struct scsi_cmnd *cmd, int reason)
 int __scsi_execute(struct scsi_device *sdev, const unsigned char *cmd,
 		 int data_direction, void *buffer, unsigned bufflen,
 		 unsigned char *sense, struct scsi_sense_hdr *sshdr,
-		 int timeout, int retries, u64 flags, req_flags_t rq_flags,
-		 int *resid)
+		 int timeout, int retries, blk_opf_t flags,
+		 req_flags_t rq_flags, int *resid)
 {
 	struct request *req;
 	struct scsi_cmnd *scmd;
@@ -633,7 +633,7 @@ static blk_status_t scsi_result_to_blk_status(struct scsi_cmnd *cmd, int result)
  */
 static unsigned int scsi_rq_err_bytes(const struct request *rq)
 {
-	unsigned int ff = rq->cmd_flags & REQ_FAILFAST_MASK;
+	blk_opf_t ff = rq->cmd_flags & REQ_FAILFAST_MASK;
 	unsigned int bytes = 0;
 	struct bio *bio;
 
diff --git a/include/scsi/scsi_device.h b/include/scsi/scsi_device.h
index 7cf5f3b7589f..2493bd65351a 100644
--- a/include/scsi/scsi_device.h
+++ b/include/scsi/scsi_device.h
@@ -457,7 +457,7 @@ extern void scsi_sanitize_inquiry_string(unsigned char *s, int len);
 extern int __scsi_execute(struct scsi_device *sdev, const unsigned char *cmd,
 			int data_direction, void *buffer, unsigned bufflen,
 			unsigned char *sense, struct scsi_sense_hdr *sshdr,
-			int timeout, int retries, u64 flags,
+			int timeout, int retries, blk_opf_t flags,
 			req_flags_t rq_flags, int *resid);
 /* Make sure any sense buffer is the correct size. */
 #define scsi_execute(sdev, cmd, data_direction, buffer, bufflen, sense,	\
