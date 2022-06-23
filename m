Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79480CCA47F
	for <linux-block@archiver.kernel.org>; Thu, 23 Jun 2022 19:01:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231799AbiFWTBT (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 23 Jun 2022 15:01:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231843AbiFWTBH (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 23 Jun 2022 15:01:07 -0400
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72CC610E65B
        for <linux-block@vger.kernel.org>; Thu, 23 Jun 2022 11:06:22 -0700 (PDT)
Received: by mail-pj1-f46.google.com with SMTP id f16so359681pjj.1
        for <linux-block@vger.kernel.org>; Thu, 23 Jun 2022 11:06:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TraJCwU51nOTrBB3rdN7pOVK5aie3yl6MvtfDVDMn3k=;
        b=l/Y/y/Jo/0N3y/w6TdWGgLCH9Y6+T68SYlxoNYsYGOLMeZVmaMSXvD9rBG34wX6B2i
         QaHDfscVgilnVfS24EAmAVLAbQgnucoNCljAOhKDEMBBhI0BJ7oAsK7cGhSillQYapIN
         FPiroXpR6O9l+BLT9f22yTjYHRGO1DQNUEmYz10zmcns/qWapVo31Ql65aiOzCRs4pnI
         urBHnjXxndNq0ODqNE0KODR89ui7qepAJZUGVJNVimdYOvEVxVM30ASCZ6vOwTwDWS6D
         GKBwH4NZaV0ff7k6DwpshbJr+mnsWl4zVOO9AXdAVz9zqL9O9WVn01g99SIMnXesXPjS
         Z0jQ==
X-Gm-Message-State: AJIora/W3vnNwj1Csj0ycclUZkxdqElWHE+q5pfwfThXY5wLsvKTgCPD
        caaR3KSydyvUnZk6hUwER/I=
X-Google-Smtp-Source: AGRyM1vrEkBc42g4wfDDDiN0d4OmxJ15w9u96fjf/P1MbtrhvTdliRPUGodcXOIAeN+k9b0o3e/pkw==
X-Received: by 2002:a17:90b:1d06:b0:1ec:cd94:539b with SMTP id on6-20020a17090b1d0600b001eccd94539bmr5128394pjb.215.1656007581733;
        Thu, 23 Jun 2022 11:06:21 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:70af:1dc5:d20:a563])
        by smtp.gmail.com with ESMTPSA id a18-20020a056a000c9200b0051c4ecb0e3dsm16019967pfv.193.2022.06.23.11.06.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jun 2022 11:06:21 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        John Garry <john.garry@huawei.com>,
        Mike Christie <michael.christie@oracle.com>
Subject: [PATCH 30/51] scsi/core: Change the return type of scsi_noretry_cmd() into bool
Date:   Thu, 23 Jun 2022 11:05:07 -0700
Message-Id: <20220623180528.3595304-31-bvanassche@acm.org>
X-Mailer: git-send-email 2.37.0.rc0.161.g10f37bed90-goog
In-Reply-To: <20220623180528.3595304-1-bvanassche@acm.org>
References: <20220623180528.3595304-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This patch prepares for introducing the new blk_opf_t type in the SCSI core.
Since the value returned by scsi_noretry_cmd() is only used in boolean
expressions, this patch does not change any functionality.

Cc: Martin K. Petersen <martin.petersen@oracle.com>
Cc: John Garry <john.garry@huawei.com>
Cc: Mike Christie <michael.christie@oracle.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/scsi/scsi_error.c | 10 +++++-----
 drivers/scsi/scsi_priv.h  |  2 +-
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/scsi/scsi_error.c b/drivers/scsi/scsi_error.c
index 49ef864df581..60bcb37acafd 100644
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
 
@@ -1794,14 +1794,14 @@ int scsi_noretry_cmd(struct scsi_cmnd *scmd)
 		return req->cmd_flags & REQ_FAILFAST_DEV;
 	case DID_ERROR:
 		if (get_status_byte(scmd) == SAM_STAT_RESERVATION_CONFLICT)
-			return 0;
+			return false;
 		fallthrough;
 	case DID_SOFT_ERROR:
 		return req->cmd_flags & REQ_FAILFAST_DRIVER;
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
index 5c4786310a31..90fbffca7eb0 100644
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
