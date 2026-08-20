Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 915E2370AFC
	for <linux-block@vger.kernel.org>; Thu, 20 Aug 2026 02:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787192338; cv=none; b=kEekweVvF7SjnimjULSH8wmuJ3iL1UXhuV4XdtfgFAdO5FgL1Ke26nxHUdj7Iy3da7wR2feHUdcmt9XGZJhkc0BmIDbolcLxXKyugGHP4CekonWDvG7HOzOwa7nneoLbyYr9Rk5LBS890SjPA+3nyfpZ6PE9f7eOHRk1ARfIvSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787192338; c=relaxed/simple;
	bh=tgp+urJmAN8hOQLJ5tLTXI1xONEwPXY8ubOnBeqBVds=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NYpdD0YlqGOfi7Kln5pPxABfRcyhiNZaycm4uxkRzxOsEmwFnsGltjfIK2pDoNSvietzq2zRRU9Wxo0EEWwbj+UM94Mnr+UPSRy1H2BuHySkMWkue17VxGhyGWEElpGa9Z4xd4jxRxDgA16yfIjBVFp+tsSH8vFb9ivT7olx1IE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.170])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4hQRtq6JvrzYQtg5
	for <linux-block@vger.kernel.org>; Thu, 20 Aug 2026 10:18:27 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id E242F4056D
	for <linux-block@vger.kernel.org>; Thu, 20 Aug 2026 10:18:45 +0800 (CST)
Received: from huaweicloud.com (unknown [10.50.87.132])
	by APP2 (Coremail) with UTF8SMTPSA id Syh0CgCXAooFZIZq1z7qCw--.40897S6;
	Thu, 20 Aug 2026 10:18:45 +0800 (CST)
From: Ye Bin <yebin@huaweicloud.com>
To: axboe@kernel.dk,
	linux-block@vger.kernel.org
Cc: ming.lei@redhat.com
Subject: [PATCH 2/2] block/mq-deadline: add module parameter for prio_aging_expire default
Date: Thu, 20 Aug 2026 10:12:46 +0800
Message-Id: <20260820021246.2681624-3-yebin@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260820021246.2681624-1-yebin@huaweicloud.com>
References: <20260820021246.2681624-1-yebin@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Syh0CgCXAooFZIZq1z7qCw--.40897S6
X-Coremail-Antispam: 1UD129KBjvJXoW7tr1DXrW8Gry8tr48GryDWrg_yoW8Kr48pF
	4UXa98tr4FvF43Ary8Aa13Zryak397JryfJ340kr4xuF1Yqr4vvFykKrs09rWfJFWIyryf
	Kr4Igas7Gr15JaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvCb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUXw
	A2048vs2IY020Ec7CjxVAFwI0_JFI_Gr1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVWUCVW8JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	W8JVWxJwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6F4UJVW0owAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ew
	Av7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY
	6r1j6r4UM4x0Y48IcxkI7VAKI48JMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r
	1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CE
	b7AF67AKxVWUXVWUAwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0x
	vE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAI
	cVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2Kf
	nxnUUI43ZEXa7IU1zpB3UUUUU==
X-CM-SenderInfo: p1hex046kxt4xhlfz01xgou0bp/

From: Ye Bin <yebin10@huawei.com>

Allow the default value of prio_aging_expire to be overridden at load
time, in milliseconds to match the sysfs attribute:

  - built-in:  mq_deadline.prio_aging_expire=0 on the kernel command line
  - module:    modprobe mq_deadline prio_aging_expire=0

A value of zero disables I/O priority from boot/load: every request is
filed in the best-effort bucket and the priority aging path is
bypassed, so systems that do not want RT/BE/IDLE distinction can opt
out without writing to sysfs after every queue creation.

Previously prio_aging_expire was a compile-time constant (10 * HZ)
with no way to change the default before the first request queue was
initialized.  Make the variable a module_param so that the override
works whether mq-deadline is built-in or compiled as a module, and
convert the millisecond value to jiffies in dd_init_sched() when
assigning the per-queue default.

Signed-off-by: Ye Bin <yebin10@huawei.com>
---
 block/mq-deadline.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/block/mq-deadline.c b/block/mq-deadline.c
index e3314f7aed8b..95a00a673be5 100644
--- a/block/mq-deadline.c
+++ b/block/mq-deadline.c
@@ -33,7 +33,10 @@ static const int write_expire = 5 * HZ; /* ditto for writes, these limits are SO
  * Time after which to dispatch lower priority requests even if higher
  * priority requests are pending.
  */
-static const int prio_aging_expire = 10 * HZ;
+static int prio_aging_expire = 10 * MSEC_PER_SEC;
+module_param(prio_aging_expire, int, 0644);
+MODULE_PARM_DESC(prio_aging_expire,
+		 "Default prio_aging_expire in milliseconds; 0 disables I/O priority.");
 static const int writes_starved = 2;    /* max times reads can starve a write */
 static const int fifo_batch = 16;       /* # of sequential requests treated as one
 				     by the above parameters. For throughput. */
@@ -559,7 +562,7 @@ static int dd_init_sched(struct request_queue *q, struct elevator_queue *eq)
 	dd->front_merges = 1;
 	dd->last_dir = DD_WRITE;
 	dd->fifo_batch = fifo_batch;
-	dd->prio_aging_expire = prio_aging_expire;
+	dd->prio_aging_expire = msecs_to_jiffies(prio_aging_expire);
 	spin_lock_init(&dd->lock);
 
 	/* We dispatch from request queue wide instead of hw queue */
-- 
2.34.1

