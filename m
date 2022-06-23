Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3AB9CCA480
	for <linux-block@archiver.kernel.org>; Thu, 23 Jun 2022 19:01:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231955AbiFWTBV (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 23 Jun 2022 15:01:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231860AbiFWTBI (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 23 Jun 2022 15:01:08 -0400
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31BCC10E65A
        for <linux-block@vger.kernel.org>; Thu, 23 Jun 2022 11:06:25 -0700 (PDT)
Received: by mail-pl1-f178.google.com with SMTP id c4so2629850plc.8
        for <linux-block@vger.kernel.org>; Thu, 23 Jun 2022 11:06:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=E+7fz1kpwun+FM+ENLhLC8EM6umBuEasV+oUHoRPE00=;
        b=73xQaq6z6uDDsmI43UXakycA1afFAd59QDJWI9wDvKBpe7ibzlmyvunIItXG6/8HwA
         IkxsZlVeMpJ+LdKITvxLRaUCi3BDkZwxd1vDIBoJheNs5YrT1qqlh1IEwsEN72oaSfCk
         /aUW8rvtkDPZeB7sbdgqFkC03YtdfPV4qzILZ14TziLRNLAZkqza0GFDAgmA6hlqDfbj
         dVuwCi30+wwrneE+H9vii8pEOeN2DXAoI70IgfzHFKtt2rwpeGbEQTTgiBVje1piJElY
         Xx8dOMhzQxOe7sXdNDVj4iap+r543mK8/LXS1VjV40vdTeuRdV8i8AolKygy2M2esI6P
         MbpA==
X-Gm-Message-State: AJIora+4WjVTgu3GcRNUfjlzzb7qHwhEGiwCUa0OdsVODmUM/wXAFxJS
        lI+pBBBvp/MT7MPZuZsSGXk=
X-Google-Smtp-Source: AGRyM1tXqEFpDPEo2draovkPUEFsova4X6QqPjqwZTktQlBJRzBw/EGm8BhHWMDir0iAiX7qf2XWEg==
X-Received: by 2002:a17:903:18a:b0:16a:612f:c9da with SMTP id z10-20020a170903018a00b0016a612fc9damr2050192plg.174.1656007584780;
        Thu, 23 Jun 2022 11:06:24 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:70af:1dc5:d20:a563])
        by smtp.gmail.com with ESMTPSA id a18-20020a056a000c9200b0051c4ecb0e3dsm16019967pfv.193.2022.06.23.11.06.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jun 2022 11:06:24 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.com>
Subject: [PATCH 32/51] scsi/device_handlers: Use the new blk_opf_t type
Date:   Thu, 23 Jun 2022 11:05:09 -0700
Message-Id: <20220623180528.3595304-33-bvanassche@acm.org>
X-Mailer: git-send-email 2.37.0.rc0.161.g10f37bed90-goog
In-Reply-To: <20220623180528.3595304-1-bvanassche@acm.org>
References: <20220623180528.3595304-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Improve static type checking by using the new blk_opf_t type for variables
that represent request flags.

Cc: Hannes Reinecke <hare@suse.com>
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
