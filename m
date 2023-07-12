Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF367EB64DD
	for <linux-block@archiver.kernel.org>; Wed, 12 Jul 2023 17:33:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229757AbjGLRd4 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 12 Jul 2023 13:33:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232644AbjGLRdz (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 12 Jul 2023 13:33:55 -0400
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 813261991
        for <linux-block@vger.kernel.org>; Wed, 12 Jul 2023 10:33:53 -0700 (PDT)
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-666ecb21f86so6582666b3a.3
        for <linux-block@vger.kernel.org>; Wed, 12 Jul 2023 10:33:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689183233; x=1691775233;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TUeLU1gIrAqM/pIx75Jx2TVyG1ihfpTnVUq6zHmwpbM=;
        b=GGFTfWPrrNVQDd9zh9eBNCysLQO06cez9tj+oznrXJ4/2/aXd9WMcwSzZcmRWkEy9A
         nU6+7xA1GEDt+Le3s/MelvCVs3ighM1hnFeZhbEp7+4zxFmhSfuqnR4VbF3Wqn/LehD5
         afU441VwQkY8DhxCu+xm8KtI3J8iLgvEVo66Zd0mD4cr9TdVjM69mtVZYNoeudH2vG5w
         g8M6pPy3Ikh9KpGF5UxrO8XaHmzHcU/xQ7LXC1b23vVYmWRYt7m6qG4MsDMqcsih9bDt
         ZKejTPZcN8nqnG+1ehisd8SYTtVXWXhcOQ+j8hycZ3iqCJk3b9maupQjcG7s2j73SI1o
         fYmA==
X-Gm-Message-State: ABy/qLY8VD66O5Ifn8D4OD7vlhuyr+0MAeOr2q7Unyhg+Si4ziedU039
        Szg5PIiHfbrwB39XvBsObDo=
X-Google-Smtp-Source: APBJJlFFDGeH+ytdw7i0R52QFow4A6VFC0DHTb1curvmyTrNWimhAu8Gs/XhKDMsGrM+6u3ug04o0w==
X-Received: by 2002:a05:6a20:8e1a:b0:12f:bc36:4c67 with SMTP id y26-20020a056a208e1a00b0012fbc364c67mr24574659pzj.61.1689183232705;
        Wed, 12 Jul 2023 10:33:52 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:fc9:1485:272d:134e])
        by smtp.gmail.com with ESMTPSA id fk25-20020a056a003a9900b00682a0184742sm4007051pfb.148.2023.07.12.10.33.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jul 2023 10:33:52 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        Damien Le Moal <dlemoal@kernel.org>,
        Hannes Reinecke <hare@suse.de>
Subject: [PATCH] block/mq-deadline: Fix a bug in deadline_from_pos()
Date:   Wed, 12 Jul 2023 10:33:43 -0700
Message-ID: <20230712173344.2994513-1-bvanassche@acm.org>
X-Mailer: git-send-email 2.41.0.255.g8b1d071c50-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

A bug was introduced in deadline_from_pos() while implementing the
suggestion to use round_down() in the following code:

	pos -= bdev_offset_from_zone_start(rq->q->disk->part0, pos);

This patch makes deadline_from_pos() use round_down() such that 'pos' is
rounded down.

Reported-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Closes: https://lore.kernel.org/all/5zthzi3lppvcdp4nemum6qck4gpqbdhvgy4k3qwguhgzxc4quj@amulvgycq67h/
Cc: Christoph Hellwig <hch@lst.de>
Cc: Damien Le Moal <dlemoal@kernel.org>
Fixes: 0effb390c4ba ("block: mq-deadline: Handle requeued requests correctly")
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 block/mq-deadline.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/mq-deadline.c b/block/mq-deadline.c
index 0bed2bdeed89..f783ed71ae19 100644
--- a/block/mq-deadline.c
+++ b/block/mq-deadline.c
@@ -176,7 +176,7 @@ static inline struct request *deadline_from_pos(struct dd_per_prio *per_prio,
 	 * zoned writes, start searching from the start of a zone.
 	 */
 	if (blk_rq_is_seq_zoned_write(rq))
-		pos -= round_down(pos, rq->q->limits.chunk_sectors);
+		pos = round_down(pos, rq->q->limits.chunk_sectors);
 
 	while (node) {
 		rq = rb_entry_rq(node);
