Return-Path: <SRS0=QnQz=SD=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EA38C43381
	for <linux-block@archiver.kernel.org>; Mon,  1 Apr 2019 15:59:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37A84208E4
	for <linux-block@archiver.kernel.org>; Mon,  1 Apr 2019 15:59:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="Yj2qE5KK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726988AbfDAP7u (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 1 Apr 2019 11:59:50 -0400
Received: from forwardcorp1o.cmail.yandex.net ([37.9.109.47]:45260 "EHLO
        forwardcorp1o.cmail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726854AbfDAP7u (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 1 Apr 2019 11:59:50 -0400
Received: from mxbackcorp1j.mail.yandex.net (mxbackcorp1j.mail.yandex.net [IPv6:2a02:6b8:0:1619::162])
        by forwardcorp1o.cmail.yandex.net (Yandex) with ESMTP id 4B80C206BD;
        Mon,  1 Apr 2019 18:59:45 +0300 (MSK)
Received: from smtpcorp1j.mail.yandex.net (smtpcorp1j.mail.yandex.net [2a02:6b8:0:1619::137])
        by mxbackcorp1j.mail.yandex.net (nwsmtp/Yandex) with ESMTP id 2NvtQEIcUi-xi3uHpiN;
        Mon, 01 Apr 2019 18:59:45 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru; s=default;
        t=1554134385; bh=y8USvex3STgIs8K+tWWDUwi0jSkeeDtmX3bMnZAm4pI=;
        h=Message-ID:Date:To:From:Subject:Cc;
        b=Yj2qE5KKRqmaqLDxT7DNTD+Dibxy/kXxh6TnnDSzN3qopp92qZvPgO6MIa45+ORPx
         2S8imaaBM1bjPiMGcv3mvj9TzsuxZA3QLHi0tEq5wHMkNdLWGDTMLu7Vr0CISi04az
         UppgDT5kJr5uTI0tNMoRrYOB2Eecu+PU6y/35P2w=
Authentication-Results: mxbackcorp1j.mail.yandex.net; dkim=pass header.i=@yandex-team.ru
Received: from dynamic-red.dhcp.yndx.net (dynamic-red.dhcp.yndx.net [2a02:6b8:0:40c:d4bb:795:9728:5f59])
        by smtpcorp1j.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id ugulgdamz1-xiBeQ7LV;
        Mon, 01 Apr 2019 18:59:44 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client certificate not present)
Subject: [PATCH 1/3] block/diskstats: accumulate all per-cpu counters in one
 pass
From:   Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
To:     linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        linux-kernel@vger.kernel.org
Cc:     Mikulas Patocka <mpatocka@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>
Date:   Mon, 01 Apr 2019 18:59:43 +0300
Message-ID: <155413438394.3201.15211440151043943989.stgit@buzz>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This is faster and makes code much smaller:

./scripts/bloat-o-meter vmlinux.before vmlinux.after
add/remove: 1/0 grow/shrink: 0/2 up/down: 176/-1348 (-1172)
Function                                     old     new   delta
part_stat_read_all                             -     176    +176
diskstats_show                              1190     569    -621
part_stat_show                              1064     337    -727
Total: Before=13762189, After=13761017, chg -0.01%

Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
---
 block/genhd.c             |   62 +++++++++++++++++++++++++++++++++++----------
 block/partition-generic.c |   31 ++++++++++++-----------
 include/linux/genhd.h     |    5 +---
 3 files changed, 67 insertions(+), 31 deletions(-)

diff --git a/block/genhd.c b/block/genhd.c
index 703267865f14..2f986af81ba1 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -45,6 +45,34 @@ static void disk_add_events(struct gendisk *disk);
 static void disk_del_events(struct gendisk *disk);
 static void disk_release_events(struct gendisk *disk);
 
+#ifdef CONFIG_SMP
+void part_stat_read_all(struct hd_struct *part, struct disk_stats *stat)
+{
+	int cpu;
+
+	memset(stat, 0, sizeof(struct disk_stats));
+	for_each_possible_cpu(cpu) {
+		struct disk_stats *ptr = per_cpu_ptr(part->dkstats, cpu);
+		int group;
+
+		for (group = 0; group < NR_STAT_GROUPS; group++) {
+			stat->nsecs[group] += ptr->nsecs[group];
+			stat->sectors[group] += ptr->sectors[group];
+			stat->ios[group] += ptr->ios[group];
+			stat->merges[group] += ptr->merges[group];
+		}
+
+		stat->io_ticks += ptr->io_ticks;
+		stat->time_in_queue += ptr->time_in_queue;
+	}
+}
+#else /* CONFIG_SMP */
+void part_stat_read_all(struct hd_struct *part, struct disk_stats *stat)
+{
+	memcpy(stat, &part->dkstats, sizeof(struct disk_stats));
+}
+#endif /* CONFIG_SMP */
+
 void part_inc_in_flight(struct request_queue *q, struct hd_struct *part, int rw)
 {
 	if (queue_is_mq(q))
@@ -1341,6 +1369,7 @@ static int diskstats_show(struct seq_file *seqf, void *v)
 	struct hd_struct *hd;
 	char buf[BDEVNAME_SIZE];
 	unsigned int inflight;
+	struct disk_stats stat;
 
 	/*
 	if (&disk_to_dev(gp)->kobj.entry == block_class.devices.next)
@@ -1352,7 +1381,9 @@ static int diskstats_show(struct seq_file *seqf, void *v)
 
 	disk_part_iter_init(&piter, gp, DISK_PITER_INCL_EMPTY_PART0);
 	while ((hd = disk_part_iter_next(&piter))) {
+		part_stat_read_all(hd, &stat);
 		inflight = part_in_flight(gp->queue, hd);
+
 		seq_printf(seqf, "%4d %7d %s "
 			   "%lu %lu %lu %u "
 			   "%lu %lu %lu %u "
@@ -1360,21 +1391,24 @@ static int diskstats_show(struct seq_file *seqf, void *v)
 			   "%lu %lu %lu %u\n",
 			   MAJOR(part_devt(hd)), MINOR(part_devt(hd)),
 			   disk_name(gp, hd->partno, buf),
-			   part_stat_read(hd, ios[STAT_READ]),
-			   part_stat_read(hd, merges[STAT_READ]),
-			   part_stat_read(hd, sectors[STAT_READ]),
-			   (unsigned int)part_stat_read_msecs(hd, STAT_READ),
-			   part_stat_read(hd, ios[STAT_WRITE]),
-			   part_stat_read(hd, merges[STAT_WRITE]),
-			   part_stat_read(hd, sectors[STAT_WRITE]),
-			   (unsigned int)part_stat_read_msecs(hd, STAT_WRITE),
+			   stat.ios[STAT_READ],
+			   stat.merges[STAT_READ],
+			   stat.sectors[STAT_READ],
+			   (unsigned int)div_u64(stat.nsecs[STAT_READ],
+							NSEC_PER_MSEC),
+			   stat.ios[STAT_WRITE],
+			   stat.merges[STAT_WRITE],
+			   stat.sectors[STAT_WRITE],
+			   (unsigned int)div_u64(stat.nsecs[STAT_WRITE],
+							NSEC_PER_MSEC),
 			   inflight,
-			   jiffies_to_msecs(part_stat_read(hd, io_ticks)),
-			   jiffies_to_msecs(part_stat_read(hd, time_in_queue)),
-			   part_stat_read(hd, ios[STAT_DISCARD]),
-			   part_stat_read(hd, merges[STAT_DISCARD]),
-			   part_stat_read(hd, sectors[STAT_DISCARD]),
-			   (unsigned int)part_stat_read_msecs(hd, STAT_DISCARD)
+			   jiffies_to_msecs(stat.io_ticks),
+			   jiffies_to_msecs(stat.time_in_queue),
+			   stat.ios[STAT_DISCARD],
+			   stat.merges[STAT_DISCARD],
+			   stat.sectors[STAT_DISCARD],
+			   (unsigned int)div_u64(stat.nsecs[STAT_DISCARD],
+							NSEC_PER_MSEC)
 			);
 	}
 	disk_part_iter_exit(&piter);
diff --git a/block/partition-generic.c b/block/partition-generic.c
index 8e596a8dff32..621e0d9f3c92 100644
--- a/block/partition-generic.c
+++ b/block/partition-generic.c
@@ -120,30 +120,33 @@ ssize_t part_stat_show(struct device *dev,
 {
 	struct hd_struct *p = dev_to_part(dev);
 	struct request_queue *q = part_to_disk(p)->queue;
+	struct disk_stats stat;
 	unsigned int inflight;
 
+	part_stat_read_all(p, &stat);
 	inflight = part_in_flight(q, p);
+
 	return sprintf(buf,
 		"%8lu %8lu %8llu %8u "
 		"%8lu %8lu %8llu %8u "
 		"%8u %8u %8u "
 		"%8lu %8lu %8llu %8u"
 		"\n",
-		part_stat_read(p, ios[STAT_READ]),
-		part_stat_read(p, merges[STAT_READ]),
-		(unsigned long long)part_stat_read(p, sectors[STAT_READ]),
-		(unsigned int)part_stat_read_msecs(p, STAT_READ),
-		part_stat_read(p, ios[STAT_WRITE]),
-		part_stat_read(p, merges[STAT_WRITE]),
-		(unsigned long long)part_stat_read(p, sectors[STAT_WRITE]),
-		(unsigned int)part_stat_read_msecs(p, STAT_WRITE),
+		stat.ios[STAT_READ],
+		stat.merges[STAT_READ],
+		(unsigned long long)stat.sectors[STAT_READ],
+		(unsigned int)div_u64(stat.nsecs[STAT_READ], NSEC_PER_MSEC),
+		stat.ios[STAT_WRITE],
+		stat.merges[STAT_WRITE],
+		(unsigned long long)stat.sectors[STAT_WRITE],
+		(unsigned int)div_u64(stat.nsecs[STAT_WRITE], NSEC_PER_MSEC),
 		inflight,
-		jiffies_to_msecs(part_stat_read(p, io_ticks)),
-		jiffies_to_msecs(part_stat_read(p, time_in_queue)),
-		part_stat_read(p, ios[STAT_DISCARD]),
-		part_stat_read(p, merges[STAT_DISCARD]),
-		(unsigned long long)part_stat_read(p, sectors[STAT_DISCARD]),
-		(unsigned int)part_stat_read_msecs(p, STAT_DISCARD));
+		jiffies_to_msecs(stat.io_ticks),
+		jiffies_to_msecs(stat.time_in_queue),
+		stat.ios[STAT_DISCARD],
+		stat.merges[STAT_DISCARD],
+		(unsigned long long)stat.sectors[STAT_DISCARD],
+		(unsigned int)div_u64(stat.nsecs[STAT_DISCARD], NSEC_PER_MSEC));
 }
 
 ssize_t part_inflight_show(struct device *dev, struct device_attribute *attr,
diff --git a/include/linux/genhd.h b/include/linux/genhd.h
index 06c0fd594097..7f981be190b4 100644
--- a/include/linux/genhd.h
+++ b/include/linux/genhd.h
@@ -357,9 +357,6 @@ static inline void free_part_stats(struct hd_struct *part)
 
 #endif /* CONFIG_SMP */
 
-#define part_stat_read_msecs(part, which)				\
-	div_u64(part_stat_read(part, nsecs[which]), NSEC_PER_MSEC)
-
 #define part_stat_read_accum(part, field)				\
 	(part_stat_read(part, field[STAT_READ]) +			\
 	 part_stat_read(part, field[STAT_WRITE]) +			\
@@ -391,6 +388,8 @@ static inline void free_part_stats(struct hd_struct *part)
 #define part_stat_local_read_cpu(gendiskp, field, cpu)			\
 	local_read(&(part_stat_get_cpu(gendiskp, field, cpu)))
 
+void part_stat_read_all(struct hd_struct *part, struct disk_stats *stat);
+
 unsigned int part_in_flight(struct request_queue *q, struct hd_struct *part);
 void part_in_flight_rw(struct request_queue *q, struct hd_struct *part,
 		       unsigned int inflight[2]);

