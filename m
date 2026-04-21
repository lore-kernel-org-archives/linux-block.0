Received: from mail-oo1-f99.google.com (mail-oo1-f99.google.com [209.85.161.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D127E3DD52D
	for <linux-block@vger.kernel.org>; Tue, 21 Apr 2026 20:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776802155; cv=none; b=t32ZtjomId9qK3C0KnTsrlYNLTx4tFIDS3QyOvk1zVk9YuJa14t0E8Cj282/kodJIQhPd9V8PAA2QU71KhEsCKJ4skCMq672MGhEr2DtVQ2xVGGtRKueXfrZFIB5ntDFDRXNA1MjbhDLZnJtCo+t0ArlDELPa/xLbbjr9dvM+3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776802155; c=relaxed/simple;
	bh=3bZzptENpoBqzIHXaVa0LkMXfgfRwFVRlUiPmM914Fc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bx5RKxfOW7JZPohWjPqwAYdf7bcQugNZZCQrnlq2t41FBzcMIOXmotk/17oDZVm2JS7+LNAl3D151RGqyjYocWvSxDIHKa17VcnKk6psCG2fBd3EF+KAw17/eQrILxKnsUwk3Dn4xIEO0Pqnds+72RXpYFiPJrIMMFBIUZHBWn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=PF20AzFX; arc=none smtp.client-ip=209.85.161.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="PF20AzFX"
Received: by mail-oo1-f99.google.com with SMTP id 006d021491bc7-66b0418ebe7so190808eaf.1
        for <linux-block@vger.kernel.org>; Tue, 21 Apr 2026 13:09:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1776802146; x=1777406946; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5HbzcGaNxncNlRgz3rnOziXXo7yuHKny0NAgQHvZ9SM=;
        b=PF20AzFXke0vC/c2Jm+OzcjFwB5cCZzV7xxuXiTb/uNTquHQIAU4/4mby8ZZKskvHE
         +epERBGXmHPsmcuhLRTfyObsMjM1Yk7WtDbKlZjAbS9lRa316Gz5MGzVTexOOhgnxJs+
         /9x546n/Gwv6e1veEKJN36nZezqufUMXu9AmLPlU2KYVYwe+MKOU9YcQmjtQJBUMfezz
         X8QIMYUWhTXeFr3wQsPvKF/KjSyTphRjVkRVxDSAQYovIpna02GHVxF6Uo5qMNIe58MU
         nflTJ+ejPVkhMnERXu+uFGnfWMvDhyPHP132I9daVOigrS+FrW1b5TpwR5QNm2b0F++Y
         a6rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776802146; x=1777406946;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5HbzcGaNxncNlRgz3rnOziXXo7yuHKny0NAgQHvZ9SM=;
        b=BtbZxHKEsmhQUjoX3RUppFqAzDAFqfWWNGBzdpp2vO59zLKiTvHn/chPUayPby4BJE
         P8OJhEJ26dXWWSHt3anY3FbAsp+82igLC7MU8lGLjYcyCDpMyWOo60A639FJmxjDkNPN
         QKHV5zVEJyL8mPkpSNNwC03RkXq8b0J3Ep/BXc5FAcYmAFCtr2D6wbVgPk6NzflWd6Mu
         Hu2ge8TGZFq2Tad0EVj14BHhgKs63/x782mcja8coBaVx5o+TWLjyAL7Xsl4LVjeIkt5
         AQA4Sp2fPLBd3Dg4VxH5KsXAk7toJuyFYLqD26JquhylDDg4QN3LRJSc1PyrCdDcLEBq
         hJpw==
X-Forwarded-Encrypted: i=1; AFNElJ822wOpXszODXWKeLNIcF56ENZ0Ocg4ojORqwqTjnxrtF4+I0wne6sVH5PpugKUksn79fMzxZ6XuP4PRw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2mpI5i4T0BDClQjBFAh6kJvfWHaMu4+MCob+e5MZabXsU+gHY
	m44hGLi2LW2dVdo/8HKOMHWTY7tgV+CsCz2NsWjuNkUnQolcsoCtmBd60HtlZxSeiScBCIHGP6h
	J0yMwK3x1kDI1IgDlV0Zptj8aWdMX/Z1tQYw6
X-Gm-Gg: AeBDieuciyIAGmqPbsgU4JMJjtNJi7rtnj1pNT6FXr1+1sKOG54vgToGloea9MTuwB8
	DByx68mUQgZgHoT1YIchU5BmNig3iJWV+lKmOClpOXtIifoTeFU1jSkQ6+s177i82n/e81dv/tM
	447DHb8iMOOjjrhlDxn1pkwPHI1JYg+ZUpdkWvrUkrRpPsUJzAauCqeOZ937nb6OC91zk74bBEy
	6tslnPyZx9aP8+aOLKlPSpIRQccAOO/tZiG42xfVjJ7zrndTMn0pWJsygTXVHYtAFJLL1GdvfDt
	iDgTZ4n24YR23NDB5vsUixVYNVRW/cCjH4urYftZWiat/685Ud50Hgq2tWdr9HYn4r+IXGGjp49
	ONp1mGTytSDGZKEUKziWdSrkKpOZaXvdW/xptyzaaOKLUtcNc9qFVc8PtK+agi42A
X-Received: by 2002:a05:6820:638d:b0:687:aaa0:8f59 with SMTP id 006d021491bc7-69462bec543mr3736693eaf.0.1776802145646;
        Tue, 21 Apr 2026 13:09:05 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([208.88.159.129])
        by smtp-relay.gmail.com with ESMTPS id 006d021491bc7-694918cf79esm258207eaf.12.2026.04.21.13.09.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 13:09:05 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.112.29.101])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 42AF03405FC;
	Tue, 21 Apr 2026 14:09:05 -0600 (MDT)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id 3DBDCE41A9F; Tue, 21 Apr 2026 14:09:05 -0600 (MDT)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Ming Lei <tom.leiming@gmail.com>,
	Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: [PATCH 1/3] selftests: ublk: remove unused argument to _cleanup
Date: Tue, 21 Apr 2026 14:08:59 -0600
Message-ID: <20260421200901.1528842-2-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20260421200901.1528842-1-csander@purestorage.com>
References: <20260421200901.1528842-1-csander@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The _cleanup helper function doesn't take any arguments, so drop them
from its callers.

Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
---
 tools/testing/selftests/ublk/test_batch_01.sh   | 4 ++--
 tools/testing/selftests/ublk/test_batch_02.sh   | 2 +-
 tools/testing/selftests/ublk/test_batch_03.sh   | 2 +-
 tools/testing/selftests/ublk/test_generic_02.sh | 4 ++--
 tools/testing/selftests/ublk/test_generic_03.sh | 2 +-
 tools/testing/selftests/ublk/test_generic_06.sh | 2 +-
 tools/testing/selftests/ublk/test_generic_07.sh | 2 +-
 tools/testing/selftests/ublk/test_generic_08.sh | 4 ++--
 tools/testing/selftests/ublk/test_generic_09.sh | 2 +-
 tools/testing/selftests/ublk/test_generic_10.sh | 2 +-
 tools/testing/selftests/ublk/test_generic_12.sh | 4 ++--
 tools/testing/selftests/ublk/test_generic_13.sh | 2 +-
 tools/testing/selftests/ublk/test_generic_16.sh | 4 ++--
 tools/testing/selftests/ublk/test_generic_17.sh | 2 +-
 tools/testing/selftests/ublk/test_loop_01.sh    | 2 +-
 tools/testing/selftests/ublk/test_loop_02.sh    | 2 +-
 tools/testing/selftests/ublk/test_loop_03.sh    | 2 +-
 tools/testing/selftests/ublk/test_loop_04.sh    | 2 +-
 tools/testing/selftests/ublk/test_loop_05.sh    | 2 +-
 tools/testing/selftests/ublk/test_loop_06.sh    | 2 +-
 tools/testing/selftests/ublk/test_loop_07.sh    | 2 +-
 tools/testing/selftests/ublk/test_null_01.sh    | 2 +-
 tools/testing/selftests/ublk/test_null_02.sh    | 2 +-
 tools/testing/selftests/ublk/test_null_03.sh    | 2 +-
 tools/testing/selftests/ublk/test_part_01.sh    | 4 ++--
 tools/testing/selftests/ublk/test_part_02.sh    | 2 +-
 tools/testing/selftests/ublk/test_recover_01.sh | 2 +-
 tools/testing/selftests/ublk/test_recover_02.sh | 2 +-
 tools/testing/selftests/ublk/test_recover_03.sh | 2 +-
 tools/testing/selftests/ublk/test_recover_04.sh | 2 +-
 tools/testing/selftests/ublk/test_shmemzc_01.sh | 2 +-
 tools/testing/selftests/ublk/test_shmemzc_02.sh | 2 +-
 tools/testing/selftests/ublk/test_shmemzc_03.sh | 2 +-
 tools/testing/selftests/ublk/test_shmemzc_04.sh | 2 +-
 tools/testing/selftests/ublk/test_stress_01.sh  | 2 +-
 tools/testing/selftests/ublk/test_stress_02.sh  | 2 +-
 tools/testing/selftests/ublk/test_stress_03.sh  | 2 +-
 tools/testing/selftests/ublk/test_stress_04.sh  | 2 +-
 tools/testing/selftests/ublk/test_stress_05.sh  | 2 +-
 tools/testing/selftests/ublk/test_stress_06.sh  | 2 +-
 tools/testing/selftests/ublk/test_stress_07.sh  | 2 +-
 tools/testing/selftests/ublk/test_stress_08.sh  | 2 +-
 tools/testing/selftests/ublk/test_stress_09.sh  | 2 +-
 tools/testing/selftests/ublk/test_stripe_01.sh  | 2 +-
 tools/testing/selftests/ublk/test_stripe_02.sh  | 2 +-
 tools/testing/selftests/ublk/test_stripe_03.sh  | 2 +-
 tools/testing/selftests/ublk/test_stripe_04.sh  | 2 +-
 tools/testing/selftests/ublk/test_stripe_05.sh  | 2 +-
 tools/testing/selftests/ublk/test_stripe_06.sh  | 2 +-
 49 files changed, 55 insertions(+), 55 deletions(-)

diff --git a/tools/testing/selftests/ublk/test_batch_01.sh b/tools/testing/selftests/ublk/test_batch_01.sh
index a18fb39af8be..6e19303706a9 100755
--- a/tools/testing/selftests/ublk/test_batch_01.sh
+++ b/tools/testing/selftests/ublk/test_batch_01.sh
@@ -16,16 +16,16 @@ _create_backfile 1 256M
 
 dev_id=$(_add_ublk_dev -t loop -q 2 -b "${UBLK_BACKFILES[0]}")
 _check_add_dev $TID $?
 
 if ! _mkfs_mount_test /dev/ublkb"${dev_id}"; then
-	_cleanup_test "generic"
+	_cleanup_test
 	_show_result $TID 255
 fi
 
 dev_id=$(_add_ublk_dev -t stripe -b --auto_zc "${UBLK_BACKFILES[0]}" "${UBLK_BACKFILES[1]}")
 _check_add_dev $TID $?
 _mkfs_mount_test /dev/ublkb"${dev_id}"
 ERR_CODE=$?
 
-_cleanup_test "generic"
+_cleanup_test
 _show_result $TID $ERR_CODE
diff --git a/tools/testing/selftests/ublk/test_batch_02.sh b/tools/testing/selftests/ublk/test_batch_02.sh
index 7ca384d11987..7c683f755379 100755
--- a/tools/testing/selftests/ublk/test_batch_02.sh
+++ b/tools/testing/selftests/ublk/test_batch_02.sh
@@ -23,7 +23,7 @@ _check_add_dev $TID $?
 # run fio over the ublk disk
 fio --name=job1 --filename=/dev/ublkb"${dev_id}" --ioengine=libaio --rw=readwrite \
 	--iodepth=32 --size=100M --numjobs=4 > /dev/null 2>&1
 ERR_CODE=$?
 
-_cleanup_test "generic"
+_cleanup_test
 _show_result $TID $ERR_CODE
diff --git a/tools/testing/selftests/ublk/test_batch_03.sh b/tools/testing/selftests/ublk/test_batch_03.sh
index aca9cf144b55..914ccd6a335d 100755
--- a/tools/testing/selftests/ublk/test_batch_03.sh
+++ b/tools/testing/selftests/ublk/test_batch_03.sh
@@ -23,7 +23,7 @@ _check_add_dev $TID $?
 # run fio over the ublk disk
 fio --name=job1 --filename=/dev/ublkb"${dev_id}" --ioengine=libaio --rw=readwrite \
 	--iodepth=32 --size=100M --numjobs=4 > /dev/null 2>&1
 ERR_CODE=$?
 
-_cleanup_test "generic"
+_cleanup_test
 _show_result $TID $ERR_CODE
diff --git a/tools/testing/selftests/ublk/test_generic_02.sh b/tools/testing/selftests/ublk/test_generic_02.sh
index 46b657143fd6..2afc8cdbed8f 100755
--- a/tools/testing/selftests/ublk/test_generic_02.sh
+++ b/tools/testing/selftests/ublk/test_generic_02.sh
@@ -27,11 +27,11 @@ for _ in $(seq 100); do
 	grep -q "BPFTRACE_READY" "$UBLK_TMP" 2>/dev/null && break
 	sleep 0.1
 done
 
 if ! kill -0 "$btrace_pid" 2>/dev/null; then
-	_cleanup_test "null"
+	_cleanup_test
 	exit "$UBLK_SKIP_CODE"
 fi
 
 # run fio over this ublk disk (pinned to CPU 0)
 taskset -c 0 fio --name=write_seq \
@@ -49,7 +49,7 @@ wait
 if grep -q "^out_of_order:" "$UBLK_TMP"; then
 	echo "I/O reordering detected:"
 	grep "^out_of_order:" "$UBLK_TMP"
 	ERR_CODE=255
 fi
-_cleanup_test "null"
+_cleanup_test
 _show_result $TID $ERR_CODE
diff --git a/tools/testing/selftests/ublk/test_generic_03.sh b/tools/testing/selftests/ublk/test_generic_03.sh
index 8934ea926762..8e78be860d34 100755
--- a/tools/testing/selftests/ublk/test_generic_03.sh
+++ b/tools/testing/selftests/ublk/test_generic_03.sh
@@ -21,7 +21,7 @@ if [ "$max_segments" != "32" ]; then
 	ERR_CODE=255
 fi
 if [ "$max_segment_size" != "32768" ]; then
 	ERR_CODE=255
 fi
-_cleanup_test "null"
+_cleanup_test
 _show_result $TID $ERR_CODE
diff --git a/tools/testing/selftests/ublk/test_generic_06.sh b/tools/testing/selftests/ublk/test_generic_06.sh
index 14a05054fcd8..a8b3634b6b4b 100755
--- a/tools/testing/selftests/ublk/test_generic_06.sh
+++ b/tools/testing/selftests/ublk/test_generic_06.sh
@@ -34,7 +34,7 @@ fi
 if [ $ELAPSED -ge 5 ]; then
         echo "dd took $ELAPSED seconds to exit (>= 5s tolerance)!"
         ERR_CODE=255
 fi
 
-_cleanup_test "fault_inject"
+_cleanup_test
 _show_result $TID $ERR_CODE
diff --git a/tools/testing/selftests/ublk/test_generic_07.sh b/tools/testing/selftests/ublk/test_generic_07.sh
index 8dcfd8978f50..d2c5e65bd124 100755
--- a/tools/testing/selftests/ublk/test_generic_07.sh
+++ b/tools/testing/selftests/ublk/test_generic_07.sh
@@ -21,7 +21,7 @@ ERR_CODE=$?
 if [ "$ERR_CODE" -eq 0 ]; then
 	_mkfs_mount_test /dev/ublkb"${dev_id}"
 	ERR_CODE=$?
 fi
 
-_cleanup_test "generic"
+_cleanup_test
 _show_result $TID $ERR_CODE
diff --git a/tools/testing/selftests/ublk/test_generic_08.sh b/tools/testing/selftests/ublk/test_generic_08.sh
index ce88c31d6b9c..77a18b313f3d 100755
--- a/tools/testing/selftests/ublk/test_generic_08.sh
+++ b/tools/testing/selftests/ublk/test_generic_08.sh
@@ -16,16 +16,16 @@ _create_backfile 1 256M
 
 dev_id=$(_add_ublk_dev -t loop -q 2 --auto_zc "${UBLK_BACKFILES[0]}")
 _check_add_dev $TID $?
 
 if ! _mkfs_mount_test /dev/ublkb"${dev_id}"; then
-	_cleanup_test "generic"
+	_cleanup_test
 	_show_result $TID 255
 fi
 
 dev_id=$(_add_ublk_dev -t stripe --auto_zc "${UBLK_BACKFILES[0]}" "${UBLK_BACKFILES[1]}")
 _check_add_dev $TID $?
 _mkfs_mount_test /dev/ublkb"${dev_id}"
 ERR_CODE=$?
 
-_cleanup_test "generic"
+_cleanup_test
 _show_result $TID $ERR_CODE
diff --git a/tools/testing/selftests/ublk/test_generic_09.sh b/tools/testing/selftests/ublk/test_generic_09.sh
index 744d0cdaa242..6c25242f245f 100755
--- a/tools/testing/selftests/ublk/test_generic_09.sh
+++ b/tools/testing/selftests/ublk/test_generic_09.sh
@@ -20,8 +20,8 @@ _check_add_dev $TID $?
 
 # run fio over the two disks
 fio --name=job1 --filename=/dev/ublkb"${dev_id}" --ioengine=libaio --rw=readwrite --iodepth=32 --size=256M > /dev/null 2>&1
 ERR_CODE=$?
 
-_cleanup_test "null"
+_cleanup_test
 
 _show_result $TID $ERR_CODE
diff --git a/tools/testing/selftests/ublk/test_generic_10.sh b/tools/testing/selftests/ublk/test_generic_10.sh
index 4b4293b9081f..fdabc9d9075e 100755
--- a/tools/testing/selftests/ublk/test_generic_10.sh
+++ b/tools/testing/selftests/ublk/test_generic_10.sh
@@ -23,7 +23,7 @@ fi
 new_size=$(_get_disk_size /dev/ublkb"${dev_id}")
 if [ "$new_size" != "$size" ]; then
 	ERR_CODE=255
 fi
 
-_cleanup_test "null"
+_cleanup_test
 _show_result $TID $ERR_CODE
diff --git a/tools/testing/selftests/ublk/test_generic_12.sh b/tools/testing/selftests/ublk/test_generic_12.sh
index 54b81ddfe9f9..435497f8da8d 100755
--- a/tools/testing/selftests/ublk/test_generic_12.sh
+++ b/tools/testing/selftests/ublk/test_generic_12.sh
@@ -23,11 +23,11 @@ dev_t=$(_get_disk_dev_t "$dev_id")
 bpftrace trace/count_ios_per_tid.bt "$dev_t" > "$UBLK_TMP" 2>&1 &
 btrace_pid=$!
 sleep 2
 
 if ! kill -0 "$btrace_pid" > /dev/null 2>&1; then
-	_cleanup_test "null"
+	_cleanup_test
 	exit "$UBLK_SKIP_CODE"
 fi
 
 # do imbalanced I/O on the ublk device
 # pin to cpu 0 to prevent migration/only target one queue
@@ -52,7 +52,7 @@ if [[ $NR_THREADS_THAT_HANDLED_IO -ne $NTHREADS ]]; then
         echo "only $NR_THREADS_THAT_HANDLED_IO handled I/O! expected $NTHREADS"
         cat "$UBLK_TMP"
         ERR_CODE=255
 fi
 
-_cleanup_test "null"
+_cleanup_test
 _show_result $TID $ERR_CODE
diff --git a/tools/testing/selftests/ublk/test_generic_13.sh b/tools/testing/selftests/ublk/test_generic_13.sh
index 922115aa14f4..2c1be6286db8 100755
--- a/tools/testing/selftests/ublk/test_generic_13.sh
+++ b/tools/testing/selftests/ublk/test_generic_13.sh
@@ -13,7 +13,7 @@ if ${UBLK_PROG} features | grep -q unknown; then
         echo "# this failure is expected if running an older test suite against"
         echo "# a newer kernel with new features added"
         ERR_CODE=255
 fi
 
-_cleanup_test "null"
+_cleanup_test
 _show_result $TID $ERR_CODE
diff --git a/tools/testing/selftests/ublk/test_generic_16.sh b/tools/testing/selftests/ublk/test_generic_16.sh
index 3ef367836ac5..6a4952146ea1 100755
--- a/tools/testing/selftests/ublk/test_generic_16.sh
+++ b/tools/testing/selftests/ublk/test_generic_16.sh
@@ -7,11 +7,11 @@ ERR_CODE=0
 
 _prep_test "null" "stop --safe command"
 
 # Check if SAFE_STOP_DEV feature is supported
 if ! _have_feature "SAFE_STOP_DEV"; then
-	_cleanup_test "null"
+	_cleanup_test
 	exit "$UBLK_SKIP_CODE"
 fi
 
 # Test 1: stop --safe on idle device should succeed
 dev_id=$(_add_ublk_dev -t null -q 2 -d 32)
@@ -50,7 +50,7 @@ wait $dd_pid 2>/dev/null
 
 # Now device should be idle, regular delete should work
 _ublk_del_dev "${dev_id}"
 udevadm settle
 
-_cleanup_test "null"
+_cleanup_test
 _show_result $TID $ERR_CODE
diff --git a/tools/testing/selftests/ublk/test_generic_17.sh b/tools/testing/selftests/ublk/test_generic_17.sh
index 2278b5fc9dba..b483d53a897a 100755
--- a/tools/testing/selftests/ublk/test_generic_17.sh
+++ b/tools/testing/selftests/ublk/test_generic_17.sh
@@ -29,7 +29,7 @@ fi
 # Clean up the device. This can only succeed once teardown of the above
 # exited ublk server completes. So if teardown never completes, we will
 # time out here
 _ublk_del_dev "${dev_id}"
 
-_cleanup_test "fault_inject"
+_cleanup_test
 _show_result $TID $ERR_CODE
diff --git a/tools/testing/selftests/ublk/test_loop_01.sh b/tools/testing/selftests/ublk/test_loop_01.sh
index 338a235fd82a..c0f5b619ad6e 100755
--- a/tools/testing/selftests/ublk/test_loop_01.sh
+++ b/tools/testing/selftests/ublk/test_loop_01.sh
@@ -18,8 +18,8 @@ _check_add_dev $TID $?
 
 # run fio over the ublk disk
 _run_fio_verify_io --filename=/dev/ublkb"${dev_id}" --size=256M
 ERR_CODE=$?
 
-_cleanup_test "loop"
+_cleanup_test
 
 _show_result $TID $ERR_CODE
diff --git a/tools/testing/selftests/ublk/test_loop_02.sh b/tools/testing/selftests/ublk/test_loop_02.sh
index 04c52454e2ec..f4191ea71f50 100755
--- a/tools/testing/selftests/ublk/test_loop_02.sh
+++ b/tools/testing/selftests/ublk/test_loop_02.sh
@@ -12,8 +12,8 @@ dev_id=$(_add_ublk_dev -t loop "${UBLK_BACKFILES[0]}")
 _check_add_dev $TID $?
 
 _mkfs_mount_test /dev/ublkb"${dev_id}"
 ERR_CODE=$?
 
-_cleanup_test "loop"
+_cleanup_test
 
 _show_result $TID $ERR_CODE
diff --git a/tools/testing/selftests/ublk/test_loop_03.sh b/tools/testing/selftests/ublk/test_loop_03.sh
index 6e8f649fe93d..aaac0c59a5ad 100755
--- a/tools/testing/selftests/ublk/test_loop_03.sh
+++ b/tools/testing/selftests/ublk/test_loop_03.sh
@@ -17,8 +17,8 @@ _check_add_dev $TID $?
 
 # run fio over the ublk disk
 _run_fio_verify_io --filename=/dev/ublkb"${dev_id}" --size=256M
 ERR_CODE=$?
 
-_cleanup_test "loop"
+_cleanup_test
 
 _show_result $TID $ERR_CODE
diff --git a/tools/testing/selftests/ublk/test_loop_04.sh b/tools/testing/selftests/ublk/test_loop_04.sh
index 9f6774ec0de6..f584c119f1d2 100755
--- a/tools/testing/selftests/ublk/test_loop_04.sh
+++ b/tools/testing/selftests/ublk/test_loop_04.sh
@@ -13,8 +13,8 @@ dev_id=$(_add_ublk_dev -t loop -z "${UBLK_BACKFILES[0]}")
 _check_add_dev $TID $?
 
 _mkfs_mount_test /dev/ublkb"${dev_id}"
 ERR_CODE=$?
 
-_cleanup_test "loop"
+_cleanup_test
 
 _show_result $TID $ERR_CODE
diff --git a/tools/testing/selftests/ublk/test_loop_05.sh b/tools/testing/selftests/ublk/test_loop_05.sh
index 2b8d99e007be..ca1a5df5f9de 100755
--- a/tools/testing/selftests/ublk/test_loop_05.sh
+++ b/tools/testing/selftests/ublk/test_loop_05.sh
@@ -18,8 +18,8 @@ _check_add_dev $TID $?
 
 # run fio over the ublk disk
 _run_fio_verify_io --filename=/dev/ublkb"${dev_id}" --size=256M
 ERR_CODE=$?
 
-_cleanup_test "loop"
+_cleanup_test
 
 _show_result $TID $ERR_CODE
diff --git a/tools/testing/selftests/ublk/test_loop_06.sh b/tools/testing/selftests/ublk/test_loop_06.sh
index e73f6f4844db..26f710ba9db7 100755
--- a/tools/testing/selftests/ublk/test_loop_06.sh
+++ b/tools/testing/selftests/ublk/test_loop_06.sh
@@ -17,8 +17,8 @@ _check_add_dev $TID $?
 
 # run fio over the ublk disk
 _run_fio_verify_io --filename=/dev/ublkb"${dev_id}" --size=256M
 ERR_CODE=$?
 
-_cleanup_test "loop"
+_cleanup_test
 
 _show_result $TID $ERR_CODE
diff --git a/tools/testing/selftests/ublk/test_loop_07.sh b/tools/testing/selftests/ublk/test_loop_07.sh
index 264d20e7c530..a9ab0b671cb2 100755
--- a/tools/testing/selftests/ublk/test_loop_07.sh
+++ b/tools/testing/selftests/ublk/test_loop_07.sh
@@ -13,8 +13,8 @@ dev_id=$(_add_ublk_dev -t loop -u "${UBLK_BACKFILES[0]}")
 _check_add_dev $TID $?
 
 _mkfs_mount_test /dev/ublkb"${dev_id}"
 ERR_CODE=$?
 
-_cleanup_test "loop"
+_cleanup_test
 
 _show_result $TID $ERR_CODE
diff --git a/tools/testing/selftests/ublk/test_null_01.sh b/tools/testing/selftests/ublk/test_null_01.sh
index eebce8076530..d2c38cbb2dd5 100755
--- a/tools/testing/selftests/ublk/test_null_01.sh
+++ b/tools/testing/selftests/ublk/test_null_01.sh
@@ -16,8 +16,8 @@ _check_add_dev $TID $?
 
 # run fio over the two disks
 fio --name=job1 --filename=/dev/ublkb"${dev_id}" --ioengine=libaio --rw=readwrite --iodepth=32 --size=256M > /dev/null 2>&1
 ERR_CODE=$?
 
-_cleanup_test "null"
+_cleanup_test
 
 _show_result $TID $ERR_CODE
diff --git a/tools/testing/selftests/ublk/test_null_02.sh b/tools/testing/selftests/ublk/test_null_02.sh
index 654bdff39664..7b205ca56367 100755
--- a/tools/testing/selftests/ublk/test_null_02.sh
+++ b/tools/testing/selftests/ublk/test_null_02.sh
@@ -16,8 +16,8 @@ _check_add_dev $TID $?
 
 # run fio over the two disks
 fio --name=job1 --filename=/dev/ublkb"${dev_id}" --ioengine=libaio --rw=readwrite --iodepth=32 --size=256M > /dev/null 2>&1
 ERR_CODE=$?
 
-_cleanup_test "null"
+_cleanup_test
 
 _show_result $TID $ERR_CODE
diff --git a/tools/testing/selftests/ublk/test_null_03.sh b/tools/testing/selftests/ublk/test_null_03.sh
index 29cd09f06672..eee7a87a60da 100755
--- a/tools/testing/selftests/ublk/test_null_03.sh
+++ b/tools/testing/selftests/ublk/test_null_03.sh
@@ -16,8 +16,8 @@ _check_add_dev $TID $?
 
 # run fio over the two disks
 fio --name=job1 --filename=/dev/ublkb"${dev_id}" --ioengine=libaio --rw=readwrite --iodepth=32 --size=256M > /dev/null 2>&1
 ERR_CODE=$?
 
-_cleanup_test "null"
+_cleanup_test
 
 _show_result $TID $ERR_CODE
diff --git a/tools/testing/selftests/ublk/test_part_01.sh b/tools/testing/selftests/ublk/test_part_01.sh
index 8028f6e4b3a5..fa3b1a9af894 100755
--- a/tools/testing/selftests/ublk/test_part_01.sh
+++ b/tools/testing/selftests/ublk/test_part_01.sh
@@ -80,11 +80,11 @@ if ! _have_program sfdisk || ! _have_program blockdev; then
 fi
 
 _prep_test "generic" "test UBLK_F_NO_AUTO_PART_SCAN"
 
 if ! _have_feature "UBLK_F_NO_AUTO_PART_SCAN"; then
-	_cleanup_test "generic"
+	_cleanup_test
 	exit "$UBLK_SKIP_CODE"
 fi
 
 
 # Create and format backing file with partition table
@@ -98,7 +98,7 @@ format_backing_file "${UBLK_BACKFILES[0]}"
 
 # Test no auto partition scan with manual scan
 [ "$ERR_CODE" -eq 0 ] && test_no_auto_part_scan "${UBLK_BACKFILES[0]}"
 [ $? -ne 0 ] && ERR_CODE=255
 
-_cleanup_test "generic"
+_cleanup_test
 _show_result $TID $ERR_CODE
diff --git a/tools/testing/selftests/ublk/test_part_02.sh b/tools/testing/selftests/ublk/test_part_02.sh
index 7d42ab4d6e83..d9ec06f36aee 100755
--- a/tools/testing/selftests/ublk/test_part_02.sh
+++ b/tools/testing/selftests/ublk/test_part_02.sh
@@ -61,7 +61,7 @@ _prep_test "partition_scan" "verify async partition scan prevents IO hang"
 _test_partition_scan_no_hang "no" "DEAD"
 
 # Test 2: With recovery support - should transition to QUIESCED
 _test_partition_scan_no_hang "yes" "QUIESCED"
 
-_cleanup_test "partition_scan"
+_cleanup_test
 _show_result $TID $ERR_CODE
diff --git a/tools/testing/selftests/ublk/test_recover_01.sh b/tools/testing/selftests/ublk/test_recover_01.sh
index 2672f9c40fa8..1cddc2345dab 100755
--- a/tools/testing/selftests/ublk/test_recover_01.sh
+++ b/tools/testing/selftests/ublk/test_recover_01.sh
@@ -38,7 +38,7 @@ wait
 ublk_run_recover_test -t null -q 2 -r 1 -i 1 &
 ublk_run_recover_test -t loop -q 2 -r 1 -i 1 "${UBLK_BACKFILES[0]}" &
 ublk_run_recover_test -t stripe -q 2 -r 1 -i 1 "${UBLK_BACKFILES[1]}" "${UBLK_BACKFILES[2]}" &
 wait
 
-_cleanup_test "recover"
+_cleanup_test
 _show_result $TID $ERR_CODE
diff --git a/tools/testing/selftests/ublk/test_recover_02.sh b/tools/testing/selftests/ublk/test_recover_02.sh
index bda5064bc31f..9c3f481880d3 100755
--- a/tools/testing/selftests/ublk/test_recover_02.sh
+++ b/tools/testing/selftests/ublk/test_recover_02.sh
@@ -42,7 +42,7 @@ wait
 ublk_run_recover_test -t null -q 2 -r 1 -z -i 1 &
 ublk_run_recover_test -t loop -q 2 -r 1 -z -i 1 "${UBLK_BACKFILES[0]}" &
 ublk_run_recover_test -t stripe -q 2 -r 1 -z -i 1 "${UBLK_BACKFILES[1]}" "${UBLK_BACKFILES[2]}" &
 wait
 
-_cleanup_test "recover"
+_cleanup_test
 _show_result $TID $ERR_CODE
diff --git a/tools/testing/selftests/ublk/test_recover_03.sh b/tools/testing/selftests/ublk/test_recover_03.sh
index e0dc0b8fe5d6..2554805e5b02 100755
--- a/tools/testing/selftests/ublk/test_recover_03.sh
+++ b/tools/testing/selftests/ublk/test_recover_03.sh
@@ -37,7 +37,7 @@ wait
 ublk_run_quiesce_recover -t null -q 2 -r 1 -i 1 &
 ublk_run_quiesce_recover -t loop -q 2 -r 1 -i 1 "${UBLK_BACKFILES[0]}" &
 ublk_run_quiesce_recover -t stripe -q 2 -r 1 -i 1 "${UBLK_BACKFILES[1]}" "${UBLK_BACKFILES[2]}" &
 wait
 
-_cleanup_test "quiesce"
+_cleanup_test
 _show_result $TID $ERR_CODE
diff --git a/tools/testing/selftests/ublk/test_recover_04.sh b/tools/testing/selftests/ublk/test_recover_04.sh
index 178443394ca5..4c83c1840c68 100755
--- a/tools/testing/selftests/ublk/test_recover_04.sh
+++ b/tools/testing/selftests/ublk/test_recover_04.sh
@@ -33,7 +33,7 @@ wait
 ublk_run_recover_test -t null -q 2 -r 1 -u -i 1 &
 ublk_run_recover_test -t loop -q 2 -r 1 -u -i 1 "${UBLK_BACKFILES[0]}" &
 ublk_run_recover_test -t stripe -q 2 -r 1 -u -i 1 "${UBLK_BACKFILES[1]}" "${UBLK_BACKFILES[2]}" &
 wait
 
-_cleanup_test "recover"
+_cleanup_test
 _show_result $TID $ERR_CODE
diff --git a/tools/testing/selftests/ublk/test_shmemzc_01.sh b/tools/testing/selftests/ublk/test_shmemzc_01.sh
index 47210af2aa20..b244ab3479a2 100755
--- a/tools/testing/selftests/ublk/test_shmemzc_01.sh
+++ b/tools/testing/selftests/ublk/test_shmemzc_01.sh
@@ -65,8 +65,8 @@ _ublk_del_dev "${dev_id}"
 rm -f "$HTLB_FILE"
 umount "$HTLB_MNT"
 rmdir "$HTLB_MNT"
 echo "$OLD_NR_HP" > /proc/sys/vm/nr_hugepages
 
-_cleanup_test "shmem_zc"
+_cleanup_test
 
 _show_result $TID $ERR_CODE
diff --git a/tools/testing/selftests/ublk/test_shmemzc_02.sh b/tools/testing/selftests/ublk/test_shmemzc_02.sh
index aed9262494e9..810dccba6d84 100755
--- a/tools/testing/selftests/ublk/test_shmemzc_02.sh
+++ b/tools/testing/selftests/ublk/test_shmemzc_02.sh
@@ -61,8 +61,8 @@ _ublk_del_dev "${dev_id}"
 rm -f "$HTLB_FILE"
 umount "$HTLB_MNT"
 rmdir "$HTLB_MNT"
 echo "$OLD_NR_HP" > /proc/sys/vm/nr_hugepages
 
-_cleanup_test "shmem_zc"
+_cleanup_test
 
 _show_result $TID $ERR_CODE
diff --git a/tools/testing/selftests/ublk/test_shmemzc_03.sh b/tools/testing/selftests/ublk/test_shmemzc_03.sh
index db967a9ffe81..606362491a32 100755
--- a/tools/testing/selftests/ublk/test_shmemzc_03.sh
+++ b/tools/testing/selftests/ublk/test_shmemzc_03.sh
@@ -62,8 +62,8 @@ _ublk_del_dev "${dev_id}"
 rm -f "$HTLB_FILE"
 umount "$HTLB_MNT"
 rmdir "$HTLB_MNT"
 echo "$OLD_NR_HP" > /proc/sys/vm/nr_hugepages
 
-_cleanup_test "shmem_zc"
+_cleanup_test
 
 _show_result $TID $ERR_CODE
diff --git a/tools/testing/selftests/ublk/test_shmemzc_04.sh b/tools/testing/selftests/ublk/test_shmemzc_04.sh
index 899de088ece4..9a2a6c2e8abe 100755
--- a/tools/testing/selftests/ublk/test_shmemzc_04.sh
+++ b/tools/testing/selftests/ublk/test_shmemzc_04.sh
@@ -65,8 +65,8 @@ _ublk_del_dev "${dev_id}"
 rm -f "$HTLB_FILE"
 umount "$HTLB_MNT"
 rmdir "$HTLB_MNT"
 echo "$OLD_NR_HP" > /proc/sys/vm/nr_hugepages
 
-_cleanup_test "shmem_zc"
+_cleanup_test
 
 _show_result $TID $ERR_CODE
diff --git a/tools/testing/selftests/ublk/test_stress_01.sh b/tools/testing/selftests/ublk/test_stress_01.sh
index a9322ce496e9..f91783f27649 100755
--- a/tools/testing/selftests/ublk/test_stress_01.sh
+++ b/tools/testing/selftests/ublk/test_stress_01.sh
@@ -27,7 +27,7 @@ _create_backfile 2 128M
 ublk_io_and_remove 8G -t null -q 4 &
 ublk_io_and_remove 256M -t loop -q 4 "${UBLK_BACKFILES[0]}" &
 ublk_io_and_remove 256M -t stripe -q 4 "${UBLK_BACKFILES[1]}" "${UBLK_BACKFILES[2]}" &
 wait
 
-_cleanup_test "stress"
+_cleanup_test
 _show_result $TID $ERR_CODE
diff --git a/tools/testing/selftests/ublk/test_stress_02.sh b/tools/testing/selftests/ublk/test_stress_02.sh
index 6c114194f9c9..b128d11658a8 100755
--- a/tools/testing/selftests/ublk/test_stress_02.sh
+++ b/tools/testing/selftests/ublk/test_stress_02.sh
@@ -29,7 +29,7 @@ for nr_queue in 1 4; do
 	ublk_io_and_kill_daemon 256M -t loop -q "$nr_queue" "${UBLK_BACKFILES[0]}" &
 	ublk_io_and_kill_daemon 256M -t stripe -q "$nr_queue" "${UBLK_BACKFILES[1]}" "${UBLK_BACKFILES[2]}" &
 	wait
 done
 
-_cleanup_test "stress"
+_cleanup_test
 _show_result $TID $ERR_CODE
diff --git a/tools/testing/selftests/ublk/test_stress_03.sh b/tools/testing/selftests/ublk/test_stress_03.sh
index 4e81ca0db758..a0f0aba8eebc 100755
--- a/tools/testing/selftests/ublk/test_stress_03.sh
+++ b/tools/testing/selftests/ublk/test_stress_03.sh
@@ -47,7 +47,7 @@ if _have_feature "PER_IO_DAEMON"; then
 	ublk_io_and_remove 256M -t stripe -q 4 --auto_zc --nthreads 8 --per_io_tasks "${UBLK_BACKFILES[1]}" "${UBLK_BACKFILES[2]}" &
 	ublk_io_and_remove 8G -t null -q 4 -z --auto_zc --auto_zc_fallback --nthreads 8 --per_io_tasks &
 	wait
 fi
 
-_cleanup_test "stress"
+_cleanup_test
 _show_result $TID $ERR_CODE
diff --git a/tools/testing/selftests/ublk/test_stress_04.sh b/tools/testing/selftests/ublk/test_stress_04.sh
index 6c6f44b172bc..896eae68d444 100755
--- a/tools/testing/selftests/ublk/test_stress_04.sh
+++ b/tools/testing/selftests/ublk/test_stress_04.sh
@@ -46,7 +46,7 @@ if _have_feature "PER_IO_DAEMON"; then
 	ublk_io_and_kill_daemon 256M -t stripe -q 4 --auto_zc --nthreads 8 --per_io_tasks "${UBLK_BACKFILES[1]}" "${UBLK_BACKFILES[2]}" &
 	ublk_io_and_kill_daemon 8G -t null -q 4 -z --auto_zc --auto_zc_fallback --nthreads 8 --per_io_tasks &
 	wait
 fi
 
-_cleanup_test "stress"
+_cleanup_test
 _show_result $TID $ERR_CODE
diff --git a/tools/testing/selftests/ublk/test_stress_05.sh b/tools/testing/selftests/ublk/test_stress_05.sh
index 7e9324de2030..d6c00c72080d 100755
--- a/tools/testing/selftests/ublk/test_stress_05.sh
+++ b/tools/testing/selftests/ublk/test_stress_05.sh
@@ -77,7 +77,7 @@ if _have_feature "PER_IO_DAEMON"; then
 	ublk_io_and_remove 256M -t loop -q 4 --nthreads 8 --per_io_tasks -r 1 -i "$reissue" "${UBLK_BACKFILES[0]}" &
 	ublk_io_and_remove 8G -t null -q 4 --nthreads 8 --per_io_tasks -r 1 -i "$reissue"  &
 fi
 wait
 
-_cleanup_test "stress"
+_cleanup_test
 _show_result $TID $ERR_CODE
diff --git a/tools/testing/selftests/ublk/test_stress_06.sh b/tools/testing/selftests/ublk/test_stress_06.sh
index c72e5d0b14be..9481a273a4b4 100755
--- a/tools/testing/selftests/ublk/test_stress_06.sh
+++ b/tools/testing/selftests/ublk/test_stress_06.sh
@@ -32,7 +32,7 @@ wait
 ublk_io_and_remove 8G -t null -q 4 -u --nthreads 8 --per_io_tasks &
 ublk_io_and_remove 256M -t loop -q 4 -u --nthreads 8 --per_io_tasks "${UBLK_BACKFILES[0]}" &
 ublk_io_and_remove 256M -t stripe -q 4 -u --nthreads 8 --per_io_tasks "${UBLK_BACKFILES[1]}" "${UBLK_BACKFILES[2]}" &
 wait
 
-_cleanup_test "stress"
+_cleanup_test
 _show_result $TID $ERR_CODE
diff --git a/tools/testing/selftests/ublk/test_stress_07.sh b/tools/testing/selftests/ublk/test_stress_07.sh
index 04c2764d5238..3e01c037cffb 100755
--- a/tools/testing/selftests/ublk/test_stress_07.sh
+++ b/tools/testing/selftests/ublk/test_stress_07.sh
@@ -32,7 +32,7 @@ wait
 ublk_io_and_kill_daemon 8G -t null -q 4 -u --nthreads 8 --per_io_tasks &
 ublk_io_and_kill_daemon 256M -t loop -q 4 -u --nthreads 8 --per_io_tasks "${UBLK_BACKFILES[0]}" &
 ublk_io_and_kill_daemon 256M -t stripe -q 4 -u --nthreads 8 --per_io_tasks "${UBLK_BACKFILES[1]}" "${UBLK_BACKFILES[2]}" &
 wait
 
-_cleanup_test "stress"
+_cleanup_test
 _show_result $TID $ERR_CODE
diff --git a/tools/testing/selftests/ublk/test_stress_08.sh b/tools/testing/selftests/ublk/test_stress_08.sh
index 37f7d204879a..5f32424d2892 100755
--- a/tools/testing/selftests/ublk/test_stress_08.sh
+++ b/tools/testing/selftests/ublk/test_stress_08.sh
@@ -38,7 +38,7 @@ ublk_io_and_remove 8G -t null -q 4 -b &
 ublk_io_and_remove 256M -t loop -q 4 --auto_zc -b "${UBLK_BACKFILES[0]}" &
 ublk_io_and_remove 256M -t stripe -q 4 --auto_zc -b "${UBLK_BACKFILES[1]}" "${UBLK_BACKFILES[2]}" &
 ublk_io_and_remove 8G -t null -q 4 -z --auto_zc --auto_zc_fallback -b &
 wait
 
-_cleanup_test "stress"
+_cleanup_test
 _show_result $TID $ERR_CODE
diff --git a/tools/testing/selftests/ublk/test_stress_09.sh b/tools/testing/selftests/ublk/test_stress_09.sh
index 53c1e3b2ab30..64cb8d9b0438 100755
--- a/tools/testing/selftests/ublk/test_stress_09.sh
+++ b/tools/testing/selftests/ublk/test_stress_09.sh
@@ -37,7 +37,7 @@ ublk_io_and_kill_daemon 8G -t null -q 4 -z -b &
 ublk_io_and_kill_daemon 256M -t loop -q 4 --auto_zc -b "${UBLK_BACKFILES[0]}" &
 ublk_io_and_kill_daemon 256M -t stripe -q 4 -b "${UBLK_BACKFILES[1]}" "${UBLK_BACKFILES[2]}" &
 ublk_io_and_kill_daemon 8G -t null -q 4 -z --auto_zc --auto_zc_fallback -b &
 wait
 
-_cleanup_test "stress"
+_cleanup_test
 _show_result $TID $ERR_CODE
diff --git a/tools/testing/selftests/ublk/test_stripe_01.sh b/tools/testing/selftests/ublk/test_stripe_01.sh
index 3bc821aadad8..9ffce477b461 100755
--- a/tools/testing/selftests/ublk/test_stripe_01.sh
+++ b/tools/testing/selftests/ublk/test_stripe_01.sh
@@ -19,7 +19,7 @@ _check_add_dev $TID $?
 
 # run fio over the ublk disk
 _run_fio_verify_io --filename=/dev/ublkb"${dev_id}" --size=512M
 ERR_CODE=$?
 
-_cleanup_test "stripe"
+_cleanup_test
 _show_result $TID $ERR_CODE
diff --git a/tools/testing/selftests/ublk/test_stripe_02.sh b/tools/testing/selftests/ublk/test_stripe_02.sh
index 4a7d2b21a6bf..4c172950a247 100755
--- a/tools/testing/selftests/ublk/test_stripe_02.sh
+++ b/tools/testing/selftests/ublk/test_stripe_02.sh
@@ -14,7 +14,7 @@ dev_id=$(_add_ublk_dev -t stripe "${UBLK_BACKFILES[0]}" "${UBLK_BACKFILES[1]}")
 _check_add_dev $TID $?
 
 _mkfs_mount_test /dev/ublkb"${dev_id}"
 ERR_CODE=$?
 
-_cleanup_test "stripe"
+_cleanup_test
 _show_result $TID $ERR_CODE
diff --git a/tools/testing/selftests/ublk/test_stripe_03.sh b/tools/testing/selftests/ublk/test_stripe_03.sh
index a1c159d54e53..2cdf9f958988 100755
--- a/tools/testing/selftests/ublk/test_stripe_03.sh
+++ b/tools/testing/selftests/ublk/test_stripe_03.sh
@@ -19,7 +19,7 @@ _check_add_dev $TID $?
 
 # run fio over the ublk disk
 _run_fio_verify_io --filename=/dev/ublkb"${dev_id}" --size=512M
 ERR_CODE=$?
 
-_cleanup_test "stripe"
+_cleanup_test
 _show_result $TID $ERR_CODE
diff --git a/tools/testing/selftests/ublk/test_stripe_04.sh b/tools/testing/selftests/ublk/test_stripe_04.sh
index 0c30bd6c2b3b..e24120eaca0e 100755
--- a/tools/testing/selftests/ublk/test_stripe_04.sh
+++ b/tools/testing/selftests/ublk/test_stripe_04.sh
@@ -14,7 +14,7 @@ dev_id=$(_add_ublk_dev -t stripe -z -q 2 "${UBLK_BACKFILES[0]}" "${UBLK_BACKFILE
 _check_add_dev $TID $?
 
 _mkfs_mount_test /dev/ublkb"${dev_id}"
 ERR_CODE=$?
 
-_cleanup_test "stripe"
+_cleanup_test
 _show_result $TID $ERR_CODE
diff --git a/tools/testing/selftests/ublk/test_stripe_05.sh b/tools/testing/selftests/ublk/test_stripe_05.sh
index 6ddfa88ad226..f3de2d5cdfe4 100755
--- a/tools/testing/selftests/ublk/test_stripe_05.sh
+++ b/tools/testing/selftests/ublk/test_stripe_05.sh
@@ -19,7 +19,7 @@ _check_add_dev $TID $?
 
 # run fio over the ublk disk
 _run_fio_verify_io --filename=/dev/ublkb"${dev_id}" --size=512M
 ERR_CODE=$?
 
-_cleanup_test "stripe"
+_cleanup_test
 _show_result $TID $ERR_CODE
diff --git a/tools/testing/selftests/ublk/test_stripe_06.sh b/tools/testing/selftests/ublk/test_stripe_06.sh
index a2c7bf4cc613..3fd5cd902956 100755
--- a/tools/testing/selftests/ublk/test_stripe_06.sh
+++ b/tools/testing/selftests/ublk/test_stripe_06.sh
@@ -14,7 +14,7 @@ dev_id=$(_add_ublk_dev -t stripe -u -q 2 "${UBLK_BACKFILES[0]}" "${UBLK_BACKFILE
 _check_add_dev $TID $?
 
 _mkfs_mount_test /dev/ublkb"${dev_id}"
 ERR_CODE=$?
 
-_cleanup_test "stripe"
+_cleanup_test
 _show_result $TID $ERR_CODE
-- 
2.45.2

