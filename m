Return-Path: <SRS0=XUQF=5A=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91103C18E5B
	for <linux-block@archiver.kernel.org>; Sun, 15 Mar 2020 22:13:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71B2220674
	for <linux-block@archiver.kernel.org>; Sun, 15 Mar 2020 22:13:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729259AbgCOWNd (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 15 Mar 2020 18:13:33 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:43066 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729213AbgCOWNc (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 15 Mar 2020 18:13:32 -0400
Received: by mail-pl1-f193.google.com with SMTP id f8so7040315plt.10
        for <linux-block@vger.kernel.org>; Sun, 15 Mar 2020 15:13:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gzt9drSq1a3M0wDqr12K6dW+/+6MWoiCVYBzeOWG8sQ=;
        b=UqBXo+MYhxLxmGkg3jucqlV63PBgtoQ49wy3Re71mtJsHOSBpk1SlcZXoG3fACx93i
         Qh+SXRoVZNuicGThmiDSukfQ99H8ntnvCzQaoJB4z7tFEBpfoMhZrkN5GruU6ZVFKH7w
         a3ui1ixe+X5fIr6ExJ+r/SWF+9zp1jQckDni+xmJp+aTM4wT0WuCoJERaPFw9oM9/KQb
         TxufFav5IdhBGLjjDPq8xgIObvrfhrs1GrlA56Ne4pv9EcCmdigirbEnKUAP/A/w6qTA
         7mxEMO2NdC2QiW7J19lvcI7huFv2C/Vy4+pAiSEo0UpoSjPDwIiUk0JF0oPIWQ6SAgBt
         q3hw==
X-Gm-Message-State: ANhLgQ2BCXD2WioM37Km95HiBqJknKfE2R085JxBvd8LclVX74nhwCxX
        FEZjybRV3job1XGkipF5sCU=
X-Google-Smtp-Source: ADFU+vtkNIIMmhzeHO9Um76DgvI+W8GLrHpaMTDiwKEYHiMeYhfIFEDpzv84eBgUiFjqOIQzDCVW6w==
X-Received: by 2002:a17:90a:bd86:: with SMTP id z6mr21935456pjr.15.1584310411643;
        Sun, 15 Mar 2020 15:13:31 -0700 (PDT)
Received: from asus.hsd1.ca.comcast.net ([2601:647:4000:d7:dc50:2da4:5bd2:69ab])
        by smtp.gmail.com with ESMTPSA id d1sm39192976pfn.51.2020.03.15.15.13.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Mar 2020 15:13:30 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Omar Sandoval <osandov@fb.com>
Cc:     linux-block@vger.kernel.org,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH blktests v2 4/4] Add a test that triggers the blk_mq_realloc_hw_ctxs() error path
Date:   Sun, 15 Mar 2020 15:13:20 -0700
Message-Id: <20200315221320.613-5-bvanassche@acm.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200315221320.613-1-bvanassche@acm.org>
References: <20200315221320.613-1-bvanassche@acm.org>
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
 tests/block/030     | 42 ++++++++++++++++++++++++++++++++++++++++++
 tests/block/030.out |  1 +
 2 files changed, 43 insertions(+)
 create mode 100755 tests/block/030
 create mode 100644 tests/block/030.out

diff --git a/tests/block/030 b/tests/block/030
new file mode 100755
index 000000000000..861c85c27f09
--- /dev/null
+++ b/tests/block/030
@@ -0,0 +1,42 @@
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
+test() {
+	local i sq=/sys/kernel/config/nullb/nullb0/submit_queues
+
+	: "${TIMEOUT:=30}"
+	if ! _init_null_blk nr_devices=0 queue_mode=2 "init_hctx=$(nproc),100,0,0"; then
+		echo "Loading null_blk failed"
+		return 1
+	fi
+	if ! _configure_null_blk nullb0 completion_nsec=0 blocksize=512 size=16\
+	     submit_queues="$(nproc)" memory_backed=1 power=1; then
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
