Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA79C10A15
	for <linux-block@vger.kernel.org>; Mon, 22 Jan 2024 22:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705963390; cv=none; b=Tz1nvxedQTfAPRrZhBYBOo2OX8UcTdZ7avLEUvjxuIF+H3PdjOFIT2Lfw/gTQRoMqtw+TAQvz2BdEbEBk3uJd5s92tSKoZtVj2dekV23UGxnEFqtNkAncLmTH+8lgrmGfbjXhjYQB8iu+D/GcXMb2hI6srvhIBoA3OKyekP3NRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705963390; c=relaxed/simple;
	bh=jq6waBdRNkIn/pUr1wxFo1S8k72Er9q9GsNFxc1jCWM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=HDA+bDD3esyNsIDau9aL8yUNUHdJ0zZeBT/5b5FP4bnCAgjnThcr45KAAZZCYb9iFmfGkkBXts+5ALMNA4lZ9IQMW8KZu5MyjxFJGGzJ4oj4BuDSYzoBFVKNrm46eZ79c3l7SdjYzbqdI6pk5+MgQYSvml4ZVJ0mY05xx/O34Ww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io; spf=pass smtp.mailfrom=layalina.io; dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b=RKLRbBZI; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=layalina.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b="RKLRbBZI"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-40e87d07c07so47295545e9.1
        for <linux-block@vger.kernel.org>; Mon, 22 Jan 2024 14:43:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20230601.gappssmtp.com; s=20230601; t=1705963387; x=1706568187; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9HIAkUY/IV0amVuu3edtawXBj2pvEspdSiVxTepe+1A=;
        b=RKLRbBZIjEezbsnhPUeiat7Q7ReFw7qDQLP8phEw9D8P0JpFxE5I7g5dwxMhxPvDtg
         S3VmKYohHnK3bmepVwnLrOQeygSDPvxtMhdgrjjXx+zR+A2LENyin76l31e2XylenONg
         DCChTSCy8DCJ5P9CaJaEiy20WPlNzc3b6umQV5/hOrKnby+mN/GWCmM+kN09OEja8pXC
         6Fsc2eamPTG2yKVT8TWepatmMuS4yWCHadwYN9wp4Dh/4fv1IyYd1z7ANMfdRDSVAOD+
         26a7nXtV1Z/rVGjT0bOpvZTSkhi4OV2KGc9Usp/nanXXW1rzUHSyeCmdSQfl/fTGiex/
         pN+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705963387; x=1706568187;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9HIAkUY/IV0amVuu3edtawXBj2pvEspdSiVxTepe+1A=;
        b=qy2rQPUkyZrAcjOlC78hk/jm5fWB46Cr/P47crIVpv/YNJscFpusVVVV01wzSOjiLc
         AykwKsVJKUY5z3mYabKO+xsQC03n2gfBESXdNXhqF9WBPvgw+3WwBJQWkPQT8PfF1y9h
         jomButwx7tFmklpolf3WJcECvPBJomzFoq72e3ETIEuf5YvGPUyeXOp76S8uA5zfJxFQ
         l+NHvnuhFghSQ40EVuQR28SWgm7oRqqfOWpCB5kFI23SQGZ+N8CnBpMzsZdfXaNWAqR4
         9KH5uT9UntSEYdXt0FmKI3yKe/PxVkaViXAVtylolYtCF1FKfx8P57i/rfCmtlmXxHYX
         osFg==
X-Gm-Message-State: AOJu0YzHbta8M7OpEQ0bksrR6fdp+No50p0kcDlSwHHaZ7MYyYxpaDek
	kcbBusWje9ppaMYYGn3ncI9abov2yMIoA1D0wHBQtAqVSwjLOQNTZc9Kl/EYzolWHxSCPaA+LVZ
	G
X-Google-Smtp-Source: AGHT+IEjlD5xRIOcTScuTGHjM6USJ+02b5+1PMeHVKOP7Pp8OqF4DhozZcwaJeTcrhn8QZSDG2G24Q==
X-Received: by 2002:a7b:c38f:0:b0:40e:6617:fc33 with SMTP id s15-20020a7bc38f000000b0040e6617fc33mr2680804wmj.146.1705963386703;
        Mon, 22 Jan 2024 14:43:06 -0800 (PST)
Received: from airbuntu.. ([213.122.231.14])
        by smtp.gmail.com with ESMTPSA id x16-20020adfdd90000000b00337d6539d52sm11412758wrl.18.2024.01.22.14.43.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jan 2024 14:43:06 -0800 (PST)
From: Qais Yousef <qyousef@layalina.io>
To: Jens Axboe <axboe@kernel.dk>,
	Ingo Molnar <mingo@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org,
	Sudeep Holla <sudeep.holla@arm.com>,
	Wei Wang <wvw@google.com>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Bart Van Assche <bvanassche@acm.org>,
	Qais Yousef <qyousef@layalina.io>
Subject: [PATCH] block/blk-mq: Don't complete locally if capacities are different
Date: Mon, 22 Jan 2024 22:42:20 +0000
Message-Id: <20240122224220.1206234-1-qyousef@layalina.io>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The logic in blk_mq_complete_need_ipi() assumes SMP systems where all
CPUs have equal capacities and only LLC cache can make a different on
perceived performance. But this assumption falls apart on HMP systems
where LLC is shared, but the CPUs have different capacities. Staying
local then can have a big performance impact if the IO request was done
from a CPU with higher capacity but the interrupt is serviced on a lower
capacity CPU.

Introduce new cpus_gte_capacity() function to enable do the additional
check.

Without the patch I see the BLOCK softirq always running on little cores
(where the hardirq is serviced). With it I can see it running on all
cores.

This was noticed after the topology change [1] where now on a big.LITTLE
we truly get that the LLC is shared between all cores where as in the
past it was being misrepresented for historical reasons. The logic
exposed a missing dependency on capacities for such systems where there
can be a big performance difference between the CPUs.

This of course introduced a noticeable change in behavior depending on
how the topology is presented. Leading to regressions in some workloads
as the performance of the BLOCK softirq on littles can be noticeably
worse.

[1] https://lpc.events/event/16/contributions/1342/attachments/962/1883/LPC-2022-Android-MC-Phantom-Domains.pdf

Signed-off-by: Qais Yousef (Google) <qyousef@layalina.io>
---
 block/blk-mq.c                 | 5 +++--
 include/linux/sched/topology.h | 6 ++++++
 kernel/sched/core.c            | 8 ++++++++
 3 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index ac18f802c027..9b2d278a7ae7 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1163,10 +1163,11 @@ static inline bool blk_mq_complete_need_ipi(struct request *rq)
 	if (force_irqthreads())
 		return false;
 
-	/* same CPU or cache domain?  Complete locally */
+	/* same CPU or cache domain and capacity?  Complete locally */
 	if (cpu == rq->mq_ctx->cpu ||
 	    (!test_bit(QUEUE_FLAG_SAME_FORCE, &rq->q->queue_flags) &&
-	     cpus_share_cache(cpu, rq->mq_ctx->cpu)))
+	     cpus_share_cache(cpu, rq->mq_ctx->cpu) &&
+	     cpus_gte_capacity(cpu, rq->mq_ctx->cpu)))
 		return false;
 
 	/* don't try to IPI to an offline CPU */
diff --git a/include/linux/sched/topology.h b/include/linux/sched/topology.h
index a6e04b4a21d7..31cef5780ba4 100644
--- a/include/linux/sched/topology.h
+++ b/include/linux/sched/topology.h
@@ -176,6 +176,7 @@ extern void partition_sched_domains(int ndoms_new, cpumask_var_t doms_new[],
 cpumask_var_t *alloc_sched_domains(unsigned int ndoms);
 void free_sched_domains(cpumask_var_t doms[], unsigned int ndoms);
 
+bool cpus_gte_capacity(int this_cpu, int that_cpu);
 bool cpus_share_cache(int this_cpu, int that_cpu);
 bool cpus_share_resources(int this_cpu, int that_cpu);
 
@@ -226,6 +227,11 @@ partition_sched_domains(int ndoms_new, cpumask_var_t doms_new[],
 {
 }
 
+static inline bool cpus_gte_capacity(int this_cpu, int that_cpu)
+{
+	return true;
+}
+
 static inline bool cpus_share_cache(int this_cpu, int that_cpu)
 {
 	return true;
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index db4be4921e7f..db5ab4b3cee7 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -3954,6 +3954,14 @@ void wake_up_if_idle(int cpu)
 	}
 }
 
+bool cpus_gte_capacity(int this_cpu, int that_cpu)
+{
+	if (this_cpu == that_cpu)
+		return true;
+
+	return arch_scale_cpu_capacity(this_cpu) >= arch_scale_cpu_capacity(that_cpu);
+}
+
 bool cpus_share_cache(int this_cpu, int that_cpu)
 {
 	if (this_cpu == that_cpu)
-- 
2.34.1

