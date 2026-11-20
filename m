Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795143374;
	b=bSo6z6OCXsbt4tAgE8rifmVRYMilf7Ny81GqddpBlOPpjGz0nUwiKLfyAs1nTZ0ik7vF
	 AdgbBAcQw4QSinHdIo2C4yzzWatyq85WNqBBl94zjHQ76JX6wHd2gjXjZ5N7Q3ZZADyS9
	 WZtq+CZOG4cYIdSdLFNxb8UVAo3ROMDg9vc1FESsCvjBQ9rQrdpI+BDV51/gVoG9l0YJz
	 d1U2HTkfPjFspYs0z6qs8zswCEhzJFbskAZx7/RMGlDc3fddRHzQcmr0BMx1HdnTUn7Ru
	 bSLoZH3Hd5mSSOzSW6vIcC9tg22svoCwJTjb6cbe5mdqwcaitmtXgIY9yySDB7yyJ1w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795143374;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=dKnCDV+ucW27s1+PYFWZiBr7bc8fW+CJcx287Vos/Tw=;
	b=QNMQqMbDjnIZjenreHiirD30KqzYJ451AnNwzLCvmsX7lm1piZ+SauXPIYczaYG+uMyQ
	 zu1LevSI/3Q9wSYZFha/MDtm8yGtzvlkhuIvwjL7uqSPwe/pT+qyf6euUx7/HojIUpbuE
	 if3czV+70An9XnfMPOZaCUw0RRQKSh/zr96rINbJLVy5hkQ4RWGpi7vqIEMCwvJKis3Ie
	 g3l/DPKGe2iGfdRNHPWFF1P0HC9MBGUyqe6yUZIKwOg/RZwRDCYmGDzi8UImV/P6ozCkN
	 SgKu3fMk3UgOIKs31JiS7fAW71tB1yeVMHDobq8OBqWgRLb4iJexBLBxuhAOesEK8Zw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=smartx.com;
	spf=pass smtp.mailfrom=smartx.com;
	dkim=pass header.d=smartx-com.20260707.gappssmtp.com header.i=@smartx-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b="PxETNb/m";
	arc=none smtp.remote-ip=209.85.216.49
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77256606A32C
	for <linux-block@vger.kernel.org>; Fri, 20 Nov 2026 02:56:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 77256606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=smartx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=smartx.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=smartx-com.20260707.gappssmtp.com header.i=@smartx-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=PxETNb/m
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-3b0bbdeae06so278599a91.1
        for <linux-block@vger.kernel.org>; Thu, 19 Nov 2026 18:56:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smartx-com.20260707.gappssmtp.com; s=20260707; t=1795143374; x=1795748174; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dKnCDV+ucW27s1+PYFWZiBr7bc8fW+CJcx287Vos/Tw=;
        b=PxETNb/mK/nN9/3uvLQZG6cDjlR84AaWjZmzJ0Jl3PlQuq2mzx2QAbomFj3RMM8cSl
         UVB32kYW3lgcXGYspUo8PCk1AjOgmR7xu9kyJedzBeWqhUm+K2eEH4MDo8MVPowub76N
         LqrIF99F534ogFeshyh69sd4axdrKYd1+GBFPPl3Yv/TJiCcNKmybSeotHyGdC9OAcjj
         4uxFnP4GDfZxZ/3dc2KR3TKNV0/0QH8sYeB8YMF1S/v5Jb5HwOQp6dKquZe5pw8r5E/x
         tdiXY6U0E6z8vR8uJyMRzC71Hq2UYBLuJ2UuLsU1nuOTqeEjkY3qdv93xZRAFN7HlWYO
         QNbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795143374; x=1795748174;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=dKnCDV+ucW27s1+PYFWZiBr7bc8fW+CJcx287Vos/Tw=;
        b=QTcgJH8bajm8YV4YVumsm7wnuhstTwiE+FEo9iWuByi4EEfd6aGuLcTcBRKx4YKJfC
         3oBRCW0t6R0kdPSruC7g3F2TQfdlCbtUBcTtMhG5znfzSQkf+Kl4Q3SEs6O8aBN1N+zi
         gVZlWKrHZdUktqaVsKpEV5hkW77DGYg68PjOTMiGAe1LZc8ge4EDQYn5PFHLHEtoLGMi
         gNNNC3LiTym+A5px87wXe2s+LREfpdqXVqqbRP+RNxW/9yY0sk5ekr3W1PFOD6VyTUCT
         0qAm+jLD9M1Uj75/3ypsHGZBmvlZkWVXCgCDGqlet4XSQRxA+xB5vHjvDbntxRCEYc8h
         MtmQ==
X-Gm-Message-State: APuU4Z9BRiZBNVqqeEcUQEOuKx8Xba/B50gavpTLBQQQr0W4bQMZFX+X
	R9brGLLps2V7ZY0i1I/cDUwLunRlPwcaW9dTVfgdPvNOtVXgj2dfsibVQ7vy5pN66l0y7dRzO4T
	afs85XeptkXAhmdaNn71BM13HAgZfr8H/xS19+2qt1Zm5DItuiKQyRIffZw==
X-Gm-Gg: AZFdTZcC6KKL6ikn+dSOj6bvwBXy1ECJ4X6FlgPTE5EWfkZZ8fxTuz5rW+he2rZqx+Z
	aUue5MlAq23Fn4mN18EyUwg4eNa4rff/3EfeTx0mDgVty/kcEQhdxcg6B496nni7DiMBHHZSVZB
	BPtFM2fkeJHsYyuFLkWrn3XX/f/W0OxJOzfPH7+Qtme4Qtw3+PcKFggdtFdmggX17Ia5qrU6QBt
	7kz6ebkDWpwXK9EkCbrHs7viAErWiXh8gp7K0MNZ7sd6ZoZM/IO7krNfdLL0UCTRaXfK4Y+Bd+t
	hHRg6jY8DLfaucNxDi16DdeTOoJCGT4wx/hYzec6zsBRjlAxrFQmT6OlebA/vjgj+mkHtAZ74TX
	3Qlvf3BQNPZhomGY+ysRTTf+qPjr2gZVwvbClTlewzyBdBaHIYFWijnejyQFLShyHaeOauhWTnA
	Ny3nnv7icQP91QG7ucoEGy6aluoBRGSwrjGZ11PjhF5YlSRhjGw6PZOXi6Ygt867MBswHcj6H0b
	B4ymwmmSuiuLDuL7bIveKvduOnyWL0Q2OIe7eSmdcPKARsM9v8m83d/nUcsbFYcmgSfkJjbNEDP
	NFK6kh+3EafAGSJBMDNwd+1eabyWzbFdG/Xa2w==
X-Received: by 2002:a17:90b:4d10:b0:3b1:b66a:c05 with SMTP id 98e67ed59e1d1-3b41c8e0c5dmr1228572a91.14.1795143373636;
        Thu, 19 Nov 2026 18:56:13 -0800 (PST)
Received: from localhost.localdomain ([103.26.8.217])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-3b405d63728sm5546461a91.8.2026.11.19.18.56.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 18:56:13 -0800 (PST)
From: Lei Chen <lei.chen@smartx.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Lei Chen <lei.chen@smartx.com>
Subject: [PATCH v2 1/5] block: expose blk-mq tag sets through debugfs
Date: Fri, 20 Nov 2026 10:56:00 +0800
Message-ID: <8e4918919fb43522f28d907987edf03d50da26d5.1795143228.git.lei.chen@smartx.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1795143228.git.lei.chen@smartx.com>
References: <20261009030111.57784-1-lei.chen@smartx.com> <cover.1795143228.git.lei.chen@smartx.com>
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

The existing block debugfs hierarchy exposes request queues and hardware
contexts, but has no directory for the tag set they share. This makes it
difficult to inspect tag set configuration and CPU mappings or identify
which request queues share a tag set.

Add a tagset/<id> directory under the debugfs root for each allocated
tag set. Expose its configuration, flags and attached queues, along with
CPU-to-hardware-queue mappings in map/<map-index>/cpu<cpu-id> files.
Expose tag information in tags/<hctx-index> and shared_tags, using
symlinks to shared_tags for entries that reference the shared tags.

Tie the directory lifetime to tag set allocation and release. Recreate
the tags directory when the number of hardware queues changes so that
its entries reflect the updated tag array. Use a NOIO allocation scope
when creating debugfs entries to prevent reclaim from issuing I/O to
frozen queues.

Serialize reads with hardware queue updates using update_nr_hwq_lock.
Tag reads must use down_read_trylock(): blk_mq_update_nr_hw_queues()
removes the tags directory while holding the write lock, and debugfs
removal waits for active reads to finish. Using down_read() would allow
the following deadlock. Both lock operations refer to
set->update_nr_hwq_lock, and time flows downward:

  blk_mq_update_nr_hw_queues()        Debugfs reader
  -----------------------------     --------------
  down_write()
    |
    |                               Acquire active reference
    |                               blk_mq_tagset_tags_show()
    |                               down_read()
    |                                 |
  debugfs_remove()                    Wait for writer to unlock
    |                                 |
  Wait for active read to finish      |
    |                                 |
    +---------- DEADLOCK -------------+

Return -EAGAIN when the read lock cannot be acquired, allowing the read
to finish and debugfs removal to proceed.

Signed-off-by: Lei Chen <lei.chen@smartx.com>
---
 block/blk-mq-debugfs.c | 316 +++++++++++++++++++++++++++++++++++++++++
 block/blk-mq-debugfs.h |  22 +++
 block/blk-mq.c         |   8 ++
 include/linux/blk-mq.h |   8 ++
 4 files changed, 354 insertions(+)

diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
index 6754d8f9449c..fd9eb17e97b9 100644
--- a/block/blk-mq-debugfs.c
+++ b/block/blk-mq-debugfs.c
@@ -7,6 +7,7 @@
 #include <linux/blkdev.h>
 #include <linux/build_bug.h>
 #include <linux/debugfs.h>
+#include <linux/idr.h>
 
 #include "blk.h"
 #include "blk-mq.h"
@@ -827,3 +828,318 @@ void blk_mq_debugfs_unregister_sched_hctx(struct blk_mq_hw_ctx *hctx)
 	debugfs_remove_recursive(hctx->sched_debugfs_dir);
 	hctx->sched_debugfs_dir = NULL;
 }
+
+/* Tag set debugfs --------------------------------------------------------- */
+
+static DEFINE_IDA(blk_mq_tagset_debugfs_ida);
+static DEFINE_MUTEX(blk_mq_tagset_debugfs_mutex);
+static struct dentry *blk_mq_tagset_debugfs_root;
+
+/* Prevent debugfs allocation reclaim from issuing I/O to frozen queues. */
+static unsigned int __must_check blk_mq_tagset_debugfs_lock(void)
+	__acquires(&blk_mq_tagset_debugfs_mutex)
+{
+	unsigned int memflags = memalloc_noio_save();
+
+	mutex_lock(&blk_mq_tagset_debugfs_mutex);
+	return memflags;
+}
+
+static void blk_mq_tagset_debugfs_unlock(unsigned int memflags)
+	__releases(&blk_mq_tagset_debugfs_mutex)
+{
+	mutex_unlock(&blk_mq_tagset_debugfs_mutex);
+	memalloc_noio_restore(memflags);
+}
+
+#define BLK_MQ_F_NAME(name) [ilog2(BLK_MQ_F_##name)] = #name
+static const char *const tagset_flag_name[] = {
+	BLK_MQ_F_NAME(TAG_QUEUE_SHARED),
+	BLK_MQ_F_NAME(STACKING),
+	BLK_MQ_F_NAME(TAG_HCTX_SHARED),
+	BLK_MQ_F_NAME(BLOCKING),
+	BLK_MQ_F_NAME(TAG_RR),
+	BLK_MQ_F_NAME(NO_SCHED_BY_DEFAULT),
+};
+#undef BLK_MQ_F_NAME
+
+static int blk_mq_tagset_flags_show(struct seq_file *m, void *v)
+{
+	struct blk_mq_tag_set *set = m->private;
+
+	BUILD_BUG_ON(ARRAY_SIZE(tagset_flag_name) != ilog2(BLK_MQ_F_MAX));
+
+	down_read(&set->update_nr_hwq_lock);
+
+	blk_flags_show(m, set->flags, tagset_flag_name,
+		       ARRAY_SIZE(tagset_flag_name));
+	seq_putc(m, '\n');
+
+	up_read(&set->update_nr_hwq_lock);
+
+	return 0;
+}
+DEFINE_SHOW_ATTRIBUTE(blk_mq_tagset_flags);
+
+#define BLK_MQ_TAGSET_VALUE_SHOW(_name, _type, _member, _format) \
+static int blk_mq_tagset_##_name##_show(struct seq_file *m, void *v) \
+{ \
+	struct blk_mq_tag_set *set = m->private; \
+	_type value; \
+ \
+	down_read(&set->update_nr_hwq_lock); \
+	value = set->_member; \
+	up_read(&set->update_nr_hwq_lock); \
+ \
+	seq_printf(m, _format, value); \
+	return 0; \
+} \
+DEFINE_SHOW_ATTRIBUTE(blk_mq_tagset_##_name)
+
+BLK_MQ_TAGSET_VALUE_SHOW(nr_maps, unsigned int, nr_maps, "%u\n");
+BLK_MQ_TAGSET_VALUE_SHOW(nr_hw_queues, unsigned int, nr_hw_queues, "%u\n");
+BLK_MQ_TAGSET_VALUE_SHOW(queue_depth, unsigned int, queue_depth, "%u\n");
+BLK_MQ_TAGSET_VALUE_SHOW(reserved_tags, unsigned int, reserved_tags, "%u\n");
+BLK_MQ_TAGSET_VALUE_SHOW(cmd_size, unsigned int, cmd_size, "%u\n");
+BLK_MQ_TAGSET_VALUE_SHOW(numa_node, int, numa_node, "%d\n");
+BLK_MQ_TAGSET_VALUE_SHOW(timeout, unsigned int, timeout, "%u\n");
+
+#undef BLK_MQ_TAGSET_VALUE_SHOW
+
+static int blk_mq_tagset_hctx_tags_shared_show(struct seq_file *m, void *v)
+{
+	struct blk_mq_tag_set *set = m->private;
+	bool shared;
+
+	down_read(&set->update_nr_hwq_lock);
+	shared = blk_mq_is_shared_tags(set->flags);
+	up_read(&set->update_nr_hwq_lock);
+
+	seq_printf(m, "%d\n", shared);
+	return 0;
+}
+DEFINE_SHOW_ATTRIBUTE(blk_mq_tagset_hctx_tags_shared);
+
+static int blk_mq_tagset_queues_show(struct seq_file *m, void *v)
+{
+	struct blk_mq_tag_set *set = m->private;
+	struct request_queue *q;
+	int ret;
+
+	ret = down_read_interruptible(&set->update_nr_hwq_lock);
+	if (ret)
+		return ret;
+
+	ret = mutex_lock_interruptible(&set->tag_list_lock);
+	if (ret) {
+		up_read(&set->update_nr_hwq_lock);
+		return ret;
+	}
+
+	if (list_empty(&set->tag_list))
+		seq_puts(m, "(none)\n");
+
+	list_for_each_entry(q, &set->tag_list, tag_set_list)
+		seq_printf(m, "%s\n", q->disk ? q->disk->disk_name : "(no-disk)");
+
+	mutex_unlock(&set->tag_list_lock);
+	up_read(&set->update_nr_hwq_lock);
+	return 0;
+}
+DEFINE_SHOW_ATTRIBUTE(blk_mq_tagset_queues);
+
+static int blk_mq_tagset_map_show(struct seq_file *m, void *v)
+{
+	struct blk_mq_tag_set *set = m->private;
+	unsigned long index = debugfs_get_aux_num(m->file);
+	unsigned int map = index / nr_cpu_ids;
+	unsigned int cpu = index % nr_cpu_ids;
+
+	down_read(&set->update_nr_hwq_lock);
+
+	seq_printf(m, "%u\n", set->map[map].mq_map[cpu]);
+
+	up_read(&set->update_nr_hwq_lock);
+	return 0;
+}
+DEFINE_SHOW_ATTRIBUTE(blk_mq_tagset_map);
+
+static void blk_mq_tagset_debugfs_create_maps(struct blk_mq_tag_set *set)
+{
+	struct dentry *dir, *map_dir;
+	unsigned int cpu, i;
+	char name[20];
+
+	dir = debugfs_create_dir("map", set->debugfs_dir);
+	if (IS_ERR_OR_NULL(dir))
+		return;
+
+	for (i = 0; i < set->nr_maps; i++) {
+		snprintf(name, sizeof(name), "%u", i);
+		map_dir = debugfs_create_dir(name, dir);
+		if (IS_ERR_OR_NULL(map_dir))
+			continue;
+
+		for_each_possible_cpu(cpu) {
+			/* Encode the map and CPU indices in the auxiliary data. */
+			unsigned long index = (unsigned long)i * nr_cpu_ids + cpu;
+
+			snprintf(name, sizeof(name), "cpu%u", cpu);
+			debugfs_create_file_aux_num(name, 0444, map_dir, set,
+						   index, &blk_mq_tagset_map_fops);
+		}
+	}
+}
+
+static int blk_mq_tagset_tags_show(struct seq_file *m, void *v)
+{
+	struct blk_mq_tag_set *set = m->private;
+	long index = (long)debugfs_get_aux_num(m->file);
+	struct blk_mq_tags *tags = NULL;
+
+	/*
+	 * use trylock here to avoid deadlock
+	 *
+	 * blk_mq_update_nr_hw_queues
+	 *     down_write(update_nr_hwq_lock)
+	 *     blk_mq_tagset_debugfs_remove_tags
+	 *         wait active reads
+	 *
+	 * blk_mq_tagset_tags_show (active reads)
+	 *     down_read(udpate_nr_hwq_lock)
+	 *
+	 */
+	if (!down_read_trylock(&set->update_nr_hwq_lock))
+		return -EAGAIN;
+
+	if (index == -1L)
+		tags = set->shared_tags;
+	else if (index >= 0 && index < set->nr_hw_queues)
+		tags = set->tags[index];
+
+	if (!tags) {
+		up_read(&set->update_nr_hwq_lock);
+		return -ENODEV;
+	}
+
+	seq_printf(m, ".nr_tags=%u\n.nr_reserved_tags=%u\n.active_queues=%u\n",
+		   tags->nr_tags,
+		   tags->nr_reserved_tags,
+		   READ_ONCE(tags->active_queues));
+
+	up_read(&set->update_nr_hwq_lock);
+	return 0;
+}
+DEFINE_SHOW_ATTRIBUTE(blk_mq_tagset_tags);
+
+void blk_mq_tagset_debugfs_remove_tags(struct blk_mq_tag_set *set)
+{
+	if (IS_ERR_OR_NULL(set->debugfs_dir))
+		return;
+
+	debugfs_lookup_and_remove("tags", set->debugfs_dir);
+}
+
+void blk_mq_tagset_debugfs_create_tags(struct blk_mq_tag_set *set)
+{
+	struct dentry *dir;
+	unsigned int i;
+	char name[20];
+
+	if (IS_ERR_OR_NULL(set->debugfs_dir))
+		return;
+
+	dir = debugfs_create_dir("tags", set->debugfs_dir);
+	if (IS_ERR_OR_NULL(dir))
+		return;
+
+	for (i = 0; i < set->nr_hw_queues; i++) {
+		struct blk_mq_tags *tags = set->tags[i];
+
+		snprintf(name, sizeof(name), "%u", i);
+		if (tags && tags == set->shared_tags)
+			debugfs_create_symlink(name, dir, "../shared_tags");
+		else
+			debugfs_create_file_aux_num(name, 0444, dir, set, i,
+						    &blk_mq_tagset_tags_fops);
+	}
+}
+
+static void blk_mq_tagset_debugfs_create_files(struct blk_mq_tag_set *set)
+{
+	debugfs_create_file("nr_maps", 0444, set->debugfs_dir, set,
+			    &blk_mq_tagset_nr_maps_fops);
+	debugfs_create_file("nr_hw_queues", 0444, set->debugfs_dir, set,
+			    &blk_mq_tagset_nr_hw_queues_fops);
+	debugfs_create_file("queue_depth", 0444, set->debugfs_dir, set,
+			    &blk_mq_tagset_queue_depth_fops);
+	debugfs_create_file("reserved_tags", 0444, set->debugfs_dir, set,
+			    &blk_mq_tagset_reserved_tags_fops);
+	debugfs_create_file("cmd_size", 0444, set->debugfs_dir, set,
+			    &blk_mq_tagset_cmd_size_fops);
+	debugfs_create_file("numa_node", 0444, set->debugfs_dir, set,
+			    &blk_mq_tagset_numa_node_fops);
+	debugfs_create_file("timeout", 0444, set->debugfs_dir, set,
+			    &blk_mq_tagset_timeout_fops);
+	debugfs_create_file("hctx_tags_shared", 0444, set->debugfs_dir, set,
+			    &blk_mq_tagset_hctx_tags_shared_fops);
+	debugfs_create_file("flags", 0444, set->debugfs_dir, set,
+			    &blk_mq_tagset_flags_fops);
+	debugfs_create_file("queues", 0444, set->debugfs_dir, set,
+			    &blk_mq_tagset_queues_fops);
+	blk_mq_tagset_debugfs_create_maps(set);
+	debugfs_create_file_aux_num("shared_tags", 0444, set->debugfs_dir, set,
+				    -1, &blk_mq_tagset_tags_fops);
+	blk_mq_tagset_debugfs_create_tags(set);
+}
+
+void blk_mq_tagset_debugfs_register(struct blk_mq_tag_set *set)
+{
+	struct dentry *dir;
+	unsigned int memflags;
+	char name[24];
+	int id;
+
+	memflags = blk_mq_tagset_debugfs_lock();
+
+	if (!blk_mq_tagset_debugfs_root)
+		blk_mq_tagset_debugfs_root = debugfs_create_dir("tagset", NULL);
+
+	if (set->debugfs_dir || IS_ERR_OR_NULL(blk_mq_tagset_debugfs_root))
+		goto out_unlock;
+
+	id = ida_alloc(&blk_mq_tagset_debugfs_ida, GFP_KERNEL);
+	if (id < 0)
+		goto out_unlock;
+
+	snprintf(name, sizeof(name), "%d", id);
+	dir = debugfs_create_dir(name, blk_mq_tagset_debugfs_root);
+	if (IS_ERR_OR_NULL(dir)) {
+		ida_free(&blk_mq_tagset_debugfs_ida, id);
+		goto out_unlock;
+	}
+
+	set->debugfs_id = id;
+	set->debugfs_dir = dir;
+	blk_mq_tagset_debugfs_create_files(set);
+
+out_unlock:
+	blk_mq_tagset_debugfs_unlock(memflags);
+}
+
+void blk_mq_tagset_debugfs_unregister(struct blk_mq_tag_set *set)
+{
+	mutex_lock(&blk_mq_tagset_debugfs_mutex);
+
+	if (set->debugfs_dir) {
+		debugfs_remove_recursive(set->debugfs_dir);
+		set->debugfs_dir = NULL;
+	}
+
+	if (set->debugfs_id >= 0) {
+		ida_free(&blk_mq_tagset_debugfs_ida, set->debugfs_id);
+		set->debugfs_id = -1;
+	}
+
+	mutex_unlock(&blk_mq_tagset_debugfs_mutex);
+}
diff --git a/block/blk-mq-debugfs.h b/block/blk-mq-debugfs.h
index 49bb1aaa83dc..aea278bdc4e7 100644
--- a/block/blk-mq-debugfs.h
+++ b/block/blk-mq-debugfs.h
@@ -7,6 +7,7 @@
 #include <linux/seq_file.h>
 
 struct blk_mq_hw_ctx;
+struct blk_mq_tag_set;
 
 struct blk_mq_debugfs_attr {
 	const char *name;
@@ -34,6 +35,11 @@ void blk_mq_debugfs_register_sched_hctx(struct request_queue *q,
 void blk_mq_debugfs_unregister_sched_hctx(struct blk_mq_hw_ctx *hctx);
 
 void blk_mq_debugfs_register_rq_qos(struct request_queue *q);
+
+void blk_mq_tagset_debugfs_register(struct blk_mq_tag_set *set);
+void blk_mq_tagset_debugfs_unregister(struct blk_mq_tag_set *set);
+void blk_mq_tagset_debugfs_create_tags(struct blk_mq_tag_set *set);
+void blk_mq_tagset_debugfs_remove_tags(struct blk_mq_tag_set *set);
 #else
 static inline void blk_mq_debugfs_register(struct request_queue *q)
 {
@@ -77,6 +83,22 @@ static inline void blk_mq_debugfs_register_rq_qos(struct request_queue *q)
 {
 }
 
+static inline void blk_mq_tagset_debugfs_register(struct blk_mq_tag_set *set)
+{
+}
+
+static inline void blk_mq_tagset_debugfs_unregister(struct blk_mq_tag_set *set)
+{
+}
+
+static inline void blk_mq_tagset_debugfs_create_tags(struct blk_mq_tag_set *set)
+{
+}
+
+static inline void blk_mq_tagset_debugfs_remove_tags(struct blk_mq_tag_set *set)
+{
+}
+
 #endif
 
 #if defined(CONFIG_BLK_DEV_ZONED) && defined(CONFIG_BLK_DEBUG_FS)
diff --git a/block/blk-mq.c b/block/blk-mq.c
index a26a11c73ee3..e3e6d87f21a7 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -4914,6 +4914,10 @@ int blk_mq_alloc_tag_set(struct blk_mq_tag_set *set)
 
 	mutex_init(&set->tag_list_lock);
 	INIT_LIST_HEAD(&set->tag_list);
+#ifdef CONFIG_BLK_DEBUG_FS
+	set->debugfs_id = -1;
+#endif
+	blk_mq_tagset_debugfs_register(set);
 
 	return 0;
 
@@ -4956,6 +4960,8 @@ void blk_mq_free_tag_set(struct blk_mq_tag_set *set)
 {
 	int i, j;
 
+	blk_mq_tagset_debugfs_unregister(set);
+
 	for (i = 0; i < set->nr_hw_queues; i++)
 		__blk_mq_free_map_and_rqs(set, i);
 
@@ -5137,6 +5143,7 @@ static void __blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set,
 		blk_mq_debugfs_unregister_hctxs(q);
 		blk_mq_sysfs_unregister_hctxs(q);
 	}
+	blk_mq_tagset_debugfs_remove_tags(set);
 
 	/*
 	 * Switch IO scheduler to 'none', cleaning up the data associated
@@ -5194,6 +5201,7 @@ static void __blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set,
 		blk_mq_remove_hw_queues_cpuhp(q);
 		blk_mq_add_hw_queues_cpuhp(q);
 	}
+	blk_mq_tagset_debugfs_create_tags(set);
 
 out_free_ctx:
 	blk_mq_free_sched_ctx_batch(&elv_tbl);
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index af878597afb8..882ed11e7c2b 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -14,6 +14,7 @@
 struct blk_mq_tags;
 struct blk_flush_queue;
 struct io_comp_batch;
+struct dentry;
 
 #define BLKDEV_MIN_RQ	4
 #define BLKDEV_DEFAULT_RQ	128
@@ -530,6 +531,8 @@ enum hctx_type {
  * @update_nr_hwq_lock:
  * 		   Synchronize updating nr_hw_queues with add/del disk &
  * 		   switching elevator.
+ * @debugfs_dir:   Debugfs directory for this tag set.
+ * @debugfs_id:    ID used as part of the debugfs directory name.
  */
 struct blk_mq_tag_set {
 	const struct blk_mq_ops	*ops;
@@ -554,6 +557,11 @@ struct blk_mq_tag_set {
 	struct srcu_struct	tags_srcu;
 
 	struct rw_semaphore	update_nr_hwq_lock;
+
+#ifdef CONFIG_BLK_DEBUG_FS
+	struct dentry		*debugfs_dir;
+	int			debugfs_id;
+#endif
 };
 
 /**
-- 
2.43.0

