Return-Path: <SRS0=YXNx=VL=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3840C742A2
	for <linux-block@archiver.kernel.org>; Sun, 14 Jul 2019 07:03:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 890EC2064A
	for <linux-block@archiver.kernel.org>; Sun, 14 Jul 2019 07:03:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="dacmDKB+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726017AbfGNHDk (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 14 Jul 2019 03:03:40 -0400
Received: from mta-p8.oit.umn.edu ([134.84.196.208]:56524 "EHLO
        mta-p8.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726152AbfGNHDi (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 14 Jul 2019 03:03:38 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-p8.oit.umn.edu (Postfix) with ESMTP id C27A29B5
        for <linux-block@vger.kernel.org>; Sun, 14 Jul 2019 07:03:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p8.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p8.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id EYyAec6kq0ch for <linux-block@vger.kernel.org>;
        Sun, 14 Jul 2019 02:03:36 -0500 (CDT)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p8.oit.umn.edu (Postfix) with ESMTPS id 9B2219E2
        for <linux-block@vger.kernel.org>; Sun, 14 Jul 2019 02:03:36 -0500 (CDT)
Received: by mail-io1-f72.google.com with SMTP id 132so16212622iou.0
        for <linux-block@vger.kernel.org>; Sun, 14 Jul 2019 00:03:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=HL1tb3nWXpE1nr/GaJWSi0TY+hGUkBRMlwJLK9dRztA=;
        b=dacmDKB+kPg8zQQC9ynkU4Vk3b0jnWW/3qs8oPKrB6WYik6A+ehewXUcltY+XJlEan
         GKLBaU2SWy7irZnmhP18uh9tOEvqIes/CFVSgSIMWQMM5NThJbBFO55wKqiK6Qz1a4oH
         6eSGmxNbnK4NGgiKeXWAuu3yl5MoznyktQ/N9rLlPovp84RxX5Oyms0vK3Y9yDKCL19u
         0fXqHKOtQ95YC9bRlJMJrFQU8VdgxdnWk/5pD7DVeXWTKoUoJoBtGaOD8JJrqA880cJ4
         PLa0LL9GWYVHo/dh6DurhpaaCz1Swp+e9h1PdH/ZNENBllcB658r2T2uCZ0uhn6NQUhg
         czrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=HL1tb3nWXpE1nr/GaJWSi0TY+hGUkBRMlwJLK9dRztA=;
        b=tuHeONNWPpVtu221dYZKti5CQUvXVyuqidBUZ/vdQkNzI3o3yDl0EQe9uKwJVWQ4gU
         cKxfHkPFJvVEQFoEYAHZZni4mNMY9dJwFCSPKw8XP04dV+EJzoVG/NqscqXZEI32r5QJ
         xeWkg4TH4VE1epjIVJA/IkAuNy7ZpFs34jVfPSrnOIcHebYGsxIqPt06tfsnVhGAhkEE
         Kxcx6tUjUcJFsUCfcT7sItlV9hupex/caSnThW9Q1XJ4a1+vo8FQ0N6WTPmFn+hiMHEh
         kIjNfDVobX4n4wi+iqBkwmlgqBNZUibgzwDZ5jV9NffYilT2DDb5+1qPJ8HOrcOQwjbi
         wN2g==
X-Gm-Message-State: APjAAAWX31WrfCm85pZ0UlrCDfvMzBWktvJDqgLYLfaCwHFwEfYLwj/k
        rfrRLyQkYYGknc8AacyixHWyX7cD8TPfIvb2v6kA9g/X727x42842NaynLHYO51CAgjj1g9RPsO
        ebZhZbvqsnFodYWzVBAOWCeHrJEU=
X-Received: by 2002:a02:aa1d:: with SMTP id r29mr21615005jam.127.1563087816045;
        Sun, 14 Jul 2019 00:03:36 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzxmmd0HxGJ+bFEBUuSrY4h1AHCB8b5x9/IESgLwYmr0HBCKuXHhGJBJGNbAn3N0di/WlWfEw==
X-Received: by 2002:a02:aa1d:: with SMTP id r29mr21614992jam.127.1563087815885;
        Sun, 14 Jul 2019 00:03:35 -0700 (PDT)
Received: from BlueSky.hsd1.mn.comcast.net (c-66-41-25-226.hsd1.mn.comcast.net. [66.41.25.226])
        by smtp.gmail.com with ESMTPSA id c14sm10814570ioa.22.2019.07.14.00.03.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 14 Jul 2019 00:03:35 -0700 (PDT)
From:   Wenwen Wang <wang6495@umn.edu>
To:     Wenwen Wang <wenwen@cs.uga.edu>
Cc:     Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org (open list:BLOCK LAYER),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] blk-mq: fix a memory leak bug
Date:   Sun, 14 Jul 2019 02:03:21 -0500
Message-Id: <1563087801-7373-1-git-send-email-wang6495@umn.edu>
X-Mailer: git-send-email 2.7.4
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Wenwen Wang <wenwen@cs.uga.edu>

In blk_mq_init_allocated_queue(), a kernel buffer is allocated through
kcalloc_node() to hold hardware dispatch queues in the request queue 'q',
i.e., 'q->queue_hw_ctx'.  Later on, if the blk-mq device has no scheduler
set, a scheduler will be initialized through elevator_init_mq(). If this
initialization fails, blk_mq_init_allocated_queue() needs to be terminated
with an error code returned to indicate this failure. However, the
allocated buffer is not freed on this execution path, leading to a memory
leak bug. Moreover, the required cleanup work is also missed on this path.

To fix the above issues, free the allocated buffer and invoke the cleanup
functions.

Signed-off-by: Wenwen Wang <wenwen@cs.uga.edu>
---
 block/blk-mq.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index e5ef40c..04fe077 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2845,6 +2845,8 @@ static unsigned int nr_hw_queues(struct blk_mq_tag_set *set)
 struct request_queue *blk_mq_init_allocated_queue(struct blk_mq_tag_set *set,
 						  struct request_queue *q)
 {
+	int ret = -ENOMEM;
+
 	/* mark the queue as mq asap */
 	q->mq_ops = set->ops;
 
@@ -2906,11 +2908,9 @@ struct request_queue *blk_mq_init_allocated_queue(struct blk_mq_tag_set *set,
 	blk_mq_map_swqueue(q);
 
 	if (!(set->flags & BLK_MQ_F_NO_SCHED)) {
-		int ret;
-
 		ret = elevator_init_mq(q);
 		if (ret)
-			return ERR_PTR(ret);
+			goto err_hctxs;
 	}
 
 	return q;
@@ -2924,7 +2924,7 @@ struct request_queue *blk_mq_init_allocated_queue(struct blk_mq_tag_set *set,
 	q->poll_cb = NULL;
 err_exit:
 	q->mq_ops = NULL;
-	return ERR_PTR(-ENOMEM);
+	return ERR_PTR(ret);
 }
 EXPORT_SYMBOL(blk_mq_init_allocated_queue);
 
-- 
2.7.4

