Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 706ED40DFA3
	for <linux-block@vger.kernel.org>; Sat, 28 Mar 2026 13:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774705815; cv=none; b=aoWFunQFu9NtRmC7YFl6epGZHUDJ5gkmtPptqfmTA6htgG8jWWtPU3zKVYN1GgobN5aN5tWYaFjljOGnaUelKzookcJjSFlwPLbMKqRvx0GKBTxqC8pwnpo624d9peLVer1cDZXdDfgWe9Hb6u9EN1FNEqXcR6mRClqxofAUlj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774705815; c=relaxed/simple;
	bh=LvwUwdfkY0NHa0bY7q2PUqxd53bHmTN4gYQDNR9yTd8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kKdrmoa7jQvcCJtwRA8VUTU2wwwYzMbRHh7EempCnUAZoyB3aZFJmaXu0kCR318y5GnZ7z+vBUvbgJ2TW2opYlh0Hs8WuXbwVEo/OkgY8aBqg0Ofu4HiNq50uyIAi5LWk6FWvb/H47Tehos6st/k8F77ZdZRx/nl/dR03YACIHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Dat9HYOl; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Dat9HYOl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774705813;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KCPjg4ijnwbcEDAWM/7pVv0jkE+67ycAJwEYBo2sgi0=;
	b=Dat9HYOlr95Va+/wjQUMLbyviYqvzzOAmRUsWcdiOIv32MC5zXAmMLQD2ivfLn8E7BQohX
	VsvLRKuqg7OUiJHdnGJG9AI+z/+hc3Edn4SFkKfADAdIRjb0s9WFUOMkFZbehbcGvs4b4+
	hFnqUBA4SGQPrk3IR+xMqxrXXvzneW0=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-613-aJnDiLOMOICjwhKemCue4g-1; Sat,
 28 Mar 2026 09:50:11 -0400
X-MC-Unique: aJnDiLOMOICjwhKemCue4g-1
X-Mimecast-MFC-AGG-ID: aJnDiLOMOICjwhKemCue4g_1774705811
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E3BC91800365;
	Sat, 28 Mar 2026 13:50:10 +0000 (UTC)
Received: from localhost (unknown [10.72.116.100])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id A3FE830001A1;
	Sat, 28 Mar 2026 13:50:09 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Caleb Sander Mateos <csander@purestorage.com>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 7/8] selftests/ublk: add hugetlbfs shmem_zc test for loop target
Date: Sat, 28 Mar 2026 21:49:02 +0800
Message-ID: <20260328134909.3207377-8-ming.lei@redhat.com>
In-Reply-To: <20260328134909.3207377-1-ming.lei@redhat.com>
References: <20260328134909.3207377-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Add test_shmem_zc_02.sh which tests the UBLK_IO_F_SHMEM_ZC zero-copy
path on the loop target using a hugetlbfs shared buffer. Both kublk and
fio mmap the same hugetlbfs file with MAP_SHARED, sharing physical
pages. The kernel's PFN matching enables zero-copy — the loop target
reads/writes directly from the shared buffer to the backing file.

Uses standard fio --mem=mmaphuge:<path> (supported since fio 1.10),
no patched fio required.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 tools/testing/selftests/ublk/Makefile         |  1 +
 .../testing/selftests/ublk/test_shmemzc_02.sh | 68 +++++++++++++++++++
 2 files changed, 69 insertions(+)
 create mode 100755 tools/testing/selftests/ublk/test_shmemzc_02.sh

diff --git a/tools/testing/selftests/ublk/Makefile b/tools/testing/selftests/ublk/Makefile
index 001b7dccf3c6..271fe11d8d0f 100644
--- a/tools/testing/selftests/ublk/Makefile
+++ b/tools/testing/selftests/ublk/Makefile
@@ -52,6 +52,7 @@ TEST_PROGS += test_part_01.sh
 TEST_PROGS += test_part_02.sh
 
 TEST_PROGS += test_shmemzc_01.sh
+TEST_PROGS += test_shmemzc_02.sh
 
 TEST_PROGS += test_stress_01.sh
 TEST_PROGS += test_stress_02.sh
diff --git a/tools/testing/selftests/ublk/test_shmemzc_02.sh b/tools/testing/selftests/ublk/test_shmemzc_02.sh
new file mode 100755
index 000000000000..aed9262494e9
--- /dev/null
+++ b/tools/testing/selftests/ublk/test_shmemzc_02.sh
@@ -0,0 +1,68 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Test: shmem_zc with hugetlbfs buffer on loop target
+#
+# kublk and fio both mmap the same hugetlbfs file (MAP_SHARED),
+# so they share physical pages.  The kernel PFN match enables
+# zero-copy I/O without socket-based fd passing.
+
+. "$(cd "$(dirname "$0")" && pwd)"/test_common.sh
+
+ERR_CODE=0
+
+_prep_test "shmem_zc" "loop target hugetlbfs shmem zero-copy test"
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
+_create_backfile 0 128M
+BACKFILE="${UBLK_BACKFILES[0]}"
+
+dev_id=$(_add_ublk_dev -t loop --shmem_zc --htlb "$HTLB_FILE" "$BACKFILE")
+_check_add_dev $TID $?
+
+_run_fio_verify_io --filename=/dev/ublkb"${dev_id}" \
+	--size=128M \
+	--mem=mmaphuge:"$HTLB_FILE"
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

