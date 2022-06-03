Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71610C433EF
	for <linux-block@archiver.kernel.org>; Fri,  3 Jun 2022 04:56:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239001AbiFCE4N (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 3 Jun 2022 00:56:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231318AbiFCE4M (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 3 Jun 2022 00:56:12 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6016236E10
        for <linux-block@vger.kernel.org>; Thu,  2 Jun 2022 21:56:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=fIIUnl2FFj3PC5UM3XNNeUdzjQLbccPKejN95eKVEjY=; b=TVgFNwI8c9NhQ5xObSl4eB9dXu
        xpQ+wrPm7ODCDNv1rDT8LbOLGQxn+0+ser4pUKAq+7ywXgmGDF/TEg1T6Ac8Ub6kZ2J6+qGqhduaI
        azJXoZcCIfx9NUJ8yq5y496tGyOYvbZtJ1JT5yKiEFFvCUlb63oowQaJPceiqu3WTeW4tKYMFUpYV
        zpy+Xe0b4w4U5K35ZsTHIjP6XApXI0NhG0WsSEedS2vJZQaXleSy/0sBI28vROKNcXVGN3uR7Mdqb
        Zn8GDZ/vsUkCTgaigu7CR0ZIXOAUhMwujDv1o4iQWbsVosQaN8Qtjn4ROlwKHbD1/lz5jt7NEim7m
        OCoE+Z9A==;
Received: from [2001:4bb8:185:a81e:9865:e17e:4c0c:3e17] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nwzM2-005qPE-Kh; Fri, 03 Jun 2022 04:56:11 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc:     linux-block@vger.kernel.org
Subject: [PATCH blktests 04/13] block/029: don't require modular null_blk
Date:   Fri,  3 Jun 2022 06:55:49 +0200
Message-Id: <20220603045558.466760-5-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220603045558.466760-1-hch@lst.de>
References: <20220603045558.466760-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Drop the call to _init_null_blk and just operate on nullb1 instead,
leaving the default device alone.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 tests/block/029 | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/tests/block/029 b/tests/block/029
index dcf4024..b9a897d 100755
--- a/tests/block/029
+++ b/tests/block/029
@@ -21,25 +21,24 @@ modify_nr_hw_queues() {
 	num_cpus=$(nproc)
 	while [ "$(_uptime_s)" -lt "$deadline" ]; do
 		sleep .1
-		echo 1 > /sys/kernel/config/nullb/nullb0/submit_queues
+		echo 1 > /sys/kernel/config/nullb/nullb1/submit_queues
 		sleep .1
-		echo "$num_cpus" > /sys/kernel/config/nullb/nullb0/submit_queues
+		echo "$num_cpus" > /sys/kernel/config/nullb/nullb1/submit_queues
 	done
 }
 
 test() {
-	local sq=/sys/kernel/config/nullb/nullb0/submit_queues
+	local sq=/sys/kernel/config/nullb/nullb1/submit_queues
 
 	: "${TIMEOUT:=30}"
-	_init_null_blk nr_devices=0 &&
-	_configure_null_blk nullb0 completion_nsec=0 blocksize=512 \
+	_configure_null_blk nullb1 completion_nsec=0 blocksize=512 \
 			    size=16 memory_backed=1 power=1 &&
 	if { echo 1 >$sq; } 2>/dev/null; then
 		modify_nr_hw_queues &
 		fio --rw=randwrite --bs=4K --loops=$((10**6)) \
 		    --iodepth=64 --group_reporting --sync=1 --direct=1 \
-		    --ioengine=libaio --filename="/dev/nullb0" \
-		    --runtime="${TIMEOUT}" --name=nullb0 \
+		    --ioengine=libaio --filename="/dev/nullb1" \
+		    --runtime="${TIMEOUT}" --name=nullb1 \
 		    --output="${RESULTS_DIR}/block/fio-output-029.txt" \
 		    >>"$FULL"
 		wait
-- 
2.30.2

