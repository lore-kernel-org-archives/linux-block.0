Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7F60C433B4
	for <linux-block@archiver.kernel.org>; Wed, 19 May 2021 02:55:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BB4C2611BF
	for <linux-block@archiver.kernel.org>; Wed, 19 May 2021 02:55:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237411AbhESC44 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 18 May 2021 22:56:56 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:5175 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237388AbhESC4z (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 18 May 2021 22:56:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1621392936; x=1652928936;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=pkTM/w4V/LaOIzD75iRX3V2KkhfGqUPYP/VrhBVpQ3M=;
  b=KWEX2s79I53vPkC0LCYtljbUbrjSqh/PMkCC5bQc/u09m73yUrRCN+xm
   u6TvBgYBqO5TTo8NqdnrioU4941vi8G96pT00qvH3NcGWHxBhfv1ZNzt2
   tc3FAK8YNlbiG4sMr3ljgYBRCW8xXn0fs/qAjP5aCuMR72Pb1hnnznAsh
   iEF4KRud5I10+Gg0mQKWq495jFKwPA2xyYZFoYZRWzHuYFGdso3/1NK8q
   /EwcgVL9CHrhqGLASySnylqMCQCmOYenVhKOoCtDkArmJkgE2HKyPqwZk
   LFh5oDK7W7T6myS+ZhoPsa0bQSGhODtHOWaIbyKvL3ZD8fZu8Xe2DmtgE
   w==;
IronPort-SDR: A1TL2IErHA5bbDAzWqipWaRh5tbBMiARyaj4DyEhD2HjyQ4nN/rYDi4PbnUydeV0gm9eYGI0yS
 U2GetrWx3PLN9X7Cp0zg2oSTXO4BtPyi29Tn4h0xGX3kqF6iVZQ17lDS62i6/buQNCNZANPEvt
 cGPvAk3Nk/dq28TfrrWhymdTg7m3L2M1VAGMif8nG6JJygZIbcvuDTZGBVyUvWAUxhKxBLxay4
 MDWzPFi5TH4KI7IFrwfewBynbQej3DC/7dlWxwvzio8qkFiY1iwc9rLP0ngjMRIAux86WroX7g
 AEY=
X-IronPort-AV: E=Sophos;i="5.82,311,1613404800"; 
   d="scan'208";a="173265901"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 19 May 2021 10:55:36 +0800
IronPort-SDR: 7eThjK3WZLLBvUwvuPN/Wor6WrIPLKaTsT/l0jHHqM8KATpHW71ciVQDfgPZVI3mt1fVe+W4Bs
 VTnQLnzl8/Y32IrDSXF+x6CN7o0qcEkgC7YpQto8DQ/yAPSUpXzY2oSV6Q3Ns6h6O7BGBvm7mJ
 35iFPjC2GPECxj5OH8kQguGg/zEWGAQTtdcvXPXPnNHwgXNg4sIuPGfjFv4nq51IzS+bIJe6wM
 EHqLHvmQBVRhOEzn0ESymt7cqNPXBDQcEeZprb9vxbaztqWoXsJN8ocz+j0MRVVD7iwF0+h2s0
 se1CuuhPakX35/MhKvxWjzi+
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2021 19:35:15 -0700
IronPort-SDR: cn9S+bH2vAN57lDXfGpWNGHaFTa/lMAMBGpy+k9iIXRCR04fLCAkSLAShfC5hohyVGXEguITG/
 GO4zfe4hRxkA3lMiiPPA699VG9pjN1dNP+amZ7VC5ohQMVWifka2UzbujOEC3cuLlvYrXhhrZv
 VC0oRhzfYZA2l8yfI3NmivNrk8Jtkyxn7GdWRC+WSsOCNojGZcIixiC/In4e2G/LDhMNOnu5Uc
 ZTe6KrE9pqjvFotycJ57CJLkv1wdeLFO9X9KfNcqbQvmoo5xKqSCF8vZ8rHpFcvA3+wTbUY/Ix
 GLQ=
WDCIronportException: Internal
Received: from washi.fujisawa.hgst.com ([10.149.53.254])
  by uls-op-cesaip02.wdc.com with ESMTP; 18 May 2021 19:55:35 -0700
From:   Damien Le Moal <damien.lemoal@wdc.com>
To:     dm-devel@redhat.com, Mike Snitzer <snitzer@redhat.com>,
        linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 05/11] dm: cleanup device_area_is_invalid()
Date:   Wed, 19 May 2021 11:55:23 +0900
Message-Id: <20210519025529.707897-6-damien.lemoal@wdc.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210519025529.707897-1-damien.lemoal@wdc.com>
References: <20210519025529.707897-1-damien.lemoal@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

In device_area_is_invalid(), use bdev_is_zoned() instead of open
coding the test on the zoned model returned by bdev_zoned_model().

Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
---
 drivers/md/dm-table.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/md/dm-table.c b/drivers/md/dm-table.c
index ee47a332b462..21fd9cd4da32 100644
--- a/drivers/md/dm-table.c
+++ b/drivers/md/dm-table.c
@@ -249,7 +249,7 @@ static int device_area_is_invalid(struct dm_target *ti, struct dm_dev *dev,
 	 * If the target is mapped to zoned block device(s), check
 	 * that the zones are not partially mapped.
 	 */
-	if (bdev_zoned_model(bdev) != BLK_ZONED_NONE) {
+	if (bdev_is_zoned(bdev)) {
 		unsigned int zone_sectors = bdev_zone_sectors(bdev);
 
 		if (start & (zone_sectors - 1)) {
-- 
2.31.1

