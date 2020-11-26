Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEC9DC64E7B
	for <linux-block@archiver.kernel.org>; Thu, 26 Nov 2020 08:36:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6E75E21D7F
	for <linux-block@archiver.kernel.org>; Thu, 26 Nov 2020 08:36:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XeQan2Vj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728790AbgKZIgN (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 26 Nov 2020 03:36:13 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:43781 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728364AbgKZIgN (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 26 Nov 2020 03:36:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606379771;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wVrLd3u++NGxsba5ZF6vCk00fz0YWU/gqYiw53/j61A=;
        b=XeQan2Vjktw9Xek+ZnS/unqSFGPK4OgkYAlVzdUqT0t7uqVEaz9jskrnkYHQYxdq4V325i
        j919E1qhATr8BRJZplXAHYHhbxUg0jzB6jw4nLS3Qfb38+KgJ7+2928L4eBRwRpagUIRqE
        LwzHr4K/mgwmHtuOLTw7kdRAezQieRU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-590-nbB4CddkNWW-62uA4Ihwlg-1; Thu, 26 Nov 2020 03:36:05 -0500
X-MC-Unique: nbB4CddkNWW-62uA4Ihwlg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F239D1012E85;
        Thu, 26 Nov 2020 08:36:03 +0000 (UTC)
Received: from dhcp-12-105.nay.redhat.com (unknown [10.66.61.33])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 27D1819C66;
        Thu, 26 Nov 2020 08:36:01 +0000 (UTC)
From:   Yi Zhang <yi.zhang@redhat.com>
To:     osandov@osandov.com, bvanassche@acm.org
Cc:     linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
        sagi@grimberg.me
Subject: [PATCH V3 blktests 3/5] nvmeof-mp/012, srp/012: fix the scheduler list
Date:   Thu, 26 Nov 2020 16:35:30 +0800
Message-Id: <20201126083532.27509-4-yi.zhang@redhat.com>
In-Reply-To: <20201126083532.27509-1-yi.zhang@redhat.com>
References: <20201126083532.27509-1-yi.zhang@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

There is no cfq scheduler and new added kyber scheduler in lastest kernel,
introduce get_scheduler_list and fix nvmeof-mp/012 srp/012

To reproduce it:
$ ./check nvmeof-mp/012
nvmeof-mp/012 (dm-mpath on top of multiple I/O schedulers)   [passed]
    runtime  5.922s  ...  8.804s

$ cat results/nodev/nvmeof-mp/012.full  | grep -n "Changing scheduler"
31:Changing scheduler of dm-3 from mq-deadline kyber [bfq] none into cfq failed
47:Changing scheduler of dm-3 from mq-deadline kyber [bfq] none into cfq failed

Signed-off-by: Yi Zhang <yi.zhang@redhat.com>
---
 common/multipath-over-rdma | 11 +++++++++++
 tests/nvmeof-mp/012        | 10 ++++++----
 tests/srp/012              | 10 ++++++----
 3 files changed, 23 insertions(+), 8 deletions(-)

diff --git a/common/multipath-over-rdma b/common/multipath-over-rdma
index ebc5939..ba6fa0d 100644
--- a/common/multipath-over-rdma
+++ b/common/multipath-over-rdma
@@ -326,6 +326,17 @@ set_scheduler() {
 	fi
 }
 
+# Get block dev scheduler list
+get_scheduler_list() {
+	local b=$1 p
+	p=/sys/block/"$b"/queue/scheduler
+	if [ -e "$p" ]; then
+		sed 's/[][]//g' /sys/block/"$b"/queue/scheduler
+	else
+		return 1
+	fi
+}
+
 # Get a /dev/... path that points at dm device number $1. Set its I/O scheduler
 # to $2 and its timeout to $3. The shell script that includes this file must
 # define a function get_bdev_path() that translates device number $1 into a
diff --git a/tests/nvmeof-mp/012 b/tests/nvmeof-mp/012
index ae6a92c..8b2e918 100755
--- a/tests/nvmeof-mp/012
+++ b/tests/nvmeof-mp/012
@@ -8,7 +8,7 @@ DESCRIPTION="dm-mpath on top of multiple I/O schedulers"
 QUICK=1
 
 test_io_schedulers() {
-	local dev m
+	local dev m dm scheds
 
 	# Load all I/O scheduler kernel modules
 	for m in "/lib/modules/$(uname -r)/kernel/block/"*.ko; do
@@ -17,15 +17,17 @@ test_io_schedulers() {
 	for mq in y n; do
 		use_blk_mq ${mq} || return $?
 		dev=$(get_bdev 0) || return $?
-		for sched in noop deadline bfq cfq; do
-			set_scheduler "$(basename "$(readlink -f "${dev}")")" $sched \
+		dm=$(basename "$(readlink -f "${dev}")") || return $?
+		scheds="$(get_scheduler_list "$dm")" || return $?
+		for sched in $scheds; do
+			set_scheduler "$dm" "$sched" \
 				      >>"$FULL" 2>&1 || continue
 			echo "I/O scheduler: $sched; use_blk_mq: $mq" >>"$FULL"
 			run_fio --verify=md5 --rw=randwrite --bs=4K --size=64K \
 				--ioengine=libaio --iodepth=64 \
 				--iodepth_batch=32 --group_reporting --sync=1 \
 				--direct=1 --filename="$dev" \
-				--name=${sched} --thread --numjobs=1 \
+				--name="${sched}" --thread --numjobs=1 \
 				--output="${RESULTS_DIR}/nvmeof-mp/012-${sched}-${mq}.txt" \
 				>>"$FULL" ||
 				return $?
diff --git a/tests/srp/012 b/tests/srp/012
index 20c6daf..ffd56ef 100755
--- a/tests/srp/012
+++ b/tests/srp/012
@@ -8,7 +8,7 @@ DESCRIPTION="dm-mpath on top of multiple I/O schedulers"
 QUICK=1
 
 test_io_schedulers() {
-	local dev m
+	local dev m dm scheds
 
 	# Load all I/O scheduler kernel modules
 	for m in "/lib/modules/$(uname -r)/kernel/block/"*.ko; do
@@ -18,15 +18,17 @@ test_io_schedulers() {
 		[ $mq = n ] && ! _have_legacy_dm && continue
 		use_blk_mq ${mq} ${mq} || return $?
 		dev=$(get_bdev 0) || return $?
-		for sched in noop deadline bfq cfq; do
-			set_scheduler "$(basename "$(readlink -f "${dev}")")" $sched \
+		dm=$(basename "$(readlink -f "${dev}")") || return $?
+		scheds="$(get_scheduler_list "$dm")" || return $?
+		for sched in $scheds; do
+			set_scheduler "$dm" "$sched" \
 				      >>"$FULL" 2>&1 || continue
 			echo "I/O scheduler: $sched; use_blk_mq: $mq" >>"$FULL"
 			run_fio --verify=md5 --rw=randwrite --bs=4K --size=64K \
 				--ioengine=libaio --iodepth=64 \
 				--iodepth_batch=32 --group_reporting --sync=1 \
 				--direct=1 --filename="$dev" \
-				--name=${sched} --thread --numjobs=1 \
+				--name="${sched}" --thread --numjobs=1 \
 				--output="${RESULTS_DIR}/srp/012-${sched}-${mq}.txt" \
 				>>"$FULL" ||
 				return $?
-- 
2.21.0

