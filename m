Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4BA33B2A0
	for <linux-block@vger.kernel.org>; Mon,  3 Nov 2025 06:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.153.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762152310; cv=none; b=cBBpQaQcT2xT5t7KJjBGMoPb3mrlx2TLhBfACWxxn747J81hVKBZaHYCItyHTxtaVar8L7ifGOwueR7PaZedIVYpByC12jcsfLGIC1w7MqWsSeOsi8g4eIqCnrrRdesv8949cwVH895sJROFmNg66hFPRWVLSNHW0+tMJXp5kH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762152310; c=relaxed/simple;
	bh=NCdmPqlxG98J+P1uJhfDH85On4YOcdxEzKOkrGe/JlM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Tt90GLM7bOd7CHqQKYdGpZVMaGSdli2NlK2rbpdiAS2cudMB3dI4eRBL07WrHfL3DiqkGOPT16uSOB1dIZR4Jm5E3+4Zw2O1otbKZywALE7QducIhGneaIDHnVvtoU7nCQCLytYgF2Nbf1NeXKMDeplfZL31OeiSbkQvux7qJVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=S0l+M9Hf; arc=none smtp.client-ip=216.71.153.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="S0l+M9Hf"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1762152308; x=1793688308;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=NCdmPqlxG98J+P1uJhfDH85On4YOcdxEzKOkrGe/JlM=;
  b=S0l+M9Hf+Wj7o9hrdFuoinBYPGexU2hpZ56YYMEgGsT4XlwjMGRNfJdC
   81CkeOS0kHOWYFARnsjnvkGoCuF4F4RkUPvN/+HhUvk1P8zPB2LUOjdoi
   uCFhSG40AnZ7jM/V9ZVm9C9EEZmPlhpnIdlSav1KHXaN4nCSLTnIvMv8R
   j/vd81ohNqO52imeUI5b1pILEeB7x3xaCWgmpra7edhpL2DAU1dYv/TtO
   PfOlwHAqBn9Y1YPWCMQv6LrDUcQGPaOgAOhUtTk+D7NHfaNxRBNybjzn1
   6xcNs/GJ+IU+6fa3UfdBvHVSI8Mp3u00iCEtrXaEpDyUpe4ljQ6sN6P+V
   w==;
X-CSE-ConnectionGUID: QUnIUUPAQlOUbm0XJMxBLg==
X-CSE-MsgGUID: f0Mf3+FEQe+s6skmdgVxgw==
X-IronPort-AV: E=Sophos;i="6.19,275,1754928000"; 
   d="scan'208";a="134391241"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep03.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 03 Nov 2025 14:44:59 +0800
IronPort-SDR: 69084f6b_M2Hk/6cvN74H1sRuC4paHlZUvP6GUHgWIFdADvg5nPOqz2r
 JchuJFHxDvBSotS4Ss1y9/Jc+KXWbluA9WMaFow==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep03.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 02 Nov 2025 22:44:59 -0800
WDCIronportException: Internal
Received: from wdap-zcgq2z60ds.ad.shared (HELO shinmob.flets-east.jp) ([10.224.109.249])
  by uls-op-cesaip02.wdc.com with ESMTP; 02 Nov 2025 22:44:59 -0800
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-block@vger.kernel.org,
	Yu Kuai <yukuai1@huaweicloud.com>
Cc: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH blktests v2 4/5] throtl/rc: support test with scsi_debug
Date: Mon,  3 Nov 2025 15:44:53 +0900
Message-ID: <20251103064454.724084-5-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251103064454.724084-1-shinichiro.kawasaki@wdc.com>
References: <20251103064454.724084-1-shinichiro.kawasaki@wdc.com>
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
index 8c25b1a..f5eb84e 100644
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
 
@@ -145,9 +182,9 @@ _throtl_issue_io() {
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

