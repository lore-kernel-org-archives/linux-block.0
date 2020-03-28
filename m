Return-Path: <SRS0=MX1A=5N=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B4EFC43331
	for <linux-block@archiver.kernel.org>; Sat, 28 Mar 2020 18:23:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E26620714
	for <linux-block@archiver.kernel.org>; Sat, 28 Mar 2020 18:23:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726981AbgC1SXE (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 28 Mar 2020 14:23:04 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:35686 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726977AbgC1SXD (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 28 Mar 2020 14:23:03 -0400
Received: by mail-pl1-f193.google.com with SMTP id c12so2013301plz.2
        for <linux-block@vger.kernel.org>; Sat, 28 Mar 2020 11:23:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uB5N1k04tBIlN5tMFckVBv+F0f8wm42FV5OnAp7qRiE=;
        b=JN0y9fI6iJG0RdJfJJIhpsxkz5ZOY9RmPlee49H0e2EvdhrYlqqiltDvuGW18fDLfM
         fjualDOwSwyWW1nreX9zfIyrddfIDFXoyMfxhCXxZeNO3NHiLx24YUSnjVx6efeQt0xo
         tNSKYmAz4bN6ffDksASybC3EN3LSWAkIYu0fK7GKn2EI1rKJke337y4GlRbVo1d3bNHE
         UQginMA2CZIB9kVZATOPxiX7i0jBX0iHPqbCyZ+ZQClE7dha0Ca39Y73XDUF/LntQ+3Z
         oG6uaJZQwQikaJTOSxFlt72TwRHWJ6ilhTMGGUX5GIQx9A5l47CEpmAAJPVXByvazpRH
         q3RA==
X-Gm-Message-State: ANhLgQ3c9tebSXx+kzAahX/lS27cFFhJ7Y3jWxR0IlCnQtrfTd5dorMq
        HaITYlbviLa886nnhhjv0sA=
X-Google-Smtp-Source: ADFU+vv0nfXfuEZ+ax1XvElOfvMWQnw9oj6oc5RdCQmBP07vwTvYMPqT4dsa1yeMtYtuhn2IzkjAzA==
X-Received: by 2002:a17:902:b28c:: with SMTP id u12mr3976471plr.262.1585419781045;
        Sat, 28 Mar 2020 11:23:01 -0700 (PDT)
Received: from asus.hsd1.ca.comcast.net ([2601:647:4000:d7:597d:a863:13de:4665])
        by smtp.gmail.com with ESMTPSA id e126sm6659179pfa.122.2020.03.28.11.22.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Mar 2020 11:23:00 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Omar Sandoval <osandov@fb.com>
Cc:     linux-block@vger.kernel.org,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
        Daniel Wagner <dwagner@suse.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Subject: [PATCH blktests v4 3/4] Introduce the function _configure_null_blk()
Date:   Sat, 28 Mar 2020 11:22:50 -0700
Message-Id: <20200328182251.19945-4-bvanassche@acm.org>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200328182251.19945-1-bvanassche@acm.org>
References: <20200328182251.19945-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Introduce a function for creating a null_blk device instance through
configfs.

Suggested-by: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Reviewed-by: Daniel Wagner <dwagner@suse.de>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 common/multipath-over-rdma | 17 +++++------------
 common/null_blk            | 14 ++++++++++++++
 tests/block/029            | 16 ++--------------
 3 files changed, 21 insertions(+), 26 deletions(-)

diff --git a/common/multipath-over-rdma b/common/multipath-over-rdma
index a56e7a8269db..e689a9633d13 100644
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
+		_configure_null_blk $i completion_nsec=0 blocksize=512 \
+				    size=$((ramdisk_size>>20)) memory_backed=1 \
+				    power=1 || return $?
+	done
 	ls -l /dev/nullb* &>>"$FULL"
 }
 
diff --git a/common/null_blk b/common/null_blk
index a4140e365955..6611db03a00e 100644
--- a/common/null_blk
+++ b/common/null_blk
@@ -29,6 +29,20 @@ _init_null_blk() {
 	return 0
 }
 
+# Configure one null_blk instance with name $1 and parameters $2..${$#}.
+_configure_null_blk() {
+	local nullb=/sys/kernel/config/nullb/$1 param val
+
+	shift
+	mkdir "$nullb" || return $?
+	while [[ $# -gt 0 ]]; do
+		param="${1%%=*}"
+		val="${1#*=}"
+		shift
+		echo "$val" > "$nullb/$param" || return $?
+	done
+}
+
 _exit_null_blk() {
 	_remove_null_blk_devices
 	udevadm settle
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
