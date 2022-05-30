Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20BD5C433FE
	for <linux-block@archiver.kernel.org>; Mon, 30 May 2022 13:08:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236325AbiE3NIb (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 30 May 2022 09:08:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236331AbiE3NIa (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 30 May 2022 09:08:30 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FFBB70929
        for <linux-block@vger.kernel.org>; Mon, 30 May 2022 06:08:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=Zt5SOYIQBaljWSRSx9PdlQ7CPcrIm29jDIYfpK+YDz0=; b=Nn8+DO1HPqBmuztX9Sh/kq6H4w
        VjI0xNTeqEgsdOYxBzL2D3abhPIUBlJLymwNGeozGNQjPEoxA930tmcTZkwMXkeAnS6upHI7RRSHd
        BpmBnOiBjJsLLT/+MrbEJBMeq/+uh9DgEFPIj95UfkUyROVc2AqjaPMjY1ecvr/9Y8EasRrySEvJC
        l95f3yHykHFKSIiLQCSQpBFHQHh/ikIhzXY5UaOQTTWGhf1LVqcuF51X6+7N2QLHKeBCLh3Ckodvw
        HZjKItUQKDhLZLlwGYULFUbyHIeZwSmsC9ibdtlOwO9aUKEZ0qPMusY+t6Dwc1FDmnLKAGM+GOW8w
        94SvY+hA==;
Received: from [2001:4bb8:185:a81e:fda9:da32:3b0c:8358] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nvf8G-006bpM-BK; Mon, 30 May 2022 13:08:28 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc:     linux-block@vger.kernel.org
Subject: [PATCH blktests 5/9] common: do not require null_blk support to be modular
Date:   Mon, 30 May 2022 15:08:07 +0200
Message-Id: <20220530130811.3006554-6-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220530130811.3006554-1-hch@lst.de>
References: <20220530130811.3006554-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Use _have_driver instead of _have_modules in _have_null_blk for the basic
null_blk check, and instead only require an actual module in
_init_null_blk when specific module parameters are passed.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 common/null_blk | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/common/null_blk b/common/null_blk
index 6611db0..ccf3750 100644
--- a/common/null_blk
+++ b/common/null_blk
@@ -5,7 +5,7 @@
 # null_blk helper functions.
 
 _have_null_blk() {
-	_have_modules null_blk
+	_have_driver null_blk
 }
 
 _remove_null_blk_devices() {
@@ -16,15 +16,19 @@ _remove_null_blk_devices() {
 }
 
 _init_null_blk() {
-	_remove_null_blk_devices
+	local modparams="$@"
 
-	local zoned=""
-	if (( RUN_FOR_ZONED )); then zoned="zoned=1"; fi
+	if (( RUN_FOR_ZONED )); then
+		modparams="${modparams} zoned=1"
+	fi
 
-	if ! modprobe -r null_blk || ! modprobe null_blk "$@" "${zoned}" ; then
+	if [ -n "${modparams}" ] && ! _have_modules null_blk; then
 		return 1
 	fi
 
+	_remove_null_blk_devices
+	modprobe -qr null_blk && modprobe -q null_blk ${modparams}
+
 	udevadm settle
 	return 0
 }
@@ -46,5 +50,5 @@ _configure_null_blk() {
 _exit_null_blk() {
 	_remove_null_blk_devices
 	udevadm settle
-	modprobe -r null_blk
+	modprobe -qr null_blk
 }
-- 
2.30.2

