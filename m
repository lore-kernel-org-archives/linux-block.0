Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA58A78F58
	for <linux-block@vger.kernel.org>; Wed,  2 Apr 2025 04:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743567288; cv=none; b=BSKpVpiV6CVPLRd33ggfX4Hg6iBwDDKDj5vGYbTf3Zuokcd35Y81Lpfb6ZTsMYwqfRq8BG04WCgaZM71Ok6IUnM0FbHNL7nKRgU5pMmZqui0fNR9xbE6zsm6WuW0nAg7Tmfpt93s6OjlHD8tuB5pAs4herJ0ZRMDbA/5mUvomlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743567288; c=relaxed/simple;
	bh=5hONtpmRNUyPK4dP1g+RfmfKZ5ZwrU7tnKN1AR2fMDM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TdpRDcRL6lyzKxPcPgVQRZPQ+B2nTAkYbJZlloByYuh3oEJyxyJ/3R+6aHFrFUDANUrL9Vyxu308BYvsb//eNOHYXnz7DTwqfhrOhFWf+8xhDRm4bo6L9WWLS0pm1Fo7DQ01RB5zxb+rz3SDdhaLG1UNx9/mxDqo1JCdN+va0LI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DOBtLUlh; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DOBtLUlh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743567285;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=A70mzkVoJ9pfEq4RRHkhmn75Iklh4asHbKzosiOmjb0=;
	b=DOBtLUlhNiuXIJLCuQU8CHvm8XZTB5af9tsLT/1GLax7MDP2CLZdh8SHQlbtYwibYEwU0Y
	KUSSN4rE7axc9w3cQX0dEUsehmbbTHN4eOGoyRyjD6j5bOsX9+phgnCgxA0T0LGpgWxQbm
	LQWZcJnDeeXllIIEj26jsrsXlvzEq8k=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-316-CCPDpLsQOfiNmhS-YjocxQ-1; Wed,
 02 Apr 2025 00:14:40 -0400
X-MC-Unique: CCPDpLsQOfiNmhS-YjocxQ-1
X-Mimecast-MFC-AGG-ID: CCPDpLsQOfiNmhS-YjocxQ_1743567279
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id AE25719560AB;
	Wed,  2 Apr 2025 04:14:39 +0000 (UTC)
Received: from localhost (unknown [10.72.120.17])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 723E5195609D;
	Wed,  2 Apr 2025 04:14:37 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: linux-block@vger.kernel.org,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH] blktests: add block/039 for test updating nr_hw_queues vs switching elevator
Date: Wed,  2 Apr 2025 12:14:29 +0800
Message-ID: <20250402041429.942623-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Add block/039 for covering updating nr_hw_queues and switching elevator.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 tests/block/039     | 67 +++++++++++++++++++++++++++++++++++++++++++++
 tests/block/039.out |  1 +
 2 files changed, 68 insertions(+)
 create mode 100755 tests/block/039
 create mode 100644 tests/block/039.out

diff --git a/tests/block/039 b/tests/block/039
new file mode 100755
index 0000000..d29db45
--- /dev/null
+++ b/tests/block/039
@@ -0,0 +1,67 @@
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
+	_have_fio && _have_null_blk
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
+			echo "$sched" > /sys/block/"$dev"/queue/scheduler > /dev/null 2>&1
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
+		    --output="${RESULTS_DIR}/block/fio-output-029.txt" \
+		    >>"$FULL"
+		wait
+	else
+		echo "Skipping test because $sq cannot be modified" >>"$FULL"
+	fi
+	_exit_null_blk
+	echo Passed
+}
diff --git a/tests/block/039.out b/tests/block/039.out
new file mode 100644
index 0000000..863339f
--- /dev/null
+++ b/tests/block/039.out
@@ -0,0 +1 @@
+Passed
-- 
2.44.0

