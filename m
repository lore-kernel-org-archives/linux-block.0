Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFA92C433F5
	for <linux-block@archiver.kernel.org>; Thu,  4 Nov 2021 15:22:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CBDBB60F70
	for <linux-block@archiver.kernel.org>; Thu,  4 Nov 2021 15:22:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231341AbhKDPYs (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 4 Nov 2021 11:24:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231450AbhKDPYs (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 4 Nov 2021 11:24:48 -0400
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DDAFC061714
        for <linux-block@vger.kernel.org>; Thu,  4 Nov 2021 08:22:10 -0700 (PDT)
Received: by mail-oi1-x236.google.com with SMTP id x70so9785504oix.6
        for <linux-block@vger.kernel.org>; Thu, 04 Nov 2021 08:22:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kRxjSFq+0VTJ4ZG+Y4lSjzqOLks9JeezG9aPZtfPP6k=;
        b=iQPky7+1EhF69oCXE18y/gsqgkkW7dov/PzkOImXTe5knrDpa2Y051Js9k5p98Cpmf
         WdGLC9I2FCyfnougmah8i1N6/mAH5rpHcIMdIoRGBor2zpbfazuUDZoo38uobEmljJdp
         +apW3FAjDDoCB5wowv1/jGyQ0e7zrhU9UxRzx2mz2xVppFKXJ31InnOzBOjO6VLRsKQx
         aJdS0JPxkYpX0DJapm6fIQ3J9bBvfFdiCpC1SKLQyOj0idaW/YbTjdSlskfvPLi+rkme
         lgAZDfeMe5PZMdoGX8mC7QOAA9cqEwygIxYHE6E8y84wTRqYYar/RUPve2i3pERyiUIY
         0VCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kRxjSFq+0VTJ4ZG+Y4lSjzqOLks9JeezG9aPZtfPP6k=;
        b=Oao8BP0uudGvZWFeiGR03r1hPHIC7ZJkFx3jPvc1MUiIK/mnu/BGGqJ3o5r1Z3oB8X
         SguYiZvF0hNwvPa7lgAJ5YEv5xY2qi0u44j2ugAs9ZjmEGzYhfg5ONF4tcVI8EXrwWhO
         U88vck9IOsewC62FCiN53bY1PrVI794ju0ZVwCRTYIARLw0YPa4ng/TPJrcy9daCljjR
         ZOX/+u2ZJkcR1sRFjnrcw7sWN2J8TNmF4XVoz0V51AkO6fT3NDY7Nrc+FP1wQikonpIK
         s5xme+yM9CVA3QW2b4mP7HwkA9qdXNlpApk5ZgyJ6+eOiQlEKYdZWaKwMaJpPQgX5+h4
         FI3A==
X-Gm-Message-State: AOAM531M8kMSreS9w5jtfMlP0wg9npMJECjGYygSvMjYkOA0oQ5Y0z6y
        XMsG2HOmTTna1/UfnjKQtfPg8ix6tx7CPw==
X-Google-Smtp-Source: ABdhPJxfcySE8gWJUZHPUHhAub+oHJfKexQJUYspU3Uj+4/yzOOE4J0EmLYVD+dkMxvjHH41Loyemw==
X-Received: by 2002:a54:4f82:: with SMTP id g2mr16214898oiy.134.1636039329379;
        Thu, 04 Nov 2021 08:22:09 -0700 (PDT)
Received: from p1.localdomain ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id k2sm1023925oiw.7.2021.11.04.08.22.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Nov 2021 08:22:09 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 3/5] block: move plug rq alloc into helper
Date:   Thu,  4 Nov 2021 09:22:02 -0600
Message-Id: <20211104152204.57360-4-axboe@kernel.dk>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211104152204.57360-1-axboe@kernel.dk>
References: <20211104152204.57360-1-axboe@kernel.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This is in preparation for a fix, but serves as a cleanup as well moving
the plugged request logic out of blk_mq_submit_bio().

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 block/blk-mq.c | 23 +++++++++++++++++++----
 1 file changed, 19 insertions(+), 4 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 5498454c2164..f7f36d5ed25a 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2478,6 +2478,23 @@ static inline unsigned short blk_plug_max_rq_count(struct blk_plug *plug)
 	return BLK_MAX_REQUEST_COUNT;
 }
 
+static inline struct request *blk_get_plug_request(struct request_queue *q,
+						   struct blk_plug *plug,
+						   struct bio *bio)
+{
+	struct request *rq;
+
+	if (!plug)
+		return NULL;
+	rq = rq_list_peek(&plug->cached_rq);
+	if (rq) {
+		plug->cached_rq = rq_list_next(rq);
+		INIT_LIST_HEAD(&rq->queuelist);
+		return rq;
+	}
+	return NULL;
+}
+
 /**
  * blk_mq_submit_bio - Create and send a request to block device.
  * @bio: Bio pointer.
@@ -2518,10 +2535,8 @@ void blk_mq_submit_bio(struct bio *bio)
 	rq_qos_throttle(q, bio);
 
 	plug = blk_mq_plug(q, bio);
-	if (plug && plug->cached_rq) {
-		rq = rq_list_pop(&plug->cached_rq);
-		INIT_LIST_HEAD(&rq->queuelist);
-	} else {
+	rq = blk_get_plug_request(q, plug, bio);
+	if (!rq) {
 		struct blk_mq_alloc_data data = {
 			.q		= q,
 			.nr_tags	= 1,
-- 
2.33.1

