Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76E3BC0015E
	for <linux-block@archiver.kernel.org>; Wed, 19 Jul 2023 18:23:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229655AbjGSSXR (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 19 Jul 2023 14:23:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229601AbjGSSXQ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 19 Jul 2023 14:23:16 -0400
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A933F1BF6
        for <linux-block@vger.kernel.org>; Wed, 19 Jul 2023 11:23:15 -0700 (PDT)
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1b89600a37fso45327775ad.2
        for <linux-block@vger.kernel.org>; Wed, 19 Jul 2023 11:23:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689790995; x=1692382995;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=824u76hYSw99543u2htvcLKDRWPlhBTji6Kvikd0vyI=;
        b=hFd7yRvjZvZhbaxb/tW20T9WXtU1p+Zm9TFSUh0+vi92AzPD0aqrK5mM0K9aB+Rmkj
         Npg4eIVSckCmTvtDWdG2/P0Vs18iArK34v4Lygb7+CZw/rEZaKFAD70Tc5dv7mWwwUG7
         9bO1HvE1g9cvKcnbeiJKFzWfmG/LezcjbDws/G0LltBYKHVSXTeIC/T0X5gX71RTolB1
         +GAcdrFSu7XrY8XtHv7CY71ld5M5Cyb99MbjVrd/yqmnpbvGiSO/fdNDJkaYZgGGXbw4
         8ccYX7SVEXwtfmpvnG5Axg0uQPAykPQXgNs/YD6zbTw7+jJ5rTP1Ut6Xdnr8x1DUvmhm
         3M+A==
X-Gm-Message-State: ABy/qLb+/CvwVy3HYmCCBMs8xRZ8wPM5fy4jEyvPTboAfxEu5/pIXPmg
        k7tUI+k/LKLKMKyC9q3EzZ3s6dsJl+4=
X-Google-Smtp-Source: APBJJlEP0QrWbl4FbFXdzE15XdGk5NtwNIi94GeCSxCOLXjauLCLFCL8/33nbj+nCKkoJsELGgaFTw==
X-Received: by 2002:a17:903:1d0:b0:1b6:bced:1dd6 with SMTP id e16-20020a17090301d000b001b6bced1dd6mr2168929plh.35.1689790994975;
        Wed, 19 Jul 2023 11:23:14 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:a2ab:183f:c76c:d30d])
        by smtp.gmail.com with ESMTPSA id l16-20020a170903245000b001bb33ee4057sm4316061pls.43.2023.07.19.11.23.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jul 2023 11:23:14 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Bart Van Assche <bvanassche@acm.org>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>
Subject: [PATCH v2 1/3] scsi: Inline scsi_kick_queue()
Date:   Wed, 19 Jul 2023 11:22:40 -0700
Message-ID: <20230719182243.2810134-2-bvanassche@acm.org>
X-Mailer: git-send-email 2.41.0.255.g8b1d071c50-goog
In-Reply-To: <20230719182243.2810134-1-bvanassche@acm.org>
References: <20230719182243.2810134-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

scsi_kick_queue() is too short to keep it as a separate function. Hence
inline it. This patch prepares for modifying the second argument passed
to blk_mq_run_hw_queues().

Cc: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/scsi/scsi_lib.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
index ad9afae49544..414d29eef968 100644
--- a/drivers/scsi/scsi_lib.c
+++ b/drivers/scsi/scsi_lib.c
@@ -300,11 +300,6 @@ void scsi_device_unbusy(struct scsi_device *sdev, struct scsi_cmnd *cmd)
 	cmd->budget_token = -1;
 }
 
-static void scsi_kick_queue(struct request_queue *q)
-{
-	blk_mq_run_hw_queues(q, false);
-}
-
 /*
  * Kick the queue of SCSI device @sdev if @sdev != current_sdev. Called with
  * interrupts disabled.
@@ -340,7 +335,7 @@ static void scsi_single_lun_run(struct scsi_device *current_sdev)
 	 * but in most cases, we will be first. Ideally, each LU on the
 	 * target would get some limited time or requests on the target.
 	 */
-	scsi_kick_queue(current_sdev->request_queue);
+	blk_mq_run_hw_queues(current_sdev->request_queue, false);
 
 	spin_lock_irqsave(shost->host_lock, flags);
 	if (!starget->starget_sdev_user)
@@ -427,7 +422,7 @@ static void scsi_starved_list_run(struct Scsi_Host *shost)
 			continue;
 		spin_unlock_irqrestore(shost->host_lock, flags);
 
-		scsi_kick_queue(slq);
+		blk_mq_run_hw_queues(slq, false);
 		blk_put_queue(slq);
 
 		spin_lock_irqsave(shost->host_lock, flags);
