Return-Path: <SRS0=aWxv=TB=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0DC3C43219
	for <linux-block@archiver.kernel.org>; Wed,  1 May 2019 19:48:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71F5620866
	for <linux-block@archiver.kernel.org>; Wed,  1 May 2019 19:48:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556740125;
	bh=+ztRiRebQ6Ax+QHlRgvtPlKbgWnwmtKJD4mcDdaZMok=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=Tzzx3et29P+BrDwa1DU5HmH+zTdhXKcA9MXP6TWuZCCqEKOHsfjJ4vKhZ8ZHk+lke
	 NQ4IOiL+hkuOySoIlBCpJDOJG/dQHGD5HSoWbWXyE5pTOCF6shlgWVoFYYDd6WPamA
	 sb1zw2iVhILmTn0awAtEFloSbdW50hQPtUr7/Kys=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726175AbfEATso (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 1 May 2019 15:48:44 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:44349 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726004AbfEATso (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 1 May 2019 15:48:44 -0400
Received: by mail-pf1-f195.google.com with SMTP id y13so9042513pfm.11
        for <linux-block@vger.kernel.org>; Wed, 01 May 2019 12:48:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=+pgdi1eNTsVXzNKyAIZD/a8iRJDidh8BfAlY25QI4xI=;
        b=kBy49VeaIzq419BSFaq+KXKEb8oLu8DFahM0d06ZBJ4HQ10ne8ZQi+RkLRipwkTUHJ
         FuvIgVMDY/uhfDoFXSPO5yPlm83ZDbE2AtjO3eh/vzkRgvIocYejEeZFU+al8NJeVmMd
         PyHNeaD9evUIbvw6OifMjNi8jG/DGj6lyFuW3f6RcdTfOZWmDaF+AGO49SONl2spYK6H
         cy4ge/+kI3vD0HaMJtbHprhTgSjTRhzmzoxVsm1qsFDEPYTOwEuxnl5k0B6uZNikl7H8
         NshyCWxWOKEYQXSIURltlEtUvJS/9uwsoVcYHP9LgXIkywOrUdySnEFh2k+/y+P1Sk0h
         qpgQ==
X-Gm-Message-State: APjAAAVGMz0tOoHVrw6Bm2PxoeFjrN3n3qT7Ne17Lt3f3aXWAthloUZh
        lPYaVpacJ/4nrsa6uowd/6jvwNqIMiI=
X-Google-Smtp-Source: APXvYqzxE39ZJuApeahw3giDfga4AD4JCB+TV9hW7UXy+Ny/JzITWfifF6KEF8RWcntR1nb4RiR6QA==
X-Received: by 2002:a63:2cc9:: with SMTP id s192mr23835934pgs.24.1556740123768;
        Wed, 01 May 2019 12:48:43 -0700 (PDT)
Received: from dennisz-mbp.thefacebook.com ([199.201.64.2])
        by smtp.gmail.com with ESMTPSA id b2sm43701414pff.63.2019.05.01.12.48.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 01 May 2019 12:48:42 -0700 (PDT)
From:   Dennis Zhou <dennis@kernel.org>
To:     Omar Sandoval <osandov@osandov.com>
Cc:     kernel-team@fb.com, linux-block@vger.kernel.org,
        Dennis Zhou <dennis@kernel.org>
Subject: [PATCH v2] block: fix fio jobs for 027 and add cgroup support
Date:   Wed,  1 May 2019 15:48:38 -0400
Message-Id: <20190501194838.81646-1-dennis@kernel.org>
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
index b480016..ae464dd 100755
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
+	mkdir -p "$CGROUP2_DIR/${TEST_NAME}"
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
+		--loops=10000 --cgroup=blktests/${TEST_NAME} $fio_jobs > "$FULL" 2>&1 &
 
-	sleep 7
+	sleep 6
 	local device_path
 	for dev in "${SCSI_DEBUG_DEVICES[@]}"; do
 		# shutdown devices in progress
@@ -61,6 +68,10 @@ scsi_debug_stress_remove() {
 
 	wait
 
+	sleep 5
+
+	_exit_cgroup2
+
 	_exit_scsi_debug
 }
 
-- 
2.17.1

