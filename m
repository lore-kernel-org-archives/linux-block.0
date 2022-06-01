Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8D57C433FE
	for <linux-block@archiver.kernel.org>; Wed,  1 Jun 2022 06:48:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245200AbiFAGsr (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 1 Jun 2022 02:48:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233201AbiFAGsq (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 1 Jun 2022 02:48:46 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAF238A07E
        for <linux-block@vger.kernel.org>; Tue, 31 May 2022 23:48:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=4ZULPl6/bgc4rYT72v1VzqAcaRtZUwHkWk/hSj8RA4U=; b=xxtjp1d56zUXxdpspxNav9FT06
        2+AqmY87tV9/91KH/D/jVssYJAjV2K0uw+rvFZf6oXc/slPp75ZYFdzVJHRtTIfLEUDTuIX6F4saM
        jxEw4W67b8jj7qgieD/B9vE0NwaHS9OXPzTDXOupeL8ocFaNThGTQWS8F7UiOKp5YvZ1DOV6g/ulv
        XjAtlcyP1u6qKvB2QiK/1M2EvA8XqYRb9wrlr47VR5/U346LJuJ9H8rbJMAsa466Gf6DDsJcCmy67
        bNMOFtCSC6FZe3goMmbzNxkaxMQsictymC7gNG/PhSDaQS50FRQb4yIV1RPe4qBmNNj9DzgTgne7H
        bsIrMAvQ==;
Received: from [2001:4bb8:185:a81e:471a:4927:bd2e:6050] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nwI9t-00EEUD-1e; Wed, 01 Jun 2022 06:48:45 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc:     linux-block@vger.kernel.org
Subject: [PATCH blktests 2/7] common: add a helper if a driver is available
Date:   Wed,  1 Jun 2022 08:48:32 +0200
Message-Id: <20220601064837.3473709-3-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220601064837.3473709-1-hch@lst.de>
References: <20220601064837.3473709-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Unlike _have_modules this allows allows for a built-in driver.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
 common/rc | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/common/rc b/common/rc
index 5e35e21..2d0fd88 100644
--- a/common/rc
+++ b/common/rc
@@ -28,6 +28,18 @@ _have_root() {
 	return 0
 }
 
+_have_driver()
+{
+	local modname="${1/-/_}"
+
+	if [ ! -d "/sys/module/${modname}" ] && ! modprobe -q "${modname}"; then
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

