Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4CF6C433F5
	for <linux-block@archiver.kernel.org>; Mon, 30 May 2022 13:08:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236322AbiE3NIW (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 30 May 2022 09:08:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236311AbiE3NIV (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 30 May 2022 09:08:21 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9BD870904
        for <linux-block@vger.kernel.org>; Mon, 30 May 2022 06:08:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=3t7tAIs+lapqDmjwRgXDVembunHtARLvAPkViFJb43Y=; b=v1LhVBOHUD6pA8B58aAENTBGwD
        iYEzmQIFG5hpKL8cFDimR7ewK/pvsWLI/RPc7Qouriog4j9XoRyU97N5OV1NZ/Syo92FYf6IS4ZDe
        QwatiBIg3q/EmYjSvOXmzjRBXWg0KCDrjI92HbPmj74+uMkShHGhKo8U8n4642nYOKtq1/BFvsiIo
        ZnfiIiBfx/L1p7QeQRphFbw9xje+wiSynevHx6BjPXvmof2DJOeZiV+u5QjOa3Nwz0N7e6C7yJqTg
        C49ZEzUDOct5lfnKzMzALtfD710KUmOz+t82FWzCoPjPG7dyvmWTXY+3PXte7zcR/73yvNmfst8I8
        GpsQag6g==;
Received: from [2001:4bb8:185:a81e:fda9:da32:3b0c:8358] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nvf88-006bm5-4D; Mon, 30 May 2022 13:08:20 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc:     linux-block@vger.kernel.org
Subject: [PATCH blktests 2/9] common: add a helper if a driver is available
Date:   Mon, 30 May 2022 15:08:04 +0200
Message-Id: <20220530130811.3006554-3-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220530130811.3006554-1-hch@lst.de>
References: <20220530130811.3006554-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Unlike _have_modules this allows allows for a built-in driver.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 common/rc | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/common/rc b/common/rc
index 5e35e21..a93b227 100644
--- a/common/rc
+++ b/common/rc
@@ -28,6 +28,18 @@ _have_root() {
 	return 0
 }
 
+_have_driver()
+{
+	local modname="${1/-/_}"
+
+	if [ ! -d "/sys/module/${modname}" ] && ! modprobe -q ${modname}; then
+		SKIP_REASON="driver ${modname} is not available"
+		return 1
+	fi
+
+	return 0
+}
+
 _have_modules() {
 	local missing=()
 	local module
-- 
2.30.2

