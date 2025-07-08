Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24DC52550D2
	for <linux-block@vger.kernel.org>; Tue,  8 Jul 2025 11:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.153.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751974696; cv=none; b=r6fqnaSvHr4Puc0CDeNFsToph6KIh27ZbQKGSy5wqGTXikil0/erVOrtSqklPnwUaYZUneP2+nzv6r6PLWApuOcKe8iynGU/5cGv53H2eJTGPv1jGyvWUO7jq/jzSV+NOP6eT8vihRjzX4Uh0zVf4fAKM9oFbl5GLOO/EuvbQVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751974696; c=relaxed/simple;
	bh=W+3xKK6IkcsIY45xK64w7e3+VdggBfRPiN4n2jjwUw0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nAU5YSf5N+P7SHijiGeBsPKtJ0Lp7nsljqydHiA77126oAEBDjI2qRgkCtcnfPpKM/pmdLsfejAchXc1vkiY4KJLJMeT8CmMAtDkQciyuhBSvb+YUQFAOzfs77XoPf0sq404mYJo9QmdbLm6T9xVF0i8huWFnwMViUdX8+YxZ5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=gH8xhYZ3; arc=none smtp.client-ip=216.71.153.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="gH8xhYZ3"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1751974692; x=1783510692;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=W+3xKK6IkcsIY45xK64w7e3+VdggBfRPiN4n2jjwUw0=;
  b=gH8xhYZ3i+yFQu0o8qCk0+7ob+JivZAH+S3DI8dDPEXUKFa8tKyNFOk/
   jLFM4q8G1yI8Rukp3fmF68azfLd8xp3HKUB4vVXSItn+mdFe3mHjcaNC9
   /G2ssKDcQSsnUslKa7CvI8nJxnBtM0Ymz7R4PWYyCzZcOeySO1o0yXWA3
   HHZiYjsIYT+kYXdoumbcWIkGysY/ay2qEyGjz41M/vKS9f451AjQrCnzV
   87GsP+NeOk+HxlvfYi6ctax1UZF/24JAE/to86289CPSjmhZ3cPQYbAai
   m831TEuMkFamhuXE8BQPmQQRDEkJZJtOJGFlUSeFaPXTsFNp3riETvWVt
   Q==;
X-CSE-ConnectionGUID: 4RQDIqyRSJeRPdbh7yvBug==
X-CSE-MsgGUID: bsVBwlbRQ7+kdqXH0TC8wA==
X-IronPort-AV: E=Sophos;i="6.16,297,1744041600"; 
   d="scan'208";a="86008826"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 08 Jul 2025 19:38:11 +0800
IronPort-SDR: 686cf490_oLNjGO96QKMkR3s5nzZ8nvkDIwEvKJbni+Jrlhhs/1fj3o/
 Maj5k4efkaazFfJGJ5F9E6L83nNacGFJxKxXItw==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 08 Jul 2025 03:36:00 -0700
WDCIronportException: Internal
Received: from 1lw9gb3.ad.shared (HELO shinmob.flets-east.jp) ([10.224.163.9])
  by uls-op-cesaip02.wdc.com with ESMTP; 08 Jul 2025 04:38:12 -0700
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-block@vger.kernel.org
Cc: Alan Adamson <alan.adamson@oracle.com>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH blktests v2] md/002: add atomic write tests for md/stacked devices
Date: Tue,  8 Jul 2025 20:38:11 +0900
Message-ID: <20250708113811.58691-1-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alan Adamson <alan.adamson@oracle.com>

Add a new test (md/002) to verify atomic write support for MD devices
(RAID 0, 1, and 10) stacked on top of SCSI devices using scsi_debug with
atomic write emulation enabled.

This test validates that atomic write sysfs attributes are correctly
propagated through MD layers, and that pwritev2() with RWF_ATOMIC
behaves as expected on these devices.

Specifically, the test checks:
    - That atomic write attributes in /sys/block/.../queue are consistent
      between MD and underlying SCSI devices
    - That atomic write limits are respected in user-space via xfs_io
    - That statx reports accurate atomic_write_unit_{min,max} values
    - That invalid writes (too small or too large) fail as expected
    - That chunk size affects max atomic write limits (for RAID 0/10)

Signed-off-by: Alan Adamson <alan.adamson@oracle.com>
[Shin'ichiro: replaced spaces with tabs, removed group_requires() call]
Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
Alan, thanks for the patch. I take the liberty to modify your original
patch [1] to reflect my review comments.

As to the kernel version check, I left it as it is since I can not think
of other simple way.

[1] https://lore.kernel.org/linux-block/20250605225725.3352708-1-alan.adamson@oracle.com/

Changes from v1:
* Replaced spaces for indent with tabs
* Removed unnecessary group_requires() call

 tests/md/002     | 244 +++++++++++++++++++++++++++++++++++++++++++++++
 tests/md/002.out |  43 +++++++++
 2 files changed, 287 insertions(+)
 create mode 100755 tests/md/002
 create mode 100644 tests/md/002.out

diff --git a/tests/md/002 b/tests/md/002
new file mode 100755
index 0000000..e586daf
--- /dev/null
+++ b/tests/md/002
@@ -0,0 +1,244 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-3.0+
+# Copyright (C) 2025 Oracle and/or its affiliates
+#
+# Test SCSI Atomic Writes with MD devices
+
+. tests/scsi/rc
+. common/scsi_debug
+. common/xfs
+
+DESCRIPTION="test md atomic writes"
+QUICK=1
+
+requires() {
+	_have_kver 6 14 0
+	_have_program mdadm
+	_have_driver scsi_debug
+	_have_xfs_io_atomic_write
+}
+
+test() {
+	local scsi_debug_atomic_wr_max_length
+	local scsi_debug_atomic_wr_gran
+	local scsi_sysfs_atomic_max_bytes
+	local scsi_sysfs_atomic_unit_max_bytes
+	local scsi_sysfs_atomic_unit_min_bytes
+	local md_atomic_max_bytes
+	local md_atomic_min_bytes
+	local md_sysfs_max_hw_sectors_kb
+	local md_max_hw_bytes
+	local md_chunk_size
+	local md_sysfs_logical_block_size
+	local md_sysfs_atomic_max_bytes
+	local md_sysfs_atomic_unit_max_bytes
+	local md_sysfs_atomic_unit_min_bytes
+	local bytes_to_write
+	local bytes_written
+	local test_desc
+	local scsi_0
+	local scsi_1
+	local scsi_2
+	local scsi_3
+	local scsi_dev_sysfs
+	local md_dev
+	local md_dev_sysfs
+	local scsi_debug_params=(
+		delay=0
+		atomic_wr=1
+		num_tgts=1
+		add_host=4
+		per_host_store=true
+	)
+
+	echo "Running ${TEST_NAME}"
+
+	if ! _configure_scsi_debug "${scsi_debug_params[@]}"; then
+		return 1
+	fi
+
+	scsi_0="${SCSI_DEBUG_DEVICES[0]}"
+	scsi_1="${SCSI_DEBUG_DEVICES[1]}"
+	scsi_2="${SCSI_DEBUG_DEVICES[2]}"
+	scsi_3="${SCSI_DEBUG_DEVICES[3]}"
+
+	scsi_dev_sysfs="/sys/block/${scsi_0}"
+	scsi_sysfs_atomic_max_bytes=$(< "${scsi_dev_sysfs}"/queue/atomic_write_max_bytes)
+	scsi_sysfs_atomic_unit_max_bytes=$(< "${scsi_dev_sysfs}"/queue/atomic_write_unit_max_bytes)
+	scsi_sysfs_atomic_unit_min_bytes=$(< "${scsi_dev_sysfs}"/queue/atomic_write_unit_min_bytes)
+	scsi_debug_atomic_wr_max_length=$(< /sys/module/scsi_debug/parameters/atomic_wr_max_length)
+	scsi_debug_atomic_wr_gran=$(< /sys/module/scsi_debug/parameters/atomic_wr_gran)
+
+	for raid_level in 0 1 10; do
+		if [ "$raid_level" = 10 ]
+		then
+			echo y | mdadm --create /dev/md/blktests_md --level=$raid_level \
+				--raid-devices=4 --force /dev/"${scsi_0}" /dev/"${scsi_1}" \
+				/dev/"${scsi_2}" /dev/"${scsi_3}" 2> /dev/null 1>&2
+		else
+			echo y | mdadm --create /dev/md/blktests_md --level=$raid_level \
+				--raid-devices=2 --force \
+				/dev/"${scsi_0}" /dev/"${scsi_1}" 2> /dev/null 1>&2
+		fi
+
+		md_dev=$(readlink /dev/md/blktests_md | sed 's|\.\./||')
+		md_dev_sysfs="/sys/devices/virtual/block/${md_dev}"
+
+		md_sysfs_logical_block_size=$(< "${md_dev_sysfs}"/queue/logical_block_size)
+		md_sysfs_max_hw_sectors_kb=$(< "${md_dev_sysfs}"/queue/max_hw_sectors_kb)
+		md_max_hw_bytes=$(( "$md_sysfs_max_hw_sectors_kb" * 1024 ))
+		md_sysfs_atomic_max_bytes=$(< "${md_dev_sysfs}"/queue/atomic_write_max_bytes)
+		md_sysfs_atomic_unit_max_bytes=$(< "${md_dev_sysfs}"/queue/atomic_write_unit_max_bytes)
+		md_sysfs_atomic_unit_min_bytes=$(< "${md_dev_sysfs}"/queue/atomic_write_unit_min_bytes)
+		md_atomic_max_bytes=$(( "$scsi_debug_atomic_wr_max_length" * "$md_sysfs_logical_block_size" ))
+		md_atomic_min_bytes=$(( "$scsi_debug_atomic_wr_gran" * "$md_sysfs_logical_block_size" ))
+
+		test_desc="TEST 1 RAID $raid_level - Verify md sysfs atomic attributes matches scsi"
+		if [ "$md_sysfs_atomic_unit_max_bytes" = "$scsi_sysfs_atomic_unit_max_bytes" ] &&
+			[ "$md_sysfs_atomic_unit_min_bytes" = "$scsi_sysfs_atomic_unit_min_bytes" ]
+		then
+			echo "$test_desc - pass"
+		else
+			echo "$test_desc - fail $md_sysfs_atomic_unit_max_bytes - $scsi_sysfs_atomic_unit_max_bytes -" \
+				"$md_sysfs_atomic_unit_min_bytes - $scsi_sysfs_atomic_unit_min_bytes "
+		fi
+
+		test_desc="TEST 2 RAID $raid_level - Verify sysfs atomic attributes"
+		if [ "$md_max_hw_bytes" -ge "$md_sysfs_atomic_max_bytes" ] &&
+			[ "$md_sysfs_atomic_max_bytes" -ge "$md_sysfs_atomic_unit_max_bytes" ] &&
+			[ "$md_sysfs_atomic_unit_max_bytes" -ge "$md_sysfs_atomic_unit_min_bytes" ]
+		then
+			echo "$test_desc - pass"
+		else
+			echo "$test_desc - fail $md_max_hw_bytes - $md_sysfs_max_hw_sectors_kb -" \
+				"$md_sysfs_atomic_max_bytes - $md_sysfs_atomic_unit_max_bytes -" \
+				"$md_sysfs_atomic_unit_min_bytes"
+		fi
+
+		test_desc="TEST 3 RAID $raid_level - Verify md sysfs_atomic_max_bytes is less than or equal "
+		test_desc+="scsi sysfs_atomic_max_bytes"
+		if [ "$md_sysfs_atomic_max_bytes" -le "$scsi_sysfs_atomic_max_bytes" ]
+		then
+			echo "$test_desc - pass"
+		else
+			echo "$test_desc - fail $md_sysfs_atomic_max_bytes - $scsi_sysfs_atomic_max_bytes"
+		fi
+
+		test_desc="TEST 4 RAID $raid_level - check sysfs atomic_write_unit_max_bytes <= scsi_debug atomic_wr_max_length"
+		if (("$md_sysfs_atomic_unit_max_bytes" <= "$md_atomic_max_bytes"))
+		then
+			echo "$test_desc - pass"
+		else
+			echo "$test_desc - fail $md_sysfs_atomic_unit_max_bytes - $md_atomic_max_bytes"
+		fi
+
+		test_desc="TEST 5 RAID $raid_level - check sysfs atomic_write_unit_min_bytes = scsi_debug atomic_wr_gran"
+		if [ "$md_sysfs_atomic_unit_min_bytes" = "$md_atomic_min_bytes" ]
+		then
+			echo "$test_desc - pass"
+		else
+			echo "$test_desc - fail $md_sysfs_atomic_unit_min_bytes - $md_atomic_min_bytes"
+		fi
+
+		test_desc="TEST 6 RAID $raid_level - check statx stx_atomic_write_unit_min"
+		statx_atomic_min=$(run_xfs_io_xstat /dev/"$md_dev" "stat.atomic_write_unit_min")
+		if [ "$statx_atomic_min" = "$md_atomic_min_bytes" ]
+		then
+			echo "$test_desc - pass"
+		else
+			echo "$test_desc - fail $statx_atomic_min - $md_atomic_min_bytes"
+		fi
+
+		test_desc="TEST 7 RAID $raid_level - check statx stx_atomic_write_unit_max"
+		statx_atomic_max=$(run_xfs_io_xstat /dev/"$md_dev" "stat.atomic_write_unit_max")
+		if [ "$statx_atomic_max" = "$md_sysfs_atomic_unit_max_bytes" ]
+		then
+			echo "$test_desc - pass"
+		else
+			echo "$test_desc - fail $statx_atomic_max - $md_sysfs_atomic_unit_max_bytes"
+		fi
+
+		test_desc="TEST 8 RAID $raid_level - perform a pwritev2 with size of sysfs_atomic_unit_max_bytes with "
+		test_desc+="RWF_ATOMIC flag - pwritev2 should be succesful"
+		bytes_written=$(run_xfs_io_pwritev2_atomic /dev/"$md_dev" "$md_sysfs_atomic_unit_max_bytes")
+		if [ "$bytes_written" = "$md_sysfs_atomic_unit_max_bytes" ]
+		then
+			echo "$test_desc - pass"
+		else
+			echo "$test_desc - fail $bytes_written - $md_sysfs_atomic_unit_max_bytes"
+		fi
+
+		test_desc="TEST 9 RAID $raid_level - perform a pwritev2 with size of sysfs_atomic_unit_max_bytes + 512 "
+		test_desc+="bytes with RWF_ATOMIC flag - pwritev2 should not be succesful"
+		bytes_to_write=$(( "${md_sysfs_atomic_unit_max_bytes}" + 512 ))
+		bytes_written=$(run_xfs_io_pwritev2_atomic /dev/"$md_dev" "$bytes_to_write")
+		if [ "$bytes_written" = "" ]
+		then
+			echo "$test_desc - pass"
+		else
+			echo "$test_desc - fail $bytes_written - $bytes_to_write"
+		fi
+
+		test_desc="TEST 10 RAID $raid_level - perform a pwritev2 with size of sysfs_atomic_unit_min_bytes "
+		test_desc+="with RWF_ATOMIC flag - pwritev2 should be succesful"
+		bytes_written=$(run_xfs_io_pwritev2_atomic /dev/"$md_dev" "$md_sysfs_atomic_unit_min_bytes")
+		if [ "$bytes_written" = "$md_sysfs_atomic_unit_min_bytes" ]
+		then
+			echo "$test_desc - pass"
+		else
+			echo "$test_desc - fail $bytes_written - $md_atomic_min_bytes"
+		fi
+
+		bytes_to_write=$(( "${md_sysfs_atomic_unit_min_bytes}" - "${md_sysfs_logical_block_size}" ))
+		test_desc="TEST 11 RAID $raid_level - perform a pwritev2 with a size of sysfs_atomic_unit_min_bytes - 512 "
+		test_desc+="bytes with RWF_ATOMIC flag - pwritev2 should fail"
+		if [ "$bytes_to_write" = 0 ]
+		then
+			echo "$test_desc - pass"
+		else
+			bytes_written=$(run_xfs_io_pwritev2_atomic /dev/"$md_dev" "$bytes_to_write")
+			if [ "$bytes_written" = "" ]
+			then
+				echo "$test_desc - pass"
+			else
+				echo "$test_desc - fail $bytes_written - $bytes_to_write"
+			fi
+		fi
+
+		mdadm --stop /dev/md/blktests_md  2> /dev/null 1>&2
+
+		if [ "$raid_level" = 0 ] || [ "$raid_level" = 10 ]
+		then
+			md_chunk_size=$(( "$scsi_sysfs_atomic_unit_max_bytes" / 2048))
+
+			if [ "$raid_level" = 0 ]
+			then
+				echo y | mdadm --create /dev/md/blktests_md --level=$raid_level \
+					--raid-devices=2 --chunk="${md_chunk_size}"K --force \
+					/dev/"${scsi_0}" /dev/"${scsi_1}" 2> /dev/null 1>&2
+			else
+				echo y | mdadm --create /dev/md/blktests_md --level=$raid_level \
+					--raid-devices=4 --chunk="${md_chunk_size}"K --force \
+					/dev/"${scsi_0}" /dev/"${scsi_1}" \
+					/dev/"${scsi_2}" /dev/"${scsi_3}" 2> /dev/null 1>&2
+			fi
+
+			md_dev=$(readlink /dev/md/blktests_md | sed 's|\.\./||')
+			md_dev_sysfs="/sys/devices/virtual/block/${md_dev}"
+			md_sysfs_atomic_unit_max_bytes=$(< "${md_dev_sysfs}"/queue/atomic_write_unit_max_bytes)
+			test_desc="TEST 12 RAID $raid_level - Verify sysfs_atomic_unit_max_bytes <= chunk size "
+			if [ "$md_chunk_size" -le "$md_sysfs_atomic_unit_max_bytes" ]
+			then
+				echo "$test_desc - pass"
+			else
+				echo "$test_desc - fail $md_chunk_size - $md_sysfs_atomic_unit_max_bytes"
+			fi
+
+			mdadm --quiet --stop /dev/md/blktests_md
+		fi
+	done
+
+	_exit_scsi_debug
+
+	echo "Test complete"
+}
diff --git a/tests/md/002.out b/tests/md/002.out
new file mode 100644
index 0000000..61fb265
--- /dev/null
+++ b/tests/md/002.out
@@ -0,0 +1,43 @@
+Running md/002
+TEST 1 RAID 0 - Verify md sysfs atomic attributes matches scsi - pass
+TEST 2 RAID 0 - Verify sysfs atomic attributes - pass
+TEST 3 RAID 0 - Verify md sysfs_atomic_max_bytes is less than or equal scsi sysfs_atomic_max_bytes - pass
+TEST 4 RAID 0 - check sysfs atomic_write_unit_max_bytes <= scsi_debug atomic_wr_max_length - pass
+TEST 5 RAID 0 - check sysfs atomic_write_unit_min_bytes = scsi_debug atomic_wr_gran - pass
+TEST 6 RAID 0 - check statx stx_atomic_write_unit_min - pass
+TEST 7 RAID 0 - check statx stx_atomic_write_unit_max - pass
+TEST 8 RAID 0 - perform a pwritev2 with size of sysfs_atomic_unit_max_bytes with RWF_ATOMIC flag - pwritev2 should be succesful - pass
+pwrite: Invalid argument
+TEST 9 RAID 0 - perform a pwritev2 with size of sysfs_atomic_unit_max_bytes + 512 bytes with RWF_ATOMIC flag - pwritev2 should not be succesful - pass
+TEST 10 RAID 0 - perform a pwritev2 with size of sysfs_atomic_unit_min_bytes with RWF_ATOMIC flag - pwritev2 should be succesful - pass
+pwrite: Invalid argument
+TEST 11 RAID 0 - perform a pwritev2 with a size of sysfs_atomic_unit_min_bytes - 512 bytes with RWF_ATOMIC flag - pwritev2 should fail - pass
+TEST 12 RAID 0 - Verify sysfs_atomic_unit_max_bytes <= chunk size  - pass
+TEST 1 RAID 1 - Verify md sysfs atomic attributes matches scsi - pass
+TEST 2 RAID 1 - Verify sysfs atomic attributes - pass
+TEST 3 RAID 1 - Verify md sysfs_atomic_max_bytes is less than or equal scsi sysfs_atomic_max_bytes - pass
+TEST 4 RAID 1 - check sysfs atomic_write_unit_max_bytes <= scsi_debug atomic_wr_max_length - pass
+TEST 5 RAID 1 - check sysfs atomic_write_unit_min_bytes = scsi_debug atomic_wr_gran - pass
+TEST 6 RAID 1 - check statx stx_atomic_write_unit_min - pass
+TEST 7 RAID 1 - check statx stx_atomic_write_unit_max - pass
+TEST 8 RAID 1 - perform a pwritev2 with size of sysfs_atomic_unit_max_bytes with RWF_ATOMIC flag - pwritev2 should be succesful - pass
+pwrite: Invalid argument
+TEST 9 RAID 1 - perform a pwritev2 with size of sysfs_atomic_unit_max_bytes + 512 bytes with RWF_ATOMIC flag - pwritev2 should not be succesful - pass
+TEST 10 RAID 1 - perform a pwritev2 with size of sysfs_atomic_unit_min_bytes with RWF_ATOMIC flag - pwritev2 should be succesful - pass
+pwrite: Invalid argument
+TEST 11 RAID 1 - perform a pwritev2 with a size of sysfs_atomic_unit_min_bytes - 512 bytes with RWF_ATOMIC flag - pwritev2 should fail - pass
+TEST 1 RAID 10 - Verify md sysfs atomic attributes matches scsi - pass
+TEST 2 RAID 10 - Verify sysfs atomic attributes - pass
+TEST 3 RAID 10 - Verify md sysfs_atomic_max_bytes is less than or equal scsi sysfs_atomic_max_bytes - pass
+TEST 4 RAID 10 - check sysfs atomic_write_unit_max_bytes <= scsi_debug atomic_wr_max_length - pass
+TEST 5 RAID 10 - check sysfs atomic_write_unit_min_bytes = scsi_debug atomic_wr_gran - pass
+TEST 6 RAID 10 - check statx stx_atomic_write_unit_min - pass
+TEST 7 RAID 10 - check statx stx_atomic_write_unit_max - pass
+TEST 8 RAID 10 - perform a pwritev2 with size of sysfs_atomic_unit_max_bytes with RWF_ATOMIC flag - pwritev2 should be succesful - pass
+pwrite: Invalid argument
+TEST 9 RAID 10 - perform a pwritev2 with size of sysfs_atomic_unit_max_bytes + 512 bytes with RWF_ATOMIC flag - pwritev2 should not be succesful - pass
+TEST 10 RAID 10 - perform a pwritev2 with size of sysfs_atomic_unit_min_bytes with RWF_ATOMIC flag - pwritev2 should be succesful - pass
+pwrite: Invalid argument
+TEST 11 RAID 10 - perform a pwritev2 with a size of sysfs_atomic_unit_min_bytes - 512 bytes with RWF_ATOMIC flag - pwritev2 should fail - pass
+TEST 12 RAID 10 - Verify sysfs_atomic_unit_max_bytes <= chunk size  - pass
+Test complete
-- 
2.50.0

