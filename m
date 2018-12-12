Return-Path: <SRS0=4xS2=OV=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AA54C65BAF
	for <linux-block@archiver.kernel.org>; Wed, 12 Dec 2018 21:58:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED1FE20849
	for <linux-block@archiver.kernel.org>; Wed, 12 Dec 2018 21:58:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20150623.gappssmtp.com header.i=@toxicpanda-com.20150623.gappssmtp.com header.b="twNnXGYH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED1FE20849
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726297AbeLLV64 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 12 Dec 2018 16:58:56 -0500
Received: from mail-yw1-f65.google.com ([209.85.161.65]:34883 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726294AbeLLV6z (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 12 Dec 2018 16:58:55 -0500
Received: by mail-yw1-f65.google.com with SMTP id h32so7652474ywk.2
        for <linux-block@vger.kernel.org>; Wed, 12 Dec 2018 13:58:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id;
        bh=/cs8v48mAyeJAD8B7oiCTAVfh/K1gbkodtCUuLdXsqk=;
        b=twNnXGYHjgdVDOZpCn/J0taD9VvNULUY+kRpDUEp3C4vMfzJp2c9iSkSb1mVpK2pyY
         9U0l+MMGuRIeUxrlu5p5Htp7lH+3gnvfm2KfJuHWaKg82ULT97X70Q1Fn9UU4QdZ7CqP
         tfXzHgUZMT+8ye2UlBbv3g4LQ6+opE6hp9vnAhWhYub2fgV/HvNnh/uyN5bJ/Voisk4R
         5TYdLmmI9RRnQAxomwfHiWtpEG6Ln0YcxYNxymrh4IkZyY/0qnXlaNOWHMeI0XTxXesE
         IPIdMJOs7kcuA4iP9jgilNG4qxRdcVqHrhQp920vn8aFXEayDjj/HUu/PwGYXhZhb4Qt
         fyTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id;
        bh=/cs8v48mAyeJAD8B7oiCTAVfh/K1gbkodtCUuLdXsqk=;
        b=Ms5e5s4iUVgKADLY3NolqlkaogtjXhfT9TU6n5LG8ZPHn4CnZm2bZSseQKpYN8EObS
         c2GAz87PmYLx8nABVgLP2joCtBuCdnVJIcqxTt/1ii8tHzEbtxOSNQw06S5pRK1OY6fH
         CxFFDSMCBjZKsE/X76szllKLKIaFpYr/2ek+AaHAqp8BHhsJwZ6oWvSWMyjOeeM2WU8C
         6G+K2KukB5IGuhoKjhpfJPn/lqLfHE/mtyIex48hlwZ/ivuVL9zn6TGoxOwgcXfJoBK6
         +ku6IhVDm+faWsrXT6hA3cMlYt6Ze8O6t0KB5ckF4vzZZXHFU9Jp5ug3AKbUI16JC1Y/
         W+XA==
X-Gm-Message-State: AA+aEWY0GETTXuYW9YLWGsIDnq8rzzwP5lOwuarYHjoN9kmR0gMtOz4N
        cKqGD+QvrHsuzZ9o2zoB7EqL6gQ8vsw=
X-Google-Smtp-Source: AFSGD/W04iY4+dmXROWS5YEuxxV8ydIuv9WRr+622qsDUbSWak/JlhKjPIpopkpfP2Dbz0gqhjmtKw==
X-Received: by 2002:a81:69c6:: with SMTP id e189mr4515131ywc.6.1544651934705;
        Wed, 12 Dec 2018 13:58:54 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id n16sm7399968ywn.31.2018.12.12.13.58.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 12 Dec 2018 13:58:54 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     kernel-team@fb.com, linux-block@vger.kernel.org, osandov@fb.com
Subject: [PATCH] blktests: test turning wbt on and off
Date:   Wed, 12 Dec 2018 16:58:53 -0500
Message-Id: <20181212215853.29855-1-josef@toxicpanda.com>
X-Mailer: git-send-email 2.14.3
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

There have been a few issues with turning wbt on and off while IO is in
flight, so add a test that just does some random rw IO and has a
background thread that toggles wbt on and off.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 tests/block/027     | 47 +++++++++++++++++++++++++++++++++++++++++++++++
 tests/block/027.out |  2 ++
 2 files changed, 49 insertions(+)
 create mode 100755 tests/block/027
 create mode 100644 tests/block/027.out

diff --git a/tests/block/027 b/tests/block/027
new file mode 100755
index 000000000000..dce6431172a8
--- /dev/null
+++ b/tests/block/027
@@ -0,0 +1,47 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-3.0+
+# Copyright (C) 2018 Josef Bacik
+#
+# Turn wbt on and off in the background while writing to the disk to verify
+# there's no races in the inflight counter manipulation
+
+. tests/block/rc
+
+DESCRIPTION="run a read workload and write workload together with wbt"
+
+requires() {
+	_have_fio && _have_program jq
+}
+
+device_requires() {
+	_test_dev_supports_wbt
+}
+
+toggle_wbt() {
+	while true
+	do
+		_test_dev_queue_set wbt_lat_usec 0
+		sleep 1
+		_test_dev_queue_set wbt_lat_usec 1
+		sleep 1			
+	done
+}
+
+test_device() {
+	echo "Running ${TEST_NAME}"
+
+	local wbt_setting toggle_pid
+	wbt_setting=$(_test_dev_queue_get wbt_lat_usec)
+
+	(toggle_wbt &)
+	toggle_pid=$!
+
+	_run_fio --name randrw --numjobs=8 --runtime=30 --randseed=12345 \
+		--ioengine=psync --readwrite=randrw --filename="$TEST_DEV"
+
+	kill $toggle_pid > /dev/null 2>&1
+	wait
+	_test_dev_queue_set wbt_lat_usec "$wbt_setting"
+
+	echo "Test complete"
+}
diff --git a/tests/block/027.out b/tests/block/027.out
new file mode 100644
index 000000000000..b03498fbc763
--- /dev/null
+++ b/tests/block/027.out
@@ -0,0 +1,2 @@
+Running block/027
+Test complete
-- 
2.14.3

