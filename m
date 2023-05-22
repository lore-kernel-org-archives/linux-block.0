Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 036F8C77B7C
	for <linux-block@archiver.kernel.org>; Mon, 22 May 2023 00:43:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229563AbjEVAnq (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 21 May 2023 20:43:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229550AbjEVAnq (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 21 May 2023 20:43:46 -0400
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D65CC5
        for <linux-block@vger.kernel.org>; Sun, 21 May 2023 17:43:44 -0700 (PDT)
Received: by mail-qv1-xf2e.google.com with SMTP id 6a1803df08f44-6239144bd59so18245696d6.3
        for <linux-block@vger.kernel.org>; Sun, 21 May 2023 17:43:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684716223; x=1687308223;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NRrWE28fk0zpUQJuUyGQUXTqzuJvY2voNofdbzRkNKk=;
        b=mAk0lPACLzNKZ0doQOJPCRxiwmRtkMIng4/hRopkmOwXI4G99Vy1fs+qR9BudhYSA+
         5nlIlWq9uDROlWMz/jXgJlJ0pwFAjxyp8v7dXj3ENdPWcHoJgh4k85J0N3/9ZvQvN1nK
         0Y6sS+9FR1K2NmdN0bYOWCjfbJJesiRYyNPSHnR4V+jiEJfyaOWnqOkO3eEWQ6tNM5f6
         dKS3KxDMclAyzKwo5z7ptPR8m8Xl7NdeEMpdOSa0WyM+7FyLS6oA5WfFbAV/S6mEo+Th
         cYpKJbdd4ZFNpGJyiBgWS04nBlM0NBqzYgi+/QPGM8P7NUkJA5Cjvvsdm6hoOvGNWIxq
         Xq4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684716223; x=1687308223;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NRrWE28fk0zpUQJuUyGQUXTqzuJvY2voNofdbzRkNKk=;
        b=UFRugmX5mRK7AFJzQdTvXVPTC62ttLjC64ERn5GdMPgc1kbDok3BgiviXM/YFjFI5F
         Qo/yY2kqn/TVQwF2/AiByxebSFaxWaPxwJtskLQQwQihDyvJRWHGjs2slCK9H7WVzNLH
         bw12q5SMIwaEh1afbUNsA87ObZvnMHdpO+SgePCdb+VrqD634oVfGPynaHH+IxN35Pes
         eDrnUBAfnQP4AKwZ+Lz/OKqCEBg15Xb4Ai1B5DiDCmORR8AHxU+5Hz3q6sv5golFbRCE
         gdmsVlziUs8QpOSZ10gaxTyb97Yasgs7C2WiC3ADbZyOauWv1dJYRVISWd9iSwyEzY30
         7uNg==
X-Gm-Message-State: AC+VfDwJpFJZY3zDhPQy5rPRysMwy/MDAEQ7liKtpVe4xoa3YKtVNyHB
        2D/u93dse0YE1xIowhwDZhLWY72A7uA=
X-Google-Smtp-Source: ACHHUZ5dnkxsJJPBRb2HzKxY+8G6i6f9HlPypwLhmt7sfmYCTy7Esc5ouhtoCrc7PMQfKkA58Z41mw==
X-Received: by 2002:a05:6214:20a9:b0:5f7:8b31:4522 with SMTP id 9-20020a05621420a900b005f78b314522mr18632610qvd.5.1684716223138;
        Sun, 21 May 2023 17:43:43 -0700 (PDT)
Received: from tian-Alienware-15-R4.fios-router.home (pool-173-77-254-84.nycmny.fios.verizon.net. [173.77.254.84])
        by smtp.gmail.com with ESMTPSA id mh12-20020a056214564c00b0061a0f7fb340sm1598501qvb.6.2023.05.21.17.43.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 May 2023 17:43:42 -0700 (PDT)
From:   Tian Lan <tilan7663@gmail.com>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, Tian Lan <tian.lan@twosigma.com>
Subject: [PATCH 1/1] blk-mq: fix race condition in active queue accounting
Date:   Sun, 21 May 2023 20:43:28 -0400
Message-Id: <20230522004328.760024-1-tilan7663@gmail.com>
X-Mailer: git-send-email 2.25.1
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
---
 block/blk-mq-tag.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
index d6af9d431dc6..07372032238a 100644
--- a/block/blk-mq-tag.c
+++ b/block/blk-mq-tag.c
@@ -42,13 +42,15 @@ void __blk_mq_tag_busy(struct blk_mq_hw_ctx *hctx)
 	if (blk_mq_is_shared_tags(hctx->flags)) {
 		struct request_queue *q = hctx->queue;
 
-		if (test_bit(QUEUE_FLAG_HCTX_ACTIVE, &q->queue_flags))
+		if (test_bit(QUEUE_FLAG_HCTX_ACTIVE, &q->queue_flags) ||
+		    test_and_set_bit(QUEUE_FLAG_HCTX_ACTIVE, &q->queue_flags)) {
 			return;
-		set_bit(QUEUE_FLAG_HCTX_ACTIVE, &q->queue_flags);
+		}
 	} else {
-		if (test_bit(BLK_MQ_S_TAG_ACTIVE, &hctx->state))
+		if (test_bit(BLK_MQ_S_TAG_ACTIVE, &hctx->state) ||
+		    test_and_set_bit(BLK_MQ_S_TAG_ACTIVE, &hctx->state)) {
 			return;
-		set_bit(BLK_MQ_S_TAG_ACTIVE, &hctx->state);
+		}
 	}
 
 	users = atomic_inc_return(&hctx->tags->active_queues);
-- 
2.34.1

