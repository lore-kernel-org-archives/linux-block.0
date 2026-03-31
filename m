Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6746B41C2F4
	for <linux-block@vger.kernel.org>; Tue, 31 Mar 2026 15:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774971189; cv=none; b=O36MRq1r/cxydUyUPuQiD1XHorCHmyv5h8ZH82gEa9BxmIhIMPAoEkV5UoWipzPmhXHB79PtcK29PPxJLBqFiceaxc5rxFaz2qmgRl90hKoHc+eJ4HfCXRqx6ep1CpashoYz2QENUzKEJsYilwTlkvAJjP7SearjDzPCDZGhZJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774971189; c=relaxed/simple;
	bh=pOtAcw2Xylmb5Jsh46ayF6ZRc0G1mq8AdjtsJh/neC4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kmREfHHGTHgRQk57QyBbetWNdxrVciEABxQvJXUbbt99f91SSf3SY/R8qAy9+jBssICqnw+wycDFP2BH99Q2Q+yUbmPFjGXJMrmaytM6FfpoJv5ip5TBFxH+bMPFu7tzuFqjM8dcY4VokTARlV+5ZOnjZFeM72gAu6R0a6lAxDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Bi0CDuj9; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Bi0CDuj9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774971175;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=avGyQ0a4uU15KXaiBgyAYyHCBb8/xL9NuxCKcruWjd0=;
	b=Bi0CDuj9QZKJyRlmKz8QUqZdepUhgCMHhLXFNbSti5bPFETmbsgR18wZ+vT2n4Q7VHwJ2t
	chaqtD2v6YQxXMyQx8i2l9+RtnOH/LT61UuvpsVxhyMhyxb90/XVDKvQUyIzwBdRIRfW01
	jIXZFMa7Aoa7277lTCNOlquWUljNzxM=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-120-3SBFMH8PO0GxUAt4Rn69gg-1; Tue,
 31 Mar 2026 11:32:52 -0400
X-MC-Unique: 3SBFMH8PO0GxUAt4Rn69gg-1
X-Mimecast-MFC-AGG-ID: 3SBFMH8PO0GxUAt4Rn69gg_1774971171
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 361FB19560B1;
	Tue, 31 Mar 2026 15:32:51 +0000 (UTC)
Received: from localhost (unknown [10.72.116.55])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 7C7031955F42;
	Tue, 31 Mar 2026 15:32:49 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Caleb Sander Mateos <csander@purestorage.com>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH v2 09/10] selftests/ublk: add filesystem fio verify test for shmem_zc
Date: Tue, 31 Mar 2026 23:32:00 +0800
Message-ID: <20260331153207.3635125-10-ming.lei@redhat.com>
In-Reply-To: <20260331153207.3635125-1-ming.lei@redhat.com>
References: <20260331153207.3635125-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Add test_shmemzc_03.sh which exercises shmem_zc through the full
filesystem stack: mkfs ext4 on the ublk device, mount it, then run
fio verify on a file inside the filesystem with --mem=mmaphuge.

Extend _mkfs_mount_test() to accept an optional command that runs
between mount and umount. The function cd's into the mount directory
so the command can use relative file paths. Existing callers that
pass only the device are unaffected.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 tools/testing/selftests/ublk/Makefile         |  1 +
 tools/testing/selftests/ublk/test_common.sh   | 15 ++--
 .../testing/selftests/ublk/test_shmemzc_03.sh | 69 +++++++++++++++++++
 3 files changed, 81 insertions(+), 4 deletions(-)
 create mode 100755 tools/testing/selftests/ublk/test_shmemzc_03.sh

diff --git a/tools/testing/selftests/ublk/Makefile b/tools/testing/selftests/ublk/Makefile
index 271fe11d8d0f..3d1ad1730d93 100644
--- a/tools/testing/selftests/ublk/Makefile
+++ b/tools/testing/selftests/ublk/Makefile
@@ -53,6 +53,7 @@ TEST_PROGS += test_part_02.sh
 
 TEST_PROGS += test_shmemzc_01.sh
 TEST_PROGS += test_shmemzc_02.sh
+TEST_PROGS += test_shmemzc_03.sh
 
 TEST_PROGS += test_stress_01.sh
 TEST_PROGS += test_stress_02.sh
diff --git a/tools/testing/selftests/ublk/test_common.sh b/tools/testing/selftests/ublk/test_common.sh
index 163a40007910..af2ea4fa1111 100755
--- a/tools/testing/selftests/ublk/test_common.sh
+++ b/tools/testing/selftests/ublk/test_common.sh
@@ -88,6 +88,7 @@ _remove_tmp_dir() {
 _mkfs_mount_test()
 {
 	local dev=$1
+	shift
 	local err_code=0
 	local mnt_dir;
 
@@ -99,12 +100,17 @@ _mkfs_mount_test()
 	fi
 
 	mount -t ext4 "$dev" "$mnt_dir" > /dev/null 2>&1
+	if [ $# -gt 0 ]; then
+		cd "$mnt_dir" && "$@"
+		err_code=$?
+		cd - > /dev/null
+	fi
 	umount "$dev"
-	err_code=$?
-	_remove_tmp_dir "$mnt_dir"
-	if [ $err_code -ne 0 ]; then
-		return $err_code
+	if [ $err_code -eq 0 ]; then
+		err_code=$?
 	fi
+	_remove_tmp_dir "$mnt_dir"
+	return $err_code
 }
 
 _check_root() {
@@ -132,6 +138,7 @@ _prep_test() {
 	local base_dir=${TMPDIR:-./ublktest-dir}
 	mkdir -p "$base_dir"
 	UBLK_TEST_DIR=$(mktemp -d ${base_dir}/${TID}.XXXXXX)
+	UBLK_TEST_DIR=$(realpath ${UBLK_TEST_DIR})
 	UBLK_TMP=$(mktemp ${UBLK_TEST_DIR}/ublk_test_XXXXX)
 	[ "$UBLK_TEST_QUIET" -eq 0 ] && echo "ublk $type: $*"
 	echo "ublk selftest: $TID starting at $(date '+%F %T')" | tee /dev/kmsg
diff --git a/tools/testing/selftests/ublk/test_shmemzc_03.sh b/tools/testing/selftests/ublk/test_shmemzc_03.sh
new file mode 100755
index 000000000000..db967a9ffe81
--- /dev/null
+++ b/tools/testing/selftests/ublk/test_shmemzc_03.sh
@@ -0,0 +1,69 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Test: shmem_zc with fio verify over filesystem on loop target
+#
+# mkfs + mount ext4 on the ublk device, then run fio verify on a
+# file inside that filesystem.  Exercises the full stack:
+# filesystem -> block layer -> ublk shmem_zc -> loop target backing file.
+
+. "$(cd "$(dirname "$0")" && pwd)"/test_common.sh
+
+ERR_CODE=0
+
+_prep_test "shmem_zc" "loop target hugetlbfs shmem zero-copy fs verify test"
+
+if ! _have_program fio; then
+	echo "SKIP: fio not available"
+	exit "$UBLK_SKIP_CODE"
+fi
+
+if ! grep -q hugetlbfs /proc/filesystems; then
+	echo "SKIP: hugetlbfs not supported"
+	exit "$UBLK_SKIP_CODE"
+fi
+
+# Allocate hugepages
+OLD_NR_HP=$(cat /proc/sys/vm/nr_hugepages)
+echo 10 > /proc/sys/vm/nr_hugepages
+NR_HP=$(cat /proc/sys/vm/nr_hugepages)
+if [ "$NR_HP" -lt 2 ]; then
+	echo "SKIP: cannot allocate hugepages"
+	echo "$OLD_NR_HP" > /proc/sys/vm/nr_hugepages
+	exit "$UBLK_SKIP_CODE"
+fi
+
+# Mount hugetlbfs
+HTLB_MNT=$(mktemp -d "${UBLK_TEST_DIR}/htlb_mnt_XXXXXX")
+if ! mount -t hugetlbfs none "$HTLB_MNT"; then
+	echo "SKIP: cannot mount hugetlbfs"
+	rmdir "$HTLB_MNT"
+	echo "$OLD_NR_HP" > /proc/sys/vm/nr_hugepages
+	exit "$UBLK_SKIP_CODE"
+fi
+
+HTLB_FILE="$HTLB_MNT/ublk_buf"
+fallocate -l 4M "$HTLB_FILE"
+
+_create_backfile 0 256M
+BACKFILE="${UBLK_BACKFILES[0]}"
+
+dev_id=$(_add_ublk_dev -t loop --shmem_zc --htlb "$HTLB_FILE" "$BACKFILE")
+_check_add_dev $TID $?
+
+_mkfs_mount_test /dev/ublkb"${dev_id}" \
+	_run_fio_verify_io --filename=testfile \
+		--size=128M \
+		--mem=mmaphuge:"$HTLB_FILE"
+ERR_CODE=$?
+
+# Delete device first so daemon releases the htlb mmap
+_ublk_del_dev "${dev_id}"
+
+rm -f "$HTLB_FILE"
+umount "$HTLB_MNT"
+rmdir "$HTLB_MNT"
+echo "$OLD_NR_HP" > /proc/sys/vm/nr_hugepages
+
+_cleanup_test "shmem_zc"
+
+_show_result $TID $ERR_CODE
-- 
2.53.0

