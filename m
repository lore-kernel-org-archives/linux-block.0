Return-Path: <SRS0=XUQF=5A=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37DBFC10DCE
	for <linux-block@archiver.kernel.org>; Sun, 15 Mar 2020 22:13:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 148DC20674
	for <linux-block@archiver.kernel.org>; Sun, 15 Mar 2020 22:13:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729254AbgCOWNa (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 15 Mar 2020 18:13:30 -0400
Received: from mail-pl1-f178.google.com ([209.85.214.178]:35815 "EHLO
        mail-pl1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729213AbgCOWNa (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 15 Mar 2020 18:13:30 -0400
Received: by mail-pl1-f178.google.com with SMTP id g6so7053469plt.2
        for <linux-block@vger.kernel.org>; Sun, 15 Mar 2020 15:13:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mGDJ2HZFiBdsaZGiTxTLtgDQACiWAgZfS87jWhdx3Qw=;
        b=dcTCTGw8owR7WJQvo27uJCvA+KFsQtmK/O39x8Ufe34Qze6JQfLuY+xNatOD+SiUyb
         aMzuDmHyqxYaSRl7mSk7HyixLvVofXuh+DIqRw4QQF3GXOnVd3tw8bHDQ2Lz0ZKaltU2
         vyXunMwY/VKETjCpAKw3h33VX5UrMe+JpCtIWIcMMWW0bUSuCIih9A1DWtk4Dp5bUJw6
         Iu3D+KSJkdCM3p0EOuFcLb9Qz2ZWI1MbhXz6soj3i5wF7cxYJvsyLipcA4lkPxN7oQZi
         oBCR14EbkUcbmyGac/zYFR5Ucag78rgnlaq+j2SUfDp00WHHi4n/rNPzDHndg4ub5sJA
         Rh+w==
X-Gm-Message-State: ANhLgQ3c1oWCu+emOa/GfGXRF4cypaOhpzGKWfu78a6GtWEy8qyy2jLm
        p/oMeu3D96rATayw8EZaz28=
X-Google-Smtp-Source: ADFU+vu1morvTkq7jmIXsqrtk0gXNH8oeybsZJvhGlXtk2/jni5oQn5NnGcQQTQFSeZ6JezDlw/PCw==
X-Received: by 2002:a17:90a:bf17:: with SMTP id c23mr21675013pjs.17.1584310409106;
        Sun, 15 Mar 2020 15:13:29 -0700 (PDT)
Received: from asus.hsd1.ca.comcast.net ([2601:647:4000:d7:dc50:2da4:5bd2:69ab])
        by smtp.gmail.com with ESMTPSA id d1sm39192976pfn.51.2020.03.15.15.13.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Mar 2020 15:13:28 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Omar Sandoval <osandov@fb.com>
Cc:     linux-block@vger.kernel.org,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH blktests v2 2/4] Use _{init,exit}_null_blk instead of open-coding these functions
Date:   Sun, 15 Mar 2020 15:13:18 -0700
Message-Id: <20200315221320.613-3-bvanassche@acm.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200315221320.613-1-bvanassche@acm.org>
References: <20200315221320.613-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This patch reduces code duplication.

Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 common/multipath-over-rdma | 12 +++---------
 tests/nvmeof-mp/rc         |  2 +-
 2 files changed, 4 insertions(+), 10 deletions(-)

diff --git a/common/multipath-over-rdma b/common/multipath-over-rdma
index 40efc4b3aa2e..a56e7a8269db 100644
--- a/common/multipath-over-rdma
+++ b/common/multipath-over-rdma
@@ -5,6 +5,7 @@
 # Functions and global variables used by both the srp and nvmeof-mp tests.
 
 . common/shellcheck
+. common/null_blk
 
 debug=
 filesystem_type=ext4
@@ -634,13 +635,6 @@ configure_null_blk() {
 	ls -l /dev/nullb* &>>"$FULL"
 }
 
-unload_null_blk() {
-	local d
-
-	for d in /sys/kernel/config/nullb/*; do [ -d "$d" ] && rmdir "$d"; done
-	unload_module null_blk
-}
-
 setup_rdma() {
 	start_soft_rdma
 	(
@@ -662,7 +656,7 @@ teardown_uncond() {
 	rm -f /etc/multipath.conf
 	stop_target
 	stop_soft_rdma
-	unload_null_blk
+	_exit_null_blk
 }
 
 teardown() {
@@ -698,7 +692,7 @@ setup_test() {
 		[ -e "/sys/module/$m" ] || modprobe "$m" || return $?
 	done
 
-	modprobe null_blk nr_devices=0 || return $?
+	_init_null_blk nr_devices=0 || return $?
 
 	configure_null_blk || return $?
 
diff --git a/tests/nvmeof-mp/rc b/tests/nvmeof-mp/rc
index 278843a1270d..f782bb3a02ac 100755
--- a/tests/nvmeof-mp/rc
+++ b/tests/nvmeof-mp/rc
@@ -278,7 +278,7 @@ stop_nvme_target() {
 	)
 	unload_module nvmet_rdma &&
 		unload_module nvmet &&
-		unload_null_blk
+		_exit_null_blk
 }
 
 start_target() {
