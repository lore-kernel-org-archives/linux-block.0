Return-Path: <SRS0=YK6u=OP=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12EB9C65BAF
	for <linux-block@archiver.kernel.org>; Thu,  6 Dec 2018 16:41:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C20DC20838
	for <linux-block@archiver.kernel.org>; Thu,  6 Dec 2018 16:41:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TddTX+td"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C20DC20838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726020AbeLFQli (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 6 Dec 2018 11:41:38 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:37344 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725896AbeLFQli (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 6 Dec 2018 11:41:38 -0500
Received: by mail-qk1-f194.google.com with SMTP id 131so689533qkd.4
        for <linux-block@vger.kernel.org>; Thu, 06 Dec 2018 08:41:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=whhiNG3tXZdK2IE35hgGnKIrXnWcdYSeBEeAqJquoA8=;
        b=TddTX+tdpNJOc6uYUE/SpPHjNGz71Uo0ch0Qz8/jqnFH6DODUqJ/rVtBj3MW2mqgLW
         s6P6IOQXN77a8oq8TqT4e0oFxMWDHGy3r/SvDJW7Ko0Rb2T3mMpTvwqAjIhgeavRssQY
         Hy2rGN3fYWzoJHbdqT8aq+u8UTGSRJLCTDkmJ89zBOEAlz1pGAlTCzmz/pVfvyc1ro6Q
         ZkiKZTLzSoowLgfH0xV6msFCRmc0KI3Sf04cvoepLyXeU+NvtGP4YbKzc5bUfHyUmc3B
         zphFCSRiR7y4gAmDKCCCwWbgUTtN9r3Djr2fsxXgMk1RHwvg4tERBBVn9icPaqJDs0JG
         gf9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=whhiNG3tXZdK2IE35hgGnKIrXnWcdYSeBEeAqJquoA8=;
        b=cC/+TkpNAbaUhdTIiokf1a8gUBIo8yAyZhl/2oAnKxbrtgSlSI+CEz8DckPIezmWpq
         z32U8d4Oh7RpJ1cOH33TYf9fpE/W2ncS4Meda5TDNhdueRYbTKzmJYg15q4J7/8cF00h
         a8WM23EY6prHO+SKlQBNw7aw04bDAaZqvQYJ6qjNJERAFZaAZZl7w5ZbXowdQFuKhXDi
         re0CwnmcfeZX2DGVz6wp/aPxEVvYyXEmtLw+qDPPKC6fCV7nQiyA52YLZfVMxB5Fwce8
         R6dSwDdGLKaV3je4MySAPvN2tSdrwCj+Re1VRvtxRzD9yQQyVzA2E3013vOuYCdZHNCM
         f7HA==
X-Gm-Message-State: AA+aEWY4R6oLcAY6j08ot7U89sawwpYTvjNm/H6cMhydQQirkwdgbCsN
        kRlQOgTQURrcpb/HKNMLCUh3SaUd
X-Google-Smtp-Source: AFSGD/XLArqca/cAf/AAegjj3fhHG0wMQaLU6cfpCVH++fyfnFNDf3M2KY3J27iTuqn4CrOCJ3NEFw==
X-Received: by 2002:a37:688c:: with SMTP id d134mr27297745qkc.57.1544114496426;
        Thu, 06 Dec 2018 08:41:36 -0800 (PST)
Received: from localhost (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id u50sm903683qta.23.2018.12.06.08.41.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Dec 2018 08:41:35 -0800 (PST)
From:   Mike Snitzer <snitzer@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, dm-devel@redhat.com,
        Mikulas Patocka <mpatocka@redhat.com>
Subject: [PATCH v4 5/7] block: switch to per-cpu in-flight counters
Date:   Thu,  6 Dec 2018 11:41:20 -0500
Message-Id: <20181206164122.2166-6-snitzer@redhat.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20181206164122.2166-1-snitzer@redhat.com>
References: <20181206164122.2166-1-snitzer@redhat.com>
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
 block/genhd.c         | 43 +++++++++++++++++++++++++++++++++----------
 include/linux/genhd.h | 29 ++++++++++++++++++++++-------
 2 files changed, 55 insertions(+), 17 deletions(-)

diff --git a/block/genhd.c b/block/genhd.c
index cdf174d7d329..9827a2c05db7 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -50,9 +50,9 @@ void part_inc_in_flight(struct request_queue *q, struct hd_struct *part, int rw)
 	if (queue_is_mq(q))
 		return;
 
-	atomic_inc(&part->in_flight[rw]);
+	part_stat_local_inc(part, in_flight[rw]);
 	if (part->partno)
-		atomic_inc(&part_to_disk(part)->part0.in_flight[rw]);
+		part_stat_local_inc(&part_to_disk(part)->part0, in_flight[rw]);
 }
 
 void part_dec_in_flight(struct request_queue *q, struct hd_struct *part, int rw)
@@ -60,38 +60,61 @@ void part_dec_in_flight(struct request_queue *q, struct hd_struct *part, int rw)
 	if (queue_is_mq(q))
 		return;
 
-	atomic_dec(&part->in_flight[rw]);
+	part_stat_local_dec(part, in_flight[rw]);
 	if (part->partno)
-		atomic_dec(&part_to_disk(part)->part0.in_flight[rw]);
+		part_stat_local_dec(&part_to_disk(part)->part0, in_flight[rw]);
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
+		inflight[0] += part_stat_local_read_cpu(part, in_flight[0], cpu) +
+			       part_stat_local_read_cpu(part, in_flight[1], cpu);
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
+			inflight[1] += part_stat_local_read_cpu(part, in_flight[0], cpu) +
+				       part_stat_local_read_cpu(part, in_flight[1], cpu);
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
+		inflight[0] += part_stat_local_read_cpu(part, in_flight[0], cpu);
+		inflight[1] += part_stat_local_read_cpu(part, in_flight[1], cpu);
+	}
+	if ((int)inflight[0] < 0)
+		inflight[0] = 0;
+	if ((int)inflight[1] < 0)
+		inflight[1] = 0;
 }
 
 struct hd_struct *__disk_get_part(struct gendisk *disk, int partno)
diff --git a/include/linux/genhd.h b/include/linux/genhd.h
index 838c2a7a40c5..636b4f687e35 100644
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
@@ -295,8 +296,11 @@ extern struct hd_struct *disk_map_sector_rcu(struct gendisk *disk,
 #define part_stat_lock()	({ rcu_read_lock(); get_cpu(); })
 #define part_stat_unlock()	do { put_cpu(); rcu_read_unlock(); } while (0)
 
-#define __part_stat_add(part, field, addnd)				\
-	(per_cpu_ptr((part)->dkstats, smp_processor_id())->field += (addnd))
+#define part_stat_get_cpu(part, field, cpu)					\
+	(per_cpu_ptr((part)->dkstats, (cpu))->field)
+
+#define part_stat_get(part, field)					\
+	part_stat_get_cpu(part, field, smp_processor_id())
 
 #define part_stat_read(part, field)					\
 ({									\
@@ -333,10 +337,9 @@ static inline void free_part_stats(struct hd_struct *part)
 #define part_stat_lock()	({ rcu_read_lock(); 0; })
 #define part_stat_unlock()	rcu_read_unlock()
 
-#define __part_stat_add(part, field, addnd)				\
-	((part)->dkstats.field += addnd)
-
-#define part_stat_read(part, field)	((part)->dkstats.field)
+#define part_stat_get(part, field)		((part)->dkstats.field)
+#define part_stat_get_cpu(part, field, cpu)	part_stat_get(part, field)
+#define part_stat_read(part, field)		part_stat_get(part, field)
 
 static inline void part_stat_set_all(struct hd_struct *part, int value)
 {
@@ -362,6 +365,9 @@ static inline void free_part_stats(struct hd_struct *part)
 	 part_stat_read(part, field[STAT_WRITE]) +			\
 	 part_stat_read(part, field[STAT_DISCARD]))
 
+#define __part_stat_add(part, field, addnd)				\
+	(part_stat_get(part, field) += (addnd))
+
 #define part_stat_add(part, field, addnd)	do {			\
 	__part_stat_add((part), field, addnd);				\
 	if ((part)->partno)						\
@@ -376,6 +382,15 @@ static inline void free_part_stats(struct hd_struct *part)
 #define part_stat_sub(gendiskp, field, subnd)				\
 	part_stat_add(gendiskp, field, -subnd)
 
+#define part_stat_local_dec(gendiskp, field)				\
+	local_dec(&(part_stat_get(gendiskp, field)))
+#define part_stat_local_inc(gendiskp, field)				\
+	local_inc(&(part_stat_get(gendiskp, field)))
+#define part_stat_local_read(gendiskp, field)				\
+	local_read(&(part_stat_get(gendiskp, field)))
+#define part_stat_local_read_cpu(gendiskp, field, cpu)			\
+	local_read(&(part_stat_get_cpu(gendiskp, field, cpu)))
+
 void part_in_flight(struct request_queue *q, struct hd_struct *part,
 		    unsigned int inflight[2]);
 void part_in_flight_rw(struct request_queue *q, struct hd_struct *part,
-- 
2.15.0

