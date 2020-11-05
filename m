Return-Path: <SRS0=FEuC=EL=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9727C4741F
	for <linux-block@archiver.kernel.org>; Thu,  5 Nov 2020 07:17:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4E14E2087D
	for <linux-block@archiver.kernel.org>; Thu,  5 Nov 2020 07:17:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="OLMLuqTf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728679AbgKEHRE (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 5 Nov 2020 02:17:04 -0500
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:30568 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729024AbgKEHRD (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 5 Nov 2020 02:17:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1604560622; x=1636096622;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=8+KoZX0XnQG4QUSJF01paR7JW/DhT9GwNZMPJsfSncs=;
  b=OLMLuqTftlDBgATr/LU0GJOMNi7Tlw+W0GqWNtdR3CX5qTq6oID0SQXv
   AP+9iD0yx8Tsl/Up/0hVdjZg9uQmhrhW5WboaMdQpgYiEblPoyzI/22VO
   SS2xCsL6oAjFCXyy1i/5lWSi9y8FeSw+kIPMncrHpWEYl9CU0dS6TAgti
   A9t/JjxTDv6S7wjv/rjX56NzbSRF/HW7ZOCd4nZdqNL2BWLRn3/pa3jlK
   S6mUpo8g1GqwlIRKOUieI7ptL59zSUW81h6AdpifWycHNH8Kg0uQia6eP
   IYH/NRzCttisxaf9madfHWv1WT+/fmoRSvBxg65nQspr0lfJwSEaRBOo3
   A==;
IronPort-SDR: VXzL0ZxBu6GZQSmBku2nDjo7GUYNIENIApMPm8ASQtXlEYYQUC6krNHl7vzorSUFyHv83GpT5C
 ewUXy9ccARXqaLVXtskeB8Bz8eaInOGbNU/mSJtLmf8xXSPo/ol6uZiUuS2y2bjsvdw1AX+4/X
 PDN4rj0wTJem36H0kcbUg1XPg6an6I6+H+RjI2jh0ePNFIrt5mPqwDGIwcwN71AmjGaZkbrsdO
 sTlXYIJWp51npU7HbGp1Uri9nOYxJftz80guHRq5cS0887M/Wa/92O7iTx5KYKcfWoCWIKzZ9/
 N4A=
X-IronPort-AV: E=Sophos;i="5.77,452,1596470400"; 
   d="scan'208";a="261859728"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 05 Nov 2020 15:16:59 +0800
IronPort-SDR: AAF5CoZpFNHXgc9C9ZIQrb0XuzfLP5OZuMw5kR1LlG6wRIW8RJWkid8LB7/lYhZyTevlfLXZSo
 oaB4QHMGKQxDwpOxONwLPqVFO9pusE6qPvRUlNY5nXEweaDTSJ+wNamozH1qO9RgdgVU1lV8gP
 xrxseONGfxQyQ854qN322FYEwAom8/L/sNH8GDGFJYXnAdezrD8PtKQJlGeaB+Rmaf/glchf3B
 ba0H6uViYnBx8/ocUK37Sacm4E7G+2UKiWYvaBC9qqVLsgosNQATZGHLs4vwHvliWyY8g0Ozoe
 sSDA/oYAP0iDJwxZvBcYcUwr
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2020 23:01:56 -0800
IronPort-SDR: b/HY/sp7+EybxkY2M++hgIbAmpsJah6Iqilsv6Nl5Y+koFqaPYgbYknhcLp8D60p9JasckkZJf
 xlW0J/nwCQV4Muuwk010DiDtJtT1cwWOoDQcOUyT0Wta4Tx+bC/gadJAPeaerggCE2HoQEmxf/
 zr4wPvquvE734ykdusdkdVOLVGOSxntpWJhcC/zPBRYSsC4Xva2pSpCOniVqdBnTCVrcg/lHuj
 UFLi9DjN6M1rO7+cFRZ4k/Q1swUWfNYfMnzy94LRmu4k6urnOFTB3N8jptp9Ho2OM7SAG0l9hK
 okY=
WDCIronportException: Internal
Received: from washi.fujisawa.hgst.com ([10.149.53.254])
  by uls-op-cesaip02.wdc.com with ESMTP; 04 Nov 2020 23:16:59 -0800
From:   Damien Le Moal <damien.lemoal@wdc.com>
To:     linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH v2] null_blk: Set mq device as blocking with zoned mode
Date:   Thu,  5 Nov 2020 16:16:56 +0900
Message-Id: <20201105071656.421762-1-damien.lemoal@wdc.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Commit aa1c09cb65e2 ("null_blk: Fix locking in zoned mode") changed zone
locking to using the potentially sleeping wait_on_bit_io() function. A
zoned null_blk device must thus be marked as blocking to avoid calls to
queue_rq() from invalid contexts triggering might_sleep() warnings.

Reported-by: kernel test robot <lkp@intel.com>
Fixes: aa1c09cb65e2 ("null_blk: Fix locking in zoned mode")
Cc: stable@vger.kernel.org
Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
---
Changes from v1:
* Add "|| g_zoned" to condition for setting blocking to correctly handle
  creation through modprobe.

 drivers/block/null_blk_main.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/block/null_blk_main.c b/drivers/block/null_blk_main.c
index 4685ea401d5b..6bcf95d611a3 100644
--- a/drivers/block/null_blk_main.c
+++ b/drivers/block/null_blk_main.c
@@ -1714,7 +1714,7 @@ static int null_init_tag_set(struct nullb *nullb, struct blk_mq_tag_set *set)
 		set->flags |= BLK_MQ_F_TAG_HCTX_SHARED;
 	set->driver_data = NULL;
 
-	if ((nullb && nullb->dev->blocking) || g_blocking)
+	if ((nullb && nullb->dev->blocking) || g_blocking || g_zoned)
 		set->flags |= BLK_MQ_F_BLOCKING;
 
 	return blk_mq_alloc_tag_set(set);
@@ -1736,10 +1736,11 @@ static int null_validate_conf(struct nullb_device *dev)
 	dev->queue_mode = min_t(unsigned int, dev->queue_mode, NULL_Q_MQ);
 	dev->irqmode = min_t(unsigned int, dev->irqmode, NULL_IRQ_TIMER);
 
-	/* Do memory allocation, so set blocking */
-	if (dev->memory_backed)
+	/* Memory allocation and zone handling may sleep, so set blocking */
+	if (dev->memory_backed || dev->zoned)
 		dev->blocking = true;
-	else /* cache is meaningless */
+	/* Cache is meaningless without memory backing */
+	if (!dev->memory_backed)
 		dev->cache_size = 0;
 	dev->cache_size = min_t(unsigned long, ULONG_MAX / 1024 / 1024,
 						dev->cache_size);
-- 
2.26.2

