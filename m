Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93193C433F5
	for <linux-block@archiver.kernel.org>; Wed,  1 Jun 2022 06:48:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245367AbiFAGsx (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 1 Jun 2022 02:48:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233201AbiFAGsw (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 1 Jun 2022 02:48:52 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CCA38FFBE
        for <linux-block@vger.kernel.org>; Tue, 31 May 2022 23:48:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=ZdYkHBG6cL6uaRc7mljfUIEJC/yqn35LG4kq2LLkuiY=; b=YCGSY/QuwrgPnpZRswqz0KC073
        6oSo5A6rM8b8LGvJN41SB304TIkp9dySdK8XL7QG84mOkeL3Nigsp2RPDgT6E5B3K/AFA5fy6SmxM
        C/QmNwY1Sj427NRDVGQEbJ36r5Ma0fUi1cmSQf9luImg7YaRCEaw/429zwlPmtfrYjlSFVR5O8XXZ
        FkMdTEwFrWF5Mtap/UQhvb3GCvlDDoHNhgueZS8sOoGiBA3CRhojaIbv/DayWNg25uqkTtYvdEqOV
        luUUT7z8kv8TA4j6rtopRZngAXwnMQ/KzAiDihGyi63n97sZqlFoM1SqklWmD7Lr4iIII6a1UTZx1
        ziasTADA==;
Received: from [2001:4bb8:185:a81e:471a:4927:bd2e:6050] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nwI9y-00EEWB-BO; Wed, 01 Jun 2022 06:48:50 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc:     linux-block@vger.kernel.org
Subject: [PATCH blktests 4/7] common: do not require loop support to be modular
Date:   Wed,  1 Jun 2022 08:48:34 +0200
Message-Id: <20220601064837.3473709-5-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220601064837.3473709-1-hch@lst.de>
References: <20220601064837.3473709-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Use _have_driver instead of _have_modules in _have_loop as nothing requires
the loop driver to be modular.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
 common/rc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/common/rc b/common/rc
index c4df814..b1cc157 100644
--- a/common/rc
+++ b/common/rc
@@ -128,7 +128,7 @@ _have_src_program() {
 }
 
 _have_loop() {
-	_have_modules loop && _have_program losetup
+	_have_driver loop && _have_program losetup
 }
 
 _have_blktrace() {
-- 
2.30.2

