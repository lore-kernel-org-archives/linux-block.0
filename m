Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB7B0C4338F
	for <linux-block@archiver.kernel.org>; Tue, 24 Aug 2021 07:54:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AC8AB6127B
	for <linux-block@archiver.kernel.org>; Tue, 24 Aug 2021 07:54:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234705AbhHXHy5 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 24 Aug 2021 03:54:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234618AbhHXHy5 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 24 Aug 2021 03:54:57 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B278C061575
        for <linux-block@vger.kernel.org>; Tue, 24 Aug 2021 00:54:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=tWYabhH9LWfkyDnISBXzaEXJ1YX9IYLzhHEPR/VIJ4c=; b=BjWuxJkfkgqLVGATbQ4IJ9Kxha
        HKwIa5oVPE6fNUAJL5fEUerKhmfTWrDll1j7ummWSHSpxMSbn0XvKl29SsXKSfOvsu0LMiydqS0y5
        xr3CdgBWmcVy4iL4ZQgH0JumDk9PUYaUMBByDyPn49J5BD8WdEz3iSeAkVSx1mZ5leOIRVIFVFW4p
        HZX7phWXyGtHAFNzmpvCaU372hqA6L9KoOf3ti/LOZHT34ZaaYWDYBRWdpD8vvlzbNpXzTjz2nA3y
        qo7VaYiDF0sMNqHH1EzvH4VvivkAGcBkfPJ5F0PG4HEQyJg9ldK9f4NBsa3hXxCHkRA0IGrn2Iwkd
        3WPB4IoA==;
Received: from [2001:4bb8:193:fd10:f8c0:1a4c:b688:f5a6] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mIRFL-00AkWx-18; Tue, 24 Aug 2021 07:53:34 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org
Subject: [PATCH 1/2] block: remove a pointless call to MINOR() in device_add_disk
Date:   Tue, 24 Aug 2021 09:52:15 +0200
Message-Id: <20210824075216.1179406-2-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210824075216.1179406-1-hch@lst.de>
References: <20210824075216.1179406-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

blk_alloc_ext_minor already returns just a minor number, so no need to
mask the high bits.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/genhd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/genhd.c b/block/genhd.c
index a4817e42f3a3..3ee031c97f22 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -515,7 +515,7 @@ static void __device_add_disk(struct device *parent, struct gendisk *disk,
 			return;
 		}
 		disk->major = BLOCK_EXT_MAJOR;
-		disk->first_minor = MINOR(ret);
+		disk->first_minor = ret;
 		disk->flags |= GENHD_FL_EXT_DEVT;
 	}
 
-- 
2.30.2

