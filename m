Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A505422C35B
	for <linux-block@vger.kernel.org>; Tue,  8 Apr 2025 16:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744129578; cv=none; b=i54V0otXqIOxCq3dufYaHDKDY0SjszRe1G0zK2sIx+0gCfACK/d+MpdGVANZM03gXtbVUKpCaIB1dGfPQRGedOAiWz55T8erkZX5AKr05b4flCBNV7JCHPewrHqGPmMVVnJu3VXT9DmaSvFm3bMuYN/eMAAXXSOPJzMOGfOxUzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744129578; c=relaxed/simple;
	bh=Fy2gKQJl6FrHnMtBkqmsewmjBpzja8at40mpcZyQCRw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RJDxPOG3NalHAxusV3Rb83En4Kmks3zCBXhbg5iB3crxlDQgQu3a03lmlSfTtiRwsifk0bsFQ9il7NnD/5Bvf+EOJS+s7bs5N49X1+jJpza9edfX93DFnqznSYiwUrh9m4HLeFUXU0pWhL3+KVuHmnUqi1xBorjL5SHFJGBXYY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RDSP+SEg; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RDSP+SEg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2E80C4CEEB;
	Tue,  8 Apr 2025 16:26:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744129577;
	bh=Fy2gKQJl6FrHnMtBkqmsewmjBpzja8at40mpcZyQCRw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=RDSP+SEgyVFUeXjL+bJ1RbtY/hkon4ukeoLvfBrtH91I8z0E55+4Z0ae7uCHJp0uo
	 N20dzC/muNCNvtEQpct3ro7/+spekSw7eufYyRF6CAWyq9SIuNOD7dXjxJqbrUdyPI
	 nW+ChAOT3ESn/YPE8yMMm8bOl3qZKriJwbaCT9NVblzNz6YGL4s2T/ZZ91dqqVqSc3
	 MoE0oE0xfIv/OYxra6378jYtfQeAqb4ZFh+PDWdMkeZlTSUSIopxBSqEpvt3r5zTtG
	 dh92/61CKnzlhSqQC6JslGin+Dr0FEWsSy64nePDjLjvo3E//C97+tR2IZ2qB/NVSv
	 Fj9uA/nNCzROg==
From: Daniel Wagner <wagi@kernel.org>
Date: Tue, 08 Apr 2025 18:26:00 +0200
Subject: [PATCH blktests v2 4/4] nvme/061: add test teardown and setup
 fabrics target during I/O
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250408-test-target-v2-4-e9e2512586f8@kernel.org>
References: <20250408-test-target-v2-0-e9e2512586f8@kernel.org>
In-Reply-To: <20250408-test-target-v2-0-e9e2512586f8@kernel.org>
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
index 0000000000000000000000000000000000000000..3b59d7137932258d06c3d64166db493df176ba4e
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
+	_require_nvme_trtype_is_fabrics
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
+		echo "state: $(cat ${state_file})"
+
+		_nvmet_target_setup
+
+		_nvmf_wait_for_state "${def_subsysnqn}" "live" || return 1
+		echo "state: $(cat ${state_file})"
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

