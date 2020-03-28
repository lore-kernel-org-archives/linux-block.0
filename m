Return-Path: <SRS0=MX1A=5N=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED15BC2D0EC
	for <linux-block@archiver.kernel.org>; Sat, 28 Mar 2020 18:23:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2B1D20714
	for <linux-block@archiver.kernel.org>; Sat, 28 Mar 2020 18:23:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725807AbgC1SXB (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 28 Mar 2020 14:23:01 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:37031 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726497AbgC1SXB (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 28 Mar 2020 14:23:01 -0400
Received: by mail-pg1-f193.google.com with SMTP id a32so6398279pga.4
        for <linux-block@vger.kernel.org>; Sat, 28 Mar 2020 11:22:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KDjQeevQOInHdNkxmzxDHiEtpmAei2DG8ChF+Sw5kqI=;
        b=LbyFSbXj2WOWem8mI7+ndA3nWlKsGkKOKQ13lWXpaFWsgly6IJsRfcS3X5xszwaOPc
         Qm36vXCC5aibKwH98P/LXtE0MGG+QNIuOcupRTXqB1wgLe+giyomR3c+pXFuViKtd1Zf
         IM04UM9ZnxUpnkKOSq7TJkgLtqm6xuRD6GXCNYlOeeWd+EXIqEVEOWL4WFndh+irfdqU
         5OS6UjEQ3OcxcSmGLQI0eAZxaS1aM182TNkACHUGW7BapWcNtG/LEjp/CSrCCei7gkZN
         TNvzzv7Q17F5pFGK6WOjnQjpYnV7SzNa5KFixAlEpnilj112763EOvUPy634ER3srXJP
         E+tQ==
X-Gm-Message-State: ANhLgQ2LrMeujvyHvh6pXFyoER1bgrlbiz7iGAduFcuHzTEM2kkQmb7X
        jY5SEZSj0g3LxWAlfEjrwoM=
X-Google-Smtp-Source: ADFU+vsPorw4Oxlni7LYED9b/pcEujCKD55brsvX+0nBj+CkdI1QV7+WOs3XHD4+YPIawF/dgqlazg==
X-Received: by 2002:a63:d943:: with SMTP id e3mr5191620pgj.434.1585419778245;
        Sat, 28 Mar 2020 11:22:58 -0700 (PDT)
Received: from asus.hsd1.ca.comcast.net ([2601:647:4000:d7:597d:a863:13de:4665])
        by smtp.gmail.com with ESMTPSA id e126sm6659179pfa.122.2020.03.28.11.22.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Mar 2020 11:22:57 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Omar Sandoval <osandov@fb.com>
Cc:     linux-block@vger.kernel.org,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
        Daniel Wagner <dwagner@suse.de>,
        Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH blktests v4 1/4] Make _exit_null_blk remove all null_blk device instances
Date:   Sat, 28 Mar 2020 11:22:48 -0700
Message-Id: <20200328182251.19945-2-bvanassche@acm.org>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200328182251.19945-1-bvanassche@acm.org>
References: <20200328182251.19945-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Instead of making every test remove null_blk device instances before calling
_exit_null_blk(), move the null_blk device instance removal code into
_exit_null_blk().

Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Reviewed-by: Daniel Wagner <dwagner@suse.de>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 common/null_blk | 7 ++++++-
 tests/block/022 | 3 ---
 tests/block/029 | 1 -
 3 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/common/null_blk b/common/null_blk
index 2e300c20bbc7..a4140e365955 100644
--- a/common/null_blk
+++ b/common/null_blk
@@ -8,11 +8,15 @@ _have_null_blk() {
 	_have_modules null_blk
 }
 
-_init_null_blk() {
+_remove_null_blk_devices() {
 	if [[ -d /sys/kernel/config/nullb ]]; then
 		find /sys/kernel/config/nullb -mindepth 1 -maxdepth 1 \
 		     -type d -delete
 	fi
+}
+
+_init_null_blk() {
+	_remove_null_blk_devices
 
 	local zoned=""
 	if (( RUN_FOR_ZONED )); then zoned="zoned=1"; fi
@@ -26,6 +30,7 @@ _init_null_blk() {
 }
 
 _exit_null_blk() {
+	_remove_null_blk_devices
 	udevadm settle
 	modprobe -r null_blk
 }
diff --git a/tests/block/022 b/tests/block/022
index 1404aacef295..b2c53e266d81 100755
--- a/tests/block/022
+++ b/tests/block/022
@@ -50,9 +50,6 @@ test() {
 		wait $pid1
 	} 2>/dev/null
 
-	rmdir /sys/kernel/config/nullb/1
-	rmdir /sys/kernel/config/nullb/0
-
 	_exit_null_blk
 	echo "Test complete"
 }
diff --git a/tests/block/029 b/tests/block/029
index d298bac8db5c..0d521edb0cf6 100755
--- a/tests/block/029
+++ b/tests/block/029
@@ -58,7 +58,6 @@ test() {
 	else
 		echo "Skipping test because $sq cannot be modified" >>"$FULL"
 	fi
-	rmdir /sys/kernel/config/nullb/nullb0
 	_exit_null_blk
 	echo Passed
 }
