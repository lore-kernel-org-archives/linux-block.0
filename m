Return-Path: <sagi@grimberg.me>
From: Sagi Grimberg <sagi@grimberg.me>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>
Subject: [PATCH] softirq: Display IRQ_POLL for irq-poll statistics
Date: Mon, 10 Oct 2016 15:10:51 +0300
Message-Id: <1476101451-722-1-git-send-email-sagi@grimberg.me>
List-ID: <linux-block@vger.kernel.org>

This library was moved to the generic area and was
renamed to irq-poll. Hence, update proc/softirqs output accordingly.

Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
---
 kernel/softirq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/softirq.c b/kernel/softirq.c
index 17caf4b63342..22e8f8d03e7f 100644
--- a/kernel/softirq.c
+++ b/kernel/softirq.c
@@ -58,7 +58,7 @@ static struct softirq_action softirq_vec[NR_SOFTIRQS] __cacheline_aligned_in_smp
 DEFINE_PER_CPU(struct task_struct *, ksoftirqd);
 
 const char * const softirq_to_name[NR_SOFTIRQS] = {
-	"HI", "TIMER", "NET_TX", "NET_RX", "BLOCK", "BLOCK_IOPOLL",
+	"HI", "TIMER", "NET_TX", "NET_RX", "BLOCK", "IRQ_POLL",
 	"TASKLET", "SCHED", "HRTIMER", "RCU"
 };
 
-- 
2.7.4
