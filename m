Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 146A14734C9
	for <linux-block@vger.kernel.org>; Thu, 20 Aug 2026 21:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787260690; cv=none; b=F+XY/oq01xZ2HjG6Ufip7fE5Bf7uUJ/q44UZ8JD6MKt9BnXf1G/bAbbA1Y9DJpbtrAY1MhZspEtDj78kb6qwykj+l2exDei/iyqW4SpPnkaTQ/Rx4Rf1bFRfxlgQO57H1EHoaqVdEG2+CVdK5lk5SYoenB8L1qDy2z684EDL/i0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787260690; c=relaxed/simple;
	bh=YjqdsGJuMeIq7n8PzjUvmgIYfZOosAHqNR3Q2LYldfs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Cou/gClFZZdZA1o1p3H+q3oXMlwRPXO2uG6NyRAcJ4TnpBbvlVUvynP7kRCTrzdX+9wgoM/jMUDd+7rTlYUowZCDJe1Z7rYHQVtnhlBQfP5TK9cVppsVrauyW6lUGXb7xNgYRkkRn2I2mCMel+GW6xVzl2FdPhLOPpW4E/1Zw04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JbQuxgBK; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JbQuxgBK"
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-cc11a905ba5so274251a12.2
        for <linux-block@vger.kernel.org>; Thu, 20 Aug 2026 14:18:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787260683; x=1787865483; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fNnF6T8sz4WljkkHVGCRYU0uuUkbDNh6HBGKfIf2U2g=;
        b=JbQuxgBKFQmH25J3svttJ5EyFkABkSSDF8T4fxc5zuOmxOhIDPuxZj/iBDwmsKwWwF
         yg/wUGCvnPmDZ4ghB6GSFJauxMGIm4Crw3oPttlhcmg1+5h9TGwYZl9P8fACiaG88Nr4
         niV2XR8Zh7SYcMcJl/9oXnzTfivZ+T8KSCq2Ni1vQSI7MQ7yJAyrdE2tjAXL/Ny8rYjN
         yPkIK24exLqzRYleEpa20U3T14LHE6XUykgKlz7kEuEoXza+C5ibFYH0dWo8zzue2Z++
         HojkILr0m348OeH1PAbv6ma6mGXFNpWOc79+DDRkepKbcPKOWjRVQzzpDmdl1dvtMW4e
         pnQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787260683; x=1787865483;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=fNnF6T8sz4WljkkHVGCRYU0uuUkbDNh6HBGKfIf2U2g=;
        b=bR9Q7glHzV8Ucy5vh7GqXKM7sUOrO66JWlNnWTxFouDXdKBzvBElFzGBiR8dY248ji
         ssSaHpVEGfkaZkd4WIQCWjA/ub/nVxhT75ndegGrCSdObI4OIWkPiI6H4RpURG3IiA3Z
         ohVn0CHedkZMsAjAJNfRCE4+c9S+47iHNtM4NNXlIFdUS9uxzf2Wvfg04fnRqxhvgIqo
         FzTkscw/tG9gxqUX/5weIUvWJ/wG8qggWR0wPjvqQuxIX5yV3dYmTK4wWkzA3lfdPtYF
         AAHwka4lrN3/uV8yr0uSy1xt57SvY14SiR9rNxU/NBncWWKeAnaewkk7rg/r8FSTNvaQ
         4CAQ==
X-Forwarded-Encrypted: i=1; AHgh+RplsbVsPCCuYLLpJKJEBRbUwF/gYbmV8iNOJuQlvSa8k1hM2hqP76k7sCCbcIE9pSKvFS91qLwAmgwvFw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxq6Dr6sGr5EBJLzOxxAvvSiqcAknwKc5jaELX/t0U0qpJjz4fD
	HjzfVXQdYVmKGYwLk7d1mYpudkvw4bjS5LflpOAFOBwA9aftWA1pDBdk
X-Gm-Gg: AR+sD11o084Nl31r4syZ1zgLzCIPuu3UTNnhheS/5o080J2EqQVcNYMBo5xTCZzAwpb
	PNDkxPxnL92fHB0uWrkogbOdZl07y74KsZXCO50Br95CGBIvWcIctHbnHtzFSCVNG+1XiHl19Ru
	f1FhZIpVAFDljJn3tkL8t7pI8qrMrT4eGth7PCWvz0V2YI5hyOc4Fh3xR6H0bbK9NZEgvzcF4aR
	+Im8gk/dfYyWeMPAIdXURlN73nGIy8nIylLgF3oTvm2KXRmDsE43YtUi5jZrdM/QNGw0aWOEr6Y
	vppsvqwb3ddonrpeuE7gDn+BBVWO0Cd3GkiY3mm9WwUO4X3WcNHAyF6dkHC27Q2OhMqLwELPr7C
	Dj2Jt14vo17j2yGrl9h3Gk2WywSd3//YfV3YlR2g30+QQ6IZ7eNqcfk1xkOuV7DZYeCyRR4Hwsj
	Oy61RvKAJgVtzYnGI8xrl37CUE+jLTl6676gYXpDLcZVtFF295F4XiMSk=
X-Received: by 2002:a05:6a20:450c:b0:3bf:6d96:ac40 with SMTP id adf61e73a8af0-3cd3007ce9bmr2646024637.12.1787260682945;
        Thu, 20 Aug 2026 14:18:02 -0700 (PDT)
Received: from localhost ([2a03:2880:9ff:72::])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-327bef3993dsm17917418eec.5.2026.08.20.14.18.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2026 14:18:02 -0700 (PDT)
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
Subject: [PATCH v3 1/4] cgroup: add BPF kfuncs to read a cpu cgroup's stats
Date: Thu, 20 Aug 2026 14:17:55 -0700
Message-ID: <20260820211758.3393984-2-ziyang.meme@gmail.com>
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
opens and parses a cgroup file. memcg already provides an efficient BPF
interface; extend that model to the CPU controller.

Register css_rstat_flush() as a common kfunc and add
bpf_cgroup_base_stat(). The latter returns cgroup_base_stat after the
same cputime adjustment used by cpu.stat.

The BPF program reads the plain CFS bandwidth counters directly. Add
bpf_css_to_task_group() to check the controller and give the verifier a
typed task_group pointer for bpf_per_cpu_ptr().

css_rstat_flush() may reschedule and requires a sleepable program.
bpf_cgroup_base_stat() only takes locks and is not marked sleepable, but
those locks are not NMI-safe.

Suggested-by: Shakeel Butt <shakeel.butt@linux.dev>
Suggested-by: Tejun Heo <tj@kernel.org>
Assisted-by: Claude:claude-opus-5
Signed-off-by: Ziyang Men <ziyang.meme@gmail.com>
---
 kernel/cgroup/Makefile     |  2 ++
 kernel/cgroup/bpf_cgroup.c | 58 ++++++++++++++++++++++++++++++++++++++
 kernel/cgroup/rstat.c      | 54 ++++++++++++++++++++++++++++++++---
 3 files changed, 110 insertions(+), 4 deletions(-)
 create mode 100644 kernel/cgroup/bpf_cgroup.c

diff --git a/kernel/cgroup/Makefile b/kernel/cgroup/Makefile
index ede31601a363..29f29228865b 100644
--- a/kernel/cgroup/Makefile
+++ b/kernel/cgroup/Makefile
@@ -1,6 +1,8 @@
 # SPDX-License-Identifier: GPL-2.0
 obj-y := cgroup.o rstat.o namespace.o cgroup-v1.o freezer.o
 
+obj-$(CONFIG_BPF_SYSCALL) += bpf_cgroup.o
+
 obj-$(CONFIG_CGROUP_FREEZER) += legacy_freezer.o
 obj-$(CONFIG_CGROUP_PIDS) += pids.o
 obj-$(CONFIG_CGROUP_RDMA) += rdma.o
diff --git a/kernel/cgroup/bpf_cgroup.c b/kernel/cgroup/bpf_cgroup.c
new file mode 100644
index 000000000000..cd28c838dc7b
--- /dev/null
+++ b/kernel/cgroup/bpf_cgroup.c
@@ -0,0 +1,58 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Cgroup BPF kfuncs
+ *
+ * Author: Ziyang Men <ziyang.meme@gmail.com>
+ */
+
+#include <linux/bpf.h>
+#include <linux/btf_ids.h>
+#include <linux/cgroup.h>
+
+#include "../sched/sched.h"
+
+#ifdef CONFIG_CGROUP_SCHED
+__bpf_kfunc_start_defs();
+
+/**
+ * bpf_css_to_task_group - Cast a CPU controller css to its task group
+ * @css: CPU controller css
+ *
+ * Must be called under RCU. The kfunc gives BPF a typed task_group pointer.
+ *
+ * Return: The task group, or NULL if @css belongs to another controller.
+ */
+__bpf_kfunc struct task_group *
+bpf_css_to_task_group(struct cgroup_subsys_state *css)
+{
+	if (unlikely(css->ss != &cpu_cgrp_subsys))
+		return NULL;
+
+	return container_of(css, struct task_group, css);
+}
+
+__bpf_kfunc_end_defs();
+
+BTF_KFUNCS_START(bpf_cpu_cgroup_kfunc_ids)
+BTF_ID_FLAGS(func, bpf_css_to_task_group,
+	     KF_RCU | KF_RCU_PROTECTED | KF_RET_NULL)
+BTF_KFUNCS_END(bpf_cpu_cgroup_kfunc_ids)
+
+static const struct btf_kfunc_id_set bpf_cpu_cgroup_kfunc_set = {
+	.owner		= THIS_MODULE,
+	.set		= &bpf_cpu_cgroup_kfunc_ids,
+};
+
+static int __init bpf_cpu_cgroup_kfunc_init(void)
+{
+	int err;
+
+	err = register_btf_kfunc_id_set(BPF_PROG_TYPE_UNSPEC,
+					&bpf_cpu_cgroup_kfunc_set);
+	if (err)
+		pr_warn("error while registering cpu cgroup kfuncs: %d\n", err);
+
+	return err;
+}
+late_initcall(bpf_cpu_cgroup_kfunc_init);
+#endif /* CONFIG_CGROUP_SCHED */
diff --git a/kernel/cgroup/rstat.c b/kernel/cgroup/rstat.c
index de816a43db9f..5db72504a8a5 100644
--- a/kernel/cgroup/rstat.c
+++ b/kernel/cgroup/rstat.c
@@ -752,10 +752,49 @@ void cgroup_base_stat_cputime_show(struct seq_file *seq)
 	cgroup_force_idle_show(seq, &bstat);
 }
 
-/* Add bpf kfuncs for css_rstat_updated() and css_rstat_flush() */
+#ifdef CONFIG_BPF_SYSCALL
+
+__bpf_kfunc_start_defs();
+
+/**
+ * bpf_cgroup_base_stat - Read a cgroup's base statistics
+ * @cgrp: cgroup to read from
+ * @out: zero-initialized output in nanoseconds
+ *
+ * CPU time is adjusted as for cpu.stat.
+ */
+__bpf_kfunc void bpf_cgroup_base_stat(struct cgroup *cgrp,
+				      struct cgroup_base_stat *out)
+{
+	if (cgroup_parent(cgrp)) {
+		__css_rstat_lock(&cgrp->self, -1);
+		*out = cgrp->bstat;
+		cputime_adjust(&cgrp->bstat.cputime, &cgrp->prev_cputime,
+			       &out->cputime.utime, &out->cputime.stime);
+		__css_rstat_unlock(&cgrp->self, -1);
+	} else {
+		root_cgroup_cputime(out);
+	}
+}
+
+__bpf_kfunc_end_defs();
+
+BTF_KFUNCS_START(bpf_rstat_common_kfunc_ids)
+BTF_ID_FLAGS(func, css_rstat_flush, KF_SLEEPABLE)
+/* The reader does not sleep, but its locks are not NMI-safe. */
+BTF_ID_FLAGS(func, bpf_cgroup_base_stat)
+BTF_KFUNCS_END(bpf_rstat_common_kfunc_ids)
+
+static const struct btf_kfunc_id_set bpf_rstat_common_kfunc_set = {
+	.owner		= THIS_MODULE,
+	.set		= &bpf_rstat_common_kfunc_ids,
+};
+
+#endif /* CONFIG_BPF_SYSCALL */
+
+/* Add a bpf kfunc for css_rstat_updated(). */
 BTF_KFUNCS_START(bpf_rstat_kfunc_ids)
 BTF_ID_FLAGS(func, css_rstat_updated)
-BTF_ID_FLAGS(func, css_rstat_flush, KF_SLEEPABLE)
 BTF_KFUNCS_END(bpf_rstat_kfunc_ids)
 
 static const struct btf_kfunc_id_set bpf_rstat_kfunc_set = {
@@ -765,7 +804,14 @@ static const struct btf_kfunc_id_set bpf_rstat_kfunc_set = {
 
 static int __init bpf_rstat_kfunc_init(void)
 {
-	return register_btf_kfunc_id_set(BPF_PROG_TYPE_TRACING,
-					 &bpf_rstat_kfunc_set);
+	int ret;
+
+	ret = register_btf_kfunc_id_set(BPF_PROG_TYPE_TRACING,
+					&bpf_rstat_kfunc_set);
+#ifdef CONFIG_BPF_SYSCALL
+	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_UNSPEC,
+					       &bpf_rstat_common_kfunc_set);
+#endif
+	return ret;
 }
 late_initcall(bpf_rstat_kfunc_init);
-- 
2.53.0-Meta

