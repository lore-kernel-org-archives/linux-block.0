Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40F76C77B61
	for <linux-block@archiver.kernel.org>; Sun, 16 Apr 2023 04:38:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229924AbjDPEim (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 16 Apr 2023 00:38:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229647AbjDPEil (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 16 Apr 2023 00:38:41 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 107F82D40
        for <linux-block@vger.kernel.org>; Sat, 15 Apr 2023 21:38:40 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id n17so6474946pln.8
        for <linux-block@vger.kernel.org>; Sat, 15 Apr 2023 21:38:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681619919; x=1684211919;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0gOl7Dm6FvtCDz71CS/eGi2ibA6Ef8NnGVRwX9vyOkQ=;
        b=Ur+vLuyAO6CDP4V16eFhezLOOo04iCPSJIwQsWDKRz4JS2L7M7pQiI/alidUR78VT2
         Axyzlt58BmBXTBq+P7z4xWnkkQI1FyjORlN66+0/PqxDiS5pOlwFvDM8S74aq6q2eV8l
         7GWPGHV+/SmYe+40YYJJK1ljYlPy33oJnn1+RLTcgpU2Focr3UJ2dZzqSKpzzVO+T5GL
         XbTRUPPR335deBKciQPSOMxtDwXptmrVYqIhkns+X2aCouvtyU4GeIoVLNTAyw6EnICB
         KqoXbzxTQ2yvxGEZycQg8mo7KQoB2bacSBIFHdZy1huVmlDFhik9ewFwFipthZMWgvbN
         a/gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681619919; x=1684211919;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0gOl7Dm6FvtCDz71CS/eGi2ibA6Ef8NnGVRwX9vyOkQ=;
        b=VdSAg3mu6Np4U6miQLfYQT8pQ2tm4MZJvCZKxx42UzHhcte983GAMctMAbrpBXMYD5
         05lZhQ+q5IeEdNTVDNcg6mJ84FY06LkffJcC1Vg7bUOh75EyMBe6SueQIs2FwxMWljKb
         TZ6ApRJ5lYH703JNG1m0U5wCAKSfUq0m/3tEwzBF2lLI9Mn3ptBhpZEPaTAjUDefbx2d
         kM2n2uwqiwwmfJ6kqALcAhz1YO6WWhYt3Gd5TQh3Vqsx+zqCULL1gmm3Pq17z5jFyeRT
         NjPki3k3pqaNfc9Rf06bUoJFK6tbLwC3LVPL9zfB4F3zimf6xkELfytyeskyxSzSoAER
         UdUQ==
X-Gm-Message-State: AAQBX9dTybAh3pGG8S7lTREhGDg59rh9RyNBMpAeDtE5VT0X+j/rq75u
        RrZdV72QFgNqz0f1nfwD6sDAalH9rgg=
X-Google-Smtp-Source: AKy350ZTFc2BqSuYyil1yBL4BGJQri8o0sL9Mukj9FJPCQ0i4bHJcUdi+XJlh/7MqckASVpqWZ0L8A==
X-Received: by 2002:a17:902:ceca:b0:1a6:5332:25b with SMTP id d10-20020a170902ceca00b001a65332025bmr10337679plg.42.1681619918571;
        Sat, 15 Apr 2023 21:38:38 -0700 (PDT)
Received: from localhost.localdomain ([240f:34:212d:1:317d:f8fe:6a1a:b968])
        by smtp.gmail.com with ESMTPSA id g6-20020a170902868600b0019fcece6847sm5276690plo.227.2023.04.15.21.38.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Apr 2023 21:38:37 -0700 (PDT)
From:   Akinobu Mita <akinobu.mita@gmail.com>
To:     linux-block@vger.kernel.org
Cc:     akinobu.mita@gmail.com, axboe@kernel.dk,
        shinichiro.kawasaki@wdc.com, chaitanyak@nvidia.com,
        hch@infradead.org
Subject: [PATCH v2 blktests] don't require modular null_blk for fault-injection
Date:   Sun, 16 Apr 2023 13:37:44 +0900
Message-Id: <20230416043744.25646-1-akinobu.mita@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This blktests change changes null_blk fault-injection settings to be
configured via configfs instead of module parameters.
This allows null_blk fault-injection tests to run even if the null_blk is
built-in the kernel and not built as a module.

If the null_blk does not yet support configuring fault-injection via
configfs, fall back to set up with module parameter.

Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
---
* v2
- don't skip the tests on older kernels without fault-injection via configfs

 tests/block/014 | 30 +++++++++++++++++++++++-------
 tests/block/015 | 30 +++++++++++++++++++++++-------
 tests/block/030 | 44 ++++++++++++++++++++++++++++++++------------
 3 files changed, 78 insertions(+), 26 deletions(-)

diff --git a/tests/block/014 b/tests/block/014
index facd4bc..cac779b 100755
--- a/tests/block/014
+++ b/tests/block/014
@@ -16,20 +16,36 @@ requires() {
 test() {
 	echo "Running ${TEST_NAME}"
 
-	# The format is "<interval>,<probability>,<space>,<times>". Here, we
-	# fail 50% of I/Os.
-	if ! _init_null_blk timeout='1,50,0,-1'; then
-		return 1
+	local faultb=faultb0
+
+	# Here, we fail 50% of I/Os.
+	if ! _configure_null_blk "$faultb" timeout_inject/probability=50 \
+	     timeout_inject/times=-1 timeout_inject/verbose=0 power=1 \
+	     > /dev/null 2>&1; then
+		rmdir /sys/kernel/config/nullb/"$faultb"
+		if _module_file_exists null_blk; then
+			faultb=nullb0
+
+			# Fall back to set up with module parameter. The format
+			# is "<interval>,<probability>,<space>,<times>"
+			if ! _init_null_blk timeout='1,50,0,-1'; then
+				echo "Configuring null_blk failed"
+				return 1
+			fi
+		else
+			SKIP_REASONS+=("requires fault injection via configfs or modular null_blk")
+			return 1
+		fi
 	fi
 
-	for sched in $(_io_schedulers nullb0); do
+	for sched in $(_io_schedulers "$faultb"); do
 		echo "Testing $sched" >> "$FULL"
-		echo "$sched" > /sys/block/nullb0/queue/scheduler
+		echo "$sched" > /sys/block/"$faultb"/queue/scheduler
 		# Do a bunch of I/Os which will timeout and then complete. The
 		# only thing we're really testing here is that this doesn't
 		# crash or hang.
 		for ((i = 0; i < 100; i++)); do
-			dd if=/dev/nullb0 of=/dev/null bs=4K count=4 \
+			dd if=/dev/"$faultb" of=/dev/null bs=4K count=4 \
 				iflag=direct status=none > /dev/null 2>&1 &
 		done
 		wait
diff --git a/tests/block/015 b/tests/block/015
index 389c67f..afb4b82 100755
--- a/tests/block/015
+++ b/tests/block/015
@@ -18,16 +18,32 @@ requires() {
 test() {
 	echo "Running ${TEST_NAME}"
 
-	# The format is "<interval>,<probability>,<space>,<times>". Here, we
-	# requeue 10% of the time.
-	if ! _init_null_blk requeue='1,10,0,-1'; then
-		return 1
+	local faultb=faultb0
+
+	# Here, we requeue 10% of the time.
+	if ! _configure_null_blk "$faultb" requeue_inject/probability=10 \
+	     requeue_inject/times=-1 requeue_inject/verbose=0 power=1 \
+	     > /dev/null 2>&1; then
+		rmdir /sys/kernel/config/nullb/"$faultb"
+		if _module_file_exists null_blk; then
+			faultb=nullb0
+
+			# Fall back to set up with module parameter. The format
+			# is "<interval>,<probability>,<space>,<times>"
+			if ! _init_null_blk requeue='1,10,0,-1'; then
+				echo "Configuring null_blk failed"
+				return 1
+			fi
+		else
+			SKIP_REASONS+=("requires fault injection via configfs or modular null_blk")
+			return 1
+		fi
 	fi
 
-	for sched in $(_io_schedulers nullb0); do
+	for sched in $(_io_schedulers "$faultb"); do
 		echo "Testing $sched" >> "$FULL"
-		echo "$sched" > /sys/block/nullb0/queue/scheduler
-		dd if=/dev/nullb0 of=/dev/null bs=4K count=$((512 * 1024)) \
+		echo "$sched" > /sys/block/"$faultb"/queue/scheduler
+		dd if=/dev/"$faultb" of=/dev/null bs=4K count=$((512 * 1024)) \
 			iflag=direct status=none
 	done
 
diff --git a/tests/block/030 b/tests/block/030
index 7a0712b..82330c2 100755
--- a/tests/block/030
+++ b/tests/block/030
@@ -17,20 +17,39 @@ requires() {
 }
 
 test() {
-	local i sq=/sys/kernel/config/nullb/nullb0/submit_queues
+	local faultb=faultb0
+	local i sq
 
 	: "${TIMEOUT:=30}"
-	# Legend: init_hctx=<interval>,<probability>,<space>,<times>
 	# Set <space> to $(nproc) + 1 to make loading of null_blk succeed.
-	if ! _init_null_blk nr_devices=0 \
-	     "init_hctx=$(nproc),100,$(($(nproc) + 1)),-1"; then
-		echo "Loading null_blk failed"
-		return 1
-	fi
-	if ! _configure_null_blk nullb0 completion_nsec=0 blocksize=512 size=16\
-	     submit_queues="$(nproc)" memory_backed=1 power=1; then
-		echo "Configuring null_blk failed"
-		return 1
+	if ! _configure_null_blk "$faultb" completion_nsec=0 blocksize=512 size=16\
+	     submit_queues="$(nproc)" memory_backed=1 \
+	     init_hctx_fault_inject/interval="$(nproc)" \
+	     init_hctx_fault_inject/probability=100 \
+	     init_hctx_fault_inject/space="$(($(nproc) + 1))" \
+	     init_hctx_fault_inject/times=-1 \
+	     init_hctx_fault_inject/verbose=0 power=1 \
+	     > /dev/null 2>&1; then
+		rmdir /sys/kernel/config/nullb/"$faultb"
+		if _module_file_exists null_blk; then
+			faultb=nullb0
+
+			# Fall back to set up with module parameter. The format
+			# is "<interval>,<probability>,<space>,<times>"
+			if ! _init_null_blk nr_devices=0 \
+			    "init_hctx=$(nproc),100,$(($(nproc) + 1)),-1"; then
+				echo "Loading null_blk failed"
+				return 1
+			fi
+			if ! _configure_null_blk "$faultb" completion_nsec=0 blocksize=512 size=16\
+			    submit_queues="$(nproc)" memory_backed=1 power=1; then
+				echo "Configuring null_blk failed"
+				return 1
+			fi
+		else
+			SKIP_REASONS+=("requires fault injection via configfs or modular null_blk")
+			return 1
+		fi
 	fi
 	# Since older null_blk versions do not allow "submit_queues" to be
 	# modified, check first whether that configs attribute is writeable.
@@ -39,6 +58,7 @@ test() {
 	# blk_mq_realloc_hw_ctxs() error paths will be triggered. Whether or
 	# not this test succeeds depends on whether or not _check_dmesg()
 	# detects a kernel warning.
+	sq=/sys/kernel/config/nullb/"$faultb"/submit_queues
 	if { echo "$(<"$sq")" >$sq; } 2>/dev/null; then
 		for ((i = 0; i < 100; i++)); do
 			echo 1 > $sq
@@ -47,7 +67,7 @@ test() {
 	else
 		SKIP_REASONS+=("Skipping test because $sq cannot be modified")
 	fi
-	rmdir /sys/kernel/config/nullb/nullb0
+	rmdir /sys/kernel/config/nullb/"$faultb"
 	_exit_null_blk
 	echo Passed
 }
-- 
2.34.1

