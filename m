Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A89FC2B9F4
	for <linux-block@archiver.kernel.org>; Tue, 22 Jun 2021 23:20:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F370560FE3
	for <linux-block@archiver.kernel.org>; Tue, 22 Jun 2021 23:20:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229746AbhFVXXI (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 22 Jun 2021 19:23:08 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:61491 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229718AbhFVXXI (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 22 Jun 2021 19:23:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1624404052; x=1655940052;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=yIR8dgubVaiyXuSuG9UYvWP6cQhn2PvoFhkM+C2mSHw=;
  b=f+Bwnk5MHoUAOz/bFgQed1RrSUgD1JMxpBpo6JWqp0EGsdOxSsh46jmB
   ymBLFaj8rtMxJ3rSCr+obiF6EUpz1Tvoy5x3fhDpGvdjtqNJDylHyxJiB
   +00t0GWU0nc+4F651nLOk6ZHwZ6Ig7Uy/s++M/qBPw7Vfj3ovHaSQKh0K
   BmBNv1MWZGDgEkuTiULWunCUv5bQZJ7nsa0Nug284+oQku2GNQwFRjPJt
   EaWFx/v6xBLO2wCpJe8Wv7B8WFEk0jcnaJ1BPiRbajijFDkyhajcZwdyq
   JD3WRtP8WzpI2Iumyskz06AkmIAtYUeBfwxrRf482ktyWXWqKB27eBS+o
   Q==;
IronPort-SDR: ia126zKYfXpu9t+0YhsmJqY5qo7gU3JBNSD11XJW4SIcjkP7jdDmxYEsMJcreT1kzoD6xRsBxY
 Br6Yr84f5hmNe8tukAvXSSOvgn9Pgd8Rnl7aOKqnt63Y71KmboyQEXiDgdqJHG9srf03v6XHFV
 hgxoRhTBGVY/1wqZCXwmaB7/W6USCl4iRlq3dRoMLyP4CKUKlAxMOKfowtMqmxeAXLCEBFUd3d
 19AtKMe0A1OQsGKLsq7uKRUJTw9vV+8c016oojXEimD1t31NL8kwYdUUvmx8yby9RRHLcM7xIX
 Q6Q=
X-IronPort-AV: E=Sophos;i="5.83,292,1616428800"; 
   d="scan'208";a="173198963"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 23 Jun 2021 07:20:51 +0800
IronPort-SDR: 5d9TgDWFjdYKJwUzJuhPfns3C0mAiimnfoYJnHundh/Z0YZMK3nAqUUZjPUH/PvC+uyWzF6d1r
 1f7LhksucSJEk7VtbuANopio6YDk5VGR/HEnVBCeRtvaMdhy6sIJL/bSYvtT2QjLZLYAUdDWGj
 ZNnO4nnqSaAs2PQF24oOtjqjElBkzFK5/ykBN7GysQSO2kgAk4jaTqYw8Bc+xTWrlcD30oKyKy
 zm6c/s/rQBxRG4DjZA14y8vTAXHG4RlMpx0ghnGORQGpPpQjO0po9UFv5LUuNhhjVn3uo+3j5Y
 86o47kbIwkaafknsgN6CshqI
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2021 15:59:27 -0700
IronPort-SDR: tvwxBYIQQYqCSjw1BLEfH7WgC0W00T3IJA++ykWKVm2WrITeyYicr4yuN4YKHqBolk3pTSznPS
 5rRHIVoBN92nZ1MhXHEUKV+mRrDuXpjIWZxY18+mdgZBFIeEZmKm4KUnitr+h7DV2Ae2FzHqgY
 1qTyRwIuSI0D+8OBPOr2gcvxkIDK2Cn8DbsdE1eBZmekW+ZG+8v/OFtFiLsk2yyzzUwNsjLNZ2
 NULpT0qADrZUoRCBnlwJHgaAavz65iwPM/Kruj6ALn12z03/fV1sdmcjtqtZKIud088zxSLuc0
 j5Q=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
  by uls-op-cesaip01.wdc.com with ESMTP; 22 Jun 2021 16:20:50 -0700
From:   Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To:     linux-block@vger.kernel.org
Cc:     axboe@kernel.dk, Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [PATCH 5/9] loop: use sysfs_emit() in the sysfs dio show
Date:   Tue, 22 Jun 2021 16:19:47 -0700
Message-Id: <20210622231952.5625-6-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1.dirty
In-Reply-To: <20210622231952.5625-1-chaitanya.kulkarni@wdc.com>
References: <20210622231952.5625-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Output defects can exist in sysfs content using sprintf and snprintf.

sprintf does not know the PAGE_SIZE maximum of the temporary buffer
used for outputting sysfs content and it's possible to overrun the
PAGE_SIZE buffer length.

Use a generic sysfs_emit function that knows that the size of the
temporary buffer and ensures that no overrun is done for dio
attribute.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 drivers/block/loop.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 96bc4544328f..abb9f05e5a53 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -833,7 +833,7 @@ static ssize_t loop_attr_dio_show(struct loop_device *lo, char *buf)
 {
 	int dio = (lo->lo_flags & LO_FLAGS_DIRECT_IO);
 
-	return sprintf(buf, "%s\n", dio ? "1" : "0");
+	return sysfs_emit(buf, "%s\n", dio ? "1" : "0");
 }
 
 LOOP_ATTR_RO(backing_file);
-- 
2.22.1

