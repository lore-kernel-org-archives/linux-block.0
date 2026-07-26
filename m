Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9436B233924
	for <linux-block@vger.kernel.org>; Sun, 26 Jul 2026 05:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.154.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785043969; cv=none; b=Hzjm43eidKrKFuKqB/KyB0uA7TPiWSCJTlqKxb2S+HQpzkz04XuF2vPrdJTrg1HMO5cBCrXmX7U6xEyMjfQKd4HrIZqttkvpILPbbdaryy5hm9u7CWkJshSGXGA5KrT8G4gID36eemojsPDrNTv8eBf5j4Z6DCG9q5ol2Omr9oM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785043969; c=relaxed/simple;
	bh=4svzbYdkviwd790siZkK5nThLCqVW7zqy51e4QCC/Ls=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Gi+e9RqlgmcqxpQXv0lWsJYM9J39087web48Fab9wj9XSpUBxjgUP+t5fgkHmb6B2MO5Z+XgWTDDNIAECmUvfwsZs4jOSeeILf/sVlYgvEKw9OLAXxP3tc93du68hfsfnsFok+74jqxfsbJn0dLFIIy2T2JutDBQmWOmZpnmBQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=QxjKnMqt; arc=none smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="QxjKnMqt"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1785043970; x=1816579970;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=4svzbYdkviwd790siZkK5nThLCqVW7zqy51e4QCC/Ls=;
  b=QxjKnMqtqzVNJW/1BTkIBONlGTHh3jK8yMF3OP7eHVvhp+S+mM9URtgc
   ON0ymlyu1xeAUq3VvH9rPim4M2ntxghu/nLmpx8O8c7V1ApK5dfFPkuSU
   ill76NmYNEGmPjk/q4NxIwzcbUklh89N7XGDuYVXYtz8LE9Xicm7kAViq
   YUSpiLc6APM8pc/sodQeyKzVKkwgkq2coK7KXqrezu0PWL1LV8j7KmhVb
   KEXsqpT+HaIdzkk2SQ2sKsrUo4I9bBqVCeYC+MUzUJKX4sW/YWlzpBU0n
   u4uogn5IGW/5LWVZjbahu6sSIkIAN2rtQICHAlB65OLu67XnDeZLxnkOW
   g==;
X-CSE-ConnectionGUID: n741KBb8RpeskDmlMfRePA==
X-CSE-MsgGUID: YUcjEeLwR1ueYsdq7/A7CA==
X-IronPort-AV: E=Sophos;i="6.25,185,1779120000"; 
   d="scan'208";a="150242813"
Received: from unknown (HELO uls-op-esad3-o.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 26 Jul 2026 13:32:41 +0800
X-CSE-ConnectionGUID: JTjKLVFDTau4y9r8cB3ISg==
X-CSE-MsgGUID: qQ63slPmRE2rWg0JFoQ+Iw==
IronPort-SDR: 6a659bda_HX5Oo8aYSc7podONxncmhVIoCz/RjV0sTIMIJI44x1sKZnv
 oyWkQ1UMwjuVxBQ4qA4Ey0PbVpW38JgtunVnU+A==
Received: from uls-op-esai2-o.wdc.com ([10.248.3.38])
  by uls-op-esad3-o.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 25 Jul 2026 22:32:10 -0700
X-CSE-ConnectionGUID: /rvl6pHORvG52GZIRJG7Pg==
X-CSE-MsgGUID: 9n6AUgPySOeA6m2yW0vLBQ==
WDCIronportException: Internal
Received: from unknown (HELO shindev.ssa.fujisawa.hgst.com) ([10.149.67.30])
  by uls-op-esai2-o.wdc.com with ESMTP; 25 Jul 2026 22:32:11 -0700
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-block@vger.kernel.org
Cc: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH blktests 3/3] common, block/{015,020,021,027,040}, zbd/012: use _write_queue_sched()
Date: Sun, 26 Jul 2026 14:32:07 +0900
Message-ID: <20260726053207.1673066-4-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260726053207.1673066-1-shinichiro.kawasaki@wdc.com>
References: <20260726053207.1673066-1-shinichiro.kawasaki@wdc.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use _write_queue_sched() to write values to the sysfs attirbute
queue/scheduler to handle -EBUSY.

Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
 common/dm                  | 2 +-
 common/multipath-over-rdma | 2 +-
 common/rc                  | 5 +----
 tests/block/015            | 2 +-
 tests/block/020            | 2 +-
 tests/block/021            | 2 +-
 tests/block/027            | 2 +-
 tests/block/040            | 3 +--
 tests/zbd/012              | 2 +-
 9 files changed, 9 insertions(+), 13 deletions(-)

diff --git a/common/dm b/common/dm
index 14f4265..b0517d6 100644
--- a/common/dm
+++ b/common/dm
@@ -38,7 +38,7 @@ _dm_destination_dev_set_scheduler() {
 			SYSFS_QUEUE_SAVED["$path"]="$(sed \
 					-e 's/.*\[//' -e 's/\].*//' "${path}")"
 		fi
-		echo "${1}" > "${path}"
+		_write_queue_sched "${1}" "${path}"
 	done < <(dmsetup table "$(<"${TEST_DEV_SYSFS}/dm/name")" |
 			 sed -n  's/.* \([0-9]*:[0-9]*\).*/\1/p')
 }
diff --git a/common/multipath-over-rdma b/common/multipath-over-rdma
index 9b72d26..9a4595d 100644
--- a/common/multipath-over-rdma
+++ b/common/multipath-over-rdma
@@ -302,7 +302,7 @@ set_scheduler() {
 			bfq-mq)      s=bfq;;
 		esac
 	fi
-	if ! echo "$s" > "$p"; then
+	if ! _write_queue_sched "$s" "$p"; then
 		echo "Changing scheduler of $b from $(<"$p") into $s failed"
 		return 1
 	fi
diff --git a/common/rc b/common/rc
index de5eb6d..6500533 100644
--- a/common/rc
+++ b/common/rc
@@ -385,10 +385,7 @@ _test_dev_queue_set() {
 	      ${SYSFS_QUEUE_SAVED["$path"]-unset} == unset ]]; then
 		SYSFS_QUEUE_SAVED["$path"]="$(_test_dev_queue_get "$1")"
 	fi
-	if ! echo "$2" >"$path"; then
-		echo "echo $2 > $path failed"
-		return 1
-	fi
+	_write_queue_sched "$2" "$path"
 }
 
 _test_dev_set_scheduler() {
diff --git a/tests/block/015 b/tests/block/015
index afb4b82..31a8135 100755
--- a/tests/block/015
+++ b/tests/block/015
@@ -42,7 +42,7 @@ test() {
 
 	for sched in $(_io_schedulers "$faultb"); do
 		echo "Testing $sched" >> "$FULL"
-		echo "$sched" > /sys/block/"$faultb"/queue/scheduler
+		_write_queue_sched "$sched" /sys/block/"$faultb"/queue/scheduler
 		dd if=/dev/"$faultb" of=/dev/null bs=4K count=$((512 * 1024)) \
 			iflag=direct status=none
 	done
diff --git a/tests/block/020 b/tests/block/020
index 66f380e..22adf46 100755
--- a/tests/block/020
+++ b/tests/block/020
@@ -33,7 +33,7 @@ test() {
 	fi
 	for sched in $(_io_schedulers nullb1); do
 		echo "Testing $sched" >> "$FULL"
-		echo "$sched" > /sys/block/nullb1/queue/scheduler
+		_write_queue_sched "$sched" /sys/block/nullb1/queue/scheduler
 		_fio_perf --bs=4k --ioengine=libaio --iodepth=$iodepth \
 			--numjobs="$(nproc)" --rw=randread --name=async \
 			--filename=/dev/nullb1 --size=1g --direct=1 \
diff --git a/tests/block/021 b/tests/block/021
index 525d707..0d26e76 100755
--- a/tests/block/021
+++ b/tests/block/021
@@ -29,7 +29,7 @@ test() {
 
 	for sched in $(_io_schedulers nullb1); do
 		echo "Testing $sched" >> "$FULL"
-		echo "$sched" > /sys/block/nullb1/queue/scheduler
+		_write_queue_sched "$sched" /sys/block/nullb1/queue/scheduler
 		max_nr="$(cat /sys/block/nullb1/queue/nr_requests)"
 		for ((nr = 4; nr <= max_nr; nr++)); do
 			echo "$nr" > /sys/block/nullb1/queue/nr_requests
diff --git a/tests/block/027 b/tests/block/027
index f59dad2..a208d33 100755
--- a/tests/block/027
+++ b/tests/block/027
@@ -51,7 +51,7 @@ scsi_debug_stress_remove() {
 		# shellcheck disable=SC2207
 		scheds=($(sed 's/[][]//g' "$queue_path/scheduler"))
 		sched_idx=$((cnt % ${#scheds[@]}))
-		echo "${scheds[$sched_idx]}" > "$queue_path/scheduler"
+		_write_queue_sched "${scheds[$sched_idx]}" "$queue_path/scheduler"
 		echo "$cnt" > "$queue_path/../device/queue_depth"
 		((cnt++))
 	done
diff --git a/tests/block/040 b/tests/block/040
index cbf48d4..32e54f0 100755
--- a/tests/block/040
+++ b/tests/block/040
@@ -27,8 +27,7 @@ modify_io_sched() {
 	deadline=$(($(_uptime_s) + TIMEOUT))
 	while [ "$(_uptime_s)" -lt "$deadline" ]; do
 		for sched in $(_io_schedulers "$dev"); do
-			{ echo "$sched" > /sys/block/"$dev"/queue/scheduler ;} \
-				&> /dev/null
+			_write_queue_sched "$sched" /sys/block/"$dev"/queue/scheduler
 			sleep .5
 		done
 	done
diff --git a/tests/zbd/012 b/tests/zbd/012
index c2e47f3..5ec6fd2 100755
--- a/tests/zbd/012
+++ b/tests/zbd/012
@@ -21,7 +21,7 @@ toggle_iosched() {
 
 	while true; do
 		for iosched in none mq-deadline; do
-			echo "${iosched}" > "/sys/class/block/$(basename "$zdev")/queue/scheduler"
+			_write_queue_sched "${iosched}" "/sys/class/block/$(basename "$zdev")/queue/scheduler"
 			sleep .1
 		done
 	done
-- 
2.54.0

