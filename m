Return-Path: <SRS0=XUQF=5A=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C4D2C0044D
	for <linux-block@archiver.kernel.org>; Sun, 15 Mar 2020 02:47:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0792B20650
	for <linux-block@archiver.kernel.org>; Sun, 15 Mar 2020 02:47:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727076AbgCOCrC (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 14 Mar 2020 22:47:02 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:40457 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726811AbgCOCrC (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 14 Mar 2020 22:47:02 -0400
Received: by mail-pg1-f196.google.com with SMTP id t24so7453882pgj.7
        for <linux-block@vger.kernel.org>; Sat, 14 Mar 2020 19:47:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3zkHpbIsmkUwu9U78T8mJG88teTa+jkQo5jbm0uzU5E=;
        b=ALRHe2g+csYjU62Q0oXGsO93Fwq/rSlsdELP8GMrxKHhIeISRNuCMn/Q2FqUtByAm2
         gCChUQPElZOJsPGANRp9nBBIAxZcrOyAYr8b/7qYOTGHzrhtlrh+ffJZweyVBBNGbYJm
         m+2GXMcDKennzXN29XySj1x5vKQkOFmST4KdvJ50bd3C/JHvFunRu7z7sfbmMQy5TaB8
         +fHmBzmDL+DqjIv5KQTmv4GTgwmlxjfb4CV4F5/ggyrkp7ji3rkutaBeIR/cDuWVcLKV
         NBy6byt910LpdWsZ0fc3nLT1jgFu6JF/meALRHe5ABHia4vOxjkRdCLana78f3qxYAPS
         kkiQ==
X-Gm-Message-State: ANhLgQ2molTURFUTMX1TVrcDEsZzGs/fMeU/Z8eTfAy9eopzRWbb/5Go
        YlP648lAFercH5m2NncL3G8=
X-Google-Smtp-Source: ADFU+vtz3IDCDcVWvKI9TYOLU70DEPWHsOqvPcyb1tHPQFmgj0wQ9hmEBJp0kN1KTkwRFZJOoNETfA==
X-Received: by 2002:a63:4752:: with SMTP id w18mr19731702pgk.379.1584240420457;
        Sat, 14 Mar 2020 19:47:00 -0700 (PDT)
Received: from asus.hsd1.ca.comcast.net ([2601:647:4000:d7:8c07:28a7:ab98:67e])
        by smtp.gmail.com with ESMTPSA id fz3sm16123972pjb.41.2020.03.14.19.46.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Mar 2020 19:46:59 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Omar Sandoval <osandov@fb.com>
Cc:     linux-block@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH blktests] Add a test that triggers the blk_mq_realloc_hw_ctxs() error path
Date:   Sat, 14 Mar 2020 19:46:54 -0700
Message-Id: <20200315024654.25174-1-bvanassche@acm.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Add a test that triggers the code touched by commit d0930bb8f46b ("blk-mq:
Fix a recently introduced regression in blk_mq_realloc_hw_ctxs()"). This
test only runs if a recently added fault injection feature is available,
namely commit 596444e75705 ("null_blk: Add support for init_hctx() fault
injection").

Cc: Ming Lei <ming.lei@redhat.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 tests/block/030     | 55 +++++++++++++++++++++++++++++++++++++++++++++
 tests/block/030.out |  1 +
 2 files changed, 56 insertions(+)
 create mode 100755 tests/block/030
 create mode 100644 tests/block/030.out

diff --git a/tests/block/030 b/tests/block/030
new file mode 100755
index 000000000000..028b0a1a6e9a
--- /dev/null
+++ b/tests/block/030
@@ -0,0 +1,55 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright 2020 Google LLC
+#
+# Trigger the blk_mq_realloc_hw_ctxs() error path.
+
+. tests/block/rc
+. common/null_blk
+
+DESCRIPTION="trigger the blk_mq_realloc_hw_ctxs() error path"
+QUICK=1
+
+requires() {
+	_have_null_blk || return $?
+	_have_module_param null_blk init_hctx || return $?
+}
+
+# Configure one null_blk instance.
+configure_null_blk() {
+	local nullb0="/sys/kernel/config/nullb/nullb0"
+
+	mkdir "$nullb0" &&
+	echo 0 > "$nullb0/completion_nsec" &&
+	echo 512 > "$nullb0/blocksize" &&
+	echo 16 > "$nullb0/size" &&
+	nproc > "$nullb0/submit_queues" &&
+	echo 1 > "$nullb0/memory_backed" &&
+	echo 1 > "$nullb0/power" &&
+	ls -l /dev/nullb* &>>"$FULL"
+}
+
+test() {
+	local i sq=/sys/kernel/config/nullb/nullb0/submit_queues
+
+	: "${TIMEOUT:=30}"
+	if ! _init_null_blk nr_devices=0 queue_mode=2 "init_hctx=$(nproc),100,0,0"; then
+		echo "Loading null_blk failed"
+		return 1
+	fi
+	if ! configure_null_blk; then
+		echo "Configuring null_blk failed"
+		return 1
+	fi
+	if { echo "$(<"$sq")" >$sq; } 2>/dev/null; then
+		for ((i=0;i<100;i++)); do
+			echo 1 >$sq
+			nproc >$sq
+		done
+	else
+		echo "Skipping test because $sq cannot be modified" >>"$FULL"
+	fi
+	rmdir /sys/kernel/config/nullb/nullb0
+	_exit_null_blk
+	echo Passed
+}
diff --git a/tests/block/030.out b/tests/block/030.out
new file mode 100644
index 000000000000..863339fb8ced
--- /dev/null
+++ b/tests/block/030.out
@@ -0,0 +1 @@
+Passed
