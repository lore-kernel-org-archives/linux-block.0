Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43F47342515
	for <linux-block@vger.kernel.org>; Fri,  9 Oct 2026 03:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791514925; cv=none; b=Yb5qec7I9l/CsmoxmTkpdZVjSUnx2AVVrN/uh0iGv6JOx3CQtI6g3nhAmwSKYcKJOS0KkR3OvniRfXluZQ8PqJ8sTSU34LaqCKwVRvxC2nSZtnpCl50h5RRUHsl+0YaQOCmADiWnWA+xaytlRTrgd+jb8gAurIQdp1+rn5AIiw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791514925; c=relaxed/simple;
	bh=ZBovTmcQPE2pXd9GoUpVf/W749aaVvzxRwew8r4j30k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i00TCOLUTpDoXa0y937I7TJ69n5RzHd4GasqsMe6/zJd1AGtFlL5hR4xijt/hU/1enXW7KC45HvMq9/dDfm4AdO0NpoFtFzzalFpJR3kdfVzeXnp2XVnXoHb4dpAtlvKufsrdkfz688kzVT/jukt2YruWAn3Xr5JqkSDUhdeXG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=smartx.com; spf=none smtp.mailfrom=smartx.com; dkim=pass (2048-bit key) header.d=smartx-com.20251104.gappssmtp.com header.i=@smartx-com.20251104.gappssmtp.com header.b=ZjuupIMw; arc=none smtp.client-ip=74.125.82.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=smartx.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=smartx.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=smartx-com.20251104.gappssmtp.com header.i=@smartx-com.20251104.gappssmtp.com header.b="ZjuupIMw"
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-353804b591eso270529eec.0
        for <linux-block@vger.kernel.org>; Thu, 08 Oct 2026 20:02:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smartx-com.20251104.gappssmtp.com; s=20251104; t=1791514922; x=1792119722; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ICz+UT57AXzc5/Mxn7MnaYTdj8hCzARQ1LXqYuGcvpc=;
        b=ZjuupIMwAmGIni4pf/N8nSbSFVdVuH+L2SaD8H6xXjqdGIySj4ekGI8arrU1UID+m6
         yTKAu9ecMcdu0AnXmFxGs76Pn4+Z1rFDbuOPAeMGtztSGf88hRF2eaB7RunozF3l7Age
         +ZMBXcqfle3sMb4ETh7Amw+HpjYP5p6XnMRUUMErKy3RRG/69m7oNTpNGSXHqWW73odR
         rYC+jBMZUDcx89GvJZSRBuAAyK8IhkdQrZoPSeYgcB3DYQm+KvTJOquTErzAKkVD4OBp
         bN6UUv7Q4SoFWeT/6ZeNBirlTyHoypSj6q3N4gNDjHisfl3+KgkIkch68H+wTKZ5lFFj
         xFOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791514922; x=1792119722;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ICz+UT57AXzc5/Mxn7MnaYTdj8hCzARQ1LXqYuGcvpc=;
        b=gC7ye1NLTmEgBkz+f3e1g2eSX+0/AI1Zw9WgY0yRLALu1ivwivY6VDLSsDvQIxWHB0
         aAn4PeDThIDgAFIvTEX1u9Nudc4leXGDzOKpN7u84ujzsyWw63J7Eqrfflkl7SlIvIHx
         AKzjw0iu4XGQlclot2ayhC2fwTKkCvUu2rOJ30sOsnwJUBY/Ciwyb+8n0uhR+vG//1oq
         7Z226r9Zj0NNnQZghTEz7l+EB1mbolAhhWmmLaISR0Y5bpPKqrnkeDL2l/yrmC16677L
         CX8s/swKdVpfboVcD00DurohyZfGEYkBZMrGtWDCseth+/Dr9DDG3AhYKCw2CBBtKCFU
         aIAg==
X-Gm-Message-State: AFq9FYJ81frlJhV6JnLdS5k9lEVPuqugCPB8kxfpfzSi8eRn2jNJ3yDX
	X4ARVyEoIe8DVLQ4edZd7g1y14+RPT4JIsURt4TDlEbavy9d9aOyYZGxHSDxvMkmrziRjdmnfBs
	KKrSUqGlJTC760py+ovGrIJPEiR/loAREav5i+QH9+mtQL0Mv/pMKL61ZYg==
X-Gm-Gg: AYBFou0u3dPI1lXzJJBT0qg0XCL+pJg4l+kaZqMszxgKZ1i8hbnVcLAeAnHaXdeflcy
	UpyCk0moKz1mxKYdZ19xDQj9dOdYfiJX0VqIytyIZ0J9MPIXrn2pTt7+uX0D2qGSJ0dm0eBQC8A
	arztTiGfVjkpBESEdSPqcS4QmkcKsfpdEDdpbMi2k4DYhsD0iVeaZ84ElsU8VDL0/9tP2HN1ldz
	Mnbs/H2Ys5OgTZsMd+zId1pWAdzdPImMXTICqviUpn9rugaEXU0bK4Id/IoXBE9RpMKvkPxi2Rg
	FTC8H/jQLe3UxTuWXjs61GBjQvmvOG1r0RpDy/eaV7I2q66L3tGdzA3mSjwW8mkDcBoRMuD7btV
	BAXFC1YZbNTEXrV5eOkW91VeKIM3XunFP4lXu/mYKoob4cG+JcebMua22dbrJBP0Mv/dhAIhSjH
	Adz7+ewHtlLLpYs+imKnSIviioNJQ+Cfyn5bsO7t2XOZFcCdddhmCdFCnL+EH7ExIBatesnoCx/
	4mtJS6sXA==
X-Received: by 2002:a05:7301:da09:b0:34b:f279:2c16 with SMTP id 5a478bee46e88-3537dedd4d0mr1151723eec.5.1791514921910;
        Thu, 08 Oct 2026 20:02:01 -0700 (PDT)
Received: from localhost.localdomain ([23.148.204.128])
        by smtp.googlemail.com with ESMTPSA id 5a478bee46e88-3537cb1e02asm2427626eec.27.2026.10.08.20.01.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2026 20:02:01 -0700 (PDT)
From: Lei Chen <lei.chen@smartx.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Lei Chen <lei.chen@smartx.com>
Subject: [PATCH v1 3/4] block: expose blk-mq tag sets through debugfs
Date: Fri,  9 Oct 2026 11:01:10 +0800
Message-ID: <20261009030111.57784-4-lei.chen@smartx.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261009030111.57784-1-lei.chen@smartx.com>
References: <20261009030111.57784-1-lei.chen@smartx.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Block debugfs exposes request queues and hardware contexts, but lacks a
view of the tag set they share. Add a tagset/<id> directory under the
debugfs root to expose tag set configuration, flags, CPU-to-hardware-queue
mappings and tag counts. Represent hardware queues using shared tags with
symlinks to the shared_tags file.

Tie the directory lifetime to tag set allocation and teardown, and rebuild
the tags directory when the hardware queue count changes. Remove tag files
before freeing the objects they reference.

Hardware queue updates may run with queues frozen, so removing tag files
must not wait for a reader that needs I/O to those queues. Use a custom
read operation with debugfs_create_file_unsafe() to hold a debugfs active
reference only while copying tag fields into local variables. Drop the
reference before formatting the output and copying it to userspace, where
a page fault may require I/O. The removal-before-free ordering protects
the tag objects during this brief access; reads after removal fail before
dereferencing them.

Serialize other tag set attribute reads with hardware queue updates using
update_nr_hwq_lock. Use a NOIO allocation scope during debugfs registration
to prevent memory reclaim from issuing I/O to frozen queues.

Signed-off-by: Lei Chen <lei.chen@smartx.com>
---
 block/blk-mq-debugfs.c | 290 +++++++++++++++++++++++++++++++++++++++++
 block/blk-mq-debugfs.h |  22 ++++
 block/blk-mq.c         |   8 ++
 include/linux/blk-mq.h |   8 ++
 4 files changed, 328 insertions(+)

diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
index 6754d8f9449c..298387607049 100644
--- a/block/blk-mq-debugfs.c
+++ b/block/blk-mq-debugfs.c
@@ -7,6 +7,7 @@
 #include <linux/blkdev.h>
 #include <linux/build_bug.h>
 #include <linux/debugfs.h>
+#include <linux/idr.h>
 
 #include "blk.h"
 #include "blk-mq.h"
@@ -827,3 +828,292 @@ void blk_mq_debugfs_unregister_sched_hctx(struct blk_mq_hw_ctx *hctx)
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
+#define BLK_MQ_F_NAME(name) \
+	[ilog2(BLK_MQ_F_##name)] = #name
+static const char *const tagset_flag_name[] = {
+	BLK_MQ_F_NAME(TAG_QUEUE_SHARED),
+	BLK_MQ_F_NAME(STACKING),
+	BLK_MQ_F_NAME(TAG_HCTX_SHARED),
+	BLK_MQ_F_NAME(BLOCKING),
+	BLK_MQ_F_NAME(TAG_RR),
+	BLK_MQ_F_NAME(NO_SCHED_BY_DEFAULT),
+};
+
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
+#define BLK_MQ_TAGSET_VALUE_SHOW(_name, _type, _value, _format) \
+static int blk_mq_tagset_##_name##_show(struct seq_file *m, void *v) \
+{ \
+	struct blk_mq_tag_set *set = m->private; \
+	_type value; \
+\
+	down_read(&set->update_nr_hwq_lock); \
+	value = (_value); \
+	up_read(&set->update_nr_hwq_lock); \
+\
+	seq_printf(m, _format, value); \
+	return 0; \
+} \
+DEFINE_SHOW_ATTRIBUTE(blk_mq_tagset_##_name)
+
+BLK_MQ_TAGSET_VALUE_SHOW(nr_maps, unsigned int, set->nr_maps, "%u\n");
+BLK_MQ_TAGSET_VALUE_SHOW(nr_hw_queues, unsigned int, set->nr_hw_queues, "%u\n");
+BLK_MQ_TAGSET_VALUE_SHOW(queue_depth, unsigned int, set->queue_depth, "%u\n");
+BLK_MQ_TAGSET_VALUE_SHOW(reserved_tags, unsigned int, set->reserved_tags, "%u\n");
+BLK_MQ_TAGSET_VALUE_SHOW(cmd_size, unsigned int, set->cmd_size, "%u\n");
+BLK_MQ_TAGSET_VALUE_SHOW(numa_node, int, set->numa_node, "%d\n");
+BLK_MQ_TAGSET_VALUE_SHOW(timeout, unsigned int, set->timeout, "%u\n");
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
+						    index, &blk_mq_tagset_map_fops);
+		}
+	}
+}
+
+static ssize_t blk_mq_tagset_tags_read(struct file *file, char __user *user_buf,
+				       size_t count, loff_t *ppos)
+{
+	struct dentry *dentry = file->f_path.dentry;
+	unsigned int nr_tags, nr_reserved_tags, active_queues;
+	struct blk_mq_tags *tags;
+	char buf[128];
+	int ret, len;
+
+	/*
+	 * Tag updates remove these files before freeing the tags. Shared tags
+	 * remain valid until tag set teardown removes the shared_tags file.
+	 */
+	ret = debugfs_file_get(dentry);
+	if (ret)
+		return ret;
+
+	tags = file->private_data;
+	if (!tags) {
+		debugfs_file_put(dentry);
+		return -ENODEV;
+	}
+
+	nr_tags = tags->nr_tags;
+	nr_reserved_tags = tags->nr_reserved_tags;
+	active_queues = READ_ONCE(tags->active_queues);
+	debugfs_file_put(dentry);
+
+	/*
+	 * A fault on the user buffer may need I/O to a frozen queue. Drop the
+	 * active reference first so file removal does not wait for that I/O.
+	 */
+	len = scnprintf(buf, sizeof(buf),
+			".nr_tags=%u\n.nr_reserved_tags=%u\n.active_queues=%u\n",
+			nr_tags, nr_reserved_tags, active_queues);
+	return simple_read_from_buffer(user_buf, count, ppos, buf, len);
+}
+
+static const struct file_operations blk_mq_tagset_tags_fops = {
+	.owner		= THIS_MODULE,
+	.open		= simple_open,
+	.read		= blk_mq_tagset_tags_read,
+	.llseek		= default_llseek,
+};
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
+			debugfs_create_file_unsafe(name, 0444, dir, tags,
+						   &blk_mq_tagset_tags_fops);
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
+	blk_mq_tagset_debugfs_create_maps(set);
+	debugfs_create_file_unsafe("shared_tags", 0444, set->debugfs_dir,
+				   set->shared_tags, &blk_mq_tagset_tags_fops);
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
+	if (IS_ERR_OR_NULL(blk_mq_tagset_debugfs_root))
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
+	debugfs_remove_recursive(set->debugfs_dir);
+	set->debugfs_dir = NULL;
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
index 12e28d779e2c..f32d2df044dc 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -4978,6 +4978,10 @@ int blk_mq_alloc_tag_set(struct blk_mq_tag_set *set)
 
 	mutex_init(&set->tag_list_lock);
 	INIT_LIST_HEAD(&set->tag_list);
+#ifdef CONFIG_BLK_DEBUG_FS
+	set->debugfs_id = -1;
+#endif
+	blk_mq_tagset_debugfs_register(set);
 
 	return 0;
 
@@ -5023,6 +5027,8 @@ void blk_mq_free_tag_set(struct blk_mq_tag_set *set)
 {
 	int i, j;
 
+	blk_mq_tagset_debugfs_unregister(set);
+
 	for (i = 0; i < set->nr_hw_queues; i++)
 		__blk_mq_free_map_and_rqs(set, i);
 
@@ -5207,6 +5213,7 @@ static void __blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set,
 		blk_mq_debugfs_unregister_hctxs(q);
 		blk_mq_sysfs_unregister_hctxs(q);
 	}
+	blk_mq_tagset_debugfs_remove_tags(set);
 
 	/*
 	 * Switch IO scheduler to 'none', cleaning up the data associated
@@ -5267,6 +5274,7 @@ static void __blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set,
 		blk_mq_remove_hw_queues_cpuhp(q);
 		blk_mq_add_hw_queues_cpuhp(q);
 	}
+	blk_mq_tagset_debugfs_create_tags(set);
 
 out_free_ctx:
 	blk_mq_free_sched_ctx_batch(&elv_tbl);
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index 3ef989dc4f99..a80bc63a6e71 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -14,6 +14,7 @@
 struct blk_mq_tags;
 struct blk_flush_queue;
 struct io_comp_batch;
+struct dentry;
 
 #define BLKDEV_MIN_RQ	4
 #define BLKDEV_DEFAULT_RQ	128
@@ -534,6 +535,8 @@ enum hctx_type {
  * @update_nr_hwq_lock:
  * 		   Synchronize updating nr_hw_queues with add/del disk &
  * 		   switching elevator.
+ * @debugfs_dir:   Debugfs directory for this tag set.
+ * @debugfs_id:    ID used as part of the debugfs directory name.
  */
 struct blk_mq_tag_set {
 	const struct blk_mq_ops	*ops;
@@ -559,6 +562,11 @@ struct blk_mq_tag_set {
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

