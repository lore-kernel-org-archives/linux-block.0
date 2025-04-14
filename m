Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5DA52D0A49
	for <linux-block@vger.kernel.org>; Mon, 14 Apr 2025 14:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744639561; cv=none; b=oQpFJZWU0gC78xMh0wOdJGApdK/rqpp7dcIdHiJLF9EnTu2vSN0voIPJlR+OCifhOzJ3Q9VUlyZd9OTbWur5FaLcXNlxR6P1OAVjkVb71FmE0qRsumLnSJ/jG9aF1b+gXO0mHrKsF9dc6M71ObRjyE3PQVkEHoNbYZBEKoswX7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744639561; c=relaxed/simple;
	bh=VGqSKjU88+1/Ydy9B6Q8Gcc0hdB/mx7qO+/1X8xaFBg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=S2qsZXrvZXm4yfNpfy8WREYkwkUVTwzF//D1UuvtjzW2KUH8ejpPyOVfoJzCTgGpIzIJBl2Mx7cJIgXTffR1mCOZc/ywiMYdyQZeUTXAy7ypUtZNf+WiXN0OXfBrdnFtjHsHyH9BHNSRQGVnXlnS/EjgQ6D56933w1tXciJfAm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vm0o7uEf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vm0o7uEf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDB71C4CEE9;
	Mon, 14 Apr 2025 14:06:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744639561;
	bh=VGqSKjU88+1/Ydy9B6Q8Gcc0hdB/mx7qO+/1X8xaFBg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Vm0o7uEfJ3vL6H3+dW5mCmNieGSWca1xAlVBV8PI48PJ4GPgtnRCD3P7eBzLZOphc
	 TpD3HRe07+wVeK7USur3omc2l5T+H1ZqpQMUa5slBwC0KMnJ7JX9XQlDGN0Uq/9cKh
	 SFGsB7vNSt9UkbvIUqc5mIxltwZPW7xV9W8M2gTijB4eH+3vrSi5u9gC1nR1SN8ewV
	 xuEMRFc7mTzF0/+17uF5urQ6XKrNEvsJBWImobd5/j/ZEEtjjlwD0nc8CMX3FcULoY
	 ojVxq/v0RwMqY5Wdbh1KTSs2IuF9mfpacE73fuGGOM1Bvu7gfZ5tjtbarVfzENdIiM
	 MX+wOmOmiiXhw==
From: Daniel Wagner <wagi@kernel.org>
Date: Mon, 14 Apr 2025 16:05:52 +0200
Subject: [PATCH blktests v3 3/4] nvme/060: add test nvme fabrics target
 resetting during I/O
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250414-test-target-v3-3-024575fcec06@kernel.org>
References: <20250414-test-target-v3-0-024575fcec06@kernel.org>
In-Reply-To: <20250414-test-target-v3-0-024575fcec06@kernel.org>
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
index 0000000000000000000000000000000000000000..aa048198708cc82e684aaf94c145ae88c4af3099
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
+	_require_nvme_trtype tcp rdma fc
+	_have_kernel_option NVME_TARGET_DEBUGFS
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

