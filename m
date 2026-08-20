Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD10548422B
	for <linux-block@vger.kernel.org>; Thu, 20 Aug 2026 21:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787260697; cv=none; b=gsMBEeY4bJwe+icwOdcdeUbwrrkZgoBDihnBgkVZhYvT0IDtFnn7B0vurLsX+9gD8liaj9e3cEbZxa3V1e2vS7OhvfkAi4KT6gbGKpQMs3OqwsbVMqPY1ltOicg6f0UfCUSGTFPX/rKt0/ehDxnEodXCIsbaYH4/0bBbgCgB1l4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787260697; c=relaxed/simple;
	bh=TDKffd9Fkjz0NiAHzS4kTGbp08DKmog+dRzwJOqZg8Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Sxd65ryQBauSzhx7L7MayArfs7UzcGWFkJHrUG3t8S/c6Q7E2d+zG9Pcj9WtURVyGtRNg4BKZyFOj+KvHC+5hOF/fXxiMQ3+t2dGQ0wmcjLxGU593kbLzwVWz8jPGx7stcdOYxwCfLsWvpKG6MP+IbINcQpZMDPpD4Suav3fkuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EDxkV+Yi; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EDxkV+Yi"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2cf50c6f235so4461875ad.0
        for <linux-block@vger.kernel.org>; Thu, 20 Aug 2026 14:18:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787260686; x=1787865486; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=usT9UbJbbjXSkfskstVIX1ccjxiE/NzHiKaVTFkNt1M=;
        b=EDxkV+YiM+3P8ZsBGZDQBhg34IhQD3pdLX01CwkZRuHWiqwV6uUhmTaR5c074TqfF/
         wh2eypQ4eZHNMUbJWR6QIESpaU0ftq+n7JwoVVPjMWLFNjFE9jQj05qmLMm21K48PjmC
         LRD8R1LFRLSQ6ddKD0fbuh9Otx4U4mgF89PX92i6A8HtHZgBqnYxRV2k5GynMDJ8OrVL
         u4astMIfbANf0oNNWuod6lk/iBwsGKirSxQCEHBNEf9jOBWk57ncuGk9iSHdQIJRbauD
         iut0DDwSuayt6koBJQFZkeiGSW96wXBQ9BTdo65+MKPMo4IJ26MBfyIKC1eedNS7EMxU
         sfiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787260686; x=1787865486;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=usT9UbJbbjXSkfskstVIX1ccjxiE/NzHiKaVTFkNt1M=;
        b=M2dcwf4811QOYnC8J5HjZZZC3iTY/9clziGAPisMzSPdwTCoIkdv1lcFSFr8eQNw66
         9UckkpxUIbyl43ucHQ/QtiS7dnvrxB/nr0DL2ZIsGQUOXRK/0JbJ4kq0fU2Gu+blr4D1
         z9QkkLvn+SrX/tFzfRl4keQlDHYfDiRj78j6ka9NlzCr+qTnq2zxyBKyASYJgoNtpOkC
         XYAK5LmUpj8GClLkP389gZXrG/BvyA7BGHuBPsuBW4KfQNKtfckcLdjxkDbHfRjd6qNy
         CrdemFFMliO4sP9z1WGFSDSimuwbRz5EotIoTFjj4M2yVSgEEhTp7OWEbY8SE12e1Oaq
         63cQ==
X-Forwarded-Encrypted: i=1; AHgh+Rok8THlN4E3iNLeXvT8p2wiW6h/Q/NPntKxUFKT6wC61IxCsjmicUI3MMLgabWu2sS/Lk4fwBGtdBj4WA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwoqWqQ2hfSAB2gxB7gl1YFtj4j/gK41a2qQMeJ0GSg3s4Z+0Ep
	p9D5qv/SStSWkLfpQ2hpWPL7eDN7/iHtiqj3Q4WwdVKwo5PvjLJaQY46
X-Gm-Gg: AR+sD13XwPzPzr/XptZJ88k4/P9o73iCS93fOSyswXV9hM8Qv0pZJfgEQXBejKnG5DN
	j0WX+UqCa+dUUgxTMg0Oqvg9O8t3dPtB/nLoroc9ESLPN/lZWWB/MtlnzQBTNjQYtXpGnzfzuWU
	faeeIoqNYmgavLTNihQl/OLxn2jlGiOfcd19SoA9fOqSI8fZroGSO8VOmDXr/IjVJGc6u31JP7u
	bRB+3lBSzFJajwErGdoI4F2JyyerR0R4/kgEKiCbHDAxGxV/EGGNYxjggTEXBVNCXNkzfhYE2XN
	bg6RJWT80XPllXshkL3K0/Ryn3g2XGTvS9/ILyzKlB/Kky7/WeWfKEcA8m9jvL+OiDwz65qaEJc
	lq7B+SdXKOFatJwKzRE124lWLcgojXrmOSLZU1MK4VTyYE2qHJVbfhhxC1HnI9/xJeaHpn/IHam
	8v1e2uVGBnezDJL5Fvemsnpk+9xSfHsPGcfQKHaDNUgr/S19EZ4okNo34=
X-Received: by 2002:a17:903:b07:b0:2d0:cc92:f7a3 with SMTP id d9443c01a7336-2d64ada8eb8mr29906555ad.2.1787260686112;
        Thu, 20 Aug 2026 14:18:06 -0700 (PDT)
Received: from localhost ([2a03:2880:9ff:66::])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-327d01ff056sm11599824eec.19.2026.08.20.14.18.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2026 14:18:05 -0700 (PDT)
From: Ziyang Men <ziyang.meme@gmail.com>
To: kernel-team@meta.com,
	Jens Axboe <axboe@kernel.dk>,
	Tejun Heo <tj@kernel.org>,
	Josef Bacik <josef@toxicpanda.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Shuah Khan <shuah@kernel.org>
Cc: Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Ben Segall <bsegall@google.com>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
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
Subject: [PATCH v3 3/4] block: add BPF kfuncs to read blkcg io.stat
Date: Thu, 20 Aug 2026 14:17:57 -0700
Message-ID: <20260820211758.3393984-4-ziyang.meme@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260820211758.3393984-1-ziyang.meme@gmail.com>
References: <20260820211758.3393984-1-ziyang.meme@gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Collecting cgroup statistics is expensive because the existing method
opens and parses a cgroup file for every cgroup. memcg already provides
an efficient BPF interface; extend that model to the block controller.

Add bpf_cgroup_css() and bpf_css_release() to acquire a controller's
css from a cgroup. The reference keeps the css alive across the
sleepable css_rstat_flush().

Add bpf_css_to_blkcg() as a checked RCU-protected css-to-blkcg
conversion and an open-coded iterator for the per-device blkgs.

Suggested-by: Shakeel Butt <shakeel.butt@linux.dev>
Suggested-by: Tejun Heo <tj@kernel.org>
Assisted-by: Claude:claude-opus-5
Signed-off-by: Ziyang Men <ziyang.meme@gmail.com>
---
 MAINTAINERS                |   1 +
 block/Makefile             |   3 +
 block/bpf_blkcg.c          | 138 +++++++++++++++++++++++++++++++++++++
 kernel/cgroup/bpf_cgroup.c |  62 ++++++++++++++---
 4 files changed, 194 insertions(+), 10 deletions(-)
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
diff --git a/block/bpf_blkcg.c b/block/bpf_blkcg.c
new file mode 100644
index 000000000000..d8ab8006bc57
--- /dev/null
+++ b/block/bpf_blkcg.c
@@ -0,0 +1,138 @@
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
+ * bpf_css_to_blkcg - Cast an io controller css to its block cgroup
+ * @css: io controller css
+ *
+ * Must be called under RCU.
+ *
+ * Return: The block cgroup, or NULL if @css belongs to another controller.
+ */
+__bpf_kfunc struct blkcg *
+bpf_css_to_blkcg(struct cgroup_subsys_state *css)
+{
+	if (unlikely(css->ss != &io_cgrp_subsys))
+		return NULL;
+
+	return css_to_blkcg(css);
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
+ * @blkcg: block cgroup to iterate
+ *
+ * Each blkg holds one device's io.stat counters. Offline blkgs are skipped.
+ * A blkg without a disk can be returned. Root blkgs do not contain the
+ * system-wide statistics shown by root io.stat. Must run under RCU.
+ *
+ * Return: 0 on success.
+ */
+__bpf_kfunc int bpf_iter_blkg_new(struct bpf_iter_blkg *it,
+				  struct blkcg *blkcg)
+{
+	struct bpf_iter_blkg_kern *kit = (void *)it;
+
+	BUILD_BUG_ON(sizeof(struct bpf_iter_blkg_kern) > sizeof(struct bpf_iter_blkg));
+	BUILD_BUG_ON(__alignof__(struct bpf_iter_blkg_kern) !=
+		     __alignof__(struct bpf_iter_blkg));
+
+	kit->pos = NULL;
+	kit->blkcg = blkcg;
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
+BTF_ID_FLAGS(func, bpf_css_to_blkcg,
+	     KF_RCU | KF_RCU_PROTECTED | KF_RET_NULL)
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
diff --git a/kernel/cgroup/bpf_cgroup.c b/kernel/cgroup/bpf_cgroup.c
index cd28c838dc7b..e253633e8278 100644
--- a/kernel/cgroup/bpf_cgroup.c
+++ b/kernel/cgroup/bpf_cgroup.c
@@ -8,12 +8,50 @@
 #include <linux/bpf.h>
 #include <linux/btf_ids.h>
 #include <linux/cgroup.h>
+#include <linux/rcupdate.h>
 
+#ifdef CONFIG_CGROUP_SCHED
 #include "../sched/sched.h"
+#endif
 
-#ifdef CONFIG_CGROUP_SCHED
 __bpf_kfunc_start_defs();
 
+/**
+ * bpf_cgroup_css - Get a reference to one controller's css
+ * @cgrp: cgroup to look in
+ * @ssid: controller ID
+ *
+ * The returned css must be released with bpf_css_release().
+ *
+ * Return: The referenced css, or NULL.
+ */
+__bpf_kfunc struct cgroup_subsys_state *
+bpf_cgroup_css(struct cgroup *cgrp, int ssid)
+{
+	struct cgroup_subsys_state *css;
+
+	if (unlikely(ssid < 0 || ssid >= CGROUP_SUBSYS_COUNT))
+		return NULL;
+
+	rcu_read_lock();
+	css = rcu_dereference(cgrp->subsys[ssid]);
+	if (css && !css_tryget(css))
+		css = NULL;
+	rcu_read_unlock();
+
+	return css;
+}
+
+/**
+ * bpf_css_release - Release a css reference
+ * @css: css to release
+ */
+__bpf_kfunc void bpf_css_release(struct cgroup_subsys_state *css)
+{
+	css_put(css);
+}
+
+#ifdef CONFIG_CGROUP_SCHED
 /**
  * bpf_css_to_task_group - Cast a CPU controller css to its task group
  * @css: CPU controller css
@@ -30,29 +68,33 @@ bpf_css_to_task_group(struct cgroup_subsys_state *css)
 
 	return container_of(css, struct task_group, css);
 }
+#endif /* CONFIG_CGROUP_SCHED */
 
 __bpf_kfunc_end_defs();
 
-BTF_KFUNCS_START(bpf_cpu_cgroup_kfunc_ids)
+BTF_KFUNCS_START(bpf_cgroup_kfunc_ids)
+BTF_ID_FLAGS(func, bpf_cgroup_css, KF_ACQUIRE | KF_RCU | KF_RET_NULL)
+BTF_ID_FLAGS(func, bpf_css_release, KF_RELEASE)
+#ifdef CONFIG_CGROUP_SCHED
 BTF_ID_FLAGS(func, bpf_css_to_task_group,
 	     KF_RCU | KF_RCU_PROTECTED | KF_RET_NULL)
-BTF_KFUNCS_END(bpf_cpu_cgroup_kfunc_ids)
+#endif
+BTF_KFUNCS_END(bpf_cgroup_kfunc_ids)
 
-static const struct btf_kfunc_id_set bpf_cpu_cgroup_kfunc_set = {
+static const struct btf_kfunc_id_set bpf_cgroup_kfunc_set = {
 	.owner		= THIS_MODULE,
-	.set		= &bpf_cpu_cgroup_kfunc_ids,
+	.set		= &bpf_cgroup_kfunc_ids,
 };
 
-static int __init bpf_cpu_cgroup_kfunc_init(void)
+static int __init bpf_cgroup_kfunc_init(void)
 {
 	int err;
 
 	err = register_btf_kfunc_id_set(BPF_PROG_TYPE_UNSPEC,
-					&bpf_cpu_cgroup_kfunc_set);
+					&bpf_cgroup_kfunc_set);
 	if (err)
-		pr_warn("error while registering cpu cgroup kfuncs: %d\n", err);
+		pr_warn("error while registering cgroup kfuncs: %d\n", err);
 
 	return err;
 }
-late_initcall(bpf_cpu_cgroup_kfunc_init);
-#endif /* CONFIG_CGROUP_SCHED */
+late_initcall(bpf_cgroup_kfunc_init);
-- 
2.53.0-Meta

