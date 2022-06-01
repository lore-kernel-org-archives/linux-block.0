Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3B6FC433FE
	for <linux-block@archiver.kernel.org>; Wed,  1 Jun 2022 06:48:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245430AbiFAGsz (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 1 Jun 2022 02:48:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233201AbiFAGsy (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 1 Jun 2022 02:48:54 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B40558FFBE
        for <linux-block@vger.kernel.org>; Tue, 31 May 2022 23:48:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=zNWbO9ANZxDSJkR1uaf2cgdY/2+eyYYE/LgvB5iNw5U=; b=ISsa35/fdw9tcKk6+2cdiOuvYJ
        hg42Gn42DXksALDoQze1dQaCOrRAMkyCUxxPeapSv3BNgBiswrpgBOw4XjLQ7FHKaoyNxZm2+Xs4i
        Ds5F05X1Hu+pULGdEa6i/RJrqBkWKhEfZoTXSww9PP/IRBiX6p9hiphchGGZ3upew+mf5nWpmwSb1
        Cl0clZmiHj7zjTQk06pPvJt0fh65fmH/m9437UyMaF445hH0PMDBIbkPPmbxBBOl4obkMAJf/BCYq
        42nUWUcFbmYupQe2ee5qqMkNeYk0k37MZ5YWtxgFe6oAl25CW7q18llRqKShylW1WvkFG/WPMeUSn
        jYB8XZYg==;
Received: from [2001:4bb8:185:a81e:471a:4927:bd2e:6050] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nwIA0-00EEXI-Uj; Wed, 01 Jun 2022 06:48:53 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc:     linux-block@vger.kernel.org
Subject: [PATCH blktests 5/7] nbd: do not require nbd support to be modular
Date:   Wed,  1 Jun 2022 08:48:35 +0200
Message-Id: <20220601064837.3473709-6-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220601064837.3473709-1-hch@lst.de>
References: <20220601064837.3473709-1-hch@lst.de>
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

