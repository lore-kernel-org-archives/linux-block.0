Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 385ADC433EF
	for <linux-block@archiver.kernel.org>; Wed, 20 Apr 2022 00:57:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343765AbiDTBAK (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 19 Apr 2022 21:00:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347146AbiDTBAI (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 19 Apr 2022 21:00:08 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A04B513DEA
        for <linux-block@vger.kernel.org>; Tue, 19 Apr 2022 17:57:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1650416244; x=1681952244;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=uwyOan50nBaMbvW8rMFHvv/sLCGtm5g93jcRVvpeF6A=;
  b=IPZm1WnFt5ew3Dsz8yf3+/mAXBBvpXRYSThSbc8jjMSWw2+VooqKLvGL
   l05MyhCKb3u4pLlclLkW0wdc8MzwjD+RrdGSkURErjFCOJKzj07u6U5hx
   HNmIMon+sWx/2exaDsCietLF9gGbrp2hIwswQT4ebOLUx6Lw9H3dQYD4L
   qAALiyC5IDKUGKxv+xGvWxG3y+up7+a12u0rsEnxiPdvOD4L9HlE9kuci
   W4gM+afvnyXS7RBub4x8nzmCBwazsmpSWhdrCQJprF4g9MceztkX8JbUn
   VwgzsMtE4fQNNFnzERU8/h7irxUcHeph3/d9Z1wX9ZzSfO+fqIoZeE5Pb
   g==;
X-IronPort-AV: E=Sophos;i="5.90,274,1643644800"; 
   d="scan'208";a="310283702"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 20 Apr 2022 08:57:24 +0800
IronPort-SDR: 6/BqO76KR3v9HP6BauTfMDegvI1N9yr9u+Rq7M7LGesI26vB8UIekPp1Y8p/zxLRMQLvkO7pOS
 MZHyvh0ykuDF5sZitbzNU21aM/GDLDpu7wbIMojtzGaxcsibtyRZc7iH7fM7UjZofllOboc2V/
 8sHWXsnfCJBq4q25Wdf1bX0eqTzKIv0o9vU1ncGqXM9AJNIZ2fzPqCSxoPAWyYRIn3yWc9ojgI
 J9a+oFMcJocuEJzUaF3fQeLhka7BhD4u5AoARL8hN+EsbKEEZ7alyB/v2Bbff0YuScy3N0E7WZ
 OZGSMKTC93/WgX+95LomnFf8
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 19 Apr 2022 17:28:28 -0700
IronPort-SDR: BjL9WQ41mFuD7b/lp39JatWHqJ5RZ3nH/t1KZKTZm/D+l5/DDSWvr8DJF91ltgkzacrnOvC1d7
 Iua7SheqOmfMJqX+eHe48JGgR6ahmVW+yuYgflS3JsmUI9hXSwKmr8CSUEcPTk7Zo22drFIDJN
 FWr38SIhflrJAp28v2MHZf/myDkBIpeTAMSuXSS37ENGz6llc+/yL7TVAOLcY2Q2t9ExbgwS+/
 RSr8344axDc1dLiDK+5VUhppPCcbcD9h8NHn2ClDOV+IYIiRRNxfyf0mgK3JJ0pJCSmK0hGUNv
 94E=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 19 Apr 2022 17:57:25 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4Kjj1v6fRQz1SVp0
        for <linux-block@vger.kernel.org>; Tue, 19 Apr 2022 17:57:23 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:mime-version
        :references:in-reply-to:x-mailer:message-id:date:subject:to
        :from; s=dkim; t=1650416243; x=1653008244; bh=uwyOan50nBaMbvW8rM
        FHvv/sLCGtm5g93jcRVvpeF6A=; b=VHUew2JZgR1P9oXo0taJPxAsADA8JDOetw
        0ZRG5WeVBuMB28orDp5d2L6mIlXCz80Tj/CZKdISpr3LVzF00pdoebBjHzXbUyXD
        O6SqDxTXqf8O3bpxTEmZ5c+XSosYAGB7FKrQxEDuybvdyxmAMJ+GklwBe+jSJ+A1
        WKRk6j9KQBPAAo+WKwFkFx0AvXGKinGq+4E+MuVHFDmVBcB7qBbV4vPHTg8dzDYt
        I7HL1vzDUPlQ3U4qrI+WnRt2SaxMWVLn7kZiCN1xf7oIYt9W3r4U7MaimnEj+i63
        smU67mLQfHvLb49vlhFKKnbX1P4p8XlQymlmSvpXYbdCFI8X+a1g==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id VSn79JLUTH4l for <linux-block@vger.kernel.org>;
        Tue, 19 Apr 2022 17:57:23 -0700 (PDT)
Received: from washi.fujisawa.hgst.com (washi.fujisawa.hgst.com [10.149.53.254])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4Kjj1t6cThz1Rwrw;
        Tue, 19 Apr 2022 17:57:22 -0700 (PDT)
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Cc:     Josef Bacik <josef@toxicpanda.com>
Subject: [PATCH v2 3/4] block: null_blk: Cleanup messages
Date:   Wed, 20 Apr 2022 09:57:17 +0900
Message-Id: <20220420005718.3780004-4-damien.lemoal@opensource.wdc.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220420005718.3780004-1-damien.lemoal@opensource.wdc.com>
References: <20220420005718.3780004-1-damien.lemoal@opensource.wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Use the pr_fmt() macro to prefix all null_blk pr_xxx() messages with
"null_blk:" to clarify which module is printing the messages. Also add
a pr_info() message in null_add_dev() to print the name of a newly
created disk.

Signed-off-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
---
 drivers/block/null_blk/main.c  | 5 +++++
 drivers/block/null_blk/zoned.c | 7 +++++--
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.=
c
index 4d6bc94086da..7bc36d5114a9 100644
--- a/drivers/block/null_blk/main.c
+++ b/drivers/block/null_blk/main.c
@@ -11,6 +11,9 @@
 #include <linux/init.h>
 #include "null_blk.h"
=20
+#undef pr_fmt
+#define pr_fmt(fmt)	"null_blk: " fmt
+
 #define FREE_BATCH		16
=20
 #define TICKS_PER_SEC		50ULL
@@ -2071,6 +2074,8 @@ static int null_add_dev(struct nullb_device *dev)
 	list_add_tail(&nullb->list, &nullb_list);
 	mutex_unlock(&lock);
=20
+	pr_info("disk %s created\n", nullb->disk_name);
+
 	return 0;
 out_cleanup_zone:
 	null_free_zoned_dev(dev);
diff --git a/drivers/block/null_blk/zoned.c b/drivers/block/null_blk/zone=
d.c
index dae54dd1aeac..ed158ea4fdd1 100644
--- a/drivers/block/null_blk/zoned.c
+++ b/drivers/block/null_blk/zoned.c
@@ -6,6 +6,9 @@
 #define CREATE_TRACE_POINTS
 #include "trace.h"
=20
+#undef pr_fmt
+#define pr_fmt(fmt)	"null_blk: " fmt
+
 static inline sector_t mb_to_sects(unsigned long mb)
 {
 	return ((sector_t)mb * SZ_1M) >> SECTOR_SHIFT;
@@ -75,8 +78,8 @@ int null_init_zoned_dev(struct nullb_device *dev, struc=
t request_queue *q)
 		dev->zone_capacity =3D dev->zone_size;
=20
 	if (dev->zone_capacity > dev->zone_size) {
-		pr_err("null_blk: zone capacity (%lu MB) larger than zone size (%lu MB=
)\n",
-					dev->zone_capacity, dev->zone_size);
+		pr_err("zone capacity (%lu MB) larger than zone size (%lu MB)\n",
+		       dev->zone_capacity, dev->zone_size);
 		return -EINVAL;
 	}
=20
--=20
2.35.1

