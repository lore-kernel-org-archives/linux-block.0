Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3956BC433DB
	for <linux-block@archiver.kernel.org>; Tue,  2 Feb 2021 05:38:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E6BCB64E9A
	for <linux-block@archiver.kernel.org>; Tue,  2 Feb 2021 05:38:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231443AbhBBFiU (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 2 Feb 2021 00:38:20 -0500
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:60445 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229846AbhBBFiT (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 2 Feb 2021 00:38:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1612244299; x=1643780299;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ijnjlyOXhm33bFLZ7zcRqWwYHaWw4JzS5EwIft2ja8A=;
  b=pjJDAYYoikyR0CWj9HhoDD7wSyzrM3ighM5qAfWXAFXj6jJn5ZIE/IJa
   p1efoGfVfTajvXlzUF8bVFngFbkpgrs07O7RGc/x9Y0WPML1soohC4dd5
   wW03HHXHVkMFlodTsX5svh2oGW/M5k2r9RcY0WcUSaSEflsxanwHFhr0v
   Ro98Z8Rupx1iPi7cVc7t/Wml0T725qzLuUIBxhs1LoUGOp1rfCReJ/qdf
   nYYS1ms5HClJYqLGzh+onwIFPqG2OHOgD0xY8tJi1cKmEiCut/iPmR0K9
   eVEUEhKhApeGcpNpkqPq2t0CAteO7KuKG1qW+y7pcME6abq7CupWIb3cX
   g==;
IronPort-SDR: ElyyHHobDrmvaZCxo9T7V7TzZylLsj8y3SxjcYcj/yrvGnJ6VwEYAC8l4ASS+K6pvZr9kNaRXH
 7fpxxyW6dq8wqZ7En7LenfFSGWLA3PGwv0ecK85S2FMICBAMJKLqvt2jWZsEawhUDLMBoUh+Tv
 okAPuMRJpYS2+mXhnHfnqog8kZHj5djk4Hrs1iPnhToh+I7J7uU9AiolfrwWY73Q9mGORRoewE
 0HzBWSrOURqbpJ4foIdidEubW4TeEcweS4y3URiX0RFTGQ46nlyeDgJlGqGbzr7FTlY7hIcPy/
 EE8=
X-IronPort-AV: E=Sophos;i="5.79,394,1602518400"; 
   d="scan'208";a="269301858"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 02 Feb 2021 13:37:13 +0800
IronPort-SDR: d35i9q1dCzFpwnGXnfkJ5C89Rk6p9lfMUYBJXSmxvHEMazdd9K7INKUmrAbkBLHKNQoETl1iuq
 1zqCrJjJ4dUzLcDdRL37wpWz5DxgOU3RAtDHXH8i2P2srn6iVP45gSuaIW/dGm/Ty+5mljopN2
 W5BiHQwAqZuhZRdSEh8c8+bvB1FiKb0aWvmOyxLLS4T3zRGwBSjkmhhxorYhq/BOT2iO+pkNRD
 2fgw3sq3oV6b/OO11+3UIrD/NBj7Js5/CTEtTLur35+gvPk1JW4WyJhBYpneAgazC2hfOYbUfF
 n5DeKsGK/z8O9kWV7JwIF/zt
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2021 21:19:22 -0800
IronPort-SDR: 0vM/mEbpN0ehFTgO9NEWGD3ivDSgBv+NT1lUUTpBmziW0eZbsps+cTZgG77BjxpRNjIoauYeWm
 R4tIqG0SJfQ31Wbp+9CYZX8b5OuP3nNyJv3rRc5PgdoN6GjoH9FwAXYLmqkYGe5V1txsSSXvbd
 J9+fZzjzrUgV/2qQjWF+gzl5EEULUA5SmBPWMPBFLxQF1PkZ7H/wUVaj2+Z+xXgP0rutREMZbB
 glw99w3g6N7H7ml1B/ao/fkpDRWs8yOiA+0/4/nvXFd7dNxsdngvrE0Q3EsKmrjRxEZX+2v7QY
 6Ns=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
  by uls-op-cesaip02.wdc.com with ESMTP; 01 Feb 2021 21:37:13 -0800
From:   Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To:     linux-block@vger.kernel.org
Cc:     axboe@kernel.dk, Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [RFC PATCH 10/20] loop: remove extra variable in lo_req_flush
Date:   Mon,  1 Feb 2021 21:35:42 -0800
Message-Id: <20210202053552.4844-11-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1
In-Reply-To: <20210202053552.4844-1-chaitanya.kulkarni@wdc.com>
References: <20210202053552.4844-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The local variable file is used to pass it to the vfs_fsync(). We can
get away with using lo->lo_backing_file instead of storing in a local
variable which is not used anywhere else.

No functional change in this patch.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 drivers/block/loop.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index f9f352c7a56f..b8028c6d5ecc 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -452,8 +452,7 @@ static int lo_fallocate(struct loop_device *lo, struct request *rq, loff_t pos,
 
 static int lo_req_flush(struct loop_device *lo, struct request *rq)
 {
-	struct file *file = lo->lo_backing_file;
-	int ret = vfs_fsync(file, 0);
+	int ret = vfs_fsync(lo->lo_backing_file, 0);
 
 	if (unlikely(ret && ret != -EINVAL))
 		ret = -EIO;
-- 
2.22.1

