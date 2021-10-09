Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7F98C43219
	for <linux-block@archiver.kernel.org>; Sat,  9 Oct 2021 12:26:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8D261610CF
	for <linux-block@archiver.kernel.org>; Sat,  9 Oct 2021 12:26:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244790AbhJIM2d (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 9 Oct 2021 08:28:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244718AbhJIM2b (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sat, 9 Oct 2021 08:28:31 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78638C061570;
        Sat,  9 Oct 2021 05:26:34 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id e12so38207336wra.4;
        Sat, 09 Oct 2021 05:26:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4GnHAbXKqGZGYNjF8KNJmEmT59MtbTDG5MrsdXPqRsg=;
        b=ccrKi0VxIswycMApCYtdwGUjtn4Xq9SFQaprAK4SCCMwUfHeICQNUFPZcpSptLxRUC
         I3HbdixkxvgRWvyY3nlr//pkY/RQTeBGWkZHWeSFWTBkWetPg6Odk0oYDXUUA0GQ1ihq
         ma5CxtA96jLaT8XkzM4WhDYIdVvDYd6WGSVhdBkZzUv2tSgs4KqlZtj/27TWOSa8lUlI
         UVCwof3iNs5uH3tk/pclz8yawGS9auyASoMfkqDkGU/UJQ5xROtZTl4mVubI/Hl9S4HV
         Dyd4tYMtf5m4RhjeiekXyI50S+q56CQ3Y2NTm4Bts8Q25DvMWIAWhtuYxzM9RZtzPKUt
         sWMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4GnHAbXKqGZGYNjF8KNJmEmT59MtbTDG5MrsdXPqRsg=;
        b=c7jJqIbElHvibwoKLFz49/DF1POe5Qi/S/R9MeENQKy3waM6FYJpi/5crm8c2OaDDL
         YDCpJydBGABJmQjyQ/aoaOSPKF39UXoYJAiONHc5snGEnTc6Q8nT2hNiWfZ6h2HOnnVf
         zeKGxzeB7NTkymuZe9i7W8xkmSp1Q3nABm+e0n/DgGfXR4VRjSshSMf3SE+no1GPm2EK
         yTQPov1jrSKQSfYqA1Ac1ixyPSSi9/0Ay0rKCOAjKE9q/Ne9AB5fhoXYsQjZDkSOqV13
         XZnubA8dZcDjV5Dm4sY1cAqZy4UBWJ5ZbIh6OI9PfGEduClBjOd9k5UVyo6IIdh5LfYt
         Pq4A==
X-Gm-Message-State: AOAM531x39QDWkHdECpivYqmilp1bJCbPSHxKs9AHAINwCoAvwuVtHVS
        xbXa76vjA/Qsyg0p4Rnq9UI=
X-Google-Smtp-Source: ABdhPJwt96jv6wrvfiB/AYbqhiqiyEPg9qkMQrzBcoxBhWiudVYrYCGD2xlDyvnJCdRyDQRPdR16WA==
X-Received: by 2002:a5d:43c3:: with SMTP id v3mr1734403wrr.22.1633782393089;
        Sat, 09 Oct 2021 05:26:33 -0700 (PDT)
Received: from localhost.localdomain ([85.255.236.155])
        by smtp.gmail.com with ESMTPSA id o12sm2157468wrv.78.2021.10.09.05.26.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Oct 2021 05:26:32 -0700 (PDT)
From:   Pavel Begunkov <asml.silence@gmail.com>
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     asml.silence@gmail.com
Subject: [PATCH 4/6] block: inline hot paths of blk_account_io_*()
Date:   Sat,  9 Oct 2021 13:25:41 +0100
Message-Id: <b0662a636bd4cc7b4f84c9d0a41efa46a688ef13.1633781740.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <cover.1633781740.git.asml.silence@gmail.com>
References: <cover.1633781740.git.asml.silence@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Extract hot paths of __blk_account_io_start() and
__blk_account_io_done() into inline functions, so we don't always pay
for function calls.

Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 block/blk-core.c | 30 +++++++++---------------------
 block/blk.h      | 24 +++++++++++++++++++++---
 2 files changed, 30 insertions(+), 24 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index 9b8c70670190..6a9607a22589 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -1172,8 +1172,7 @@ blk_status_t blk_insert_cloned_request(struct request_queue *q, struct request *
 	if (blk_crypto_insert_cloned_request(rq))
 		return BLK_STS_IOERR;
 
-	if (blk_queue_io_stat(q))
-		blk_account_io_start(rq);
+	blk_account_io_start(rq);
 
 	/*
 	 * Since we have a scheduler attached on the top device,
@@ -1252,30 +1251,19 @@ static void blk_account_io_completion(struct request *req, unsigned int bytes)
 	}
 }
 
-void blk_account_io_done(struct request *req, u64 now)
+void __blk_account_io_done(struct request *req, u64 now)
 {
-	/*
-	 * Account IO completion.  flush_rq isn't accounted as a
-	 * normal IO on queueing nor completion.  Accounting the
-	 * containing request is enough.
-	 */
-	if (req->part && blk_do_io_stat(req) &&
-	    !(req->rq_flags & RQF_FLUSH_SEQ)) {
-		const int sgrp = op_stat_group(req_op(req));
+	const int sgrp = op_stat_group(req_op(req));
 
-		part_stat_lock();
-		update_io_ticks(req->part, jiffies, true);
-		part_stat_inc(req->part, ios[sgrp]);
-		part_stat_add(req->part, nsecs[sgrp], now - req->start_time_ns);
-		part_stat_unlock();
-	}
+	part_stat_lock();
+	update_io_ticks(req->part, jiffies, true);
+	part_stat_inc(req->part, ios[sgrp]);
+	part_stat_add(req->part, nsecs[sgrp], now - req->start_time_ns);
+	part_stat_unlock();
 }
 
-void blk_account_io_start(struct request *rq)
+void __blk_account_io_start(struct request *rq)
 {
-	if (!blk_do_io_stat(rq))
-		return;
-
 	/* passthrough requests can hold bios that do not have ->bi_bdev set */
 	if (rq->bio && rq->bio->bi_bdev)
 		rq->part = rq->bio->bi_bdev;
diff --git a/block/blk.h b/block/blk.h
index 38867b4c5c7e..5d74270314ea 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -219,8 +219,8 @@ bool blk_attempt_plug_merge(struct request_queue *q, struct bio *bio,
 bool blk_bio_list_merge(struct request_queue *q, struct list_head *list,
 			struct bio *bio, unsigned int nr_segs);
 
-void blk_account_io_start(struct request *req);
-void blk_account_io_done(struct request *req, u64 now);
+void __blk_account_io_start(struct request *req);
+void __blk_account_io_done(struct request *req, u64 now);
 
 /*
  * Plug flush limits
@@ -284,7 +284,25 @@ int blk_dev_init(void);
  */
 static inline bool blk_do_io_stat(struct request *rq)
 {
-	return rq->rq_disk && (rq->rq_flags & RQF_IO_STAT);
+	return (rq->rq_flags & RQF_IO_STAT) && rq->rq_disk;
+}
+
+static inline void blk_account_io_done(struct request *req, u64 now)
+{
+	/*
+	 * Account IO completion.  flush_rq isn't accounted as a
+	 * normal IO on queueing nor completion.  Accounting the
+	 * containing request is enough.
+	 */
+	if (blk_do_io_stat(req) && req->part &&
+	    !(req->rq_flags & RQF_FLUSH_SEQ))
+		__blk_account_io_done(req, now);
+}
+
+static inline void blk_account_io_start(struct request *req)
+{
+	if (blk_do_io_stat(req))
+		__blk_account_io_start(req);
 }
 
 static inline void req_set_nomerge(struct request_queue *q, struct request *req)
-- 
2.33.0

