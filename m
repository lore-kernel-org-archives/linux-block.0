Return-Path: <SRS0=zBYI=YO=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92D52CA9EAF
	for <linux-block@archiver.kernel.org>; Mon, 21 Oct 2019 22:57:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72C912084C
	for <linux-block@archiver.kernel.org>; Mon, 21 Oct 2019 22:57:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730492AbfJUW5c (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 21 Oct 2019 18:57:32 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:44819 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730350AbfJUW5b (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 21 Oct 2019 18:57:31 -0400
Received: by mail-pf1-f193.google.com with SMTP id q21so9338087pfn.11
        for <linux-block@vger.kernel.org>; Mon, 21 Oct 2019 15:57:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JcAPZHBup7EGGT2HEeVEwPdgfLi+5+AbDG/DlcY9dvU=;
        b=DgZhazjpR9XaYmdNRWnK3ML2mcDNHKnU52E7HVSOL+HqUVa9El9L5eL50kdrLIv9ed
         INyHny4ByzLChDFVL32zxcu+pJtNX3wTONO1x9/fgvV90/dI1xZIfFfgoFxIzNPQjaJj
         Fav1UVCWk4PcTIhB6GP6RQySTWGmxoENUazRKPD4Meh+8eLVEBMrxiJii6FN71MKC/9h
         yI6j5fehIoLT8TUTJqxtyTO314WGpq6BOvF4i4Qr+a4eZXRSzOanNs6G6WVLhbsWAY6z
         3CP1LWEhGDT209HSc0MSODKIi1oe4VFCuoiy+Eo2KCuk9Oapi1voEARC43D2GfKwX4T8
         9lzA==
X-Gm-Message-State: APjAAAWpqTXOqpVrEipBwrXSmx33V+VlLuGe2Pc4SkV6KGJRnbjXmDBJ
        49TaurPqnp+Jzmwks6hAhTE=
X-Google-Smtp-Source: APXvYqyUtmNvZdeZBNvnCESRjXPVpTcuzRgWq6VAvTRqFcR4VABjlVCFNmD6vel09eFeNQOrgRNm8g==
X-Received: by 2002:a17:90a:2522:: with SMTP id j31mr625715pje.123.1571698651086;
        Mon, 21 Oct 2019 15:57:31 -0700 (PDT)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id x70sm255474pfd.132.2019.10.21.15.57.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2019 15:57:30 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Omar Sandoval <osandov@fb.com>
Cc:     linux-block@vger.kernel.org,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH blktests 2/2] Add a test that triggers blk_mq_update_nr_hw_queues()
Date:   Mon, 21 Oct 2019 15:57:19 -0700
Message-Id: <20191021225719.211651-3-bvanassche@acm.org>
X-Mailer: git-send-email 2.23.0.866.gb869b98d4c-goog
In-Reply-To: <20191021225719.211651-1-bvanassche@acm.org>
References: <20191021225719.211651-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 tests/block/029     | 63 +++++++++++++++++++++++++++++++++++++++++++++
 tests/block/029.out |  1 +
 2 files changed, 64 insertions(+)
 create mode 100755 tests/block/029
 create mode 100644 tests/block/029.out

diff --git a/tests/block/029 b/tests/block/029
new file mode 100755
index 000000000000..1999168603c1
--- /dev/null
+++ b/tests/block/029
@@ -0,0 +1,63 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (C) 2019 Google Inc.
+#
+# Trigger blk_mq_update_nr_hw_queues().
+
+. tests/block/rc
+. common/null_blk
+
+DESCRIPTION="trigger blk_mq_update_nr_hw_queues()"
+QUICK=1
+
+requires() {
+	_have_null_blk
+}
+
+# Configure one null_blk instance.
+configure_null_blk() {
+	(
+		cd /sys/kernel/config/nullb || return $?
+		(
+			mkdir -p nullb0 &&
+				cd nullb0 &&
+				echo 0 > completion_nsec &&
+				echo 512 > blocksize &&
+				echo 16 > size &&
+				echo 1 > memory_backed &&
+				echo 1 > power
+		)
+	) &&
+	ls -l /dev/nullb* &>>"$FULL"
+}
+
+modify_nr_hw_queues() {
+	local deadline num_cpus
+
+	deadline=$(($(_uptime_s) + TIMEOUT))
+	num_cpus=$(find /sys/devices/system/cpu -maxdepth 1 -name 'cpu[0-9]*' |
+			   wc -l)
+	while [ "$(_uptime_s)" -lt "$deadline" ]; do
+		sleep .1
+		echo 1 > /sys/kernel/config/nullb/nullb0/submit_queues
+		sleep .1
+		echo "$num_cpus" > /sys/kernel/config/nullb/nullb0/submit_queues
+	done
+}
+
+test() {
+	: "${TIMEOUT:=30}"
+	_init_null_blk nr_devices=0 queue_mode=2 &&
+	configure_null_blk
+	modify_nr_hw_queues &
+	fio --rw=randwrite --bs=4K --loops=$((10**6)) \
+		--iodepth=64 --group_reporting --sync=1 --direct=1 \
+		--ioengine=libaio --filename="/dev/nullb0" \
+		--runtime="${TIMEOUT}" --name=nullb0 \
+		--output="${RESULTS_DIR}/block/fio-output-029.txt" \
+		>>"$FULL"
+	wait
+	rmdir /sys/kernel/config/nullb/nullb0
+	_exit_null_blk
+	echo Passed
+}
diff --git a/tests/block/029.out b/tests/block/029.out
new file mode 100644
index 000000000000..863339fb8ced
--- /dev/null
+++ b/tests/block/029.out
@@ -0,0 +1 @@
+Passed
-- 
2.23.0.866.gb869b98d4c-goog

