Return-Path: <SRS0=A/1A=5J=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAA6DC10DCE
	for <linux-block@archiver.kernel.org>; Tue, 24 Mar 2020 06:39:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 903B420771
	for <linux-block@archiver.kernel.org>; Tue, 24 Mar 2020 06:39:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="IUxsI2KO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727380AbgCXGjt (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 24 Mar 2020 02:39:49 -0400
Received: from forwardcorp1p.mail.yandex.net ([77.88.29.217]:49282 "EHLO
        forwardcorp1p.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727328AbgCXGjt (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 24 Mar 2020 02:39:49 -0400
Received: from mxbackcorp1g.mail.yandex.net (mxbackcorp1g.mail.yandex.net [IPv6:2a02:6b8:0:1402::301])
        by forwardcorp1p.mail.yandex.net (Yandex) with ESMTP id 05E5A2E151F;
        Tue, 24 Mar 2020 09:39:45 +0300 (MSK)
Received: from myt4-18a966dbd9be.qloud-c.yandex.net (myt4-18a966dbd9be.qloud-c.yandex.net [2a02:6b8:c00:12ad:0:640:18a9:66db])
        by mxbackcorp1g.mail.yandex.net (mxbackcorp/Yandex) with ESMTP id rPzhyygJ86-di4q6Os5;
        Tue, 24 Mar 2020 09:39:45 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru; s=default;
        t=1585031985; bh=zh5H7xtrpjC0B6xsaGoNkXsuvDRcxQzlG8ZeX056csA=;
        h=In-Reply-To:Message-ID:References:Date:To:From:Subject:Cc;
        b=IUxsI2KOyuK0KER3goVmBkGkUm4WcVlHZmPoyuNGHZlVzEujLMGVor9N57gC3LLng
         StV3tOLXGvPJKcLu36pdCEkeOjfIUdFbD5cMnHxKuPYiSG+TsJD7VzZ1+gwunphc9S
         hJMhwGQoH6xmvDiKGlhpgKRijnBuXKXK25uY8+4Y=
Authentication-Results: mxbackcorp1g.mail.yandex.net; dkim=pass header.i=@yandex-team.ru
Received: from unknown (unknown [2a02:6b8:b080:6410::1:2])
        by myt4-18a966dbd9be.qloud-c.yandex.net (smtpcorp/Yandex) with ESMTPSA id oSRgcI6OWu-diaaVDYI;
        Tue, 24 Mar 2020 09:39:44 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client certificate not present)
Subject: [PATCH v3 2/3] block/diskstats: accumulate all per-cpu counters in
 one pass
From:   Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
To:     linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        linux-kernel@vger.kernel.org
Cc:     Mikulas Patocka <mpatocka@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Ming Lei <ming.lei@redhat.com>
Date:   Tue, 24 Mar 2020 09:39:43 +0300
Message-ID: <158503198306.1955.15150686320152629671.stgit@buzz>
In-Reply-To: <158503038812.1955.7827988255138056389.stgit@buzz>
References: <158503038812.1955.7827988255138056389.stgit@buzz>
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
 block/genhd.c             |   61 +++++++++++++++++++++++++++++++++------------
 block/partition-generic.c |   35 ++++++++++++++------------
 include/linux/genhd.h     |   11 ++++++--
 3 files changed, 72 insertions(+), 35 deletions(-)

diff --git a/block/genhd.c b/block/genhd.c
index b210c12c4870..606e8755f6ed 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -69,6 +69,28 @@ void set_capacity_revalidate_and_notify(struct gendisk *disk, sector_t size,
 
 EXPORT_SYMBOL_GPL(set_capacity_revalidate_and_notify);
 
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
+#endif /* CONFIG_SMP */
 
 void part_inc_in_flight(struct request_queue *q, struct hd_struct *part, int rw)
 {
@@ -1429,6 +1451,7 @@ static int diskstats_show(struct seq_file *seqf, void *v)
 	struct hd_struct *hd;
 	char buf[BDEVNAME_SIZE];
 	unsigned int inflight;
+	struct disk_stats stat;
 
 	/*
 	if (&disk_to_dev(gp)->kobj.entry == block_class.devices.next)
@@ -1440,7 +1463,9 @@ static int diskstats_show(struct seq_file *seqf, void *v)
 
 	disk_part_iter_init(&piter, gp, DISK_PITER_INCL_EMPTY_PART0);
 	while ((hd = disk_part_iter_next(&piter))) {
+		part_stat_read_all(hd, &stat);
 		inflight = part_in_flight(gp->queue, hd);
+
 		seq_printf(seqf, "%4d %7d %s "
 			   "%lu %lu %lu %u "
 			   "%lu %lu %lu %u "
@@ -1450,23 +1475,27 @@ static int diskstats_show(struct seq_file *seqf, void *v)
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
diff --git a/block/partition-generic.c b/block/partition-generic.c
index 564fae77711d..6d3fcb5187cb 100644
--- a/block/partition-generic.c
+++ b/block/partition-generic.c
@@ -120,9 +120,12 @@ ssize_t part_stat_show(struct device *dev,
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
@@ -130,23 +133,23 @@ ssize_t part_stat_show(struct device *dev,
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
diff --git a/include/linux/genhd.h b/include/linux/genhd.h
index f1066f10b062..ead3ffb7f327 100644
--- a/include/linux/genhd.h
+++ b/include/linux/genhd.h
@@ -375,6 +375,8 @@ static inline void part_stat_set_all(struct hd_struct *part, int value)
 				sizeof(struct disk_stats));
 }
 
+void part_stat_read_all(struct hd_struct *part, struct disk_stats *stat);
+
 static inline int init_part_stats(struct hd_struct *part)
 {
 	part->dkstats = alloc_percpu(struct disk_stats);
@@ -401,6 +403,12 @@ static inline void part_stat_set_all(struct hd_struct *part, int value)
 	memset(&part->dkstats, value, sizeof(struct disk_stats));
 }
 
+static inline void part_stat_read_all(struct hd_struct *part,
+				      struct disk_stats *stat)
+{
+	memcpy(stat, &part->dkstats, sizeof(struct disk_stats));
+}
+
 static inline int init_part_stats(struct hd_struct *part)
 {
 	return 1;
@@ -412,9 +420,6 @@ static inline void free_part_stats(struct hd_struct *part)
 
 #endif /* CONFIG_SMP */
 
-#define part_stat_read_msecs(part, which)				\
-	div_u64(part_stat_read(part, nsecs[which]), NSEC_PER_MSEC)
-
 #define part_stat_read_accum(part, field)				\
 	(part_stat_read(part, field[STAT_READ]) +			\
 	 part_stat_read(part, field[STAT_WRITE]) +			\

