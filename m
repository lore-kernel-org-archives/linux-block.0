Return-Path: <SRS0=yjA8=5K=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAA44C54FD3
	for <linux-block@archiver.kernel.org>; Wed, 25 Mar 2020 13:07:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A0942078D
	for <linux-block@archiver.kernel.org>; Wed, 25 Mar 2020 13:07:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="qnbYGJq8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727547AbgCYNHK (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 25 Mar 2020 09:07:10 -0400
Received: from forwardcorp1j.mail.yandex.net ([5.45.199.163]:38498 "EHLO
        forwardcorp1j.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727275AbgCYNHK (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 25 Mar 2020 09:07:10 -0400
Received: from mxbackcorp1o.mail.yandex.net (mxbackcorp1o.mail.yandex.net [IPv6:2a02:6b8:0:1a2d::301])
        by forwardcorp1j.mail.yandex.net (Yandex) with ESMTP id 124F02E1564;
        Wed, 25 Mar 2020 16:07:07 +0300 (MSK)
Received: from vla1-81430ab5870b.qloud-c.yandex.net (vla1-81430ab5870b.qloud-c.yandex.net [2a02:6b8:c0d:35a1:0:640:8143:ab5])
        by mxbackcorp1o.mail.yandex.net (mxbackcorp/Yandex) with ESMTP id 0ZfgZTMiiq-76Y0fUx6;
        Wed, 25 Mar 2020 16:07:07 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru; s=default;
        t=1585141627; bh=kN5evJgfo1PXXDGLaUlt0K4nFK3qgfPaqiBOgDZOdGo=;
        h=In-Reply-To:Message-ID:References:Date:To:From:Subject:Cc;
        b=qnbYGJq8m8FcRMoLrzxJz58B9x54asaKgG/bByurxGYtoTMGplKy90Yx+M/A+TJI4
         xxZtNrXswoRcuJvBs6YtoLTv8vT0XB4TdjoTu57dTJ3ZjnviCeDTZuQiFA/qR/JknH
         lWU33Wx6zmnQb56rtlS5Qe2svQxO55ncwKUqP8s0=
Authentication-Results: mxbackcorp1o.mail.yandex.net; dkim=pass header.i=@yandex-team.ru
Received: from unknown (unknown [2a02:6b8:b080:8204::1:e])
        by vla1-81430ab5870b.qloud-c.yandex.net (smtpcorp/Yandex) with ESMTPSA id z4qV869qSD-76a0f0Xp;
        Wed, 25 Mar 2020 16:07:06 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client certificate not present)
Subject: [PATCH v4 2/3] block/diskstats: accumulate all per-cpu counters in
 one pass
From:   Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
To:     linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        linux-kernel@vger.kernel.org
Cc:     Mikulas Patocka <mpatocka@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Ming Lei <ming.lei@redhat.com>
Date:   Wed, 25 Mar 2020 16:07:06 +0300
Message-ID: <158514162626.7009.2583993017832653145.stgit@buzz>
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

Reading /proc/diskstats iterates over all cpus for summing each field.
It's faster to sum all fields in one pass.

Hammering /proc/diskstats with fio shows 2x performance improvement:

fio --name=test --numjobs=$JOBS --filename=/proc/diskstats \
    --size=1k --bs=1k --fallocate=none --create_on_open=1 \
    --time_based=1 --runtime=10 --invalidate=0 --group_report

	  JOBS=1	JOBS=10
Before:	  7k iops	64k iops
After:	 18k iops      120k iops

Also this way code is more compact:

add/remove: 1/0 grow/shrink: 0/2 up/down: 194/-1540 (-1346)
Function                                     old     new   delta
part_stat_read_all                             -     194    +194
diskstats_show                              1344     631    -713
part_stat_show                              1219     392    -827
Total: Before=14966947, After=14965601, chg -0.01%

Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
---
 block/genhd.c         |  102 ++++++++++++++++++++++++++++++++++---------------
 include/linux/genhd.h |    3 -
 2 files changed, 70 insertions(+), 35 deletions(-)

diff --git a/block/genhd.c b/block/genhd.c
index f7d60b620b97..9eb981f7e5a4 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -92,6 +92,34 @@ const char *bdevname(struct block_device *bdev, char *buf)
 }
 EXPORT_SYMBOL(bdevname);
 
+#ifdef CONFIG_SMP
+static void part_stat_read_all(struct hd_struct *part, struct disk_stats *stat)
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
+static void part_stat_read_all(struct hd_struct *part, struct disk_stats *stat)
+{
+	memcpy(stat, &part->dkstats, sizeof(struct disk_stats));
+}
+#endif /* CONFIG_SMP */
+
 void part_inc_in_flight(struct request_queue *q, struct hd_struct *part, int rw)
 {
 	if (queue_is_mq(q))
@@ -1214,9 +1242,12 @@ ssize_t part_stat_show(struct device *dev,
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
@@ -1224,23 +1255,23 @@ ssize_t part_stat_show(struct device *dev,
 		"%8lu %8lu %8llu %8u "
 		"%8lu %8u"
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
-		(unsigned int)part_stat_read_msecs(p, STAT_DISCARD),
-		part_stat_read(p, ios[STAT_FLUSH]),
-		(unsigned int)part_stat_read_msecs(p, STAT_FLUSH));
+		jiffies_to_msecs(stat.io_ticks),
+		jiffies_to_msecs(stat.time_in_queue),
+		stat.ios[STAT_DISCARD],
+		stat.merges[STAT_DISCARD],
+		(unsigned long long)stat.sectors[STAT_DISCARD],
+		(unsigned int)div_u64(stat.nsecs[STAT_DISCARD], NSEC_PER_MSEC),
+		stat.ios[STAT_FLUSH],
+		(unsigned int)div_u64(stat.nsecs[STAT_FLUSH], NSEC_PER_MSEC));
 }
 
 ssize_t part_inflight_show(struct device *dev, struct device_attribute *attr,
@@ -1492,6 +1523,7 @@ static int diskstats_show(struct seq_file *seqf, void *v)
 	struct hd_struct *hd;
 	char buf[BDEVNAME_SIZE];
 	unsigned int inflight;
+	struct disk_stats stat;
 
 	/*
 	if (&disk_to_dev(gp)->kobj.entry == block_class.devices.next)
@@ -1503,7 +1535,9 @@ static int diskstats_show(struct seq_file *seqf, void *v)
 
 	disk_part_iter_init(&piter, gp, DISK_PITER_INCL_EMPTY_PART0);
 	while ((hd = disk_part_iter_next(&piter))) {
+		part_stat_read_all(hd, &stat);
 		inflight = part_in_flight(gp->queue, hd);
+
 		seq_printf(seqf, "%4d %7d %s "
 			   "%lu %lu %lu %u "
 			   "%lu %lu %lu %u "
@@ -1513,23 +1547,27 @@ static int diskstats_show(struct seq_file *seqf, void *v)
 			   "\n",
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
-			   (unsigned int)part_stat_read_msecs(hd, STAT_DISCARD),
-			   part_stat_read(hd, ios[STAT_FLUSH]),
-			   (unsigned int)part_stat_read_msecs(hd, STAT_FLUSH)
+			   jiffies_to_msecs(stat.io_ticks),
+			   jiffies_to_msecs(stat.time_in_queue),
+			   stat.ios[STAT_DISCARD],
+			   stat.merges[STAT_DISCARD],
+			   stat.sectors[STAT_DISCARD],
+			   (unsigned int)div_u64(stat.nsecs[STAT_DISCARD],
+						 NSEC_PER_MSEC),
+			   stat.ios[STAT_FLUSH],
+			   (unsigned int)div_u64(stat.nsecs[STAT_FLUSH],
+						 NSEC_PER_MSEC)
 			);
 	}
 	disk_part_iter_exit(&piter);
diff --git a/include/linux/genhd.h b/include/linux/genhd.h
index 13bb51f37b3f..b0c588d1aa29 100644
--- a/include/linux/genhd.h
+++ b/include/linux/genhd.h
@@ -380,9 +380,6 @@ static inline void free_part_stats(struct hd_struct *part)
 
 #endif /* CONFIG_SMP */
 
-#define part_stat_read_msecs(part, which)				\
-	div_u64(part_stat_read(part, nsecs[which]), NSEC_PER_MSEC)
-
 #define part_stat_read_accum(part, field)				\
 	(part_stat_read(part, field[STAT_READ]) +			\
 	 part_stat_read(part, field[STAT_WRITE]) +			\

