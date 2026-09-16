Received: from mta0.migadu.com (out-89.mta0.migadu.com [91.218.175.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A96BB448B9A
	for <linux-block@vger.kernel.org>; Wed, 16 Sep 2026 07:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789543460; cv=none; b=EzguyjcsDukpfXwYzPdohicnxyNcqUNEm+wj3zGH71vaMJL7v/80IMqtykVgFxSQ7roR76gp+lTHBeO/euiv8J1lWogRtaUHbCux1MuN6DdN5OtPTKANRIXGbI+zhpw8z2yXI+ihiIRZeg/9lUzNgnI0TS0SoYyQjZmwbIsYRMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789543460; c=relaxed/simple;
	bh=8Iom+NaePa0RHUNn9Ize0m+imtqlvs2cwIgmCNAa2SY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uCQToHozEMyCqCQ2migYD8trSlSCwgOcOMwNO0ehaAhehTMpxaqJTe03VA0zlHlZ1y7MPP3bbaTMDIy6DHnJcOAmsujEyXaP6dd4h4tDijTl9SfbNSDsVPyRV6/otS509qFgXRO2nFkyZeO/rAHeX9/ZZoSE/2swaUHafVztJZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=rM85vQaG; arc=none smtp.client-ip=91.218.175.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="rM85vQaG"
X-Envelope-To: linux-block@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=8Iom+NaePa0RHUNn9Ize0m+imtqlvs2cwIgmCNAa2SY=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1789543434; v=1; x=1790148234;
 b=rM85vQaG4fDE3B3DY/jwiwnU1wlpLsoTMEwqO5U19QrQad/dTYhy+RV+WVPGCcamUgMkJJR+
 VbOMPPZUwumCNrqZE6UtNqGKvUXEEToSXxXX139KnJapjAyRm8/Q4NPqdXys8MohvO/Umz5k131
 DVH3OP3NUJrtKj93xFBhgAZA=
X-Envelope-To: linux-block@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 6954b634cad03e54;
	Wed, 16 Sep 2026 07:23:54 +0000
X-Mizu-Trace-ID: 6954b634cad03e54
X-Migadu-Flow: FLOW_OUT
From: Tao Cui <cui.tao@linux.dev>
To: tj@kernel.org,
	josef@toxicopanda.com,
	axboe@kernel.dk,
	ameryhung@gmail.com
Cc: cgroups@vger.kernel.org,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	andrii@kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	linux-kselftest@vger.kernel.org,
	cui.tao@linux.dev,
	cuitao@kylinos.cn
Subject: [RFC PATCH v4 5/5] docs: cgroup-v2: document io.cost model=<name> binding
Date: Wed, 16 Sep 2026 15:23:02 +0800
Message-ID: <20260916072302.1068871-6-cui.tao@linux.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260916072302.1068871-1-cui.tao@linux.dev>
References: <20260916072302.1068871-1-cui.tao@linux.dev>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tao Cui <cuitao@kylinos.cn>

Document the named-model binding of io.cost.model in the
io.cost.model section of the cgroup v2 documentation: the binding
and restore syntax, the unknown-name rejection, the full-replacement
semantics of a bound model and the unregister lifetime.

Signed-off-by: Tao Cui <cuitao@kylinos.cn>
---
 Documentation/admin-guide/cgroup-v2.rst | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
index 8d2603751c51a..0d2d0525255cb 100644
--- a/Documentation/admin-guide/cgroup-v2.rst
+++ b/Documentation/admin-guide/cgroup-v2.rst
@@ -2124,6 +2124,18 @@ IO Interface Files
 	parameters are written to, "ctrl" become "user" and the
 	automatic changes are disabled.
 
+	When CONFIG_BLK_CGROUP_IOCOST_BPF is enabled, "model" also accepts
+	the name of a registered iocost_model_ops BPF struct_ops model:
+	"model=<name>" binds the model to the device and the model fully
+	replaces the builtin linear pricing, for every operation including
+	flushes; "model=linear" (or "ctrl=auto/user") restores the builtin
+	model.  Writing an unknown name fails with ENOENT and nothing is
+	applied.  Unregistering a model removes its name so it can no
+	longer be selected; devices already bound keep using it, and keep
+	receiving cgroup lifecycle notifications, until switched back to
+	the builtin model.  See
+	include/linux/blk-iocost.h for the model interface.
+
 	When "model" is "linear", the following model parameters are
 	defined.
 
-- 
2.43.0

