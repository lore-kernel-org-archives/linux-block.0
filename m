Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49310509F03
	for <linux-block@vger.kernel.org>; Thu, 17 Sep 2026 13:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789651817; cv=none; b=DvQA2bXm++yk811+fRY2ifapbGUX8R5Ss5iT0SQodTsZMbDYPW9khrFcWxkPM5+zVdu+RSbp0HHxHfeacq3QGAh91/T0XkReUqBl7wf7r0mY6+JRAoZ0DYMOrR2pPDGlOLi/QSY1CZexKXL9GkgXqjt5rQV/UoOBqXZIUlt8alE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789651817; c=relaxed/simple;
	bh=awwlgzxtXDrXgtIayBPQhLrxnIbxDh2MzbBIZ+zdxQA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZlvQj7YNEfIxMfQUI9PB670dr9oOpncy+QhgDxtqUCAVPFQNLMLZF4iopqRCPmOIPESjpoe9rGIC/IGH52EZAa7ebuz8sjcXS+Pvyr51gaswICVrwfDhGOzaUx5n3Gy620Fo86wNIMvpmOr4IYRd0EaKmtC9ze50MettIfhQfvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=starlabs.systems; spf=pass smtp.mailfrom=starlabs.systems; dkim=pass (2048-bit key) header.d=starlabs-systems.20251104.gappssmtp.com header.i=@starlabs-systems.20251104.gappssmtp.com header.b=yw/YPe+D; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=starlabs.systems
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starlabs.systems
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=starlabs-systems.20251104.gappssmtp.com header.i=@starlabs-systems.20251104.gappssmtp.com header.b="yw/YPe+D"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49e79a408deso4210155e9.2
        for <linux-block@vger.kernel.org>; Thu, 17 Sep 2026 06:30:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=starlabs-systems.20251104.gappssmtp.com; s=20251104; t=1789651797; x=1790256597; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GKh+va21iR5NhJ1aJ3Y13UNlm+0FMnv30u4Z223eMLE=;
        b=yw/YPe+DPFXVi0kIGM0sj5v+OJ68LTADyQ9640vxAf6VZZkJzrjDEjhpVYppL2153j
         Cr2QmLlObfNCXEvAFULJ+5GCtayg6Dr7WSW7fqRAiR1lX+uCNULQ+wadziyJkaPCHWm2
         86RkRe8vHZIDJe4Cuy9oY54nuCguMZv5slnCkgK32XiaPQk+H/qNx8CrGMP1RsJikqvv
         OgEdB9YYA5AD29IXiTQv/cL6Ox2pcOf2DKa8F76SbpaQiXAyza1woo7oq/k5ZW0hqpRQ
         hK+8ktVCEeYY9fXsC/+kpHnr3KmAO/4ZNnVmE6GIwqfT6rqZMnMWyXaPc7MtCkb9F6rm
         9H+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789651797; x=1790256597;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=GKh+va21iR5NhJ1aJ3Y13UNlm+0FMnv30u4Z223eMLE=;
        b=Rj2JuduzDl04W8GBqGGulGlPT1T/3Cc4bGA6mICPE8RfV8CiPzW/sNxkayWOTljzZE
         v1nNPf+OinVRP2PhpcfF8JyRpnW4n5d8v3+iK1VnRI9+gFOHLW1bBLIyPSSwqd9Kx9Br
         B9UphAs8RV+eJ+JNm3KKAEnSBHPExTjL11E+6/0iWlUzotv/Su664aj3TMLtM7lkBFp4
         FoVr1U9nFSsTyKb8DFdpU8lk/DziaJbjLbTcewhwxEeGSOu/oaHTpus488gmNK6VrrbI
         J0FXqs8b0KuWFe/DvMRH+69dqcAx0S+42naP6iadK6MiEhQZde54zlwmehwAvX9MR8W6
         n7HA==
X-Forwarded-Encrypted: i=1; AKwUvBx1UcH2FTKPaSb/Qkh5G7NqKRPbD67XpSQVRE8RAAvn5twiw63qtPWrJq+/JnZP8ecs+lgbfasPHgl/Rw==@vger.kernel.org
X-Gm-Message-State: AFuF++mBvIY0o1zp/Fm4aR2KpiabHGaXyZvbOJp7bYpKUH9lZFxzs30g
	IU5sP5Tkg7F2SPNtTQkK4k0gfEb2sd5E/PeF4/WKt89HwaNwJrsMnyk+kGAaXOqXCg==
X-Gm-Gg: AYBFou3o7g2tpTwN0ib+cc4F7/pg2OeIjEVIQAg57mQGuHt9Y9b+Jb0G2ZUH7nWiDBX
	xbLqAqpNawBBqizmBTpVHv4Vb79mCIWxLTw4+XQYVMpSYBAiAYwavu2JRSZlW7nShEocQx66Za2
	u0eSWA7G6QQlxYYEp0OOrIRmpwjILcwLqZ/XXzJqK9enSANcW70AiZ/WtEHfOV6BX13QxqEpHiQ
	sgCmvE0WZuRw61TjiLkgzcRqALJssvha5iVfLRWVUdIr5whbUPJLndCCbrAASRcw+O2ULpyX/ZF
	gAMKI+4wvfRvf0PuuDcW2o7t2jSDFlZFTfnShsnQuFhbYHIXLOzAV0qN0CgdFMaDorA7ZTw7VpD
	/qe41mVNHDTHVxoOz5CKIIWYO5Rnu24/HWYLWPJ7suPB8e/cfXfamTnBJiQdM1wIE0ZcKpweEas
	RvIYorJr0BpIlEY1QPglCx2P9+WMxfiKiTXiLMhg7HE9d/AfOc44SbT8y3WsUqwY5+EbcPnnBFo
	InqE9+RCegRDxeP2ttSZjIS4nzTe7kM4MYOVQ==
X-Received: by 2002:a05:600c:314a:b0:49e:799e:c1c3 with SMTP id 5b1f17b1804b1-49eb73263c6mr82073545e9.17.1789651796582;
        Thu, 17 Sep 2026 06:29:56 -0700 (PDT)
Received: from fighter ([216.128.28.240])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fbd2356d1sm97548275e9.6.2026.09.17.06.29.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2026 06:29:55 -0700 (PDT)
From: Sean Rhodes <sean@starlabs.systems>
To: linux-pm@vger.kernel.org
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Pavel Machek <pavel@kernel.org>,
	Evan Green <evgreen@chromium.org>,
	Sean Rhodes <sean@starlabs.systems>,
	linux-kernel@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>,
	Andrew Morton <akpm@linux-foundation.org>,
	Chris Li <chrisl@kernel.org>,
	Kairui Song <kasong@tencent.com>,
	Kemeng Shi <shikemeng@huaweicloud.com>,
	Nhat Pham <nphamcs@gmail.com>,
	Baoquan He <baoquan.he@linux.dev>,
	Barry Song <baohua@kernel.org>,
	Youngjun Park <youngjun.park@lge.com>,
	linux-block@vger.kernel.org,
	linux-mm@kvack.org,
	Xueqin Luo <luoxueqin@kylinos.cn>,
	Nicolas Bouchinet <nicolas.bouchinet@oss.cyber.gouv.fr>
Subject: [PATCH v3 RESEND 2/4] PM: hibernate: confine encrypted snapshot writes
Date: Thu, 17 Sep 2026 14:29:48 +0100
Message-ID: <afbc2f0ca0cf680c3e47c931ed62a4d49065c72f.1789651778.git.sean@starlabs.systems>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1789651778.git.sean@starlabs.systems>
References: <cover.1789651778.git.sean@starlabs.systems>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Userspace writes a uswsusp image through the normal block path. Before
allowing encrypted hibernation under lockdown, restrict direct writes to
the process that owns the active snapshot, the swap extents allocated
through the snapshot API, the recorded swap-header page, and the total
number of pages allocated for the image.

Apply the checks to the active swap backend even when its block-device
inode is not itself marked as swap. Require synchronous buffered writes
so reservation accounting follows completed I/O, and release reservations
for partial writes.

Signed-off-by: Sean Rhodes <sean@starlabs.systems>
---
 block/fops.c            |  58 ++++++++---
 include/linux/suspend.h |  24 +++++
 include/linux/swap.h    |   9 ++
 kernel/power/power.h    |   1 +
 kernel/power/swap.c     |  87 +++++++++++++++++
 kernel/power/user.c     | 211 ++++++++++++++++++++++++++++++++++++++++
 kernel/power/user.h     |  11 +++
 mm/swapfile.c           |  25 +++++
 8 files changed, 413 insertions(+), 13 deletions(-)

diff --git a/block/fops.c b/block/fops.c
index 2ce7c6c4714e..bdc9f2cf7156 100644
--- a/block/fops.c
+++ b/block/fops.c
@@ -725,43 +725,68 @@ static ssize_t blkdev_write_iter(struct kiocb *iocb, struct iov_iter *from)
 	struct file *file = iocb->ki_filp;
 	struct inode *bd_inode = bdev_file_inode(file);
 	struct block_device *bdev = I_BDEV(bd_inode);
+	dev_t dev = bd_inode->i_rdev;
 	bool atomic = iocb->ki_flags & IOCB_ATOMIC;
 	loff_t size = bdev_nr_bytes(bdev);
+	enum hibernate_snapshot_write hibernate_write;
+	bool hibernate_active;
+	size_t hibernate_len = 0;
 	size_t shorted = 0;
+	ssize_t hibernate_written = 0;
 	ssize_t ret;
 
 	if (bdev_read_only(bdev))
 		return -EPERM;
 
-	if (IS_SWAPFILE(bd_inode) && !is_hibernate_resume_dev(bd_inode->i_rdev))
-		return -ETXTBSY;
+	hibernate_active = hibernate_snapshot_write_active(dev);
+	if ((IS_SWAPFILE(bd_inode) && !is_hibernate_resume_dev(dev)) ||
+	    hibernate_active) {
+		if (!is_sync_kiocb(iocb) || !iocb_is_dsync(iocb) ||
+		    (iocb->ki_flags & IOCB_DIRECT))
+			return -ETXTBSY;
+
+		hibernate_len = iov_iter_count(from);
+		hibernate_write = hibernate_snapshot_write_begin(dev, iocb->ki_pos, hibernate_len);
+		if (hibernate_write == HIBERNATE_SNAPSHOT_WRITE_NONE)
+			return -ETXTBSY;
+	} else {
+		hibernate_write = HIBERNATE_SNAPSHOT_WRITE_NONE;
+	}
 
-	if (!iov_iter_count(from))
-		return 0;
+	if (!iov_iter_count(from)) {
+		ret = 0;
+		goto out_hibernate;
+	}
 
-	if (iocb->ki_pos >= size)
-		return -ENOSPC;
+	if (iocb->ki_pos >= size) {
+		ret = -ENOSPC;
+		goto out_hibernate;
+	}
 
-	if ((iocb->ki_flags & (IOCB_NOWAIT | IOCB_DIRECT)) == IOCB_NOWAIT)
-		return -EOPNOTSUPP;
+	if ((iocb->ki_flags & (IOCB_NOWAIT | IOCB_DIRECT)) == IOCB_NOWAIT) {
+		ret = -EOPNOTSUPP;
+		goto out_hibernate;
+	}
 
 	if (atomic) {
 		ret = generic_atomic_write_valid(iocb, from);
 		if (ret)
-			return ret;
+			goto out_hibernate;
 	}
 
 	size -= iocb->ki_pos;
 	if (iov_iter_count(from) > size) {
-		if (atomic)
-			return -EINVAL;
+		if (atomic) {
+			ret = -EINVAL;
+			goto out_hibernate;
+		}
 		shorted = iov_iter_count(from) - size;
 		iov_iter_truncate(from, size);
 	}
 
 	ret = file_update_time(file);
 	if (ret)
-		return ret;
+		goto out_hibernate;
 
 	if (iocb->ki_flags & IOCB_DIRECT) {
 		ret = blkdev_direct_write(iocb, from);
@@ -779,9 +804,16 @@ static ssize_t blkdev_write_iter(struct kiocb *iocb, struct iov_iter *from)
 		inode_unlock_shared(bd_inode);
 	}
 
-	if (ret > 0)
+	if (ret > 0) {
+		hibernate_written = ret;
 		ret = generic_write_sync(iocb, ret);
+	}
 	iov_iter_reexpand(from, iov_iter_count(from) + shorted);
+
+out_hibernate:
+	if (hibernate_len)
+		hibernate_snapshot_write_end(hibernate_write, hibernate_len,
+					     hibernate_written);
 	return ret;
 }
 
diff --git a/include/linux/suspend.h b/include/linux/suspend.h
index b02876f1ae38..a2a8863f89cf 100644
--- a/include/linux/suspend.h
+++ b/include/linux/suspend.h
@@ -426,10 +426,34 @@ static inline bool pm_hibernation_mode_is_suspend(void) { return false; }
 
 int arch_resume_nosmt(void);
 
+enum hibernate_snapshot_write {
+	HIBERNATE_SNAPSHOT_WRITE_NONE,
+	HIBERNATE_SNAPSHOT_WRITE_IMAGE,
+	HIBERNATE_SNAPSHOT_WRITE_HEADER,
+};
+
 #ifdef CONFIG_HIBERNATION_SNAPSHOT_DEV
 int is_hibernate_resume_dev(dev_t dev);
+bool hibernate_snapshot_write_active(dev_t dev);
+enum hibernate_snapshot_write
+hibernate_snapshot_write_begin(dev_t dev, loff_t pos, size_t count);
+void hibernate_snapshot_write_end(enum hibernate_snapshot_write type,
+				  size_t reserved, ssize_t written);
 #else
 static inline int is_hibernate_resume_dev(dev_t dev) { return 0; }
+static inline bool hibernate_snapshot_write_active(dev_t dev) { return false; }
+
+static inline enum hibernate_snapshot_write
+hibernate_snapshot_write_begin(dev_t dev, loff_t pos, size_t count)
+{
+	return HIBERNATE_SNAPSHOT_WRITE_NONE;
+}
+
+static inline void hibernate_snapshot_write_end(enum hibernate_snapshot_write type,
+						size_t reserved,
+						ssize_t written)
+{
+}
 #endif
 
 /* Hibernation and suspend events */
diff --git a/include/linux/swap.h b/include/linux/swap.h
index 5658a1634b85..deab983ef3d6 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -377,6 +377,8 @@ extern int find_hibernation_swap_type(dev_t device, sector_t offset);
 int find_first_swap(dev_t *device);
 extern unsigned int count_swap_pages(int, int);
 extern sector_t swapdev_block(int, pgoff_t);
+int swapdev_block_to_extent(int type, sector_t block, pgoff_t *offset,
+			    pgoff_t *nr_pages);
 extern int __swap_count(swp_entry_t entry);
 extern bool swap_entry_swapped(struct swap_info_struct *si, swp_entry_t entry);
 extern int swp_swapcount(swp_entry_t entry);
@@ -472,6 +474,13 @@ static inline int add_swap_extent(struct swap_info_struct *sis,
 {
 	return -EINVAL;
 }
+
+static inline int swapdev_block_to_extent(int type, sector_t block,
+					  pgoff_t *offset,
+					  pgoff_t *nr_pages)
+{
+	return -EINVAL;
+}
 #endif /* CONFIG_SWAP */
 #ifdef CONFIG_MEMCG
 void lru_reparent_memcg(struct mem_cgroup *memcg, struct mem_cgroup *parent, int nid);
diff --git a/kernel/power/power.h b/kernel/power/power.h
index e080230f97fc..815c84c1e0dd 100644
--- a/kernel/power/power.h
+++ b/kernel/power/power.h
@@ -170,6 +170,7 @@ extern bool hibernate_acquire(void);
 extern void hibernate_release(void);
 
 extern sector_t alloc_swapdev_block(int swap);
+bool swsusp_swap_range_allocated(int swap, loff_t pos, size_t count);
 extern void free_all_swap_pages(int swap);
 extern int swsusp_swap_in_use(void);
 
diff --git a/kernel/power/swap.c b/kernel/power/swap.c
index c78f1593600b..ac736d2b59e3 100644
--- a/kernel/power/swap.c
+++ b/kernel/power/swap.c
@@ -166,6 +166,93 @@ static int swsusp_extents_insert(unsigned long swap_offset)
 	return 0;
 }
 
+static bool swsusp_extents_contain_range(unsigned long swap_offset,
+					 unsigned long nr_pages)
+{
+	struct rb_node *node = swsusp_extents.rb_node;
+	struct swsusp_extent *ext;
+	unsigned long end;
+
+	if (!nr_pages)
+		return false;
+
+	end = swap_offset + nr_pages - 1;
+	if (end < swap_offset)
+		return false;
+
+	while (node) {
+		ext = rb_entry(node, struct swsusp_extent, node);
+		if (swap_offset < ext->start)
+			node = node->rb_left;
+		else if (swap_offset > ext->end)
+			node = node->rb_right;
+		else
+			goto found;
+	}
+
+	return false;
+
+found:
+	for (;;) {
+		if (swap_offset < ext->start)
+			return false;
+		if (end <= ext->end)
+			return true;
+		if (ext->end == (unsigned long)-1)
+			return false;
+
+		swap_offset = ext->end + 1;
+		node = rb_next(&ext->node);
+		if (!node)
+			return false;
+
+		ext = rb_entry(node, struct swsusp_extent, node);
+	}
+}
+
+bool swsusp_swap_range_allocated(int swap, loff_t pos, size_t count)
+{
+	u64 block;
+	u64 end;
+	u64 end_block;
+
+	if (swap < 0 || pos < 0 || !count)
+		return false;
+
+	end = (u64)pos + count - 1;
+	if (end < (u64)pos)
+		return false;
+
+	block = (u64)pos >> PAGE_SHIFT;
+	end_block = end >> PAGE_SHIFT;
+
+	for (;;) {
+		u64 remaining_pages = end_block - block + 1;
+		pgoff_t swap_offset;
+		pgoff_t mapped_pages;
+		sector_t page_block = block;
+		u64 pages;
+
+		if (!remaining_pages)
+			return false;
+		if ((u64)page_block != block)
+			return false;
+		if (swapdev_block_to_extent(swap, page_block, &swap_offset,
+					    &mapped_pages))
+			return false;
+		if (!mapped_pages)
+			return false;
+		pages = min_t(u64, mapped_pages, remaining_pages);
+		if ((u64)(unsigned long)pages != pages)
+			return false;
+		if (!swsusp_extents_contain_range(swap_offset, pages))
+			return false;
+		if (pages == remaining_pages)
+			return true;
+		block += pages;
+	}
+}
+
 sector_t alloc_swapdev_block(int swap)
 {
 	unsigned long offset;
diff --git a/kernel/power/user.c b/kernel/power/user.c
index 07dbb1e82847..de41f590c98d 100644
--- a/kernel/power/user.c
+++ b/kernel/power/user.c
@@ -21,6 +21,9 @@
 #include <linux/console.h>
 #include <linux/cpu.h>
 #include <linux/freezer.h>
+#include <linux/pid.h>
+#include <linux/sched/signal.h>
+#include <linux/security.h>
 
 #include <linux/uaccess.h>
 
@@ -35,6 +38,146 @@ int is_hibernate_resume_dev(dev_t dev)
 	return hibernation_available() && snapshot_state.dev == dev;
 }
 
+bool hibernate_snapshot_write_active(dev_t dev)
+{
+#if defined(CONFIG_ENCRYPTED_HIBERNATION)
+	struct snapshot_data *data = &snapshot_state;
+
+	return data->encryption_required && data->mode == O_RDONLY &&
+		data->ready && data->dev == dev &&
+		snapshot_encryption_enabled(data);
+#else
+	return false;
+#endif
+}
+
+#if defined(CONFIG_ENCRYPTED_HIBERNATION)
+static bool snapshot_encrypted_output_owned(struct snapshot_data *data, dev_t dev)
+{
+	return hibernate_snapshot_write_active(dev) &&
+		data->owner_tgid == task_tgid(current);
+}
+
+static bool snapshot_header_write_range(struct snapshot_data *data,
+					loff_t pos, size_t count)
+{
+	loff_t header_offset = data->swap_header_offset;
+	loff_t offset;
+
+	if (pos < header_offset)
+		return false;
+
+	offset = pos - header_offset;
+	return offset < PAGE_SIZE && count <= PAGE_SIZE - offset;
+}
+
+static u64 snapshot_swap_write_budget(struct snapshot_data *data)
+{
+	if (data->crypt_swap_allocated > U64_MAX >> PAGE_SHIFT)
+		return 0;
+
+	return data->crypt_swap_allocated << PAGE_SHIFT;
+}
+
+static void snapshot_reset_swap_write_state(struct snapshot_data *data,
+					    bool reset_allocation)
+{
+	spin_lock(&data->crypt_lock);
+	if (reset_allocation)
+		data->crypt_swap_allocated = 0;
+	data->crypt_swap_reserved = 0;
+	data->crypt_header_reserved = 0;
+	spin_unlock(&data->crypt_lock);
+}
+#endif
+
+enum hibernate_snapshot_write
+hibernate_snapshot_write_begin(dev_t dev, loff_t pos, size_t count)
+{
+#if defined(CONFIG_ENCRYPTED_HIBERNATION)
+	struct snapshot_data *data = &snapshot_state;
+	enum hibernate_snapshot_write type = HIBERNATE_SNAPSHOT_WRITE_NONE;
+	bool image_range_allocated;
+	u64 swap_budget;
+
+	if (!count || !snapshot_encrypted_output_owned(data, dev))
+		return HIBERNATE_SNAPSHOT_WRITE_NONE;
+
+	mutex_lock(&system_transition_mutex);
+
+	if (!snapshot_encrypted_output_owned(data, dev))
+		goto unlock;
+
+	image_range_allocated = swsusp_swap_range_allocated(data->swap, pos, count);
+
+	spin_lock(&data->crypt_lock);
+	swap_budget = snapshot_swap_write_budget(data);
+	if (snapshot_header_write_range(data, pos, count) &&
+	    data->crypt_header_reserved <= PAGE_SIZE &&
+	    PAGE_SIZE - data->crypt_header_reserved >= count) {
+		data->crypt_header_reserved += count;
+		type = HIBERNATE_SNAPSHOT_WRITE_HEADER;
+	} else if (image_range_allocated &&
+		   swap_budget >= data->crypt_swap_reserved &&
+		   swap_budget - data->crypt_swap_reserved >= count) {
+		data->crypt_swap_reserved += count;
+		type = HIBERNATE_SNAPSHOT_WRITE_IMAGE;
+	}
+	spin_unlock(&data->crypt_lock);
+
+	if (type == HIBERNATE_SNAPSHOT_WRITE_NONE)
+		goto unlock;
+
+	return type;
+
+unlock:
+	mutex_unlock(&system_transition_mutex);
+	return HIBERNATE_SNAPSHOT_WRITE_NONE;
+#else
+	return HIBERNATE_SNAPSHOT_WRITE_NONE;
+#endif
+}
+
+void hibernate_snapshot_write_end(enum hibernate_snapshot_write type,
+				  size_t reserved, ssize_t written)
+{
+#if defined(CONFIG_ENCRYPTED_HIBERNATION)
+	struct snapshot_data *data = &snapshot_state;
+	u64 *reserved_total;
+	size_t unused;
+
+	if (type == HIBERNATE_SNAPSHOT_WRITE_NONE)
+		return;
+	if (!reserved)
+		goto unlock;
+
+	if (type == HIBERNATE_SNAPSHOT_WRITE_HEADER)
+		unused = reserved;
+	else if (written <= 0)
+		unused = reserved;
+	else if (written < reserved)
+		unused = reserved - written;
+	else
+		goto unlock;
+
+	reserved_total = type == HIBERNATE_SNAPSHOT_WRITE_HEADER ?
+		&data->crypt_header_reserved : &data->crypt_swap_reserved;
+
+	spin_lock(&data->crypt_lock);
+	*reserved_total -= min_t(u64, *reserved_total, unused);
+	spin_unlock(&data->crypt_lock);
+
+unlock:
+	mutex_unlock(&system_transition_mutex);
+#endif
+}
+
+static bool snapshot_encryption_required(struct snapshot_data *data)
+{
+	data->encryption_required = security_locked_down(LOCKDOWN_HIBERNATION);
+	return data->encryption_required;
+}
+
 static int snapshot_open(struct inode *inode, struct file *filp)
 {
 	struct snapshot_data *data;
@@ -60,6 +203,14 @@ static int snapshot_open(struct inode *inode, struct file *filp)
 	data = &snapshot_state;
 	filp->private_data = data;
 	memset(&data->handle, 0, sizeof(struct snapshot_handle));
+#if defined(CONFIG_ENCRYPTED_HIBERNATION)
+	spin_lock_init(&data->crypt_lock);
+	data->crypt_swap_allocated = 0;
+	data->crypt_swap_reserved = 0;
+	data->crypt_header_reserved = 0;
+	data->swap_header_offset = 0;
+	data->owner_tgid = NULL;
+#endif
 	if ((filp->f_flags & O_ACCMODE) == O_RDONLY) {
 		/* Hibernating.  The image device should be accessible. */
 		data->swap = pin_hibernation_swap_type(swsusp_resume_device, 0);
@@ -90,6 +241,11 @@ static int snapshot_open(struct inode *inode, struct file *filp)
 	data->ready = false;
 	data->platform_support = false;
 	data->dev = 0;
+	data->encryption_required = snapshot_encryption_required(data);
+#if defined(CONFIG_ENCRYPTED_HIBERNATION)
+	if (!error)
+		data->owner_tgid = get_task_pid(current, PIDTYPE_TGID);
+#endif
 
  unlock:
 	unlock_system_sleep(sleep_flags);
@@ -107,6 +263,10 @@ static int snapshot_release(struct inode *inode, struct file *filp)
 	swsusp_free();
 	data = filp->private_data;
 	data->dev = 0;
+#if defined(CONFIG_ENCRYPTED_HIBERNATION)
+	put_pid(data->owner_tgid);
+	data->owner_tgid = NULL;
+#endif
 	free_all_swap_pages(data->swap);
 	unpin_hibernation_swap_type(data->swap);
 	if (data->frozen) {
@@ -141,6 +301,11 @@ static ssize_t snapshot_read(struct file *filp, char __user *buf,
 		res = -ENODATA;
 		goto unlock;
 	}
+	if (snapshot_encryption_required(data) &&
+	    !snapshot_encryption_enabled(data)) {
+		res = -EPERM;
+		goto unlock;
+	}
 
 	if (snapshot_encryption_enabled(data)) {
 		res = snapshot_read_encrypted(data, buf, count, offp);
@@ -183,6 +348,12 @@ static ssize_t snapshot_write(struct file *filp, const char __user *buf,
 
 	data = filp->private_data;
 
+	if (snapshot_encryption_required(data) &&
+	    !snapshot_encryption_enabled(data)) {
+		res = -EPERM;
+		goto unlock;
+	}
+
 	if (snapshot_encryption_enabled(data)) {
 		res = snapshot_write_encrypted(data, buf, count, offp);
 		goto unlock;
@@ -255,6 +426,9 @@ static int snapshot_set_swap_area(struct snapshot_data *data,
 	if (data->swap < 0)
 		return swdev ? -ENODEV : -EINVAL;
 	data->dev = swdev;
+#if defined(CONFIG_ENCRYPTED_HIBERNATION)
+	data->swap_header_offset = (loff_t)offset << PAGE_SHIFT;
+#endif
 	return 0;
 }
 
@@ -321,6 +495,11 @@ static long snapshot_ioctl(struct file *filp, unsigned int cmd,
 			error = -EPERM;
 			break;
 		}
+		if (snapshot_encryption_required(data) &&
+		    !snapshot_encryption_enabled(data)) {
+			error = -EPERM;
+			break;
+		}
 		pm_restore_gfp_mask();
 		error = hibernation_snapshot(data->platform_support);
 		if (!error) {
@@ -331,6 +510,11 @@ static long snapshot_ioctl(struct file *filp, unsigned int cmd,
 		break;
 
 	case SNAPSHOT_ATOMIC_RESTORE:
+		if (snapshot_encryption_required(data) &&
+		    !snapshot_encryption_enabled(data)) {
+			error = -EPERM;
+			break;
+		}
 		if (snapshot_encryption_enabled(data)) {
 			error = snapshot_finalize_decrypted_image(data);
 			if (error)
@@ -356,6 +540,9 @@ static long snapshot_ioctl(struct file *filp, unsigned int cmd,
 		memset(&data->handle, 0, sizeof(struct snapshot_handle));
 		data->ready = false;
 		snapshot_teardown_encryption(data);
+#if defined(CONFIG_ENCRYPTED_HIBERNATION)
+		snapshot_reset_swap_write_state(data, false);
+#endif
 		/*
 		 * It is necessary to thaw kernel threads here, because
 		 * SNAPSHOT_CREATE_IMAGE may be invoked directly after
@@ -398,6 +585,13 @@ static long snapshot_ioctl(struct file *filp, unsigned int cmd,
 		if (offset) {
 			offset <<= PAGE_SHIFT;
 			error = put_user(offset, (loff_t __user *)arg);
+#if defined(CONFIG_ENCRYPTED_HIBERNATION)
+			if (!error) {
+				spin_lock(&data->crypt_lock);
+				data->crypt_swap_allocated++;
+				spin_unlock(&data->crypt_lock);
+			}
+#endif
 		} else {
 			error = -ENOSPC;
 		}
@@ -409,6 +603,9 @@ static long snapshot_ioctl(struct file *filp, unsigned int cmd,
 			break;
 		}
 		free_all_swap_pages(data->swap);
+#if defined(CONFIG_ENCRYPTED_HIBERNATION)
+		snapshot_reset_swap_write_state(data, true);
+#endif
 		break;
 
 	case SNAPSHOT_S2RAM:
@@ -416,6 +613,11 @@ static long snapshot_ioctl(struct file *filp, unsigned int cmd,
 			error = -EPERM;
 			break;
 		}
+		if (snapshot_encryption_required(data) &&
+		    !snapshot_encryption_enabled(data)) {
+			error = -EPERM;
+			break;
+		}
 		/*
 		 * Tasks are frozen and the notifiers have been called with
 		 * PM_HIBERNATION_PREPARE
@@ -429,6 +631,11 @@ static long snapshot_ioctl(struct file *filp, unsigned int cmd,
 		break;
 
 	case SNAPSHOT_POWER_OFF:
+		if (snapshot_encryption_required(data) &&
+		    !snapshot_encryption_enabled(data)) {
+			error = -EPERM;
+			break;
+		}
 		if (data->platform_support)
 			error = hibernation_platform_enter();
 		break;
@@ -442,6 +649,10 @@ static long snapshot_ioctl(struct file *filp, unsigned int cmd,
 			error = snapshot_get_encryption_key(data, (void __user *)arg);
 		else
 			error = snapshot_set_encryption_key(data, (void __user *)arg);
+#if defined(CONFIG_ENCRYPTED_HIBERNATION)
+		if (!error)
+			snapshot_reset_swap_write_state(data, false);
+#endif
 		break;
 
 	case SNAPSHOT_SET_USER_KEY:
diff --git a/kernel/power/user.h b/kernel/power/user.h
index b0c20e5d5ee9..0e1e123e3230 100644
--- a/kernel/power/user.h
+++ b/kernel/power/user.h
@@ -5,10 +5,13 @@
 
 #include <linux/crypto.h>
 #include <linux/scatterlist.h>
+#include <linux/spinlock.h>
 #include <linux/suspend_ioctls.h>
 #include <crypto/aead.h>
 #include <crypto/aes.h>
 
+struct pid;
+
 #define SNAPSHOT_ENCRYPTION_KEY_SIZE AES_KEYSIZE_128
 #define SNAPSHOT_AUTH_TAG_SIZE 16
 
@@ -23,6 +26,7 @@ struct snapshot_data {
 	bool ready;
 	bool platform_support;
 	bool free_bitmaps;
+	bool encryption_required;
 	dev_t dev;
 
 #if defined(CONFIG_ENCRYPTED_HIBERNATION)
@@ -42,6 +46,13 @@ struct snapshot_data {
 	bool user_key_valid;
 	u64 meta_size;
 	u64 crypt_meta_size;
+	/* Protect the swap allocation and block-write reservations. */
+	spinlock_t crypt_lock;
+	u64 crypt_swap_allocated;
+	u64 crypt_swap_reserved;
+	u64 crypt_header_reserved;
+	loff_t swap_header_offset;
+	struct pid *owner_tgid;
 #endif
 
 };
diff --git a/mm/swapfile.c b/mm/swapfile.c
index 601979b97f95..ebddf954ad84 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -2379,6 +2379,31 @@ sector_t swapdev_block(int type, pgoff_t offset)
 	return se->start_block + (offset - se->start_page);
 }
 
+int swapdev_block_to_extent(int type, sector_t block, pgoff_t *offset,
+			    pgoff_t *nr_pages)
+{
+	struct swap_info_struct *si = swap_type_to_info(type);
+	struct swap_extent *se;
+	struct rb_node *rb;
+
+	if (!si || !(si->flags & SWP_WRITEOK))
+		return -ENODEV;
+
+	for (rb = rb_first(&si->swap_extent_root); rb; rb = rb_next(rb)) {
+		se = rb_entry(rb, struct swap_extent, rb_node);
+		if (block >= se->start_block &&
+		    block - se->start_block < se->nr_pages) {
+			pgoff_t page = block - se->start_block;
+
+			*offset = se->start_page + page;
+			*nr_pages = se->nr_pages - page;
+			return 0;
+		}
+	}
+
+	return -ENOENT;
+}
+
 /*
  * Return either the total number of swap pages of given type, or the number
  * of free pages of that type (depending on @free)
