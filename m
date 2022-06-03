Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D35E1C43334
	for <linux-block@archiver.kernel.org>; Fri,  3 Jun 2022 04:56:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239077AbiFCE4W (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 3 Jun 2022 00:56:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231318AbiFCE4T (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 3 Jun 2022 00:56:19 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE6CC36E10
        for <linux-block@vger.kernel.org>; Thu,  2 Jun 2022 21:56:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=Z2CkPnYlffK5GNSK1h/kYKOR8TaKi66VozXAAmMXrbg=; b=A5uVjge1g08d/PxPAVODOTt2b3
        HceGM5KRgdKRpIUvkj2yHdSpXz5LLJrinKjSW5PGUfVFWuiT36L5i++4ze1C48JTa4t/Hkl0BMViC
        vMZfYePAmvk+wgNtoUvK2fcKfn1xsziSEFnpfRt1q3rRMDxNlc589Vz5F6u2cUxMySZ8P+Ht/jKd5
        wUA/Eq5O85XcwUfywa96iN3ywo472vBf9rLzyWFrFcSY69XE5bIEZYN6JzKkfP9EAV38JNpNgRwLM
        RzyKDM8j8UcufaghjidxffB0UDz5dCISPI9irUQ35AUY93MYbaCpuVKfV6kit8UwLguMffF2ygDYy
        unpAsHGQ==;
Received: from [2001:4bb8:185:a81e:9865:e17e:4c0c:3e17] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nwzMA-005qQU-3P; Fri, 03 Jun 2022 04:56:18 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc:     linux-block@vger.kernel.org
Subject: [PATCH blktests 07/13] block/017: convert to use _configure_null_blk
Date:   Fri,  3 Jun 2022 06:55:52 +0200
Message-Id: <20220603045558.466760-8-hch@lst.de>
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
 tests/block/017 | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/tests/block/017 b/tests/block/017
index c84b661..8596888 100755
--- a/tests/block/017
+++ b/tests/block/017
@@ -19,23 +19,24 @@ requires() {
 
 show_inflight() {
 	awk '{ printf "sysfs inflight reads %d\nsysfs inflight writes %d\n", $1, $2 }' \
-		/sys/block/nullb0/inflight
-	awk '{ print "sysfs stat " $9 }' /sys/block/nullb0/stat
-	awk '$3 == "nullb0" { print "diskstats " $12 }' /proc/diskstats
+		/sys/block/nullb1/inflight
+	awk '{ print "sysfs stat " $9 }' /sys/block/nullb1/stat
+	awk '$3 == "nullb1" { print "diskstats " $12 }' /proc/diskstats
 }
 
 test() {
 	echo "Running ${TEST_NAME}"
 
-	if ! _init_null_blk irqmode=2 completion_nsec=500000000; then
+	if ! _configure_null_blk nullb1 irqmode=2 completion_nsec=500000000 \
+			power=1; then
 		return 1
 	fi
 
-	dd if=/dev/nullb0 of=/dev/null bs=4096 iflag=direct count=1 status=none &
+	dd if=/dev/nullb1 of=/dev/null bs=4096 iflag=direct count=1 status=none &
 	sleep 0.1
 	show_inflight
 
-	dd if=/dev/zero of=/dev/nullb0 bs=4096 oflag=direct count=1 status=none &
+	dd if=/dev/zero of=/dev/nullb1 bs=4096 oflag=direct count=1 status=none &
 	sleep 0.1
 	show_inflight
 
-- 
2.30.2

