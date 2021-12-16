Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E44FC433F5
	for <linux-block@archiver.kernel.org>; Thu, 16 Dec 2021 16:39:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233316AbhLPQjG (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 16 Dec 2021 11:39:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbhLPQjF (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 16 Dec 2021 11:39:05 -0500
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3506C061574
        for <linux-block@vger.kernel.org>; Thu, 16 Dec 2021 08:39:05 -0800 (PST)
Received: by mail-io1-xd36.google.com with SMTP id z26so35864846iod.10
        for <linux-block@vger.kernel.org>; Thu, 16 Dec 2021 08:39:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=z+2oYvndBswSZaKsj1QzPxEnhIwscC5+Oo0mdTn6+Dc=;
        b=yVowYWvxaczkDintg9/OYs4mta6ur4XI8QM9V7IS/4j7hJ7IVfG/p1UtKN9Oj9HKyf
         dvpycSXBY66fnxl4f4ODqsuvnE0bt4Iu5ypURdLq3JdGrKjsYd9KjOII+m4kzTXzqI6c
         zdf5Zx4EuwHP8ls6C6eCZXSXRa+kwCD/6c1e0GKV94IgCtbghoLn7mGbCRPv/sRDOM5Q
         4igld9S5Imxsd/4QUU8av6SYgW2lezEhL4kyebUmOM/+Cf//4dJ+bRJDEbiniKLSqegM
         gW4Mu1E2LOMKCRru5ZBvUOPnoeYj7Y/jY4qnbFbZaM7rSjmcATav3eMTpQwWCK4pLneC
         E44g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=z+2oYvndBswSZaKsj1QzPxEnhIwscC5+Oo0mdTn6+Dc=;
        b=6EqWa0cDWeHJvji8u35aCcvPGHq8zeJTdqtrGsgqWCxn+i3+UA8AEpNKGPLcD0o5B7
         GsQE7vYIrDTCzMpv3icbxCFHLEiavsSv0ELOv91GZr87IkoAk5fCTL2M3S2gMnQVLsqj
         JtDHGKW0xKZlMiXoRcY0In8G7nBoLNq4QT9d/JUpwO3wBaJ77vs15e9Qy2PAB8lDEp96
         UTyPyje81FH9eMBeRsRavJDOs1zpccEnuRN2a1lK0sAq/NMulEz7UnG69GzpBamFBKob
         z8WS4ozK2jVC3S2KimhyF10ybL/Hu255YI6L+NucOtgxZBqs3GRpzT9NiUhWpPLFiAR6
         Jcqg==
X-Gm-Message-State: AOAM530QgAr5m+V+opmn8Hs2ErCTvtYtCIfjev87CzQfMvGPeqHmYG8c
        4ydZcuAwvLTlwb9sbJtuKIRATA==
X-Google-Smtp-Source: ABdhPJyVdd7iRMbi7TlLSgBNUbLTjF4iOc3lkxSgG43dQaU+1dqqGcxHWIIAam4lk1kutc09Uj2kjA==
X-Received: by 2002:a05:6638:4087:: with SMTP id m7mr10188047jam.112.1639672745102;
        Thu, 16 Dec 2021 08:39:05 -0800 (PST)
Received: from x1.localdomain ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id t17sm71816ilm.46.2021.12.16.08.39.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Dec 2021 08:39:04 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     io-uring@vger.kernel.org, linux-block@vger.kernel.org,
        linux-nvme@lists.infradead.org
Cc:     Jens Axboe <axboe@kernel.dk>, Chaitanya Kulkarni <kch@nvidia.com>,
        Hannes Reinecke <hare@suse.de>,
        Max Gurtovoy <mgurtovoy@nvidia.com>
Subject: [PATCH 2/4] nvme: split command copy into a helper
Date:   Thu, 16 Dec 2021 09:38:59 -0700
Message-Id: <20211216163901.81845-3-axboe@kernel.dk>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211216163901.81845-1-axboe@kernel.dk>
References: <20211216163901.81845-1-axboe@kernel.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

We'll need it for batched submit as well. Since we now have a copy
helper, get rid of the nvme_submit_cmd() wrapper.

Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Max Gurtovoy <mgurtovoy@nvidia.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 drivers/nvme/host/pci.c | 28 +++++++++++++---------------
 1 file changed, 13 insertions(+), 15 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 8637538f3fd5..9d2a36de228a 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -500,22 +500,13 @@ static inline void nvme_write_sq_db(struct nvme_queue *nvmeq, bool write_sq)
 	nvmeq->last_sq_tail = nvmeq->sq_tail;
 }
 
-/**
- * nvme_submit_cmd() - Copy a command into a queue and ring the doorbell
- * @nvmeq: The queue to use
- * @cmd: The command to send
- * @write_sq: whether to write to the SQ doorbell
- */
-static void nvme_submit_cmd(struct nvme_queue *nvmeq, struct nvme_command *cmd,
-			    bool write_sq)
+static inline void nvme_sq_copy_cmd(struct nvme_queue *nvmeq,
+				    struct nvme_command *cmd)
 {
-	spin_lock(&nvmeq->sq_lock);
-	memcpy(nvmeq->sq_cmds + (nvmeq->sq_tail << nvmeq->sqes),
-	       cmd, sizeof(*cmd));
+	memcpy(nvmeq->sq_cmds + (nvmeq->sq_tail << nvmeq->sqes), cmd,
+		sizeof(*cmd));
 	if (++nvmeq->sq_tail == nvmeq->q_depth)
 		nvmeq->sq_tail = 0;
-	nvme_write_sq_db(nvmeq, write_sq);
-	spin_unlock(&nvmeq->sq_lock);
 }
 
 static void nvme_commit_rqs(struct blk_mq_hw_ctx *hctx)
@@ -957,7 +948,10 @@ static blk_status_t nvme_queue_rq(struct blk_mq_hw_ctx *hctx,
 	}
 
 	blk_mq_start_request(req);
-	nvme_submit_cmd(nvmeq, cmnd, bd->last);
+	spin_lock(&nvmeq->sq_lock);
+	nvme_sq_copy_cmd(nvmeq, &iod->cmd);
+	nvme_write_sq_db(nvmeq, bd->last);
+	spin_unlock(&nvmeq->sq_lock);
 	return BLK_STS_OK;
 out_unmap_data:
 	nvme_unmap_data(dev, req);
@@ -1140,7 +1134,11 @@ static void nvme_pci_submit_async_event(struct nvme_ctrl *ctrl)
 
 	c.common.opcode = nvme_admin_async_event;
 	c.common.command_id = NVME_AQ_BLK_MQ_DEPTH;
-	nvme_submit_cmd(nvmeq, &c, true);
+
+	spin_lock(&nvmeq->sq_lock);
+	nvme_sq_copy_cmd(nvmeq, &c);
+	nvme_write_sq_db(nvmeq, true);
+	spin_unlock(&nvmeq->sq_lock);
 }
 
 static int adapter_delete_queue(struct nvme_dev *dev, u8 opcode, u16 id)
-- 
2.34.1

