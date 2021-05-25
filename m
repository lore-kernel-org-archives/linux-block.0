Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EF2AC47084
	for <linux-block@archiver.kernel.org>; Tue, 25 May 2021 02:25:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E41306141D
	for <linux-block@archiver.kernel.org>; Tue, 25 May 2021 02:25:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230162AbhEYC1Q (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 24 May 2021 22:27:16 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:34067 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230175AbhEYC1P (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 24 May 2021 22:27:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1621909546; x=1653445546;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=qwMSHzXDr1xSUztltcFrjPV9BIHY9llHie0d63Ir2Pg=;
  b=nLC83B9l4xR6InLKYqaQHWAcfXiDlKrdi1rGZHFjlEGVK0/g+LmEdr1H
   kw18eGWqqTv1bIHoI/M1tnPGajkib6pL4Vy6NBnSSy6fGC03bb2GGtR2u
   koFwb2kk2WM9B0+xfnKlrGqIYlzih5xVRloCtMUlj+JkZb6sBAzcZsm4h
   uoj/qfv60YYTZXBn8v7LU6a+ZZ9hZPQ753JgQ8yeMhPm2rVJYKLGYa3Yl
   11dubS4/8FXRKbjwhvwINlwqX0g23dViD0m1uLQd2OepqsISkPiVmjWd5
   DQXLXfovNhDGaql5fznhiHLDkU3jpitb9Gv2hIP5OeVnngGsRQzEyYEAv
   w==;
IronPort-SDR: 7SgMTMiICP7rQhNyytY2DhhL86qM25JlqjH2AZ43qUssa3i/i9aPuEsKSsj771/XgeApvdXMhz
 ZOqRQZ9uY7HcqiJTMZ2soWoAU9HvzuxMEG4JVzBHimz6TtVFxZto9nKdOzJ7REjSABlEqI+8aV
 92bosaW3DyMowl1Rj5n7grUnZjdI8+JJAzxB93HsUsbI4tDDslYQm1W4xWlv+AI2ncchZSmCQQ
 f9QqtOLz3C9/RxNkhxe8PRP9kySHRsb+MFAEXENABSbrp2XYqdgMhcSpK9jKUKNz5qbiuWP06k
 AVE=
X-IronPort-AV: E=Sophos;i="5.82,327,1613404800"; 
   d="scan'208";a="173981326"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 25 May 2021 10:25:46 +0800
IronPort-SDR: 3Se462Ad58R19pASuSQ1a5spcVwkL0OoRFVlf5bToKYUIHasZ6GmZqOrc8UVnaQgCxWN2VWt6Z
 FoTU8HJo2XHdHctFVyqMES45ZQVusXnfZjYmajECbTY+uD+n3y+AMcXVna4i6tuZDDQCj1x7Wr
 cRhkHbfTbpEXntaXi14eQv7jfnLvWUG+iku45QHHT2SZcfJpqgz83K+I7wMYLtcKPP3PEY5A8N
 yMI2AW7IKIEfLyk6C0HdGVUH+BFam6dbTGwmxShkrUbYLmNK88IPE5tMXrujqIeNQmDSUcFgq7
 1cXyeOveElyPntQtOXG5MHFR
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 May 2021 19:04:01 -0700
IronPort-SDR: nzjkQfLveOBcPnqFVJ3qcjNFl6RWinOGZaMHko/aoC07m7DRB/BgrvQ5lmQppmfHPTSCoIoxDI
 H7pYALN+qTXHXn43AD4j0oehM2MPa+Hq1zuwtVKb7JAP1B7+DeMn8/8PccGq7z8d+gC5OlUHYX
 gEjeb94ha+5eCCcVBIKZYipVLKMINtgi/zoo/wuprs7p0yNUSc/CcgIBqE2fmJ92lfK93IHweh
 w7Qz8Dgur5OOf6QegloFJaJ8/6D+Z+w4Xkn87wzg3sQ0n89gcQzBbu6N6rHuVi/7+wK21vHAcS
 TCs=
WDCIronportException: Internal
Received: from washi.fujisawa.hgst.com ([10.149.53.254])
  by uls-op-cesaip02.wdc.com with ESMTP; 24 May 2021 19:25:46 -0700
From:   Damien Le Moal <damien.lemoal@wdc.com>
To:     dm-devel@redhat.com, Mike Snitzer <snitzer@redhat.com>,
        linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH v4 05/11] dm: cleanup device_area_is_invalid()
Date:   Tue, 25 May 2021 11:25:33 +0900
Message-Id: <20210525022539.119661-6-damien.lemoal@wdc.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210525022539.119661-1-damien.lemoal@wdc.com>
References: <20210525022539.119661-1-damien.lemoal@wdc.com>
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

