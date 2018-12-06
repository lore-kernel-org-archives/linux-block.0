Return-Path: <SRS0=YK6u=OP=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2D26C64EB1
	for <linux-block@archiver.kernel.org>; Thu,  6 Dec 2018 16:41:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F21620838
	for <linux-block@archiver.kernel.org>; Thu,  6 Dec 2018 16:41:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y2FIg8DE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F21620838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726034AbeLFQlk (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 6 Dec 2018 11:41:40 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:44496 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725896AbeLFQlj (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 6 Dec 2018 11:41:39 -0500
Received: by mail-qt1-f196.google.com with SMTP id n32so1185700qte.11
        for <linux-block@vger.kernel.org>; Thu, 06 Dec 2018 08:41:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=XfUbBH6Cr+GEY0pE8uAPo/0HeFQFgkb69YK480+bzXg=;
        b=Y2FIg8DEwly6TEvFuo/G76K96SJhY4FdFHHQKRvDlmqJ85zYeciMiqmUCJMMYOPvi8
         2mVEql1C1m0i4rRzckcdAUtx2PzAtiuIsH1Ybab76heVaCgBSWYA5H4BLNbxrfgEE1Hu
         KUFAgFon1OTfVsmA/zFK6uA+c1l9J1F+DERCwQAsyUcouozudUMY5DUdn2YGKValmzJK
         191VHqNKTdO7AGSn7Xzbs+R5ujYHhGfXU6VKNQheWue0KnRytB4X9v1Z8qozeBo84NP5
         Lf1yWFAG4ypSKnzt1wUwqXmx52nqcvigQ6qXGBLjIOzPd6w0B07FSnSSVxVxCLOnjS6i
         Zu5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=XfUbBH6Cr+GEY0pE8uAPo/0HeFQFgkb69YK480+bzXg=;
        b=C8WzM/RjciBVseF0xeX6iY09+1mD6DXIRpQ9bTilDQJthW0mQKMoOrb9o/IYr57xgN
         K1iKT+Z1W8bHez5KawC6Ey2emmeLt8ZzTx3sSWCUegLaiWYdN05Ob0UAtznHLC5uLvG2
         2qUto5s1iKkYeSQ8UjlLyl813itk5KGw2UK4zVYz4A+lEVZxYDWA6dWljYkPEhICg+mu
         2FGa/VShmO3E5yG/pAQbGJjDG54MkTNnN80C97foE4HY60pR+9nrCe/oQ09k4BfUGQJT
         pc31Wiub907UuULMew9Vxzn9d2cy+g12iox6AlUSjITHzynJJp3jVh58ksgnUXHXyrpy
         bGrw==
X-Gm-Message-State: AA+aEWau/KU/6szBTpSGGUKR26t2IO6Ly2SLVuVYjpXq4lb53q4raPDR
        INwsmRliv8P9ZxVESeeS+rQ=
X-Google-Smtp-Source: AFSGD/VQdyMZQbgHEZF5otRR3yNwFAIHNqn+ZAYgHVUUqyqJEIz7GelrXEimvj1Bbb281/16S/mbKg==
X-Received: by 2002:ac8:354e:: with SMTP id z14mr28336024qtb.272.1544114498433;
        Thu, 06 Dec 2018 08:41:38 -0800 (PST)
Received: from localhost (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id d193sm701279qka.91.2018.12.06.08.41.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Dec 2018 08:41:37 -0800 (PST)
From:   Mike Snitzer <snitzer@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, dm-devel@redhat.com,
        Mikulas Patocka <mpatocka@redhat.com>
Subject: [PATCH v4 6/7] block: return just one value from part_in_flight
Date:   Thu,  6 Dec 2018 11:41:21 -0500
Message-Id: <20181206164122.2166-7-snitzer@redhat.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20181206164122.2166-1-snitzer@redhat.com>
References: <20181206164122.2166-1-snitzer@redhat.com>
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
 block/genhd.c             | 34 ++++++++++++----------------------
 block/partition-generic.c |  6 +++---
 include/linux/genhd.h     |  3 +--
 5 files changed, 22 insertions(+), 36 deletions(-)

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
index 9827a2c05db7..1dd8fd6613b8 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -65,34 +65,24 @@ void part_dec_in_flight(struct request_queue *q, struct hd_struct *part, int rw)
 		part_stat_local_dec(&part_to_disk(part)->part0, in_flight[rw]);
 }
 
-void part_in_flight(struct request_queue *q, struct hd_struct *part,
-		    unsigned int inflight[2])
+unsigned int part_in_flight(struct request_queue *q, struct hd_struct *part)
 {
 	int cpu;
+	unsigned int inflight;
 
 	if (queue_is_mq(q)) {
-		blk_mq_in_flight(q, part, inflight);
-		return;
+		return blk_mq_in_flight(q, part);
 	}
 
-	inflight[0] = 0;
+	inflight = 0;
 	for_each_possible_cpu(cpu) {
-		inflight[0] += part_stat_local_read_cpu(part, in_flight[0], cpu) +
-			       part_stat_local_read_cpu(part, in_flight[1], cpu);
+		inflight += part_stat_local_read_cpu(part, in_flight[0], cpu) +
+			    part_stat_local_read_cpu(part, in_flight[1], cpu);
 	}
-	if ((int)inflight[0] < 0)
-		inflight[0] = 0;
+	if ((int)inflight < 0)
+		inflight = 0;
 
-	if (part->partno) {
-		part = &part_to_disk(part)->part0;
-		inflight[1] = 0;
-		for_each_possible_cpu(cpu) {
-			inflight[1] += part_stat_local_read_cpu(part, in_flight[0], cpu) +
-				       part_stat_local_read_cpu(part, in_flight[1], cpu);
-		}
-		if ((int)inflight[1] < 0)
-			inflight[1] = 0;
-	}
+	return inflight;
 }
 
 void part_in_flight_rw(struct request_queue *q, struct hd_struct *part,
@@ -1348,7 +1338,7 @@ static int diskstats_show(struct seq_file *seqf, void *v)
 	struct disk_part_iter piter;
 	struct hd_struct *hd;
 	char buf[BDEVNAME_SIZE];
-	unsigned int inflight[2];
+	unsigned int inflight;
 
 	/*
 	if (&disk_to_dev(gp)->kobj.entry == block_class.devices.next)
@@ -1360,7 +1350,7 @@ static int diskstats_show(struct seq_file *seqf, void *v)
 
 	disk_part_iter_init(&piter, gp, DISK_PITER_INCL_EMPTY_PART0);
 	while ((hd = disk_part_iter_next(&piter))) {
-		part_in_flight(gp->queue, hd, inflight);
+		inflight = part_in_flight(gp->queue, hd);
 		seq_printf(seqf, "%4d %7d %s "
 			   "%lu %lu %lu %u "
 			   "%lu %lu %lu %u "
@@ -1376,7 +1366,7 @@ static int diskstats_show(struct seq_file *seqf, void *v)
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
index 636b4f687e35..06c0fd594097 100644
--- a/include/linux/genhd.h
+++ b/include/linux/genhd.h
@@ -391,8 +391,7 @@ static inline void free_part_stats(struct hd_struct *part)
 #define part_stat_local_read_cpu(gendiskp, field, cpu)			\
 	local_read(&(part_stat_get_cpu(gendiskp, field, cpu)))
 
-void part_in_flight(struct request_queue *q, struct hd_struct *part,
-		    unsigned int inflight[2]);
+unsigned int part_in_flight(struct request_queue *q, struct hd_struct *part);
 void part_in_flight_rw(struct request_queue *q, struct hd_struct *part,
 		       unsigned int inflight[2]);
 void part_dec_in_flight(struct request_queue *q, struct hd_struct *part,
-- 
2.15.0

