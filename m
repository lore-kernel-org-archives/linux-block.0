Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 424A140DFA3
	for <linux-block@vger.kernel.org>; Sat, 28 Mar 2026 13:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774705801; cv=none; b=D+uqpf/VBSPbb6CpEN5WEtFaWlB46qvGafQQdkNmMoDhAzcXQgZU/k2xVCO1Jvg71ZMVWnCY2UswqUjeGGQM1s8BbbZ10E6y/zmVVV8cmC9uWOdnvaAVgG5v1P7q2+FVUsj5v94fU6lIt+ncGbQHZKZHnu/WFYGB32lNcUOAIOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774705801; c=relaxed/simple;
	bh=gLqGZaIvuI9W61nRVMemrKdmsMRPdgFAyAAFiYrtR68=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U0Rn0QFOVNnvjBjFB+kRuBpTL+RBcagud3KF5C4e1Epgp3BhH/4kOWOGc62cqIgIEwnP6eC3y0GnVyNiysY2Efavh/3w7X/RxZ03R26C3UPQahJB2ISKEqIrx7GwgeZEJfbIO3bXUk/MO/hwH/264NCcogBbEJ6MATL4hvpXVfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EfoxZEzs; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EfoxZEzs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774705799;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nnp4DZZaJA7P7oCJBmeimBW5M0m6C/JrtYMNIZUDsPY=;
	b=EfoxZEzsGLtnKw7Fc4R3VZzYvYxTmy1mYFV24Q6I1RLsuyNXaBYsRy3VtWsrca0m/5xFRR
	PlFYIQMbV64U4r0hvavRHbsNcCwLGsEr5dXpa0gBYXhLVWrHmWBdlJDdrgEnnkf1tQw7Ag
	gAkcQMVADroNY2Ui9xvmNPhfU7qhJps=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-661-lVi5gti8MLKvA5NvE2FceQ-1; Sat,
 28 Mar 2026 09:49:57 -0400
X-MC-Unique: lVi5gti8MLKvA5NvE2FceQ-1
X-Mimecast-MFC-AGG-ID: lVi5gti8MLKvA5NvE2FceQ_1774705796
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6E7EC180047F;
	Sat, 28 Mar 2026 13:49:56 +0000 (UTC)
Received: from localhost (unknown [10.72.116.100])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 8057930001A1;
	Sat, 28 Mar 2026 13:49:55 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Caleb Sander Mateos <csander@purestorage.com>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 6/8] selftests/ublk: add shared memory zero-copy test
Date: Sat, 28 Mar 2026 21:49:01 +0800
Message-ID: <20260328134909.3207377-7-ming.lei@redhat.com>
In-Reply-To: <20260328134909.3207377-1-ming.lei@redhat.com>
References: <20260328134909.3207377-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Add test_shmem_zc_01.sh which tests UBLK_IO_F_SHMEM_ZC on the null
target using a hugetlbfs shared buffer. Both kublk (--htlb) and fio
(--mem=mmaphuge:<path>) mmap the same hugetlbfs file with MAP_SHARED,
sharing physical pages. The kernel PFN match enables zero-copy I/O.

Uses standard fio --mem=mmaphuge:<path> (supported since fio 1.10),
no patched fio required.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 tools/testing/selftests/ublk/Makefile         |  2 +
 .../testing/selftests/ublk/test_shmemzc_01.sh | 72 +++++++++++++++++++
 2 files changed, 74 insertions(+)
 create mode 100755 tools/testing/selftests/ublk/test_shmemzc_01.sh

diff --git a/tools/testing/selftests/ublk/Makefile b/tools/testing/selftests/ublk/Makefile
index 8ac2d4a682a1..001b7dccf3c6 100644
--- a/tools/testing/selftests/ublk/Makefile
+++ b/tools/testing/selftests/ublk/Makefile
@@ -51,6 +51,8 @@ TEST_PROGS += test_stripe_06.sh
 TEST_PROGS += test_part_01.sh
 TEST_PROGS += test_part_02.sh
 
+TEST_PROGS += test_shmemzc_01.sh
+
 TEST_PROGS += test_stress_01.sh
 TEST_PROGS += test_stress_02.sh
 TEST_PROGS += test_stress_03.sh
diff --git a/tools/testing/selftests/ublk/test_shmemzc_01.sh b/tools/testing/selftests/ublk/test_shmemzc_01.sh
new file mode 100755
index 000000000000..47210af2aa20
--- /dev/null
+++ b/tools/testing/selftests/ublk/test_shmemzc_01.sh
@@ -0,0 +1,72 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Test: shmem_zc with hugetlbfs buffer on null target
+#
+# kublk and fio both mmap the same hugetlbfs file (MAP_SHARED),
+# so they share physical pages.  The kernel PFN match enables
+# zero-copy I/O without socket-based fd passing.
+
+. "$(cd "$(dirname "$0")" && pwd)"/test_common.sh
+
+ERR_CODE=0
+
+_prep_test "shmem_zc" "null target hugetlbfs shmem zero-copy test"
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
+dev_id=$(_add_ublk_dev -t null --shmem_zc --htlb "$HTLB_FILE")
+_check_add_dev $TID $?
+
+fio --name=htlb_zc \
+	--filename=/dev/ublkb"${dev_id}" \
+	--ioengine=io_uring \
+	--rw=randwrite \
+	--direct=1 \
+	--bs=4k \
+	--size=4M \
+	--iodepth=32 \
+	--mem=mmaphuge:"$HTLB_FILE" \
+	> /dev/null 2>&1
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

