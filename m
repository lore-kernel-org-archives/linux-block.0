Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D288BC43334
	for <linux-block@archiver.kernel.org>; Tue,  7 Jun 2022 12:48:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244206AbiFGMsb (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 7 Jun 2022 08:48:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244238AbiFGMs0 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 7 Jun 2022 08:48:26 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05B7027FDF
        for <linux-block@vger.kernel.org>; Tue,  7 Jun 2022 05:48:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=9ImW3ViAH4R/6++YirlEucp0ES3EGzNnPCCbYMq0OV8=; b=Agj0jyta1cI2r67tQeRCu/M4pF
        0Woaeh+wmoy0rItA+rYZgoNRAa3HF/1uowgcBgn11Et+M1BSAjc26fRzfL01zXFBpgWakF1mRo8hG
        frxNUEgI+P0Jn7hZe4jjw3Pt6D8HQRdOcfniyzIC3yA3HV0TPf3XcM9cWEAI7damySpahh9glpsS1
        2/WiCVMdlk3B6z+aUtEMVeCe6qOhmgfnH9sdugcx6ZJUi1wWW75UNjqTrbHUMn+bNCk8G1a1qDIE4
        Id1FQkODVmMOXzp0xDYFOlufovdE+hVQRZLQ1yP8cxNEMw/aQ4m2u8Wt5aPLiVJf437Vfwv/zD4NR
        D82nKXlA==;
Received: from [2001:4bb8:190:726c:b34a:228:52ee:6d34] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nyYd8-007Snm-PW; Tue, 07 Jun 2022 12:48:19 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc:     linux-block@vger.kernel.org
Subject: [PATCH blktests 13/13] zbd: allow falling back to built-in null_blk
Date:   Tue,  7 Jun 2022 14:47:39 +0200
Message-Id: <20220607124739.1259977-14-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220607124739.1259977-1-hch@lst.de>
References: <20220607124739.1259977-1-hch@lst.de>
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
index 9deadc1..fea55d6 100644
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
+	if ! _configure_null_blk nullb1 zone_size=4 size=1024 zoned=1 \
+			power=1; then
 		return 1
 	fi
-	echo /dev/nullb0
+	echo /dev/nullb1
 }
 
 #
-- 
2.30.2

