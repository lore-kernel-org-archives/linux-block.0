Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09ED5C433EF
	for <linux-block@archiver.kernel.org>; Fri,  3 Jun 2022 04:56:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239103AbiFCE4Z (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 3 Jun 2022 00:56:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231318AbiFCE4Y (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 3 Jun 2022 00:56:24 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B031136E11
        for <linux-block@vger.kernel.org>; Thu,  2 Jun 2022 21:56:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=SqL/dT8JHaSK4BhmWma2PjJFslONxIxpXjyJPGhZHP4=; b=r8BEnNEZH2XQ7sr/BjuBqpVXzQ
        LrBfDA5bw6dPgAwqzs2hJjKEoSgY8YMJYKLDV7KR8wsuR6EVdTW4DCt+ishp81R49kt0tQJkKB5i7
        dMX4lJ7wecc/EUSio/Qfh1WAFfYqywXuw716zhX+Rh/Lh/qhE10gXYHvstjGg9xi2nZmt62LAcmuk
        Z9uCKYcuEcnFJdft5uOc1aB2efgiDjUpVwCS+ogQPRINOAR25HC5P7Is2dSAsv8qUZThHkud9MZiJ
        t7SkYs/PyCrrjjaQ7iLeVg6C5TDKWh0co/eUnbdZPZV/W1fmc/nt7mQqvubFNAEdDhyXJr5VsE+xK
        WsNIhJwA==;
Received: from [2001:4bb8:185:a81e:9865:e17e:4c0c:3e17] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nwzME-005qRK-Vt; Fri, 03 Jun 2022 04:56:23 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc:     linux-block@vger.kernel.org
Subject: [PATCH blktests 09/13] block/020: convert to use _configure_null_blk
Date:   Fri,  3 Jun 2022 06:55:54 +0200
Message-Id: <20220603045558.466760-10-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220603045558.466760-1-hch@lst.de>
References: <20220603045558.466760-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Switch to use _configure_null_blk so that built-in null_blk can be
supported, which implies not using the default nullb0 device.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 tests/block/020 | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/tests/block/020 b/tests/block/020
index eef63cb..3e8cbbd 100755
--- a/tests/block/020
+++ b/tests/block/020
@@ -20,14 +20,14 @@ requires() {
 test() {
 	echo "Running ${TEST_NAME}"
 
-	if ! _init_null_blk irqmode=2 completion_nsec=2000000 \
-	     submit_queues=4 hw_queue_depth=1; then
+	if ! _configure_null_blk nullb1 irqmode=2 completion_nsec=2000000 \
+	     submit_queues=4 hw_queue_depth=1 power=1; then
 		return 1
 	fi
 
 	local scheds
 	# shellcheck disable=SC2207
-	scheds=($(sed 's/[][]//g' /sys/block/nullb0/queue/scheduler))
+	scheds=($(sed 's/[][]//g' /sys/block/nullb1/queue/scheduler))
 
 	local max_iodepth=$(($(cat /proc/sys/fs/aio-max-nr) / $(nproc)))
 	local iodepth=1024
@@ -36,10 +36,10 @@ test() {
 	fi
 	for sched in "${scheds[@]}"; do
 		echo "Testing $sched" >> "$FULL"
-		echo "$sched" > /sys/block/nullb0/queue/scheduler
+		echo "$sched" > /sys/block/nullb1/queue/scheduler
 		_fio_perf --bs=4k --ioengine=libaio --iodepth=$iodepth \
 			--numjobs="$(nproc)" --rw=randread --name=async \
-			--filename=/dev/nullb0 --size=1g --direct=1 \
+			--filename=/dev/nullb1 --size=1g --direct=1 \
 			--runtime=10
 	done
 
-- 
2.30.2

