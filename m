Return-Path: <SRS0=QOfo=4T=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96F50C3F2D1
	for <linux-block@archiver.kernel.org>; Mon,  2 Mar 2020 10:38:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02109217F4
	for <linux-block@archiver.kernel.org>; Mon,  2 Mar 2020 10:38:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="0YYmCIZK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727390AbgCBKiW (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 2 Mar 2020 05:38:22 -0500
Received: from forwardcorp1j.mail.yandex.net ([5.45.199.163]:46712 "EHLO
        forwardcorp1j.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726674AbgCBKiW (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 2 Mar 2020 05:38:22 -0500
Received: from mxbackcorp1g.mail.yandex.net (mxbackcorp1g.mail.yandex.net [IPv6:2a02:6b8:0:1402::301])
        by forwardcorp1j.mail.yandex.net (Yandex) with ESMTP id AF8082E1672;
        Mon,  2 Mar 2020 13:38:18 +0300 (MSK)
Received: from sas1-9998cec34266.qloud-c.yandex.net (sas1-9998cec34266.qloud-c.yandex.net [2a02:6b8:c14:3a0e:0:640:9998:cec3])
        by mxbackcorp1g.mail.yandex.net (mxbackcorp/Yandex) with ESMTP id P14cYGpF4i-cIx4H9Ht;
        Mon, 02 Mar 2020 13:38:18 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru; s=default;
        t=1583145498; bh=TYLGng62TDr6UK+a541Et2tFaIMCXjFCn0Kh/yV69fg=;
        h=Message-ID:Date:To:From:Subject:Cc;
        b=0YYmCIZKZRisFdpyaBNPI2GQHbT9R6iszPX2OH19oiJ2nh0vTw9QYlAzPriBXFuMx
         S1wxznD8tsULkPT3sYuS+ondAMI5E32pzNrJnVBpUh0beeCkd2haxbfCcge/QZHi78
         C8ZJsKy+/RhtoDKXwQakvicbIR8/w4ozE67pCEMA=
Authentication-Results: mxbackcorp1g.mail.yandex.net; dkim=pass header.i=@yandex-team.ru
Received: from dynamic-red.dhcp.yndx.net (dynamic-red.dhcp.yndx.net [2a02:6b8:0:40c:7cd4:25a8:c7e3:39e2])
        by sas1-9998cec34266.qloud-c.yandex.net (smtpcorp/Yandex) with ESMTPSA id 0lxJxrGRPa-cIWakF18;
        Mon, 02 Mar 2020 13:38:18 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client certificate not present)
Subject: [PATCH 1/3] block/diskstats: more accurate approximation of
 io_ticks for slow disks
From:   Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
To:     linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        linux-kernel@vger.kernel.org
Cc:     Mikulas Patocka <mpatocka@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>
Date:   Mon, 02 Mar 2020 13:38:17 +0300
Message-ID: <158314549775.1788.6529015932237292177.stgit@buzz>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Currently io_ticks is approximated by adding one at each start and end of
requests if jiffies counter has changed. This works perfectly for requests
shorter than a jiffy or if one of requests starts/ends at each jiffy.

If disk executes just one request at a time and they are longer than two
jiffies then only first and last jiffies will be accounted.

Fix is simple: at the end of request add up into io_ticks jiffies passed
since last update rather than just one jiffy.

Example: common HDD executes random read 4k requests around 12ms.

fio --name=test --filename=/dev/sdb --rw=randread --direct=1 --runtime=30 &
iostat -x 10 sdb

Note changes of iostat's "%util" before/after patch:

Before:

Device:         rrqm/s   wrqm/s     r/s     w/s    rkB/s    wkB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
sdb               0,00     0,00   82,60    0,00   330,40     0,00     8,00     0,96   12,09   12,09    0,00   1,02   8,43

After:

Device:         rrqm/s   wrqm/s     r/s     w/s    rkB/s    wkB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
sdb               0,00     0,00   82,50    0,00   330,00     0,00     8,00     1,00   12,10   12,10    0,00  12,12  99,99

Fixes: 5b18b5a73760 ("block: delete part_round_stats and switch to less precise counting")
Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
---
 block/bio.c           |    8 ++++----
 block/blk-core.c      |    4 ++--
 include/linux/genhd.h |    2 +-
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index 94d697217887..5319bf8721b7 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -1752,14 +1752,14 @@ void bio_check_pages_dirty(struct bio *bio)
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
@@ -1775,7 +1775,7 @@ void generic_start_io_acct(struct request_queue *q, int op,
 
 	part_stat_lock();
 
-	update_io_ticks(part, jiffies);
+	update_io_ticks(part, jiffies, false);
 	part_stat_inc(part, ios[sgrp]);
 	part_stat_add(part, sectors[sgrp], sectors);
 	part_inc_in_flight(q, part, op_is_write(op));
@@ -1793,7 +1793,7 @@ void generic_end_io_acct(struct request_queue *q, int req_op,
 
 	part_stat_lock();
 
-	update_io_ticks(part, now);
+	update_io_ticks(part, now, true);
 	part_stat_add(part, nsecs[sgrp], jiffies_to_nsecs(duration));
 	part_stat_add(part, time_in_queue, duration);
 	part_dec_in_flight(q, part, op_is_write(req_op));
diff --git a/block/blk-core.c b/block/blk-core.c
index 089e890ab208..caad0dc32333 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -1339,7 +1339,7 @@ void blk_account_io_done(struct request *req, u64 now)
 		part_stat_lock();
 		part = req->part;
 
-		update_io_ticks(part, jiffies);
+		update_io_ticks(part, jiffies, true);
 		part_stat_inc(part, ios[sgrp]);
 		part_stat_add(part, nsecs[sgrp], now - req->start_time_ns);
 		part_stat_add(part, time_in_queue, nsecs_to_jiffies64(now - req->start_time_ns));
@@ -1381,7 +1381,7 @@ void blk_account_io_start(struct request *rq, bool new_io)
 		rq->part = part;
 	}
 
-	update_io_ticks(part, jiffies);
+	update_io_ticks(part, jiffies, false);
 
 	part_stat_unlock();
 }
diff --git a/include/linux/genhd.h b/include/linux/genhd.h
index 6fbe58538ad6..d5ff7023daa8 100644
--- a/include/linux/genhd.h
+++ b/include/linux/genhd.h
@@ -431,7 +431,7 @@ static inline void free_part_info(struct hd_struct *part)
 	kfree(part->info);
 }
 
-void update_io_ticks(struct hd_struct *part, unsigned long now);
+void update_io_ticks(struct hd_struct *part, unsigned long now, bool end);
 
 /* block/genhd.c */
 extern void device_add_disk(struct device *parent, struct gendisk *disk,

