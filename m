Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBA6EC63798
	for <linux-block@archiver.kernel.org>; Fri, 20 Nov 2020 01:55:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 79D5F22255
	for <linux-block@archiver.kernel.org>; Fri, 20 Nov 2020 01:55:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="jw5IMCSl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727266AbgKTBzr (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 19 Nov 2020 20:55:47 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:6558 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726479AbgKTBzr (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 19 Nov 2020 20:55:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1605837346; x=1637373346;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=7g9vbczkAtuKa0oaVgaWdrIrL7UeG50WRzCl1A1RxUQ=;
  b=jw5IMCSlS4VslxZmBPzpg5qakfZMg0LS+yC8ncFVK9ehw5nFwM/3R4Jq
   WS+RC6PaX7mu9nUAxQJu/CW9JxlcfmrfhzkabkFm84R9NAQJaHItRNW+T
   UuZJ5Asat/NOBR8OLDmgeDrjOQwvCW0VVLxjQrh9Li24k6hTwJQsonrzz
   Fdv4LQnhaHQV4z1YdTztWUzh2ejPblxR6pWbUqqq4/di6rBXf3e/R/sXJ
   sdt+aoDMPRSNupjFBqCaeaF9FR6xsTXhK5X3Lrb4vkF66BRGtaNvqQ87V
   GAw8yMQ5gcOePJ28AVJ0VdpUiUsjpeNjXZsmeG+3e+jBQF1rXy5NywjTY
   Q==;
IronPort-SDR: 8fcDXA48/Wv7tKRn1ng1te1os3F4uz6yiSHzsYo6ury3xUxdPHMdbxODQahMbWFCYVJt4IlGmj
 hgHl+JwTOUyxMOrr7l7BZybccfeI2157PudeHgUeHOcGgsfnj7aIA2NnFGQQb7KtYi0LhMALX6
 MLFBRMvkAr/QVdBMPPTHKnhEbpw8ToFQMjMKIitmGT3G/A8TC3D0+PMKjaGspwCvEUXaWgIfFI
 HD3IXSIHUShDfD1UgJD8B4L5GA7z/Nq7uWpDTh/PQjT9XwQM9Hlju/9Nf5GYBh8qhMuY9PuSAI
 Gys=
X-IronPort-AV: E=Sophos;i="5.78,354,1599494400"; 
   d="scan'208";a="157516407"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 20 Nov 2020 09:55:46 +0800
IronPort-SDR: 4lwLY4Yevmbu9C4O38Lx9psSOA9W25vkOax/IyJB8gMII5Q9tHSRDmm7+EM5L2R+tZh91Mt18N
 NGQwCybv//dZj2HETDPBc2m6fM38+08WCCdT8ELgR8wywN4Ve8DLkN9xMenuti5xOKJ/jKo2jl
 ps+8k695W1WXOKQpbbgtPtljp7Y0SxK5l6qmCA09bFf122Ex+bqtFHcF32M+BZBBy42U8UXMf2
 vQ/jRdS+1NQBwygpZjb1AI6z35oK/fIkitbLykfCyD3D9+OVhjXvOnZfzAJk42leLxJ5e/B3ID
 YapKCJqwLOkOCEIVXrC/qbpA
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2020 17:41:36 -0800
IronPort-SDR: GkxFMcx7R3XDEiMkkWFPeD6dnOZTotMFYncHu7lk8QIFn2w5oYnGU4ayyXhU6uyJTcnjGAr+Wx
 wf/K49oA7kHmk2HvDhA0yMmyA7UWyuoDtySnxIedwzY4p3a0XXK2wnERaZkeSPg9WP7xoxd5f6
 PWVoPxPWbQR71oBlsEagqfE0OR6LQhXkStK33etCSU7r1UpgeCQcjzV/ZNpQ+BYqgFbWYoeDDH
 qAUODd3RTTuCC+Nzib836r1xiXOQQP510af4jINl5xJJWlZrNxzrZQ2AxmaIhbKGHLU5vcBYxl
 eAs=
WDCIronportException: Internal
Received: from washi.fujisawa.hgst.com ([10.149.53.254])
  by uls-op-cesaip02.wdc.com with ESMTP; 19 Nov 2020 17:55:45 -0800
From:   Damien Le Moal <damien.lemoal@wdc.com>
To:     linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH v4 7/9] null_blk: discard zones on reset
Date:   Fri, 20 Nov 2020 10:55:17 +0900
Message-Id: <20201120015519.276820-8-damien.lemoal@wdc.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201120015519.276820-1-damien.lemoal@wdc.com>
References: <20201120015519.276820-1-damien.lemoal@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

When memory backing is enabled, use null_handle_discard() to free the
backing memory used by a zone when the zone is being reset.

Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 drivers/block/null_blk.h       | 2 ++
 drivers/block/null_blk_main.c  | 4 ++--
 drivers/block/null_blk_zoned.c | 3 +++
 3 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/block/null_blk.h b/drivers/block/null_blk.h
index 29a8817fadfc..63000aeeb2f3 100644
--- a/drivers/block/null_blk.h
+++ b/drivers/block/null_blk.h
@@ -116,6 +116,8 @@ struct nullb {
 	char disk_name[DISK_NAME_LEN];
 };
 
+blk_status_t null_handle_discard(struct nullb_device *dev, sector_t sector,
+				 sector_t nr_sectors);
 blk_status_t null_process_cmd(struct nullb_cmd *cmd,
 			      enum req_opf op, sector_t sector,
 			      unsigned int nr_sectors);
diff --git a/drivers/block/null_blk_main.c b/drivers/block/null_blk_main.c
index a223bee24e76..b758b9366630 100644
--- a/drivers/block/null_blk_main.c
+++ b/drivers/block/null_blk_main.c
@@ -1076,8 +1076,8 @@ static void nullb_fill_pattern(struct nullb *nullb, struct page *page,
 	kunmap_atomic(dst);
 }
 
-static blk_status_t null_handle_discard(struct nullb_device *dev,
-					sector_t sector, sector_t nr_sectors)
+blk_status_t null_handle_discard(struct nullb_device *dev,
+				 sector_t sector, sector_t nr_sectors)
 {
 	struct nullb *nullb = dev->nullb;
 	size_t n = nr_sectors << SECTOR_SHIFT;
diff --git a/drivers/block/null_blk_zoned.c b/drivers/block/null_blk_zoned.c
index 4dad8748a61d..65464f7559e0 100644
--- a/drivers/block/null_blk_zoned.c
+++ b/drivers/block/null_blk_zoned.c
@@ -588,6 +588,9 @@ static blk_status_t null_reset_zone(struct nullb_device *dev,
 
 	null_unlock_zone_res(dev);
 
+	if (dev->memory_backed)
+		return null_handle_discard(dev, zone->start, zone->len);
+
 	return BLK_STS_OK;
 }
 
-- 
2.28.0

