Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9187424EF7F
	for <linux-block@vger.kernel.org>; Wed,  2 Jul 2025 10:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.153.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751450982; cv=none; b=ZGq5peKpXbKLE6bBDUpAUdjqb2Aq1Ll8IL6AWu0IJs0Cr7QQfr+Ntvk4+Ap1hIfRVV3PHX8bOfYt7ufr1gBAHNMnwkNhmOSAInVT08rEg3A2vODKE6vwniyE5baethzfLyoc2EMBtFmxTjLmqW3WaGUMirSI14RCKj8HN9t+cJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751450982; c=relaxed/simple;
	bh=eCffJVRAobOuZBcjrH9bwiDLqn3v3rqZ4hifQuwBfgQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FadZ7laNB0VjlvzwshrB2Q6FqGN+EV2j6GkYy5jpXMy/EzoFrzQmemP57a6UyBYzviR81dD5I0REZ4LkXORmQ8L9VJzSVshvzbvWNNh24dbmYk5RMnLehyIH9WSkBKgzZK3DsUew0zTQr4t55+xsxk4z/mv9j6Y4YciblbNIoPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=Wr89g30T; arc=none smtp.client-ip=216.71.153.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Wr89g30T"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1751450981; x=1782986981;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=eCffJVRAobOuZBcjrH9bwiDLqn3v3rqZ4hifQuwBfgQ=;
  b=Wr89g30Tljx7cXFyX3XvXmzUzTQRPToYkCobZwpiybAmKf9pR1my+G0n
   Eh1h5u2B9VbMEhxYLLlPeBFDThh/fUgVszr5fYGOKpSjruE5Ca5m4Ea2W
   R027FxAymKy8zjiP5cgVKEUIRP9ZRZqPLitVjaM/UWwsq0pn/gFZFHpd/
   Ds8g6TV63Ud/7clySyL4Ba0jXoFPf0nwuPJGwTMphSsJy2DxMN47ap2K2
   vPGh0pK73+oX4g+Hk3R3Z1uUYXSg53TGqggv9PUHVSu3I5U1PKgetqLM/
   zC5UBTERvn0h60O0NV7Iq+3Lwa0hOK866XVXS8YqG9kTG/xksCt+6Ah5E
   A==;
X-CSE-ConnectionGUID: sV1E7ZTdTJ+CCIi38wwDAQ==
X-CSE-MsgGUID: e53QyBiLQv6yKxUTQE05/Q==
X-IronPort-AV: E=Sophos;i="6.16,281,1744041600"; 
   d="scan'208";a="86384535"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 02 Jul 2025 18:09:35 +0800
IronPort-SDR: 6864f6d3_uK6lyEtoR/9xtawt7bLhJYoF8R/xgC5+9OBMiMm+j8SeQ5L
 92HmYHlOx6AYNs+9TM/Wi4nwBJWku0E9EOvLdbw==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 02 Jul 2025 02:07:31 -0700
WDCIronportException: Internal
Received: from 5cg0390ply.ad.shared (HELO shinmob.wdc.com) ([10.224.173.22])
  by uls-op-cesaip02.wdc.com with ESMTP; 02 Jul 2025 03:09:34 -0700
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-block@vger.kernel.org
Cc: Ming Lei <ming.lei@redhat.com>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH blktests v2] block: add block/040 for test updating nr_hw_queues vs switching elevator
Date: Wed,  2 Jul 2025 19:09:32 +0900
Message-ID: <20250702100932.647761-1-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ming Lei <ming.lei@redhat.com>

Add block/040 for covering updating nr_hw_queues and switching elevator.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
[Shin'ichiro: fixed redirection to scheduler file and skip reason check]
[Shin'ichiro: renumbered test case]
Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
I take the liberty to modify the original patch by Ming [1] to reflect my
review comments. The new test case had caused hang with the v6.15-rcX
kernel. Now it works good with the v6.16-rcX kernel. Thank you for the
fix work.

[1] https://lore.kernel.org/linux-block/20250402041429.942623-1-ming.lei@redhat.com/

Changes from v1:
* Renumbered the test case from block/039 to block/040
* Fixed redirection to queue/scheduler
* Fixed skip reason reporting
* Removed && in requires()
* Renamed fio output file

 tests/block/040     | 71 +++++++++++++++++++++++++++++++++++++++++++++
 tests/block/040.out |  1 +
 2 files changed, 72 insertions(+)
 create mode 100755 tests/block/040
 create mode 100644 tests/block/040.out

diff --git a/tests/block/040 b/tests/block/040
new file mode 100755
index 0000000..fbc433a
--- /dev/null
+++ b/tests/block/040
@@ -0,0 +1,71 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright 2025 Ming Lei <ming.lei@redhat.com>
+#
+# Most of code is copied from block/029
+#
+# Trigger blk_mq_update_nr_hw_queues() & elevator switch
+
+. tests/block/rc
+. common/null_blk
+
+DESCRIPTION="test blk_mq_update_nr_hw_queues() vs switch elevator"
+QUICK=1
+
+requires() {
+	_have_fio
+	_have_null_blk
+}
+
+
+modify_io_sched() {
+	local deadline
+	local dev=$1
+
+	deadline=$(($(_uptime_s) + TIMEOUT))
+	while [ "$(_uptime_s)" -lt "$deadline" ]; do
+		for sched in $(_io_schedulers "$dev"); do
+			{ echo "$sched" > /sys/block/"$dev"/queue/scheduler ;} \
+				&> /dev/null
+			sleep .5
+		done
+	done
+}
+
+modify_nr_hw_queues() {
+	local deadline num_cpus
+
+	deadline=$(($(_uptime_s) + TIMEOUT))
+	num_cpus=$(nproc)
+	while [ "$(_uptime_s)" -lt "$deadline" ]; do
+		sleep .1
+		echo 1 > /sys/kernel/config/nullb/nullb1/submit_queues
+		sleep .1
+		echo "$num_cpus" > /sys/kernel/config/nullb/nullb1/submit_queues
+	done
+}
+
+test() {
+	local sq=/sys/kernel/config/nullb/nullb1/submit_queues
+
+	: "${TIMEOUT:=30}"
+	_configure_null_blk nullb1 completion_nsec=0 blocksize=512 \
+			    size=16 memory_backed=1 power=1 &&
+	if { echo 1 >$sq; } 2>/dev/null; then
+		modify_nr_hw_queues &
+		modify_io_sched nullb1 &
+		fio --rw=randwrite --bs=4K --loops=$((10**6)) \
+		    --iodepth=64 --group_reporting --sync=1 --direct=1 \
+		    --ioengine=libaio --filename="/dev/nullb1" \
+		    --runtime="${TIMEOUT}" --name=nullb1 \
+		    --output="${RESULTS_DIR}/block/fio-output-040.txt" \
+		    >>"$FULL"
+		wait
+	else
+		SKIP_REASONS+=("$sq cannot be modified")
+		_exit_null_blk
+		return
+	fi
+	_exit_null_blk
+	echo Passed
+}
diff --git a/tests/block/040.out b/tests/block/040.out
new file mode 100644
index 0000000..863339f
--- /dev/null
+++ b/tests/block/040.out
@@ -0,0 +1 @@
+Passed
-- 
2.50.0

