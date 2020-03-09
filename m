Return-Path: <SRS0=ZA/H=42=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B7B0C10F25
	for <linux-block@archiver.kernel.org>; Mon,  9 Mar 2020 21:42:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 248412467C
	for <linux-block@archiver.kernel.org>; Mon,  9 Mar 2020 21:42:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cloud.ionos.com header.i=@cloud.ionos.com header.b="Iu2nqbPh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727111AbgCIVmR (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 9 Mar 2020 17:42:17 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:40550 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727083AbgCIVmR (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 9 Mar 2020 17:42:17 -0400
Received: by mail-ed1-f68.google.com with SMTP id a13so13787751edu.7
        for <linux-block@vger.kernel.org>; Mon, 09 Mar 2020 14:42:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=stEvf+irlg/oXYzll8/KK02iP6wmSBumwpN8cq6fpys=;
        b=Iu2nqbPhXD0JXWfF/85NHmMvDPY5W1ekWWFNTTQxC0ykmSB8ac4AVzzCrRibtE1TJ8
         LC3DRFMe6ZtRUzqwcBBkO3pzrKd5c0ZxnY2ax7GKRehmndLZ6wiexROJYotlCWpb0C+P
         R1TFKKNMRUqnRpdYv9nF3Y39UVmvqw8zwSmAyjUZ2RSBIpIOJYE02eMjgdgO/9FIQrfn
         wTbKE/e075W1oh1OEY05f+B84GCLNnj8a8nDiD850U9ur+P/jNkctekP4Gm+GRQbYaj9
         uGyHd3JPQkw/ysK9BTEpPDmKUHs887ZpdQ+t94SVsLoyiKClpXCiu39w7o/7UgrsgsBI
         /Cuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=stEvf+irlg/oXYzll8/KK02iP6wmSBumwpN8cq6fpys=;
        b=FWMXXlh5N9NzSawup/ViEs/FayMK31LS1p1Rj74ma13oZBrXVPbTEH5rFifEv9lXiq
         2XUQ5PwnqpHpXN98/zg2JXF0PQRCrlageZx0LBHBIQw+tV50XnfgHJfp1Qo2Q21TESKV
         1adB32Rdpw1ugYVVLh58MSLqyqTJevEvXhp7P24J/Vp2rNQ5L4pwkuQSjALQkeFOVM5M
         k9D6RPiDqnRVfKtNBFM163X/eMac0YQmIKdOKVxow4MeP8sr6RWWeAOvS7Micb+R7Xm9
         3aamLoP4UXiQkk8HpDVn8Jc5fqt+ccioDtqbNNX22/s8OzW7wUGhiAcMWqK9buXzmLfz
         y4qg==
X-Gm-Message-State: ANhLgQ1i+joSj5PNqmsSNMk4txkcPrR3xNrWfNzMjo8RNyBrHXiXCg2W
        I6NFQaIVjUVP1MJGe6TMXn6f5S7y7sPKSg==
X-Google-Smtp-Source: ADFU+vtCQhZWzNqW3mvOf/FSGLHgfSo71o+B8LyxP6L12Nxk+Roc1F946nrKZOU0JoX6WbjStHGB6w==
X-Received: by 2002:a05:6402:b3c:: with SMTP id bo28mr14672483edb.284.1583790135438;
        Mon, 09 Mar 2020 14:42:15 -0700 (PDT)
Received: from nb01257.fritz.box ([2001:16b8:4824:700:55b0:6e1e:26ab:27a5])
        by smtp.gmail.com with ESMTPSA id g6sm3828488edm.29.2020.03.09.14.42.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2020 14:42:14 -0700 (PDT)
From:   Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org,
        Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Subject: [PATCH V2 5/6] block: remove unneeded argument from blk_alloc_flush_queue
Date:   Mon,  9 Mar 2020 22:41:37 +0100
Message-Id: <20200309214138.30770-6-guoqing.jiang@cloud.ionos.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200309214138.30770-1-guoqing.jiang@cloud.ionos.com>
References: <20200309214138.30770-1-guoqing.jiang@cloud.ionos.com>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Remove 'q' from arguments since it is not used anymore after
commit 7e992f847a08e ("block: remove non mq parts from the
flush code").

Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Reviewed-by: Nikolay Borisov <nborisov@suse.com>
Signed-off-by: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
---
 block/blk-flush.c | 4 ++--
 block/blk-mq.c    | 3 +--
 block/blk.h       | 4 ++--
 3 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/block/blk-flush.c b/block/blk-flush.c
index 5cc775bdb06a..7f7f98305115 100644
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
index d92088dec6c3..d855cf860682 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2409,8 +2409,7 @@ blk_mq_alloc_hctx(struct request_queue *q, struct blk_mq_tag_set *set,
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

