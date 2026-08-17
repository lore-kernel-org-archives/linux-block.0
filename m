Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05CF2472795
	for <linux-block@vger.kernel.org>; Mon, 17 Aug 2026 21:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787002944; cv=none; b=XbrB/99pVCR51D/LyBgzpithmQGGAYVLY2CLs0JlfYqxU/JB13n0ASCxe/KEH+XHElD7K20znZ30GjpVZp2bKCkya4dxaiTtcEOLLqr66yLeroxAdZ5ofIFP19UMnz345VWW56f3E8pt/PHImseuH17RT+WkATkdewEWZAqsua0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787002944; c=relaxed/simple;
	bh=0z8PWGduURq5jdmaL9vW7E71Pmvd9PeAhi1Jwg4AAbc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FQ+qdGw2cH2ua6ZmvuWy2pEE+tdxADhIw7UPaxWAAQ4+88dQ3jihiDLAoLVVerG0C6or0Io4G28D3XJb9ExuWs4r5Y+ArqHQT+RKEro3g8en+VbeP0YwdQuPSHAlUj0KzFLoPng2rC34R8DH914F793nCDSbdnOHl3U6vtx6E6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aDvHJwq6; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aDvHJwq6"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2ced3386430so38929715ad.1
        for <linux-block@vger.kernel.org>; Mon, 17 Aug 2026 14:42:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787002942; x=1787607742; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0OAypTyGdu6BgXD9Bv7vBEYzg6snlB0upRlQ0JuzemU=;
        b=aDvHJwq6i2tIzrgcGv3KFgI63iLRqPNOGoImgz9BSed+93i79zMgB1VS6ai8Tu4bFM
         wBqWZxX4eB+pxJLBomOQe84DLzewCWWE/UJcTPpW7YybyEgQt7XSrguAFm41fdEbeVpc
         1zVNVqPyzZsdtsh6x8z7NqPMGsGpej6q+AF2j5pEz82uKIVVhenN5npntDflLLuXTv9O
         b559TnxIjIlYTyOv8b3pYHCdhIrb5qVkMmAa2139dNsS52zf8QmM1SXhZScHKvuTHxLO
         nVM//LV1htAEZ+vpsHWzhkm4KCTVLFxSk042Dv+ZGA3rN/NefmAniF1oy5WvYOyb0/hJ
         J05Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787002942; x=1787607742;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=0OAypTyGdu6BgXD9Bv7vBEYzg6snlB0upRlQ0JuzemU=;
        b=N5/RcXd5XnQ2IaxKs39OZadpqhuD+YihsrsHIwFAhF17sQ/I5Pg/QOD0L/5hH3oyZI
         a6yaf7Y0D2U0IY9NUgcq7+jeyyYeV3dDrMKCWAkqM9fZw8Kic4I+icmAJwDTS/wRJfk/
         xVsVEiIgknNLeIw4jEp4k+ldYLNRu8KEU0uPJlFA7xrkHyQrq0RBUIhezNqHDZDdH4eP
         m7wPQn0t5mtUz7r1tOPQ/xJgOElgNC4yS4wqIYjlCBOQgU/zebbG93dmRRJlP/yzlwfi
         nY5wIXUEJ0nnmRdjO8mWtgeuSc0EwZU4/UF/ln9m9gJ9acvqwF0ubUVYofBwpiDKNRqg
         TF3A==
X-Forwarded-Encrypted: i=1; AHgh+RoHJjmb9g6LOSbhQRxkfUAVAc6qhbCCa3uuyIbGSLmn43q9OAaIZeDrHG27SF1d8Af7YRSrk2P6QIVlkA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxEi1sc7XiGW4oj5cTUYdHl+jnHomvCKXT195M5tTvC1immzP5g
	yXMn37ZTkfetwmF5O9eJRBJNmnPzI23KU3zNK0a5Imie6CFMXpc6TD2I
X-Gm-Gg: AR+sD10JEcltSAY2F/QGoy8jcdo0TNsp4mkOEFQPEvzaM/kc3H3u4vyAaLjHB1N21+4
	3qxHWrnFU/8NORTYBkEQCpzvu9Sey55rjhgwLWwy5DwT2+wGl7BUuUAB7czeGp3hInvqTdtgBiF
	GTp/+3Cu3eS0hoe0aLarrOazTvZvLXCNyArd5gCaFmXvl9UjQfCSpVFRsx8+XdlJUPV53YxereU
	X1Bg6ehas8LbiEX1kzOEAE8fe+jQ0x/2JHQvsoLah1HInIAQJmxbc2a3jf808UD1okA8ID76bdM
	hGFNyHx0w5EK04FyOGYICo6TQ1Hg6fp0trn9lUAoD23bmlYW05aG+j7DTVxj39X5/0BljKVwW71
	N/AFhgpvkMKJXIdq+8Xmb/h/40PxHK//n4+HBIwGOvlHUaKFdmnqiEzcWX/oZzuuR1lVBaSQNsj
	Ob7WU31zsO90/AFvNpmbo77tZxJie0YGxFMqTLqIC+SyJ40uJWeHQPrj0=
X-Received: by 2002:a17:902:f605:b0:2ca:4f33:e86f with SMTP id d9443c01a7336-2d3b0c5e569mr339655925ad.12.1787002942282;
        Mon, 17 Aug 2026 14:42:22 -0700 (PDT)
Received: from localhost ([2a03:2880:9ff:42::])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3267c897e37sm10556279eec.28.2026.08.17.14.42.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2026 14:42:21 -0700 (PDT)
From: Ziyang Men <ziyang.meme@gmail.com>
To: kernel-team@meta.com,
	Jens Axboe <axboe@kernel.dk>,
	Tejun Heo <tj@kernel.org>,
	Josef Bacik <josef@toxicpanda.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Shuah Khan <shuah@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	JP Kobryn <inwardvessel@gmail.com>,
	Mykola Lysenko <mykolal@meta.com>,
	Ziyang Men <ziyang.meme@gmail.com>,
	linux-block@vger.kernel.org,
	bpf@vger.kernel.org,
	cgroups@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] block: add BPF kfuncs to read blkcg io.stat
Date: Mon, 17 Aug 2026 14:42:04 -0700
Message-ID: <20260817214205.723267-2-ziyang.meme@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260817214205.723267-1-ziyang.meme@gmail.com>
References: <20260817214205.723267-1-ziyang.meme@gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Collecting cgroup statistics is expensive: the existing method is to
open and parse a cgroup file for every cgroup of interest. memcg already
has an efficient alternative through BPF; this series extends that idea
to block.  This series exposes the block I/O controller's per-device
io.stat to BPF.

The flush is sleepable and takes a cgroup. It pins the I/O css before
leaving RCU, then flushes it.  The iterator takes the RCU-protected css
and remains block-specific because each block device has its own blkg.
The behavior mirrows the blkcg_print_stat().

The blkg device iterator take a RCU css.

No kfuncs are added to read the blkcg counters since user can read it
using the BPF_CORE_READ.

Suggested-by: Shakeel Butt <shakeel.butt@linux.dev>
Assisted-by: Claude:claude-opus-5
Signed-off-by: Ziyang Men <ziyang.meme@gmail.com>
---
 MAINTAINERS        |   1 +
 block/Makefile     |   3 +
 block/blk-cgroup.c |   2 +-
 block/blk-cgroup.h |   1 +
 block/bpf_blkcg.c  | 154 +++++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 160 insertions(+), 1 deletion(-)
 create mode 100644 block/bpf_blkcg.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 2f9472c1a090..87c56e955577 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6617,6 +6617,7 @@ F:	block/blk-cgroup.c
 F:	block/blk-iocost.c
 F:	block/blk-iolatency.c
 F:	block/blk-throttle.c
+F:	block/bpf_blkcg.c
 F:	include/linux/blk-cgroup.h
 
 CONTROL GROUP - CPUSET
diff --git a/block/Makefile b/block/Makefile
index e7bd320e3d69..572e49988c8e 100644
--- a/block/Makefile
+++ b/block/Makefile
@@ -17,6 +17,9 @@ obj-$(CONFIG_BLK_ERROR_INJECTION) += error-injection.o
 obj-$(CONFIG_BLK_DEV_BSG_COMMON) += bsg.o
 obj-$(CONFIG_BLK_DEV_BSGLIB)	+= bsg-lib.o
 obj-$(CONFIG_BLK_CGROUP)	+= blk-cgroup.o
+ifdef CONFIG_BPF_SYSCALL
+obj-$(CONFIG_BLK_CGROUP)	+= bpf_blkcg.o
+endif
 obj-$(CONFIG_BLK_CGROUP_RWSTAT)	+= blk-cgroup-rwstat.o
 obj-$(CONFIG_BLK_CGROUP_FC_APPID) += blk-cgroup-fc-appid.o
 obj-$(CONFIG_BLK_DEV_THROTTLING)	+= blk-throttle.o
diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index d9676126c5b5..8d538ad4e861 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -1086,7 +1086,7 @@ static void blkcg_rstat_flush(struct cgroup_subsys_state *css, int cpu)
  * flushing the root cgroup's stats by explicitly filling in the iostat
  * with disk level statistics.
  */
-static void blkcg_fill_root_iostats(void)
+void blkcg_fill_root_iostats(void)
 {
 	struct class_dev_iter iter;
 	struct device *dev;
diff --git a/block/blk-cgroup.h b/block/blk-cgroup.h
index 615390f751aa..8c9c2a1adfaa 100644
--- a/block/blk-cgroup.h
+++ b/block/blk-cgroup.h
@@ -205,6 +205,7 @@ void blkcg_deactivate_policy(struct gendisk *disk,
 			     const struct blkcg_policy *pol);
 
 const char *blkg_dev_name(struct blkcg_gq *blkg);
+void blkcg_fill_root_iostats(void);
 void blkcg_print_blkgs(struct seq_file *sf, struct blkcg *blkcg,
 		       u64 (*prfill)(struct seq_file *,
 				     struct blkg_policy_data *, int),
diff --git a/block/bpf_blkcg.c b/block/bpf_blkcg.c
new file mode 100644
index 000000000000..25c809f5091c
--- /dev/null
+++ b/block/bpf_blkcg.c
@@ -0,0 +1,154 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Block I/O Controller-related BPF kfuncs and auxiliary code
+ */
+
+#include "blk-cgroup.h"
+
+#include <linux/bpf.h>
+#include <linux/btf_ids.h>
+#include <linux/rculist.h>
+
+__bpf_kfunc_start_defs();
+
+/**
+ * bpf_blkcg_flush_stats - Flush a block cgroup's io statistics
+ * @cgrp: cgroup to flush
+ *
+ * Propagate I/O statistics up the cgroup tree. Root statistics come from
+ * block devices and include all cgroups' I/O.
+ */
+__bpf_kfunc void bpf_blkcg_flush_stats(struct cgroup *cgrp)
+{
+	struct cgroup_subsys_state *css;
+
+	/* Pin the css for the sleepable flush. */
+	rcu_read_lock();
+	css = cgroup_css(cgrp, &io_cgrp_subsys);
+	if (css && !css_tryget(css))
+		css = NULL;
+	rcu_read_unlock();
+
+	if (!css)
+		return;
+
+	if (!css->parent)
+		blkcg_fill_root_iostats();
+	else
+		css_rstat_flush(css);
+
+	css_put(css);
+}
+
+struct bpf_iter_blkg {
+	__u64 __opaque[2];
+} __aligned(8);
+
+struct bpf_iter_blkg_kern {
+	struct blkcg *blkcg;
+	struct blkcg_gq *pos;
+} __aligned(8);
+
+/**
+ * bpf_iter_blkg_new - Start iterating a block cgroup's per-device blkgs
+ * @it: iterator to initialize
+ * @css: the io controller's css
+ *
+ * Each blkg holds one device's io.stat counters. Offline blkgs are skipped.
+ * A blkg without a disk can be returned. Must run under RCU.
+ *
+ * Return: 0 on success, -EINVAL if @css is not the io controller's.
+ */
+__bpf_kfunc int bpf_iter_blkg_new(struct bpf_iter_blkg *it,
+				  struct cgroup_subsys_state *css)
+{
+	struct bpf_iter_blkg_kern *kit = (void *)it;
+
+	BUILD_BUG_ON(sizeof(struct bpf_iter_blkg_kern) > sizeof(struct bpf_iter_blkg));
+	BUILD_BUG_ON(__alignof__(struct bpf_iter_blkg_kern) !=
+		     __alignof__(struct bpf_iter_blkg));
+
+	kit->pos = NULL;
+
+	if (css->ss != &io_cgrp_subsys) {
+		kit->blkcg = NULL;
+		return -EINVAL;
+	}
+
+	kit->blkcg = css_to_blkcg(css);
+	return 0;
+}
+
+/**
+ * bpf_iter_blkg_next - Return the next online blkg of the iterated block cgroup
+ * @it: iterator
+ *
+ * Return: the next online blkg, or NULL when the walk is done.
+ */
+__bpf_kfunc struct blkcg_gq *bpf_iter_blkg_next(struct bpf_iter_blkg *it)
+{
+	struct bpf_iter_blkg_kern *kit = (void *)it;
+	struct blkcg_gq *blkg = kit->pos;
+	struct hlist_node *node;
+
+	if (!kit->blkcg)
+		return NULL;
+
+	if (!blkg)
+		node = rcu_dereference(hlist_first_rcu(&kit->blkcg->blkg_list));
+	else
+		node = rcu_dereference(hlist_next_rcu(&blkg->blkcg_node));
+
+	/* Skip offline blkgs, matching io.stat. */
+	while (node) {
+		blkg = hlist_entry(node, struct blkcg_gq, blkcg_node);
+		/* A race only changes whether this blkg is returned. */
+		if (data_race(blkg->online)) {
+			kit->pos = blkg;
+			return blkg;
+		}
+		node = rcu_dereference(hlist_next_rcu(&blkg->blkcg_node));
+	}
+
+	/* The iterator must keep returning NULL after completion. */
+	kit->pos = NULL;
+	kit->blkcg = NULL;
+	return NULL;
+}
+
+/**
+ * bpf_iter_blkg_destroy - Tear down a blkg iterator
+ * @it: iterator
+ */
+__bpf_kfunc void bpf_iter_blkg_destroy(struct bpf_iter_blkg *it)
+{
+}
+
+__bpf_kfunc_end_defs();
+
+BTF_KFUNCS_START(bpf_blkcg_kfuncs)
+BTF_ID_FLAGS(func, bpf_blkcg_flush_stats, KF_SLEEPABLE)
+
+BTF_ID_FLAGS(func, bpf_iter_blkg_new,
+	     KF_ITER_NEW | KF_RCU | KF_RCU_PROTECTED)
+BTF_ID_FLAGS(func, bpf_iter_blkg_next, KF_ITER_NEXT | KF_RET_NULL)
+BTF_ID_FLAGS(func, bpf_iter_blkg_destroy, KF_ITER_DESTROY)
+BTF_KFUNCS_END(bpf_blkcg_kfuncs)
+
+static const struct btf_kfunc_id_set bpf_blkcg_kfunc_set = {
+	.owner		= THIS_MODULE,
+	.set		= &bpf_blkcg_kfuncs,
+};
+
+static int __init bpf_blkcg_init(void)
+{
+	int err;
+
+	err = register_btf_kfunc_id_set(BPF_PROG_TYPE_UNSPEC,
+					&bpf_blkcg_kfunc_set);
+	if (err)
+		pr_warn("error while registering bpf blkcg kfuncs: %d\n", err);
+
+	return err;
+}
+late_initcall(bpf_blkcg_init);
-- 
2.53.0-Meta

