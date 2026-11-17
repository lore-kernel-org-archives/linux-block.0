Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=162.243.164.118
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794912689;
	b=qxahgyiKjKlqBPJa4MvURyTDYgAFluNVpsFTnIsvwzjfqElabbQI2mnfcj/eR7+uAiEN
	 knAe6ht2P5YDYB6N3WzW5zvldM+TK8Sk2qEk0mbcW4ktOF0hAHhj/sfpbxNFJhVtI7M5E
	 T77nKP5iuHpmDP82QT0RRWE+wcIrnoPA0S4IDZDHAjTelG9lheioDAmppuRz+XlJYs/Jr
	 yUHizilU3N9O84so0LFVPsjtVo5QINkmwdja5JLJD+xUfzoFToHbelNY1ByzBVIUKRmn+
	 q0Kt49d8avlSOdWQCQv+pzZh+XGbXfoeR3Jb+tZYMEIJdZdWONqB+uBb13FYcegS+fg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794912689;
	h=DMARC-Filter:Received:Received:From:To:Cc:Subject:Date:Message-Id:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-CM-SenderInfo:
	 X-Coremail-Antispam;
	bh=Le1aTwSmJJVjoIZHS1zuonXE4iOS881VhWU6iH/FA2w=;
	b=Tr0+nBat1zuFsoWBW1Pdwc3p4gPZX4JpxN/U/LwA34ZeWXL0LCFUcx/Upk5+Q0+Ovq0C
	 62x4vGSz9jbmNueteXhLSkhKpGhJ4uQTzXcmzc+j7q4Np8c6wrMVjwE9Ua5xtjepQmbSP
	 icjj28LW71L5Vz93C5lXOC9/Wv1BUmqF2sEPzEnD5Olvt5L0Neoa3FVi5xin2ykzKuaXO
	 NDDG9Mw+ZwHXLLNTLqWbezYEAorJpDM/MSVL2wOROFiA7TictkjeE2I7jA7cns/ftypS9
	 abSgk2XpDMT0xcPRYmaKO3f7SuWGwLTrxOcT+9mzBWMa/Gwq26OOs0ZPtRHT32MHhTQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=phytium.com.cn;
	spf=pass smtp.mailfrom=phytium.com.cn;
	arc=none smtp.remote-ip=162.243.164.118
Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net (zg8tmtyylji0my4xnjqumte4.icoremail.net [162.243.164.118])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F7EC606A32A;
	Tue, 17 Nov 2026 10:51:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3F7EC606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytium.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phytium.com.cn
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
	by hzbj-icmmx-7 (Coremail) with UTF8SMTP id AQAAfwCXnMCtMfxqKZNWBg--.51193S2;
	Tue, 17 Nov 2026 18:51:25 +0800 (CST)
Received: from phytium.. (unknown [218.76.62.144])
	by mail (Coremail) with SMTP id AQAAf8DwSnOdMfxqF977AA--.36666S4;
	Tue, 17 Nov 2026 18:51:13 +0800 (CST)
From: Ethan <yangyizhen3198@phytium.com.cn>
To: Jens Axboe <axboe@kernel.dk>,
	Christian Brauner <brauner@kernel.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>,
	linux-block@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	yangyizhen3198@phytium.com.cn
Subject: [RFC PATCH 1/1] block: reclaim cache before block file close notification
Date: Tue, 17 Nov 2026 18:51:07 +0800
Message-Id: <20261117105107.14236-2-yangyizhen3198@phytium.com.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261117105107.14236-1-yangyizhen3198@phytium.com.cn>
References: <20261117105107.14236-1-yangyizhen3198@phytium.com.cn>
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAf8DwSnOdMfxqF977AA--.36666S4
X-CM-SenderInfo: 51dqw5pl2kv0atrzmqxsk13x1xpou0fpof0/1tbiAQACDWr7WcwEQQANsC
Authentication-Results: hzbj-icmmx-7; spf=neutral smtp.mail=yangyizhen
	3198@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvJXoW3AryxKF13Cw1UWw1rZrWkJFb_yoWxuw1kpF
	Z8GFW5Jw48WryxGan7Za17WryFgayvgFWUXryfW34FyrnrtryvyrZ2vr1jyr47Crs7ArW5
	Xw47KrZ8CryUCaDanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
	DUYxn0WfASr-VFAU7a7-sFnT9fnUUIcSsGvfJ3UbIYCTnIWIevJa73UjIFyTuYvj4RJUUU
	UUUUU

A full mkfs.ntfs run on a raw NVMe device can finish writing but leave
hundreds of GiB of device mapping cache for final close cleanup. On an
ARM64 system with about 1 TiB of RAM and a 1.92 TB NVMe device, a vendor
6.6 diagnostic kernel without reclaim optimizations reproduced long
udev open blocking in three consecutive runs. All three mkfs runs and
the subsequent NTFS information checks completed successfully.

The final truncate_inode_pages() calls took 423.282, 447.064 and 420.785
seconds with about 805 GiB of mapping pages at close. The corresponding
udev opens took 423.282, 447.061 and 420.785 seconds. The blocked udev
stacks went through mutex_lock(), blkdev_get_by_dev() and blkdev_open();
the diagnostic open_mutex wait values agreed at millisecond resolution.
Each run produced hung-task warnings and one udev watchdog restart.

The examined close path holds disk->open_mutex while the last-opener
blkdev_put_whole() calls blkdev_flush_mapping(), kill_bdev() and
truncate_inode_pages(). A concurrent opener needs the same mutex. In the
recorded runs, the long interval was concentrated in cache teardown,
not the separately recorded final sync. A successful sync can leave
clean cache pages and associated metadata for this later teardown.

The problem is therefore prolonged exclusion of other device openers
during final cache cleanup, even when formatting itself succeeds. The
120-second hung-task reporting threshold is not an open_mutex timeout.
The objective is to reduce time spent in that critical section, not to
make the complete mkfs or close finish within 120 seconds. The evidence
is from a vendor diagnostic kernel, not current upstream reproduction.

Explore best-effort reclaim before notification and original release:
at final __fput of a block-device file, call vfs_fsync(), then
vfs_fadvise(POSIX_FADV_DONTNEED), before fsnotify_close(). Keep the
original release responsible for any remaining pages and concurrent
activity. Skip O_PATH and missing fsync operations before interpreting
the block-device mapping. Log sync errors and skip advice; log advice
errors and continue release. No new close error return is introduced.

The hook applies to block-device files with a fsync operation, excluding
O_PATH handles. It runs at the last reference to each such struct file,
including files opened read-only or with O_DIRECT. It does not wait for
the last device opener. A read-only close can therefore initiate shared
mapping writeback and a device flush. Reclaim can evict useful cache.
Sync/reclaim can block in __fput and delayed fput, and placing it before
fsnotify_close changes when observers run. DONTNEED does not guarantee
an empty mapping or a bound on later lock hold time.

This is a design RFC based on the recorded vendor 6.6 tree. It is not
rebased or validated on current mainline, nor proposed as a stable
backport. Please advise whether this should remain a userspace action,
be placed elsewhere in the block lifecycle, or be addressed through a
more fundamental close-locking change before pursuing a mergeable fix.

Signed-off-by: Ethan <yangyizhen3198@phytium.com.cn>
---
Baseline: recorded vendor Linux 6.6 source snapshot, not current mainline.
The baseline measurements describe the problem, not results of this
proposed patch. No additional build or runtime test was run while
preparing this posting.

Questions for reviewers:
- Is __fput an appropriate context for this blocking work?
- Should implicit sync and cache eviction remain a userspace choice?
- If a kernel policy is appropriate, what eligibility rules avoid
  repeated work and interference with other mapping users?
- How should delayed fput and close notification ordering be handled?
- Would a different block close locking design be preferable?

 block/Makefile                |  2 ++
 block/bdev-preclose.c         | 29 +++++++++++++++++++++++++++++
 fs/file_table.c               |  4 ++++
 include/linux/bdev-preclose.h | 14 ++++++++++++++
 4 files changed, 49 insertions(+)
 create mode 100644 block/bdev-preclose.c
 create mode 100644 include/linux/bdev-preclose.h

diff --git a/block/Makefile b/block/Makefile
index 46ada9d..df775b4 100644
--- a/block/Makefile
+++ b/block/Makefile
@@ -11,6 +11,8 @@ obj-y		:= bdev.o fops.o bio.o elevator.o blk-core.o blk-sysfs.o \
 			genhd.o ioprio.o badblocks.o partitions/ blk-rq-qos.o \
 			disk-events.o blk-ia-ranges.o early-lookup.o
 
+obj-y += bdev-preclose.o
+
 obj-$(CONFIG_BOUNCE)		+= bounce.o
 obj-$(CONFIG_BLK_DEV_BSG_COMMON) += bsg.o
 obj-$(CONFIG_BLK_DEV_BSGLIB)	+= bsg-lib.o
diff --git a/block/bdev-preclose.c b/block/bdev-preclose.c
new file mode 100644
index 0000000..ba3849e
--- /dev/null
+++ b/block/bdev-preclose.c
@@ -0,0 +1,29 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Best-effort cache reclaim before final release of a block-device file. */
+#include <linux/bdev-preclose.h>
+#include <linux/blkdev.h>
+#include <linux/fadvise.h>
+#include <linux/fs.h>
+#include <linux/printk.h>
+#include "blk.h"
+
+/* The caller is __fput, before fsnotify_close and the original release. */
+void bdev_preclose_reclaim(struct file *file)
+{
+	int ret;
+
+	/* A block-special inode can also be opened as a path-only handle. */
+	if ((file->f_mode & FMODE_PATH) || !file->f_op || !file->f_op->fsync)
+		return;
+
+	lockdep_assert_not_held(&I_BDEV(file->f_mapping->host)->bd_disk->open_mutex);
+	ret = vfs_fsync(file, 0);
+	if (ret) {
+		pr_err_ratelimited("bdev preclose: fsync failed (%d); skipping DONTNEED\n",
+				   ret);
+		return;
+	}
+	ret = vfs_fadvise(file, 0, 0, POSIX_FADV_DONTNEED);
+	if (ret)
+		pr_err_ratelimited("bdev preclose: DONTNEED failed (%d)\n", ret);
+}
diff --git a/fs/file_table.c b/fs/file_table.c
index ee21b3d..0b9d7a8 100644
--- a/fs/file_table.c
+++ b/fs/file_table.c
@@ -9,6 +9,7 @@
 #include <linux/string.h>
 #include <linux/slab.h>
 #include <linux/file.h>
+#include <linux/bdev-preclose.h>
 #include <linux/fdtable.h>
 #include <linux/init.h>
 #include <linux/module.h>
@@ -367,6 +368,9 @@ static void __fput(struct file *file)
 
 	might_sleep();
 
+	/* Reclaim before notifying observers; original release remains below. */
+	if (S_ISBLK(inode->i_mode))
+		bdev_preclose_reclaim(file);
 	fsnotify_close(file);
 	/*
 	 * The function eventpoll_release() should be the first called
diff --git a/include/linux/bdev-preclose.h b/include/linux/bdev-preclose.h
new file mode 100644
index 0000000..5e75ac3
--- /dev/null
+++ b/include/linux/bdev-preclose.h
@@ -0,0 +1,14 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+#ifndef _LINUX_BDEV_PRECLOSE_H
+#define _LINUX_BDEV_PRECLOSE_H
+
+struct file;
+
+#ifdef CONFIG_BLOCK
+void bdev_preclose_reclaim(struct file *file);
+#else
+static inline void bdev_preclose_reclaim(struct file *file)
+{
+}
+#endif
+#endif

