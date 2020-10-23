Return-Path: <SRS0=d006=D6=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07461C55178
	for <linux-block@archiver.kernel.org>; Fri, 23 Oct 2020 08:02:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AF6B02192A
	for <linux-block@archiver.kernel.org>; Fri, 23 Oct 2020 08:02:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2898461AbgJWICO (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 23 Oct 2020 04:02:14 -0400
Received: from 22.17.110.36.static.bjtelecom.net ([36.110.17.22]:20906 "HELO
        bsf02.didichuxing.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with SMTP id S370808AbgJWICN (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 23 Oct 2020 04:02:13 -0400
X-Greylist: delayed 4521 seconds by postgrey-1.27 at vger.kernel.org; Fri, 23 Oct 2020 04:02:03 EDT
X-ASG-Debug-ID: 1603435597-0e41083db8bc41e0001-Cu09wu
Received: from mail.didiglobal.com (bogon [172.20.15.14]) by bsf02.didichuxing.com with ESMTP id CTBHmmBIF6chUDSX; Fri, 23 Oct 2020 14:46:37 +0800 (CST)
X-Barracuda-Envelope-From: zhangweiping@didiglobal.com
Received: from 192.168.3.9 (172.22.50.20) by BJSGEXMBX03.didichuxing.com
 (172.20.15.133) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Fri, 23 Oct
 2020 14:46:37 +0800
Date:   Fri, 23 Oct 2020 14:46:32 +0800
From:   Weiping Zhang <zhangweiping@didiglobal.com>
To:     <axboe@kernel.dk>, <ming.lei@redhat.com>, <snitzer@redhat.com>,
        <mpatocka@redhat.com>
CC:     <linux-block@vger.kernel.org>
Subject: [PATCH RFC] block: fix inaccurate io_ticks
Message-ID: <20201023064621.GA16839@192.168.3.9>
X-ASG-Orig-Subj: [PATCH RFC] block: fix inaccurate io_ticks
Mail-Followup-To: axboe@kernel.dk, ming.lei@redhat.com, snitzer@redhat.com,
        mpatocka@redhat.com, linux-block@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Originating-IP: [172.22.50.20]
X-ClientProxiedBy: BJEXCAS02.didichuxing.com (172.20.36.211) To
 BJSGEXMBX03.didichuxing.com (172.20.15.133)
X-Barracuda-Connect: bogon[172.20.15.14]
X-Barracuda-Start-Time: 1603435597
X-Barracuda-URL: https://bsf02.didichuxing.com:443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at didichuxing.com
X-Barracuda-Scan-Msg-Size: 4644
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: INNOCENT GLOBAL 0.0000 1.0000 -2.0210
X-Barracuda-Spam-Score: -2.02
X-Barracuda-Spam-Status: No, SCORE=-2.02 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=1000.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.85467
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------------------------
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Do not add io_ticks if there is no infligh io when start a new IO,
otherwise an extra 1 jiffy will be add to this IO.

I run the following command on a host, with different kernel version.

fio -name=test -ioengine=sync -bs=4K -rw=write
-filename=/home/test.fio.log -size=100M -time_based=1 -direct=1
-runtime=300 -rate=2m,2m

If we run fio in a sync direct io mode, IO will be proccessed one by one,
you can see that there are 512 IOs completed in one second.

kernel: 4.19.0

Device: rrqm/s wrqm/s  r/s    w/s rMB/s wMB/s avgrq-sz avgqu-sz await r_await w_await svctm %util
vda       0.00   0.00 0.00 512.00  0.00  2.00     8.00     0.21  0.40    0.00    0.40  0.40 20.60

The averate io.latency is 0.4ms, so the disk time cost in one second
should be 0.4 * 512 = 204.8 ms, that means, %util should be 20%.

Becase update_io_ticks will add a extra 1 jiffy(1ms) for every IO, the
io.latency io.latency will be 1 + 0.4 = 1.4ms,
1.4 * 512 = 716.8ms, so the %util show it about 72%.

Device  r/s    w/s rMB/s wMB/s rrqm/s wrqm/s %rrqm %wrqm r_await w_await aqu-sz rareq-sz wareq-sz svctm  %util
vda    0.00 512.00  0.00  2.00   0.00   0.00  0.00  0.00    0.00    0.40   0.20     0.00     4.00  1.41  72.10

After this patch:
Device  r/s    w/s rMB/s wMB/s rrqm/s wrqm/s %rrqm %wrqm r_await w_await aqu-sz rareq-sz wareq-sz svctm  %util
vda    0.00 512.00  0.00  2.00   0.00   0.00  0.00  0.00    0.00    0.40   0.20     0.00     4.00  0.39  20.00

Fixes: 5b18b5a73760 ("block: delete part_round_stats and switch to less precise counting")
Signed-off-by: Weiping Zhang <zhangweiping@didiglobal.com>
---
 block/blk-core.c | 19 ++++++++++++++-----
 block/blk.h      |  1 +
 block/genhd.c    |  2 +-
 3 files changed, 16 insertions(+), 6 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index ac00d2fa4eb4..789a5c40b6a6 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -1256,14 +1256,14 @@ unsigned int blk_rq_err_bytes(const struct request *rq)
 }
 EXPORT_SYMBOL_GPL(blk_rq_err_bytes);
 
-static void update_io_ticks(struct hd_struct *part, unsigned long now, bool end)
+static void update_io_ticks(struct hd_struct *part, unsigned long now, bool inflight)
 {
 	unsigned long stamp;
 again:
 	stamp = READ_ONCE(part->stamp);
 	if (unlikely(stamp != now)) {
-		if (likely(cmpxchg(&part->stamp, stamp, now) == stamp))
-			__part_stat_add(part, io_ticks, end ? now - stamp : 1);
+		if (likely(cmpxchg(&part->stamp, stamp, now) == stamp) && inflight)
+			__part_stat_add(part, io_ticks, now - stamp);
 	}
 	if (part->partno) {
 		part = &part_to_disk(part)->part0;
@@ -1310,13 +1310,20 @@ void blk_account_io_done(struct request *req, u64 now)
 
 void blk_account_io_start(struct request *rq)
 {
+	struct hd_struct *part;
+	struct request_queue *q;
+	int inflight;
+
 	if (!blk_do_io_stat(rq))
 		return;
 
 	rq->part = disk_map_sector_rcu(rq->rq_disk, blk_rq_pos(rq));
 
 	part_stat_lock();
-	update_io_ticks(rq->part, jiffies, false);
+	part = rq->part;
+	q = part_to_disk(part)->queue;
+	inflight = blk_mq_in_flight(q, part);
+	update_io_ticks(part, jiffies, inflight > 0 ? true : false);
 	part_stat_unlock();
 }
 
@@ -1325,12 +1332,14 @@ static unsigned long __part_start_io_acct(struct hd_struct *part,
 {
 	const int sgrp = op_stat_group(op);
 	unsigned long now = READ_ONCE(jiffies);
+	int inflight;
 
 	part_stat_lock();
-	update_io_ticks(part, now, false);
 	part_stat_inc(part, ios[sgrp]);
 	part_stat_add(part, sectors[sgrp], sectors);
 	part_stat_local_inc(part, in_flight[op_is_write(op)]);
+	inflight = part_in_flight(part);
+	update_io_ticks(part, now, inflight > 0 ? true : false);
 	part_stat_unlock();
 
 	return now;
diff --git a/block/blk.h b/block/blk.h
index dfab98465db9..0b9d1c13ceee 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -443,5 +443,6 @@ static inline void part_nr_sects_write(struct hd_struct *part, sector_t size)
 int bio_add_hw_page(struct request_queue *q, struct bio *bio,
 		struct page *page, unsigned int len, unsigned int offset,
 		unsigned int max_sectors, bool *same_page);
+unsigned int part_in_flight(struct hd_struct *part);
 
 #endif /* BLK_INTERNAL_H */
diff --git a/block/genhd.c b/block/genhd.c
index 0a273211fec2..89ef5539577a 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -109,7 +109,7 @@ static void part_stat_read_all(struct hd_struct *part, struct disk_stats *stat)
 	}
 }
 
-static unsigned int part_in_flight(struct hd_struct *part)
+unsigned int part_in_flight(struct hd_struct *part)
 {
 	unsigned int inflight = 0;
 	int cpu;
-- 
2.18.4

