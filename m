Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7457140F8DA
	for <linux-block@vger.kernel.org>; Tue, 31 Mar 2026 15:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774971185; cv=none; b=p+REhf0MSh9IdfCA1uFhnzoLmrIOZJcZzPuc9HxOcN5a4AXkN2Nzi7NwAbnfDcfCcbYsJZ4cSK5i0blxq6oNu0lem2VtYSqvc3j1UBlLLANA/uD9UDNWUBPSRQZaWIojynQhm7G3lmk4tYNal20XImusPmLdpK/dTJNcrms3xkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774971185; c=relaxed/simple;
	bh=gLqGZaIvuI9W61nRVMemrKdmsMRPdgFAyAAFiYrtR68=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=laK/xc47wkeAKYnjJCzo15sXjiflG+ZGikiZVvNy0Pn58GMphGk8srwrgGP7S5a/AlZRWb9QOBoLhWIWkmTEnih8EjxaDPFTzpT+LdHk24RJ+lO6ZqxX90V/K7x9HX5g4BWJFLknbTQ1e/4xeCrkxudGsDA0kDUbdTrs7l6VHNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AxOZJI7T; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AxOZJI7T"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774971167;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nnp4DZZaJA7P7oCJBmeimBW5M0m6C/JrtYMNIZUDsPY=;
	b=AxOZJI7TdkxuuO/nwZcvQOvzK7oV/b5bgJYAuRxTd3WH0UW9t0QltnT3dBUPY32Eu2DG8z
	v55mpxvtdrxkG0fEimJCLwrwBJzsekukGRds/1YFrdcDBDE++bl/pxUwqz3j5P8URFiBv3
	7KA+4cxQ0we5u6eEHhUhF70n9vtXce4=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-519-iVVJi6s0OFSRNsHQ7zmb1w-1; Tue,
 31 Mar 2026 11:32:44 -0400
X-MC-Unique: iVVJi6s0OFSRNsHQ7zmb1w-1
X-Mimecast-MFC-AGG-ID: iVVJi6s0OFSRNsHQ7zmb1w_1774971163
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2593A180049D;
	Tue, 31 Mar 2026 15:32:43 +0000 (UTC)
Received: from localhost (unknown [10.72.116.55])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 0BC2518001FE;
	Tue, 31 Mar 2026 15:32:41 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Caleb Sander Mateos <csander@purestorage.com>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH v2 07/10] selftests/ublk: add shared memory zero-copy test
Date: Tue, 31 Mar 2026 23:31:58 +0800
Message-ID: <20260331153207.3635125-8-ming.lei@redhat.com>
In-Reply-To: <20260331153207.3635125-1-ming.lei@redhat.com>
References: <20260331153207.3635125-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

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

