Return-Path: <SRS0=VELz=OO=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 133E9C04EB9
	for <linux-block@archiver.kernel.org>; Wed,  5 Dec 2018 20:24:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C22D920989
	for <linux-block@archiver.kernel.org>; Wed,  5 Dec 2018 20:24:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="maq5ei4I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C22D920989
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728391AbeLEUYs (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 5 Dec 2018 15:24:48 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:34949 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727388AbeLEUYs (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 5 Dec 2018 15:24:48 -0500
Received: by mail-qt1-f195.google.com with SMTP id v11so23855381qtc.2
        for <linux-block@vger.kernel.org>; Wed, 05 Dec 2018 12:24:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=uDXGZWmWGlMBhtUHpFWeBKtFEXOqKhmCzRaLRoOIvZk=;
        b=maq5ei4I8Q+znxuXL0sUOoUljfHDWyHIbosxRQsiXx0xGCBnRu8ZyzsRNOSfb4ph9l
         twZzG85xR7jGgdn+PPIV5z8JYa6EWtYFV2G2UNioOBwFeIT1ikOwJGFCLzcu9q0ppsQJ
         wMc4ZZepU6SUaBrqqsaekmhcZlhnQAwDoyOLvt5BxlL3k88bMr7+o5HqPcjledrfrAWd
         CntO73h5KMBfbWpBlLgmo11lq3n6qD8nZ+NivB4MAtfQGeZzDfOyhcOPJZaG5EIs+7Nw
         tGxOFA4rH7EhAPUwxB8oIx2DDhBURxf7rzVq7las9//3kHbE8FeNgjRqW5eL24VZIeVb
         P+ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=uDXGZWmWGlMBhtUHpFWeBKtFEXOqKhmCzRaLRoOIvZk=;
        b=WZ+XWUHnGuYxSIjUuR3jEnCQLb0XfRUBJ/taBLZIjnxHRaK7GwRA1qxu05JxsKEE/K
         KXR9DJO4w42j3ob6t1XxofF8c6K5w5sHdYR6hEyHj6cew07AoxcbSed2HovecskNmy0Y
         jylHwXEaljXPMthlPRE4HeU85K4ElHrep3m4gcW9hB065va2GMZaFv+gAzddxnTDGrkN
         6fYTQooVrq9D+FIesyUvycv/T0zqvWjxGmZmoOk/Q5WrDKzGVjguZ8nkTc7Bx/dtvh3s
         HHxLmU9Q9iemycIF/mr2YPHSDlq1bZZSZ9GuxTEqKxcljtl9W9FleLsoEqfFDeG5qSPF
         akhw==
X-Gm-Message-State: AA+aEWb+0Q5XFXrpy2egpCFJFQZNibjXBlk85a4WbZZW51cXLwPkq62i
        dixzM7L5e9C18D8iBF9X0OI=
X-Google-Smtp-Source: AFSGD/Wv2ljeBsmMBPVdR5RsdKZdRXueaQX8heV/YxYz4H3V+l06mf8TQx8ClYLs61bU5qJVHX4AsA==
X-Received: by 2002:aed:2aa3:: with SMTP id t32mr24558973qtd.25.1544041486532;
        Wed, 05 Dec 2018 12:24:46 -0800 (PST)
Received: from localhost (pool-68-160-144-192.bstnma.fios.verizon.net. [68.160.144.192])
        by smtp.gmail.com with ESMTPSA id q38sm12426825qtj.65.2018.12.05.12.24.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Dec 2018 12:24:45 -0800 (PST)
From:   Mike Snitzer <snitzer@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, dm-devel@redhat.com,
        Mikulas Patocka <mpatocka@redhat.com>
Subject: [PATCH v3 6/7] block: return just one value from part_in_flight
Date:   Wed,  5 Dec 2018 15:24:32 -0500
Message-Id: <20181205202433.95823-7-snitzer@redhat.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20181205202433.95823-1-snitzer@redhat.com>
References: <20181205202433.95823-1-snitzer@redhat.com>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Mikulas Patocka <mpatocka@redhat.com>

The previous patches deleted all the code that needed the second value
returned from part_in_flight - now the kernel only uses the first value.

Consequently, part_in_flight (and blk_mq_in_flight) may be changed so that
it only returns one value.

This patch just refactors the code, there's no functional change.

Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
Signed-off-by: Mike Snitzer <snitzer@redhat.com>
---
 block/blk-mq.c            | 12 +++++-------
 block/blk-mq.h            |  3 +--
 block/genhd.c             | 32 +++++++++++---------------------
 block/partition-generic.c |  6 +++---
 include/linux/genhd.h     |  3 +--
 5 files changed, 21 insertions(+), 35 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 900550594651..c6d3101352f4 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -100,25 +100,23 @@ static bool blk_mq_check_inflight(struct blk_mq_hw_ctx *hctx,
 	struct mq_inflight *mi = priv;
 
 	/*
-	 * index[0] counts the specific partition that was asked for. index[1]
-	 * counts the ones that are active on the whole device, so increment
-	 * that if mi->part is indeed a partition, and not a whole device.
+	 * index[0] counts the specific partition that was asked for.
 	 */
 	if (rq->part == mi->part)
 		mi->inflight[0]++;
-	if (mi->part->partno)
-		mi->inflight[1]++;
 
 	return true;
 }
 
-void blk_mq_in_flight(struct request_queue *q, struct hd_struct *part,
-		      unsigned int inflight[2])
+unsigned int blk_mq_in_flight(struct request_queue *q, struct hd_struct *part)
 {
+	unsigned inflight[2];
 	struct mq_inflight mi = { .part = part, .inflight = inflight, };
 
 	inflight[0] = inflight[1] = 0;
 	blk_mq_queue_tag_busy_iter(q, blk_mq_check_inflight, &mi);
+
+	return inflight[0];
 }
 
 static bool blk_mq_check_inflight_rw(struct blk_mq_hw_ctx *hctx,
diff --git a/block/blk-mq.h b/block/blk-mq.h
index a664ea44ffd4..0c9c9ea2fefe 100644
--- a/block/blk-mq.h
+++ b/block/blk-mq.h
@@ -187,8 +187,7 @@ static inline bool blk_mq_hw_queue_mapped(struct blk_mq_hw_ctx *hctx)
 	return hctx->nr_ctx && hctx->tags;
 }
 
-void blk_mq_in_flight(struct request_queue *q, struct hd_struct *part,
-		      unsigned int inflight[2]);
+unsigned int blk_mq_in_flight(struct request_queue *q, struct hd_struct *part);
 void blk_mq_in_flight_rw(struct request_queue *q, struct hd_struct *part,
 			 unsigned int inflight[2]);
 
diff --git a/block/genhd.c b/block/genhd.c
index ffb9d416db64..dd84922192b6 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -71,34 +71,24 @@ void part_dec_in_flight(struct request_queue *q, struct hd_struct *part, int rw)
 		local_dec(&per_cpu_ptr(part_to_disk(part)->part0.dkstats, cpu)->in_flight[rw]);
 }
 
-void part_in_flight(struct request_queue *q, struct hd_struct *part,
-		    unsigned int inflight[2])
+unsigned int part_in_flight(struct request_queue *q, struct hd_struct *part)
 {
 	int cpu;
+	int inflight;
 
 	if (queue_is_mq(q)) {
-		blk_mq_in_flight(q, part, inflight);
-		return;
+		return blk_mq_in_flight(q, part);
 	}
 
-	inflight[0] = 0;
+	inflight = 0;
 	for_each_possible_cpu(cpu) {
-		inflight[0] +=	local_read(&per_cpu_ptr(part->dkstats, cpu)->in_flight[0]) +
+		inflight +=	local_read(&per_cpu_ptr(part->dkstats, cpu)->in_flight[0]) +
 				local_read(&per_cpu_ptr(part->dkstats, cpu)->in_flight[1]);
 	}
-	if ((int)inflight[0] < 0)
-		inflight[0] = 0;
+	if (inflight < 0)
+		inflight = 0;
 
-	if (part->partno) {
-		part = &part_to_disk(part)->part0;
-		inflight[1] = 0;
-		for_each_possible_cpu(cpu) {
-			inflight[1] +=	local_read(&per_cpu_ptr(part->dkstats, cpu)->in_flight[0]) +
-					local_read(&per_cpu_ptr(part->dkstats, cpu)->in_flight[1]);
-		}
-		if ((int)inflight[1] < 0)
-			inflight[1] = 0;
-	}
+	return (unsigned int)inflight;
 }
 
 void part_in_flight_rw(struct request_queue *q, struct hd_struct *part,
@@ -1354,7 +1344,7 @@ static int diskstats_show(struct seq_file *seqf, void *v)
 	struct disk_part_iter piter;
 	struct hd_struct *hd;
 	char buf[BDEVNAME_SIZE];
-	unsigned int inflight[2];
+	unsigned int inflight;
 
 	/*
 	if (&disk_to_dev(gp)->kobj.entry == block_class.devices.next)
@@ -1366,7 +1356,7 @@ static int diskstats_show(struct seq_file *seqf, void *v)
 
 	disk_part_iter_init(&piter, gp, DISK_PITER_INCL_EMPTY_PART0);
 	while ((hd = disk_part_iter_next(&piter))) {
-		part_in_flight(gp->queue, hd, inflight);
+		inflight = part_in_flight(gp->queue, hd);
 		seq_printf(seqf, "%4d %7d %s "
 			   "%lu %lu %lu %u "
 			   "%lu %lu %lu %u "
@@ -1382,7 +1372,7 @@ static int diskstats_show(struct seq_file *seqf, void *v)
 			   part_stat_read(hd, merges[STAT_WRITE]),
 			   part_stat_read(hd, sectors[STAT_WRITE]),
 			   (unsigned int)part_stat_read_msecs(hd, STAT_WRITE),
-			   inflight[0],
+			   inflight,
 			   jiffies_to_msecs(part_stat_read(hd, io_ticks)),
 			   jiffies_to_msecs(part_stat_read(hd, time_in_queue)),
 			   part_stat_read(hd, ios[STAT_DISCARD]),
diff --git a/block/partition-generic.c b/block/partition-generic.c
index 42d6138ac876..8e596a8dff32 100644
--- a/block/partition-generic.c
+++ b/block/partition-generic.c
@@ -120,9 +120,9 @@ ssize_t part_stat_show(struct device *dev,
 {
 	struct hd_struct *p = dev_to_part(dev);
 	struct request_queue *q = part_to_disk(p)->queue;
-	unsigned int inflight[2];
+	unsigned int inflight;
 
-	part_in_flight(q, p, inflight);
+	inflight = part_in_flight(q, p);
 	return sprintf(buf,
 		"%8lu %8lu %8llu %8u "
 		"%8lu %8lu %8llu %8u "
@@ -137,7 +137,7 @@ ssize_t part_stat_show(struct device *dev,
 		part_stat_read(p, merges[STAT_WRITE]),
 		(unsigned long long)part_stat_read(p, sectors[STAT_WRITE]),
 		(unsigned int)part_stat_read_msecs(p, STAT_WRITE),
-		inflight[0],
+		inflight,
 		jiffies_to_msecs(part_stat_read(p, io_ticks)),
 		jiffies_to_msecs(part_stat_read(p, time_in_queue)),
 		part_stat_read(p, ios[STAT_DISCARD]),
diff --git a/include/linux/genhd.h b/include/linux/genhd.h
index 9489dcb7cc27..669b7fe400d7 100644
--- a/include/linux/genhd.h
+++ b/include/linux/genhd.h
@@ -377,8 +377,7 @@ static inline void free_part_stats(struct hd_struct *part)
 #define part_stat_sub(gendiskp, field, subnd)				\
 	part_stat_add(gendiskp, field, -subnd)
 
-void part_in_flight(struct request_queue *q, struct hd_struct *part,
-		    unsigned int inflight[2]);
+unsigned int part_in_flight(struct request_queue *q, struct hd_struct *part);
 void part_in_flight_rw(struct request_queue *q, struct hd_struct *part,
 		       unsigned int inflight[2]);
 void part_dec_in_flight(struct request_queue *q, struct hd_struct *part,
-- 
2.18.0

