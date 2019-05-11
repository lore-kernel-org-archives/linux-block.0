Return-Path: <SRS0=UHms=TL=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDB6DC04AB1
	for <linux-block@archiver.kernel.org>; Sat, 11 May 2019 15:37:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7F892184B
	for <linux-block@archiver.kernel.org>; Sat, 11 May 2019 15:37:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728604AbfEKPhG (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 11 May 2019 11:37:06 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58386 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728599AbfEKPhG (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sat, 11 May 2019 11:37:06 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A64424E92B;
        Sat, 11 May 2019 15:37:06 +0000 (UTC)
Received: from localhost.redhat.com (ovpn-12-30.pek2.redhat.com [10.72.12.30])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 2871F67C99;
        Sat, 11 May 2019 15:37:04 +0000 (UTC)
From:   Xiao Liang <xiliang@redhat.com>
To:     linux-block@vger.kernel.org, osandov@fb.com
Cc:     xiliang@redhat.com
Subject: [PATCH blktests v2] block/005,008: do exit if fio did not finish within timeout
Date:   Sat, 11 May 2019 23:36:51 +0800
Message-Id: <20190511153651.4119-1-xiliang@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Sat, 11 May 2019 15:37:06 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

In some bad situation, fio needs taking over several hours to complete
random read operations with specified size. The test may skip out in such
cases and does not block other cases run.

With this patch, the case will be ended within $TIMEOUT(if set) or 900s.
block/005 => nvme1n1 (switch schedulers while doing IO)      [failed]
    runtime      ...  1800.477s
    read iops    ...
    --- tests/block/005.out	2019-03-31 14:29:39.905449312 +0000
    +++ /home/ec2-user/blktests/results/nvme1n1/block/005.out.bad	2019-05-07 04:10:16.026681842 +0000
    @@ -1,2 +1,4 @@
     Running block/005
    +fio did not finish after 900 seconds which probably caused by
    +lower disk performance
     Test complete

Reviewed-by: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Signed-off-by: Xiao Liang <xiliang@redhat.com>
---
 tests/block/005 | 9 +++++++++
 tests/block/008 | 9 +++++++++
 2 files changed, 18 insertions(+)

diff --git a/tests/block/005 b/tests/block/005
index 8ab6791..de8ddaf 100755
--- a/tests/block/005
+++ b/tests/block/005
@@ -31,10 +31,19 @@ test_device() {
 	_run_fio_rand_io --filename="$TEST_DEV" --size="$size" &
 
 	# while job is running, switch between schedulers
+	# fio test may take too long time to complete read/write in special size in some bad 
+	# situations. Set a timeout here which does not block overall test.
+	start_time=$(date +%s)
+	timeout=${TIMEOUT:=900}
 	while kill -0 $! 2>/dev/null; do
 		idx=$((RANDOM % ${#scheds[@]}))
 		_test_dev_queue_set scheduler "${scheds[$idx]}"
 		sleep .2
+		end_time=$(date +%s)
+		if (( end_time - start_time > timeout )); then
+			echo "fio did not finish after $timeout seconds!"
+			break
+		fi
 	done
 
 	FIO_PERF_FIELDS=("read iops")
diff --git a/tests/block/008 b/tests/block/008
index 4a88056..d215136 100755
--- a/tests/block/008
+++ b/tests/block/008
@@ -45,6 +45,10 @@ test_device() {
 	done
 
 	# while job is running, hotplug CPUs
+	# fio test may take too long time to complete read/write in special size in some bad 
+	# situations. Set a timeout here which does not block overall test.
+	start_time=$(date +%s)
+	timeout=${TIMEOUT:=900}
 	while sleep .2; kill -0 $! 2> /dev/null; do
 		if (( offlining && ${#offline_cpus[@]} == max_offline )); then
 			offlining=0
@@ -65,6 +69,11 @@ test_device() {
 			unset offline_cpus["$idx"]
 			offline_cpus=("${offline_cpus[@]}")
 		fi
+		end_time=$(date +%s)
+		if (( end_time - start_time > timeout )); then
+			echo "fio did not finish after $timeout seconds!"
+			break
+		fi
 	done
 
 	FIO_PERF_FIELDS=("read iops")
-- 
2.17.2

