Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B768C433B4
	for <linux-block@archiver.kernel.org>; Fri, 21 May 2021 03:01:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 56DF66128A
	for <linux-block@archiver.kernel.org>; Fri, 21 May 2021 03:01:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237936AbhEUDCu (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 20 May 2021 23:02:50 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:25389 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235553AbhEUDCu (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 20 May 2021 23:02:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1621566088; x=1653102088;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=qwMSHzXDr1xSUztltcFrjPV9BIHY9llHie0d63Ir2Pg=;
  b=dC05c+eFZHLDuMNDOr78bjFu+OiPpIe0+R03suiHvXMavGqrQRHqZSvx
   GvoQ343pQtgWgrK/yDpCTRT1dYKuVs/4OLQ2FYJqum5waZBC077fOZWhE
   Wjn/lK5VLdC4Co9uRklNs9xH8msCc9jkFv3JpDTjDivf2TnrDaBdOEhhh
   TCMgNrkfzV29/1HLKcxyiTMN5twj74dYg35iF2Cpelj5KMWPd533thv7z
   lvQb9QWgGSaFppLkdNWf0pE57ZdlIYznIZrxCTNWL5GuNlJaIPKnytMu8
   LZd8UZONpNBq28nw6d9w6Uc+FuV6BKAQtU8yyszGEZQ+Vf2aV53Ki2aOc
   A==;
IronPort-SDR: /Hue5h/pooGcfekzR0TXYUI3XfOdugW9iYVKPEULQq4k6Wg0/13wZwGVK1gPsQGQVi46CWZK3H
 t40CfKxhkvzUtpuSbJz1Vt0LT48saztLoTNLT+vAdOLv4/RRiL7rMBRW7oIRrYYfUh3MGfpl3O
 /eSGncEQdJGaaVlL6xUXFL43WcaoGeaYqgb6tI9VUYH7xg18Unux28JfkRSrVvRTeyFPU03mu4
 uGJfdzEsPZSzTTuOHak9bgMwR6zQt3pU3FJCMouwwdHWoqHckhe1ckyUaBVG8r6BfSaoeyMLWD
 JBU=
X-IronPort-AV: E=Sophos;i="5.82,313,1613404800"; 
   d="scan'208";a="168943830"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 21 May 2021 11:01:27 +0800
IronPort-SDR: 3HEpnoNR6yKR0coTvQYwoetNU0ukdBM0lmtbs7oo14EpvdCrp10/XV5NY3D66boyyv1yYJ2CSJ
 RwAZiY0SZ+vM7jwwvMNA4kr9CoQo8AbqhcppYX+LCx8NVxCbBQuM4d6Proc7hPTTHzwDTxjlxw
 vJD2q+IYj8r7rXZ6AXKhhe9XMABz+BJ5l+reRHKa+E9ftf8QCNEzSbua+X8+aZjr23xEU/INU5
 ug6NCrxTnLTvpdBWPmeezZMz6IuIQ/wc4VBs2ccsbVhTUsiDQhX5/GYp2Seg/7nPWpG4X0UOls
 VJJKkt4+cdaaesVbwCzTpmJo
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2021 19:41:04 -0700
IronPort-SDR: 4AZpCJ5RZBShdzujQpwtsu4LG365nyts0TnD3MLehk3UQSjrGyAeZeIs+UkRrvRn2uL9L/4Rs6
 5fBm7zZeVXVfrs3yB8wyrd+c1+y6Dc9pZ5WlODloIQmu+FtX3XsJ//CFegDiA9GrY4b/nGMUGi
 KFXAD1F4e4vEw5t5ToT2wl1BXmmBJy5TFd4yMx0gxvkiRJ5SSjK3t6R3a1zUmzeFVHCA+FNSny
 mXUTq6JuBobwx31k/kA+irggjxfW3QBKEIL91onw1issbC1v+SnkA1OMjsXsNSYwhoSRix63d7
 PbQ=
WDCIronportException: Internal
Received: from washi.fujisawa.hgst.com ([10.149.53.254])
  by uls-op-cesaip02.wdc.com with ESMTP; 20 May 2021 20:01:27 -0700
From:   Damien Le Moal <damien.lemoal@wdc.com>
To:     dm-devel@redhat.com, Mike Snitzer <snitzer@redhat.com>,
        linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH v3 05/11] dm: cleanup device_area_is_invalid()
Date:   Fri, 21 May 2021 12:01:13 +0900
Message-Id: <20210521030119.1209035-6-damien.lemoal@wdc.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210521030119.1209035-1-damien.lemoal@wdc.com>
References: <20210521030119.1209035-1-damien.lemoal@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

In device_area_is_invalid(), use bdev_is_zoned() instead of open
coding the test on the zoned model returned by bdev_zoned_model().

Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Reviewed-by: Hannes Reinecke <hare@suse.de>
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

