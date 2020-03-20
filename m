Return-Path: <SRS0=+z0d=5F=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6923DC4332B
	for <linux-block@archiver.kernel.org>; Fri, 20 Mar 2020 22:24:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 475C320722
	for <linux-block@archiver.kernel.org>; Fri, 20 Mar 2020 22:24:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727183AbgCTWY1 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 20 Mar 2020 18:24:27 -0400
Received: from mail-pg1-f178.google.com ([209.85.215.178]:33244 "EHLO
        mail-pg1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726666AbgCTWY1 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 20 Mar 2020 18:24:27 -0400
Received: by mail-pg1-f178.google.com with SMTP id d17so3203513pgo.0
        for <linux-block@vger.kernel.org>; Fri, 20 Mar 2020 15:24:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zNEvMmWFNr1bekp0igSykCALguZdx8FVYe6VB146guA=;
        b=gKuov0vXfsDeNeZOH69k93PYNOUWdlAsFnYnuqn6bY8ZqFWdf/OaXOgFpTrIwtL1rc
         laPAk/LlLCfyB1ePOyf7dru1i66vrdn1g4h3+2xDm2Kz6ggW3hdtInoft7TfblyQ6ORM
         ssLezDc9ZcaXql31GqkAnnRNFDVQSt0kUvCK2InYqd7jh1YLqL0fxIp4/Ys3neplamVk
         7RQiZ6ZiMKWlX74kKJikPx308EpaUku0OxkA30hpsd6NKgJ0YMtJmGwu8rM0Fb7cYJBL
         i64OsQFySpU8JkCuriIGmPUeVTKyK4SvPCBRQj/W2svMBzHpxfL7bT5TV6g6qNp5gEFi
         Jwqg==
X-Gm-Message-State: ANhLgQ04qm5ATd0sUiD7dxm2J8IcVnCbYQkYdmht+BpnUpb4nAlJH6aH
        VFPDGDARItjdEHWt0O7zTaN72ENpKt4=
X-Google-Smtp-Source: ADFU+vvHzvPaXGzR/plop4/h/QkZecO8bECshYzmJJ+O6f1XXp2+ssTDhueCAlwqE0bY/OdCc75ciQ==
X-Received: by 2002:aa7:94b5:: with SMTP id a21mr11987561pfl.290.1584743065788;
        Fri, 20 Mar 2020 15:24:25 -0700 (PDT)
Received: from asus.hsd1.ca.comcast.net ([2601:647:4000:d7:c142:5d77:5a3f:9429])
        by smtp.gmail.com with ESMTPSA id z20sm6050530pge.62.2020.03.20.15.24.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2020 15:24:24 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Omar Sandoval <osandov@fb.com>
Cc:     linux-block@vger.kernel.org,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Subject: [PATCH blktests v3 3/4] Introduce the function _configure_null_blk()
Date:   Fri, 20 Mar 2020 15:24:12 -0700
Message-Id: <20200320222413.24386-4-bvanassche@acm.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200320222413.24386-1-bvanassche@acm.org>
References: <20200320222413.24386-1-bvanassche@acm.org>
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
index a4140e365955..08008fca8eae 100644
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
+	while [ -n "$1" ]; do
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
