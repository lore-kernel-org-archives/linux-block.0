Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EED14C433EF
	for <linux-block@archiver.kernel.org>; Fri,  3 Jun 2022 04:56:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239157AbiFCE4d (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 3 Jun 2022 00:56:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231318AbiFCE4c (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 3 Jun 2022 00:56:32 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13B4536E10
        for <linux-block@vger.kernel.org>; Thu,  2 Jun 2022 21:56:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=JeU7VryXXcal5oED3q371Aec/jIk1kAEDb5xYMDF3/I=; b=BTJYvl75J37/2UCGuwnBuAuNLd
        H+zcSzlhE1pak+K4XZYwOM9ufYMK2s5q1y9biZECQ+rtLkJvbe6uHV4f6AagQgOOmM4o+99xs0gPC
        SB8awguxYPha1+V4L3wlWAfwumiSZ1Uxkuby/vLRjsJtid88lr/RM37bxDwU9/y1XnbaMvZgN0tM9
        dKnjjh57QplOUV0AJkkO5NSUzQWj5bauRTa64JBpWieZpexVmp2GszvPYHcy8leh0T1kcEC5iDkoV
        43IBBUQn1Op2W0KE9KVAZ4kc0utV/woFAy0SaLwsX4h/cD0Xt60iZPGYL5oNxQF8DMf/iOtTU52Vi
        LcGTf8LA==;
Received: from [2001:4bb8:185:a81e:9865:e17e:4c0c:3e17] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nwzMM-005qSa-Aj; Fri, 03 Jun 2022 04:56:30 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc:     linux-block@vger.kernel.org
Subject: [PATCH blktests 12/13] block/024: convert to use _configure_null_blk
Date:   Fri,  3 Jun 2022 06:55:57 +0200
Message-Id: <20220603045558.466760-13-hch@lst.de>
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
 tests/block/024 | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/tests/block/024 b/tests/block/024
index 6808db0..2a7c934 100755
--- a/tests/block/024
+++ b/tests/block/024
@@ -17,13 +17,13 @@ requires() {
 }
 
 init_times() {
-	init_read_ms="$(awk '{ print $4 }' /sys/block/nullb0/stat)"
-	init_write_ms="$(awk '{ print $8 }' /sys/block/nullb0/stat)"
+	init_read_ms="$(awk '{ print $4 }' /sys/block/nullb1/stat)"
+	init_write_ms="$(awk '{ print $8 }' /sys/block/nullb1/stat)"
 }
 
 show_times() {
-	read_ms="$(awk '{ print $4 }' /sys/block/nullb0/stat)"
-	write_ms="$(awk '{ print $8 }' /sys/block/nullb0/stat)"
+	read_ms="$(awk '{ print $4 }' /sys/block/nullb1/stat)"
+	write_ms="$(awk '{ print $8 }' /sys/block/nullb1/stat)"
 
 	# Print rounded to the nearest second
 	printf 'read %d s\n' $(((read_ms - init_read_ms + 500) / 1000))
@@ -37,7 +37,8 @@ test() {
 
 	# The maximum value for CONFIG_HZ is 1000. I.e., a tick is one
 	# millisecond. So, make each I/O take half a millisecond.
-	if ! _init_null_blk irqmode=2 completion_nsec=500000; then
+	if ! _configure_null_blk nullb1 irqmode=2 completion_nsec=500000 \
+			power=1; then
 		return 1
 	fi
 
@@ -46,16 +47,16 @@ test() {
 
 	# 1500 * 0.5 ms is 0.75 seconds, allowing for some overhead so
 	# that it rounds to one second.
-	dd if=/dev/nullb0 of=/dev/null bs=4096 iflag=direct count=1500 status=none
+	dd if=/dev/nullb1 of=/dev/null bs=4096 iflag=direct count=1500 status=none
 	show_times
 
-	dd if=/dev/zero of=/dev/nullb0 bs=4096 oflag=direct count=1500 status=none
+	dd if=/dev/zero of=/dev/nullb1 bs=4096 oflag=direct count=1500 status=none
 	show_times
 
 	# 1800 * 0.5 ms is 0.9 seconds.
-	dd if=/dev/nullb0 of=/dev/null bs=4096 iflag=direct count=1500 status=none &
-	dd if=/dev/zero of=/dev/nullb0 bs=4096 oflag=direct count=1800 status=none &
-	dd if=/dev/zero of=/dev/nullb0 bs=4096 oflag=direct count=1800 status=none &
+	dd if=/dev/nullb1 of=/dev/null bs=4096 iflag=direct count=1500 status=none &
+	dd if=/dev/zero of=/dev/nullb1 bs=4096 oflag=direct count=1800 status=none &
+	dd if=/dev/zero of=/dev/nullb1 bs=4096 oflag=direct count=1800 status=none &
 	wait
 	show_times
 
-- 
2.30.2

