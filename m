Return-Path: <SRS0=zNjm=ZH=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B92B1C43215
	for <linux-block@archiver.kernel.org>; Fri, 15 Nov 2019 17:07:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9EBC120740
	for <linux-block@archiver.kernel.org>; Fri, 15 Nov 2019 17:07:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727528AbfKORH1 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 15 Nov 2019 12:07:27 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:40310 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727564AbfKORH0 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 15 Nov 2019 12:07:26 -0500
Received: by mail-pl1-f193.google.com with SMTP id e3so5067789plt.7
        for <linux-block@vger.kernel.org>; Fri, 15 Nov 2019 09:07:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZaxTzNmwwAn9HJVWyR+icmkGtWCz8kvI1scga3SLIPY=;
        b=SJ7X8U9jjnec8ohA2bWuceE0F33eWI1S0ILNM2IZCctalcoLLSlH9li1Az2yc0AwnU
         ZAK1Yg1Hd9cqYHVKRIUT9vx31WDO+O0Ui2COxq9RGD7CxXRU8nBbMSv/X2WLlZZ1HRpc
         h7FEA/JYxateZWqoYHl3nMhIw5acW7WsHU+4kJQDkoL5SsZPXjA9ZvjfoymMsV+Suem4
         5nPXD87+iatVYrC9nKpNiyZBHn0KRTPCyeK6/PT73KtgaLLCNSiB3Qi7B/Z/h6MxFaC7
         JQM4NG/xLzmkLEMWtWrzkO9K1QAVw0P2xBsaSg2byvrGURbUlFqHBk4YI65A3D4pnFUY
         5d+Q==
X-Gm-Message-State: APjAAAXvoMvRfL1y+2z12HOyogiCSVICHKQRB1K/avLpZ+TjQdauyMEb
        kiaCU4QVlK+IcvzMnb80Kp7WFy10
X-Google-Smtp-Source: APXvYqyRxpRHXH4ZFvlyepzAcBXuMn+SoNOqJvEYNKU9ehHB7WuJa/AI7jwdwekKnLxw7yCdkkoRtQ==
X-Received: by 2002:a17:902:7287:: with SMTP id d7mr16451223pll.333.1573837646006;
        Fri, 15 Nov 2019 09:07:26 -0800 (PST)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id m7sm2364793pfb.153.2019.11.15.09.07.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Nov 2019 09:07:24 -0800 (PST)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Omar Sandoval <osandov@fb.com>
Cc:     linux-block@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH blktests 4/4] tests/srp/015: Add a test that uses the SoftiWARP (siw) driver
Date:   Fri, 15 Nov 2019 09:07:11 -0800
Message-Id: <20191115170711.232741-5-bvanassche@acm.org>
X-Mailer: git-send-email 2.24.0.432.g9d3f5f5b63-goog
In-Reply-To: <20191115170711.232741-1-bvanassche@acm.org>
References: <20191115170711.232741-1-bvanassche@acm.org>
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
 tests/srp/015     | 42 ++++++++++++++++++++++++++++++++++++++++++
 tests/srp/015.out |  2 ++
 2 files changed, 44 insertions(+)
 create mode 100755 tests/srp/015
 create mode 100644 tests/srp/015.out

diff --git a/tests/srp/015 b/tests/srp/015
new file mode 100755
index 000000000000..faef5089ec4c
--- /dev/null
+++ b/tests/srp/015
@@ -0,0 +1,42 @@
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
