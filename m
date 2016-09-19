Return-Path: <tglx@linutronix.de>
Message-Id: <20160919212601.014440603@linutronix.de>
Date: Mon, 19 Sep 2016 21:28:19 -0000
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
 Christoph Hellwing <hch@lst.de>, Sebastian Siewior <bigeasy@linutronix.de>,
 Peter Zijlstra <peterz@infradead.org>, rt@linutronix.de
Subject: [patch 1/3] blk/mq: Reserve hotplug states for block multiqueue
References: <20160919212207.161583394@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
List-ID: <linux-block@vger.kernel.org>

This patch only reserves two CPU hotplug states for block/mq so the block tree
can apply the conversion patches.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Jens Axboe <axboe@kernel.dk>
Cc: rt@linutronix.de
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

---
 include/linux/cpuhotplug.h |    2 ++
 1 file changed, 2 insertions(+)

--- a/include/linux/cpuhotplug.h
+++ b/include/linux/cpuhotplug.h
@@ -14,6 +14,7 @@ enum cpuhp_state {
 	CPUHP_PERF_SUPERH,
 	CPUHP_X86_HPET_DEAD,
 	CPUHP_X86_APB_DEAD,
+	CPUHP_BLK_MQ_DEAD,
 	CPUHP_WORKQUEUE_PREP,
 	CPUHP_POWER_NUMA_PREPARE,
 	CPUHP_HRTIMERS_PREPARE,
@@ -22,6 +23,7 @@ enum cpuhp_state {
 	CPUHP_SMPCFD_PREPARE,
 	CPUHP_RCUTREE_PREP,
 	CPUHP_NOTIFY_PREPARE,
+	CPUHP_BLK_MQ_PREPARE,
 	CPUHP_TIMERS_DEAD,
 	CPUHP_BRINGUP_CPU,
 	CPUHP_AP_IDLE_DEAD,
