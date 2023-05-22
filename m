Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4EF5C7EE2A
	for <linux-block@archiver.kernel.org>; Mon, 22 May 2023 21:06:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235145AbjEVVGH (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 22 May 2023 17:06:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234653AbjEVVGG (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 22 May 2023 17:06:06 -0400
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4500DC1
        for <linux-block@vger.kernel.org>; Mon, 22 May 2023 14:06:05 -0700 (PDT)
Received: by mail-qk1-x72f.google.com with SMTP id af79cd13be357-74e4f839ae4so340769585a.0
        for <linux-block@vger.kernel.org>; Mon, 22 May 2023 14:06:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684789564; x=1687381564;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ljRC7JLVntpkTIClFzuOc4f+4gIqX3vdkFlSizRBCPo=;
        b=Z826cv/HRmxaVIz3VcMDuTvqECUugIOeOpJ+SmysHESEc7jbjJd8DFfnSd6Uqq1DNA
         5+Xpo5cDlYZmj2dRnGQw4xSss9lIhzqEXJIf0nk+08k2uXG6Z3tzV1c0e3NCwarZ9cdl
         QKMRrSyAmlnfS6fKrub6OQ0oSst5yfJC7Bavps6Dl3v0Z6OqfJjwlbXGQinfrgRRISQK
         XurQ1Bwf4rxCaj0Sn3WRaYKrc0KeuW4BrS9WioRKZkoEkga7nMai9FdB9qarIyKp1xHo
         kRmiFmeXNYbZ09slRCHoQ14JflIWMhzmxWEkcep3g8IMo1rg6NIVLxq2HtAalaIMjaKR
         rtsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684789564; x=1687381564;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ljRC7JLVntpkTIClFzuOc4f+4gIqX3vdkFlSizRBCPo=;
        b=E3RITm46p7F7Y7AfeWYufSiMrxm0sYbg2ty7xbiTKX1D3q7bSDvJqskW3g97HXrWFa
         OdPL5bxg24ZSWKdU69532+4ChyiTaicyEy7ARok/QVcpMxyz7CU6WAJbMWqFE1jeioq2
         BjDKASQgANjKsaCB1JRxR5sbDIFhJNFOvhZJdqdvv6PjAgXvltEyOFVX6bS3/JU7NhQd
         6PtChyEtnp1L/hVRfB7dRJRKB5CE9+0zcViJX/kqdG/iTEnvW2xzsmiIB+wsHA2NUEMt
         tbDhTvcDk/9XcBKzottrMAvVge+5pJaOJY1a5qUlk9G7d+ocatnuM9VubhjmjyLSvUQC
         0OYg==
X-Gm-Message-State: AC+VfDyQCZBkHqGD626sWCi06wo/xNtnqDHtXBL9quWn41X5QwtJ/mTE
        yZ8APGKslkVeP0eIkf78RhU=
X-Google-Smtp-Source: ACHHUZ4QR9EIphGtjkflUmxx413f8p1HORqG3IOW9muqOJoCvxA9w7ITBN0oNTNYW6QTXCPOr/4xJQ==
X-Received: by 2002:a05:6214:21e4:b0:621:6217:f528 with SMTP id p4-20020a05621421e400b006216217f528mr16504061qvj.30.1684789564248;
        Mon, 22 May 2023 14:06:04 -0700 (PDT)
Received: from tian-Alienware-15-R4.fios-router.home (pool-173-77-254-84.nycmny.fios.verizon.net. [173.77.254.84])
        by smtp.gmail.com with ESMTPSA id h21-20020ac85155000000b003f3c975ba2fsm2332404qtn.86.2023.05.22.14.06.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 May 2023 14:06:03 -0700 (PDT)
From:   Tian Lan <tilan7663@gmail.com>
To:     john.g.garry@oracle.com
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org,
        liusong@linux.alibaba.com, ming.lei@redhat.com,
        tian.lan@twosigma.com, tilan7663@gmail.com
Subject: [PATCH 1/1] blk-mq: fix race condition in active queue accounting
Date:   Mon, 22 May 2023 17:05:55 -0400
Message-Id: <20230522210555.794134-1-tilan7663@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <a11faa27-965e-3109-15e2-33f015262426@oracle.com>
References: <a11faa27-965e-3109-15e2-33f015262426@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Tian Lan <tian.lan@twosigma.com>

If multiple CPUs are sharing the same hardware queue, it can
cause leak in the active queue counter tracking when __blk_mq_tag_busy()
is executed simultaneously.

Fixes: ee78ec1077d3 ("blk-mq: blk_mq_tag_busy is no need to return a value")
Signed-off-by: Tian Lan <tian.lan@twosigma.com>
Reviewed-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-mq-tag.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
index d6af9d431dc6..dfd81cab5788 100644
--- a/block/blk-mq-tag.c
+++ b/block/blk-mq-tag.c
@@ -39,16 +39,20 @@ void __blk_mq_tag_busy(struct blk_mq_hw_ctx *hctx)
 {
 	unsigned int users;
 
+	/*
+	 * calling test_bit() prior to test_and_set_bit() is intentional,
+	 * it avoids dirtying the cacheline if the queue is already active.
+	 */
 	if (blk_mq_is_shared_tags(hctx->flags)) {
 		struct request_queue *q = hctx->queue;
 
-		if (test_bit(QUEUE_FLAG_HCTX_ACTIVE, &q->queue_flags))
+		if (test_bit(QUEUE_FLAG_HCTX_ACTIVE, &q->queue_flags) ||
+		    test_and_set_bit(QUEUE_FLAG_HCTX_ACTIVE, &q->queue_flags))
 			return;
-		set_bit(QUEUE_FLAG_HCTX_ACTIVE, &q->queue_flags);
 	} else {
-		if (test_bit(BLK_MQ_S_TAG_ACTIVE, &hctx->state))
+		if (test_bit(BLK_MQ_S_TAG_ACTIVE, &hctx->state) ||
+		    test_and_set_bit(BLK_MQ_S_TAG_ACTIVE, &hctx->state))
 			return;
-		set_bit(BLK_MQ_S_TAG_ACTIVE, &hctx->state);
 	}
 
 	users = atomic_inc_return(&hctx->tags->active_queues);
-- 
2.25.1

