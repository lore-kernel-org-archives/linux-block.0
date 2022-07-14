Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3907FC433EF
	for <linux-block@archiver.kernel.org>; Thu, 14 Jul 2022 18:09:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240157AbiGNSJ2 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 14 Jul 2022 14:09:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240541AbiGNSIt (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 14 Jul 2022 14:08:49 -0400
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43C3A14090
        for <linux-block@vger.kernel.org>; Thu, 14 Jul 2022 11:08:45 -0700 (PDT)
Received: by mail-pl1-f177.google.com with SMTP id r1so1121288plo.10
        for <linux-block@vger.kernel.org>; Thu, 14 Jul 2022 11:08:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XYU1/QmsLeNdj0K1UBWBwoHsQTbx8MJ5yBdMXh+eT/Q=;
        b=qFzA3asLJx7Yq9iBceMgNWBIKaazr4joqa/gVbDQiD/OH0eWgWV3lFowjcLq0rnNg/
         VofWbVNjlGdt/dOxILax4fi/ALgChtDdA/O/USf1vECUX4LOMFSBVXtz5ggg+musOoDK
         F2Jx/wnAtvrf/eAZT/5ksRZuPd5ZBeKuwZocfMaLOhAuvedwzdL0jxHyV8LL2Rj05eFE
         qoPdf/D3PNYA0GlL1xjAjp0m5mVS7AUOGouOImbe7XRzHAY1/CjJoAf7rWpxbcbuqkSC
         /nTvIYmkrWIHwhYZUbCQsTZlwW/kzKnjZgBZFQnPdQEPay6rRUdOqgv59fykV79PVLaZ
         SG2w==
X-Gm-Message-State: AJIora/B80MM+BwDXPXCZ862AoGROKJXiVfHeydBj92EsfwlL8by5saT
        vWwAqp8ALmCRavmgb+Vij/Q=
X-Google-Smtp-Source: AGRyM1thJfDSN/Dps0K3I+qBVBFVWj/KPHqJNeFfVD8Il6bQxVA4R5N00LgbRREqGiqE4DacHqzdXQ==
X-Received: by 2002:a17:90b:2114:b0:1ef:8ac4:c66c with SMTP id kz20-20020a17090b211400b001ef8ac4c66cmr17192509pjb.174.1657822124298;
        Thu, 14 Jul 2022 11:08:44 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:9fab:70d1:f0e7:922b])
        by smtp.gmail.com with ESMTPSA id m5-20020a170902db0500b0016bebb0cb96sm1781846plx.266.2022.07.14.11.08.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jul 2022 11:08:43 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Bart Van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.com>, Martin Wilck <mwilck@suse.com>
Subject: [PATCH v3 42/63] scsi/device_handlers: Use the new blk_opf_t type
Date:   Thu, 14 Jul 2022 11:07:08 -0700
Message-Id: <20220714180729.1065367-43-bvanassche@acm.org>
X-Mailer: git-send-email 2.37.0.170.g444d1eabd0-goog
In-Reply-To: <20220714180729.1065367-1-bvanassche@acm.org>
References: <20220714180729.1065367-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Improve static type checking by using the new blk_opf_t type for variables
that represent request flags.

Cc: Hannes Reinecke <hare@suse.com>
Cc: Martin Wilck <mwilck@suse.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/scsi/device_handler/scsi_dh_alua.c  | 4 ++--
 drivers/scsi/device_handler/scsi_dh_emc.c   | 2 +-
 drivers/scsi/device_handler/scsi_dh_hp_sw.c | 4 ++--
 drivers/scsi/device_handler/scsi_dh_rdac.c  | 2 +-
 4 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/scsi/device_handler/scsi_dh_alua.c b/drivers/scsi/device_handler/scsi_dh_alua.c
index 1d9be771f3ee..610a51538f03 100644
--- a/drivers/scsi/device_handler/scsi_dh_alua.c
+++ b/drivers/scsi/device_handler/scsi_dh_alua.c
@@ -127,7 +127,7 @@ static int submit_rtpg(struct scsi_device *sdev, unsigned char *buff,
 		       int bufflen, struct scsi_sense_hdr *sshdr, int flags)
 {
 	u8 cdb[MAX_COMMAND_SIZE];
-	int req_flags = REQ_FAILFAST_DEV | REQ_FAILFAST_TRANSPORT |
+	blk_opf_t req_flags = REQ_FAILFAST_DEV | REQ_FAILFAST_TRANSPORT |
 		REQ_FAILFAST_DRIVER;
 
 	/* Prepare the command. */
@@ -157,7 +157,7 @@ static int submit_stpg(struct scsi_device *sdev, int group_id,
 	u8 cdb[MAX_COMMAND_SIZE];
 	unsigned char stpg_data[8];
 	int stpg_len = 8;
-	int req_flags = REQ_FAILFAST_DEV | REQ_FAILFAST_TRANSPORT |
+	blk_opf_t req_flags = REQ_FAILFAST_DEV | REQ_FAILFAST_TRANSPORT |
 		REQ_FAILFAST_DRIVER;
 
 	/* Prepare the data buffer */
diff --git a/drivers/scsi/device_handler/scsi_dh_emc.c b/drivers/scsi/device_handler/scsi_dh_emc.c
index bd28ec6cfb72..2e21ab447873 100644
--- a/drivers/scsi/device_handler/scsi_dh_emc.c
+++ b/drivers/scsi/device_handler/scsi_dh_emc.c
@@ -239,7 +239,7 @@ static int send_trespass_cmd(struct scsi_device *sdev,
 	unsigned char cdb[MAX_COMMAND_SIZE];
 	int err, res = SCSI_DH_OK, len;
 	struct scsi_sense_hdr sshdr;
-	u64 req_flags = REQ_FAILFAST_DEV | REQ_FAILFAST_TRANSPORT |
+	blk_opf_t req_flags = REQ_FAILFAST_DEV | REQ_FAILFAST_TRANSPORT |
 		REQ_FAILFAST_DRIVER;
 
 	if (csdev->flags & CLARIION_SHORT_TRESPASS) {
diff --git a/drivers/scsi/device_handler/scsi_dh_hp_sw.c b/drivers/scsi/device_handler/scsi_dh_hp_sw.c
index 4a3f7831a2d6..0d2cfa60aa06 100644
--- a/drivers/scsi/device_handler/scsi_dh_hp_sw.c
+++ b/drivers/scsi/device_handler/scsi_dh_hp_sw.c
@@ -83,7 +83,7 @@ static int hp_sw_tur(struct scsi_device *sdev, struct hp_sw_dh_data *h)
 	unsigned char cmd[6] = { TEST_UNIT_READY };
 	struct scsi_sense_hdr sshdr;
 	int ret = SCSI_DH_OK, res;
-	u64 req_flags = REQ_FAILFAST_DEV | REQ_FAILFAST_TRANSPORT |
+	blk_opf_t req_flags = REQ_FAILFAST_DEV | REQ_FAILFAST_TRANSPORT |
 		REQ_FAILFAST_DRIVER;
 
 retry:
@@ -121,7 +121,7 @@ static int hp_sw_start_stop(struct hp_sw_dh_data *h)
 	struct scsi_device *sdev = h->sdev;
 	int res, rc = SCSI_DH_OK;
 	int retry_cnt = HP_SW_RETRIES;
-	u64 req_flags = REQ_FAILFAST_DEV | REQ_FAILFAST_TRANSPORT |
+	blk_opf_t req_flags = REQ_FAILFAST_DEV | REQ_FAILFAST_TRANSPORT |
 		REQ_FAILFAST_DRIVER;
 
 retry:
diff --git a/drivers/scsi/device_handler/scsi_dh_rdac.c b/drivers/scsi/device_handler/scsi_dh_rdac.c
index 66652ab409cc..bf8754741f85 100644
--- a/drivers/scsi/device_handler/scsi_dh_rdac.c
+++ b/drivers/scsi/device_handler/scsi_dh_rdac.c
@@ -536,7 +536,7 @@ static void send_mode_select(struct work_struct *work)
 	unsigned char cdb[MAX_COMMAND_SIZE];
 	struct scsi_sense_hdr sshdr;
 	unsigned int data_size;
-	u64 req_flags = REQ_FAILFAST_DEV | REQ_FAILFAST_TRANSPORT |
+	blk_opf_t req_flags = REQ_FAILFAST_DEV | REQ_FAILFAST_TRANSPORT |
 		REQ_FAILFAST_DRIVER;
 
 	spin_lock(&ctlr->ms_lock);
