Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51CBAC6379D
	for <linux-block@archiver.kernel.org>; Fri, 20 Nov 2020 01:55:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C4A9B22255
	for <linux-block@archiver.kernel.org>; Fri, 20 Nov 2020 01:55:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="j43fzXIo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726485AbgKTBzn (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 19 Nov 2020 20:55:43 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:6553 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726479AbgKTBzm (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 19 Nov 2020 20:55:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1605837342; x=1637373342;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=u4RvdBCLXAsEgfYrFWz21p+kYwih56qACaS8qEWsIyc=;
  b=j43fzXIojWu5eUYxqylNSkl8MrQcE60mUBnpQzCiyQ202PMBhAMAhxbm
   zTpnL7O05i56rQ6ullqoMJAAgBmcUWfSDs42PvwJ2cufP9628wK/IFYIW
   30tumUTvXjHAmvVLwAueRRqqsbm3YhKHX2nPWFAof47fJDqfZ/qp1Xmc3
   EwEk40Z5PCe9s3o7D8vCmTXWAMquJOojqm8+K4xcyfcHxWUaqj+nDmd67
   KM351MxwfQJjzBFekGdUiDi/lFKb8OpC1IZ1P4O3+qVwCYQVRUDtPbnw8
   jJneiSq/sVNMoI+aCb7bev9JXAOfxdNAjefTRrcaxZ2u3ojO1eMKeZOKd
   g==;
IronPort-SDR: uojvf4odap6hLbhs2Mqo2QdbvucE1H4qDyjHQ0SWLhGRA81iW177XJC5n8038LI/h5hopG+qgZ
 JgzLSyvwamHkc21w0wYfl4d0pCdIrHfntIxiWzqYbDK2nFojCDco6g01V2pyQ49lVqwv4E6j8q
 TQbqG+L4g1INKY14Ll47DML8W/E0eZ7zdIkIoI5tGdi5Pw0wGmVGuW5NBWPsS1RtMxGd3zuJHX
 TZlP6JlgAkT+Lar9CBoyOveqJ2J8csCOOREoiUwl/8BpGWcC0hBlwOAFVrVU90rU/FFwpLZVx/
 M9Y=
X-IronPort-AV: E=Sophos;i="5.78,354,1599494400"; 
   d="scan'208";a="157516400"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 20 Nov 2020 09:55:42 +0800
IronPort-SDR: 4os4iUTjZn880bpSZwpNiFVlGXvbmiPeAkvOnnd1dpudX4rCSL92pFdukN1UFUGuI+aLGGShsb
 mMuy+m0HH0knFyM3P44Z9e8qZvZGKhL1kNX9Lh3BngeBEWf0sKxcs8CYY9toaX8gwUvKT0ocrJ
 jyv512QeQymaffSo5gyN9aE5BfiDLflXG3V4wmaZjGXMAq3mSXBwZcUvXYomS0n/lBEtpmG8D6
 172GSJd2eE5r5lkfrZwhSg9RezkYHnSv84yAdBPo2LQqZOUk+9f4NSfmAV7LnczJiGJX+8y8kd
 TRY09pKNr1Qy7eaX9EvoP00v
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2020 17:41:32 -0800
IronPort-SDR: lV0ql2G6cpsSbO8x+el9kxACM74T/XReOo4yrKm1CVoXeiKyLvJmU19PBeX4CwmP0VQYbfY9zj
 8n7zWsJjRh4D+g2elPDGvMQD41t7VQbuNy3KphXDSPpAefcxxkqFw2xI8mfwr0hYla0Cu5afGd
 NUZGP1iNzEfPspZhRWTZ0RAhLhave79ANmDW1UdP4qv5mTEnz9UbQ+BpUTq+1f6A1KkIST6pM/
 QaPP3GdxSqyT1LS1hk+9glhOcbI755AVe01z6O0iAKRdUm1PIscBZw824EbpOFwb9T44yxjWFb
 Ktw=
WDCIronportException: Internal
Received: from washi.fujisawa.hgst.com ([10.149.53.254])
  by uls-op-cesaip02.wdc.com with ESMTP; 19 Nov 2020 17:55:41 -0800
From:   Damien Le Moal <damien.lemoal@wdc.com>
To:     linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH v4 2/9] null_blk: Fail zone append to conventional zones
Date:   Fri, 20 Nov 2020 10:55:12 +0900
Message-Id: <20201120015519.276820-3-damien.lemoal@wdc.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201120015519.276820-1-damien.lemoal@wdc.com>
References: <20201120015519.276820-1-damien.lemoal@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Conventional zones do not have a write pointer and so cannot accept zone
append writes. Make sure to fail any zone append write command issued to
a conventional zone.

Reported-by: Naohiro Aota <naohiro.aota@wdc.com>
Fixes: e0489ed5daeb ("null_blk: Support REQ_OP_ZONE_APPEND")
Cc: stable@vger.kernel.org
Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 drivers/block/null_blk_zoned.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/block/null_blk_zoned.c b/drivers/block/null_blk_zoned.c
index 1d0370d91fe7..172f720b8d63 100644
--- a/drivers/block/null_blk_zoned.c
+++ b/drivers/block/null_blk_zoned.c
@@ -339,8 +339,11 @@ static blk_status_t null_zone_write(struct nullb_cmd *cmd, sector_t sector,
 
 	trace_nullb_zone_op(cmd, zno, zone->cond);
 
-	if (zone->type == BLK_ZONE_TYPE_CONVENTIONAL)
+	if (zone->type == BLK_ZONE_TYPE_CONVENTIONAL) {
+		if (append)
+			return BLK_STS_IOERR;
 		return null_process_cmd(cmd, REQ_OP_WRITE, sector, nr_sectors);
+	}
 
 	null_lock_zone(dev, zno);
 
-- 
2.28.0

