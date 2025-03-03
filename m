Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0FF22147E8
	for <linux-block@vger.kernel.org>; Mon,  3 Mar 2025 12:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741005868; cv=none; b=JZkb2kyanP3m9qFle4m02H6jH1ZswrMVrwSQuYibfOJ10Z9r0p2ltyNSC1+oOrff0CgtfCMM5H1mWgIM0KIVwW5mQzEbrmWzfVWCT8L1gXIlQaVqwhrKIVi5Rqt0we9RYIu12ZIjW4Mkwcm+kQAYJyKR3M3dIRG46KarPPUUqIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741005868; c=relaxed/simple;
	bh=yzen7vGiasuqWpPiMRv8npN+/wnYlavCS0OTkAhg93I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZL+fZkDureyhrzERo43MpgMPIsoMnYQcKcwy4SbOaF6wATrya6becCDswMKFVxZj+I8728i3mJLZrUb5UYVhrm8SHI0UX7ASvCkvQP5Ab56xx554dOAKjImsc0OFuhUoT2mr5bCSo9eFeVCuaTokyab/k2G3znOTY6GxUzNvTvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LEmF1jWE; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LEmF1jWE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741005865;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=au45iy9Z4vYO/0vG2IShtPayiK/hMU7zUbUz9ZFnV1M=;
	b=LEmF1jWE/xtRAhGfQRZRJldXJkhYO3ayynHWZkyunNSoLHTtU2epmxyGPqQ+CeB0yyyM+V
	pAcYnHE2Pzs4M71g3Vx07Vx+/klolGDiG6hKnsDhtAX0YEP9g9pkY0JA+x39R8QCSHcqlP
	FTdmIQlcRfxTyehtd/XXIg/QXdLr8GU=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-576-0DHCWXsXMuiNdRb2OUunMg-1; Mon,
 03 Mar 2025 07:44:22 -0500
X-MC-Unique: 0DHCWXsXMuiNdRb2OUunMg-1
X-Mimecast-MFC-AGG-ID: 0DHCWXsXMuiNdRb2OUunMg_1741005861
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B1DB21801A18;
	Mon,  3 Mar 2025 12:44:21 +0000 (UTC)
Received: from localhost (unknown [10.72.120.23])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 5C259300019F;
	Mon,  3 Mar 2025 12:44:19 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: linux-kselftest@vger.kernel.org,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 09/11] selftests: ublk: add one stress test for covering IO vs. removing device
Date: Mon,  3 Mar 2025 20:43:19 +0800
Message-ID: <20250303124324.3563605-10-ming.lei@redhat.com>
In-Reply-To: <20250303124324.3563605-1-ming.lei@redhat.com>
References: <20250303124324.3563605-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Add stress_test_01 for running IO vs. removing device for verifying that
ublk device removal can work as expected when heavy IO workloads are in
progress.

null, loop and loop/zc are covered in this tests.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 tools/testing/selftests/ublk/Makefile         |  2 +
 tools/testing/selftests/ublk/test_common.sh   | 26 ++++++++++
 .../testing/selftests/ublk/test_stress_01.sh  | 47 +++++++++++++++++++
 3 files changed, 75 insertions(+)
 create mode 100755 tools/testing/selftests/ublk/test_stress_01.sh

diff --git a/tools/testing/selftests/ublk/Makefile b/tools/testing/selftests/ublk/Makefile
index 9415f6f6df48..40af938cd277 100644
--- a/tools/testing/selftests/ublk/Makefile
+++ b/tools/testing/selftests/ublk/Makefile
@@ -9,6 +9,8 @@ TEST_PROGS += test_loop_02.sh
 TEST_PROGS += test_loop_03.sh
 TEST_PROGS += test_loop_04.sh
 
+TEST_PROGS += test_stress_01.sh
+
 TEST_GEN_PROGS_EXTENDED = kublk
 
 include ../lib.mk
diff --git a/tools/testing/selftests/ublk/test_common.sh b/tools/testing/selftests/ublk/test_common.sh
index bcb0c7aa3956..89244a7e275c 100755
--- a/tools/testing/selftests/ublk/test_common.sh
+++ b/tools/testing/selftests/ublk/test_common.sh
@@ -155,5 +155,31 @@ _add_ublk_dev() {
 	echo "${dev_id}"
 }
 
+__remove_ublk_dev_return() {
+	local dev_id=$1
+
+	${UBLK_PROG} del -n "${dev_id}"
+	local res=$?
+	udevadm settle
+	return ${res}
+}
+
+__run_io_and_remove()
+{
+	local dev_id=$1
+	local size=$2
+
+	fio --name=job1 --filename=/dev/ublkb"${dev_id}" --ioengine=libaio \
+		--rw=readwrite --iodepth=64 --size="${size}" --numjobs=4 \
+		--runtime=20 --time_based > /dev/null 2>&1 &
+	sleep 2
+	if ! __remove_ublk_dev_return "${dev_id}"; then
+		echo "delete dev ${dev_id} failed"
+		return 255
+	fi
+	wait
+}
+
+
 UBLK_PROG=$(pwd)/kublk
 export UBLK_PROG
diff --git a/tools/testing/selftests/ublk/test_stress_01.sh b/tools/testing/selftests/ublk/test_stress_01.sh
new file mode 100755
index 000000000000..2dfd01cfd265
--- /dev/null
+++ b/tools/testing/selftests/ublk/test_stress_01.sh
@@ -0,0 +1,47 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+
+. test_common.sh
+TID="stress_01"
+ERR_CODE=0
+DEV_ID=-1
+
+ublk_io_and_remove()
+{
+	local size=$1
+	shift 1
+	local backfile=""
+	if echo "$@" | grep -q "loop"; then
+		backfile=${*: -1}
+	fi
+	DEV_ID=$(_add_ublk_dev "$@")
+	_check_add_dev $TID $? "${backfile}"
+
+	echo "run ublk IO vs. remove device(ublk add $*)"
+	if ! __run_io_and_remove "${DEV_ID}" "${size}"; then
+		echo "/dev/ublkc${DEV_ID} isn't removed"
+		_remove_backfile "${backfile}"
+		exit 255
+	fi
+}
+
+_prep_test "stress" "run IO and remove device"
+
+ublk_io_and_remove 8G -t null
+ERR_CODE=$?
+if [ ${ERR_CODE} -ne 0 ]; then
+	_show_result $TID $ERR_CODE
+fi
+
+BACK_FILE=$(_create_backfile 256M)
+ublk_io_and_remove 256M -t loop "${BACK_FILE}"
+ERR_CODE=$?
+if [ ${ERR_CODE} -ne 0 ]; then
+	_show_result $TID $ERR_CODE
+fi
+
+ublk_io_and_remove 256M -t loop -z "${BACK_FILE}"
+ERR_CODE=$?
+_cleanup_test "stress"
+_remove_backfile "${BACK_FILE}"
+_show_result $TID $ERR_CODE
-- 
2.47.0

