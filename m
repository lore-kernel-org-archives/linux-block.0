Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7540925A2B5
	for <linux-block@vger.kernel.org>; Fri, 10 Oct 2025 08:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.154.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760084406; cv=none; b=Y0lDOM/sThGdTpj02kfgWmhDfp04E06xdNm6/umfE7ypd1PtzSx9AhCorkk+VGpbQQcxGRTYmM/ObEoIYIQzgq7fxs+zmYaDaASMWHc305jSB8O8+XV+MdYRG7LdGObeP/aJvad5ivV0rioSi+s7arixb6bVkbr0P8muOT7ivqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760084406; c=relaxed/simple;
	bh=A8DfMVPwSiFWRrl5f+M0dhPgeLwYCsX8HWAvLqdseU8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RoBQOfENcwzmEkQt6hEA0BotMYsK/yVqfIfr3YVFcGvuYuc6nUZyRy8iDfF+sV0/XIhQbSzBvoa7NnWGsbpGYXO+uAdwZYaRnd2gSZ4+svYoqYWItpbluGcxcHRE6FS7+uO/7HNK/A6b9PjU9q2HzR6gznI58BlCDlZavr/Vbbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=L3LmM32C; arc=none smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="L3LmM32C"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1760084404; x=1791620404;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=A8DfMVPwSiFWRrl5f+M0dhPgeLwYCsX8HWAvLqdseU8=;
  b=L3LmM32CyN4Y5t5TsR4vH5tSZ+KDuvTd/BLrbFO/AbgvQbsom2uGJVay
   vYiaiJL+LapUAIIPyShORSSm0jbR3kd03dBzdN2IE2a6sV64HP+HHM8XR
   PBBqHUcQiIlvd+Dp8Exswip7w6gFpzGIIqlDBH1bM57jqujBOPj7PBDSh
   YWbGrrA/tqmuewYUNHPxrQPuWfdNzJUTPunk2w2W1cW1u8zU+t3SctZLA
   q+yTLoLibeJfEVd3vZJ5xrI7ztzcXgH7+Fb/RZqAauU3vV92XwTQjiQ3i
   7xwOIhSNiMFtuMFcTsQbDQFrF6SSTpNVQnY7wYXg97S3WQu0OHKVyP6q9
   g==;
X-CSE-ConnectionGUID: NBveX24kSNyO2vGNR0GGQg==
X-CSE-MsgGUID: gR2xAHLKRkOvbU8/2dv1hg==
X-IronPort-AV: E=Sophos;i="6.19,218,1754928000"; 
   d="scan'208";a="132653547"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 10 Oct 2025 16:19:56 +0800
IronPort-SDR: 68e8c1ac_NEN/qO8WJAWVaAJ7z6jlkwM8I/dDuY56vVFdFQS6Cy8vdAm
 KchohBFe2HV5wTRN8cixLiu2leihCkBT1SWVLiQ==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 10 Oct 2025 01:19:57 -0700
WDCIronportException: Internal
Received: from 5cg2148fq4.ad.shared (HELO shinmob.wdc.com) ([10.224.163.88])
  by uls-op-cesaip02.wdc.com with ESMTP; 10 Oct 2025 01:19:56 -0700
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-block@vger.kernel.org,
	Yu Kuai <yukuai1@huaweicloud.com>
Cc: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH blktests 3/4] throtl/rc: support test with scsi_debug
Date: Fri, 10 Oct 2025 17:19:51 +0900
Message-ID: <20251010081952.187064-4-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251010081952.187064-1-shinichiro.kawasaki@wdc.com>
References: <20251010081952.187064-1-shinichiro.kawasaki@wdc.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, the throtl test cases set up null_blk devices as test
targets. It is desired to run the tests with scsi_debug devices also
to expand test coverage and identify failures that do not surface with
null_blk as shown in the Link.

Introduce the global variable throtl_blkdev_type to choose the test
target block device type. When 'nullb' is set to it, run the tests
with null_blk. When 'sdebug' is set, run with scsi_debug. The command
line below runs the throtl group with scsi_debug.

  $ sudo bash -c "throtl_blkdev_type=sdebug ./check throtl"

Modify the helper functions _configure_throtl_blkdev(),
_delete_throtl_blkdev() and _exit_throtl_blkdev() to support both
null_blk and scsi_debug. After this change, the global variable
THROTL_DEV is no longer constant then shellcheck warns about its
references. Add double quotations to suppress the shellcheck warnings.

Link: https://lore.kernel.org/linux-block/20250918085341.3686939-1-yukuai1@huaweicloud.com/
Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
 tests/throtl/rc | 63 +++++++++++++++++++++++++++++++++++++++----------
 1 file changed, 50 insertions(+), 13 deletions(-)

diff --git a/tests/throtl/rc b/tests/throtl/rc
index d20dc94..c7539aa 100644
--- a/tests/throtl/rc
+++ b/tests/throtl/rc
@@ -6,21 +6,26 @@
 
 . common/rc
 . common/null_blk
+. common/scsi_debug
 . common/cgroup
 
 THROTL_DIR=$(echo "$TEST_NAME" | tr '/' '_')
-THROTL_DEV=dev_nullb
+throtl_blkdev_type=${throtl_blkdev_type:-"nullb"}
+THROTL_NULL_DEV=dev_nullb
+declare THROTL_DEV
 declare THROTL_CLEAR_BASE_SUBTREE_CONTROL_IO
 declare THROTL_CLEAR_CGROUP2_DIR_CONTROL_IO
 
 group_requires() {
 	_have_root
 	_have_null_blk
+	_have_scsi_debug
 	_have_kernel_option BLK_DEV_THROTTLING
 	_have_cgroup2_controller io
 	_have_program bc
 }
 
+# Prepare null_blk or scsi_debug device to test, based on throtl_blkdev_type.
 _configure_throtl_blkdev() {
 	local sector_size=0 memory_backed=0
 	local -a args
@@ -42,21 +47,53 @@ _configure_throtl_blkdev() {
 		esac
 	done
 
-	args=("$THROTL_DEV")
-	((sector_size)) && args+=(max_sectors="$((sector_size / 512))")
-	((memory_backed)) && args+=(memory_backed=1)
-	if _configure_null_blk "${args[@]}" power=1; then
-		return
-	fi
+	THROTL_DEV=
+	case "$throtl_blkdev_type" in
+	nullb)
+		args=("$THROTL_NULL_DEV")
+		((sector_size)) && args+=(max_sectors="$((sector_size / 512))")
+		((memory_backed)) && args+=(memory_backed=1)
+		if _configure_null_blk "${args[@]}" power=1; then
+			THROTL_DEV=$THROTL_NULL_DEV
+			return
+		fi
+		;;
+	sdebug)
+		args=(dev_size_mb=1024)
+		((sector_size)) && args+=(sector_size="${sector_size}")
+		if _configure_scsi_debug "${args[@]}"; then
+			THROTL_DEV=${SCSI_DEBUG_DEVICES[0]}
+			return
+		fi
+		;;
+	*)
+		echo "Invalid block device type: ${throtl_blkdev_type}" ;;
+	esac
 	return 1
 }
 
 _delete_throtl_blkdev() {
-	echo 0 > "/sys/kernel/config/nullb/$THROTL_DEV/power"
+	case "$throtl_blkdev_type" in
+	nullb)
+		echo 0 > "/sys/kernel/config/nullb/$THROTL_DEV/power"
+		;;
+	sdebug)
+		echo 1 > "/sys/block/$THROTL_DEV/device/delete"
+		;;
+	*)
+		echo "Invalid block device type: ${throtl_blkdev_type}" ;;
+	esac
 }
 
 _exit_throtl_blkdev() {
-	_exit_null_blk
+	case "$throtl_blkdev_type" in
+	nullb)
+		_exit_null_blk ;;
+	sdebug)
+		_exit_scsi_debug ;;
+	*)
+		echo "Invalid block device type: ${throtl_blkdev_type}" ;;
+	esac
 	unset THROTL_DEV
 }
 
@@ -101,12 +138,12 @@ _clean_up_throtl() {
 }
 
 _throtl_set_limits() {
-	echo "$(cat /sys/block/$THROTL_DEV/dev) $*" > \
+	echo "$(cat /sys/block/"$THROTL_DEV"/dev) $*" > \
 		"$CGROUP2_DIR/$THROTL_DIR/io.max"
 }
 
 _throtl_remove_limits() {
-	echo "$(cat /sys/block/$THROTL_DEV/dev) rbps=max wbps=max riops=max wiops=max" > \
+	echo "$(cat /sys/block/"$THROTL_DEV"/dev) rbps=max wbps=max riops=max wiops=max" > \
 		"$CGROUP2_DIR/$THROTL_DIR/io.max"
 }
 
@@ -141,9 +178,9 @@ _throtl_issue_io() {
 	start_time=$(date +%s.%N)
 
 	if [ "$1" == "read" ]; then
-		dd if=/dev/$THROTL_DEV of=/dev/null bs="$2" count="$3" iflag=direct status=none
+		dd if=/dev/"$THROTL_DEV" of=/dev/null bs="$2" count="$3" iflag=direct status=none
 	elif [ "$1" == "write" ]; then
-		dd of=/dev/$THROTL_DEV if=/dev/zero bs="$2" count="$3" oflag=direct status=none
+		dd of=/dev/"$THROTL_DEV" if=/dev/zero bs="$2" count="$3" oflag=direct status=none
 	fi
 
 	end_time=$(date +%s.%N)
-- 
2.51.0

