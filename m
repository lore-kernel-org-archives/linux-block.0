Return-Path: <SRS0=MX1A=5N=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DF27C43331
	for <linux-block@archiver.kernel.org>; Sat, 28 Mar 2020 18:23:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53B1420717
	for <linux-block@archiver.kernel.org>; Sat, 28 Mar 2020 18:23:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726518AbgC1SXA (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 28 Mar 2020 14:23:00 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:46973 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725807AbgC1SXA (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 28 Mar 2020 14:23:00 -0400
Received: by mail-pg1-f194.google.com with SMTP id k191so6379790pgc.13
        for <linux-block@vger.kernel.org>; Sat, 28 Mar 2020 11:23:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rxQwUex0J61YPXEhUY1i6yWSOf6pgDXtAcBgQ+1Rgh4=;
        b=d1YyOsgJmqRadx7aPHQPekCNdw9BvOjix3NwFXxLmTEogL4Jeunot5WNFdK1Ino7cR
         ueEBQZMjBLIO77PV0/UTf4PHZt6itPrfjdG7gkTIkZd3pOowwXuzsDtb6DKg/9XWmAKD
         9DfbG8uTeFF/FVoaNZ2afaYoG+uNOjm80TxfJcNkgDbjt12+TSx8yXUMPoEmaor8t8vg
         Om7L6D48NTtAmuHAi5rMzCcIuvPhbtObgSU2H8R07ic5IJ8RMam8net/4zsf9wv9FvfR
         iT40/jB+kGkE+3z56nN4ZnFQI5KdhXUj5cFAsgAuN4q12I9o2SrqF6pDq2CZo5Wn9DXl
         pL6g==
X-Gm-Message-State: ANhLgQ1957hArutoohPgxW1qKr4J2NjuiodH4/gow4gywwXainLTR1Jb
        9gJPI+IVrtviniKVFgD461s=
X-Google-Smtp-Source: ADFU+vsGyEH+rMrST1Q/W7tQnpRvfXwXZsYqgbULYQCVhZj0141k6Nq+4S74tYeDwkO8/UtLwnIb+Q==
X-Received: by 2002:aa7:947c:: with SMTP id t28mr4890632pfq.239.1585419779543;
        Sat, 28 Mar 2020 11:22:59 -0700 (PDT)
Received: from asus.hsd1.ca.comcast.net ([2601:647:4000:d7:597d:a863:13de:4665])
        by smtp.gmail.com with ESMTPSA id e126sm6659179pfa.122.2020.03.28.11.22.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Mar 2020 11:22:58 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Omar Sandoval <osandov@fb.com>
Cc:     linux-block@vger.kernel.org,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
        Daniel Wagner <dwagner@suse.de>,
        Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH blktests v4 2/4] Use _{init,exit}_null_blk instead of open-coding these functions
Date:   Sat, 28 Mar 2020 11:22:49 -0700
Message-Id: <20200328182251.19945-3-bvanassche@acm.org>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200328182251.19945-1-bvanassche@acm.org>
References: <20200328182251.19945-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This patch reduces code duplication.

Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Reviewed-by: Daniel Wagner <dwagner@suse.de>
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
