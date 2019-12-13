Return-Path: <SRS0=J0ZO=2D=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3299C3497F
	for <linux-block@archiver.kernel.org>; Fri, 13 Dec 2019 20:37:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E7C124787
	for <linux-block@archiver.kernel.org>; Fri, 13 Dec 2019 20:37:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727709AbfLMOdQ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 13 Dec 2019 09:33:16 -0500
Received: from mail-io1-f51.google.com ([209.85.166.51]:36198 "EHLO
        mail-io1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727673AbfLMOdP (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 13 Dec 2019 09:33:15 -0500
Received: by mail-io1-f51.google.com with SMTP id a22so2600808ios.3
        for <linux-block@vger.kernel.org>; Fri, 13 Dec 2019 06:33:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dE37kZUC3yYiYi/MLsMUvkcOAr9NO2+1TohR9l9Xusg=;
        b=Jz0UdQnHwC1DBbjJdGtXD1x4T6g+mR5QtI2nF+/sy41YPv78LCmvSI5VW6unr+NT3Y
         +rbDtjaeiD7nZOJgcr3HYLZdVkQLQu6ZT6mAq6X2/uyXHplg+boKcgHZSVScqH/mYCj2
         R15bExh+yfifR+PXtxho/t7eQdLXXS+AX3nJpkkVPkX/uDO4XG1u2yo/p7g1rUw0ECox
         0O26oDUYliotpyulkdymGULdUcBmUODU2zcbsPeH58kilKS017nf7n2cXab6BfCVEfKl
         61kkzUZ2SF54RZeAg3FFEO9zisECojvL71k2rGwdxLIkV0HubagVBV5OUi1SPkBzklPD
         ENPQ==
X-Gm-Message-State: APjAAAVfwhSY+593qA5ROPETP/NpncHXGVg+FZq3X6VpleQcmj6GQ/3F
        oJn5Dh/iyNDPLiPb0BYPaBSCsKie
X-Google-Smtp-Source: APXvYqzK2yL0Af11dWFlkN3AITkZ+rQo5pIbefPkNucukW2cRN0o09PpPvkcgFc6vgVM3E2hmfh0ng==
X-Received: by 2002:a02:2385:: with SMTP id u127mr13304262jau.127.1576247595210;
        Fri, 13 Dec 2019 06:33:15 -0800 (PST)
Received: from bvanassche-glaptop.ka.ltv ([75.104.68.105])
        by smtp.gmail.com with ESMTPSA id i79sm2785026ild.6.2019.12.13.06.33.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Dec 2019 06:33:14 -0800 (PST)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Omar Sandoval <osandov@fb.com>
Cc:     linux-block@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH v2 4/4] tests/srp/015: Add a test that uses the SoftiWARP (siw) driver
Date:   Fri, 13 Dec 2019 09:32:32 -0500
Message-Id: <20191213143232.29899-5-bvanassche@acm.org>
X-Mailer: git-send-email 2.24.1.735.g03f4e72817-goog
In-Reply-To: <20191213143232.29899-1-bvanassche@acm.org>
References: <20191213143232.29899-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Recently support has been added in the SRP initiator and target drivers
for the SoftiWARP driver. Add a test for SRP over SoftiWARP.

Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 common/rc         | 28 ++++++++++++++++++++++++++++
 tests/srp/015     | 45 +++++++++++++++++++++++++++++++++++++++++++++
 tests/srp/015.out |  2 ++
 3 files changed, 75 insertions(+)
 create mode 100755 tests/srp/015
 create mode 100644 tests/srp/015.out

diff --git a/common/rc b/common/rc
index 87b1e0718382..63b29be7ba74 100644
--- a/common/rc
+++ b/common/rc
@@ -87,6 +87,21 @@ _have_program() {
 	return 1
 }
 
+# Check whether the iproute2 snapshot is greater than or equal to $1.
+_have_iproute2() {
+	local snapshot
+
+	if ! snapshot=$(ip -V | sed 's/ip utility, iproute2-ss//'); then
+		SKIP_REASON="ip utility not found"
+		return 1
+	fi
+	if [ "$snapshot" -lt "$1" ]; then
+		SKIP_REASON="ip utility too old"
+		return 1
+	fi
+	return 0
+}
+
 _have_src_program() {
 	if [[ ! -x "$SRCDIR/$1" ]]; then
 		SKIP_REASON="$1 was not built; run \`make\`"
@@ -134,6 +149,19 @@ _have_kernel_option() {
 	return 1
 }
 
+# Check whether the version of the running kernel is greater than or equal to
+# $1.$2.$3
+_have_kver() {
+	local d=$1 e=$2 f=$3
+
+	IFS='.' read -r a b c < <(uname -r | sed 's/-.*//')
+	if [ $((a * 65536 + b * 256 + c)) -lt $((d * 65536 + e * 256 + f)) ];
+	then
+		SKIP_REASON="Kernel version too old"
+		return 1
+	fi
+}
+
 _have_tracefs() {
 	stat /sys/kernel/debug/tracing/trace > /dev/null 2>&1
 	if ! findmnt -t tracefs /sys/kernel/debug/tracing >/dev/null; then
diff --git a/tests/srp/015 b/tests/srp/015
new file mode 100755
index 000000000000..e9769dc8a6a0
--- /dev/null
+++ b/tests/srp/015
@@ -0,0 +1,45 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0+
+# Copyright 2019 Google LLC
+
+. tests/srp/rc
+
+DESCRIPTION="File I/O on top of multipath concurrently with logout and login (mq) using the SoftiWARP (siw) driver"
+TIMED=1
+
+requires() {
+	_have_modules siw
+	_have_kver 5 5
+	# See also commit 4336c5821a7b ("rdma: add 'link add/delete' commands").
+	_have_iproute2 190404
+}
+
+test_disconnect_repeatedly() {
+	local dev fio_status m
+
+	use_blk_mq y y || return $?
+	dev=$(get_bdev 0) || return $?
+	m=$(mountpoint 0) || return $?
+	create_filesystem "$dev" || return $?
+	mount_and_check "$dev" "$m" || return $?
+	# shellcheck disable=SC2064
+	trap "unmount_and_check $m" RETURN
+	simulate_network_failure_loop "$dev" "$TIMEOUT" &
+	run_fio --verify=md5 --rw=randwrite --bs=4K --loops=$((10**6)) \
+		--iodepth=64 --group_reporting --sync=1 --direct=1 \
+		--ioengine=libaio --directory="$m" --runtime="${TIMEOUT}" \
+		--name=data-integrity-test-mq --thread --numjobs=16 \
+		--output="${RESULTS_DIR}/srp/fio-output-015.txt" \
+		>>"$FULL"
+	fio_status=$?
+	wait
+	log_in
+	return $fio_status
+}
+
+test() {
+	: "${TIMEOUT:=30}"
+	trap 'trap "" EXIT; teardown' EXIT
+	use_siw=1
+	setup && test_disconnect_repeatedly && echo Passed
+}
diff --git a/tests/srp/015.out b/tests/srp/015.out
new file mode 100644
index 000000000000..5e25d8e8672d
--- /dev/null
+++ b/tests/srp/015.out
@@ -0,0 +1,2 @@
+Configured SRP target driver
+Passed
