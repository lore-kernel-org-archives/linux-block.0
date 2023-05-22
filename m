Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 819E8C77B73
	for <linux-block@archiver.kernel.org>; Mon, 22 May 2023 02:12:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229761AbjEVCMq (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 21 May 2023 22:12:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229707AbjEVCMp (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 21 May 2023 22:12:45 -0400
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19098B7
        for <linux-block@vger.kernel.org>; Sun, 21 May 2023 19:12:45 -0700 (PDT)
Received: by mail-qv1-xf33.google.com with SMTP id 6a1803df08f44-62576fa52b4so3669696d6.0
        for <linux-block@vger.kernel.org>; Sun, 21 May 2023 19:12:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684721564; x=1687313564;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YWVPS1dR1tLDehmVs/fNxZ8sQHHZQ7oHzKE5CJkZueo=;
        b=Cqi8GtpVz9sGl4mGsf9iup84QAZ/1cqDpu0JLeEReQoQ+/KhJO4zxVIbcNg4TWgnpJ
         Szm/3GwICgIGZw/eEcnn1TpXDOILnFRTWVDZnSM5JRsS1E0KVV7x2nTOdxIhM/JiPafp
         l2LZ6kGrptpuMoa7tPGpvcKNGjcJATLI395nLI5sPLX+4EgjFdb+4dejMhVI3mijMtKl
         42nsZU/pQIizjWZGZXASF0eNAR7phn/X/V1szggdQ5PYYzVBMhUWSQnB+vd8z58FCTvI
         4FVIrykV7kVxk1W6QdQY2fLxxTUCvd9Qx8egjc2LY64KVZBuwF2dtYumjpEpE7KTgLSN
         XXeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684721564; x=1687313564;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YWVPS1dR1tLDehmVs/fNxZ8sQHHZQ7oHzKE5CJkZueo=;
        b=VcX4ilI6NqACUR07pBS/dDsD3E9aQefQcMI9B7svvfJiCc2E9p6BXOC0CrA5qgB9ip
         IK1IfVpogycb0zcCYviZ9vMB5giOeOXhgywn13I7mOJpdjUbL3AIkfPN+zOveLq4Sc7d
         tkEjA7vjySaajVWCvNDUFRTzwvbSygtjzq/eFRjKItCzeJAls4lSO+Ab5n0R7+Eqb8jS
         yiXdH5LklQVHLNa/KrhRAdlvP3pZLfDbZVcBYy/72UzQRWBBY7trVAR0uVMjPORw7iLw
         jKMeRXr6z/UDm/qwKHgrFr69IJntG2PswN54PsJfsZb57rN9ESY9Ltx/a6hUVhXRhjYk
         74Dw==
X-Gm-Message-State: AC+VfDzeaGEODN9zWzAUh8CpGqmpsDh/5MBpNy/7f92gX7ztDbz6Ycmd
        D17BiPxf8H1Vawnqdou0kWM=
X-Google-Smtp-Source: ACHHUZ5fE09QYanHXlbwKITtL2Q4vyzCf8cP7c8x/y3SmBGAVWqFeZhE5Ryf/l8DKleh1/Gh9YO12w==
X-Received: by 2002:a05:6214:27c5:b0:5f1:31eb:1eff with SMTP id ge5-20020a05621427c500b005f131eb1effmr15674033qvb.2.1684721564060;
        Sun, 21 May 2023 19:12:44 -0700 (PDT)
Received: from tian-Alienware-15-R4.fios-router.home (pool-173-77-254-84.nycmny.fios.verizon.net. [173.77.254.84])
        by smtp.gmail.com with ESMTPSA id ea15-20020ad458af000000b0062075f40f61sm1623056qvb.73.2023.05.21.19.12.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 May 2023 19:12:43 -0700 (PDT)
From:   Tian Lan <tilan7663@gmail.com>
To:     ming.lei@redhat.com
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org,
        liusong@linux.alibaba.com, tian.lan@twosigma.com,
        tilan7663@gmail.com
Subject: [PATCH 1/1] blk-mq: fix race condition in active queue accounting
Date:   Sun, 21 May 2023 22:12:14 -0400
Message-Id: <20230522021214.783024-1-tilan7663@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <CAFj5m9LfZ=CATGUz-KFE3YFd04XV2Zmu7kPMdbbyXLg-KnsPeg@mail.gmail.com>
References: <CAFj5m9LfZ=CATGUz-KFE3YFd04XV2Zmu7kPMdbbyXLg-KnsPeg@mail.gmail.com>
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
 block/blk-mq-tag.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
index d6af9d431dc6..0db6c31d3f4a 100644
--- a/block/blk-mq-tag.c
+++ b/block/blk-mq-tag.c
@@ -42,13 +42,13 @@ void __blk_mq_tag_busy(struct blk_mq_hw_ctx *hctx)
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

