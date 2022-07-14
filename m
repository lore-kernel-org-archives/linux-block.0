Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C220CCA47B
	for <linux-block@archiver.kernel.org>; Thu, 14 Jul 2022 18:11:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229458AbiGNSLI (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 14 Jul 2022 14:11:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240498AbiGNSIs (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 14 Jul 2022 14:08:48 -0400
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D5EBE12
        for <linux-block@vger.kernel.org>; Thu, 14 Jul 2022 11:08:43 -0700 (PDT)
Received: by mail-pf1-f181.google.com with SMTP id y141so2552006pfb.7
        for <linux-block@vger.kernel.org>; Thu, 14 Jul 2022 11:08:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=riAlwJYpT/QEHE5otafNnKkoOdhtRB0VaJHnKEK1BOI=;
        b=Nxouj9gJTZSyqyZoz/KXLEQT4nhEMHueNbm2K3p7eAdTM305dG5NBFXVKWtA8MjXPS
         PuTriDQGY45EDFSnNNvJ95hB1CiPn5QIXHMxead5u3x5vR9nu96ylMTrYNDLGuUyyrG+
         6COshci0hzinvFkTafFai6QFoHHajWQS4kzQGnRv2jKpnjUYLjzqq0Mncagg7RZ77ovl
         V0BR13vhR/JIvxI1IxjMKx4VpN7OyG00z4/SDccRpPoPzWtre6Bs8OJxvIY5unUSLpM8
         J3y2liSUZ7k2d5z3ewTGE438uMA37Y33WWmv37W/bFwHpVjQ5gelAoHzldpnB9ZjEqVG
         szRQ==
X-Gm-Message-State: AJIora8tbrEg6gUc5lA8u3yf3nUgYOhSjbmzWpBB8Lj5ZzFcSTmLBvGH
        YeuwA0SJ9c1kmjnVoylL5CU=
X-Google-Smtp-Source: AGRyM1smz0CiDs3skRC+HfiVEDsl/nR+qx7/jXcLVEcyuqdufkugcw1qKyZCyS4Q23wtBEka0QrqMQ==
X-Received: by 2002:a05:6a00:841:b0:52b:15d2:e50f with SMTP id q1-20020a056a00084100b0052b15d2e50fmr7207419pfk.47.1657822122721;
        Thu, 14 Jul 2022 11:08:42 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:9fab:70d1:f0e7:922b])
        by smtp.gmail.com with ESMTPSA id m5-20020a170902db0500b0016bebb0cb96sm1781846plx.266.2022.07.14.11.08.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jul 2022 11:08:42 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Bart Van Assche <bvanassche@acm.org>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Ming Lei <ming.lei@redhat.com>, Hannes Reinecke <hare@suse.de>,
        John Garry <john.garry@huawei.com>,
        Mike Christie <michael.christie@oracle.com>
Subject: [PATCH v3 41/63] scsi/core: Use the new blk_opf_t type
Date:   Thu, 14 Jul 2022 11:07:07 -0700
Message-Id: <20220714180729.1065367-42-bvanassche@acm.org>
X-Mailer: git-send-email 2.37.0.170.g444d1eabd0-goog
In-Reply-To: <20220714180729.1065367-1-bvanassche@acm.org>
References: <20220714180729.1065367-1-bvanassche@acm.org>
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
index 06ec4705caf9..17a617db9ae0 100644
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
