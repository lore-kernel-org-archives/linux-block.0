Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=160.30.148.35
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794239901;
	b=seikPZHxWVJpJFIEIHIIBJXGgCTBf91bLCsH/x68inl3+eUo6g3Ub+kHFZOrp6P41Wjw
	 yK1xgiXU40UQgssedrbHjVXNcYT7WsEQKg3VIiDoyrNB6vg/UbQh39pgqxakykWv3Vl5h
	 R8cUy4/xBU8zGQ+S8Hl6s6xRVgbHpLe7mgTG3byBDul4iOKvl/rrSl8j6NB1iCyTMuzAo
	 fRWpTEA+ABSqTcIwMUG5IwGTIAfeaaJCuYzX0cSZ2dGQc+pPyzrNa0P0ZsLWKPTQ+VDTQ
	 l+ePU/KzPvJUjp97tntP54xEGSYrYy4xgNxUZ2HBo8gCs7rWxyuV5AMBqaaHwZH9Sdg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794239901;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 X-Zmail-TransId:X-Mailer:Message-ID:Date:Mime-Version:From:To:Cc:
	 Subject:Content-Type:X-MAIL:X-TLS:X-ENVELOPE-SENDER:X-SOURCE-IP:
	 X-CLEAN:X-Fangmail-Anti-Spam-Filtered:X-Fangmail-MID-QID;
	bh=zLeBDeQcVR5Q0Jv6hH+HoARVZwuyEL/ztbGvicGzjrg=;
	b=t90ZjwwYti1rh/ODAbfwd1CDlq2XcG+jOaNDq5sI6AmgESAC5BQlEXflp7C/nObiQeta
	 LAM0eNl21zqHGX03IvTtd6JzaOxmzjIAw9/e7PAvWFVyTpXNaUFXO+Jh6aFzx5N3AyD2q
	 VYbUL+fFOaPISpDnOUjILv9LSc2in0XLZTzbZig5AFLN4wNVzt4Kh8QBIVZumrm6MH+Ie
	 dDUhCERiNfBqvl8N6CldBf8+dawY99Iztqgo4ODXPY0mToV6zBWjtSn8DtQqKDImNPcxl
	 d95UyTAEvdyrUtaEIHVhhDzsEA66fgmiD7I8EHg4binjP99wCRNGF7U+xRKe+Z69W6w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=zte.com.cn;
	spf=pass smtp.mailfrom=zte.com.cn;
	dkim=pass header.d=zte.com.cn header.i=@zte.com.cn header.a=rsa-sha256 header.s=z202610 header.b=OQLaxX+1;
	arc=none smtp.remote-ip=160.30.148.35
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [160.30.148.35])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB8DA60A2633;
	Mon,  9 Nov 2026 15:58:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BB8DA60A2633
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=zte.com.cn header.i=@zte.com.cn header.a=rsa-sha256 header.s=z202610 header.b=OQLaxX+1
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4jNZFN434Dz8Xrnw;
	Mon, 09 Nov 2026 23:58:16 +0800 (CST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=zte.com.cn;
	s=z202610; t=1794239896;
	bh=ZD5Vz0dYdMHAoRn66WdpVTqDsd56pq0fa4QdyoLKuG8=;
	h=Date:From:To:Cc:Subject;
	b=OQLaxX+11GbDnFLswRX/TE40XfrzbYOf4xISJ+RH0IThRMVMDvWrkDjjT0gKgnybs
	 g2A6o0WJyqr2mAwKUC1BNxiVSZbbp/Ek1LJlvjIwkEN4AlbFdelVT+6VfWVFIrCOAO
	 M1OdKNDDFUK/015H3s2R15hHvRD+E0fiy0+eq6pGo2M808nyiV+f0qFfoA4T9XaNoC
	 VwXNvfV8HdzX0vPlbKS02H4JOzUQgIVVu6GsJ8HGqC+4xzdOkHylhvNQCshUBU+xVc
	 8Rc+RfC8ECiIWq2q4xm8c4wKyFvy412h9hf5ucdVDBgVIXH1zB33sRQlRYluFfQNsj
	 wQZ2rEzohr8Xw==
Received: from xaxapp05.zte.com.cn ([10.99.98.109])
	by mse-fl1.zte.com.cn with SMTP id 6A9Fw961036738;
	Mon, 9 Nov 2026 23:58:09 +0800 (+08)
	(envelope-from shao.mingyin@zte.com.cn)
Received: from mapi (xaxapp01[null])
	by mapi (Zmail) with MAPI id mid32;
	Mon, 9 Nov 2026 23:58:13 +0800 (CST)
X-Zmail-TransId: 2af96af1ed95a12-a17af
X-Mailer: Zmail v1.0
Message-ID: <202611092358134332uegNg75loROSwL53Em6A@zte.com.cn>
Date: Mon, 9 Nov 2026 23:58:13 +0800 (CST)
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
From: <shao.mingyin@zte.com.cn>
To: <tom.leiming@gmail.com>, <shuah@kernel.org>, <linux-block@vger.kernel.org>,
        <linux-kselftest@vger.kernel.org>
Cc: <linux-kernel@vger.kernel.org>
Subject: =?UTF-8?B?W1BBVENIXSBzZWxmdGVzdHM6IHVibGs6IHByb3BhZ2F0ZSByZWNvdmVyeSB3b3JrZXIgZmFpbHVyZXM=?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl1.zte.com.cn 6A9Fw961036738
X-TLS: YES
X-ENVELOPE-SENDER: shao.mingyin@zte.com.cn
X-SOURCE-IP: 10.5.228.132 unknown Mon, 09 Nov 2026 23:58:16 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6AF1ED98.001/4jNZFN434Dz8Xrnw

From: Shao Mingyin <shao.mingyin@zte.com.cn>

The recovery tests update ERR_CODE in background subshells and use wait
without PIDs. A worker can report a failure while the parent still prints
PASS and exits with zero. Calling _show_result() from a failed worker also
removes shared backing files while other workers may still be using them.

Wait for each recorded worker PID and aggregate its status in the parent,
keeping failures ahead of skips and preserving errors across batches.
Return worker and device-creation errors without reporting or cleaning up
from the child, so the parent can finish waiting before shared cleanup.

Fixes: 57e13a2e8cd2 ("selftests: ublk: support user recovery")
Fixes: 533c87e2ed74 ("selftests: ublk: add test for UBLK_F_QUIESCE")
Fixes: 63276182c513 ("selftests: ublk: add user copy test cases")
Signed-off-by: Shao Mingyin <shao.mingyin@zte.com.cn>
---
Tested on native x86_64 Bash 5.2 with the recovery scripts and common
helpers from the unpatched and patched trees. Device and I/O operations
were replaced by test-only stubs. Single-worker failures at every launch
position, multiple failures, skips, signal termination and device-creation
errors no longer produce a final PASS or a zero exit status. Successful
runs still pass, and cleanup follows all worker exits. Prerequisite skips
still exit before preparation. The 71 scenarios passed their expected
checks on each tree. This does not exercise real ublk devices or I/O.

 tools/testing/selftests/ublk/test_common.sh   | 23 +++++++++++++++++--
 .../testing/selftests/ublk/test_recover_01.sh | 20 ++++++++++++----
 .../testing/selftests/ublk/test_recover_02.sh | 20 ++++++++++++----
 .../testing/selftests/ublk/test_recover_03.sh | 20 ++++++++++++----
 .../testing/selftests/ublk/test_recover_04.sh | 14 ++++++++---
 5 files changed, 80 insertions(+), 17 deletions(-)

diff --git a/tools/testing/selftests/ublk/test_common.sh b/tools/testing/selftests/ublk/test_common.sh
index af2ea4fa1..c5adb4d29 100755
--- a/tools/testing/selftests/ublk/test_common.sh
+++ b/tools/testing/selftests/ublk/test_common.sh
@@ -379,6 +379,26 @@ run_io_and_kill_daemon()
 	fi
 }
 
+# Collect recovery workers in the parent before removing shared backing files.
+_wait_recovery_tests()
+{
+	local pid
+	local ret
+
+	for pid in "$@"; do
+		if wait "$pid"; then
+			continue
+		else
+			ret=$?
+		fi
+
+		# A failure takes precedence over a skipped worker.
+		if [ "$ERR_CODE" -eq 0 ] || [ "$ERR_CODE" -eq "$UBLK_SKIP_CODE" ]; then
+			ERR_CODE=$ret
+		fi
+	done
+}
+
 run_io_and_recover()
 {
 	local size=$1
@@ -387,8 +407,7 @@ run_io_and_recover()
 	local dev_id
 
 	shift 2
-	dev_id=$(_add_ublk_dev "$@")
-	_check_add_dev "$TID" $?
+	dev_id=$(_add_ublk_dev "$@") || return $?
 
 	fio --name=job1 --filename=/dev/ublkb"${dev_id}" --ioengine=libaio \
 		--rw=randread --iodepth=256 --size="${size}" --numjobs=4 \
diff --git a/tools/testing/selftests/ublk/test_recover_01.sh b/tools/testing/selftests/ublk/test_recover_01.sh
index 1cddc2345..950928abd 100755
--- a/tools/testing/selftests/ublk/test_recover_01.sh
+++ b/tools/testing/selftests/ublk/test_recover_01.sh
@@ -11,8 +11,8 @@ ublk_run_recover_test()
 	ERR_CODE=$?
 	if [ ${ERR_CODE} -ne 0 ]; then
 		echo "$TID failure: $*"
-		_show_result $TID $ERR_CODE
 	fi
+	return "$ERR_CODE"
 }
 
 if ! _have_program fio; then
@@ -25,20 +25,32 @@ _create_backfile 0 256M
 _create_backfile 1 128M
 _create_backfile 2 128M
 
+pids=()
 ublk_run_recover_test -t null -q 2 -r 1 -b &
+pids+=("$!")
 ublk_run_recover_test -t loop -q 2 -r 1 -b "${UBLK_BACKFILES[0]}" &
+pids+=("$!")
 ublk_run_recover_test -t stripe -q 2 -r 1 -b "${UBLK_BACKFILES[1]}" "${UBLK_BACKFILES[2]}" &
-wait
+pids+=("$!")
+_wait_recovery_tests "${pids[@]}"
 
+pids=()
 ublk_run_recover_test -t null -q 2 -r 1 &
+pids+=("$!")
 ublk_run_recover_test -t loop -q 2 -r 1 "${UBLK_BACKFILES[0]}" &
+pids+=("$!")
 ublk_run_recover_test -t stripe -q 2 -r 1 "${UBLK_BACKFILES[1]}" "${UBLK_BACKFILES[2]}" &
-wait
+pids+=("$!")
+_wait_recovery_tests "${pids[@]}"
 
+pids=()
 ublk_run_recover_test -t null -q 2 -r 1 -i 1 &
+pids+=("$!")
 ublk_run_recover_test -t loop -q 2 -r 1 -i 1 "${UBLK_BACKFILES[0]}" &
+pids+=("$!")
 ublk_run_recover_test -t stripe -q 2 -r 1 -i 1 "${UBLK_BACKFILES[1]}" "${UBLK_BACKFILES[2]}" &
-wait
+pids+=("$!")
+_wait_recovery_tests "${pids[@]}"
 
 _cleanup_test
 _show_result $TID $ERR_CODE
diff --git a/tools/testing/selftests/ublk/test_recover_02.sh b/tools/testing/selftests/ublk/test_recover_02.sh
index 9c3f48188..beeeb3535 100755
--- a/tools/testing/selftests/ublk/test_recover_02.sh
+++ b/tools/testing/selftests/ublk/test_recover_02.sh
@@ -11,8 +11,8 @@ ublk_run_recover_test()
 	ERR_CODE=$?
 	if [ ${ERR_CODE} -ne 0 ]; then
 		echo "$TID failure: $*"
-		_show_result $TID $ERR_CODE
 	fi
+	return "$ERR_CODE"
 }
 
 if ! _have_program fio; then
@@ -29,20 +29,32 @@ _create_backfile 0 256M
 _create_backfile 1 128M
 _create_backfile 2 128M
 
+pids=()
 ublk_run_recover_test -t null -q 2 -r 1 -z -b &
+pids+=("$!")
 ublk_run_recover_test -t loop -q 2 -r 1 -z -b "${UBLK_BACKFILES[0]}" &
+pids+=("$!")
 ublk_run_recover_test -t stripe -q 2 -r 1 -z -b "${UBLK_BACKFILES[1]}" "${UBLK_BACKFILES[2]}" &
-wait
+pids+=("$!")
+_wait_recovery_tests "${pids[@]}"
 
+pids=()
 ublk_run_recover_test -t null -q 2 -r 1 -z &
+pids+=("$!")
 ublk_run_recover_test -t loop -q 2 -r 1 -z "${UBLK_BACKFILES[0]}" &
+pids+=("$!")
 ublk_run_recover_test -t stripe -q 2 -r 1 -z "${UBLK_BACKFILES[1]}" "${UBLK_BACKFILES[2]}" &
-wait
+pids+=("$!")
+_wait_recovery_tests "${pids[@]}"
 
+pids=()
 ublk_run_recover_test -t null -q 2 -r 1 -z -i 1 &
+pids+=("$!")
 ublk_run_recover_test -t loop -q 2 -r 1 -z -i 1 "${UBLK_BACKFILES[0]}" &
+pids+=("$!")
 ublk_run_recover_test -t stripe -q 2 -r 1 -z -i 1 "${UBLK_BACKFILES[1]}" "${UBLK_BACKFILES[2]}" &
-wait
+pids+=("$!")
+_wait_recovery_tests "${pids[@]}"
 
 _cleanup_test
 _show_result $TID $ERR_CODE
diff --git a/tools/testing/selftests/ublk/test_recover_03.sh b/tools/testing/selftests/ublk/test_recover_03.sh
index 92f401217..0c6b312e2 100755
--- a/tools/testing/selftests/ublk/test_recover_03.sh
+++ b/tools/testing/selftests/ublk/test_recover_03.sh
@@ -11,8 +11,8 @@ ublk_run_quiesce_recover()
 	ERR_CODE=$?
 	if [ ${ERR_CODE} -ne 0 ]; then
 		echo "$TID failure: $*"
-		_show_result $TID $ERR_CODE
 	fi
+	return "$ERR_CODE"
 }
 
 if ! _have_feature "QUIESCE"; then
@@ -29,20 +29,32 @@ _create_backfile 0 256M
 _create_backfile 1 128M
 _create_backfile 2 128M
 
+pids=()
 ublk_run_quiesce_recover -t null -q 2 -r 1 -b &
+pids+=("$!")
 ublk_run_quiesce_recover -t loop -q 2 -r 1 -b "${UBLK_BACKFILES[0]}" &
+pids+=("$!")
 ublk_run_quiesce_recover -t stripe -q 2 -r 1 -b "${UBLK_BACKFILES[1]}" "${UBLK_BACKFILES[2]}" &
-wait
+pids+=("$!")
+_wait_recovery_tests "${pids[@]}"
 
+pids=()
 ublk_run_quiesce_recover -t null -q 2 -r 1 &
+pids+=("$!")
 ublk_run_quiesce_recover -t loop -q 2 -r 1 "${UBLK_BACKFILES[0]}" &
+pids+=("$!")
 ublk_run_quiesce_recover -t stripe -q 2 -r 1 "${UBLK_BACKFILES[1]}" "${UBLK_BACKFILES[2]}" &
-wait
+pids+=("$!")
+_wait_recovery_tests "${pids[@]}"
 
+pids=()
 ublk_run_quiesce_recover -t null -q 2 -r 1 -i 1 &
+pids+=("$!")
 ublk_run_quiesce_recover -t loop -q 2 -r 1 -i 1 "${UBLK_BACKFILES[0]}" &
+pids+=("$!")
 ublk_run_quiesce_recover -t stripe -q 2 -r 1 -i 1 "${UBLK_BACKFILES[1]}" "${UBLK_BACKFILES[2]}" &
-wait
+pids+=("$!")
+_wait_recovery_tests "${pids[@]}"
 
 _cleanup_test
 _show_result $TID $ERR_CODE
diff --git a/tools/testing/selftests/ublk/test_recover_04.sh b/tools/testing/selftests/ublk/test_recover_04.sh
index 4c83c1840..232ae7d4a 100755
--- a/tools/testing/selftests/ublk/test_recover_04.sh
+++ b/tools/testing/selftests/ublk/test_recover_04.sh
@@ -11,8 +11,8 @@ ublk_run_recover_test()
 	ERR_CODE=$?
 	if [ ${ERR_CODE} -ne 0 ]; then
 		echo "$TID failure: $*"
-		_show_result $TID $ERR_CODE
 	fi
+	return "$ERR_CODE"
 }
 
 if ! _have_program fio; then
@@ -25,15 +25,23 @@ _create_backfile 0 256M
 _create_backfile 1 128M
 _create_backfile 2 128M
 
+pids=()
 ublk_run_recover_test -t null -q 2 -r 1 -u &
+pids+=("$!")
 ublk_run_recover_test -t loop -q 2 -r 1 -u "${UBLK_BACKFILES[0]}" &
+pids+=("$!")
 ublk_run_recover_test -t stripe -q 2 -r 1 -u "${UBLK_BACKFILES[1]}" "${UBLK_BACKFILES[2]}" &
-wait
+pids+=("$!")
+_wait_recovery_tests "${pids[@]}"
 
+pids=()
 ublk_run_recover_test -t null -q 2 -r 1 -u -i 1 &
+pids+=("$!")
 ublk_run_recover_test -t loop -q 2 -r 1 -u -i 1 "${UBLK_BACKFILES[0]}" &
+pids+=("$!")
 ublk_run_recover_test -t stripe -q 2 -r 1 -u -i 1 "${UBLK_BACKFILES[1]}" "${UBLK_BACKFILES[2]}" &
-wait
+pids+=("$!")
+_wait_recovery_tests "${pids[@]}"
 
 _cleanup_test
 _show_result $TID $ERR_CODE
