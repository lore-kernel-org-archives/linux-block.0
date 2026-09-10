Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB4963603E9
	for <linux-block@vger.kernel.org>; Thu, 10 Sep 2026 10:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789034965; cv=none; b=BZoNwBJICJ955ijvk3jYKg8pUmMhItrza1/e5qk4q8EBPyjC254lFEcIK6tWi0c3vKpi8EdVe0H9zhbBLmGO1Vy97mYJSmruUMBsf/SNvjQCyg2xvt/3lcFzO4OJ7e6M1l9/ozTnt2eq2L18zQu6kuaBJijOABqzvRqCKwLRQaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789034965; c=relaxed/simple;
	bh=hlAykUo9I2bigzIy2JPghjU3ML/LdcDHWDxvtaUsKPQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=k0XrgsJGFDM3LGHjJ5d8UIccawqFYZTiNNt2nmSX2ik5HVxuEmRxIQUMymOvXP2BbbpXGnIBS+8gdM7npQKkIo6Oh0PyJSWjyWaidINm66z0MY2G2mPsUDslePlpn56ydcp2b5cRdAszPJ55YEk4LjpU6Eg5p1CP11a/fcN0YO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=HkwkdUGY; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="HkwkdUGY"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49cfbdac7a1so3362155e9.1
        for <linux-block@vger.kernel.org>; Thu, 10 Sep 2026 03:09:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1789034958; x=1789639758; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=/CoJWU3gPqFQv9oVm0NfkdqY7xtpSQCHGkVKyD5YRlw=;
        b=HkwkdUGYPN/tG9A3o14Dryh37GlKXPEcNYdgNcCndR+eV+Xegu0msT2UsO+lcSTfuS
         8nNXzhHT4KvauI0VBVuoqtFuFFM15HcJvT5+ihjNvIGR4tLEs+uSi5yyp79wkZtvGgeL
         dDNT/sR8CMwl3VE1hS7Ur7WbgbCv1r+UwKWcCU4OFJeW0O+BiveBb/FU8l+NazZ4EylY
         LH95yl/qlCDMWHKmFPoeI4zVok+xTlDFjvE6Dz5ji8ra7LWDU8uHtUY5qN1osi4npVTr
         hGuKfJ6ej/rgU9+KQ3nihPfR5L4uwRcUiROHMtrMNOYjDsRF6PmpK7frfv+n5+hU+aNl
         UfPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789034958; x=1789639758;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/CoJWU3gPqFQv9oVm0NfkdqY7xtpSQCHGkVKyD5YRlw=;
        b=Em8oZTvAu3ObBaBrNrEsA7S1p98/BQUsrFOzWgSZ4Os2sRjIPiBdzqu8i9t7wXnhdt
         NGfHNdqaEIH+QY6fMfYSAw7nCGJ4MtwbuGKCU1N0f3yFGNyjSzY0pZ0v7K2IXjBHQobb
         PEdplHA/Iw/tFVKT8QyujcDOAprYTarTJDKkdPz6TzgT8q6amvEJLeLzJMJBxXatG9lC
         63GiY4oHLtdybzIC7qAVhkuiTenZ3NLQVn3AjbIrM9HO/rKkSjjF7c4oFj7dzhHVJXkT
         0rB/4FRgGILyBpLc9uwfDLLTKW4r0Y04YpaD8cUD3frbKxp4FcZLF1oBjeGXbkifQj38
         tzjg==
X-Gm-Message-State: AFuF++ltIBr+9BWTxk/kwN/5g1PEg5jtrJgBMWnNKb5ff+1UUXFkrjGF
	PnDMly3SOlIgi2zlr17CJEP/dyTMkYKvLPSc51E5ED2bemkCxW8UTWNCGq4YPoVUgSHyBMAjxt9
	esIfz/g8=
X-Gm-Gg: AYBFou1Ai2nl/MK2/HAchYdFIiAZECbsSzDjS9KufU+t9Vc/neC8uS9KRTlujy032cN
	bhb1MrTm5KVu1xZHLp7hkuokqIxeSXgLqYA2Iz9XKKTLEzjeB5qRDc36wbk9aUOpvSPmimy3HRo
	chOCGiF/lUtploScnoiwgdM/F2pwioHUKv6Wq89s836CzVHao/yGjiCXHKewf/bzSThifZyosJZ
	bHzIA2QJW7x3VHRI7y9eoKrvr9mnL34lgtfoYQHTBNBX988h40TMlKhAh2bt6dPx2Bate6O8z/j
	KGtqrjsd8/mCE857NbW/qFKBNQHtR3gm1/EDk7d5kJQB4kggBvxqJB1ivhtMyU/s/n8q/JSPlCW
	ump+A+Q6E43QB3yWO3G+FU9xBrT9/JayUkpMQUzBIU8sJC4CzbuWZh3C+m4nhwbryQ6tk7HCjFi
	zC42US2uTH2PFJH/wt5ydbtP0H7pUBSLGENL3cS4grmXP7CQ0t26pYbshWqU6Ee7Hil/M8MWoEg
	L9Wg6f/axNhmmT9Wz/XjTOZ19wF3BqT0XfW5BLt10JkRg==
X-Received: by 2002:a05:600c:3b25:b0:49b:910c:76fb with SMTP id 5b1f17b1804b1-49d01dd415bmr278776245e9.2.1789034957523;
        Thu, 10 Sep 2026 03:09:17 -0700 (PDT)
Received: from jwang-ThinkPad-T14-Gen-6.fkb.profitbricks.net ([212.227.34.98])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49d26b7332asm65567875e9.0.2026.09.10.03.09.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2026 03:09:17 -0700 (PDT)
From: Jack Wang <jinpu.wang@ionos.com>
To: linux-block@vger.kernel.org,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: Jack Wang <jinpu.wang@cloud.ionos.com>
Subject: [PATCH blktests] tests/md: add test 005 for raid1 deadlock under I/O, limit changes and recovery
Date: Thu, 10 Sep 2026 12:09:16 +0200
Message-ID: <20260910100916.1638378-1-jinpu.wang@ionos.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jack Wang <jinpu.wang@cloud.ionos.com>

Add a regression test for a deadlock reported against raid1 with an
internal bitmap, where concurrent I/O, queue limit updates
(max_sectors_kb) and device fail/remove/add (recovery) cycles can
deadlock.

The test creates a raid1 array with an internal bitmap on two brd
devices, drives it with fio while repeatedly toggling
max_sectors_kb and cycling one member through fail/remove/add, and
flags a likely deadlock if any of these steps fail to make progress
within a bounded timeout.

Link: https://lore.kernel.org/linux-raid/CAMGffE=heGA3y8FjQ0Sm1jj-kd-=H9Y54WozKASSEZhc9UNKjA@mail.gmail.com/T/#t
Signed-off-by: Jack Wang <jinpu.wang@cloud.ionos.com>
---
 tests/md/005     | 142 +++++++++++++++++++++++++++++++++++++++++++++++
 tests/md/005.out |   2 +
 2 files changed, 144 insertions(+)
 create mode 100755 tests/md/005
 create mode 100644 tests/md/005.out

diff --git a/tests/md/005 b/tests/md/005
new file mode 100755
index 000000000000..5493d0edc933
--- /dev/null
+++ b/tests/md/005
@@ -0,0 +1,142 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-3.0+
+# Copyright (C) 2026 Jack Wang
+#
+# Regression test for a deadlock reported against raid1 with an internal
+# bitmap, where concurrent I/O, queue limit updates (max_sectors_kb) and
+# device fail/remove/add cycles (recovery) can deadlock.
+#
+# See: https://lore.kernel.org/linux-raid/CAMGffE=heGA3y8FjQ0Sm1jj-kd-=H9Y54WozKASSEZhc9UNKjA@mail.gmail.com/T/#t
+
+. tests/md/rc
+. common/brd
+. common/fio
+
+DESCRIPTION="test for raid1 deadlock with internal bitmap under I/O, queue limit changes and fail/remove/add"
+
+requires() {
+	_have_fio
+	_have_driver raid1
+	_have_brd
+}
+
+# Resolve the real md device node (e.g. "md126") backing /dev/ram0 via
+# sysfs. This is more reliable than the mdadm-requested /dev/md/<name>
+# symlink, whose creation depends on udev rules/timing that can vary
+# across systems.
+_resolve_md_dev() {
+	local holder
+
+	for holder in /sys/class/block/ram0/holders/*; do
+		[[ -e $holder ]] || continue
+		basename "$(readlink -f "$holder")"
+		return 0
+	done
+
+	return 1
+}
+
+_toggle_max_sectors_kb() {
+	local sysfs_attr="/sys/block/${1}/queue/max_sectors_kb"
+
+	while [[ -e "$sysfs_attr" ]]; do
+		echo 128 > "$sysfs_attr" 2>/dev/null
+	done
+}
+
+# Wait up to $2 seconds for background pid $1 to exit. Returns 1 only if
+# it is still running once the deadline is hit (a real hang); the pid's
+# own exit status is irrelevant here and is not propagated.
+_wait_pid_timeout() {
+	local pid=$1
+	local secs=$2
+	local waited=0
+
+	while kill -0 "$pid" 2>/dev/null; do
+		if ((waited >= secs)); then
+			return 1
+		fi
+		sleep 1
+		((waited++))
+	done
+
+	wait "$pid" 2>/dev/null
+	return 0
+}
+
+# Repeatedly fail/remove/add a member while I/O is ongoing, racing
+# recovery against I/O submission and queue limit updates. mdadm --wait
+# returns failure when there was nothing to wait for (e.g. a fail/remove/
+# add cycle that didn't actually trigger recovery), which is expected and
+# not itself a sign of trouble here; a real hang is instead caught by the
+# overall `timeout` this is invoked under.
+_fail_remove_add_loop() {
+	local md_dev=$1
+	local i
+
+	for ((i = 0; i < 10; i++)); do
+		mdadm "/dev/${md_dev}" --fail /dev/ram0
+		mdadm "/dev/${md_dev}" --remove /dev/ram0
+		mdadm "/dev/${md_dev}" --add /dev/ram0
+		mdadm --wait "/dev/${md_dev}"
+	done
+}
+export -f _fail_remove_add_loop
+
+test() {
+	echo "Running ${TEST_NAME}"
+
+	local md_dev
+	local toggle_pid
+	local fio_pid
+
+	if ! _init_brd rd_size=262144 rd_nr=2; then
+		return 1
+	fi
+
+	mdadm --quiet --create /dev/md/blktests_md --force -e 1.2 \
+		--assume-clean --level=1 --bitmap=internal --raid-devices=2 \
+		/dev/ram0 /dev/ram1 >> "$FULL" 2>&1
+
+	if ! md_dev=$(_resolve_md_dev); then
+		echo "failed to resolve md device for /dev/ram0"
+		_cleanup_brd
+		return 1
+	fi
+
+	# Keep writing to max_sectors_kb while I/O and recovery are ongoing,
+	# this races queue limit updates against I/O submission and md
+	# reconfiguration.
+	_toggle_max_sectors_kb "$md_dev" &
+	toggle_pid=$!
+
+	fio --direct=1 --rw=randrw --ioengine=libaio --iodepth=32 --numjobs=4 \
+		--time_based=1 --runtime=60 --filename="/dev/${md_dev}" \
+		--name=repro >> "$FULL" 2>&1 &
+	fio_pid=$!
+
+	# Give fio a moment to start driving I/O so the array is in
+	# read-write mode before failing/adding a member below.
+	sleep 2
+
+	# shellcheck disable=SC2016
+	if ! timeout 120 bash -c '_fail_remove_add_loop "$1"' _ "$md_dev" \
+		>> "$FULL" 2>&1; then
+		echo "fail/remove/add loop did not complete in time, possible deadlock"
+	fi
+
+	if ! _wait_pid_timeout "$fio_pid" 90; then
+		echo "fio did not complete in time, possible deadlock"
+		kill -9 "$fio_pid" 2>/dev/null
+	fi
+
+	kill "$toggle_pid" 2>/dev/null
+	wait "$toggle_pid" 2>/dev/null
+
+	if ! timeout 30 mdadm --quiet --stop "/dev/${md_dev}" >> "$FULL" 2>&1; then
+		echo "mdadm --stop timed out, possible deadlock"
+	fi
+	_cleanup_brd
+
+	echo "Test complete"
+}
diff --git a/tests/md/005.out b/tests/md/005.out
new file mode 100644
index 000000000000..d5ca24713e54
--- /dev/null
+++ b/tests/md/005.out
@@ -0,0 +1,2 @@
+Running md/005
+Test complete
-- 
2.43.0

