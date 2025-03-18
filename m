Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBCC31F4E38
	for <linux-block@vger.kernel.org>; Tue, 18 Mar 2025 10:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742294361; cv=none; b=W0N4nPjxMd5+Diy0t3ZGZM9DtLyQF5mBAo1+hdCm3saHoY+AJvZY6s9cUeVfQc8Bq6QvsQP+bpURbuDCU3HlpdAoFCJ9gwkMln+a1C3ovVQKMf67wQRjbjf2I30c8kyouDk04csBaVCF24h3kcDiDSixor1N5J8ADkaRgGmAvgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742294361; c=relaxed/simple;
	bh=zQn/rn0MHJPSGxwcsZKraRouhAtkHB5PCZ15cfQAAdY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ij9T0wcv75OCFyLdP8/j2HYh0/1HAE8CyLBSB7BMvH1FgnYUhloKqFZo7VSJTkHRC5yxJa1mOGyomgbKAfRaB1eIM6RFThKRxd45RuMGfYY85tlKMIFoFBZPpHiXUopH7xX7oUJ6Bwjn5XAAP0gpe2V7F6zK1WosZ2f4O9v0AHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MkSSeuwr; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MkSSeuwr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB1BCC4CEDD;
	Tue, 18 Mar 2025 10:39:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742294361;
	bh=zQn/rn0MHJPSGxwcsZKraRouhAtkHB5PCZ15cfQAAdY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=MkSSeuwrFQRLaWx1TWWQd+ospVOWygN601udmTW7zD2UdFMCMQ1kCmKnNyHyvsUKZ
	 n7jCUK4GFpOmT5CxghpPnMNW641XaEbSRS07yqCgX1Qdcfnzfmshrc2P7KP27V7Q4l
	 68ZgZv+7YRa1KWyDJOBr9puE+/m4BuJcYVKeU1II3WhqH+S4AE0QlWFnuode4HbX0c
	 +hleBgIPwwrGGpKfsKAOodp9lXccSfnzHy3aFnKEfro4S40N7Fgch9DII08QxtCOZL
	 0d9LMIcLVXjw9/O7F5q4v5zA8ku6as17pFCyli8y5bOM4ZOz02wAwiFcFPzc3AXqzx
	 +Kd4FB6K+67Fg==
From: Daniel Wagner <wagi@kernel.org>
Date: Tue, 18 Mar 2025 11:39:00 +0100
Subject: [PATCH blktests 2/3] nvme/060: add test nvme fabrics target
 resetting during I/O
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250318-test-target-v1-2-01e01142cf2b@kernel.org>
References: <20250318-test-target-v1-0-01e01142cf2b@kernel.org>
In-Reply-To: <20250318-test-target-v1-0-01e01142cf2b@kernel.org>
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: linux-block@vger.kernel.org, Daniel Wagner <wagi@kernel.org>
X-Mailer: b4 0.14.2

Newer kernel support to reset the target via the debugfs. Add a new test
case which exercises this interface.

Signed-off-by: Daniel Wagner <wagi@kernel.org>
---
 tests/nvme/060     | 88 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/nvme/060.out |  2 ++
 2 files changed, 90 insertions(+)

diff --git a/tests/nvme/060 b/tests/nvme/060
new file mode 100755
index 0000000000000000000000000000000000000000..16a3c0d20274428ae175693109c694f42004a619
--- /dev/null
+++ b/tests/nvme/060
@@ -0,0 +1,88 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-3.0+
+# Copyright (C) 2025 Daniel Wagner, SUSE Labs
+#
+# Test nvme fabrics controller reset/disconnect/reconnect operation during I/O
+# This test is somewhat similar to test 032 but for fabrics controllers.
+
+. tests/nvme/rc
+
+DESCRIPTION="test nvme fabrics target resetting during I/O"
+
+requires() {
+	_nvme_requires
+	_have_loop
+	_have_fio
+	_require_nvme_trtype_is_fabrics
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
+nvmf_wait_for_state() {
+	local def_state_timeout=5
+	local subsys_name="$1"
+	local state="$2"
+	local timeout="${3:-$def_state_timeout}"
+	local nvmedev
+	local state_file
+	local start_time
+	local end_time
+
+	nvmedev=$(_find_nvme_dev "${subsys_name}")
+	state_file="/sys/class/nvme-fabrics/ctl/${nvmedev}/state"
+
+	start_time=$(date +%s)
+	while ! grep -q "${state}" "${state_file}"; do
+		sleep 1
+		end_time=$(date +%s)
+		if (( end_time - start_time > timeout )); then
+			echo "expected state \"${state}\" not " \
+				"reached within ${timeout} seconds"
+			return 1
+		fi
+	done
+
+	return 0
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
+	fio_pid=$!
+
+	# Try to trigger resets when the host is in different states connected,
+	# or connecting by calling target reset with an even number and the
+	# reconnect attempt with an uneven timeout.
+	for ((i = 0; i <= 5; i++)); do
+		_nvme_connect_subsys --keep-alive-tmo 1 --reconnect-delay 1
+		sleep 3
+		_nvme_disconnect_subsys >> "$FULL" 2>&1
+	done
+
+	{ kill "${fio_pid}"; wait; } &> /dev/null
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
2.48.1

