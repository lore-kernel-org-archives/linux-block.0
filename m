Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.203
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795007477;
	b=iaKwHHMgB5Y3Vj0dI+HkyaGbiGLiiJoSOz8tbKO+7g/SlzSwVWqCVuwswtAM2ZSol1NQ
	 SKyMXwJHqEkcXWjlRpWzdc27mgAZD9rbB8repKnBOd3iWehqgMsG3oZ+vy0cI6D7I/mNz
	 TKMCs5sLTTxMjQYacC8UdORP8myA1uubYH0zu6BCkipeQp2L1TvzFThBdAjM9363t+Zpy
	 N77YFUu+MGP6T0224yPusgiTCk/gVQn8+Ydw2NI2FxKaRe7o9afyUJO414hJKnz5FUSQn
	 t7wYaC+JM2uWuzsHzJX+Wifltubu6x8lMmQ7E/4Z//4/y5oGdVF4ZTgY5FuVuM5tojg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795007477;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=QJAC08ngDRm9W4yawdTHyboRVQ9MGN7haYElLNq+7pU=;
	b=JXbID7Tlgs8cHSwUDj4Qy7e+cZR5lNyFfiY2hKgWgQ1yf0QxR4KXq3HgY64wqBSFuTeq
	 jEDaZxxnFtKddV1AIVbMc2FU3Zd4OsxdzG5gZpUE6ujKKoZplqb8zuZ+BEDZAe7QuuDTB
	 Oa2IJxBISPePbSNwDkebHYQA3/h44lMj+DhCOuOpwalZqsyY5FwP8NVsqQaETI5v8uQ3y
	 KQwV3GpeElVSMpIuL4ZZn3J2FiymY6YxxSptHXI+4mTEUbsRuZDBtRZ98lK4vudk0gh/F
	 jk6MEzQktsopypBKlYKEjD44b6NudTsDq40e28FNJs55HZ6quk9shBsz5Tow0yjjsoQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=WyZI6CJM;
	arc=none smtp.remote-ip=95.215.58.203
Received: from mta1.migadu.com (out-203.mta1.migadu.com [95.215.58.203])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DD5C606A32F
	for <linux-block@vger.kernel.org>; Wed, 18 Nov 2026 13:11:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8DD5C606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=WyZI6CJM
X-Envelope-To: linux-block@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=RMpd59Gb6dpKtX3get0waM32XpfRzKJRh6E8RWM6GBM=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795007474; v=1; x=1795612274;
 b=WyZI6CJMpR2JzG0xH9pWLqLOd9sD5rcrzUY3EyZSpuedZRCwAcV0ju6Cbq+bBG9I9tozVrKv
 ahN5j7O3ka+rk9/fDYa4C6TlWsyJB6WkDsha63OcVJ15xKmJ/aRTuw4ToWB/MHj+VSP+9ozXuuk
 9MbkuYctNf0NJ6cx4I3QHOjA=
X-Envelope-To: linux-block@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 8bd3cc9683cdaa16;
	Wed, 18 Nov 2026 13:11:14 +0000
X-Mizu-Trace-ID: 8bd3cc9683cdaa16
X-Migadu-Flow: FLOW_OUT
From: Tao Cui <cui.tao@linux.dev>
To: tj@kernel.org,
	josef@toxicopanda.com,
	axboe@kernel.dk,
	ast@kernel.org,
	alexei.starovoitov@gmail.com
Cc: cgroups@vger.kernel.org,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	andrii@kernel.org,
	eddyz87@gmail.com,
	daniel@iogearbox.net,
	linux-kselftest@vger.kernel.org,
	cui.tao@linux.dev,
	cuitao@kylinos.cn,
	ameryhung@gmail.com
Subject: [RFC PATCH v14 4/4] docs: cgroup-v2: document the iocost BPF cost model attachment
Date: Wed, 18 Nov 2026 21:10:29 +0800
Message-ID: <20261118131029.797007-5-cui.tao@linux.dev>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261118131029.797007-1-cui.tao@linux.dev>
References: <20261118131029.797007-1-cui.tao@linux.dev>
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

From: Tao Cui <cuitao@kylinos.cn>

Document the BPF cost model attachment in the io.cost.model section
of the cgroup v2 documentation: attaching an iocost_model_ops
struct_ops to a device by its major:minor, the model=bpf readback
while attached (ctrl keeps describing the coefficients), the builtin
model coming back on detach, and ctrl writes never selecting a model.

Suggested-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Tao Cui <cuitao@kylinos.cn>
---
 Documentation/admin-guide/cgroup-v2.rst | 55 +++++++++++++++++++++----
 1 file changed, 47 insertions(+), 8 deletions(-)

diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
index 9e3c67b02ae2..a3c402f03ae9 100644
--- a/Documentation/admin-guide/cgroup-v2.rst
+++ b/Documentation/admin-guide/cgroup-v2.rst
@@ -2056,8 +2056,9 @@ IO Interface Files
 	currently implements "io.weight" proportional control.  Lines
 	are keyed by $MAJ:$MIN device numbers and not ordered.  The
 	line for a given device is populated on the first write for
-	the device on "io.cost.qos" or "io.cost.model".  The following
-	nested keys are defined.
+	the device on "io.cost.qos" or "io.cost.model", or when a BPF
+	cost model is attached to it.  The following nested keys are
+	defined.
 
 	  ======	=====================================
 	  enable	Weight-based control enable
@@ -2111,13 +2112,50 @@ IO Interface Files
 	implements "io.weight" proportional control.  Lines are keyed
 	by $MAJ:$MIN device numbers and not ordered.  The line for a
 	given device is populated on the first write for the device on
-	"io.cost.qos" or "io.cost.model".  The following nested keys
-	are defined.
+	"io.cost.qos" or "io.cost.model", or when a BPF cost model is
+	attached to it.  The following nested keys are defined.
 
-	  =====		================================
+	  =====		==========================================
 	  ctrl		"auto" or "user"
-	  model		The cost model in use - "linear"
-	  =====		================================
+	  model		The cost model in use - "linear" or "bpf"
+	  =====		==========================================
+
+	When BPF cost model support is available, a BPF cost model
+	can be bound to a device by attaching an
+	"iocost_model_ops" struct_ops carrying the whole disk's
+	major:minor as encoded by makedev(3) in its "dev" member (a
+	partition's major:minor is rejected).  The loader supplies
+	"dev" when the map is created and it cannot be changed
+	afterward.  Attaching creates the controller if needed, like an
+	io.cost.model write does, switches the device's pricing to the
+	model and populates the device's line in this file and in
+	"io.cost.qos" if it did not exist yet.  Attaching fails with
+	-EBUSY if the device already has a model attached, with
+	-EINVAL if the model fails its attach-time validation, with
+	-EOPNOTSUPP if dev names a partition or a device without a
+	multiqueue queue, and with -ENODEV if dev does not name an
+	existing device or if the device has gone away.  Updating the
+	link to a different model is not supported and fails with
+	-EINVAL or -EOPNOTSUPP; switching models requires detaching
+	first.  The
+	attached model prices IOs only while the controller is enabled
+	through "io.cost.qos"; attaching does not enable it.  IOs issued
+	directly by the root cgroup bypass the model's per-IO pricing;
+	the completion-time sizing of their requests still uses the
+	attached model's transfer coefficients.
+
+	While a model is attached, "model" selects between it and the
+	builtin model: "model=bpf" switches to the attached model and
+	"model=linear" switches back to the builtin model, and neither
+	detaches the struct_ops.
+
+	Detaching removes the model, after which "model=bpf"
+	fails and the device prices with the builtin model again.
+	Device removal ejects the attached model as well, while the
+	struct_ops link remains until userspace destroys it.  "ctrl"
+	accepts only "auto" and "user" and never selects a model.  It
+	keeps describing the builtin coefficients, which take effect
+	again when switched back.
 
 	When "ctrl" is "auto", the kernel may change all parameters
 	dynamically.  When "ctrl" is set to "user" or any other
@@ -2125,7 +2163,8 @@ IO Interface Files
 	automatic changes are disabled.
 
 	When "model" is "linear", the following model parameters are
-	defined.
+	defined.  They remain readable and writable while "model" is
+	"bpf".
 
 	  =============	========================================
 	  [r|w]bps	The maximum sequential IO throughput
-- 
2.53.0

