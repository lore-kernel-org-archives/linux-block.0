Return-Path: <SRS0=XUQF=5A=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B14C1C10F29
	for <linux-block@archiver.kernel.org>; Sun, 15 Mar 2020 22:13:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91B7220674
	for <linux-block@archiver.kernel.org>; Sun, 15 Mar 2020 22:13:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729260AbgCOWNc (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 15 Mar 2020 18:13:32 -0400
Received: from mail-pl1-f176.google.com ([209.85.214.176]:35814 "EHLO
        mail-pl1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729213AbgCOWNb (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 15 Mar 2020 18:13:31 -0400
Received: by mail-pl1-f176.google.com with SMTP id g6so7053498plt.2
        for <linux-block@vger.kernel.org>; Sun, 15 Mar 2020 15:13:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=C7sM9H/oB/NtZ/k+MD4fVoE3W9QS6nyiuLjXZueeE7s=;
        b=tlrpfJaPrCtwJjNe/jBfrM+ygf0OqsQOhz40qO2VEsuQu8kYHetYHPXvmrAHfsrgwO
         Wj7nbRlsVUgkPrv0OcNLg7tnDNvpm0fBhhwjiNh24RPDXFUNj4G2mEWctVjphm8EF8WE
         zitWl3nSvjHZynM5gw8LlBZ1DQUT/cbii/kngM8TiGUUoubOB8QWy6YU8G71m06gfOsG
         gVKyatyQjKbUdG00rp3m0OB3nZvXsRCM7Np5CuL4PX1DRkfvg1Kad3eDrA8NCt8UblMZ
         T9/m67Tu0IlCn3jytH+Um2JgqR56bAoB/kL44gArWgf/8RNLSPQsg5zu/jfZm/Er+7ys
         4ynw==
X-Gm-Message-State: ANhLgQ2+CLipLmldisNYKCafQdGwykKB/8vUUaRrd/xKfIo+xFbYPwia
        cvKgPGLO8S3YyWOfz40eoAo=
X-Google-Smtp-Source: ADFU+vtrr8b8PJwJNT1bnZtOH1FN5tQk7XYDVoxQzY4okS8K9Rsw74frgy9FdD9L4REtt7YLEAE+Qw==
X-Received: by 2002:a17:90a:950f:: with SMTP id t15mr6294215pjo.133.1584310410301;
        Sun, 15 Mar 2020 15:13:30 -0700 (PDT)
Received: from asus.hsd1.ca.comcast.net ([2601:647:4000:d7:dc50:2da4:5bd2:69ab])
        by smtp.gmail.com with ESMTPSA id d1sm39192976pfn.51.2020.03.15.15.13.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Mar 2020 15:13:29 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Omar Sandoval <osandov@fb.com>
Cc:     linux-block@vger.kernel.org,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Subject: [PATCH blktests v2 3/4] Introduce the function _configure_null_blk()
Date:   Sun, 15 Mar 2020 15:13:19 -0700
Message-Id: <20200315221320.613-4-bvanassche@acm.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200315221320.613-1-bvanassche@acm.org>
References: <20200315221320.613-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Introduce a function for creating a null_blk device instance through
configfs.

Suggested-by: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 common/multipath-over-rdma | 17 +++++------------
 common/null_blk            | 14 ++++++++++++++
 tests/block/029            | 16 ++--------------
 3 files changed, 21 insertions(+), 26 deletions(-)

diff --git a/common/multipath-over-rdma b/common/multipath-over-rdma
index a56e7a8269db..7e610a0ccbbb 100644
--- a/common/multipath-over-rdma
+++ b/common/multipath-over-rdma
@@ -620,18 +620,11 @@ run_fio() {
 configure_null_blk() {
 	local i
 
-	(
-		cd /sys/kernel/config/nullb || return $?
-		for i in nullb0 nullb1; do (
-			{ mkdir -p $i &&
-				  cd $i &&
-				  echo 0 > completion_nsec &&
-				  echo 512 > blocksize &&
-				  echo $((ramdisk_size>>20)) > size &&
-				  echo 1 > memory_backed &&
-				  echo 1 > power; } || exit $?
-		) done
-	)
+	for i in nullb0 nullb1; do
+		_configure_null_blk nullb$i completion_nsec=0 blocksize=512 \
+				    size=$((ramdisk_size>>20)) memory_backed=1 \
+				    power=1 || return $?
+	done
 	ls -l /dev/nullb* &>>"$FULL"
 }
 
diff --git a/common/null_blk b/common/null_blk
index 6a5f99aaae9d..3c31db1ed4ac 100644
--- a/common/null_blk
+++ b/common/null_blk
@@ -28,6 +28,20 @@ _init_null_blk() {
 	return 0
 }
 
+# Configure one null_blk instance with name $1 and parameters $2..${$#}.
+_configure_null_blk() {
+	local nullb=/sys/kernel/config/nullb/$1 param val
+
+	shift
+	mkdir "$nullb" &&
+		while [ -n "$1" ]; do
+			param="${1//=*}"
+			val="${1#${param}=}"
+			shift
+			echo "$val" > "$nullb/$param" || return $?
+		done
+}
+
 _exit_null_blk() {
 	udevadm settle
 	_remove_null_blk_devices
diff --git a/tests/block/029 b/tests/block/029
index 0d521edb0cf6..dbb582eab473 100755
--- a/tests/block/029
+++ b/tests/block/029
@@ -14,19 +14,6 @@ requires() {
 	_have_null_blk
 }
 
-# Configure one null_blk instance.
-configure_null_blk() {
-	local nullb0="/sys/kernel/config/nullb/nullb0"
-
-	mkdir "$nullb0" &&
-	echo 0 > "$nullb0/completion_nsec" &&
-	echo 512 > "$nullb0/blocksize" &&
-	echo 16 > "$nullb0/size" &&
-	echo 1 > "$nullb0/memory_backed" &&
-	echo 1 > "$nullb0/power" &&
-	ls -l /dev/nullb* &>>"$FULL"
-}
-
 modify_nr_hw_queues() {
 	local deadline num_cpus
 
@@ -45,7 +32,8 @@ test() {
 
 	: "${TIMEOUT:=30}"
 	_init_null_blk nr_devices=0 queue_mode=2 &&
-	configure_null_blk
+	_configure_null_blk nullb0 completion_nsec=0 blocksize=512 \
+			    size=16 memory_backed=1 power=1 &&
 	if { echo 1 >$sq; } 2>/dev/null; then
 		modify_nr_hw_queues &
 		fio --rw=randwrite --bs=4K --loops=$((10**6)) \
