Return-Path: <SRS0=FEuC=EL=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E0E5C00A89
	for <linux-block@archiver.kernel.org>; Thu,  5 Nov 2020 06:50:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D186A2087D
	for <linux-block@archiver.kernel.org>; Thu,  5 Nov 2020 06:50:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="e0pIbx5c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725294AbgKEGuL (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 5 Nov 2020 01:50:11 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:8698 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725287AbgKEGuK (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 5 Nov 2020 01:50:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1604559010; x=1636095010;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=CkxRU5BOaSQpaRRcA2LDXSlHa6ERXzY0iIVwTkluBRU=;
  b=e0pIbx5cddFiGIfp8DDV51UMerrrkvjMA/OrQptavYEYr/FMOYi3qC8p
   b7WutchqL0fwS/F3LU2STkwmvvkERterBFQZL08BTBIFe1DK5/dQHyVhV
   j0nB4hoMvf4AcCjAgj6u6VqbW6nEh+IVB8yRNmM02PUocPp8TzJz+hY0+
   pubUy7gItHej6JVaZQ2n0TN7gJ9ONn8ZVKCnb1IT3jKCSuiN9jJuGDlvM
   z5IhvUGOKicsm2bKLyU49DB7UPK5BXDBMnnXSqEvXIzctZsDx09+VyTVK
   SompC04aroL0hAZjPH7IDiwSnGgPilIsB38LhlcMObBgxa18eboVeT6uK
   w==;
IronPort-SDR: gCYpVtFW37Xu2t3lgVfXHAcnDb/A6khal2A5dECGV+DmGTVBlhfRPh8KyxglYNhc9a2Mx3PW6U
 zGBB5tkhMwTUjpnU0eafteU4a2h7/rPZ43XRnof46e3z5rF3H1IAYyyyB/TOEdnPrhRWVwQ/o6
 KKFZjgLMvGQo3mfZ2iaOCGi8fVrpFQ2VlOUhf6o5XpDrDRwcz6+q2KpzyQkW01aTb5nXjJbzna
 LAMU2nQjXpGALWXl3aSU9TQwdSR+yb4kE+SP+2KtbPNWHZh1cLg+fYkbl8g4H/Yu/9ZvbrrjlS
 0Cc=
X-IronPort-AV: E=Sophos;i="5.77,452,1596470400"; 
   d="scan'208";a="156350354"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 05 Nov 2020 14:50:10 +0800
IronPort-SDR: OnpBtzVxClegWYxsrLwtPxocdq5A7/3VuDqs4CgLbHeDVLL0faDI1XzN70oegaoj26WdOWtJRc
 OWrHewdwOGvS0i3evzyi6q5bwDBqK6V3zWiIt8oa2vwN0yq9ff3z1UfSFBAmKw4Jt9kZ5RQt0U
 s51lzcM95Ui47Jgdo9hR4htcuQJh4zs0SsLUA3uaqIfEoBRpTkT2/I6UcJ5+4wlWQ7AgOGstVG
 O0P9j2gseOWx0vdy52509N27e18Y/K+WvdaQ4qJU5RNJ4+R0YkEZxBEz1DjqbV4XGcxstRAX1u
 y9hBcbHABLZPmcNZigO+F1SC
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2020 22:35:07 -0800
IronPort-SDR: 1Bm+yT4PN3O+VnA+pefSl7bzOvXaOUgQgrZVXxtc1ipzrw2AE2XL9skWl5XoRCXWaRZU/90fuJ
 sO1w2dcRYCDItrDV3pLvi+Chxm4VRbNSZyXFlDJDY0Dpu29RXRQif43IIPbNgsv27D2wVBmiTS
 eq0Tn6dZoGka5ymHwS7dtYkhqTM+m1QTDbXGahwm6ykQjWAaZN41jLl2Kh/x8ztbHm8cpDRUDx
 CdhE5+HD1HAfUVsFBw1Xup4LqBqx23FprGauKzH6gNKc91WGM7HsPi0iuPhtaOA0gOebvluI06
 sSE=
WDCIronportException: Internal
Received: from washi.fujisawa.hgst.com ([10.149.53.254])
  by uls-op-cesaip01.wdc.com with ESMTP; 04 Nov 2020 22:50:09 -0800
From:   Damien Le Moal <damien.lemoal@wdc.com>
To:     linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH] null_blk: Set mq device as blocking with zoned mode
Date:   Thu,  5 Nov 2020 15:50:08 +0900
Message-Id: <20201105065008.401112-1-damien.lemoal@wdc.com>
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
 drivers/block/null_blk_main.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/block/null_blk_main.c b/drivers/block/null_blk_main.c
index 4685ea401d5b..9b4e22c8cc78 100644
--- a/drivers/block/null_blk_main.c
+++ b/drivers/block/null_blk_main.c
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

