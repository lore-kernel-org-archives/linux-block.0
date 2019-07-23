Return-Path: <SRS0=ppXp=VU=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A5A9C76186
	for <linux-block@archiver.kernel.org>; Tue, 23 Jul 2019 03:27:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30D2C21911
	for <linux-block@archiver.kernel.org>; Tue, 23 Jul 2019 03:27:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fXGWiznk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730544AbfGWD1K (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 22 Jul 2019 23:27:10 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:43378 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727314AbfGWD1K (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 22 Jul 2019 23:27:10 -0400
Received: by mail-pl1-f196.google.com with SMTP id 4so13029234pld.10;
        Mon, 22 Jul 2019 20:27:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GRP7pr2OOjgRbOreV1kxricoKxpbSE+Edva7aK+xUiQ=;
        b=fXGWiznkmj5kwTl4LV/rK/UBc1vKdzE/lRoCKq2t+H/nwZ+31Zb/87eCxxnntMNXC4
         Ph7DVYIQDdsW7B9IdxUUP2d41s0ZptBlSBiyPKUYGi8nzCy3/+HR+r/cM5W1LObSTVRx
         wI7NiisdUYMAswy8bUMhvbgac9PvnvrGN4olGHx1HVUg+PmfRC+esU4b9Axvinr+RCsV
         qMGaxca7LFrVw1jTVn2XMplUmkEkmAJ8kRep3E1KE8zTKTUBnoF9dhmjz14E1Ixk8PkC
         QBw9y3LFeWF17J428KZQQ3OecqQCsSrHX4lxq9PArrBrahu+J4VMsjPePdn21cOEgaux
         qtoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GRP7pr2OOjgRbOreV1kxricoKxpbSE+Edva7aK+xUiQ=;
        b=BMGPrQaz9BgqXxbvu3IES7furEJmAMRMacqc3by4M785Mf7X5GhykJNwMNOUdrqNrS
         wXbjxv9ZdrHeWhEK7Dq8HUMmeR9akyI1oBGjznqk5R7nQSu6914jal64u0JNznN64EiJ
         p4awuia/4RqDVc56Q2iqfSJ8j3c6lbRD3fWnF8FyiSTea8vhRvrrXAcPNuftpTbXMUNj
         AWKRDYI2OgWWUraZDbmETuqZn6eVnIRd31TWMWjamU3iqzgp55zeBFUr9MVyJL1kBo4/
         NbYyLBm6zdT+4SWadJLnLYWtRyAe6PPZ8VlbI9nF7xzZ2Dja1Wl+Tsew5dRQhp/SeNxO
         HW8w==
X-Gm-Message-State: APjAAAWjkL+UoCBso30j8JfpdcaP51kDJ3tE+5HYVWcfQg5YOfpqB+uL
        vSyqik8Xd4jhgh+mKO8lvJ0oexIGI6s=
X-Google-Smtp-Source: APXvYqwenlVjDz1d39lyo7MCi5QM1hoS6SK/Ormll0gf7flg5s/iUBUYNWcrAH7mNe6wAuXm4J8zpw==
X-Received: by 2002:a17:902:a607:: with SMTP id u7mr78983045plq.43.1563852429181;
        Mon, 22 Jul 2019 20:27:09 -0700 (PDT)
Received: from continental.prv.suse.net ([191.248.110.143])
        by smtp.gmail.com with ESMTPSA id h1sm51552956pfo.152.2019.07.22.20.27.06
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 22 Jul 2019 20:27:08 -0700 (PDT)
From:   Marcos Paulo de Souza <marcos.souza.org@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        axboe@kernel.dk
Cc:     Marcos Paulo de Souza <marcos.souza.org@gmail.com>,
        Omar Sandoval <osandov@fb.com>,
        Damien Le Moal <damien.lemoal@wdc.com>
Subject: [PATCH v2] block: blk-mq: Remove blk_mq_sched_started_request and started_request
Date:   Tue, 23 Jul 2019 00:27:41 -0300
Message-Id: <20190723032743.10552-1-marcos.souza.org@gmail.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

blk_mq_sched_completed_request is a function that checks if the elevator
related to the request has started_request implemented, but currently, none of
the available IO schedulers implement started_request, so remove both.

Signed-off-by: Marcos Paulo de Souza <marcos.souza.org@gmail.com>
---
 Changes from v1:
 This was previously two patches, one removing blk_mq_sched_completed_request 
 and another one removing started_request, but now they are merged into this
 commit.

 block/blk-mq-sched.h     | 9 ---------
 block/blk-mq.c           | 2 --
 include/linux/elevator.h | 1 -
 3 files changed, 12 deletions(-)

diff --git a/block/blk-mq-sched.h b/block/blk-mq-sched.h
index cf22ab00fefb..126021fc3a11 100644
--- a/block/blk-mq-sched.h
+++ b/block/blk-mq-sched.h
@@ -61,15 +61,6 @@ static inline void blk_mq_sched_completed_request(struct request *rq, u64 now)
 		e->type->ops.completed_request(rq, now);
 }
 
-static inline void blk_mq_sched_started_request(struct request *rq)
-{
-	struct request_queue *q = rq->q;
-	struct elevator_queue *e = q->elevator;
-
-	if (e && e->type->ops.started_request)
-		e->type->ops.started_request(rq);
-}
-
 static inline void blk_mq_sched_requeue_request(struct request *rq)
 {
 	struct request_queue *q = rq->q;
diff --git a/block/blk-mq.c b/block/blk-mq.c
index b038ec680e84..3e8902714253 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -669,8 +669,6 @@ void blk_mq_start_request(struct request *rq)
 {
 	struct request_queue *q = rq->q;
 
-	blk_mq_sched_started_request(rq);
-
 	trace_block_rq_issue(q, rq);
 
 	if (test_bit(QUEUE_FLAG_STATS, &q->queue_flags)) {
diff --git a/include/linux/elevator.h b/include/linux/elevator.h
index 17cd0078377c..1dd014c9c87b 100644
--- a/include/linux/elevator.h
+++ b/include/linux/elevator.h
@@ -45,7 +45,6 @@ struct elevator_mq_ops {
 	struct request *(*dispatch_request)(struct blk_mq_hw_ctx *);
 	bool (*has_work)(struct blk_mq_hw_ctx *);
 	void (*completed_request)(struct request *, u64);
-	void (*started_request)(struct request *);
 	void (*requeue_request)(struct request *);
 	struct request *(*former_request)(struct request_queue *, struct request *);
 	struct request *(*next_request)(struct request_queue *, struct request *);
-- 
2.22.0

