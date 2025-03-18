Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AFC92063EA
	for <linux-block@vger.kernel.org>; Tue, 18 Mar 2025 10:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742294364; cv=none; b=c/yB7GT6dIK379h7nMtOuT2Xa59oKm1cZ+oO7tkOxiYMbMYLbqll6DUh3gJ16jhW2GAM7SY6lKxCat3XlLswbVHpcq0vncOnMqAFtUipq8xsmQprcyNvbJplvCMpehYrKzjTqvgvr0JscTZ1KyHtU0L5SoGldad3d1kv8591cts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742294364; c=relaxed/simple;
	bh=lat+6NhuDdq1mjanFRrAUQ8SY0fhKvWRh4DdhV+sxIM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ft8XPk9mzVq6suUxC7MGQ1bfb2m44hAsPXC+QvoI/WDDzMohL4titHfe8h91HnVPzYCZyOE3yYGJ32d9ri5m7QSN+Uqsp95PBkKjP549Vycwb+3kuRqZOxyN4KMhoIIW/yPTAI3Pd1+DUADrQiuY77InnvMvlkRhOxY6W3DNA3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R+V2e0Zc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R+V2e0Zc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72EC6C4CEDD;
	Tue, 18 Mar 2025 10:39:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742294363;
	bh=lat+6NhuDdq1mjanFRrAUQ8SY0fhKvWRh4DdhV+sxIM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=R+V2e0ZcB4eRUZBLmVa0bmDJeGRapXJJj9t14swg0R1uEznzgryuuKtfrL2eAiVkW
	 Tilk7uxYx45s4wlvr4Jm7Ad0EZcUCO+NxqhC0s5Yo6soIISdHrEmtuHSBv5eGC7ys3
	 1ZD2EEVygQmWuAHuCQE0HY+0T3naXY+NI86cCU/Ztgp3IUVCE/1ThWxGvCzCWZRYSw
	 c4fxYkO5sNocDQzEI/k0+EW2ptUouBPm/xiZURS1jIPlfrgW9IdNCT5YLyAijU7ru8
	 R1t3NMwDFEI3XAvIZFeV4vaM7JmtiS+WL8Dec5sa8WfudTcUMXkPbakDQwQ3yM3YIW
	 WrqOOZlLWzw7g==
From: Daniel Wagner <wagi@kernel.org>
Date: Tue, 18 Mar 2025 11:39:01 +0100
Subject: [PATCH blktests 3/3] nvme/061: add test teardown and setup fabrics
 target during I/O
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250318-test-target-v1-3-01e01142cf2b@kernel.org>
References: <20250318-test-target-v1-0-01e01142cf2b@kernel.org>
In-Reply-To: <20250318-test-target-v1-0-01e01142cf2b@kernel.org>
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: linux-block@vger.kernel.org, Daniel Wagner <wagi@kernel.org>
X-Mailer: b4 0.14.2

Add a new test case which forcefully removes the target and setup it
again.

Signed-off-by: Daniel Wagner <wagi@kernel.org>
---
 tests/nvme/061     | 99 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/nvme/061.out | 21 ++++++++++++
 2 files changed, 120 insertions(+)

diff --git a/tests/nvme/061 b/tests/nvme/061
new file mode 100755
index 0000000000000000000000000000000000000000..b7a9ca216e6b71db209e80dc69dfd934618b54c2
--- /dev/null
+++ b/tests/nvme/061
@@ -0,0 +1,99 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-3.0+
+# Copyright (C) 2025 Daniel Wagner, SUSE Labs
+#
+# Test if the host keeps running IO when the target is forcefully removed and
+# recreated.
+
+. tests/nvme/rc
+
+DESCRIPTION="test teardown and setup fabrics target during I/O"
+TIMED=1
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
+test() {
+	echo "Running ${TEST_NAME}"
+
+	_setup_nvmet
+
+	local ns
+
+	_nvmet_target_setup
+
+	local connect_args=""
+
+	if [[ "${nvme_trtype}" == "fc" ]]; then
+		connect_args="--ctrl-dev-loss 0"
+	fi
+
+	_nvme_connect_subsys --keep-alive-tmo 1 --reconnect-delay 1
+
+	ns=$(_find_nvme_ns "${def_subsys_uuid}")
+
+	_run_fio_rand_io --filename="/dev/${ns}" \
+		--group_reporting \
+		--time_based --runtime=1d &> /dev/null &
+	fio_pid=$!
+	sleep 1
+
+	nvmedev=$(_find_nvme_dev "${def_subsysnqn}")
+	state_file="/sys/class/nvme-fabrics/ctl/${nvmedev}/state"
+	for ((i = 0; i <= 5; i++)); do
+		echo "iteration $i"
+
+		_nvmet_target_cleanup
+
+		nvmf_wait_for_state "${def_subsysnqn}" "connecting" || return 1
+		echo "state: $(cat $state_file)"
+
+		_nvmet_target_setup
+
+		nvmf_wait_for_state "${def_subsysnqn}" "live" || return 1
+		echo "state: $(cat $state_file)"
+	done
+
+	{ kill "${fio_pid}"; wait; } &> /dev/null
+
+	_nvme_disconnect_subsys
+
+	_nvmet_target_cleanup
+
+	echo "Test complete"
+}
diff --git a/tests/nvme/061.out b/tests/nvme/061.out
new file mode 100644
index 0000000000000000000000000000000000000000..75516abdac005854c2be165005c076ef8891c518
--- /dev/null
+++ b/tests/nvme/061.out
@@ -0,0 +1,21 @@
+Running nvme/061
+iteration 0
+state: connecting
+state: live
+iteration 1
+state: connecting
+state: live
+iteration 2
+state: connecting
+state: live
+iteration 3
+state: connecting
+state: live
+iteration 4
+state: connecting
+state: live
+iteration 5
+state: connecting
+state: live
+disconnected 1 controller(s)
+Test complete

-- 
2.48.1

