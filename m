Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E7022D0A54
	for <linux-block@vger.kernel.org>; Mon, 14 Apr 2025 14:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744639564; cv=none; b=D/P1QW2xaWT2UxawZ6VWVmgHW9fHIpp9uct4Cbl6lUNe31LpQ5MmfegDMF7yRaAOmbnz+l9k71q+YuFkqVk573nqQR/UxzE08ulmdS3VZnX3a/aKjV5zxCKS0JuGsPetaDkdchVch4IZh5u/Y8vJ+wlDVRfYR/aWmS9QrsDQc7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744639564; c=relaxed/simple;
	bh=7Sv5aVE5FdxcIGCABFX+xyDVu2hjevPjbLV0GYczMcw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XZyLJ2AYYBgwo1i0C+7kMdCuSHA4pCq1lyq+r5enC1f7NvIDK09vTcC1eNfOD6P3RF7dUZrqBZxyhHLCih0TnZfxdrAsWu9DHoCsO4gg+7/QBSSrkTy+cIvz3QxjZ36txwwAXs44rR7A+gUoj+mtfqhugWdq3k1OFTjPK6t/b3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a3RUhNSR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a3RUhNSR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F68DC4CEE2;
	Mon, 14 Apr 2025 14:06:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744639563;
	bh=7Sv5aVE5FdxcIGCABFX+xyDVu2hjevPjbLV0GYczMcw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=a3RUhNSRbTQn3B2Jd8P8KMmK+APQFaa2WnHEQY19PKk9cwIavICyY+jcIWobNkO+5
	 PmXV8Xed6AZhCRq2zndtrq0Rrw2ZEhffWG0MtWs1Igm+XUHDrqFXUzUIficNthTVKl
	 sQE/v5lAIwpflGxLh5fjhE4IhfV+O41w/bxa3kYwtZxfd0GXmZ2+XiulbMqZ3iQR3z
	 1jUAQy4hNJoaKGU5LKVuZzxeoJixD6LZ2x59pncuG7CE2Pws54Sjgu9TUgwfoEFMUl
	 0fxjW3BtuW/DsMc5huk2GRGQGXA70sw9fFIRqGWvfuOJCysl+IQegM6tecBFosHMx8
	 7zpoiWreSQhZw==
From: Daniel Wagner <wagi@kernel.org>
Date: Mon, 14 Apr 2025 16:05:53 +0200
Subject: [PATCH blktests v3 4/4] nvme/061: add test teardown and setup
 fabrics target during I/O
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250414-test-target-v3-4-024575fcec06@kernel.org>
References: <20250414-test-target-v3-0-024575fcec06@kernel.org>
In-Reply-To: <20250414-test-target-v3-0-024575fcec06@kernel.org>
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: Chaitanya Kulkarni <kch@nvidia.com>, linux-block@vger.kernel.org, 
 Daniel Wagner <wagi@kernel.org>
X-Mailer: b4 0.14.2

Add a new test case which forcefully removes the target and setup it
again.

Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
Signed-off-by: Daniel Wagner <wagi@kernel.org>
---
 tests/nvme/061     | 66 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/nvme/061.out | 21 +++++++++++++++++
 2 files changed, 87 insertions(+)

diff --git a/tests/nvme/061 b/tests/nvme/061
new file mode 100755
index 0000000000000000000000000000000000000000..c22046a6f547ea3325e2f5bdd6fed807f445391d
--- /dev/null
+++ b/tests/nvme/061
@@ -0,0 +1,66 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-3.0+
+# Copyright (C) 2025 Daniel Wagner, SUSE Labs
+#
+# Test if the host keeps running IO when the target is forcefully removed and
+# added back.
+
+. tests/nvme/rc
+
+DESCRIPTION="test fabric target teardown and setup during I/O"
+TIMED=1
+
+requires() {
+	_nvme_requires
+	_have_loop
+	_have_fio
+	_require_nvme_trtype tcp rdma fc
+}
+
+set_conditions() {
+	_set_nvme_trtype "$@"
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
+		_nvmf_wait_for_state "${def_subsysnqn}" "connecting" || return 1
+		echo "state: $(cat "${state_file}")"
+
+		_nvmet_target_setup
+
+		_nvmf_wait_for_state "${def_subsysnqn}" "live" || return 1
+		echo "state: $(cat "${state_file}")"
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
2.49.0

