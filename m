Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54932C4332F
	for <linux-block@archiver.kernel.org>; Tue,  8 Nov 2022 18:10:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234738AbiKHSKt (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 8 Nov 2022 13:10:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234733AbiKHSKs (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 8 Nov 2022 13:10:48 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CCCA50F1D
        for <linux-block@vger.kernel.org>; Tue,  8 Nov 2022 10:10:44 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id u6so14855276plq.12
        for <linux-block@vger.kernel.org>; Tue, 08 Nov 2022 10:10:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eWhULAO1PGhpQ+ChwOYcLNZC3f58WMaAVvC3B9Ax33I=;
        b=OgzPo8mpGNo5exrre/OhRCO+v816mE1waYy6787p/nQN/NFFZsxn5irwVZFL5r59nK
         x7EWvXlhyznmWuDdfthA2yb4OyR11IASvIamkj1DwgqiZa+qLYaOJi2eEilaUrVEKzk8
         BmUYdSjxJ+fmBVou4WlXk29qTxMPYZ11FG5aI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eWhULAO1PGhpQ+ChwOYcLNZC3f58WMaAVvC3B9Ax33I=;
        b=wAhgeFAozBLmHEgcGxnNEs1KmMOjxwdTcYlywA1Rf46NDgx9ttO/HMMllbJVA6JLar
         u8CbqvklueKNgmnj6btnuw1CIxOpcvml1Q93svpA+BhL11XWpl432xRvmXtflVeHJ2g2
         h14XK39brCMHJerjzKhdxQwbhQMEG5ZIoYX4EqqRr2TxxChuN1BLPQpbnSbJt39l+SmF
         m+NU6Z+fRZfW9seunsSDZ3k36K7NKBIB57pBMbD4MDf9R8wQdQUGKThh0YV1crIUPC9i
         hHsQNYhUcCfP8CHwX2pVsOqOkZhwP0o4lWiZtRkvOQpLfMk41L9WdMP4bnxg/5Vd0P2Q
         kYYQ==
X-Gm-Message-State: ACrzQf1eGAU1D/EjQtG/nvec6zyQVxpR9Ovpxd80UiEhMkmekSjz/X1v
        G3s97MdxyywPTzxevkT9hdjJfw==
X-Google-Smtp-Source: AMsMyM5JdjlJDsuzUS3rfn2V0Wd1PJvEuFBmM2cCCPRZeXudLibia2TOoUKOYyUhYKZB+L6OntvxEg==
X-Received: by 2002:a17:902:ecc1:b0:186:b57e:d229 with SMTP id a1-20020a170902ecc100b00186b57ed229mr58084545plh.167.1667931043637;
        Tue, 08 Nov 2022 10:10:43 -0800 (PST)
Received: from khazhy-linux.svl.corp.google.com ([2620:15c:2d4:203:21f:525:beef:f928])
        by smtp.gmail.com with ESMTPSA id h3-20020a63df43000000b0046fd180640asm6048754pgj.24.2022.11.08.10.10.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Nov 2022 10:10:43 -0800 (PST)
From:   Khazhismel Kumykov <khazhy@chromium.org>
X-Google-Original-From: Khazhismel Kumykov <khazhy@google.com>
To:     Paolo Valente <paolo.valente@linaro.org>,
        Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yu Kuai <yukuai1@huaweicloud.com>, Jan Kara <jack@suse.cz>,
        Khazhismel Kumykov <khazhy@google.com>
Subject: [PATCH 1/2] bfq: fix waker_bfqq inconsistency crash
Date:   Tue,  8 Nov 2022 10:10:29 -0800
Message-Id: <20221108181030.1611703-1-khazhy@google.com>
X-Mailer: git-send-email 2.38.1.431.g37b22c650d-goog
In-Reply-To: <20221103013937.603626-1-khazhy@google.com>
References: <20221103013937.603626-1-khazhy@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This fixes crashes in bfq_add_bfqq_busy due to waker_bfqq being NULL,
but woken_list_node still being hashed. This would happen when
bfq_init_rq() expects a brand new allocated queue to be returned from
bfq_get_bfqq_handle_split() and unconditionally updates waker_bfqq
without resetting woken_list_node. Since we can always return oom_bfqq
when attempting to allocate, we cannot assume waker_bfqq starts as NULL.

Avoid setting woken_bfqq for oom_bfqq entirely, as it's not useful.

Crashes would have a stacktrace like:
[160595.656560]  bfq_add_bfqq_busy+0x110/0x1ec
[160595.661142]  bfq_add_request+0x6bc/0x980
[160595.666602]  bfq_insert_request+0x8ec/0x1240
[160595.671762]  bfq_insert_requests+0x58/0x9c
[160595.676420]  blk_mq_sched_insert_request+0x11c/0x198
[160595.682107]  blk_mq_submit_bio+0x270/0x62c
[160595.686759]  __submit_bio_noacct_mq+0xec/0x178
[160595.691926]  submit_bio+0x120/0x184
[160595.695990]  ext4_mpage_readpages+0x77c/0x7c8
[160595.701026]  ext4_readpage+0x60/0xb0
[160595.705158]  filemap_read_page+0x54/0x114
[160595.711961]  filemap_fault+0x228/0x5f4
[160595.716272]  do_read_fault+0xe0/0x1f0
[160595.720487]  do_fault+0x40/0x1c8

Tested by injecting random failures into bfq_get_queue, crashes go away
completely.

Fixes: 8ef3fc3a043c ("block, bfq: make shared queues inherit wakers")
Signed-off-by: Khazhismel Kumykov <khazhy@google.com>
---
 block/bfq-iosched.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index 7ea427817f7f..ca04ec868c40 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -6784,6 +6784,12 @@ static struct bfq_queue *bfq_init_rq(struct request *rq)
 				bfqq = bfq_get_bfqq_handle_split(bfqd, bic, bio,
 								 true, is_sync,
 								 NULL);
+				if (unlikely(bfqq == &bfqd->oom_bfqq))
+					bfqq_already_existing = true;
+			} else
+				bfqq_already_existing = true;
+
+			if (!bfqq_already_existing) {
 				bfqq->waker_bfqq = old_bfqq->waker_bfqq;
 				bfqq->tentative_waker_bfqq = NULL;
 
@@ -6797,8 +6803,7 @@ static struct bfq_queue *bfq_init_rq(struct request *rq)
 				if (bfqq->waker_bfqq)
 					hlist_add_head(&bfqq->woken_list_node,
 						       &bfqq->waker_bfqq->woken_list);
-			} else
-				bfqq_already_existing = true;
+			}
 		}
 	}
 
-- 
2.38.1.431.g37b22c650d-goog

