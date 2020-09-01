Return-Path: <SRS0=kheS=CK=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1015DC433E2
	for <linux-block@archiver.kernel.org>; Tue,  1 Sep 2020 18:56:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EAE822065F
	for <linux-block@archiver.kernel.org>; Tue,  1 Sep 2020 18:56:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598986608;
	bh=3s2Yw/bNvP1WTiAnTgIEY8ngBX73M0ZoeCaoNpDReWg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ZnHmT/pmdOWWr+thsvZ7EcFqTU6fdmiDo/ovls7vKA8fhvxEkmYghcnxPbSzmi/qU
	 xmCUXCjDeWkB4mciBBXCntIEOA3J8jKfOdZIAX6Q0PjpDuvI2NcMKzenxq8X55TC0V
	 CxZsdLVbyqkwNVj13F/529o7qNZSZ9QrBb3JR+Ng=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731375AbgIASxR (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 1 Sep 2020 14:53:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731329AbgIASxO (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 1 Sep 2020 14:53:14 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B55CC061244;
        Tue,  1 Sep 2020 11:53:14 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id d27so1738848qtg.4;
        Tue, 01 Sep 2020 11:53:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6GL4H8pij+pmYHNiyj1arTTHlbzqgLGjt59578Jx0II=;
        b=Xf4/aamsMdEx/yZ2bHoNq1RdPJ9KMsJVCeiC8A/RGlXxqVkMePHHHhDwHH+qzmu/Y3
         n9Syo9hvtP0Dk/O9OAH0ITX0S0NuKlDdBOMzhcDkbF+DbIoilxy3C+CFtyTCegiXXNMt
         WYesuWY0HT6/xGbQDx0XwSiLZg9P61eYq+gHpIR0y80Ni8HrJBFwmgIgSMrw/5FWflN7
         vOrHHnlsVjfz3cMRKdHZiiHy8AISdk3BmWqUmJ0KHnTJAnqNtlkwD3eDoGE5is9G1SGL
         najP9zacapJk6+8W7bt8Eyk2nPn2jK5rQwhzr4vGDSCt7HI4iRt3uQFAngQACqLdfgV1
         Up3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=6GL4H8pij+pmYHNiyj1arTTHlbzqgLGjt59578Jx0II=;
        b=JJS5pgx+Z+P4dPvLPNDG48hzAqMQZNYDi0rP0mnawCCH3F7ApM4clQrzpGpoHD1g1c
         GI91mbwLG3oRL5edGB7DrOtyUhGcn9EZ8aw1bGxJbkLdnBgrXEWvIZ55D7awE4DCWfTL
         JogR515oHgRWNojrXq0ISntL4AvKH3c4LRQzRw8fK9Sj6n4SUqdpuo34vTadW7d9s1Ld
         bliqEOrbDshDPELVGfDXKHtFBF3gGqWGy932JDbxnF4hgZ+gDNBtvTMsdQ21ky8jkRYs
         tyC+2rWphwvEj+IN2lJFYJuj1SRu+N1rswJiiuy73Fu2EumJKjyQXQsHoD/2HAwcDg1B
         nAeQ==
X-Gm-Message-State: AOAM531LzZTtjP84xCYUekv0RqbGEEAQGUWL3S+xg7iIzW3grGosNsLM
        1A5Y2uV7jd7A8bkTQDq3X34=
X-Google-Smtp-Source: ABdhPJwHkifWm2B1bW1JcFTu2RFjKovzm3fFIpUxV9ynAzKVIGr+zS0GUgQjkWHtC3EJ2xRc0xilPQ==
X-Received: by 2002:aed:2ce5:: with SMTP id g92mr3185524qtd.204.1598986393468;
        Tue, 01 Sep 2020 11:53:13 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:a198])
        by smtp.gmail.com with ESMTPSA id x28sm2340852qki.55.2020.09.01.11.53.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2020 11:53:13 -0700 (PDT)
From:   Tejun Heo <tj@kernel.org>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com, newella@fb.com,
        Tejun Heo <tj@kernel.org>
Subject: [PATCH 03/27] blk-iocost: use local[64]_t for percpu stat
Date:   Tue,  1 Sep 2020 14:52:33 -0400
Message-Id: <20200901185257.645114-4-tj@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200901185257.645114-1-tj@kernel.org>
References: <20200901185257.645114-1-tj@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

blk-iocost has been reading percpu stat counters from remote cpus which on
some archs can lead to torn reads in really rare occassions. Use local[64]_t
for those counters.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 block/blk-iocost.c | 37 +++++++++++++++++++++++++++----------
 1 file changed, 27 insertions(+), 10 deletions(-)

diff --git a/block/blk-iocost.c b/block/blk-iocost.c
index d37b55db2409..e2266e7692b4 100644
--- a/block/blk-iocost.c
+++ b/block/blk-iocost.c
@@ -179,6 +179,8 @@
 #include <linux/parser.h>
 #include <linux/sched/signal.h>
 #include <linux/blk-cgroup.h>
+#include <asm/local.h>
+#include <asm/local64.h>
 #include "blk-rq-qos.h"
 #include "blk-stat.h"
 #include "blk-wbt.h"
@@ -373,8 +375,8 @@ struct ioc_params {
 };
 
 struct ioc_missed {
-	u32				nr_met;
-	u32				nr_missed;
+	local_t				nr_met;
+	local_t				nr_missed;
 	u32				last_met;
 	u32				last_missed;
 };
@@ -382,7 +384,7 @@ struct ioc_missed {
 struct ioc_pcpu_stat {
 	struct ioc_missed		missed[2];
 
-	u64				rq_wait_ns;
+	local64_t			rq_wait_ns;
 	u64				last_rq_wait_ns;
 };
 
@@ -1278,8 +1280,8 @@ static void ioc_lat_stat(struct ioc *ioc, u32 *missed_ppm_ar, u32 *rq_wait_pct_p
 		u64 this_rq_wait_ns;
 
 		for (rw = READ; rw <= WRITE; rw++) {
-			u32 this_met = READ_ONCE(stat->missed[rw].nr_met);
-			u32 this_missed = READ_ONCE(stat->missed[rw].nr_missed);
+			u32 this_met = local_read(&stat->missed[rw].nr_met);
+			u32 this_missed = local_read(&stat->missed[rw].nr_missed);
 
 			nr_met[rw] += this_met - stat->missed[rw].last_met;
 			nr_missed[rw] += this_missed - stat->missed[rw].last_missed;
@@ -1287,7 +1289,7 @@ static void ioc_lat_stat(struct ioc *ioc, u32 *missed_ppm_ar, u32 *rq_wait_pct_p
 			stat->missed[rw].last_missed = this_missed;
 		}
 
-		this_rq_wait_ns = READ_ONCE(stat->rq_wait_ns);
+		this_rq_wait_ns = local64_read(&stat->rq_wait_ns);
 		rq_wait_ns += this_rq_wait_ns - stat->last_rq_wait_ns;
 		stat->last_rq_wait_ns = this_rq_wait_ns;
 	}
@@ -1908,6 +1910,7 @@ static void ioc_rqos_done_bio(struct rq_qos *rqos, struct bio *bio)
 static void ioc_rqos_done(struct rq_qos *rqos, struct request *rq)
 {
 	struct ioc *ioc = rqos_to_ioc(rqos);
+	struct ioc_pcpu_stat *ccs;
 	u64 on_q_ns, rq_wait_ns, size_nsec;
 	int pidx, rw;
 
@@ -1931,13 +1934,17 @@ static void ioc_rqos_done(struct rq_qos *rqos, struct request *rq)
 	rq_wait_ns = rq->start_time_ns - rq->alloc_time_ns;
 	size_nsec = div64_u64(calc_size_vtime_cost(rq, ioc), VTIME_PER_NSEC);
 
+	ccs = get_cpu_ptr(ioc->pcpu_stat);
+
 	if (on_q_ns <= size_nsec ||
 	    on_q_ns - size_nsec <= ioc->params.qos[pidx] * NSEC_PER_USEC)
-		this_cpu_inc(ioc->pcpu_stat->missed[rw].nr_met);
+		local_inc(&ccs->missed[rw].nr_met);
 	else
-		this_cpu_inc(ioc->pcpu_stat->missed[rw].nr_missed);
+		local_inc(&ccs->missed[rw].nr_missed);
+
+	local64_add(rq_wait_ns, &ccs->rq_wait_ns);
 
-	this_cpu_add(ioc->pcpu_stat->rq_wait_ns, rq_wait_ns);
+	put_cpu_ptr(ccs);
 }
 
 static void ioc_rqos_queue_depth_changed(struct rq_qos *rqos)
@@ -1977,7 +1984,7 @@ static int blk_iocost_init(struct request_queue *q)
 {
 	struct ioc *ioc;
 	struct rq_qos *rqos;
-	int ret;
+	int i, cpu, ret;
 
 	ioc = kzalloc(sizeof(*ioc), GFP_KERNEL);
 	if (!ioc)
@@ -1989,6 +1996,16 @@ static int blk_iocost_init(struct request_queue *q)
 		return -ENOMEM;
 	}
 
+	for_each_possible_cpu(cpu) {
+		struct ioc_pcpu_stat *ccs = per_cpu_ptr(ioc->pcpu_stat, cpu);
+
+		for (i = 0; i < ARRAY_SIZE(ccs->missed); i++) {
+			local_set(&ccs->missed[i].nr_met, 0);
+			local_set(&ccs->missed[i].nr_missed, 0);
+		}
+		local64_set(&ccs->rq_wait_ns, 0);
+	}
+
 	rqos = &ioc->rqos;
 	rqos->id = RQ_QOS_COST;
 	rqos->ops = &ioc_rqos_ops;
-- 
2.26.2

