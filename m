Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CF02C433EF
	for <linux-block@archiver.kernel.org>; Mon, 30 May 2022 13:08:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236323AbiE3NI2 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 30 May 2022 09:08:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236324AbiE3NI1 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 30 May 2022 09:08:27 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61B1D70904
        for <linux-block@vger.kernel.org>; Mon, 30 May 2022 06:08:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=8XpyH7ypt4V2s//tkU1u1OrnrAFvSPAexvr5mF2MJEg=; b=barTAuyaFAXUo8dRK+2a9nYnBV
        h9OuyfawaUec90zYWLh0pb9hnV++SeASa5q6FXIpF3yQpSEWjg66oYoIdWRZip2dW++L8CPZA5RS3
        jhey0s02O/S46FCwHy/SZZXO3Y5G24oqjC6i+SsOomZLZLhIn3aakYy0ESkmAFI4VPjV9LFGNgDM5
        vkyqbKCNycaHine6gH3YWiYrnIomYqI6ikk+T1IzQ8ZDDABci+FDm04I+1X5oKZMu8gjDmwSlqw9h
        DY11NCFs1DZaKKlJ6mcVfE/PAmGtq3535xkjz2nuLHonMkj1Mf4H2qsQziGyKOBXR2RCx7sLSaRDS
        Ob3uz4Wg==;
Received: from [2001:4bb8:185:a81e:fda9:da32:3b0c:8358] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nvf8D-006boQ-LO; Mon, 30 May 2022 13:08:26 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc:     linux-block@vger.kernel.org
Subject: [PATCH blktests 4/9] common: do not require loop support to be modular
Date:   Mon, 30 May 2022 15:08:06 +0200
Message-Id: <20220530130811.3006554-5-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220530130811.3006554-1-hch@lst.de>
References: <20220530130811.3006554-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Use _have_driver instead of _have_modules in _have_loop as nothing requires
the loop driver to be modular.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 common/rc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/common/rc b/common/rc
index ffd15b6..d71a81e 100644
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

