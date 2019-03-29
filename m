Return-Path: <SRS0=pPwc=SA=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83495C43381
	for <linux-block@archiver.kernel.org>; Fri, 29 Mar 2019 22:14:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F6FE218A5
	for <linux-block@archiver.kernel.org>; Fri, 29 Mar 2019 22:14:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553897679;
	bh=k12ILwZ2bvM1Lf/W0slFRBoeRVKl4jU9w9UyzkvHoyU=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=QFgRbY6GC7uRjh+GCBnW5T8DWwMquZTX/60gap4AzekWd2R4mcUAgkAmhBVkHAffy
	 nV6pu83rV/ZZlURayTybIakbmFdprFD6HdMZJzuJkJj+z4aNjtHKPfUtPjgs2F9xR0
	 WfdVeed3QuxcacojwCYo1fB4ejO6wZBUWB2u4Lm8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730463AbfC2WOi (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 29 Mar 2019 18:14:38 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:35838 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730240AbfC2WOi (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 29 Mar 2019 18:14:38 -0400
Received: by mail-pg1-f193.google.com with SMTP id g8so1848074pgf.2
        for <linux-block@vger.kernel.org>; Fri, 29 Mar 2019 15:14:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=oFR7LthxF7JoMlx1hs9OKquJntCo0ypOYdStECQ0XfM=;
        b=UnMa5DtiTYVPUwIWcfglAY8+BSf0hZCGNScpyrpW9lilUkBrldM8mFL5dTILJM+CFm
         3XCJwV6Bnpvw3GM/Al9htM+pGH9iYkid0HPVtbkQIrw8aKxEDDaeDfmWCgr4gQndTVZK
         gTUiEmn+XEmXQu/4a4bxbbtZbruEMPyYL51mvZd6Ydohzo5+/WlJg5KUN/Nm8/84rMRz
         paV94gV1DDL/HAiYlKrNBueZJdmxYw7W+/BUEnqk26qWcH5EAUR8vf261YqtLufosiyr
         XeeI5FaJQ6Na+tCiO/VvI1npcCJA758D6Uj2ddW+hnNzWE0TMBEr4S1h19yK93jx8byn
         4lvw==
X-Gm-Message-State: APjAAAXoLLvPcO2SjU6WOc4V+9u9RTMeimAkUxa1bIx+CmxbMHYRxGXW
        8gTxxShDIlFcrxFLXvshO7s=
X-Google-Smtp-Source: APXvYqxjCTFkm1vjc7aEBNpKUkCMinSGmX5k2m/VZxqtr9swXhlaQrcNYq8xlo3eI7QjvF6BqDiMZQ==
X-Received: by 2002:a65:63d7:: with SMTP id n23mr19572209pgv.26.1553897677834;
        Fri, 29 Mar 2019 15:14:37 -0700 (PDT)
Received: from dennisz-mbp.thefacebook.com ([199.201.64.136])
        by smtp.gmail.com with ESMTPSA id w18sm6346200pfg.75.2019.03.29.15.14.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 29 Mar 2019 15:14:36 -0700 (PDT)
From:   Dennis Zhou <dennis@kernel.org>
To:     Omar Sandoval <osandov@osandov.com>
Cc:     kernel-team@fb.com, linux-block@vger.kernel.org,
        Dennis Zhou <dennis@kernel.org>
Subject: [PATCH] block: fix fio jobs for 027 and add cgroup support
Date:   Fri, 29 Mar 2019 15:14:32 -0700
Message-Id: <20190329221432.38726-1-dennis@kernel.org>
X-Mailer: git-send-email 2.13.5
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Previously, the test was broken as "$fio_jobs" was considered as a
string instead of additional parameters. This is fixed here.

Second, there was an issue with earlier kernels when request lists
existed such that request_queues were never being cleaned up because
non-root blkgs took a reference on the queue. However, blkgs were being
cleaned up after the last reference to the request_queue was put back.
This creates a blktest cgroup for the fio jobs to utilize and should be
useful for catching this scenario in the future.

Signed-off-by: Dennis Zhou <dennis@kernel.org>
---
 tests/block/027 | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/tests/block/027 b/tests/block/027
index b480016..36e88b4 100755
--- a/tests/block/027
+++ b/tests/block/027
@@ -26,6 +26,13 @@ scsi_debug_stress_remove() {
 		return
 	fi
 
+	_init_cgroup2
+
+	# setup cgroups
+	echo "+io" > "/sys/fs/cgroup/cgroup.subtree_control"
+	echo "+io" > "$CGROUP2_DIR/cgroup.subtree_control"
+	mkdir "$CGROUP2_DIR/fast"
+
 	# set higher aio limit
 	echo 524288 > /proc/sys/fs/aio-max-nr
 
@@ -45,13 +52,13 @@ scsi_debug_stress_remove() {
 		((cnt++))
 	done
 
-	local num_jobs=4 runtime=21
+	local num_jobs=4 runtime=12
 	fio --rw=randread --size=128G --direct=1 --ioengine=libaio \
 		--iodepth=2048 --numjobs=$num_jobs --bs=4k \
 		--group_reporting=1 --group_reporting=1 --runtime=$runtime \
-		--loops=10000 "$fio_jobs" > "$FULL" 2>&1 &
+		--loops=10000 --cgroup=blktests/fast $fio_jobs > "$FULL" 2>&1 &
 
-	sleep 7
+	sleep 6
 	local device_path
 	for dev in "${SCSI_DEBUG_DEVICES[@]}"; do
 		# shutdown devices in progress
@@ -61,6 +68,10 @@ scsi_debug_stress_remove() {
 
 	wait
 
+	sleep 10
+
+	_exit_cgroup2
+
 	_exit_scsi_debug
 }
 
-- 
2.17.1

