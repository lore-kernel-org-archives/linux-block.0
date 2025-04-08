Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C251A22FE07
	for <linux-block@vger.kernel.org>; Tue,  8 Apr 2025 16:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744129574; cv=none; b=CnGnbFizJXnECDPWMIi1RsHVPszwqEm2HD9VHVVyScAOPrZBQUQ8kgZpXRHuoIClO+Ia8d6kCdrNqR2ipC8fTc7ITZ94+WpNBoHo3LjKhF4GsGSEFYqry5AHH0KS9NPp1QKvfGSEn9yB2NFJmY0c3oXwXhHqca5bLpMMQsT8aiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744129574; c=relaxed/simple;
	bh=WJ9VFXs8LDtfg8uIwMi7UOmm3Jgz8doNUes5m0fdjmU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kIrcsvA4plcuBH15yNLHQYPyzAK5z07YA7Hyk7SxQ/yBPCPC1g1QuleIltGPGWzFe/nJs58NQI75wE3CpAW44Iti49g2N4jaGfYHBLXYqpHC7/G3k+jpfWOA9vqmtfEGK+8NA4EELh6XRU17HZuzxxKIMOW6Gi0NSQwxieGah/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gF2W1Zpe; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gF2W1Zpe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 225D0C4CEEB;
	Tue,  8 Apr 2025 16:26:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744129574;
	bh=WJ9VFXs8LDtfg8uIwMi7UOmm3Jgz8doNUes5m0fdjmU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=gF2W1Zpe25gYTdYRTr8JYhGuc+It0ybVu/i4CrmTyEfOsMqcJD2SYYAs7DkE4Ny8U
	 pWBin+U16KadB+gkXaLLMSzLW7n8tBIUCaFsrGwBCUIS2bhUKO+SdwxKdKxQx+qZhD
	 ePOR/mqoVBy4/t0TzTGo6yM5gvmmE9mghGEr/uOywBCpX5WSvnjR8kI8ZffSMbvuor
	 TNCm92catwzNeioRFmpYKSn0x4p+QZ78SnDH/gbMkaedpNVXs2czl9p9Gm441tJNpd
	 xGB1isoiJPiuZqEaYvLzKSoK8lnM0bJTOc6ZLu/FrX6+Sjtax7kEi5Z7dU9KJJr/Bz
	 IHxKAlMEj5Ttg==
From: Daniel Wagner <wagi@kernel.org>
Date: Tue, 08 Apr 2025 18:25:59 +0200
Subject: [PATCH blktests v2 3/4] nvme/060: add test nvme fabrics target
 resetting during I/O
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250408-test-target-v2-3-e9e2512586f8@kernel.org>
References: <20250408-test-target-v2-0-e9e2512586f8@kernel.org>
In-Reply-To: <20250408-test-target-v2-0-e9e2512586f8@kernel.org>
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: Chaitanya Kulkarni <kch@nvidia.com>, linux-block@vger.kernel.org, 
 Daniel Wagner <wagi@kernel.org>
X-Mailer: b4 0.14.2

Newer kernel support to reset the target via the debugfs. Add a new test
case which exercises this interface.

Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
Signed-off-by: Daniel Wagner <wagi@kernel.org>
---
 tests/nvme/060     | 62 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/nvme/060.out |  2 ++
 2 files changed, 64 insertions(+)

diff --git a/tests/nvme/060 b/tests/nvme/060
new file mode 100755
index 0000000000000000000000000000000000000000..293b03cd0ef6a75722c6b86fccbbc931d6f5e3a1
--- /dev/null
+++ b/tests/nvme/060
@@ -0,0 +1,62 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-3.0+
+# Copyright (C) 2025 Daniel Wagner, SUSE Labs
+#
+# Test nvme fabrics controller reset/disconnect/reconnect.
+
+. tests/nvme/rc
+
+DESCRIPTION="test nvme fabrics target reset"
+
+requires() {
+	_nvme_requires
+	_have_loop
+	_require_nvme_trtype_is_fabrics
+	_have_kernel_option NVME_TARGET_DEBUGF
+}
+
+set_conditions() {
+	_set_nvme_trtype "$@"
+}
+
+nvmet_debug_trigger_reset() {
+	local nvmet_subsystem="$1"
+	local dfs_path="${NVMET_DFS}/${nvmet_subsystem}"
+
+	find "${dfs_path}" -maxdepth 1 -type d -name 'ctrl*' -exec sh -c 'echo "fatal" > "$1/state"' _ {} \;
+}
+
+nvmet_reset_loop() {
+	while true; do
+		nvmet_debug_trigger_reset "${def_subsysnqn}"
+		sleep 2
+	done
+}
+
+test() {
+	echo "Running ${TEST_NAME}"
+
+	_setup_nvmet
+
+	_nvmet_target_setup
+
+	nvmet_reset_loop &
+	reset_loop_pid=$!
+
+	# Reset the host in different states e.g when the host is in the
+	# connected or connecting state.
+	#
+	# The target reset is triggered with an even number timeout, while the
+	# host reconnects with an odd number timeout.
+	for ((i = 0; i <= 5; i++)); do
+		_nvme_connect_subsys --keep-alive-tmo 1 --reconnect-delay 1
+		sleep 3
+		_nvme_disconnect_subsys >> "$FULL" 2>&1
+	done
+
+	{ kill "${reset_loop_pid}"; wait; } &> /dev/null
+
+	_nvmet_target_cleanup
+
+	echo "Test complete"
+}
diff --git a/tests/nvme/060.out b/tests/nvme/060.out
new file mode 100644
index 0000000000000000000000000000000000000000..517ff2dfcfd41c4088991e669af9fef52bde570b
--- /dev/null
+++ b/tests/nvme/060.out
@@ -0,0 +1,2 @@
+Running nvme/060
+Test complete

-- 
2.49.0

