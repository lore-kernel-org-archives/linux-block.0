Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D70BAC43334
	for <linux-block@archiver.kernel.org>; Tue,  7 Jun 2022 12:47:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242948AbiFGMrx (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 7 Jun 2022 08:47:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244165AbiFGMrw (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 7 Jun 2022 08:47:52 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C14D0101C1
        for <linux-block@vger.kernel.org>; Tue,  7 Jun 2022 05:47:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=XGcDw+5ZFF149p0q/ozu/n6Dg7dA61lEb6sxxuCdLRU=; b=K8qjI8llXeBcPF3kfulce0zQvN
        23AKM7IOG2//SoLXNc1qosckxeX0tNWstFAklQqZ1QPLAa3vhdbeJ9cSXlwnXx8UDjp89LILmHzzm
        hzKULVGr0qLuiOEdFxYrCsjdQyLQJlaEmMAIWBnL7BCVh/TECvXWk2DIKMIlxGDRO6maWTtu3ivdD
        h5Oc8SgKGrydS+Dn/Ch/sO+M9ezv/r0IrTvLMXTtn+SKjIlc52WVsTUOLle4NHbw80yUuZBEcqi3B
        bSs43dToOGSCZmpsj3WSAMP+Uia0Bg3vdgLITfGSnSpRWhIU0jg9xa/WKaWhGyaDVv7kwCfEi+h7h
        vufuOHCQ==;
Received: from [2001:4bb8:190:726c:b34a:228:52ee:6d34] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nyYch-007SXy-1N; Tue, 07 Jun 2022 12:47:51 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc:     linux-block@vger.kernel.org
Subject: [PATCH blktests 03/13] common/null_blk: respect RUN_FOR_ZONED in _configure_null_blk
Date:   Tue,  7 Jun 2022 14:47:29 +0200
Message-Id: <20220607124739.1259977-4-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220607124739.1259977-1-hch@lst.de>
References: <20220607124739.1259977-1-hch@lst.de>
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
index 30d54c2..918ba44 100644
--- a/common/null_blk
+++ b/common/null_blk
@@ -42,6 +42,11 @@ _configure_null_blk() {
 	fi
 
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

