Return-Path: <SRS0=XB/C=6S=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 346CEC3A5A9
	for <linux-block@archiver.kernel.org>; Mon,  4 May 2020 13:31:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 073732078E
	for <linux-block@archiver.kernel.org>; Mon,  4 May 2020 13:31:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="EeeNfwqm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727103AbgEDNbK (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 4 May 2020 09:31:10 -0400
Received: from forwardcorp1j.mail.yandex.net ([5.45.199.163]:46750 "EHLO
        forwardcorp1j.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726404AbgEDNbI (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 4 May 2020 09:31:08 -0400
Received: from mxbackcorp1o.mail.yandex.net (mxbackcorp1o.mail.yandex.net [IPv6:2a02:6b8:0:1a2d::301])
        by forwardcorp1j.mail.yandex.net (Yandex) with ESMTP id 069812E09E9;
        Mon,  4 May 2020 16:31:06 +0300 (MSK)
Received: from vla1-81430ab5870b.qloud-c.yandex.net (vla1-81430ab5870b.qloud-c.yandex.net [2a02:6b8:c0d:35a1:0:640:8143:ab5])
        by mxbackcorp1o.mail.yandex.net (mxbackcorp/Yandex) with ESMTP id pH5zwfWsX8-V4bKi1Cm;
        Mon, 04 May 2020 16:31:05 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru; s=default;
        t=1588599065; bh=6SgBaqhCwd7nXa7Q0OgUv6wMyJo9sh+9c7AFEoii+p0=;
        h=Message-ID:References:Date:To:From:Subject:In-Reply-To;
        b=EeeNfwqmYY4ELZvsWcsFIsl1z5IQPTUP7RWaobgjqo5POwx8P0UutteXDyFIjrRPR
         RALnMWrv4aHIx+WaNKIin7irjEqnWBvhp8+v3QkoyMHgSJLdNeGSTOsdGVokGubIUg
         qF/DKLsq6GoXtNzhUqd/ZKxVPAgtJUn2yNyLmGKA=
Authentication-Results: mxbackcorp1o.mail.yandex.net; dkim=pass header.i=@yandex-team.ru
Received: from dynamic-vpn.dhcp.yndx.net (dynamic-vpn.dhcp.yndx.net [2a02:6b8:b081:409::1:8])
        by vla1-81430ab5870b.qloud-c.yandex.net (smtpcorp/Yandex) with ESMTPSA id c9UVbiVNmj-V4X0KAgb;
        Mon, 04 May 2020 16:31:04 +0300
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client certificate not present)
Subject: [PATCH 4/4] block/part_stat: add helper blk_account_io_merge_bio()
From:   Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
To:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>
Date:   Mon, 04 May 2020 16:31:04 +0300
Message-ID: <158859906056.19958.10435750035306672420.stgit@buzz>
In-Reply-To: <158859896942.19836.15240144203131230746.stgit@buzz>
References: <158859896942.19836.15240144203131230746.stgit@buzz>
User-Agent: StGit/0.22-32-g6a05
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Move non-"new_io" branch of blk_account_io_start() into separate function.
Fix merge accounting for discards (they were counted as write merges).

Also blk_account_io_merge_bio() doesn't call update_io_ticks() unlike to
blk_account_io_start(), there is no reason for that.

Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
---
 block/blk-core.c |   39 ++++++++++++++++++++++-----------------
 block/blk-exec.c |    2 +-
 block/blk-mq.c   |    2 +-
 block/blk.h      |    2 +-
 4 files changed, 25 insertions(+), 20 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index 45ddf7238c06..18fb42eb2f18 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -622,6 +622,17 @@ void blk_put_request(struct request *req)
 }
 EXPORT_SYMBOL(blk_put_request);
 
+static void blk_account_io_merge_bio(struct request *req)
+{
+	if (blk_do_io_stat(req)) {
+		const int sgrp = op_stat_group(req_op(req));
+
+		part_stat_lock();
+		part_stat_inc(req->part, merges[sgrp]);
+		part_stat_unlock();
+	}
+}
+
 bool bio_attempt_back_merge(struct request *req, struct bio *bio,
 		unsigned int nr_segs)
 {
@@ -640,7 +651,7 @@ bool bio_attempt_back_merge(struct request *req, struct bio *bio,
 	req->biotail = bio;
 	req->__data_len += bio->bi_iter.bi_size;
 
-	blk_account_io_start(req, false);
+	blk_account_io_merge_bio(req);
 	return true;
 }
 
@@ -664,7 +675,7 @@ bool bio_attempt_front_merge(struct request *req, struct bio *bio,
 	req->__sector = bio->bi_iter.bi_sector;
 	req->__data_len += bio->bi_iter.bi_size;
 
-	blk_account_io_start(req, false);
+	blk_account_io_merge_bio(req);
 	return true;
 }
 
@@ -686,7 +697,7 @@ bool bio_attempt_discard_merge(struct request_queue *q, struct request *req,
 	req->__data_len += bio->bi_iter.bi_size;
 	req->nr_phys_segments = segments + 1;
 
-	blk_account_io_start(req, false);
+	blk_account_io_merge_bio(req);
 	return true;
 no_merge:
 	req_set_nomerge(q, req);
@@ -1258,7 +1269,7 @@ blk_status_t blk_insert_cloned_request(struct request_queue *q, struct request *
 		return BLK_STS_IOERR;
 
 	if (blk_queue_io_stat(q))
-		blk_account_io_start(rq, true);
+		blk_account_io_start(rq);
 
 	/*
 	 * Since we have a scheduler attached on the top device,
@@ -1348,20 +1359,14 @@ void blk_account_io_done(struct request *req, u64 now)
 	}
 }
 
-void blk_account_io_start(struct request *rq, bool new_io)
+void blk_account_io_start(struct request *rq)
 {
 	struct hd_struct *part;
 	int rw = rq_data_dir(rq);
 
-	if (!blk_do_io_stat(rq))
-		return;
-
-	part_stat_lock();
+	if (blk_do_io_stat(rq)) {
+		part_stat_lock();
 
-	if (!new_io) {
-		part = rq->part;
-		part_stat_inc(part, merges[rw]);
-	} else {
 		rcu_read_lock();
 		part = disk_map_sector_rcu(rq->rq_disk, blk_rq_pos(rq));
 		if (!hd_struct_try_get(part)) {
@@ -1378,13 +1383,13 @@ void blk_account_io_start(struct request *rq, bool new_io)
 		}
 		rcu_read_unlock();
 
-		part_inc_in_flight(rq->q, part, rw);
 		rq->part = part;
-	}
 
-	update_io_ticks(part, jiffies, false);
+		part_inc_in_flight(rq->q, part, rw);
+		update_io_ticks(part, jiffies, false);
 
-	part_stat_unlock();
+		part_stat_unlock();
+	}
 }
 
 /*
diff --git a/block/blk-exec.c b/block/blk-exec.c
index e20a852ae432..85324d53d072 100644
--- a/block/blk-exec.c
+++ b/block/blk-exec.c
@@ -55,7 +55,7 @@ void blk_execute_rq_nowait(struct request_queue *q, struct gendisk *bd_disk,
 	rq->rq_disk = bd_disk;
 	rq->end_io = done;
 
-	blk_account_io_start(rq, true);
+	blk_account_io_start(rq);
 
 	/*
 	 * don't check dying flag for MQ because the request won't
diff --git a/block/blk-mq.c b/block/blk-mq.c
index bcc3a2397d4a..049c4f9417c3 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1794,7 +1794,7 @@ static void blk_mq_bio_to_request(struct request *rq, struct bio *bio,
 	rq->write_hint = bio->bi_write_hint;
 	blk_rq_bio_prep(rq, bio, nr_segs);
 
-	blk_account_io_start(rq, true);
+	blk_account_io_start(rq);
 }
 
 static blk_status_t __blk_mq_issue_directly(struct blk_mq_hw_ctx *hctx,
diff --git a/block/blk.h b/block/blk.h
index 73bd3b1c6938..06cd57cc10fb 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -195,7 +195,7 @@ bool bio_attempt_discard_merge(struct request_queue *q, struct request *req,
 bool blk_attempt_plug_merge(struct request_queue *q, struct bio *bio,
 		unsigned int nr_segs, struct request **same_queue_rq);
 
-void blk_account_io_start(struct request *req, bool new_io);
+void blk_account_io_start(struct request *req);
 void blk_account_io_completion(struct request *req, unsigned int bytes);
 void blk_account_io_done(struct request *req, u64 now);
 

