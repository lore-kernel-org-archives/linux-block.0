Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FD67C001DF
	for <linux-block@archiver.kernel.org>; Mon, 17 Jul 2023 20:53:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229886AbjGQUxR (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 17 Jul 2023 16:53:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229658AbjGQUxP (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 17 Jul 2023 16:53:15 -0400
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4BF21725
        for <linux-block@vger.kernel.org>; Mon, 17 Jul 2023 13:52:31 -0700 (PDT)
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-5577900c06bso3772733a12.2
        for <linux-block@vger.kernel.org>; Mon, 17 Jul 2023 13:52:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689627151; x=1692219151;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nVSZbVbHnYr4oPJtre+peVtx9ULfxBAErKcKzg0bkGo=;
        b=bwmgYrGxumBZZqaT2xGEE6poTEv8MbZTvdwqAMz6o241uftyy+VL+8KjtOM5rMD8hf
         UwA/+bfq1WDaLcRFnoi0xJ6nZaSG/siZXfVe7xNOk9OcGn8kKmhiBxNKughgJOFUevQi
         sYlrD6R87qQMMMTHdwmapZy17JK/mFJidAH+YexdcTnoxlqIHxwt7FCrAw8TD7JG9Upz
         Aze58rWkQoAHHph45wmPgdWXjrl6CR/ANTe8TPEtq725916MSbYwM47zySEA0FzvF2Xp
         MAErYTZcPwfpJjyqiYMBLS4xSkjVQiD+poKrCdZVFcAsoHXApkXPAGdzCYM+NJlt3iEx
         0I0g==
X-Gm-Message-State: ABy/qLbgKwLiMvBdcgm23LJZdDEGdEoHEbHYcRteX/M8h2+nkV1p0SQy
        ztenSng/R7VIxIRcGM56tlg=
X-Google-Smtp-Source: APBJJlHhebQiAEEp/s+2qZtNhZeSgejD+aqeb4F5EKr0V25ZS3YmkT1iD08aHoFUtJR0cpcDBKNDKQ==
X-Received: by 2002:a17:90a:b00d:b0:259:b065:da4f with SMTP id x13-20020a17090ab00d00b00259b065da4fmr12266934pjq.36.1689627150877;
        Mon, 17 Jul 2023 13:52:30 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:ac3:b183:3725:4b8f])
        by smtp.gmail.com with ESMTPSA id v17-20020a17090abb9100b0025645ce761dsm5222403pjr.35.2023.07.17.13.52.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jul 2023 13:52:30 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Bart Van Assche <bvanassche@acm.org>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>
Subject: [PATCH 1/3] scsi: Inline scsi_kick_queue()
Date:   Mon, 17 Jul 2023 13:52:13 -0700
Message-ID: <20230717205216.2024545-2-bvanassche@acm.org>
X-Mailer: git-send-email 2.41.0.255.g8b1d071c50-goog
In-Reply-To: <20230717205216.2024545-1-bvanassche@acm.org>
References: <20230717205216.2024545-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

scsi_kick_queue() is too short to keep it as a separate function. Hence
inline it.

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
