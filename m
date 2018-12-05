Return-Path: <SRS0=VELz=OO=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7465C04EB9
	for <linux-block@archiver.kernel.org>; Wed,  5 Dec 2018 20:24:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD02320989
	for <linux-block@archiver.kernel.org>; Wed,  5 Dec 2018 20:24:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vgoMiXIj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD02320989
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728360AbeLEUYq (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 5 Dec 2018 15:24:46 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:45487 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727388AbeLEUYq (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 5 Dec 2018 15:24:46 -0500
Received: by mail-qt1-f195.google.com with SMTP id e5so23809658qtr.12
        for <linux-block@vger.kernel.org>; Wed, 05 Dec 2018 12:24:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=5qg6a7Y6go7cyLi7i49o60iw5DUZNQ7KPvqRiUxLRyU=;
        b=vgoMiXIjJTwS80/Ru5Bd4OWuvZwGMxZfGnu9zF2hLsK5+lMUKXIHIyIFgsMPpMRfyn
         XrLEae4+YoEmbQ5tAexB+EP6oXUkNXDsXDLCTLxAHFQaUB/kD/YinW+K8rdQofenZ+N4
         MVVSsmXuit8jpJCybWpIEZnmyLK/d9LHxtm8ekrJ/W1P4aiKFHsq16eYutIyxla35kbM
         zhRMYsUrR4McY79xtK/slQX//yijX3yO71mFQs1z+6Mbrq3ncOtHh0m9S2rE+ddhXek6
         pJDJtVH8jvlzhj1os1ci3+QHRRUV8LBecKuGYsgkFMy3/uhEQmNkL1Ef6LJD4sfolvIu
         Th4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=5qg6a7Y6go7cyLi7i49o60iw5DUZNQ7KPvqRiUxLRyU=;
        b=JnO2bPtWlxNaBeLRRLLT8d6aKRXiS3QDlteaWq1WpQFgVnT0qekTWeS6FxBGlvG0y4
         uII4bnD2IOTOr1W1t4cpke9sgGhyO5uJjXeg7hluLsdH4sH8iwb0LUcf3dLHtKYVh+Pe
         IHc751j3IbSKOmek5zY+RdTGIh20XjkTy7jnCUhVoC+Bw549GEEzPyT0iXutqrFb5MR0
         BWbfw2PfiEc+I5bYlrT9DxOkh8zH2eJMC6nQsH6xPqMHXR8xdLryenn1XWSb5K5EqyAX
         widbiDRe9NAFjv3AGHfPm/E6yrTxnMUvUWx17n9Od8LYC7WQ6esBlWY6O3JzvSUngVuF
         fINQ==
X-Gm-Message-State: AA+aEWbR34HgtrmBzZ+OhPHvA+W3E2yTqlEPmvqr2/Hci2T9LPiTH8U6
        7oy7ZPj+5cgYO09rCgdOXu0=
X-Google-Smtp-Source: AFSGD/W0m9KSqMEEPdonxFDoyQR3WEOtXMM8b8DoFtLBqUaEnLcudoJozTpMcRfBYGYtHBBS/4ySJg==
X-Received: by 2002:a0c:a045:: with SMTP id b63mr25424831qva.164.1544041484655;
        Wed, 05 Dec 2018 12:24:44 -0800 (PST)
Received: from localhost (pool-68-160-144-192.bstnma.fios.verizon.net. [68.160.144.192])
        by smtp.gmail.com with ESMTPSA id o42sm14380641qtc.90.2018.12.05.12.24.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Dec 2018 12:24:43 -0800 (PST)
From:   Mike Snitzer <snitzer@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, dm-devel@redhat.com,
        Mikulas Patocka <mpatocka@redhat.com>
Subject: [PATCH v3 5/7] block: switch to per-cpu in-flight counters
Date:   Wed,  5 Dec 2018 15:24:31 -0500
Message-Id: <20181205202433.95823-6-snitzer@redhat.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20181205202433.95823-1-snitzer@redhat.com>
References: <20181205202433.95823-1-snitzer@redhat.com>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Mikulas Patocka <mpatocka@redhat.com>

Now when part_round_stats is gone, we can switch to per-cpu in-flight
counters.

We use the local-atomic type local_t, so that if part_inc_in_flight or
part_dec_in_flight is reentrantly called from an interrupt, the value will
be correct.

The other counters could be corrupted due to reentrant interrupt, but the
corruption only results in slight counter skew - the in_flight counter
must be exact, so it needs local_t.

Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
Signed-off-by: Mike Snitzer <snitzer@redhat.com>
---
 block/genhd.c         | 49 ++++++++++++++++++++++++++++++++++---------
 include/linux/genhd.h |  3 ++-
 2 files changed, 41 insertions(+), 11 deletions(-)

diff --git a/block/genhd.c b/block/genhd.c
index cdf174d7d329..ffb9d416db64 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -47,51 +47,80 @@ static void disk_release_events(struct gendisk *disk);
 
 void part_inc_in_flight(struct request_queue *q, struct hd_struct *part, int rw)
 {
+	int cpu;
+
 	if (queue_is_mq(q))
 		return;
 
-	atomic_inc(&part->in_flight[rw]);
+	cpu = smp_processor_id();
+	local_inc(&per_cpu_ptr(part->dkstats, cpu)->in_flight[rw]);
 	if (part->partno)
-		atomic_inc(&part_to_disk(part)->part0.in_flight[rw]);
+		local_inc(&per_cpu_ptr(part_to_disk(part)->part0.dkstats, cpu)->in_flight[rw]);
 }
 
 void part_dec_in_flight(struct request_queue *q, struct hd_struct *part, int rw)
 {
+	int cpu;
+
 	if (queue_is_mq(q))
 		return;
 
-	atomic_dec(&part->in_flight[rw]);
+	cpu = smp_processor_id();
+	local_dec(&per_cpu_ptr(part->dkstats, cpu)->in_flight[rw]);
 	if (part->partno)
-		atomic_dec(&part_to_disk(part)->part0.in_flight[rw]);
+		local_dec(&per_cpu_ptr(part_to_disk(part)->part0.dkstats, cpu)->in_flight[rw]);
 }
 
 void part_in_flight(struct request_queue *q, struct hd_struct *part,
 		    unsigned int inflight[2])
 {
+	int cpu;
+
 	if (queue_is_mq(q)) {
 		blk_mq_in_flight(q, part, inflight);
 		return;
 	}
 
-	inflight[0] = atomic_read(&part->in_flight[0]) +
-			atomic_read(&part->in_flight[1]);
+	inflight[0] = 0;
+	for_each_possible_cpu(cpu) {
+		inflight[0] +=	local_read(&per_cpu_ptr(part->dkstats, cpu)->in_flight[0]) +
+				local_read(&per_cpu_ptr(part->dkstats, cpu)->in_flight[1]);
+	}
+	if ((int)inflight[0] < 0)
+		inflight[0] = 0;
+
 	if (part->partno) {
 		part = &part_to_disk(part)->part0;
-		inflight[1] = atomic_read(&part->in_flight[0]) +
-				atomic_read(&part->in_flight[1]);
+		inflight[1] = 0;
+		for_each_possible_cpu(cpu) {
+			inflight[1] +=	local_read(&per_cpu_ptr(part->dkstats, cpu)->in_flight[0]) +
+					local_read(&per_cpu_ptr(part->dkstats, cpu)->in_flight[1]);
+		}
+		if ((int)inflight[1] < 0)
+			inflight[1] = 0;
 	}
 }
 
 void part_in_flight_rw(struct request_queue *q, struct hd_struct *part,
 		       unsigned int inflight[2])
 {
+	int cpu;
+
 	if (queue_is_mq(q)) {
 		blk_mq_in_flight_rw(q, part, inflight);
 		return;
 	}
 
-	inflight[0] = atomic_read(&part->in_flight[0]);
-	inflight[1] = atomic_read(&part->in_flight[1]);
+	inflight[0] = 0;
+	inflight[1] = 0;
+	for_each_possible_cpu(cpu) {
+		inflight[0] += local_read(&per_cpu_ptr(part->dkstats, cpu)->in_flight[0]);
+		inflight[1] += local_read(&per_cpu_ptr(part->dkstats, cpu)->in_flight[1]);
+	}
+	if ((int)inflight[0] < 0)
+		inflight[0] = 0;
+	if ((int)inflight[1] < 0)
+		inflight[1] = 0;
 }
 
 struct hd_struct *__disk_get_part(struct gendisk *disk, int partno)
diff --git a/include/linux/genhd.h b/include/linux/genhd.h
index 838c2a7a40c5..9489dcb7cc27 100644
--- a/include/linux/genhd.h
+++ b/include/linux/genhd.h
@@ -17,6 +17,7 @@
 #include <linux/percpu-refcount.h>
 #include <linux/uuid.h>
 #include <linux/blk_types.h>
+#include <asm/local.h>
 
 #ifdef CONFIG_BLOCK
 
@@ -89,6 +90,7 @@ struct disk_stats {
 	unsigned long merges[NR_STAT_GROUPS];
 	unsigned long io_ticks;
 	unsigned long time_in_queue;
+	local_t in_flight[2];
 };
 
 #define PARTITION_META_INFO_VOLNAMELTH	64
@@ -122,7 +124,6 @@ struct hd_struct {
 	int make_it_fail;
 #endif
 	unsigned long stamp;
-	atomic_t in_flight[2];
 #ifdef	CONFIG_SMP
 	struct disk_stats __percpu *dkstats;
 #else
-- 
2.18.0

