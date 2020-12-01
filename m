Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49552C64E7B
	for <linux-block@archiver.kernel.org>; Tue,  1 Dec 2020 12:57:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C55C32084C
	for <linux-block@archiver.kernel.org>; Tue,  1 Dec 2020 12:57:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=javigon-com.20150623.gappssmtp.com header.i=@javigon-com.20150623.gappssmtp.com header.b="iObn40qE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726832AbgLAM45 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 1 Dec 2020 07:56:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726166AbgLAM44 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 1 Dec 2020 07:56:56 -0500
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58B5AC0613D6
        for <linux-block@vger.kernel.org>; Tue,  1 Dec 2020 04:56:16 -0800 (PST)
Received: by mail-ed1-x542.google.com with SMTP id l5so3035805edq.11
        for <linux-block@vger.kernel.org>; Tue, 01 Dec 2020 04:56:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=javigon-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jlx5ljuoha5y8gLnWfck0WODBeR/256Mld210jR/EFk=;
        b=iObn40qEZn/sKbA/Df7xy7osUqamwET0bD7BELJ4D/9DcGiJAzNR77nwvw3DLx/xHF
         Zi8peOOCGzmtzsi1IxevIGJopixNEBqIV1Mb/BrccYSSxeG4T6zcOPZvVo0f+w+FU/oN
         EMMOitKOCQ8O9dpg74HUJ1iwby6Wo4zi2hp1reqRymWTJdIVJgrw1aK/b6iIhx5A9NKn
         8cQuGckD0Coo+WSs2q1I0VUXCcC1OyQQArCJAjSuy/TGNAnoRwjiNbR/ftOko3GYSGWu
         7ZbvJ9G9Yn2UUhPCbqzs/RSnIrJ4Y5za0mCQJ6FwEZTZRnyhZD23vFua18QAOo2D0KcL
         J+pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jlx5ljuoha5y8gLnWfck0WODBeR/256Mld210jR/EFk=;
        b=nPyubk2lUCq7C+muw11BosCaPW+C1RTfRMIjzr+jr/HVsgEFhvPlp4olyzbtBqT2co
         D46g2+3mxLA80OoxqHpYHLr+DjIdsOreZaeW7D8Qw0pkGaA9xdn8n9FqTM1zlfCzaLw5
         KyQT+IXTsSl2zoKsWJe7Pg5M7AjtwWQFP8p4BOgYXu9e5iescqgOPQc5PneTXaqZ3dBA
         9JpLTauVG1YiCtDga+Cjom/uC0pR2UwQd3qtxUN4FaS9jOFU1PoC+xUp90T6KecNxFWa
         p6ec7KIZS+4hvMiL03G6slw5blP4MqeRNfX8rZnVkI70zvGWEUg7IPQEZqa1YwMrz0c9
         +exw==
X-Gm-Message-State: AOAM5303v4me9vCo/XA8SN9uX0t1x9ZXmNy6+0MhDcvPQdP+xdvC5vLF
        iycKoMI51uRYTtNoo9Ao31VRfA==
X-Google-Smtp-Source: ABdhPJzMggpJFAnW8X/NAlgFZv92Xj0V7ijaNdIE7uJuNFXybN+5B+NYTEVUqe5xyZDelYWo627zEg==
X-Received: by 2002:a50:e8c4:: with SMTP id l4mr2936307edn.105.1606827375048;
        Tue, 01 Dec 2020 04:56:15 -0800 (PST)
Received: from ch-wrk-javier.localdomain (5.186.124.214.cgn.fibianet.dk. [5.186.124.214])
        by smtp.gmail.com with ESMTPSA id be6sm796864edb.29.2020.12.01.04.56.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Dec 2020 04:56:14 -0800 (PST)
From:   javier@javigon.com
X-Google-Original-From: javier.gonz@samsung.com
To:     linux-nvme@lists.infradead.org
Cc:     linux-block@vger.kernel.org, hch@lst.de, kbusch@kernel.org,
        sagi@grimberg.me,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier.gonz@samsung.com>
Subject: [PATCH 1/4] nvme: remove unnecessary return values
Date:   Tue,  1 Dec 2020 13:56:07 +0100
Message-Id: <20201201125610.17138-2-javier.gonz@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201201125610.17138-1-javier.gonz@samsung.com>
References: <20201201125610.17138-1-javier.gonz@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Javier González <javier.gonz@samsung.com>

Cleanup unnecessary ret values that are not checked or used in
nvme_alloc_ns().

Signed-off-by: Javier González <javier.gonz@samsung.com>
---
 drivers/nvme/host/core.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 170745d4a34b..a965a8d28ba0 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -3831,7 +3831,7 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, unsigned nsid,
 	struct gendisk *disk;
 	struct nvme_id_ns *id;
 	char disk_name[DISK_NAME_LEN];
-	int node = ctrl->numa_node, flags = GENHD_FL_EXT_DEVT, ret;
+	int node = ctrl->numa_node, flags = GENHD_FL_EXT_DEVT;
 
 	if (nvme_identify_ns(ctrl, nsid, ids, &id))
 		return;
@@ -3855,8 +3855,7 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, unsigned nsid,
 	ns->ctrl = ctrl;
 	kref_init(&ns->kref);
 
-	ret = nvme_init_ns_head(ns, nsid, ids, id->nmic & NVME_NS_NMIC_SHARED);
-	if (ret)
+	if (nvme_init_ns_head(ns, nsid, ids, id->nmic & NVME_NS_NMIC_SHARED))
 		goto out_free_queue;
 	nvme_set_disk_name(disk_name, ns, ctrl, &flags);
 
@@ -3875,8 +3874,7 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, unsigned nsid,
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

