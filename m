Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82A04255E21
	for <linux-block@vger.kernel.org>; Mon, 24 Feb 2025 10:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740391203; cv=none; b=mGqzpIxSLfhUibvP7pm9v41gr7aSOAbGrepEcnpgQWGYO3OhQ4xpvpqpLTNnPRu8lJdohURWVAsEQjiSoL5C9D65mfuVP92IOq1FnzEWxjCLxUm2HQ8XWNZ7mHl2AXTA4AeMYiHyr/xSOVWSsrorQ/yAEARDMg/zx/o/p5lr4/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740391203; c=relaxed/simple;
	bh=gm+yihZCzgde+pWWjtds6/mCNUCGRa0PDZ1471s986I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Q/czyRFZCgmJEC3LT2BOBb0NgF50yKaCz2SvhagVwfRPHl5vdd2P6rPHefEe5PrZiGzxTefaCDDArFJXdsL4URybvzOHQxBWoEtw6UX7Aus3HVCls+QZ6xTakd8Y+0v/+7lntC/rhvLP/EmDctNwECCOR1R6V1IbZeoGNNQx9yM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CnXCsxc8; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CnXCsxc8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740391200;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=6L+Qyy0sQBzRDx6vB86O556jHBJgVJTblXX5aPNNvqE=;
	b=CnXCsxc8h9jhQDhFg9UgyQ9Xmg2jGNtZzJh3mBTSg9HqH35zasC4QXBxObmtpbnpvCSTCH
	+kZGiPdolm/enCu0RyAVTxCKGTqVY9pETpNYbwvCRAR9TMlmUsTSxzgUX/K5cazgIkCl94
	UDWOGLJdnf3j7OMksHSoHon02cxPvg4=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-549-VBz1cQ5gPiyThw5xFXiRMA-1; Mon,
 24 Feb 2025 04:59:54 -0500
X-MC-Unique: VBz1cQ5gPiyThw5xFXiRMA-1
X-Mimecast-MFC-AGG-ID: VBz1cQ5gPiyThw5xFXiRMA_1740391194
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BF0001800570;
	Mon, 24 Feb 2025 09:59:53 +0000 (UTC)
Received: from localhost (unknown [10.72.120.33])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 5827D1800366;
	Mon, 24 Feb 2025 09:59:51 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: linux-block@vger.kernel.org,
	Ming Lei <ming.lei@redhat.com>,
	Yu Kuai <yukuai1@huaweicloud.com>
Subject: [PATCH] tests/throtl: add a new test 006
Date: Mon, 24 Feb 2025 17:59:45 +0800
Message-ID: <20250224095945.1994997-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

Add test for covering prioritized meta IO when throttling, regression
test for commit 29390bb5661d ("blk-throttle: support prioritized processing
of metadata").

Cc: Yu Kuai <yukuai1@huaweicloud.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 tests/throtl/006     | 58 ++++++++++++++++++++++++++++++++++++++++++++
 tests/throtl/006.out |  4 +++
 tests/throtl/rc      | 19 +++++++++++++++
 3 files changed, 81 insertions(+)
 create mode 100755 tests/throtl/006
 create mode 100644 tests/throtl/006.out

diff --git a/tests/throtl/006 b/tests/throtl/006
new file mode 100755
index 0000000..4baadaf
--- /dev/null
+++ b/tests/throtl/006
@@ -0,0 +1,58 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-3.0+
+# Copyright (C) 2025 Ming Lei
+#
+# Test prioritized meta IO when IO throttling, regression test for
+# commit 29390bb5661d ("blk-throttle: support prioritized processing of metadata")
+
+. tests/throtl/rc
+
+DESCRIPTION="test if meta IO has higher priority than data IO"
+QUICK=1
+
+requires() {
+	_have_program mkfs.ext4
+}
+
+test_meta_io() {
+	local path="$1"
+	local start_time
+	local end_time
+	local elapsed
+
+	start_time=$(date +%s.%N)
+	mkdir "${path}"/xxx
+	touch "${path}"/xxx/1
+	sync "${path}"/xxx
+
+	end_time=$(date +%s.%N)
+	elapsed=$(echo "$end_time - $start_time" | bc)
+	printf "%.0f\n" "$elapsed"
+}
+
+test() {
+	echo "Running ${TEST_NAME}"
+
+	if ! _set_up_throtl memory_backed=1; then
+		return 1;
+	fi
+
+	mkdir -p "${TMPDIR}/mnt"
+	mkfs.ext4 -E lazy_itable_init=0,lazy_journal_init=0 -F "/dev/${THROTL_DEV}" >> "$FULL" 2>&1
+	mount "/dev/${THROTL_DEV}" "${TMPDIR}/mnt" >> "$FULL" 2>&1
+
+	_throtl_set_limits wbps=$((1024 * 1024))
+	{
+		echo "$BASHPID" > "$CGROUP2_DIR/$THROTL_DIR/cgroup.procs"
+		_throtl_issue_fs_io  "${TMPDIR}/mnt/test.img" write 64K 64 &
+		sleep 2
+		test_meta_io "${TMPDIR}/mnt"
+		wait
+	} &
+	wait $!
+
+	umount "${TMPDIR}/mnt" || return $?
+	_throtl_remove_limits
+	_clean_up_throtl
+	echo "Test complete"
+}
diff --git a/tests/throtl/006.out b/tests/throtl/006.out
new file mode 100644
index 0000000..8c3d176
--- /dev/null
+++ b/tests/throtl/006.out
@@ -0,0 +1,4 @@
+Running throtl/006
+0
+4
+Test complete
diff --git a/tests/throtl/rc b/tests/throtl/rc
index df54cb9..327084b 100644
--- a/tests/throtl/rc
+++ b/tests/throtl/rc
@@ -75,6 +75,25 @@ _throtl_get_max_io_size() {
 	cat "/sys/block/$THROTL_DEV/queue/max_sectors_kb"
 }
 
+_throtl_issue_fs_io() {
+	local path=$1
+	local start_time
+	local end_time
+	local elapsed
+
+	start_time=$(date +%s.%N)
+
+	if [ "$2" == "read" ]; then
+		dd if="${path}" of=/dev/null bs="$3" count="$4" iflag=direct status=none
+	elif [ "$2" == "write" ]; then
+		dd of="${path}" if=/dev/zero bs="$3" count="$4" oflag=direct conv=fdatasync status=none
+	fi
+
+	end_time=$(date +%s.%N)
+	elapsed=$(echo "$end_time - $start_time" | bc)
+	printf "%.0f\n" "$elapsed"
+}
+
 _throtl_issue_io() {
 	local start_time
 	local end_time
-- 
2.47.1

