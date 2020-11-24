Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17C74C6379F
	for <linux-block@archiver.kernel.org>; Tue, 24 Nov 2020 01:05:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ADF7520721
	for <linux-block@archiver.kernel.org>; Tue, 24 Nov 2020 01:05:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NGod7eig"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728193AbgKXBFD (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 23 Nov 2020 20:05:03 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:51408 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728149AbgKXBFD (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 23 Nov 2020 20:05:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606179902;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0QRgWQAgp2wbMXFshIMqSuj8+Y5bpwNzqyWYNL833Vg=;
        b=NGod7eigIv91mIAm0ujAz9JJaL0MGMC2yG/w6C2BN4i2g8h3oMRIXEgvIySnpTjW7dTTlA
        zeyH3jbBcBXiOs5TvWeeAeh251rjMZ6B/9Q+R61axJyRtaiNysxE5w2Hz9j2IwVXVxTZot
        Y2acKQIXOpVDIVXdH69Kr8GxySYEUcs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-95-M0YeAQSHMVqG5czEIDxiRw-1; Mon, 23 Nov 2020 20:05:00 -0500
X-MC-Unique: M0YeAQSHMVqG5czEIDxiRw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0F97980EDA9;
        Tue, 24 Nov 2020 01:04:59 +0000 (UTC)
Received: from dhcp-12-105.nay.redhat.com (unknown [10.66.61.33])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 38DEC1346D;
        Tue, 24 Nov 2020 01:04:56 +0000 (UTC)
From:   Yi Zhang <yi.zhang@redhat.com>
To:     osandov@osandov.com, bvanassche@acm.org
Cc:     linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
        sagi@grimberg.me
Subject: [PATCH blktests 3/5] tests/nvmeof-mp/012: fix the schedulers list
Date:   Tue, 24 Nov 2020 09:04:25 +0800
Message-Id: <20201124010427.18595-4-yi.zhang@redhat.com>
In-Reply-To: <20201124010427.18595-1-yi.zhang@redhat.com>
References: <20201124010427.18595-1-yi.zhang@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

There is no cfg scheduler and new added kyber scheduler in lastest kernel,
so get the scheduler from sysfs

To reproduce it:
$ ./check nvmeof-mp/012
nvmeof-mp/012 (dm-mpath on top of multiple I/O schedulers)   [passed]
    runtime  5.922s  ...  8.804s

$ cat results/nodev/nvmeof-mp/012.full  | grep -n "Changing scheduler"
31:Changing scheduler of dm-3 from mq-deadline kyber [bfq] none into cfq failed
47:Changing scheduler of dm-3 from mq-deadline kyber [bfq] none into cfq failed

Signed-off-by: Yi Zhang <yi.zhang@redhat.com>
---
 tests/nvmeof-mp/012 | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/tests/nvmeof-mp/012 b/tests/nvmeof-mp/012
index ae6a92c..96adc70 100755
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
+		scheds=$(sed 's/[][]//g' /sys/block/"$dm"/queue/scheduler) || return $?
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
-- 
2.21.0

