Return-Path: <SRS0=/0DQ=4Q=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85E0BC3F2CD
	for <linux-block@archiver.kernel.org>; Fri, 28 Feb 2020 15:06:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A7EA24699
	for <linux-block@archiver.kernel.org>; Fri, 28 Feb 2020 15:06:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cloud.ionos.com header.i=@cloud.ionos.com header.b="WgFsVSiO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726994AbgB1PGm (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 28 Feb 2020 10:06:42 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:38567 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726805AbgB1PGl (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 28 Feb 2020 10:06:41 -0500
Received: by mail-pg1-f193.google.com with SMTP id d6so1664826pgn.5
        for <linux-block@vger.kernel.org>; Fri, 28 Feb 2020 07:06:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=w5IWlWsaAR3Ywj3NVn3Owh6HRx1odbyjzEUx8w5C8jk=;
        b=WgFsVSiOn1cfhW5Tc1VccnSdnElD1w0HOQOEn8tnTyAYaWNNO8nZfLlcYmb5wfFL67
         /hslUNhjypH+3GOPN1KMkEW6XDC4xHIFz6fpVb9qB7Zb+3k3HffT5Duql8eYSg9Avbcl
         ewLdLt7eHlWA7svqi0zj8FYLfzXHLwVNczLBmGh4IPtdlWZAO7ilapIWt5S7RkmAt7jb
         nRwLdmMHvD5wk/BAlsEwP+CW/gPr0kjBTuetyhm3LL3AEN+GVAZe6UXMcdJjJG/cGBpQ
         QIqnwjCiKWp/x4NP/h3V38lh1Tqr29EZsZirjq1bTXS0eS9sw5dY+KZKn8xWmmHgNaDu
         FhsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=w5IWlWsaAR3Ywj3NVn3Owh6HRx1odbyjzEUx8w5C8jk=;
        b=bsFtb3TKYxPnMD21t+pjgRyvOQOH5DhPGMAo6cFt7b5Bf7BFuPVw1uFvd22Ri0jh7i
         b03EU8XpWmpX0QQVDJbqC68r+sKhcfXgjX548ytZJDtafh8ehTH58MQsZ5IR6l63nPyG
         eeFWeIi7lTzfx037IqPLoMvqqNteLSCWiPDiWZHwt6fuwRqe3XVKUf4CqAhXpVcOCzqN
         rhBdHEZfnr8vZpdOll8KyA79xwOJUsrG7yotgaQf1ujglp3lQrM89aaLA2s27iFHB4+F
         lU8M3jdnrL0Mm4a2m23BeaVESZtseEX0P+EDwRhw5cB+AUN1/teMrPEpfcJh9Qz27EY+
         247g==
X-Gm-Message-State: ANhLgQ1ZcVbB6WmqBxtn/ateL8S8htPpnceKHQ6eu+AgiJFPBDvnMyLn
        EGu/ETG3x1VLSN+EUUoF2+GVxA==
X-Google-Smtp-Source: ADFU+vvgO/f+UYZ/u/pwALH/orOxJ4/aVU36a/Y2CxXl0D6TI4yvFRvIY+iyxIRbqwReK2W0BU3Ipw==
X-Received: by 2002:a63:36ce:: with SMTP id d197mr770162pga.8.1582902399317;
        Fri, 28 Feb 2020 07:06:39 -0800 (PST)
Received: from nb01257.pb.local ([240e:82:3:5b12:940:b7e:a31d:58eb])
        by smtp.gmail.com with ESMTPSA id y1sm7621912pgs.74.2020.02.28.07.06.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2020 07:06:38 -0800 (PST)
From:   Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org,
        Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Subject: [PATCH 5/6] block: remove unneeded argument from blk_alloc_flush_queue
Date:   Fri, 28 Feb 2020 16:05:17 +0100
Message-Id: <20200228150518.10496-6-guoqing.jiang@cloud.ionos.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200228150518.10496-1-guoqing.jiang@cloud.ionos.com>
References: <20200228150518.10496-1-guoqing.jiang@cloud.ionos.com>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Remove 'q' from arguments since it is not used anymore after
commit 7e992f847a08e ("block: remove non mq parts from the
flush code").

Signed-off-by: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
---
 block/blk-flush.c | 4 ++--
 block/blk-mq.c    | 3 +--
 block/blk.h       | 4 ++--
 3 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/block/blk-flush.c b/block/blk-flush.c
index 3f977c517960..963ae56d5aae 100644
--- a/block/blk-flush.c
+++ b/block/blk-flush.c
@@ -485,8 +485,8 @@ int blkdev_issue_flush(struct block_device *bdev, gfp_t gfp_mask,
 }
 EXPORT_SYMBOL(blkdev_issue_flush);
 
-struct blk_flush_queue *blk_alloc_flush_queue(struct request_queue *q,
-		int node, int cmd_size, gfp_t flags)
+struct blk_flush_queue *blk_alloc_flush_queue(int node, int cmd_size,
+					      gfp_t flags)
 {
 	struct blk_flush_queue *fq;
 	int rq_sz = sizeof(struct request);
diff --git a/block/blk-mq.c b/block/blk-mq.c
index a12b1763508d..9684ea9a9e1f 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2405,8 +2405,7 @@ blk_mq_alloc_hctx(struct request_queue *q, struct blk_mq_tag_set *set,
 	init_waitqueue_func_entry(&hctx->dispatch_wait, blk_mq_dispatch_wake);
 	INIT_LIST_HEAD(&hctx->dispatch_wait.entry);
 
-	hctx->fq = blk_alloc_flush_queue(q, hctx->numa_node, set->cmd_size,
-			gfp);
+	hctx->fq = blk_alloc_flush_queue(hctx->numa_node, set->cmd_size, gfp);
 	if (!hctx->fq)
 		goto free_bitmap;
 
diff --git a/block/blk.h b/block/blk.h
index 0b8884353f6b..670337b7cfa0 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -55,8 +55,8 @@ is_flush_rq(struct request *req, struct blk_mq_hw_ctx *hctx)
 	return hctx->fq->flush_rq == req;
 }
 
-struct blk_flush_queue *blk_alloc_flush_queue(struct request_queue *q,
-		int node, int cmd_size, gfp_t flags);
+struct blk_flush_queue *blk_alloc_flush_queue(int node, int cmd_size,
+					      gfp_t flags);
 void blk_free_flush_queue(struct blk_flush_queue *q);
 
 void blk_freeze_queue(struct request_queue *q);
-- 
2.17.1

