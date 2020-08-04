Return-Path: <SRS0=uCqz=BO=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E986C433E0
	for <linux-block@archiver.kernel.org>; Tue,  4 Aug 2020 09:25:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9E53D2086A
	for <linux-block@archiver.kernel.org>; Tue,  4 Aug 2020 09:25:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="mdatIUpX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725830AbgHDJZJ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 4 Aug 2020 05:25:09 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:39028 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725826AbgHDJZJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 4 Aug 2020 05:25:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1596533110; x=1628069110;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=j2qZXIaDd5zM+xru6KZPV4orJE0o/HlpK2J1NxMtGOw=;
  b=mdatIUpX8J9PCZLcmPicjwJR0OFmeqz7jojf5ob+/Rf5/dqI2pjTaBFY
   nTtwNq1449SxtFsHnZx41CVMhCgb47CHe2MQOMJ9m8yue1UW7Wte9EEjy
   F6vrtHKixmpOkG1lQSyQta+VXBoBPxHxI+VCoTn5W6LvkjFPJvXK3iMDZ
   +vsC0l8zOZNIa6cC0fBqNOrTB5UP0ptXiPyhGj8CF2WGvzf5VvW2BIukW
   p87WOt/6BU+QSppNXE3CNQoKOLm+wSFsnLrjovR/1yw67fncgaJr9nmrD
   hTY3n7Rleo/ObPKt7qIGcc2r6NHIbnEFGBytrMZJUHfaGI3LEJTvT+486
   w==;
IronPort-SDR: hPXIGYfznK26euuxb/ROnjRKsrW7a2vf6bMFt3OPh0hWFXhNf6hDCE4YPktrZ8GEbAtJ34ddoh
 wfpckCeIAe6afnJIuvU2+A+Re/sxRzqRGl+JYV0BkIaAVc3O99S8XVomZeinjwJZzjWcBImzH9
 AtkJgbkeQOPNkt58zhzriSBiyhLIbKXqA3d0lRSZrk4ZqnAHbF/+DCnJaFHj3lZC87zSz24g1Q
 pvmBK+VW3Dh/KHiVFPgtwQSvFZ83yriEVrUKyGpb0dLpAgn7RuNqrLDp37Rmdkdz+a56KgORSB
 HRM=
X-IronPort-AV: E=Sophos;i="5.75,433,1589212800"; 
   d="scan'208";a="247193504"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 04 Aug 2020 17:25:10 +0800
IronPort-SDR: 7or6tZHG3cdxlwdWlaeazxQgGFw9GoItKdsf1wDfoHoQE1VvWQAkeZudUH6bP7thopcQ3CqTga
 YQSJaOCAbBCA==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2020 02:13:09 -0700
IronPort-SDR: msS9q4U6bq36kCs3sF3lj5wiBOYViz9U57vE+kNCqdCFGhItj7eeuMuVhcwyx6+llRjUPrEr/V
 xapHunlDYeow==
WDCIronportException: Internal
Received: from unknown (HELO redsun60.ssa.fujisawa.hgst.com) ([10.149.66.36])
  by uls-op-cesaip02.wdc.com with ESMTP; 04 Aug 2020 02:25:08 -0700
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     Mike Snitzer <snitzer@redhat.com>
Cc:     dm-devel@redhat.com, linux-block@vger.kernel.org,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Naohiro Aota <Naohiro.Aota@wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH] dm: don't call report zones for more than the user requested
Date:   Tue,  4 Aug 2020 18:25:01 +0900
Message-Id: <20200804092501.7938-1-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Don't call report zones for more zones than the user actually requested,
otherwise this can lead to out-of-bounds accesses in the callback
functions.

Such a situation can happen if the target's ->report_zones() callback
function returns 0 because we've reached the end of the target and then
restart the report zones on the second target.

We're again calling into ->report_zones() and ultimately into the user
supplied callback function but when we're not subtracting the number of
zones already processed this may lead to out-of-bounds accesses in the
user callbacks.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 drivers/md/dm.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/md/dm.c b/drivers/md/dm.c
index 5b9de2f71bb0..88b391ff9bea 100644
--- a/drivers/md/dm.c
+++ b/drivers/md/dm.c
@@ -504,7 +504,8 @@ static int dm_blk_report_zones(struct gendisk *disk, sector_t sector,
 		}
 
 		args.tgt = tgt;
-		ret = tgt->type->report_zones(tgt, &args, nr_zones);
+		ret = tgt->type->report_zones(tgt, &args,
+					      nr_zones - args.zone_idx);
 		if (ret < 0)
 			goto out;
 	} while (args.zone_idx < nr_zones &&
-- 
2.26.2

