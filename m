Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD516C43334
	for <linux-block@archiver.kernel.org>; Fri,  3 Jun 2022 04:56:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238922AbiFCE4I (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 3 Jun 2022 00:56:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231318AbiFCE4H (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 3 Jun 2022 00:56:07 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D3EE36E10
        for <linux-block@vger.kernel.org>; Thu,  2 Jun 2022 21:56:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=ixDonDx4pZck5vwWNGze/P7Iv4HXyJswPnnWQ1TEfvk=; b=LYexjoRoAeeGRlLxZc9t90rvpL
        wTb/9eTggeGT0J2/jFjLLny/LN3Ag1xYhJIJHwQ8UDgjsU6vv5EBe69jey9DELAyUe/Gtv2fc7Knx
        z6VyCtaJ7t0K6ytujhtMeQT+mZxJykomGjTd/cGwHHeZsmwgucuUGWHQZmQ6OUpl4VuLaMtepZ2ra
        EvdoWltN2hHGruBUJ96BkArb7wso5qR89Q/hV4K92rqQnuJdqf+zfWqzVZ3n6QTPTO+9TtMnliUIp
        42tprUxwxDNyZKoq+WU049g25KDZ5YPz1GcsVrVjs/MZTqmhw8pOT7VRyDr3olaQW19vWERBbiZ7e
        iQTQCR5A==;
Received: from [2001:4bb8:185:a81e:9865:e17e:4c0c:3e17] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nwzLx-005qOU-O3; Fri, 03 Jun 2022 04:56:06 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc:     linux-block@vger.kernel.org
Subject: [PATCH blktests 02/13] common/null_blk: allow _configure_null_blk with built-in null_blk
Date:   Fri,  3 Jun 2022 06:55:47 +0200
Message-Id: <20220603045558.466760-3-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220603045558.466760-1-hch@lst.de>
References: <20220603045558.466760-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Test that do use _configure_null_blk already configure do not actually
require a built-in null_blk driver.  Relax the check in _have_null_blk
to just require a driver instead of a module, and instead set a skip
reason instead of failing in _init_null_blk when null_blk is built-in
or otherwise not available.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 common/null_blk | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/common/null_blk b/common/null_blk
index 6611db0..381f6b8 100644
--- a/common/null_blk
+++ b/common/null_blk
@@ -4,8 +4,10 @@
 #
 # null_blk helper functions.
 
+. common/shellcheck
+
 _have_null_blk() {
-	_have_modules null_blk
+	_have_driver null_blk
 }
 
 _remove_null_blk_devices() {
@@ -22,6 +24,7 @@ _init_null_blk() {
 	if (( RUN_FOR_ZONED )); then zoned="zoned=1"; fi
 
 	if ! modprobe -r null_blk || ! modprobe null_blk "$@" "${zoned}" ; then
+		SKIP_REASON="requires modular null_blk"
 		return 1
 	fi
 
-- 
2.30.2

