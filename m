Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81B71C43334
	for <linux-block@archiver.kernel.org>; Fri,  3 Jun 2022 04:56:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239091AbiFCE4R (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 3 Jun 2022 00:56:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231318AbiFCE4Q (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 3 Jun 2022 00:56:16 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A8FB36E10
        for <linux-block@vger.kernel.org>; Thu,  2 Jun 2022 21:56:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=MSo0KHkZgIYFHJZ42AzFvKbwN7oNudFzfkVTVPAxH7Q=; b=EhviBmHkbac3x9F4U1A2xBktJR
        382bGEFW15AwamhBV9Oo5vPpUUYGLzf85YXaShwDT5jj72iEM5NhLGalrDeGpDhqSCk1P86KQpAth
        QTwlNL23VOLd/F/t+ZWI1+iS+VUPYxMznSdWEiwvCHYZy60KNfeQQo3RNuKnDmH37KG27N7yjwHcC
        PWIZjTdNWaLSP1cgdcy6A0T3kBPeUmPzFV48/Rd2KAQawqQyFf7ZBguO0zfwBib5ee1Uh1X7gmCUo
        GnGUMKn0qAi28+4AgpVUh64RE45BS8VT5f+mFr11YVYUNLPNUVwRR+twi/8wjZMguknYz0jBetSK/
        ojKnRY3w==;
Received: from [2001:4bb8:185:a81e:9865:e17e:4c0c:3e17] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nwzM7-005qQ5-Jr; Fri, 03 Jun 2022 04:56:16 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc:     linux-block@vger.kernel.org
Subject: [PATCH blktests 06/13] block/016: convert to use _configure_null_blk
Date:   Fri,  3 Jun 2022 06:55:51 +0200
Message-Id: <20220603045558.466760-7-hch@lst.de>
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
 tests/block/016 | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/tests/block/016 b/tests/block/016
index 2b7a05f..775069c 100755
--- a/tests/block/016
+++ b/tests/block/016
@@ -20,21 +20,22 @@ requires() {
 test() {
 	echo "Running ${TEST_NAME}"
 
-	if ! _init_null_blk irqmode=2 completion_nsec=2000000000; then
+	if ! _configure_null_blk nullb1 irqmode=2 completion_nsec=2000000000 \
+			power=1; then
 		return 1
 	fi
 
 	# Start an I/O, which will take two seconds.
-	dd if=/dev/nullb0 of=/dev/null bs=512 iflag=direct count=1 status=none &
+	dd if=/dev/nullb1 of=/dev/null bs=512 iflag=direct count=1 status=none &
 	sleep 0.5
 
 	# This will freeze the queue, and since we have an I/O in flight, it
 	# will stay frozen until the I/O completes.
-	echo 64 > /sys/block/nullb0/queue/nr_requests &
+	echo 64 > /sys/block/nullb1/queue/nr_requests &
 	sleep 0.5
 
 	# Do an I/O, which will wait for the queue to unfreeze.
-	dd if=/dev/nullb0 of=/dev/null bs=512 iflag=direct count=1 status=none &
+	dd if=/dev/nullb1 of=/dev/null bs=512 iflag=direct count=1 status=none &
 	sleep 0.5
 
 	# While dd is blocked, send a signal which we know dd has a handler
-- 
2.30.2

