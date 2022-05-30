Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3232FC433F5
	for <linux-block@archiver.kernel.org>; Mon, 30 May 2022 13:08:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236324AbiE3NId (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 30 May 2022 09:08:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236327AbiE3NId (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 30 May 2022 09:08:33 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09DCD70922
        for <linux-block@vger.kernel.org>; Mon, 30 May 2022 06:08:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=zNWbO9ANZxDSJkR1uaf2cgdY/2+eyYYE/LgvB5iNw5U=; b=octar8nkcs30OalsDI5g8VywJy
        nE+ZKiEAELmPvZd4yrokDSPqJegvyprC5EfEJx9/Aayx3iz6VTyI+AUnewP/PYs8Csb0DcXNTN9mK
        joX+Mc4BDcWNwSOScCxBhZzWdDbEj1l8tv6qx409DUxg6mXMaUJxpFwE7NZccOwNm2spKbRYIErbt
        yc57hSWxNLwABiBTazxKYpJBhxDIiVVRTQLlO5l4HPGgz7ShWiFzeqavyoLoM6LAJh/jKvg2TJwsr
        V5weiPAiBSYFytAiJGgbJBBUhKt8B5ClR7nxoax9w0qAh93Ho7CIV5yficcyFqMt0dug+wEGwGRRe
        5OXG69IA==;
Received: from [2001:4bb8:185:a81e:fda9:da32:3b0c:8358] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nvf8J-006bqW-3Y; Mon, 30 May 2022 13:08:31 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc:     linux-block@vger.kernel.org
Subject: [PATCH blktests 6/9] nbd: do not require nbd support to be modular
Date:   Mon, 30 May 2022 15:08:08 +0200
Message-Id: <20220530130811.3006554-7-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220530130811.3006554-1-hch@lst.de>
References: <20220530130811.3006554-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Use _have_driver instead of _have_modules in _have_nbd as nothing requires
the nbd driver to be modular.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 tests/nbd/rc | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tests/nbd/rc b/tests/nbd/rc
index 9d0e3d1..118553c 100644
--- a/tests/nbd/rc
+++ b/tests/nbd/rc
@@ -7,11 +7,11 @@
 . common/rc
 
 group_requires() {
-	_have_root && _have_nbd && modprobe nbd
+	_have_root && _have_nbd
 }
 
 _have_nbd() {
-	if ! _have_modules nbd; then
+	if ! _have_driver nbd; then
 		return 1
 	fi
 	if ! _have_program nbd-server; then
-- 
2.30.2

