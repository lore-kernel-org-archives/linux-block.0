Received: from outboundhk.mxmail.xiaomi.com (outboundhk.mxmail.xiaomi.com [118.143.206.90])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CB37233949;
	Fri,  4 Sep 2026 06:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=118.143.206.90
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788504320; cv=none; b=q239Hsxdd2VrBbixo3t9wbihORQD4Ox0eWQp5l1Y24ywYKHO4O0ppwNUfQgZpRsG55Pup60ANtsYaWwNpdyJKWscJ4TzkAac+Q96RRJmTjlF/MVtxZ9Sn28K2MwNkP9pCl/tLqpEy6fbB4In0Iom+3mKmudCcoy03kOBuIU/oSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788504320; c=relaxed/simple;
	bh=Be3NKpeYyku2QkrBjKFmErRhp0bgBDENK4U0S0pHM6k=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=b8WmPKQAsgatuUUtN7/SnJ52iCoqETilRq1fqxDK8MVZwq8X1kKbmcogIkxeiNnXPQKgkwOViW/NdFOC/O6NpaWoqL/f8sCkz7gygREBxRMtmC2AAK9N5iRHmLx2kwJ7JUmCcXoIYuJjL4qODC0roJ41kiKxYRLqicmoNW2vmjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=xiaomi.com; spf=pass smtp.mailfrom=xiaomi.com; arc=none smtp.client-ip=118.143.206.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=xiaomi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xiaomi.com
X-CSE-ConnectionGUID: 7Z/tdsLnSyGvG78wVVpMhw==
X-CSE-MsgGUID: Ff33qnlCQ/SkQYzfNFynVA==
X-IronPort-AV: E=Sophos;i="6.25,260,1779120000"; 
   d="scan'208";a="161531732"
From: Wang Shuaiwei <wangshuaiwei1@xiaomi.com>
To: Frederic Weisbecker <frederic@kernel.org>, Thomas Gleixner
	<tglx@kernel.org>, Jens Axboe <axboe@kernel.dk>
CC: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, <wanghui33@xiaomi.com>,
	Wang Shuaiwei <wangshuaiwei1@xiaomi.com>, <linux-kernel@vger.kernel.org>,
	<linux-block@vger.kernel.org>
Subject: [PATCH] tick/block: Add BLOCK_SOFTIRQ to the hotplug safe mask
Date: Fri, 4 Sep 2026 14:45:06 +0800
Message-ID: <20260904064506.671203-1-wangshuaiwei1@xiaomi.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BJ-MBX03.mioffice.cn (10.237.8.123) To bj-mbx11.mioffice.cn
 (10.237.8.131)

During CPU-hotplug stress testing combined with an I/O
workload, the following message is observed:

  "NOHZ tick-stop error: local softirq work is pending, handler #10!!!"

On CPU offline, ksoftirqd is parked at CPUHP_AP_SMPBOOT_THREADS while
the CPU still takes interrupts. A block completion raised after that
point stays pending, and if the dying CPU goes idle before teardown,
report_idle_softirq() sees it, keeps the tick alive and prints the
error above.

Such pending block completions on the outgoing CPU are drained later by
blk_softirq_cpu_dead() (CPUHP_BLOCK_SOFTIRQ_DEAD), so a pending
BLOCK_SOFTIRQ is harmless here. Add it to SOFTIRQ_HOTPLUG_SAFE_MASK
like the other teardown-covered vectors.

Signed-off-by: Wang Shuaiwei <wangshuaiwei1@xiaomi.com>
---
 include/linux/interrupt.h | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/include/linux/interrupt.h b/include/linux/interrupt.h
index 3bf969ad8fe0..52bb684090c0 100644
--- a/include/linux/interrupt.h
+++ b/include/linux/interrupt.h
@@ -573,9 +573,11 @@ enum
  * _ IRQ_POLL: irq_poll_cpu_dead() migrates the queue
  *
  * _ (HR)TIMER_SOFTIRQ: (hr)timers_dead_cpu() migrates the queue
+ *
+ * _ BLOCK_SOFTIRQ: blk_softirq_cpu_dead() completes the remaining requests
  */
-#define SOFTIRQ_HOTPLUG_SAFE_MASK (BIT(TIMER_SOFTIRQ) | BIT(IRQ_POLL_SOFTIRQ) |\
-				   BIT(HRTIMER_SOFTIRQ) | BIT(RCU_SOFTIRQ))
+#define SOFTIRQ_HOTPLUG_SAFE_MASK (BIT(TIMER_SOFTIRQ) | BIT(BLOCK_SOFTIRQ) |\
+				   BIT(IRQ_POLL_SOFTIRQ) | BIT(HRTIMER_SOFTIRQ) | BIT(RCU_SOFTIRQ))
 
 
 /* map softirq index to softirq name. update 'softirq_to_name' in
-- 
2.43.0

