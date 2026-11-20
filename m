Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795143503;
	b=fSb8M04PQvJpCcB6WJTPi+qyVQapLgEcX+F2ByDxdIBF0lnHBn76PmkLtp5D30+BeQ3b
	 z/1RMoFXD+2cMSP0KYtkDsXyjkT0l3j167ctwtFvOIsBeKNoXPAoAODV/dne8hmlIHjbj
	 3UhAWhtgsJNwCXx4O3Ca8tuskwYonnFTzuHKPLRzhnCSPFOeIfPSw8dxvA9FjzhLlYMpJ
	 qkBG1sz+rvnXaFoL5L4wOo8hSlDP3ts3JT7JsGO2AIRSzGJDGZ117lK3fgdQ6mHY54EAl
	 yJgaKBamwfsU0288gQQzzinnGVMTPPeqEa3Dqp5cEhf0mcUgm2ilpySkcruDsbnnNAA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795143503;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=ICz+UT57AXzc5/Mxn7MnaYTdj8hCzARQ1LXqYuGcvpc=;
	b=qgHT4jWt4XgjtJ6b5ihXioz4U1MuFstiO2IyzzDlKC2sagrg9B2VjL6lyfZewWBI1FMQ
	 mASVxrDsY07Ce/8uqqZ7ZcnonN6+piJWhfmlcqE8hA3kmXlWYGTM2PvrStysHP1wXsuiQ
	 QibPj+X6I3AnhThggC4wwTJ+XgNMZrVNACD5SxWQ0iDl9X0BDnbuGriKuYJ2P+cRg/mVu
	 LHZ5cQgBtcpZko5oOnNYypTBYYaJbPW+8Nj3Ox/GaWXqQMfoyXzF+CGdLnLnwu5EX5F98
	 TTSytjyE4yog5LsPBVnVlcy1i3m5vprN/DFHMcX7GBQQl5Aj151kIrwa3Xv2XdOQ4og==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=smartx.com;
	spf=pass smtp.mailfrom=smartx.com;
	dkim=pass header.d=smartx-com.20260707.gappssmtp.com header.i=@smartx-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=jA4VJaGl;
	arc=none smtp.remote-ip=209.85.210.169
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7D9A606A337
	for <linux-block@vger.kernel.org>; Fri, 20 Nov 2026 02:58:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E7D9A606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=smartx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=smartx.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=smartx-com.20260707.gappssmtp.com header.i=@smartx-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=jA4VJaGl
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-8c5ebbc5150so386229b3a.3
        for <linux-block@vger.kernel.org>; Thu, 19 Nov 2026 18:58:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smartx-com.20260707.gappssmtp.com; s=20260707; t=1795143502; x=1795748302; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ICz+UT57AXzc5/Mxn7MnaYTdj8hCzARQ1LXqYuGcvpc=;
        b=jA4VJaGl9OKpnYWaw/fIRiikwuVGA0m9HXM3SUw0WLcuuNQFbY3uWDUjARK7Dcf2iL
         UeRAsiRYQSfRKrAgS8GzX3hqy2RRDxG6GI+oIPmgOt3bQfRmUzpAAIz3S0lFNYkKpqSo
         kQOTuf76Yq9hNuGRUi75YdMf61OhwOiObX1rGeFCrleV4QCn7PzySz30yg2X6XIFJ6vZ
         8/6v6lBDOdiDXGbIcPV/NF303aKFJkqvkOEGgpEEcYZAdkpGSXqDfXVXfCnXHRz48JEE
         8Fj7AEHirLvmpci2t3a3EZ+5jb7nam1KreEa4hq5O8AmUFQ6tTV06KPe2eCCl9z2z/eB
         BQXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795143502; x=1795748302;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ICz+UT57AXzc5/Mxn7MnaYTdj8hCzARQ1LXqYuGcvpc=;
        b=RkH++1ezkcB6kadudKR1QoYyWT6S5haCnYeK9tauxJzLKrjuh1nRmww5zps5zdPAyg
         wSAZrQcNi+4tKha5J6GQhQ8iA04Kkl2FkC13t8yt3/zaEepde+DCR7XChGXI3fzwSnve
         rZhHIPz7RfZH/SAJuZQc77JIq34Pg+APJlNFzjMovMqhbaarMptYGzkoXerk9D7XLrfG
         s1K9l+jO/PGoo857g+2H82F5g19n3d0Y2l0A4ku9Iz8eBn2sXYG1Nx+paFPMhsnJ01EQ
         BD91E2k4vihRc5LTjW+IzrAoseX0sCecmNhR65oR2+v0MD9+zsHNRU1QycyImVZpXPRe
         T4pQ==
X-Gm-Message-State: APuU4Z/KcvoCmni4UOxea02FWsCA1jON1ZqehTTgTDoFiRbK/iQcYf4j
	HYoyOWhO2bKE9kISHR5AfN/VjW8dX1wBelALaBtGg5LV9u94ISweTzBlBsz3Jt062lmMNlBvxws
	xgXjI1XzyA+Hy/VScmmAPpvwoJwum+f/dGsgJnXv1PDhrbQlOkLN5QVvMFA==
X-Gm-Gg: AYBFou20gRMIThdab+8GaH+GXjJqQWSizxZ7fiYKTeIodK6gc8CrNPAV/031TsHAawy
	nyUtJ9zAs2iyLv3Vys/VdZ3uLnzQ1FdfVdXQuq5WtHBxHeO6v7qB7x8ch0ANFqy3uP+FNx7lXlE
	2P5W8/n33SnlxHc8DaupCXGWxOR6oosOKJqdm+UmtwMxtT6lJjIztzm8i+fvIjXhAhE4sARIHhq
	5A9cGEqAfAaT9HtJp55+nASdb4Z/T5fzQ4OL6kfWtiI7dJ6uvpYmImftRQxQ056LdK/l8X/fmRC
	Ng0oVInZas2xl3kswl5VaJHDoNZecljrVYDJ1XYqYsZWQ/BRJe08eRoChAfuERuGmZRc8M63Wf/
	u4F23iUzkEGiU8SYIgcWQswYtjiP2jAvqKI5y/qo6Cx0rAMX9NYBSwL7A2iU2ks+zm6PVLka0s+
	WBcIL2Cn94A2hL/Fiv3CWgOawdkZsUrIpPkHxGR9ILCRbM09E6/HG/BGJy53pB+6CjRZqoEZNoI
	16dmCLRN5Qym1nlyHqKkZN2yn6+bwzc5crogt/5l3ohwW+9lknOZDNb+CEK8CnF9axG4e0EOub3
	cIfzF6iO9kw1Cve3puICITLsrG1PmVynfYe5cA==
X-Received: by 2002:a05:6a20:ef0b:b0:3f0:43:2bb6 with SMTP id adf61e73a8af0-4014a17aa5bmr1548774637.7.1795143502182;
        Thu, 19 Nov 2026 18:58:22 -0800 (PST)
Received: from localhost.localdomain ([103.26.8.217])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-8c872e45eccsm749647b3a.31.2026.11.19.18.58.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 18:58:21 -0800 (PST)
From: Lei Chen <lei.chen@smartx.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Lei Chen <lei.chen@smartx.com>
Subject: [RESEND PATCH v1 3/4] block: expose blk-mq tag sets through debugfs
Date: Fri, 20 Nov 2026 10:58:05 +0800
Message-ID: <20261120025806.1065295-4-lei.chen@smartx.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261120025806.1065295-1-lei.chen@smartx.com>
References: <20261009030111.57784-1-lei.chen@smartx.com>
 <20261120025806.1065295-1-lei.chen@smartx.com>
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

