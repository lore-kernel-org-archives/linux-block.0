Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C62F8C43334
	for <linux-block@archiver.kernel.org>; Fri,  3 Jun 2022 04:56:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239075AbiFCE4P (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 3 Jun 2022 00:56:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231318AbiFCE4O (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 3 Jun 2022 00:56:14 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2C4536E10
        for <linux-block@vger.kernel.org>; Thu,  2 Jun 2022 21:56:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=YZqL45OZLXfGdFUrW98mhAIJnOCPS8lTW1cNSXZmPb8=; b=n/nXkNzj9wXiTA87jPUT8s/+f4
        O0i25IiFtF02P8vxV+6mwiKgBdhJZ16az2GjS+iyPf3Vo3AkTqi7oH54Uck75AT9Q86q5WjM/sBHp
        SQclnUHm0gSTR7coCabkk0uS9elegJ0S9HcqhKECXaYwWKIE6+9t91MqNnD9Oxco2vbzlbHw/JUeo
        Bl7+KJpuAAxXOX7LqqBctDw6M8yAWJDRiVgO6M6Z4cnNujEt5YStOuTbKQvqjq7MaN8iWKfaI5Ahw
        /vQRfpGyLdSDKPUfGpkoaX55WJ0EPbikO3SNUMm9NbgTxnd9zPHvT76EDgSBYDe3qFb1eEU5P6M2J
        D9y0Va0A==;
Received: from [2001:4bb8:185:a81e:9865:e17e:4c0c:3e17] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nwzM5-005qPg-3n; Fri, 03 Jun 2022 04:56:13 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc:     linux-block@vger.kernel.org
Subject: [PATCH blktests 05/13] block/006: convert to use _configure_null_blk
Date:   Fri,  3 Jun 2022 06:55:50 +0200
Message-Id: <20220603045558.466760-6-hch@lst.de>
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
 tests/block/006 | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tests/block/006 b/tests/block/006
index 7ca1021..7d05b11 100755
--- a/tests/block/006
+++ b/tests/block/006
@@ -24,18 +24,18 @@ test() {
 	_divide_timeout 2
 	FIO_PERF_FIELDS=("read iops")
 
-	if ! _init_null_blk submit_queues=2 blocking=1; then
+	if ! _configure_null_blk nullb1 submit_queues=2 blocking=1 power=1; then
 		return 1
 	fi
 
 	# run sync test
 	_fio_perf --bs=4k --ioengine=sync --rw=randread --norandommap --name=sync \
-		--filename=/dev/nullb0 --size=5g --direct=1
+		--filename=/dev/nullb1 --size=5g --direct=1
 
 	# run async test
 	_fio_perf --bs=4k --ioengine=libaio --iodepth=8 --numjobs="$(nproc)" \
 		--rw=randread --norandommap --name=async \
-		--filename=/dev/nullb0 --size=5g --direct=1
+		--filename=/dev/nullb1 --size=5g --direct=1
 
 	_exit_null_blk
 
-- 
2.30.2

