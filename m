Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A568DC43334
	for <linux-block@archiver.kernel.org>; Wed, 29 Jun 2022 23:33:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231809AbiF2XdA (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 29 Jun 2022 19:33:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231777AbiF2Xc7 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 29 Jun 2022 19:32:59 -0400
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C51B526D1
        for <linux-block@vger.kernel.org>; Wed, 29 Jun 2022 16:32:55 -0700 (PDT)
Received: by mail-pf1-f180.google.com with SMTP id x138so13811512pfc.3
        for <linux-block@vger.kernel.org>; Wed, 29 Jun 2022 16:32:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ePR7TAy30ouQJKbpSNPbp6jqPCms33oEcG+tnZcR6Vo=;
        b=xqEz/1CT1ZS6DxTgFdcjyWoLPdbHDeGR5UXeorDG9xKDFlZW3k5GaFi8HdjzF+0P0J
         JUmisLNRooxNOQQTsCUAz28+5DPPLACNd1iKFNBWYLbCUYXu+xY9QYj63hFUqdk4UkvX
         NLXnOtwJ1JyKeR4IZ8j/YGq7phXn0ho1N4lUt2dmWNY61dBGJhlj8tb7Mb6rEQ4kIgzw
         RBxipR68OOyr/Cqn8ADOBvkoD2AmoPVUGJjnCtPEZSOhzL9QH5gA8xnY4jNmUtKBjwj2
         SxVloOwAFoQ3f8vHv/9SfQurVk3UxBg794mmDJ71WOYJPsRYyy8BvtuLgGX+E2hHZlky
         qaIw==
X-Gm-Message-State: AJIora8gmvtwH8BaaCi+xpCXhGVjitWYTuSym3VlNv8/A6Y96f4XHjh2
        71x/wYeqF7WLVIu6yjrHDhg=
X-Google-Smtp-Source: AGRyM1u4c1SPRk/nLEYS/7N++wlPIBwdOuVfy0K8FFw8Q7rtN8xa6uFviC9Vf3SVIwtawAMBBw1UBg==
X-Received: by 2002:a63:8ac7:0:b0:411:6ef8:2123 with SMTP id y190-20020a638ac7000000b004116ef82123mr5065003pgd.300.1656545575066;
        Wed, 29 Jun 2022 16:32:55 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:3841:49ce:cba5:1586])
        by smtp.gmail.com with ESMTPSA id b21-20020a17090a8c9500b001ec8d191db4sm2763687pjo.17.2022.06.29.16.32.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jun 2022 16:32:54 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Ming Lei <ming.lei@redhat.com>, Hannes Reinecke <hare@suse.de>,
        John Garry <john.garry@huawei.com>,
        Mike Christie <michael.christie@oracle.com>
Subject: [PATCH v2 40/63] scsi/core: Change the return type of scsi_noretry_cmd() into bool
Date:   Wed, 29 Jun 2022 16:31:22 -0700
Message-Id: <20220629233145.2779494-41-bvanassche@acm.org>
X-Mailer: git-send-email 2.37.0.rc0.161.g10f37bed90-goog
In-Reply-To: <20220629233145.2779494-1-bvanassche@acm.org>
References: <20220629233145.2779494-1-bvanassche@acm.org>
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
index 49ef864df581..4b8686162ddd 100644
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
