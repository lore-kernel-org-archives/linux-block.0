Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1244C4332F
	for <linux-block@archiver.kernel.org>; Tue, 19 Apr 2022 06:33:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348859AbiDSGfx (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 19 Apr 2022 02:35:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237377AbiDSGfx (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 19 Apr 2022 02:35:53 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F38B02611F;
        Mon, 18 Apr 2022 23:33:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=7aG/PbvADzbqL2ouZgBB0f/ZCAoM5xZzFnGCoC1Qb4c=; b=TSzKkejEbzOQcmmx5aR0K+TnnB
        mfM/LUMHTPPo3xUwfkueFooqr6PZZwKbWl28L391WW7Cm+10cFOWTLBoQEUZHWu0t/j0f7Iqet/H9
        y89lITFy5nCBp4zS2iVqZXUHeEXYimX7mbKSH+rmKtkddsj5K1qUfdYwrvfFskGmV3AWX0sJhhnSJ
        SkdhiPTSdMD4gbh3m4SSa3th1/g4FP2BG+TpICmQnFEuFY+dirE6WbOp+XTX25fzMZ/C5Sf7MATei
        ofLGPDa4w7dN8p4Gu2K1gtF1YFl3Ch1THiMus+GwAont73lKfc0lr7udBr3L3Gd4qE+y3z/OfCENB
        Anpa7u3g==;
Received: from [2001:4bb8:191:364b:8ef6:df8:5a60:ae5d] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nghQE-001hzY-FF; Tue, 19 Apr 2022 06:33:10 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>, "Theodore Ts'o" <tytso@mit.edu>
Cc:     linux-block@vger.kernel.org, linux-spdx@vger.kernel.org
Subject: [PATCH 2/4] loop: add a SPDX header
Date:   Tue, 19 Apr 2022 08:33:01 +0200
Message-Id: <20220419063303.583106-3-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220419063303.583106-1-hch@lst.de>
References: <20220419063303.583106-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The copyright statement says:

"Redistribution of this file is permitted under the GNU General Public
 License." and was added by Ted in 1993, at which point GPLv2 only
 was the default Linux license.

Replace it with the usual GPLv2 only SPDX header.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/block/loop.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index f87bb136b66b4..b87151b60dc20 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -1,10 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0-only
 /*
  *  linux/drivers/block/loop.c
  *
  *  Written by Theodore Ts'o, 3/29/93
  *
- * Copyright 1993 by Theodore Ts'o.  Redistribution of this file is
- * permitted under the GNU General Public License.
+ * Copyright 1993 by Theodore Ts'o.
  *
  * DES encryption plus some minor changes by Werner Almesberger, 30-MAY-1993
  * more DES encryption plus IDEA encryption by Nicholas J. Leon, June 20, 1996
-- 
2.30.2

