Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DF69C4167B
	for <linux-block@archiver.kernel.org>; Mon,  6 Nov 2023 20:03:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232455AbjKFUDg (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 6 Nov 2023 15:03:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232686AbjKFUDf (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 6 Nov 2023 15:03:35 -0500
X-Greylist: delayed 538 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 06 Nov 2023 12:03:32 PST
Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48832D49
        for <linux-block@vger.kernel.org>; Mon,  6 Nov 2023 12:03:32 -0800 (PST)
Message-ID: <ec494d90-3f04-4ab4-870b-bb4f015eb0ed@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1699300519;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=phlU4gV4Aft/tjiYrtjDOJr6Ls/Rl5IpOB+DSxP4KLc=;
        b=xZQwR1W75ReIaJ8QXWSP7HwDPs0OJKfjtfTYVK6q9TY2bH0x9z7cbpyRf35O3yseKlwgHX
        zoOd8CU1UJ+S9G37A3Xb4p+m05SrUJhAqvRc057IXSlxd0+ssH7UawYdv/BhUtikMNFBQv
        w0Z1hI0W4IEXmGMex3X8wOEc4KQOqus=
Date:   Mon, 6 Nov 2023 22:55:19 +0300
MIME-Version: 1.0
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Vasily Averin <vasily.averin@linux.dev>
Subject: [PATCH] zram: extra zram_get_element call in zram_read_from_zspool()
To:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Minchan Kim <minchan@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        zhouxianrong <zhouxianrong@huawei.com>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

'element' and 'handle' are union in struct zram_table_entry.

Fixes: 8e19d540d107 ("zram: extend zero pages to same element pages")
Signed-off-by: Vasily Averin <vasily.averin@linux.dev>
---
 drivers/block/zram/zram_drv.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index 9ac3d4e51d26..f4d342d11b81 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -1318,12 +1318,10 @@ static int zram_read_from_zspool(struct zram *zram, struct page *page,
 
 	handle = zram_get_handle(zram, index);
 	if (!handle || zram_test_flag(zram, index, ZRAM_SAME)) {
-		unsigned long value;
 		void *mem;
 
-		value = handle ? zram_get_element(zram, index) : 0;
 		mem = kmap_atomic(page);
-		zram_fill_page(mem, PAGE_SIZE, value);
+		zram_fill_page(mem, PAGE_SIZE, handle);
 		kunmap_atomic(mem);
 		return 0;
 	}
-- 
2.34.1

