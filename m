Return-Path: <SRS0=+z0d=5F=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4C76C43332
	for <linux-block@archiver.kernel.org>; Fri, 20 Mar 2020 22:24:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9503220722
	for <linux-block@archiver.kernel.org>; Fri, 20 Mar 2020 22:24:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726980AbgCTWY0 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 20 Mar 2020 18:24:26 -0400
Received: from mail-pl1-f181.google.com ([209.85.214.181]:35503 "EHLO
        mail-pl1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726666AbgCTWYZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 20 Mar 2020 18:24:25 -0400
Received: by mail-pl1-f181.google.com with SMTP id g6so3108501plt.2
        for <linux-block@vger.kernel.org>; Fri, 20 Mar 2020 15:24:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YJA9YnykAkWSeQQyL2vt7uCWBP6qJY034eSIRzdUVgg=;
        b=k14YFltPUJkdAXj3PcPfC6Gy9Bx1MWQhkN2V1wWp2Oc3aDTgyVeNC0U2yfFVIT9Cke
         5uyS+Iih8xiS4e7TqIT+81DzjDQBygGvvdLgE9RbMV1+dIfJmMlXc1c4FHsB2wmxaFHA
         kQK8nMQXpUuHKZ6Hr2IBe9L13/ANYz6PBJPrnJyHhXv1ht9scagZQLEM17aPgtPCCS77
         FkUBBA6HPmAnUbu5q64QbNbuFfE/hHdBLantph73+OpFMIrzBov4tV+83xokS8lw+7Tf
         Z1UimFRYqIDQGLRDa91q7v+ZBXYGK3bvyWObEbl/FciDbzlIG0IuvYG9cqXUEClST/+E
         SSWA==
X-Gm-Message-State: ANhLgQ0mDxpp0oFBS6sNHt7JhLTvZatdxEWTEc6SduueoDVYuikfyJax
        x4kgA796jeDq+9g9fByglQI=
X-Google-Smtp-Source: ADFU+vtZ3vy7z3O0do02HFFQE6PpJKoOJG9V2E5MsecbmsxFLmNIqij/KIPbMWcGCOCHFtTYTZD7ZA==
X-Received: by 2002:a17:90a:fb8e:: with SMTP id cp14mr11694891pjb.8.1584743064136;
        Fri, 20 Mar 2020 15:24:24 -0700 (PDT)
Received: from asus.hsd1.ca.comcast.net ([2601:647:4000:d7:c142:5d77:5a3f:9429])
        by smtp.gmail.com with ESMTPSA id z20sm6050530pge.62.2020.03.20.15.24.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2020 15:24:22 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Omar Sandoval <osandov@fb.com>
Cc:     linux-block@vger.kernel.org,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH blktests v3 2/4] Use _{init,exit}_null_blk instead of open-coding these functions
Date:   Fri, 20 Mar 2020 15:24:11 -0700
Message-Id: <20200320222413.24386-3-bvanassche@acm.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200320222413.24386-1-bvanassche@acm.org>
References: <20200320222413.24386-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This patch reduces code duplication.

Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
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
index 1fd631445921..136163bc73ad 100755
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
