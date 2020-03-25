Return-Path: <SRS0=yjA8=5K=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28CC4C1975A
	for <linux-block@archiver.kernel.org>; Wed, 25 Mar 2020 13:07:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 005F52078D
	for <linux-block@archiver.kernel.org>; Wed, 25 Mar 2020 13:07:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="WpSOhmSV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727360AbgCYNHV (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 25 Mar 2020 09:07:21 -0400
Received: from forwardcorp1o.mail.yandex.net ([95.108.205.193]:53690 "EHLO
        forwardcorp1o.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727470AbgCYNHH (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 25 Mar 2020 09:07:07 -0400
Received: from mxbackcorp2j.mail.yandex.net (mxbackcorp2j.mail.yandex.net [IPv6:2a02:6b8:0:1619::119])
        by forwardcorp1o.mail.yandex.net (Yandex) with ESMTP id EFB5C2E1655;
        Wed, 25 Mar 2020 16:07:04 +0300 (MSK)
Received: from myt4-18a966dbd9be.qloud-c.yandex.net (myt4-18a966dbd9be.qloud-c.yandex.net [2a02:6b8:c00:12ad:0:640:18a9:66db])
        by mxbackcorp2j.mail.yandex.net (mxbackcorp/Yandex) with ESMTP id zYEwKna8fE-74tGC8Q9;
        Wed, 25 Mar 2020 16:07:04 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru; s=default;
        t=1585141624; bh=AG1RfzU6IsBKlhj7NXKRSSMiAB387dPpuEky4QpipuI=;
        h=In-Reply-To:Message-ID:References:Date:To:From:Subject:Cc;
        b=WpSOhmSVOqAtdBEgY/wy82uISPT9EaPjjgWb1e2pCBofd3W165pDXqCjfFcu+UQnB
         R2IDYz0WVbx6apQhmu80vBwBo7k2BYz5DkYf3RHv4N0CxbKMxbdZ9dpKUFvxk5nLlr
         ngm7vXQbHdDiTwTwsmL5w5gEhz8ggYJ62XJZ7MaI=
Authentication-Results: mxbackcorp2j.mail.yandex.net; dkim=pass header.i=@yandex-team.ru
Received: from unknown (unknown [2a02:6b8:b080:8204::1:e])
        by myt4-18a966dbd9be.qloud-c.yandex.net (smtpcorp/Yandex) with ESMTPSA id w7gREjCitJ-74cqdsqn;
        Wed, 25 Mar 2020 16:07:04 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client certificate not present)
Subject: [PATCH v4 1/3] block/diskstats: more accurate approximation of
 io_ticks for slow disks
From:   Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
To:     linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        linux-kernel@vger.kernel.org
Cc:     Mikulas Patocka <mpatocka@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Ming Lei <ming.lei@redhat.com>
Date:   Wed, 25 Mar 2020 16:07:04 +0300
Message-ID: <158514162422.7009.10103628072965195890.stgit@buzz>
In-Reply-To: <158514148436.7009.1234367408038809210.stgit@buzz>
References: <158514148436.7009.1234367408038809210.stgit@buzz>
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

Note changes of iostat's "%util" 8,43% -> 99,99% before/after patch:

Before:

Device:         rrqm/s   wrqm/s     r/s     w/s    rkB/s    wkB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
sdb               0,00     0,00   82,60    0,00   330,40     0,00     8,00     0,96   12,09   12,09    0,00   1,02   8,43

After:

Device:         rrqm/s   wrqm/s     r/s     w/s    rkB/s    wkB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
sdb               0,00     0,00   82,50    0,00   330,00     0,00     8,00     1,00   12,10   12,10    0,00  12,12  99,99

Now io_ticks does not loose time between start and end of requests, but
for queue-depth > 1 some I/O time between adjacent starts might be lost.

For load estimation "%util" is not as useful as average queue length,
but it clearly shows how often disk queue is completely empty.

Fixes: 5b18b5a73760 ("block: delete part_round_stats and switch to less precise counting")
Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Reviewed-by: Ming Lei <ming.lei@redhat.com>
---
 Documentation/admin-guide/iostats.rst |    5 ++++-
 block/bio.c                           |    8 ++++----
 block/blk-core.c                      |    4 ++--
 include/linux/genhd.h                 |    2 +-
 4 files changed, 11 insertions(+), 8 deletions(-)

diff --git a/Documentation/admin-guide/iostats.rst b/Documentation/admin-guide/iostats.rst
index df5b8345c41d..9b14b0c2c9c4 100644
--- a/Documentation/admin-guide/iostats.rst
+++ b/Documentation/admin-guide/iostats.rst
@@ -100,7 +100,7 @@ Field 10 -- # of milliseconds spent doing I/Os (unsigned int)
 
     Since 5.0 this field counts jiffies when at least one request was
     started or completed. If request runs more than 2 jiffies then some
-    I/O time will not be accounted unless there are other requests.
+    I/O time might be not accounted in case of concurrent requests.
 
 Field 11 -- weighted # of milliseconds spent doing I/Os (unsigned int)
     This field is incremented at each I/O start, I/O completion, I/O
@@ -143,6 +143,9 @@ are summed (possibly overflowing the unsigned long variable they are
 summed to) and the result given to the user.  There is no convenient
 user interface for accessing the per-CPU counters themselves.
 
+Since 4.19 request times are measured with nanoseconds precision and
+truncated to milliseconds before showing in this interface.
+
 Disks vs Partitions
 -------------------
 
diff --git a/block/bio.c b/block/bio.c
index 209715765a7a..68f65ef2ceba 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -1768,14 +1768,14 @@ void bio_check_pages_dirty(struct bio *bio)
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
@@ -1791,7 +1791,7 @@ void generic_start_io_acct(struct request_queue *q, int op,
 
 	part_stat_lock();
 
-	update_io_ticks(part, jiffies);
+	update_io_ticks(part, jiffies, false);
 	part_stat_inc(part, ios[sgrp]);
 	part_stat_add(part, sectors[sgrp], sectors);
 	part_inc_in_flight(q, part, op_is_write(op));
@@ -1809,7 +1809,7 @@ void generic_end_io_acct(struct request_queue *q, int req_op,
 
 	part_stat_lock();
 
-	update_io_ticks(part, now);
+	update_io_ticks(part, now, true);
 	part_stat_add(part, nsecs[sgrp], jiffies_to_nsecs(duration));
 	part_stat_add(part, time_in_queue, duration);
 	part_dec_in_flight(q, part, op_is_write(req_op));
diff --git a/block/blk-core.c b/block/blk-core.c
index abfdcf81a228..4401b30a1751 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -1337,7 +1337,7 @@ void blk_account_io_done(struct request *req, u64 now)
 		part_stat_lock();
 		part = req->part;
 
-		update_io_ticks(part, jiffies);
+		update_io_ticks(part, jiffies, true);
 		part_stat_inc(part, ios[sgrp]);
 		part_stat_add(part, nsecs[sgrp], now - req->start_time_ns);
 		part_stat_add(part, time_in_queue, nsecs_to_jiffies64(now - req->start_time_ns));
@@ -1379,7 +1379,7 @@ void blk_account_io_start(struct request *rq, bool new_io)
 		rq->part = part;
 	}
 
-	update_io_ticks(part, jiffies);
+	update_io_ticks(part, jiffies, false);
 
 	part_stat_unlock();
 }
diff --git a/include/linux/genhd.h b/include/linux/genhd.h
index da62b44b15be..13bb51f37b3f 100644
--- a/include/linux/genhd.h
+++ b/include/linux/genhd.h
@@ -422,7 +422,7 @@ void part_dec_in_flight(struct request_queue *q, struct hd_struct *part,
 void part_inc_in_flight(struct request_queue *q, struct hd_struct *part,
 			int rw);
 
-void update_io_ticks(struct hd_struct *part, unsigned long now);
+void update_io_ticks(struct hd_struct *part, unsigned long now, bool end);
 
 /* block/genhd.c */
 extern void device_add_disk(struct device *parent, struct gendisk *disk,

