Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D013BCCA47B
	for <linux-block@archiver.kernel.org>; Mon, 27 Jun 2022 23:44:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236532AbiF0XoC (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 27 Jun 2022 19:44:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242327AbiF0XoB (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 27 Jun 2022 19:44:01 -0400
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 825B813CEA
        for <linux-block@vger.kernel.org>; Mon, 27 Jun 2022 16:44:00 -0700 (PDT)
Received: by mail-pf1-f174.google.com with SMTP id k9so1203409pfg.5
        for <linux-block@vger.kernel.org>; Mon, 27 Jun 2022 16:44:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hqpsHFfHkm5Pkj04n/IH7gcU0rzDX2ha8rnKflqkGE8=;
        b=CfJ4F4DymiQXqq45+JcFhoykAvpjtb/bsKrSCRkjlU+/uXilCkcVxTrHfYRz0/8gT8
         ylwu0XmgU//ieV0pbEU8aehf812kpwXNbYv4zdqh87hGjfRe5JpnOKYO7UveHuFgrhN/
         jGX5BxYm1z+5QW5nsvvT6EPOL/LDKsl5E4UURAOJ/G64y5Ecm6UptI0hIr/TKIUgja0k
         g4XXW3aJGJBBteZbyEkifwTpRzMcU0IszNEwMx6Tx1nB8tdAUjpEhu63qTgRtBLIupWg
         TyvpDITkSoDRiBKDHPRCGcoQrCY0gzfbCR62gvRjUJolmYIMTRGTXZwHwiE3h+w7Ar3Y
         K46A==
X-Gm-Message-State: AJIora9YTPKQI3u1qfRWjPWondf1uGC/ayjTpJ0P3ICamwTGKcAHBRGx
        NlXpNTkXjBlKdCxxnCAMyHI=
X-Google-Smtp-Source: AGRyM1sZBFKZCombPzuzZmE26KUTSWsB+tN4KOLyrVdEaciwgi9hYcRZ8kE42iQG9zAqoSzWW6leHw==
X-Received: by 2002:aa7:82c1:0:b0:525:ad2c:7271 with SMTP id f1-20020aa782c1000000b00525ad2c7271mr1648478pfn.30.1656373439891;
        Mon, 27 Jun 2022 16:43:59 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:3879:b18f:db0d:205])
        by smtp.gmail.com with ESMTPSA id md6-20020a17090b23c600b001e305f5cd22sm7907456pjb.47.2022.06.27.16.43.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jun 2022 16:43:59 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Bart Van Assche <bvanassche@acm.org>,
        Keith Busch <kbusch@kernel.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Chaitanya Kulkarni <kch@nvidia.com>
Subject: [PATCH v3 7/8] nvme: Make the number of retries command specific
Date:   Mon, 27 Jun 2022 16:43:34 -0700
Message-Id: <20220627234335.1714393-8-bvanassche@acm.org>
X-Mailer: git-send-email 2.37.0.rc0.161.g10f37bed90-goog
In-Reply-To: <20220627234335.1714393-1-bvanassche@acm.org>
References: <20220627234335.1714393-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Add support for specifying the number of retries per NVMe command.

Cc: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>
Cc: Sagi Grimberg <sagi@grimberg.me>
Cc: Chaitanya Kulkarni <kch@nvidia.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/nvme/host/core.c | 3 ++-
 drivers/nvme/host/nvme.h | 1 +
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index b3d9c29aba1e..df9ac7fab9b8 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -339,7 +339,7 @@ static inline enum nvme_disposition nvme_decide_disposition(struct request *req)
 
 	if (blk_noretry_request(req) ||
 	    (nvme_req(req)->status & NVME_SC_DNR) ||
-	    nvme_req(req)->retries >= nvme_max_retries)
+	    nvme_req(req)->retries >= nvme_req(req)->max_retries)
 		return COMPLETE;
 
 	if (req->cmd_flags & REQ_NVME_MPATH) {
@@ -632,6 +632,7 @@ static inline void nvme_clear_nvme_request(struct request *req)
 {
 	nvme_req(req)->status = 0;
 	nvme_req(req)->retries = 0;
+	nvme_req(req)->max_retries = nvme_max_retries;
 	nvme_req(req)->flags = 0;
 	req->rq_flags |= RQF_DONTPREP;
 }
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 0da94b233fed..ca415cd9571e 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -160,6 +160,7 @@ struct nvme_request {
 	union nvme_result	result;
 	u8			genctr;
 	u8			retries;
+	u8			max_retries;
 	u8			flags;
 	u16			status;
 	struct nvme_ctrl	*ctrl;
