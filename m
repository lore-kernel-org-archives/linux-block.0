Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 323F8CCA473
	for <linux-block@archiver.kernel.org>; Fri,  3 Jun 2022 04:56:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239102AbiFCE4Y (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 3 Jun 2022 00:56:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231318AbiFCE4W (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 3 Jun 2022 00:56:22 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B8F436E11
        for <linux-block@vger.kernel.org>; Thu,  2 Jun 2022 21:56:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=2W4S3a1VuQDwEOsgchh+sd14l85+LMpS0eeU2cEnqkk=; b=EqbuXD9qdAwgI+wtrYZn1mRXdR
        ue0l5UpluoUNL5ZAplbjjy5BpOqz0o94ggZmO6ou+NM+sY9i7R9bP0T7ulANET0rc0va8FPPm5n2p
        ORZ5LIu8ihdkLMCI35hQffgSEiyFgQRzNatoP4GzGjvxi7NuXG6vk+dL4ELJzZ1lhzhcbFFe3ipL3
        WSTS8Di68ULMBsrB+0rJWxQAvgF507kSDOAgndyG3hFpXt+92yLz+TfNxdwRemqswLH6b+/XEI0sQ
        synNSUrCbSMlokpKAh9lz6a3EQjo9SlO6oXSIAxwLZfno5CnbT40U2xmCXgFDxRG1fB2q2e29tLXZ
        heLlSU9A==;
Received: from [2001:4bb8:185:a81e:9865:e17e:4c0c:3e17] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nwzMC-005qQw-I9; Fri, 03 Jun 2022 04:56:20 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc:     linux-block@vger.kernel.org
Subject: [PATCH blktests 08/13] block/018: convert to use _configure_null_blk
Date:   Fri,  3 Jun 2022 06:55:53 +0200
Message-Id: <20220603045558.466760-9-hch@lst.de>
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
 tests/block/018 | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/tests/block/018 b/tests/block/018
index a80ecbc..e7ac445 100755
--- a/tests/block/018
+++ b/tests/block/018
@@ -15,13 +15,13 @@ requires() {
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
@@ -33,22 +33,23 @@ test() {
 
 	echo "Running ${TEST_NAME}"
 
-	if ! _init_null_blk irqmode=2 completion_nsec=1000000000; then
+	if ! _configure_null_blk nullb1 irqmode=2 completion_nsec=1000000000 \
+			power=1; then
 		return 1
 	fi
 
 	init_times
 	show_times
 
-	dd if=/dev/nullb0 of=/dev/null bs=4096 iflag=direct count=1 status=none
+	dd if=/dev/nullb1 of=/dev/null bs=4096 iflag=direct count=1 status=none
 	show_times
 
-	dd if=/dev/zero of=/dev/nullb0 bs=4096 oflag=direct count=1 status=none
+	dd if=/dev/zero of=/dev/nullb1 bs=4096 oflag=direct count=1 status=none
 	show_times
 
-	dd if=/dev/nullb0 of=/dev/null bs=4096 iflag=direct count=1 status=none &
-	dd if=/dev/zero of=/dev/nullb0 bs=4096 oflag=direct count=1 status=none &
-	dd if=/dev/zero of=/dev/nullb0 bs=4096 oflag=direct count=1 status=none &
+	dd if=/dev/nullb1 of=/dev/null bs=4096 iflag=direct count=1 status=none &
+	dd if=/dev/zero of=/dev/nullb1 bs=4096 oflag=direct count=1 status=none &
+	dd if=/dev/zero of=/dev/nullb1 bs=4096 oflag=direct count=1 status=none &
 	wait
 	show_times
 
-- 
2.30.2

