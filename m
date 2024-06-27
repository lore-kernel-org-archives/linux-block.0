Received: from mail.nearlyone.de (mail.nearlyone.de [49.12.199.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1735419599C;
	Thu, 27 Jun 2024 14:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=49.12.199.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719497485; cv=none; b=HzEKe0/U628VofpxkaEPHdW6k67bZ9JT1LFwM5CNhY6IoFjg1DjMM6GjYK/dN7bv+oBHYw8+FixxPsPmS2YfROCxaopSjlXa8jo+2LTKgwIo8yYJ5T+3Ha5XtFTfhzwG7P9c+XKAjCt+fioZgvDV8qx4dtM27cFQvD7MTPJ+DWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719497485; c=relaxed/simple;
	bh=2SBOoMtiJ54DPGGVHAq7iv2C4pFRN2GgpRpH94Lztm8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tdMAyAIBg+cgwOIvu5r5GYlZ2UXxpLxmG/tQL4SCKqQznja/mpao/gjxG5nxuYcny4p0wa4Mi24BSiBMxuW2BXtETW4EAZYSb2spEGG1wNKnLHh/9PBK6/akDnAPEE9q045axgg+CHlRhvsRi4TJGAHdXnJeXQBNBEKh/4aXmgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=monom.org; dkim=pass (2048-bit key) header.d=monom.org header.i=@monom.org header.b=TOv9ofVQ; arc=none smtp.client-ip=49.12.199.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=monom.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=monom.org header.i=@monom.org header.b="TOv9ofVQ"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 13CF2DAD4C;
	Thu, 27 Jun 2024 16:11:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monom.org; s=dkim;
	t=1719497474; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=BNoWuT7UuG2Nbrf+bgTkJFKZb6gx8cFnWOjFFjkii6s=;
	b=TOv9ofVQ1gOF3fSkFSbOab6RiJ5vO26sBn9Hu5tJIhE7rQaK0GUz4k2D3kl86fHi+BZ+R9
	cDbnih4Y432teCGAXpn5Z2hiVZKGVWbgW+af/r+Myz+rj8GtSP8YqcaQ+983d3Msdn0FsM
	yfQqo+Btm7Ms27KEmHVWLfYBrQfmS/YgFB6trKQ/E5SN7eIl/q0DzjKvH8i4hlKNWvu+a4
	QjWYihlNS+drQSFWEilX734flAsOs29QmaM4d1j2FrmlcnVhvhXl4h1AfZYrJ6QGdugpGf
	RQXX9EDIXZMVNk1wKXsiCFfGlaGy75abK0RgA28ZZhV9HlzK7UFyu5DiDEm6IQ==
From: Daniel Wagner <dwagner@suse.de>
Date: Thu, 27 Jun 2024 16:10:51 +0200
Subject: [PATCH v2 1/3] blk-mq: add blk_mq_num_possible_queues helper
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240627-isolcpus-io-queues-v2-1-26a32e3c4f75@suse.de>
References: <20240627-isolcpus-io-queues-v2-0-26a32e3c4f75@suse.de>
In-Reply-To: <20240627-isolcpus-io-queues-v2-0-26a32e3c4f75@suse.de>
To: Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>, 
 Sagi Grimberg <sagi@grimberg.me>, Thomas Gleixner <tglx@linutronix.de>, 
 Christoph Hellwig <hch@lst.de>
Cc: Frederic Weisbecker <fweisbecker@suse.com>, 
 Mel Gorman <mgorman@suse.de>, Hannes Reinecke <hare@suse.de>, 
 Sridhar Balaraman <sbalaraman@parallelwireless.com>, 
 "brookxu.cn" <brookxu.cn@gmail.com>, Ming Lei <ming.lei@redhat.com>, 
 linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, 
 linux-nvme@lists.infradead.org, Daniel Wagner <dwagner@suse.de>
X-Mailer: b4 0.14.0
X-Last-TLS-Session-Version: TLSv1.3

Multi queue devices which use managed IRQs should only allocate queues
for the housekeeping CPUs when isolcpus is set. This avoids that the
isolated CPUs get disturbed with OS workload.

Add a helper which calculates the correct number of queues which should
be used.

Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 block/blk-mq-cpumap.c  | 20 ++++++++++++++++++++
 include/linux/blk-mq.h |  1 +
 2 files changed, 21 insertions(+)

diff --git a/block/blk-mq-cpumap.c b/block/blk-mq-cpumap.c
index 9638b25fd521..9717e323f308 100644
--- a/block/blk-mq-cpumap.c
+++ b/block/blk-mq-cpumap.c
@@ -11,10 +11,30 @@
 #include <linux/smp.h>
 #include <linux/cpu.h>
 #include <linux/group_cpus.h>
+#include <linux/sched/isolation.h>
 
 #include "blk.h"
 #include "blk-mq.h"
 
+/**
+ * blk_mq_num_possible_queues - Calc nr of queues for managed devices
+ *
+ * Calculate the number of queues which should be used for a multiqueue
+ * device which uses the managed IRQ API. The helper is considering
+ * isolcpus settings.
+ */
+unsigned int blk_mq_num_possible_queues(void)
+{
+	const struct cpumask *hk_mask;
+
+	hk_mask = housekeeping_cpumask(HK_TYPE_MANAGED_IRQ);
+	if (!cpumask_empty(hk_mask))
+		return cpumask_weight(hk_mask);
+
+	return num_possible_cpus();
+}
+EXPORT_SYMBOL_GPL(blk_mq_num_possible_queues);
+
 void blk_mq_map_queues(struct blk_mq_queue_map *qmap)
 {
 	const struct cpumask *masks;
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index 89ba6b16fe8b..2105cc78ca67 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -900,6 +900,7 @@ void blk_mq_freeze_queue_wait(struct request_queue *q);
 int blk_mq_freeze_queue_wait_timeout(struct request_queue *q,
 				     unsigned long timeout);
 
+unsigned int blk_mq_num_possible_queues(void);
 void blk_mq_map_queues(struct blk_mq_queue_map *qmap);
 void blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set, int nr_hw_queues);
 

-- 
2.45.2

