Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DACB3C43334
	for <linux-block@archiver.kernel.org>; Wed, 29 Jun 2022 23:33:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231779AbiF2XdG (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 29 Jun 2022 19:33:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231800AbiF2XdD (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 29 Jun 2022 19:33:03 -0400
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9884A255B9
        for <linux-block@vger.kernel.org>; Wed, 29 Jun 2022 16:32:57 -0700 (PDT)
Received: by mail-pf1-f174.google.com with SMTP id k9so7271683pfg.5
        for <linux-block@vger.kernel.org>; Wed, 29 Jun 2022 16:32:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bHWrXyMgtSdwe8y23mL3dy52/qxSY7cvJTW/Y2OQngQ=;
        b=Lz6Op7frpJ9I5ZPtzIWy/mRYI8e1FAke7nDQyqJzzyEC4NqDxadDReWbiVok//baFf
         Le4btdcwvWocR8+yv4OWOguXBzaBMBglSdi5xRfVeh/b80M9w9go5qBnejuDDBH3JKQ0
         UNlMzo1VRBlA4WjTCddp3TFOhi8A7x1Fj8EpBgV2vrrYBq9nOUzoAJy5xhqVLSCJlYZb
         I+1EzFYUTX/UAsMQ7dsSiTZniotwPiMlPiQqAG8+YQ+iES0EnUcXro0XMu0zdH6msAg3
         dxihgxattfhaE9uPvvHtbwODBhUARuvSUMKRqI1QnUB+Wcv8S6dqY3z32VDKfJEfYCWf
         H7eQ==
X-Gm-Message-State: AJIora9ocDYWVINL72TLB8H+jKgtMbrvS4ocTxAlKyK8e3fAb3/Wx+18
        8WGggD1yrigxKMcvy7Ina5U=
X-Google-Smtp-Source: AGRyM1s8x05E5/drCcncmEL/utKgBKAONqVJNQQgS0d4Lsx8WpJv6NWZtz/qP0Rxgn2qvnrHIuxI8A==
X-Received: by 2002:a63:2bd2:0:b0:40d:62e4:b880 with SMTP id r201-20020a632bd2000000b0040d62e4b880mr4818752pgr.488.1656545576608;
        Wed, 29 Jun 2022 16:32:56 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:3841:49ce:cba5:1586])
        by smtp.gmail.com with ESMTPSA id b21-20020a17090a8c9500b001ec8d191db4sm2763687pjo.17.2022.06.29.16.32.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jun 2022 16:32:55 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Ming Lei <ming.lei@redhat.com>, Hannes Reinecke <hare@suse.de>,
        John Garry <john.garry@huawei.com>,
        Mike Christie <michael.christie@oracle.com>
Subject: [PATCH v2 41/63] scsi/core: Use the new blk_opf_t type
Date:   Wed, 29 Jun 2022 16:31:23 -0700
Message-Id: <20220629233145.2779494-42-bvanassche@acm.org>
X-Mailer: git-send-email 2.37.0.rc0.161.g10f37bed90-goog
In-Reply-To: <20220629233145.2779494-1-bvanassche@acm.org>
References: <20220629233145.2779494-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Use the new blk_opf_t type for arguments and variables that represent
request flags. Use the !! operator in scsi_noretry_cmd() to convert the
blk_opf_t type into a boolean. This patch does not change any functionality.

Cc: Martin K. Petersen <martin.petersen@oracle.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Ming Lei <ming.lei@redhat.com>
Cc: Hannes Reinecke <hare@suse.de>
Cc: John Garry <john.garry@huawei.com>
Cc: Mike Christie <michael.christie@oracle.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/scsi/scsi_lib.c    | 6 +++---
 include/scsi/scsi_device.h | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
index 126997e464cb..d07d193e7d78 100644
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
