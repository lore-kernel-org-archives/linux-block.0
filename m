Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F120C432BE
	for <linux-block@archiver.kernel.org>; Thu, 26 Aug 2021 13:41:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6391E60F44
	for <linux-block@archiver.kernel.org>; Thu, 26 Aug 2021 13:41:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242751AbhHZNmk (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 26 Aug 2021 09:42:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242760AbhHZNmj (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 26 Aug 2021 09:42:39 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 079BAC0613D9
        for <linux-block@vger.kernel.org>; Thu, 26 Aug 2021 06:41:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=OtiK5aG5B0h6GUp744XKsyYpxdt0kmLykLnDyPJAboo=; b=wAAnXyn8kYuvH2lDvdxtMnRhZT
        ze/1aQoxO7oNRp7t16q3UcxAFogBLHOFg9eYoeXuuj9unDtFrG2rqJrXTWpa4D0CFXw9b4G4I+eDB
        HnPlU7nYOjXKfTmrzKhe34kyIs+LxcKY2IrxakV0QweJyOICa80e8UQ8kKGHAjPqe8o2hYIFMsqGF
        JbIoqmmPsIOTNMQwr9O5Bf/jtWxvrHRU093/a1pRY98VEv564QRPAlAj0riTup5yJkYf9HGYgT0tD
        C4ExmITKvWWO7foe/1xSYMXxYe4fQzhWkzmxKRnqeFN4eOo5Qg59lSkQ/DjdBBf0A/+pEUnNJnvPh
        H5voTLYQ==;
Received: from [2001:4bb8:193:fd10:d9d9:6c15:481b:99c4] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mJFbG-00DL88-Rg; Thu, 26 Aug 2021 13:39:53 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Hillf Danton <hdanton@sina.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        "Reviewed-by : Tyler Hicks" <tyhicks@linux.microsoft.com>,
        linux-block@vger.kernel.org
Subject: [PATCH 1/8] cryptoloop: fix a sparse annotation
Date:   Thu, 26 Aug 2021 15:38:03 +0200
Message-Id: <20210826133810.3700-2-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210826133810.3700-1-hch@lst.de>
References: <20210826133810.3700-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

iv is used as a little endian value, so use a __le32 type for it.  Also
move the initialization into the declaration to simplify it a bit.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/block/cryptoloop.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/block/cryptoloop.c b/drivers/block/cryptoloop.c
index 3cabc335ae74..1a65dec47b07 100644
--- a/drivers/block/cryptoloop.c
+++ b/drivers/block/cryptoloop.c
@@ -130,8 +130,7 @@ cryptoloop_transfer(struct loop_device *lo, int cmd,
 
 	while (size > 0) {
 		const int sz = min(size, LOOP_IV_SECTOR_SIZE);
-		u32 iv[4] = { 0, };
-		iv[0] = cpu_to_le32(IV & 0xffffffff);
+		__le32 iv[4] = { cpu_to_le32(IV & 0xffffffff), };
 
 		sg_set_page(&sg_in, in_page, sz, in_offs);
 		sg_set_page(&sg_out, out_page, sz, out_offs);
-- 
2.30.2

