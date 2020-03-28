Return-Path: <SRS0=MX1A=5N=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99E4BC2D0EC
	for <linux-block@archiver.kernel.org>; Sat, 28 Mar 2020 18:23:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F92220717
	for <linux-block@archiver.kernel.org>; Sat, 28 Mar 2020 18:23:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726977AbgC1SXE (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 28 Mar 2020 14:23:04 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:42470 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726497AbgC1SXD (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 28 Mar 2020 14:23:03 -0400
Received: by mail-pl1-f193.google.com with SMTP id e1so4839125plt.9
        for <linux-block@vger.kernel.org>; Sat, 28 Mar 2020 11:23:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tyLVb9Ja6jhwBLlCwiXZKXwAYbh2y4g1wSwx4K9Pt5o=;
        b=KMTdO9XeZEd3ACKWZ3ylQm+/zOtdaxcqLwh5u80VQ4aNnhWOFYxn962z0og/W9oU/E
         jb1lpgEDHjY/4DLXjpvdOvZJB3T5SmFzNKjSCBpM2lxIGHvcbcfNDKJrvw89oVCWnCAq
         aYSUmdNrjvIt5mXypvsBY72Kz4RYDDpieMp/X8XQySkxEUsfGRajp8Gq3OtV0YshSctm
         SLYIYHm4GRB5sg6OwgXJH7MPAH6JQsZtRjSdJLdGDo+3CwfU5hTzRaXKxXxy8FSrQC/1
         tdIyUiRRuG7IEoXH/gch9IsI3ReWT3cRtPCDzlhnKQrobUGd8R2acEEQY68KCaOrYTRp
         umdA==
X-Gm-Message-State: ANhLgQ09lH1fRH5DQEdOUXPGF46mL6+erX8rm6rg+S8qb7fSRBJWgAW9
        RHo40wrzxeKOeWSWaiPvcpV26LPkOtk=
X-Google-Smtp-Source: ADFU+vvQeqRtmK2ANkFeuOq0PJeDQttEwY8/EOXprfeC3YJfMji7qMRm60jtwRw6/CaAqT+8hcPMGg==
X-Received: by 2002:a17:902:ba08:: with SMTP id j8mr5005100pls.70.1585419782745;
        Sat, 28 Mar 2020 11:23:02 -0700 (PDT)
Received: from asus.hsd1.ca.comcast.net ([2601:647:4000:d7:597d:a863:13de:4665])
        by smtp.gmail.com with ESMTPSA id e126sm6659179pfa.122.2020.03.28.11.23.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Mar 2020 11:23:02 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Omar Sandoval <osandov@fb.com>
Cc:     linux-block@vger.kernel.org,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
        Daniel Wagner <dwagner@suse.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH blktests v4 4/4] Add a test that triggers the blk_mq_realloc_hw_ctxs() error path
Date:   Sat, 28 Mar 2020 11:22:51 -0700
Message-Id: <20200328182251.19945-5-bvanassche@acm.org>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200328182251.19945-1-bvanassche@acm.org>
References: <20200328182251.19945-1-bvanassche@acm.org>
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
Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 tests/block/030     | 52 +++++++++++++++++++++++++++++++++++++++++++++
 tests/block/030.out |  1 +
 2 files changed, 53 insertions(+)
 create mode 100755 tests/block/030
 create mode 100644 tests/block/030.out

diff --git a/tests/block/030 b/tests/block/030
new file mode 100755
index 000000000000..2b159510e586
--- /dev/null
+++ b/tests/block/030
@@ -0,0 +1,52 @@
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
+	# Legend: init_hctx=<interval>,<probability>,<space>,<times>
+	# Set <space> to $(nproc) + 1 to make loading of null_blk succeed.
+	if ! _init_null_blk nr_devices=0 queue_mode=2 \
+	     "init_hctx=$(nproc),100,$(($(nproc)+1)),-1"; then
+		echo "Loading null_blk failed"
+		return 1
+	fi
+	if ! _configure_null_blk nullb0 completion_nsec=0 blocksize=512 size=16\
+	     submit_queues="$(nproc)" memory_backed=1 power=1; then
+		echo "Configuring null_blk failed"
+		return 1
+	fi
+	# Since older null_blk versions do not allow "submit_queues" to be
+	# modified, check first whether that configs attribute is writeable.
+	# Each iteration of the loop below triggers $(nproc) + 1
+	# null_init_hctx() calls. Since <interval>=$(nproc), all possible
+	# blk_mq_realloc_hw_ctxs() error paths will be triggered. Whether or
+	# not this test succeeds depends on whether or not _check_dmesg()
+	# detects a kernel warning.
+	if { echo "$(<"$sq")" >$sq; } 2>/dev/null; then
+		for ((i=0;i<100;i++)); do
+			echo 1 >$sq
+			nproc >$sq
+		done
+	else
+		SKIP_REASON="Skipping test because $sq cannot be modified"
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
