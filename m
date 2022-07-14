Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BB3ECCA47B
	for <linux-block@archiver.kernel.org>; Thu, 14 Jul 2022 18:09:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233854AbiGNSJ0 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 14 Jul 2022 14:09:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240523AbiGNSIr (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 14 Jul 2022 14:08:47 -0400
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5273DC37
        for <linux-block@vger.kernel.org>; Thu, 14 Jul 2022 11:08:42 -0700 (PDT)
Received: by mail-pl1-f178.google.com with SMTP id b2so1118953plx.7
        for <linux-block@vger.kernel.org>; Thu, 14 Jul 2022 11:08:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wD3ywf4yaoFAbAUOfKrGBD6BdZNwViN2JP41b+JRVuU=;
        b=fbxOOOueuxMa4eIUt/dMMOuChTAlsmmyReUggaUZ1dLI1Unk7Ln6KX5tDRszG86KAM
         bvSyBW+WA9nLzo6hK1/CUJVHD5l8urTUOjU1Q23l04w5vdwWk0VoDjrsTrcLqxK/8GHz
         lFpIyoegLwZcdH3MfG4L/+lBZJKykrrfVJwnTbCRTDTxPeOOtreyeaOOiTJkGuszCien
         gy/NsCHyJzrfjPxJiP+vuAjsy4ZWxeTtYnAmjJ8Fi2CtRN/Up39zESIAzyPjOByiZmN8
         xV2r5KpMeKw2YcSp7c7i8g2P6bAqjugA4hEBlfAqeuPpmJlf16fT1rcBAKLvFKWo0maY
         pyzw==
X-Gm-Message-State: AJIora8MRpoFb2nipZ4ceQuucsoTe8gtylGh+dHNItPwk4ws/LkhhasS
        vQqtjZSKQ9C8OYQ6mZxhF80=
X-Google-Smtp-Source: AGRyM1tMbrhNeqAmhnPdy1BZyUEAeofWOR+aY+wiKwK/dPmQ0/0EpHwa42IcXpEM6arxM6o61MUbpA==
X-Received: by 2002:a17:902:f542:b0:16b:dbf1:2179 with SMTP id h2-20020a170902f54200b0016bdbf12179mr9872345plf.18.1657822121213;
        Thu, 14 Jul 2022 11:08:41 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:9fab:70d1:f0e7:922b])
        by smtp.gmail.com with ESMTPSA id m5-20020a170902db0500b0016bebb0cb96sm1781846plx.266.2022.07.14.11.08.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jul 2022 11:08:40 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Bart Van Assche <bvanassche@acm.org>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Ming Lei <ming.lei@redhat.com>, Hannes Reinecke <hare@suse.de>,
        John Garry <john.garry@huawei.com>,
        Mike Christie <michael.christie@oracle.com>
Subject: [PATCH v3 40/63] scsi/core: Change the return type of scsi_noretry_cmd() into bool
Date:   Thu, 14 Jul 2022 11:07:06 -0700
Message-Id: <20220714180729.1065367-41-bvanassche@acm.org>
X-Mailer: git-send-email 2.37.0.170.g444d1eabd0-goog
In-Reply-To: <20220714180729.1065367-1-bvanassche@acm.org>
References: <20220714180729.1065367-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This patch prepares for introducing the new blk_opf_t type in the SCSI core.
Since the value returned by scsi_noretry_cmd() is only used in boolean
expressions, this patch does not change any functionality.

Cc: Martin K. Petersen <martin.petersen@oracle.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Ming Lei <ming.lei@redhat.com>
Cc: Hannes Reinecke <hare@suse.de>
Cc: John Garry <john.garry@huawei.com>
Cc: Mike Christie <michael.christie@oracle.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/scsi/scsi_error.c | 16 ++++++++--------
 drivers/scsi/scsi_priv.h  |  2 +-
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/scsi/scsi_error.c b/drivers/scsi/scsi_error.c
index 266ce414589c..b776cefc7cda 100644
--- a/drivers/scsi/scsi_error.c
+++ b/drivers/scsi/scsi_error.c
@@ -1779,7 +1779,7 @@ static void scsi_eh_offline_sdevs(struct list_head *work_q,
  * scsi_noretry_cmd - determine if command should be failed fast
  * @scmd:	SCSI cmd to examine.
  */
-int scsi_noretry_cmd(struct scsi_cmnd *scmd)
+bool scsi_noretry_cmd(struct scsi_cmnd *scmd)
 {
 	struct request *req = scsi_cmd_to_rq(scmd);
 
@@ -1789,19 +1789,19 @@ int scsi_noretry_cmd(struct scsi_cmnd *scmd)
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
-			return 0;
+			return false;
 		fallthrough;
 	case DID_SOFT_ERROR:
-		return req->cmd_flags & REQ_FAILFAST_DRIVER;
+		return !!(req->cmd_flags & REQ_FAILFAST_DRIVER);
 	}
 
 	if (!scsi_status_is_check_condition(scmd->result))
-		return 0;
+		return false;
 
 check_type:
 	/*
@@ -1809,9 +1809,9 @@ int scsi_noretry_cmd(struct scsi_cmnd *scmd)
 	 * the check condition was retryable.
 	 */
 	if (req->cmd_flags & REQ_FAILFAST_DEV || blk_rq_is_passthrough(req))
-		return 1;
+		return true;
 
-	return 0;
+	return false;
 }
 
 /**
diff --git a/drivers/scsi/scsi_priv.h b/drivers/scsi/scsi_priv.h
index 6eeaa0a7f86d..429663bd78ec 100644
--- a/drivers/scsi/scsi_priv.h
+++ b/drivers/scsi/scsi_priv.h
@@ -82,7 +82,7 @@ void scsi_eh_ready_devs(struct Scsi_Host *shost,
 			struct list_head *done_q);
 int scsi_eh_get_sense(struct list_head *work_q,
 		      struct list_head *done_q);
-int scsi_noretry_cmd(struct scsi_cmnd *scmd);
+bool scsi_noretry_cmd(struct scsi_cmnd *scmd);
 void scsi_eh_done(struct scsi_cmnd *scmd);
 
 /* scsi_lib.c */
