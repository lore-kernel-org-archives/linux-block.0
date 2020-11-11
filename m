Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8E6AC5517A
	for <linux-block@archiver.kernel.org>; Wed, 11 Nov 2020 12:46:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6465620709
	for <linux-block@archiver.kernel.org>; Wed, 11 Nov 2020 12:46:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=javigon-com.20150623.gappssmtp.com header.i=@javigon-com.20150623.gappssmtp.com header.b="leoNSQPN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726441AbgKKMqo (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 11 Nov 2020 07:46:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726685AbgKKMqn (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 11 Nov 2020 07:46:43 -0500
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A8FDC0613D1
        for <linux-block@vger.kernel.org>; Wed, 11 Nov 2020 04:46:43 -0800 (PST)
Received: by mail-ej1-x643.google.com with SMTP id oq3so2569588ejb.7
        for <linux-block@vger.kernel.org>; Wed, 11 Nov 2020 04:46:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=javigon-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nMEopWDrD+ugiSvfFXLXwcXEOZdgi3F7y/TkjGT26q0=;
        b=leoNSQPNzsuyI/ZFHg9GdriMvv3wwK9ahsZkC4gkVquYW09oTTri0qG4pL/pORa364
         q8/eyC7VTegWUCH0X4vluB1L/8u/qckZN1NeU0caakF/JhW+dueZgBfHDbNW9Z3rSiMI
         FIKRI5ODONpzdja6fyqFN9i2PicLA5v8QiwHCrWspolMqb5sJnDU5oEnBOXgv//qpRYq
         45jA9uCgfWCc/ydwzqQ09090Z81ecibH5M9l5CFp+qx9WFrN8LtseKF1jyqBpLmPI4X5
         2waow2baqA3u7idvkvzvgokPYboVxhsbonD3g/augXXlDxU7ukNYNwlwoHAHW0e39Dn6
         fVlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nMEopWDrD+ugiSvfFXLXwcXEOZdgi3F7y/TkjGT26q0=;
        b=qfq8Vm74AUaKjHa8YHnL5omkrmR8tyTTX2uG5VWbxJiJ5erxb1z7zsW9O2GU0jmtlN
         LWrJs8j/Dj23vpPt5Et5TC4KHT28lJWHw8vwxQuZRlZrKw6/o5rr9XPL8Lxq6T9hQwWJ
         MBP0Lv7g04Bno1G4G8a4iHxrL47FIkL8YDu0zTMbgZPm9IHggBjfipPM7a5A0cefiD2k
         v7WGz/6iBiQY5axHaOER4us8OnZYVm9Kv3msNT5nx/37KYeby2nUNknlCb6+Ji1tP5fx
         W1tPRcEovW6E2p/QjzL5x4bIJsoUBT9Qc506uPJq9C8p1oP4e0phWYuz8zvc4bYynwN0
         pCBA==
X-Gm-Message-State: AOAM532nBAdOE+8ix8CY+NcQepltAzFRdRCwII5ZFYWto6YEY3LA8lfK
        SbP6Zblusp5kjYPSpKO1+jOagQ==
X-Google-Smtp-Source: ABdhPJyBs/G4oEHFb0D3AMKSGJzDeYyJQufISO3OWqqRT2PrFfDJ9YsnSXEQXlNICFo43L6g8J0Dig==
X-Received: by 2002:a17:906:5f89:: with SMTP id a9mr24450770eju.262.1605098801867;
        Wed, 11 Nov 2020 04:46:41 -0800 (PST)
Received: from ch-wrk-javier.localdomain (5.186.124.214.cgn.fibianet.dk. [5.186.124.214])
        by smtp.gmail.com with ESMTPSA id h22sm840290ejt.21.2020.11.11.04.46.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2020 04:46:41 -0800 (PST)
From:   javier@javigon.com
X-Google-Original-From: javier@samsung.com
To:     linux-nvme@lists.infradead.org
Cc:     linux-block@vger.kernel.org, hch@lst.de, kbusch@kernel.org,
        sagi@grimberg.me, axboe@kernel.dk, joshi.k@samsung.com,
        k.jensen@samsung.com, Niklas.Cassel@wdc.com,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier.gonz@samsung.com>
Subject: [PATCH 1/2] nvme: allow to force refresh of effects log
Date:   Wed, 11 Nov 2020 13:46:38 +0100
Message-Id: <20201111124639.11305-1-javier@samsung.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Javier González <javier.gonz@samsung.com>

Allow the called of nvme_get_effects_log() to force re-reading the log
page from the device instead of getting the cached version when
available.

Signed-off-by: Javier González <javier.gonz@samsung.com>
---
 drivers/nvme/host/core.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index fff90200497c..e4c79f1d2e96 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2951,18 +2951,20 @@ int nvme_get_log(struct nvme_ctrl *ctrl, u32 nsid, u8 log_page, u8 lsp, u8 csi,
 	return nvme_submit_sync_cmd(ctrl->admin_q, &c, log, size);
 }
 
-static int nvme_get_effects_log(struct nvme_ctrl *ctrl, u8 csi,
-				struct nvme_effects_log **log)
+static int nvme_get_effects_log(struct nvme_ctrl *ctrl, u8 csi, struct nvme_effects_log **log,
+				bool force)
 {
 	struct nvme_cel *cel = xa_load(&ctrl->cels, csi);
 	int ret;
 
-	if (cel)
+	if (cel && !force)
 		goto out;
 
-	cel = kzalloc(sizeof(*cel), GFP_KERNEL);
-	if (!cel)
-		return -ENOMEM;
+	if (!cel) {
+		cel = kzalloc(sizeof(*cel), GFP_KERNEL);
+		if (!cel)
+			return -ENOMEM;
+	}
 
 	ret = nvme_get_log(ctrl, 0x00, NVME_LOG_CMD_EFFECTS, 0, csi,
 			&cel->log, sizeof(cel->log), 0);
@@ -3008,7 +3010,7 @@ int nvme_init_identify(struct nvme_ctrl *ctrl)
 	}
 
 	if (id->lpa & NVME_CTRL_LPA_CMD_EFFECTS_LOG) {
-		ret = nvme_get_effects_log(ctrl, NVME_CSI_NVM, &ctrl->effects);
+		ret = nvme_get_effects_log(ctrl, NVME_CSI_NVM, &ctrl->effects, false);
 		if (ret < 0)
 			goto out_free;
 	}
@@ -3725,7 +3727,7 @@ static struct nvme_ns_head *nvme_alloc_ns_head(struct nvme_ctrl *ctrl,
 	}
 
 	if (head->ids.csi) {
-		ret = nvme_get_effects_log(ctrl, head->ids.csi, &head->effects);
+		ret = nvme_get_effects_log(ctrl, head->ids.csi, &head->effects, false);
 		if (ret)
 			goto out_cleanup_srcu;
 	} else
-- 
2.17.1

