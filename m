Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CE30C433E0
	for <linux-block@archiver.kernel.org>; Fri, 29 Jan 2021 06:35:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C64AD64E09
	for <linux-block@archiver.kernel.org>; Fri, 29 Jan 2021 06:35:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232070AbhA2Gfa (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 29 Jan 2021 01:35:30 -0500
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:30101 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230121AbhA2GeZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 29 Jan 2021 01:34:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1611902531; x=1643438531;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=0VCLSE5sXO0lyPFXEr0yksZfkAxQoGXlgleG3h+1sZY=;
  b=BYu3yfIvztF90SGAvoPQt1rJf+OMGM2Q1BLydvPf0IL9kg4sNWCOonrV
   eoRWs+fj4CjVmY9rqI027C6XFdMZCfRsl6jmX1RlDY/dfl0BCiYlAkMGn
   hIsJsMqlqMYK9kUtPkDwfKww3PSpX9PNfYdPxYbE4TlQBOT6ZpFkVJ/RF
   BuVXHfuxPoy8/FGFL6ANHHMjmSsUDggdETaompnj5CP3Vlj5rV50ZjcTy
   G6bZEF8sfp95zEKdXsDdemBIYJf4TVsuG7IKBezYtJMz2EtFxAW/GlPq9
   xXJfpSp8q9kV4UeSPTuRRp+uz+23RA4K9p3UxP45ixRGdknq9VtFUxKbG
   g==;
IronPort-SDR: uT9v2rJRs4H+8PH7JBwvjh5XMd2kManRds90hBa1Z/259Mx+unVrJm3zj9zBbBEiEDNkq9sLlw
 H2QUr/bGC1/tnn14r55iTg02y6lJZ8R05Bi2rIgzLkrMma2pZ0aG9uvCzTO7CXSr4kBKSNNV2j
 wC59j1v/tNDDYI+l4ySmtKOYBKM1JaQ9rUFbGUd8VV+8kQ9rgweBZn5HWLjlEEsO+0suypqoSx
 lyl7OlbFNFgfDHl8hVtsQ4EJhERAgoQ6Km08O4CAdwTMEOc+TuIAM4nkMOuM+houNv1gf6038X
 Xvk=
X-IronPort-AV: E=Sophos;i="5.79,384,1602518400"; 
   d="scan'208";a="262653719"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 29 Jan 2021 14:40:29 +0800
IronPort-SDR: AIlC1Xen3fknfQ/wnEfsngZYWq1S0Brns8ISYJBZyHI7AObkCZ+OwARWR+w7TvOIe9xVmF0kTv
 8iTUwn6AQXWMlr9+4jYydrwoL47hiFvxKkCyAYdz80bVyhKQqsyMr1L8LY2JoYkQsIrwbK8zj5
 2VcV6iJ9C3yF9FmdBy22Soe0cXhRtosIYLzJMEjE9infXGkyoWQCMzMpEFFMwQtHFZ1cFq5LJw
 thmIjjJEqzEQ/AXsuQVdU1LDSJtEVw1sr0danPC54flt6t1C7uc3SWRxFiS+9l/AeooTiFRWwb
 xbKWlWdYo4x3ilrFNPQifRgc
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2021 22:17:36 -0800
IronPort-SDR: BUr/ZtB8TnQP7KzUj0r8RZZU5+MGQw5XfXc7qv5X2bov1k93eYrTxJEIj87BLe5joSiaOYpI4z
 mqhUNe0niZMGjHyXqHmCNR4HoduKnZHWjdTcyC+NdJ1BKhbM4jhA7qQOmI8LZw1FgiS4oL0dPL
 afzZEh1ESRmmGd8jNvu3sl/PafjBOp4dnFwRgMO86Ful/G7LVYz3X8aM/xRE2UY5G7JmwO6xlr
 s5cMUbkBOITYC9KPffAsfLhoARv7svlnjcYm/a+yL2ztE9leLhyy/1xBK+cCsZW8lEqwSM4w3u
 x94=
WDCIronportException: Internal
Received: from washi.fujisawa.hgst.com ([10.149.53.254])
  by uls-op-cesaip01.wdc.com with ESMTP; 28 Jan 2021 22:33:18 -0800
From:   Damien Le Moal <damien.lemoal@wdc.com>
To:     linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH] null_blk: fix compilation error on 32-bit arch
Date:   Fri, 29 Jan 2021 15:33:16 +0900
Message-Id: <20210129063316.638610-1-damien.lemoal@wdc.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Calculating the total number of zones of the device using DIV_ROUND_UP()
with two 64-bit arguments causes a compilation error on 32-bit arch
(undefined reference to `__udivdi3'). Replace this macro with a call
to round_up() to round up the device capacity to the zone size and a
bit shift operation for dividing the rounded capacity by the zone size.

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
---
 drivers/block/null_blk/zoned.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/block/null_blk/zoned.c b/drivers/block/null_blk/zoned.c
index 535351570bb2..fce0a54df0e5 100644
--- a/drivers/block/null_blk/zoned.c
+++ b/drivers/block/null_blk/zoned.c
@@ -83,7 +83,8 @@ int null_init_zoned_dev(struct nullb_device *dev, struct request_queue *q)
 	zone_capacity_sects = mb_to_sects(dev->zone_capacity);
 	dev_capacity_sects = mb_to_sects(dev->size);
 	dev->zone_size_sects = mb_to_sects(dev->zone_size);
-	dev->nr_zones = DIV_ROUND_UP(dev_capacity_sects, dev->zone_size_sects);
+	dev->nr_zones = round_up(dev_capacity_sects, dev->zone_size_sects)
+		>> ilog2(dev->zone_size_sects);
 
 	dev->zones = kvmalloc_array(dev->nr_zones, sizeof(struct nullb_zone),
 				    GFP_KERNEL | __GFP_ZERO);
-- 
2.29.2

