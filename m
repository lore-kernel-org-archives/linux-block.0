Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 252B234CD5
	for <linux-block@vger.kernel.org>; Sun,  7 Apr 2024 12:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712494652; cv=none; b=QWsPGNxtQsivR7JJKUAILhH4Ucz1QlnGPpVcmUhSzG7Ch1BbihRcATNdPtGgFcDM80o+rWBZ/oVvXTaxlVo1ViaOq7MTN7+v7vPibfV0BlYrtsmI/Z85Ipmj7cPZBU2abeYuktjr0UTMLqLIfE0QNXlEeDhnzne+hsHDGRsQe9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712494652; c=relaxed/simple;
	bh=XxcxhhcGsaMwdC9AnrpW/ZYGkVeOfSvHxjczmROLsZU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iNkQFVy7giJOfdtJ3glTrDemOTl+B/wQvLuhArTvU4+3ezzjpOHlBRUxrE8HuzgA4+SO/As+kHPm6GPC+amJe15XtewIMrvQZXTjFc6m8AVQ4gGmIPxl331jzgNQn6SbODi0Af2b71uGyjDIBGKHLyEIQLpEmR8B3QVwGPcKYvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BJOCPMMM; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BJOCPMMM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712494649;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=szymyODjETFv2c66DXuyP5VwSQTNs1pd2/QW68OU2L0=;
	b=BJOCPMMMR9v671E7KP6b7SjC5RHKWlL6uAed/AizZnXuFdk4NP2W1A9FYR6rp/2YJz9vjT
	k+zPPeEJO9BoYayDWT33AUFx2tIa0yyLEI2m1LcYoh1F2Zj/5mJmtKBZyiDcP579G64GQ7
	JPn+aUIlLQnrdFuucBboTYyVjSJ5/2c=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-657-I9f6_Zv8N6ujyw7CS758Ig-1; Sun, 07 Apr 2024 08:57:27 -0400
X-MC-Unique: I9f6_Zv8N6ujyw7CS758Ig-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6221C1887316;
	Sun,  7 Apr 2024 12:57:27 +0000 (UTC)
Received: from localhost (unknown [10.72.116.148])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 6DC7823D61;
	Sun,  7 Apr 2024 12:57:26 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: linux-block@vger.kernel.org,
	Ming Lei <ming.lei@redhat.com>,
	Changhui Zhong <czhong@redhat.com>
Subject: [PATCH] block/035: add test to cover blk-cgroup vs. disk rebind
Date: Sun,  7 Apr 2024 20:57:17 +0800
Message-ID: <20240407125717.4052964-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5

Recently it is observed that list corruption is triggered when running
scsi disk rebind in case of blk-cgroup.

Add one such test case for covering this unusual operation.

Cc: Changhui Zhong <czhong@redhat.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 tests/block/035     | 54 +++++++++++++++++++++++++++++++++++++++++++++
 tests/block/035.out |  2 ++
 2 files changed, 56 insertions(+)
 create mode 100755 tests/block/035
 create mode 100644 tests/block/035.out

diff --git a/tests/block/035 b/tests/block/035
new file mode 100755
index 0000000..a1057a3
--- /dev/null
+++ b/tests/block/035
@@ -0,0 +1,54 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-3.0+
+# Copyright (C) 2024 Ming Lei
+#
+# blk-cgroup is usually initialized in disk allocation code, and
+# de-initialized in disk release code. And scsi disk rebind needs
+# to re-allocate/re-add disk, meantime request queue is kept as
+# live during the whole cycle.
+#
+# Add this test for covering blk-cgroup & disk rebind.
+
+. tests/block/rc
+. common/scsi_debug
+. common/cgroup
+
+DESCRIPTION="test cgroup vs. scsi_debug rebind"
+QUICK=1
+
+requires() {
+	_have_cgroup2_controller io
+	_have_scsi_debug
+	_have_fio
+}
+
+scsi_debug_rebind() {
+	if ! _configure_scsi_debug; then
+		return
+	fi
+
+	_init_cgroup2
+
+	echo "+io" > "/sys/fs/cgroup/cgroup.subtree_control"
+	echo "+io" > "$CGROUP2_DIR/cgroup.subtree_control"
+	mkdir -p "$CGROUP2_DIR/${TEST_NAME}"
+
+	local dev dev_path hctl
+	dev=${SCSI_DEBUG_DEVICES[0]}
+	dev_path="$(realpath "/sys/block/${dev}/device")"
+	hctl="$(basename "$dev_path")"
+
+	echo -n "${hctl}" > "/sys/bus/scsi/drivers/sd/unbind"
+	echo -n "${hctl}" > "/sys/bus/scsi/drivers/sd/bind"
+
+	_exit_cgroup2
+	_exit_scsi_debug
+}
+
+test() {
+	echo "Running ${TEST_NAME}"
+
+	scsi_debug_rebind
+
+	echo "Test complete"
+}
diff --git a/tests/block/035.out b/tests/block/035.out
new file mode 100644
index 0000000..6ffa504
--- /dev/null
+++ b/tests/block/035.out
@@ -0,0 +1,2 @@
+Running block/035
+Test complete
-- 
2.41.0

