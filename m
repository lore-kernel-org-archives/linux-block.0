Received: from mx0a-00364e01.pphosted.com (mx0a-00364e01.pphosted.com [148.163.135.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 726573B71B4
	for <linux-block@vger.kernel.org>; Thu, 30 Jul 2026 06:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785394761; cv=none; b=L8a1nSE6otBCGruyFlWSVl0Eu9EH64rKshT0TovC8BniiZWUFiPQtxvY3GVicacxKyi0NHvmCWYdtPN/u+MBWptVoHdYawIHsLrLaHs7eznAuZMm5NViwqBjSzl0jV74iNvngSCLoa/AIHOUs1VQFsywSVq6QqlJdAIHgZ4PvPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785394761; c=relaxed/simple;
	bh=YrH/DI0wDNjV2YhuSveiemrqulp6QrFTzw6B0mwxX4w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kQTD9Shw2Pn3mvKFSxrA2UMxN8n3sJTH5fGjBMCIOLgwxxuO4hdbNyFyz8Jw8aH4ALnsBZMQXSMGHmbSz4u7OC0SxVWddxamHWIb+4vZzWdOJFR1JPw9uBwLV+aaaqQNAoC1mZORH8pbG//+lUlAceXjGdNwylhODPmxzqi25mI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu; spf=pass smtp.mailfrom=columbia.edu; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=HKNEeqvR; arc=none smtp.client-ip=148.163.135.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="HKNEeqvR"
Received: from pps.filterd (m0167069.ppops.net [127.0.0.1])
	by mx0a-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66U6X1tG1772158
	for <linux-block@vger.kernel.org>; Thu, 30 Jul 2026 02:59:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps01; bh=74HZ
	01F88KB/oklQrwCAy7hY9ntmF2BEMQHJrOL405s=; b=HKNEeqvRLRNt1X/6LcMe
	0tSPW3BkvnqEPRKFomJ/CgXbFb4ZPAGMV2HOF0JGj0RPL2mgPAO3ndg4mnsLdfQf
	Ifzxuhw7K3bPVBqwt9UCWf62YO61G4ZLnrokkiD5smLWKEtDwzKqvSjQe6AiaLso
	s77mjKJQNhYgZt5Itf4NtY3duXQ7HUg6BhTKPzb3mG0JH825HYfQCj7RuN8AN8Nd
	gUpwM0c2KiuEviL6kD2SgcSmv8/OIjj9rK7eX3oPweqyoWcneWoY05hfUU74q0Kc
	HuhLaTG1mTGXaMaRCTEwt11Bqwb+rBqBzRKU7yKlweiqssCeN/UVPkK3sMLpVD6s
	+g==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-00364e01.pphosted.com (PPS) with ESMTPS id 4fqrjxt50k-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Thu, 30 Jul 2026 02:59:09 -0400 (EDT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-92e606e8f3eso141634285a.3
        for <linux-block@vger.kernel.org>; Wed, 29 Jul 2026 23:59:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785394741; x=1785999541;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=74HZ01F88KB/oklQrwCAy7hY9ntmF2BEMQHJrOL405s=;
        b=RbZP1pWTAYwuI5WRJOzgPQKhrWkMARJcqStfY3ML/FGbX1jyR4qXkRSHPQWMWn4Ksv
         Debru4tHvtcEiSRiYHkLHyL56yk7FXrvEiy/F1i47FUaVfVm4PAGPnpyLARhjc0hznK2
         fQh1iO+bgUqkEXBkv26VKnCeaQHfdBO6KRkOB0UmO6YhqxgJ09pg6vq9cTHDzThbf1Am
         ceMnZKBDBfqGrN0AzdleG0AQlJV/tJ1E3MhTM7/ufFLbrpZ64gGnxWVfF4evor5DN4v2
         diaSd6ldsnqZFVCh14/uD2PV8V67HE0iaBybmS4SZ66WYqn7FuopMqoHZVwKDgfLw9SM
         H+Xg==
X-Forwarded-Encrypted: i=1; AHgh+RrPtQQnP7JIzo1/k6u32YNdAL79d9LdAGOUjWdBu6sXJtUlyBa/6P84MKPTpifR3UuHQyF5HGoixGbblg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyf3sGHa/T7L5OFBwXLczIyRQ/pgPtLA/4c+ufvj7HqcjcDaP2x
	ORV07zeVqAyAzInVSae3zzm9Rrz29j40V4Sh04oUHFL0r624Rjhw50/FwLvKXIRPoahw80fwV2V
	L8ZeNSl7aHSADcBinbGZlh9QdMII/e0dlIsyi5AV3tq5Fx073g2dqbbRAV73G
X-Gm-Gg: AR+sD10hgVsiUQW40C0+OcL5Qdi94PcbqoBqNWJ/nSoK1dYvaML+wTwpFFkCggOqTPE
	yiaMnbqXXAPt9L6RoXIEs4rjF4Z0uK0WrC66TVamlgTJ7wEfGCbnqeGuhoHyRyLOmaY2D5yBUqM
	OFwtSQzdbZ3IQ5y2yOwiG5rGlZnOlMZ13uVPB8lP+dHDwTGynaXF4O5gmcFWbaJ81lugo+JWmmp
	l7xp9pp+2DCHKvkmtqLg99LuG0Sy25MJ+d7momw/Eh4JRTmhm6doBvHni/iW9FLCVerAJYSjXWw
	/OlmszbdpBNwhAFPEr3rN56qMGOThrPS1Bf17gelskR/+eVyhqwCGcLUswPfVo6zFIN8NNpcIIV
	ISHJ3M3wRNFKEZpwwdaRl1XKYmqgG60MzgEEayWfxTAFc9Q==
X-Received: by 2002:a05:620a:1988:b0:92e:7733:e3ac with SMTP id af79cd13be357-93485fbe303mr145369385a.20.1785394740588;
        Wed, 29 Jul 2026 23:59:00 -0700 (PDT)
X-Received: by 2002:a05:620a:1988:b0:92e:7733:e3ac with SMTP id af79cd13be357-93485fbe303mr145367585a.20.1785394740081;
        Wed, 29 Jul 2026 23:59:00 -0700 (PDT)
Received: from [127.0.1.1] (dyn-160-39-33-242.dyn.columbia.edu. [160.39.33.242])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-933d3221bc7sm349752485a.7.2026.07.29.23.58.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2026 23:58:59 -0700 (PDT)
From: Tal Zussman <tz2294@columbia.edu>
Date: Thu, 30 Jul 2026 02:57:52 -0400
Subject: [PATCH v7 2/5] block: add task-context bio completion
 infrastructure
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260730-blk-dontcache-v7-2-3e8e6850068d@columbia.edu>
References: <20260730-blk-dontcache-v7-0-3e8e6850068d@columbia.edu>
In-Reply-To: <20260730-blk-dontcache-v7-0-3e8e6850068d@columbia.edu>
To: Jens Axboe <axboe@kernel.dk>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Christian Brauner <brauner@kernel.org>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Carlos Maiolino <cem@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
        Christoph Hellwig <hch@infradead.org>, Gao Xiang <xiang@kernel.org>,
        Chao Yu <chao@kernel.org>, Yue Hu <zbestahu@gmail.com>,
        Jeffle Xu <jefflexu@linux.alibaba.com>,
        Sandeep Dhavale <dhavale@google.com>,
        Hongbo Li <lihongbo22@huawei.com>, Chunhai Guo <guochunhai@vivo.com>
Cc: Dave Chinner <dgc@kernel.org>, Bart Van Assche <bvanassche@acm.org>,
        Hillf Danton <hdanton@sina.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-erofs@lists.ozlabs.org,
        Tal Zussman <tz2294@columbia.edu>
X-Mailer: b4 0.14.3-dev-d7477
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785394735; l=7962;
 i=tz2294@columbia.edu; s=20250528; h=from:subject:message-id;
 bh=YrH/DI0wDNjV2YhuSveiemrqulp6QrFTzw6B0mwxX4w=;
 b=kbYbuMhjXn1+05VTQOJx1nfXceANSbqyKVyaSmrfVoPjXZyio2Q4S6pS4ZglHtR5agyOibJ8a
 8FRVk+iY5pzDSRlHRoDycOfdt7M3KogsFwfx4OCm4kkWFT0/CDVPDM3
X-Developer-Key: i=tz2294@columbia.edu; a=ed25519;
 pk=BIj5KdACscEOyAC0oIkeZqLB3L94fzBnDccEooxeM5Y=
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMwMDA0OCBTYWx0ZWRfXx+cNB1umG/PH
 BYtIHYRJ2GgN5p1qcmXlmCvDxGbBSpI4qDkOsMOBNatW3oJtlcNvrJr/PWWBexyhTpzjtacKceM
 PABi9m5k3yK3+TFeryexKmIyIXQ62d1JWbbX7d31FyvAC4GD3pJC
X-Proofpoint-ORIG-GUID: zmLGcm72Edi5RKOIoJ_zGgh1b4Y58aCA
X-Proofpoint-GUID: zmLGcm72Edi5RKOIoJ_zGgh1b4Y58aCA
X-Authority-Analysis: v=2.4 cv=ObCoyBTY c=1 sm=1 tr=0 ts=6a6af63d cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=GaPK54s0Se3oFqK5NkZy0g==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=x7bEGLp0ZPQA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=JR4YdQiviy7OQf72WyZ1:22
 a=VwQbUJbxAAAA:8 a=JfrnYn6hAAAA:8 a=c6MZQJnkE7hPhdHR2eoA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22 a=1CNFftbPRP8L7MoqJWF3:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMwMDA0OCBTYWx0ZWRfX05Btsu3TcLRt
 QcFGJ1ntBuLg/dCsRBqQpA7cwifdPXC/yT+e6L1I3BkF0NOdUOTxkilGo09lF6jCyPKgu1dFN6s
 CZHHzv53RFUESE5VhMNLTneoHK1/YdffxWIXlDhCUs7zYpKnlJOh+0JuysGoytvaniVnO7LARGf
 MP1IveRSqOPyU6jJgsjX4qI77cFm4PvikS0cK0urNHOnz5S1hXuk4QuVrTT53/+jC1LgyOdeGI2
 Vllg7q6FipLBGAzgwRHP99+gcrWUUv5mjcrTNSAFOWoqCCaUppNxV0vVI019x+hem7Y95ZzLV01
 rGB/aeLEiAVIprZwOUPoHgJMfPmtrtS/ySaxJhbIpZWrs8IjJ3gfp4a/rSQYQ8ixo5BogC19YoJ
 HQzOK5I6ANr+a7hiGUmSKX3NdoddiusKhlrkOmNZ8xVwlqw3jIniMMcEuh5NT5SjsqCxCCxDX5d
 V1OI3oh4WwU1Ynhf5qQ==
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11859
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 bulkscore=10 malwarescore=0 impostorscore=10
 adultscore=0 priorityscore=1501 lowpriorityscore=10 clxscore=1015
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607300048

Some bio completion handlers need to run from preemptible task context,
but bio_endio() may be called from IRQ context (e.g., buffer_head
writeback). Callers need a way to ensure their callback eventually runs
from a sleepable context. Add infrastructure for that, in two forms:

  1. BIO_COMPLETE_IN_TASK, a bio flag the submitter sets when it knows
     in advance that its callback needs task context (e.g., dropbehind
     writeback). bio_endio() sees the flag and offloads completion to a
     worker automatically.

  2. bio_complete_in_task(), a helper that completion callbacks can
     invoke from within bi_end_io() when the deferral decision is
     dynamic (e.g., fserror reporting).

Both share a per-CPU list drained by a work item on a WQ_PERCPU
workqueue. Producers push the bio onto the local CPU's list and schedule
the work item, which then dispatches each bio's bi_end_io() from task
context.

Both methods are gated on bio_in_atomic(), which returns true in any
context where a sleeping bi_end_io() is unsafe, including
non-preemptible task context.

Two CPU hotplug callbacks are used to drain remaining bios from the
departing CPU's batch, while maintaining the per-CPU behavior. The
CPUHP_AP_ONLINE_DYN callback disables the per-CPU work item while the
CPU is still online, preventing it from running on an unbound worker
later. CPUHP_BP_PREPARE_DYN then drains any bios added between disabling
the work item and CPU offline.

Link: https://lore.kernel.org/all/20260409160243.1008358-1-hch@lst.de/
Suggested-by: Matthew Wilcox <willy@infradead.org>
Suggested-by: Christoph Hellwig <hch@infradead.org>
Signed-off-by: Tal Zussman <tz2294@columbia.edu>
---
 block/bio.c               | 132 +++++++++++++++++++++++++++++++++++++++++++++-
 include/linux/bio.h       |  24 +++++++++
 include/linux/blk_types.h |   1 +
 3 files changed, 156 insertions(+), 1 deletion(-)

diff --git a/block/bio.c b/block/bio.c
index 6a2f6fc3413e..a9610950325b 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -1741,6 +1741,61 @@ void bio_check_pages_dirty(struct bio *bio)
 	schedule_work(&bio_dirty_work);
 }
 
+/*
+ * Infrastructure for deferring bio completions to task-context via a per-CPU
+ * workqueue. Triggered either by the BIO_COMPLETE_IN_TASK bio flag (static
+ * decision at submit time) or by calling bio_complete_in_task() from
+ * bi_end_io() (dynamic decision at completion time).
+ */
+
+struct bio_complete_batch {
+	struct bio_list list;
+	struct work_struct work;
+	int cpu;
+};
+
+static DEFINE_PER_CPU(struct bio_complete_batch, bio_complete_batch);
+static struct workqueue_struct *bio_complete_wq;
+
+static void bio_complete_work_fn(struct work_struct *w)
+{
+	struct bio_complete_batch *batch =
+		container_of(w, struct bio_complete_batch, work);
+
+	while (1) {
+		struct bio_list list;
+		struct bio *bio;
+
+		local_irq_disable();
+		list = batch->list;
+		bio_list_init(&batch->list);
+		local_irq_enable();
+
+		if (bio_list_empty(&list))
+			break;
+
+		while ((bio = bio_list_pop(&list)))
+			bio->bi_end_io(bio);
+	}
+}
+
+void __bio_complete_in_task(struct bio *bio)
+{
+	struct bio_complete_batch *batch;
+	unsigned long flags;
+	bool was_empty;
+
+	local_irq_save(flags);
+	batch = this_cpu_ptr(&bio_complete_batch);
+	was_empty = bio_list_empty(&batch->list);
+	bio_list_add(&batch->list, bio);
+	local_irq_restore(flags);
+
+	if (was_empty)
+		queue_work_on(batch->cpu, bio_complete_wq, &batch->work);
+}
+EXPORT_SYMBOL_GPL(__bio_complete_in_task);
+
 static inline bool bio_remaining_done(struct bio *bio)
 {
 	/*
@@ -1815,7 +1870,9 @@ void bio_endio(struct bio *bio)
 	}
 #endif
 
-	if (bio->bi_end_io)
+	if (bio_flagged(bio, BIO_COMPLETE_IN_TASK) && bio_in_atomic())
+		__bio_complete_in_task(bio);
+	else if (bio->bi_end_io)
 		bio->bi_end_io(bio);
 }
 EXPORT_SYMBOL(bio_endio);
@@ -2001,6 +2058,55 @@ int bioset_init(struct bio_set *bs,
 }
 EXPORT_SYMBOL(bioset_init);
 
+static int bio_complete_batch_cpu_online(unsigned int cpu)
+{
+	struct bio_complete_batch *batch = &per_cpu(bio_complete_batch, cpu);
+
+	enable_work(&batch->work);
+	if (!bio_list_empty(&batch->list))
+		queue_work_on(cpu, bio_complete_wq, &batch->work);
+	return 0;
+}
+
+/*
+ * Disable this CPU's work item so that it cannot run on an unbound worker
+ * after the CPU is offlined.
+ */
+static int bio_complete_batch_cpu_down_prep(unsigned int cpu)
+{
+	disable_work_sync(&per_cpu(bio_complete_batch, cpu).work);
+	return 0;
+}
+
+/*
+ * Drain a dead CPU's deferred bio completions. The CPU is dead and the worker
+ * is canceled so no locking is needed.
+ */
+static int bio_complete_batch_cpu_dead(unsigned int cpu)
+{
+	struct bio_complete_batch *batch =
+		per_cpu_ptr(&bio_complete_batch, cpu);
+	struct bio *bio;
+
+	while ((bio = bio_list_pop(&batch->list)))
+		bio->bi_end_io(bio);
+
+	return 0;
+}
+
+static void __init bio_complete_batch_init(int cpu)
+{
+	struct bio_complete_batch *batch =
+		per_cpu_ptr(&bio_complete_batch, cpu);
+
+	bio_list_init(&batch->list);
+	INIT_WORK(&batch->work, bio_complete_work_fn);
+	batch->cpu = cpu;
+
+	if (!cpu_online(cpu))
+		disable_work_sync(&batch->work);
+}
+
 static int __init init_bio(void)
 {
 	int i;
@@ -2015,6 +2121,30 @@ static int __init init_bio(void)
 				SLAB_HWCACHE_ALIGN | SLAB_PANIC, NULL);
 	}
 
+	for_each_possible_cpu(i)
+		bio_complete_batch_init(i);
+
+	bio_complete_wq = alloc_workqueue("bio_complete",
+					   WQ_MEM_RECLAIM | WQ_PERCPU, 0);
+	if (!bio_complete_wq)
+		panic("bio: can't allocate bio_complete workqueue\n");
+
+	/*
+	 * bio task-context completion draining on hot-unplugged CPUs:
+	 *
+	 *   1. Stop the per-CPU work item while the CPU is still online, so
+	 *      that it cannot run on an unbound worker later.
+	 *   2. Drain leftover bios added between worker disabling and CPU
+	 *      offlining.
+	 */
+	cpuhp_setup_state_nocalls(CPUHP_AP_ONLINE_DYN,
+				  "block/bio:complete:online",
+				  bio_complete_batch_cpu_online,
+				  bio_complete_batch_cpu_down_prep);
+	cpuhp_setup_state_nocalls(CPUHP_BP_PREPARE_DYN,
+				  "block/bio:complete:dead",
+				  NULL, bio_complete_batch_cpu_dead);
+
 	cpuhp_setup_state_multi(CPUHP_BIO_DEAD, "block/bio:dead", NULL,
 					bio_cpu_dead);
 
diff --git a/include/linux/bio.h b/include/linux/bio.h
index 62a983758e09..a8091a3e9d87 100644
--- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@ -383,6 +383,30 @@ static inline bool bio_in_atomic(void)
 	return !preemptible();
 }
 
+void __bio_complete_in_task(struct bio *bio);
+
+/**
+ * bio_complete_in_task - ensure a bio is completed in preemptible task context
+ * @bio: bio to complete
+ *
+ * If called from non-task context, offload the bio completion to a worker
+ * thread and return %true. Else return %false and do nothing.
+ *
+ * Uses BIO_COMPLETE_IN_TASK as a sentinel: if set, the bio was already
+ * deferred and we are running in the worker — return %false so the
+ * callback proceeds instead of re-deferring.
+ */
+static inline bool bio_complete_in_task(struct bio *bio)
+{
+	if (bio_flagged(bio, BIO_COMPLETE_IN_TASK))
+		return false;
+	if (!bio_in_atomic())
+		return false;
+	bio_set_flag(bio, BIO_COMPLETE_IN_TASK);
+	__bio_complete_in_task(bio);
+	return true;
+}
+
 extern void bio_endio(struct bio *);
 
 /**
diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index 8808ee76e73c..d49d97a050d0 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -322,6 +322,7 @@ enum {
 	BIO_REMAPPED,
 	BIO_ZONE_WRITE_PLUGGING, /* bio handled through zone write plugging */
 	BIO_EMULATES_ZONE_APPEND, /* bio emulates a zone append operation */
+	BIO_COMPLETE_IN_TASK, /* complete bi_end_io() in task context */
 	BIO_FLAG_LAST
 };
 

-- 
2.39.5

