Return-Path: <SRS0=QnQz=SD=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2E1DC43381
	for <linux-block@archiver.kernel.org>; Mon,  1 Apr 2019 03:38:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C7B720870
	for <linux-block@archiver.kernel.org>; Mon,  1 Apr 2019 03:38:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731597AbfDADiV (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 31 Mar 2019 23:38:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46569 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731476AbfDADiU (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sun, 31 Mar 2019 23:38:20 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C25BB3082D9E;
        Mon,  1 Apr 2019 03:38:20 +0000 (UTC)
Received: from localhost.redhat.com (ovpn-12-85.pek2.redhat.com [10.72.12.85])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 3788E5C207;
        Mon,  1 Apr 2019 03:38:18 +0000 (UTC)
From:   Xiao Liang <xiliang@redhat.com>
To:     linux-block@vger.kernel.org, osandov@fb.com
Cc:     xiliang@redhat.com
Subject: [PATCH blktests] block/020: dynamically change iodepth if test aio-nr lager than aio-max-nr
Date:   Mon,  1 Apr 2019 11:38:00 +0800
Message-Id: <20190401033800.6032-1-xiliang@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.46]); Mon, 01 Apr 2019 03:38:20 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

When system has large count of cpus(eg. 96), the test failed as aio-nr over
aio-max-nr limitation.

This patch continues to use 1024 as default iodepth, but change it if
iodepth*$(nproc) > aio-max-nr.

Signed-off-by: Xiao Liang <xiliang@redhat.com>
---
 tests/block/020 | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/tests/block/020 b/tests/block/020
index 39dde66..f03c131 100755
--- a/tests/block/020
+++ b/tests/block/020
@@ -29,10 +29,16 @@ test() {
 	# shellcheck disable=SC2207
 	scheds=($(sed 's/[][]//g' /sys/block/nullb0/queue/scheduler))
 
+	aio_max_nr=$(cat /proc/sys/fs/aio-max-nr)
+	max_iodepth=$(($aio_max_nr/$(nproc)))
+	iodepth=1024
+	if (( $iodepth > $max_iodepth )); then
+		iodepth=$max_iodepth
+	fi
 	for sched in "${scheds[@]}"; do
 		echo "Testing $sched" >> "$FULL"
 		echo "$sched" > /sys/block/nullb0/queue/scheduler
-		_fio_perf --bs=4k --ioengine=libaio --iodepth=1024 \
+		_fio_perf --bs=4k --ioengine=libaio --iodepth=$iodepth \
 			--numjobs="$(nproc)" --rw=randread --name=async \
 			--filename=/dev/nullb0 --size=1g --direct=1 \
 			--runtime=10
-- 
2.17.2

