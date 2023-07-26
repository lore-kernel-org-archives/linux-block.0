Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4088C001DE
	for <linux-block@archiver.kernel.org>; Wed, 26 Jul 2023 00:58:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229498AbjGZA6O (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 25 Jul 2023 20:58:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229963AbjGZA6N (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 25 Jul 2023 20:58:13 -0400
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06008F7
        for <linux-block@vger.kernel.org>; Tue, 25 Jul 2023 17:58:09 -0700 (PDT)
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-6b9cf7e6ab2so5019806a34.1
        for <linux-block@vger.kernel.org>; Tue, 25 Jul 2023 17:58:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690333088; x=1690937888;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vg27AP3dmRQc/Q6tg7fhXLXYbPyXneQBPb55lq0Fmaw=;
        b=kz9hC2GbzSBSv36y6x/XxuCFAP5N+oFX9wprk4qYpQAv4by0GNzzfmddNKrlvE+4KF
         cbRY5RYuJ1CQY3UINp8HEzVFwybbvJCLvIUKr7jkE6mGr7raZMnoODUZ+MIPxZHklFa9
         SUCAbB8p5Xtzt8CTGYmc/NFclIymc1baf2uwdynaFkS2eoh+f7oFIJwGppeJyHjFuwu7
         LHFT+s03VVrNlRUBI2AuQ2UWA6DFZgtA5jFq6gSqC8r6uXrmIfJBwfkM9BC3dsiIJRWb
         7EwzJG2ZxL1H/fI/PbvpcUXw6uPGqusMsVksOfcv7AO3kXUAE4jdKkML7Vi+LVrdi1sA
         Uj6A==
X-Gm-Message-State: ABy/qLZzj0EGhgPUgjrIUPxF64g7hdvwo6Zw1RNlx3mi+GJKa6vGlphM
        Sehor1UsoXh4veiqdCensP8=
X-Google-Smtp-Source: APBJJlHAqhy1tdNuM/DRyWnpw1vE2LTUnUAe3X7YGyYRSQs0jI3zYtW0Z2e0jCK0fVecABlmq0pHOg==
X-Received: by 2002:a05:6830:14c:b0:6ba:169f:f419 with SMTP id j12-20020a056830014c00b006ba169ff419mr720995otp.4.1690333088104;
        Tue, 25 Jul 2023 17:58:08 -0700 (PDT)
Received: from bvanassche-glaptop2.roam.corp.google.com ([2601:642:4c05:4a8d:dbda:6b13:2798:9795])
        by smtp.gmail.com with ESMTPSA id t10-20020a63954a000000b005634bd81331sm11090138pgn.72.2023.07.25.17.58.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jul 2023 17:58:07 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Bart Van Assche <bvanassche@acm.org>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Avri Altman <avri.altman@wdc.com>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Ming Lei <ming.lei@redhat.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Stanley Chu <stanley.chu@mediatek.com>,
        Can Guo <quic_cang@quicinc.com>,
        Asutosh Das <quic_asutoshd@quicinc.com>,
        "Bao D. Nguyen" <quic_nguyenb@quicinc.com>,
        Bean Huo <beanhuo@micron.com>,
        Arthur Simchaev <Arthur.Simchaev@wdc.com>
Subject: [PATCH v3 5/6] scsi: ufs: Disable zone write locking
Date:   Tue, 25 Jul 2023 17:57:29 -0700
Message-ID: <20230726005742.303865-6-bvanassche@acm.org>
X-Mailer: git-send-email 2.41.0.487.g6d72f3e995-goog
In-Reply-To: <20230726005742.303865-1-bvanassche@acm.org>
References: <20230726005742.303865-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From the UFSHCI 4.0 specification, about the legacy (single queue) mode:
"The host controller always process transfer requests in-order according
to the order submitted to the list. In case of multiple commands with
single doorbell register ringing (batch mode), The dispatch order for
these transfer requests by host controller will base on their index in
the List. A transfer request with lower index value will be executed
before a transfer request with higher index value."

From the UFSHCI 4.0 specification, about the MCQ mode:
"Command Submission
1. Host SW writes an Entry to SQ
2. Host SW updates SQ doorbell tail pointer

Command Processing
3. After fetching the Entry, Host Controller updates SQ doorbell head
   pointer
4. Host controller sends COMMAND UPIU to UFS device"

In other words, for both legacy and MCQ mode, UFS controllers are
required to forward commands to the UFS device in the order these
commands have been received from the host.

Notes:
- For legacy mode this is only correct if the host submits one
  command at a time. The UFS driver does this.
- Also in legacy mode, the command order is not preserved if
  auto-hibernation is enabled in the UFS controller.

This patch improves small write IOPS with a factor four on my test
setup.

Cc: Martin K. Petersen <martin.petersen@oracle.com>
Cc: Avri Altman <avri.altman@wdc.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc: Ming Lei <ming.lei@redhat.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/ufs/core/ufshcd.c | 45 ++++++++++++++++++++++++++++++++++++---
 1 file changed, 42 insertions(+), 3 deletions(-)

diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
index 129446775796..0f7f91e2cda9 100644
--- a/drivers/ufs/core/ufshcd.c
+++ b/drivers/ufs/core/ufshcd.c
@@ -4337,29 +4337,67 @@ int ufshcd_uic_hibern8_exit(struct ufs_hba *hba)
 }
 EXPORT_SYMBOL_GPL(ufshcd_uic_hibern8_exit);
 
+void ufshcd_update_no_zone_write_lock(struct ufs_hba *hba,
+				      bool set_no_zone_write_lock)
+{
+	struct scsi_device *sdev;
+
+	shost_for_each_device(sdev, hba->host)
+		blk_freeze_queue_start(sdev->request_queue);
+	shost_for_each_device(sdev, hba->host) {
+		struct request_queue *q = sdev->request_queue;
+
+		blk_mq_freeze_queue_wait(q);
+		if (set_no_zone_write_lock)
+			blk_queue_flag_set(QUEUE_FLAG_NO_ZONE_WRITE_LOCK, q);
+		else
+			blk_queue_flag_clear(QUEUE_FLAG_NO_ZONE_WRITE_LOCK, q);
+		blk_mq_unfreeze_queue(q);
+	}
+}
+
 void ufshcd_auto_hibern8_update(struct ufs_hba *hba, u32 ahit)
 {
 	unsigned long flags;
-	bool update = false;
+	bool prev_state, new_state, update = false;
 
 	if (!ufshcd_is_auto_hibern8_supported(hba))
 		return;
 
 	spin_lock_irqsave(hba->host->host_lock, flags);
+	prev_state = ufshcd_is_auto_hibern8_enabled(hba);
 	if (hba->ahit != ahit) {
 		hba->ahit = ahit;
 		update = true;
 	}
+	new_state = ufshcd_is_auto_hibern8_enabled(hba);
 	spin_unlock_irqrestore(hba->host->host_lock, flags);
 
-	if (update &&
-	    !pm_runtime_suspended(&hba->ufs_device_wlun->sdev_gendev)) {
+	if (!update)
+		return;
+	if (!is_mcq_enabled(hba) && !prev_state && new_state) {
+		/*
+		 * Auto-hibernation will be enabled. Enable write locking for
+		 * zoned writes since auto-hibernation may cause reordering of
+		 * zoned writes when using the legacy mode of the UFS host
+		 * controller.
+		 */
+		ufshcd_update_no_zone_write_lock(hba, false);
+	}
+	if (!pm_runtime_suspended(&hba->ufs_device_wlun->sdev_gendev)) {
 		ufshcd_rpm_get_sync(hba);
 		ufshcd_hold(hba);
 		ufshcd_auto_hibern8_enable(hba);
 		ufshcd_release(hba);
 		ufshcd_rpm_put_sync(hba);
 	}
+	if (!is_mcq_enabled(hba) && prev_state && !new_state) {
+		/*
+		 * Auto-hibernation has been disabled. Disable write locking
+		 * for zoned writes.
+		 */
+		ufshcd_update_no_zone_write_lock(hba, true);
+	}
 }
 EXPORT_SYMBOL_GPL(ufshcd_auto_hibern8_update);
 
@@ -5139,6 +5177,7 @@ static int ufshcd_slave_configure(struct scsi_device *sdev)
 
 	ufshcd_hpb_configure(hba, sdev);
 
+	blk_queue_flag_set(QUEUE_FLAG_NO_ZONE_WRITE_LOCK, q);
 	blk_queue_update_dma_pad(q, PRDT_DATA_BYTE_COUNT_PAD - 1);
 	if (hba->quirks & UFSHCD_QUIRK_4KB_DMA_ALIGNMENT)
 		blk_queue_update_dma_alignment(q, SZ_4K - 1);
