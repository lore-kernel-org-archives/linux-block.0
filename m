Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2F6CC433EF
	for <linux-block@archiver.kernel.org>; Fri,  3 Jun 2022 04:56:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238990AbiFCE4K (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 3 Jun 2022 00:56:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231318AbiFCE4J (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 3 Jun 2022 00:56:09 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E218036E10
        for <linux-block@vger.kernel.org>; Thu,  2 Jun 2022 21:56:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=AHlTnEABPKajxczRo37yzdEK5RP23lZjC9G/OFWN5v8=; b=YMC8bcHLx3QTX7BaoBKa9mD9zJ
        iTlbaDkGkb3tOE/9LU98UsT5LuNQaFxxW840cnrjG9pvHL2UteCVjrCqatj2CbVLFYrLV6tYK7y5h
        y6GCXHxFWlUcgZ8vC741bDZ8qiyZJuwK65wuZXsxYczD1EEgQjoI2bxYwvQD0bc5jv0ztbpDA3pZ5
        7kxWFF1lndthO8R0KxZFAf1ma85Czz7JSxgyqN+YUM1zzl4CZv09+Z9OEiCc2DwNgXovjRR9hTzB7
        rQOE6jeBqfjrl8J+HpXBKvkLEB1uMvB0uSwj4WXTjPtxRwTyWfxyTEAC5cJF8IuVLXcGAepn2FkoN
        xJHBGViA==;
Received: from [2001:4bb8:185:a81e:9865:e17e:4c0c:3e17] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nwzM0-005qP1-6G; Fri, 03 Jun 2022 04:56:08 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc:     linux-block@vger.kernel.org
Subject: [PATCH blktests 03/13] common/null_blk: respect RUN_FOR_ZONED in _configure_null_blk
Date:   Fri,  3 Jun 2022 06:55:48 +0200
Message-Id: <20220603045558.466760-4-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220603045558.466760-1-hch@lst.de>
References: <20220603045558.466760-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Create zoned devices in _configure_null_blk when RUN_FOR_ZONED is
set, just like it is done in _init_null_blk

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 common/null_blk | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/common/null_blk b/common/null_blk
index 381f6b8..c82327d 100644
--- a/common/null_blk
+++ b/common/null_blk
@@ -38,6 +38,11 @@ _configure_null_blk() {
 
 	shift
 	mkdir "$nullb" || return $?
+
+	if (( RUN_FOR_ZONED )); then
+		echo "1" > "$nullb/zoned" || return $?
+	fi
+
 	while [[ $# -gt 0 ]]; do
 		param="${1%%=*}"
 		val="${1#*=}"
-- 
2.30.2

