Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18189C001DF
	for <linux-block@archiver.kernel.org>; Mon, 31 Jul 2023 22:15:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230416AbjGaWPv (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 31 Jul 2023 18:15:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230007AbjGaWPt (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 31 Jul 2023 18:15:49 -0400
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E45E41723
        for <linux-block@vger.kernel.org>; Mon, 31 Jul 2023 15:15:44 -0700 (PDT)
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1bbbbb77b38so29383015ad.3
        for <linux-block@vger.kernel.org>; Mon, 31 Jul 2023 15:15:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690841744; x=1691446544;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KQtAnIArA9iV45Y4VwwqcwMGiJtLwJXQ9EsDGHUi6lM=;
        b=ODkjrn0UEwyCaK3gzuAnaqXSEZB9upwBk4quPtJhWyYDxDoxX20dJZLFd9Ob1KyD6U
         hR4C7R1xkUdNjz/IQz1EqoJfaaTwsobIeKJ62BjkoScwRsec212dBFpq8x/96TemVPEj
         AuTUwQdgwXFzFFd1y+tmmk0D5HD0+Grg52Ha7zcUQFFXNzSO4ib32GmvzyVGhMtM9a6E
         65g4JpfhEDmgzLbe2ZraVfyIakGOSTGxDuaNUdD7ob79foWQyZ06Ur8ZhVggkzQqeY0q
         5mRolOokCf8EC9PJTwkZaqXydWyx3IbLeaJom1teoWo10BGy4qZ3cxrJ8nGzys2LVvE3
         VBAA==
X-Gm-Message-State: ABy/qLbFTEfPeVXoADT3hCjvErNafOvVfvLGrPGDNoN9HvVdwKtOtP17
        0lsxEhmsXlkWQZJdr0KawT4=
X-Google-Smtp-Source: APBJJlF7CgFdHK5tpjnQAIh20WScB+UvdUsa5oHDiGqf/SEFV6daYoUboVIwMK4bpnBljtOZn40sTQ==
X-Received: by 2002:a17:903:1107:b0:1b8:5a32:2345 with SMTP id n7-20020a170903110700b001b85a322345mr10736203plh.22.1690841744360;
        Mon, 31 Jul 2023 15:15:44 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:9346:70e3:158a:281c])
        by smtp.gmail.com with ESMTPSA id jn13-20020a170903050d00b001b895a18472sm9000888plb.117.2023.07.31.15.15.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jul 2023 15:15:44 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Avri Altman <avri.altman@wdc.com>,
        Damien Le Moal <dlemoal@kernel.org>,
        Ming Lei <ming.lei@redhat.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Stanley Chu <stanley.chu@mediatek.com>,
        Can Guo <quic_cang@quicinc.com>, Bean Huo <beanhuo@micron.com>,
        Asutosh Das <quic_asutoshd@quicinc.com>,
        "Bao D. Nguyen" <quic_nguyenb@quicinc.com>,
        Arthur Simchaev <Arthur.Simchaev@wdc.com>
Subject: [PATCH v5 7/7] scsi: ufs: Disable zone write locking
Date:   Mon, 31 Jul 2023 15:14:43 -0700
Message-ID: <20230731221458.437440-8-bvanassche@acm.org>
X-Mailer: git-send-email 2.41.0.585.gd2178a4bd4-goog
In-Reply-To: <20230731221458.437440-1-bvanassche@acm.org>
References: <20230731221458.437440-1-bvanassche@acm.org>
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
  auto-hibernation is enabled in the UFS controller. Hence, enable
  zone write locking if auto-hibernation is enabled.

This patch improves performance as follows on my test setup:
- With the mq-deadline scheduler: 2.5x more IOPS for small writes.
- When not using an I/O scheduler compared to using mq-deadline with
  zone locking: 4x more IOPS for small writes.

Cc: Martin K. Petersen <martin.petersen@oracle.com>
Cc: Avri Altman <avri.altman@wdc.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Damien Le Moal <dlemoal@kernel.org>
Cc: Ming Lei <ming.lei@redhat.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/ufs/core/ufshcd.c | 40 ++++++++++++++++++++++++++++++++++++++-
 1 file changed, 39 insertions(+), 1 deletion(-)

diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
index ae7b868f9c26..3c99516c38fa 100644
--- a/drivers/ufs/core/ufshcd.c
+++ b/drivers/ufs/core/ufshcd.c
@@ -4337,23 +4337,53 @@ int ufshcd_uic_hibern8_exit(struct ufs_hba *hba)
 }
 EXPORT_SYMBOL_GPL(ufshcd_uic_hibern8_exit);
 
+static void ufshcd_update_no_zone_write_lock(struct ufs_hba *hba,
+					     bool set_no_zone_write_lock)
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
 
 	if (!update)
 		return;
+	if (!is_mcq_enabled(hba) && !prev_state && new_state) {
+		/*
+		 * Auto-hibernation will be enabled. Enable write locking for
+		 * zoned writes since auto-hibernation may cause reordering of
+		 * zoned writes when using the legacy mode of the UFS host
+		 * controller.
+		 */
+		ufshcd_update_no_zone_write_lock(hba, false);
+	}
 	if (!pm_runtime_suspended(&hba->ufs_device_wlun->sdev_gendev)) {
 		ufshcd_rpm_get_sync(hba);
 		ufshcd_hold(hba);
@@ -4361,6 +4391,13 @@ void ufshcd_auto_hibern8_update(struct ufs_hba *hba, u32 ahit)
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
 
@@ -5140,6 +5177,7 @@ static int ufshcd_slave_configure(struct scsi_device *sdev)
 
 	ufshcd_hpb_configure(hba, sdev);
 
+	blk_queue_flag_set(QUEUE_FLAG_NO_ZONE_WRITE_LOCK, q);
 	blk_queue_update_dma_pad(q, PRDT_DATA_BYTE_COUNT_PAD - 1);
 	if (hba->quirks & UFSHCD_QUIRK_4KB_DMA_ALIGNMENT)
 		blk_queue_update_dma_alignment(q, SZ_4K - 1);
