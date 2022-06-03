Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AE30C43334
	for <linux-block@archiver.kernel.org>; Fri,  3 Jun 2022 04:56:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239206AbiFCE4f (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 3 Jun 2022 00:56:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231318AbiFCE4e (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 3 Jun 2022 00:56:34 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FAA136E10
        for <linux-block@vger.kernel.org>; Thu,  2 Jun 2022 21:56:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=jqrgVGzy1obXQ34EADFADidNeaZkYzLm17/7aQR9VVw=; b=jYCUshwlHHBrYASzJ1AEfXy0N6
        ypSWrP1ujp17qghbade4n566EERbF0PiIPnu4hg0kVdjjnSxiilySDttg9L5+Wsv8vqLVH1JpZHsu
        wLPdNu9/BfIz2rekJs/kaLI2bzAO2wmyFgXZQdTMntXFieW1M1rrXXcg5EOzkp42KsI9YjU8Z8qqf
        4iLrLaLqb4502Jd8YzJ2DdkQGkKVjw/FgtSNNwGJ4XTb66zWIaSu9juxOcC1JOfQffrmXFMnkqffo
        tbfmB0x/ycsxDMzZBsAVPhntsQA1c/rQm7qMkOcRYykd6Y1Akz1AcPyvU2gqaMzjXm/OewXRAiO3s
        a0k+L2Sg==;
Received: from [2001:4bb8:185:a81e:9865:e17e:4c0c:3e17] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nwzMO-005qSu-P1; Fri, 03 Jun 2022 04:56:33 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc:     linux-block@vger.kernel.org
Subject: [PATCH blktests 13/13] zbd: allow falling back to builtin null_blk
Date:   Fri,  3 Jun 2022 06:55:58 +0200
Message-Id: <20220603045558.466760-14-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220603045558.466760-1-hch@lst.de>
References: <20220603045558.466760-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Use _configure_null_blk to configure the fallback device and thus allow
for a built-in null_blk driver.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 tests/zbd/rc | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/tests/zbd/rc b/tests/zbd/rc
index 9deadc1..e56d607 100644
--- a/tests/zbd/rc
+++ b/tests/zbd/rc
@@ -13,7 +13,7 @@
 
 group_requires() {
 	_have_root && _have_program blkzone && _have_program dd &&
-		_have_kernel_option BLK_DEV_ZONED && _have_modules null_blk &&
+		_have_kernel_option BLK_DEV_ZONED && _have_null_blk &&
 		_have_module_param null_blk zoned
 }
 
@@ -25,10 +25,11 @@ group_device_requires() {
 }
 
 _fallback_null_blk_zoned() {
-	if ! _init_null_blk zone_size=4 gb=1 zoned=1 ; then
+	if ! _configure_null_blk nullb1 zone_size=4 size=1048576 zoned=1 \
+			power=1; then
 		return 1
 	fi
-	echo /dev/nullb0
+	echo /dev/nullb1
 }
 
 #
-- 
2.30.2

