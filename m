Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F21CC5517A
	for <linux-block@archiver.kernel.org>; Wed, 11 Nov 2020 20:10:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C1C082087D
	for <linux-block@archiver.kernel.org>; Wed, 11 Nov 2020 20:10:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=javigon-com.20150623.gappssmtp.com header.i=@javigon-com.20150623.gappssmtp.com header.b="iTy2MIwp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725924AbgKKUKZ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 11 Nov 2020 15:10:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725920AbgKKUKZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 11 Nov 2020 15:10:25 -0500
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A1D4C0613D1
        for <linux-block@vger.kernel.org>; Wed, 11 Nov 2020 12:10:25 -0800 (PST)
Received: by mail-ej1-x644.google.com with SMTP id me8so4452088ejb.10
        for <linux-block@vger.kernel.org>; Wed, 11 Nov 2020 12:10:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=javigon-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0eKjEubKup8XTHuNBAl9N3Wyqo/WJjUQR451Q6kaN9Y=;
        b=iTy2MIwpO6n935ULTixRdY8Hp8Hf+p8RT5ZenDPsoEzX20hhRtaY29SnS3v9SxwHSK
         iiRBKe9HQd7s/+m0zWw28Ohhec32fbcQNBH1p4XZ+9SvzBRCw+wwtzK07FqI2AO+g+cm
         qjzIz3lpcaHCvtMGIwJYn2+PgYlIWfCTIElfpLRKgyzFolkWQ7mCuRgahY742r52iHZ4
         Ii91M5ikx/dcYSYQ4pRk88ZTfUw21pMjrKIMFqLAwLZyTF+EWhnEGRVl9haMYkinmXW/
         LHWOTpTwsTC6M5kUH4OiwCfAV0QfVUH/Tm04QqeMSgmqH8B+u4IGOgpiDRRUdjr63nQA
         tHWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0eKjEubKup8XTHuNBAl9N3Wyqo/WJjUQR451Q6kaN9Y=;
        b=q2eD6wJTeGSdtYPGcKLdh3+nNWP9qULNjaS2N6F/Lm/Os8QKWt9rZ6dzQ5qs65DzaL
         AqYJdSJBqrDtN76D3hjtyJg+6nE6DVKOTI6F1NlGFU9HmU04ksgr3yDk0S2D2VZWFArt
         CinEl3mpX4uh1QnJiG9is2UuZgmL7rC0xXqze7UrZRZezZMpeYXJzPzSvuoc7PXFo66B
         ggJyT4yBWkS+44NrNiKAbMdRPZ6AyF9SPurqiuds+o6Gf66kE4bclLsru+v6f61KeHxh
         NrGvU5vqCtPwmIw38W2kUsCh8IDi+v9zhoJYQhFxVZ1R3tCp/If66pnv3B3psD4juOPY
         fE1Q==
X-Gm-Message-State: AOAM532cx86LpoBjlCr0it3bjijeR+VEhb9asvc3vhWWvtDIgpryv3tJ
        8hJ2+6Qv4K/Ht37qSSmYINGbkA==
X-Google-Smtp-Source: ABdhPJwAX5HGR9uDut/VpxCMLptOFx6697XGl+AHnbWpgMtqhGJWy3z2+hKvQMV6TCRBfDbIky7aoA==
X-Received: by 2002:a17:906:d1c3:: with SMTP id bs3mr25631279ejb.246.1605125423958;
        Wed, 11 Nov 2020 12:10:23 -0800 (PST)
Received: from ch-wrk-javier.localdomain (5.186.124.214.cgn.fibianet.dk. [5.186.124.214])
        by smtp.gmail.com with ESMTPSA id j9sm1360421edv.92.2020.11.11.12.10.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2020 12:10:22 -0800 (PST)
From:   javier@javigon.com
X-Google-Original-From: javier@samsung.com
To:     linux-nvme@lists.infradead.org
Cc:     linux-block@vger.kernel.org, hch@lst.de, kbusch@kernel.org,
        sagi@grimberg.me,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier.gonz@samsung.com>
Subject: [PATCH] nvme: remove unnecessary return values
Date:   Wed, 11 Nov 2020 21:10:18 +0100
Message-Id: <20201111201018.30764-1-javier@samsung.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Javier González <javier.gonz@samsung.com>

Cleanup unnecessary ret values that are not checked or used in
nvme_alloc_ns()

Signed-off-by: Javier González <javier.gonz@samsung.com>
---
 drivers/nvme/host/core.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index fff90200497c..c9ea32c87e52 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -3830,7 +3830,7 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, unsigned nsid,
 	struct gendisk *disk;
 	struct nvme_id_ns *id;
 	char disk_name[DISK_NAME_LEN];
-	int node = ctrl->numa_node, flags = GENHD_FL_EXT_DEVT, ret;
+	int node = ctrl->numa_node, flags = GENHD_FL_EXT_DEVT;
 
 	if (nvme_identify_ns(ctrl, nsid, ids, &id))
 		return;
@@ -3854,8 +3854,7 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, unsigned nsid,
 	ns->ctrl = ctrl;
 	kref_init(&ns->kref);
 
-	ret = nvme_init_ns_head(ns, nsid, ids, id->nmic & NVME_NS_NMIC_SHARED);
-	if (ret)
+	if (nvme_init_ns_head(ns, nsid, ids, id->nmic & NVME_NS_NMIC_SHARED))
 		goto out_free_queue;
 	nvme_set_disk_name(disk_name, ns, ctrl, &flags);
 
@@ -3874,8 +3873,7 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, unsigned nsid,
 		goto out_put_disk;
 
 	if ((ctrl->quirks & NVME_QUIRK_LIGHTNVM) && id->vs[0] == 0x1) {
-		ret = nvme_nvm_register(ns, disk_name, node);
-		if (ret) {
+		if (nvme_nvm_register(ns, disk_name, node)) {
 			dev_warn(ctrl->device, "LightNVM init failure\n");
 			goto out_put_disk;
 		}
-- 
2.17.1

