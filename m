Received: from m16.mail.126.com (m16.mail.126.com [220.197.31.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE17616EB42
	for <linux-block@vger.kernel.org>; Mon, 10 Nov 2025 15:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762788243; cv=none; b=eOinT4WBaSzUWicHi1cSWPifYFmSLNsF1pC8iGtNCrhAziMaXBqafPKMnyWgDZFcaBgWhHsDTSR1KDW0D3W1OH3cOFxbl+DWOisqNn73h8IF4NxXgLQlKUmW07yMEoTAFj6GXxEieMKBAiOwyQ5Mjv5IhMs+y2Szb6e+qx6nPAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762788243; c=relaxed/simple;
	bh=WgPLYwWBqPbdNvjsPPY3wllr3qGd3ZqFjx0fePA+ao8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XqMN7NmwYcsJ+AUFw6p8vwsSy0s5F2t5VcrpHKdseqzGLrlOqfunKpJz8PAbEVoUmDcgZQamncQww0HTVWvdADYvr+Yj0sPSWe9o37M6LFiqvhJ8HxnevsfghIbWpcaKdaVTlUoyQytKumODy9bqXuTBG7kSBHOuBRIlTzbGghU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=EaDTc//I; arc=none smtp.client-ip=220.197.31.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="EaDTc//I"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=N1
	EVr8G896vfw0lYI4Fn8dKmiUCvwQC3BiB+o1WqZH4=; b=EaDTc//Iez3koX9nQ+
	irYl5WUFsZp4C+vxrEOOALnU3V4eLmRBVjubNX23RldEC5AX9TQjIjtHWbav7Q/+
	f1vgWtL8k3XviaeAq2+m+P7ia5Cp6BvXA9+r1iGSvqW9Wnf3Aoad8W3lja2WD/NA
	1IqGjhhn2XB+Dxx2Kl4DZjnxU=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-0 (Coremail) with SMTP id _____wAHKj+GAxJp64DdAg--.31764S2;
	Mon, 10 Nov 2025 23:23:51 +0800 (CST)
From: lwk <lwk111111@126.com>
To: axboe@kernel.dk
Cc: linux-block@vger.kernel.org,
	lwk <lwk111111@126.com>
Subject: [PATCH] block: add sysctl_blk_timeout
Date: Mon, 10 Nov 2025 23:23:48 +0800
Message-ID: <20251110152348.2653843-1-lwk111111@126.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wAHKj+GAxJp64DdAg--.31764S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxWrykWryUAF1DKFy7uw1kuFg_yoW5Aw1kpF
	s8K3WrGw48KF47XFyfG3WayF1rJa18KryjkF9ru34Fyr9akrZ7Ar1vyry8tFn2kanxCF43
	XF17WrW5G3yrGa7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pRvzuXUUUUU=
X-CM-SenderInfo: 5ozniiirrriqqrswhudrp/1tbiFgcCSmkR9FfGmwAAsf

In some scenarios, we want to modify the blk timeout, but the
blk timeout is a hard-code constant, the default value is 30s,
so this patch changes blk timeout to a variable that can be
controlled via sysctl.

Signed-off-by: lwk <lwk111111@126.com>

	modified:   block/blk-mq.c
	modified:   drivers/block/Makefile
	new file:   drivers/block/blk_sysctl.c
	modified:   include/linux/blkdev.h
---
 block/blk-mq.c             |  2 +-
 drivers/block/Makefile     |  1 +
 drivers/block/blk_sysctl.c | 37 +++++++++++++++++++++++++++++++++++++
 include/linux/blkdev.h     |  1 +
 4 files changed, 40 insertions(+), 1 deletion(-)
 create mode 100644 drivers/block/blk_sysctl.c

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 40490ac88..2a087b6b8 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -4537,7 +4537,7 @@ int blk_mq_init_allocated_queue(struct blk_mq_tag_set *set,
 		goto err_hctxs;
 
 	INIT_WORK(&q->timeout_work, blk_mq_timeout_work);
-	blk_queue_rq_timeout(q, set->timeout ? set->timeout : 30 * HZ);
+	blk_queue_rq_timeout(q, set->timeout ? set->timeout : sysctl_blk_timeout);
 
 	q->queue_flags |= QUEUE_FLAG_MQ_DEFAULT;
 
diff --git a/drivers/block/Makefile b/drivers/block/Makefile
index 1105a2d4f..544e6b6b5 100644
--- a/drivers/block/Makefile
+++ b/drivers/block/Makefile
@@ -12,6 +12,7 @@ ccflags-y				+= -I$(src)
 obj-$(CONFIG_BLK_DEV_RUST_NULL) += rnull_mod.o
 rnull_mod-y := rnull.o
 
+obj-$(CONFIG_SYSCTL)        += blk_sysctl.o
 obj-$(CONFIG_MAC_FLOPPY)	+= swim3.o
 obj-$(CONFIG_BLK_DEV_SWIM)	+= swim_mod.o
 obj-$(CONFIG_BLK_DEV_FD)	+= floppy.o
diff --git a/drivers/block/blk_sysctl.c b/drivers/block/blk_sysctl.c
new file mode 100644
index 000000000..f8f96ad12
--- /dev/null
+++ b/drivers/block/blk_sysctl.c
@@ -0,0 +1,37 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * blk_sysctl.c: sysctl interface to block subsystem.
+ *
+ * Begun Nov 10, 2025, lwk.
+ * Added /proc/sys/block directory entry
+ */
+
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/sysctl.h>
+#include <linux/blkdev.h>
+
+
+unsigned int sysctl_blk_timeout = 30;
+
+static struct ctl_table blk_table_sysctls[] = {
+	{
+		.procname		= "blk_timeout",
+		.data			= &sysctl_blk_timeout,
+		.maxlen			= sizeof(int),
+		.mode			= 0644,
+		.proc_handler	= proc_dointvec
+	},
+	{}
+};
+
+static __init int sysctl_blk_init(void)
+{
+#ifdef CONFIG_SYSCTL
+	register_sysctl_init("block", blk_table_sysctls);
+#endif
+
+	return 0;
+}
+
+__initcall(sysctl_blk_init);
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index d37751789..51802d5f7 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -42,6 +42,7 @@ struct blk_queue_stats;
 struct blk_stat_callback;
 struct blk_crypto_profile;
 
+extern unsigned int sysctl_blk_timeout;
 extern const struct device_type disk_type;
 extern const struct device_type part_type;
 extern const struct class block_class;
-- 
2.47.3

