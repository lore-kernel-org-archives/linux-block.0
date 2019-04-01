Return-Path: <SRS0=QnQz=SD=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4247C43381
	for <linux-block@archiver.kernel.org>; Mon,  1 Apr 2019 15:59:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D3AB2133F
	for <linux-block@archiver.kernel.org>; Mon,  1 Apr 2019 15:59:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="uUv2QEMB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728359AbfDAP7y (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 1 Apr 2019 11:59:54 -0400
Received: from forwardcorp1g.cmail.yandex.net ([87.250.241.190]:34172 "EHLO
        forwardcorp1g.cmail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726887AbfDAP7x (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 1 Apr 2019 11:59:53 -0400
Received: from mxbackcorp1o.mail.yandex.net (mxbackcorp1o.mail.yandex.net [IPv6:2a02:6b8:0:1a2d::301])
        by forwardcorp1g.cmail.yandex.net (Yandex) with ESMTP id EB4E020EAE;
        Mon,  1 Apr 2019 18:59:48 +0300 (MSK)
Received: from smtpcorp1p.mail.yandex.net (smtpcorp1p.mail.yandex.net [2a02:6b8:0:1472:2741:0:8b6:10])
        by mxbackcorp1o.mail.yandex.net (nwsmtp/Yandex) with ESMTP id vS4nfsb2VB-xmLiDELi;
        Mon, 01 Apr 2019 18:59:48 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru; s=default;
        t=1554134388; bh=j1Yk/MHeaXGfHm4eG2oS9nL8Ukq1mQ3YLPCAz7e/2yM=;
        h=In-Reply-To:Message-ID:References:Date:To:From:Subject:Cc;
        b=uUv2QEMBzoBpkHYzXgjytE3ZAhkoEjRwdRcNNr0ALtCHhP+Tl9L5aZBTp2w6GExxY
         qXToUjpXBAt4JQQ4zaQza7HZsytVqdJiJwwr8HxU904b2Bi6Hcn4nlBTWUqLWEbAnd
         t+R/3ymhir4/9wYp6324+o82W4w1H3dbXg2P5xL0=
Authentication-Results: mxbackcorp1o.mail.yandex.net; dkim=pass header.i=@yandex-team.ru
Received: from dynamic-red.dhcp.yndx.net (dynamic-red.dhcp.yndx.net [2a02:6b8:0:40c:d4bb:795:9728:5f59])
        by smtpcorp1p.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id MPq6S22oNT-xms8CMD5;
        Mon, 01 Apr 2019 18:59:48 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client certificate not present)
Subject: [PATCH 3/3] block/diskstats: more accurate approximation of
 io_ticks for slow disks
From:   Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
To:     linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        linux-kernel@vger.kernel.org
Cc:     Mikulas Patocka <mpatocka@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>
Date:   Mon, 01 Apr 2019 18:59:48 +0300
Message-ID: <155413438824.3201.15254568091182734151.stgit@buzz>
In-Reply-To: <155413438394.3201.15211440151043943989.stgit@buzz>
References: <155413438394.3201.15211440151043943989.stgit@buzz>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Currently io_ticks is approximated by adding one at each
start and end of requests if jiffies has changed.
This works perfectly for requests shorter than a jiffy.

Fix for slow requests is simple: at the end of request add
count of jiffies passed since last update.

Fixes: 5b18b5a73760 ("block: delete part_round_stats and switch to less precise counting")
Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
---
 block/bio.c           |    8 ++++----
 block/blk-core.c      |    4 ++--
 include/linux/genhd.h |    2 +-
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index c0a60f3e9b7b..245056797999 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -1729,14 +1729,14 @@ void bio_check_pages_dirty(struct bio *bio)
 	schedule_work(&bio_dirty_work);
 }
 
-void update_io_ticks(struct hd_struct *part, unsigned long now)
+void update_io_ticks(struct hd_struct *part, unsigned long now, bool end)
 {
 	unsigned long stamp;
 again:
 	stamp = READ_ONCE(part->stamp);
 	if (unlikely(stamp != now)) {
 		if (likely(cmpxchg(&part->stamp, stamp, now) == stamp)) {
-			__part_stat_add(part, io_ticks, 1);
+			__part_stat_add(part, io_ticks, end ? now - stamp : 1);
 		}
 	}
 	if (part->partno) {
@@ -1752,7 +1752,7 @@ void generic_start_io_acct(struct request_queue *q, int op,
 
 	part_stat_lock();
 
-	update_io_ticks(part, jiffies);
+	update_io_ticks(part, jiffies, false);
 	part_stat_inc(part, ios[sgrp]);
 	part_stat_add(part, sectors[sgrp], sectors);
 	part_inc_in_flight(q, part, op_is_write(op));
@@ -1770,7 +1770,7 @@ void generic_end_io_acct(struct request_queue *q, int req_op,
 
 	part_stat_lock();
 
-	update_io_ticks(part, now);
+	update_io_ticks(part, now, true);
 	part_stat_add(part, nsecs[sgrp], jiffies_to_nsecs(duration));
 	part_dec_in_flight(q, part, op_is_write(req_op));
 
diff --git a/block/blk-core.c b/block/blk-core.c
index d89168b167e9..6e8f0b9e7731 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -1334,7 +1334,7 @@ void blk_account_io_done(struct request *req, u64 now)
 		part_stat_lock();
 		part = req->part;
 
-		update_io_ticks(part, jiffies);
+		update_io_ticks(part, jiffies, true);
 		part_stat_inc(part, ios[sgrp]);
 		part_stat_add(part, nsecs[sgrp], now - req->start_time_ns);
 		part_dec_in_flight(req->q, part, rq_data_dir(req));
@@ -1375,7 +1375,7 @@ void blk_account_io_start(struct request *rq, bool new_io)
 		rq->part = part;
 	}
 
-	update_io_ticks(part, jiffies);
+	update_io_ticks(part, jiffies, false);
 
 	part_stat_unlock();
 }
diff --git a/include/linux/genhd.h b/include/linux/genhd.h
index 2f5a9ed7e86e..8ece8e02c609 100644
--- a/include/linux/genhd.h
+++ b/include/linux/genhd.h
@@ -410,7 +410,7 @@ static inline void free_part_info(struct hd_struct *part)
 	kfree(part->info);
 }
 
-void update_io_ticks(struct hd_struct *part, unsigned long now);
+void update_io_ticks(struct hd_struct *part, unsigned long now, bool end);
 
 /* block/genhd.c */
 extern void device_add_disk(struct device *parent, struct gendisk *disk,

