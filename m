Return-Path: <SRS0=D5/G=64=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8778C433E0
	for <linux-block@archiver.kernel.org>; Thu, 14 May 2020 06:58:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8FCF4206BE
	for <linux-block@archiver.kernel.org>; Thu, 14 May 2020 06:58:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="f1bN0BYQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725886AbgENG6d (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 14 May 2020 02:58:33 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:52283 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725864AbgENG6c (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 14 May 2020 02:58:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1589439513; x=1620975513;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=2arxs2HAmOYTbkwwFQ2/QyeKUxTgRPfSGeWkxUNfrd8=;
  b=f1bN0BYQ+pJVh5go2heoiIw1s+VeZx+fz2S89QKL+SJzezBD6LbyqRUJ
   CbV/f2bDMsltuoGQLQUH6q2Gy22tq4gyr7i47/kd23SAqCUlwLK9f/e0w
   y0nKPxXjcpQd+cg4mtICxsF+lyBTyB0GC163Yl1NmJ6mesV9oupPYa+ra
   NdOgfsed2C+3yj+W0z/iFiSil4HoDqETv+gtcWqnXIaIQ5YvXdVgp1k7f
   5ruEoglsZ7shLOFRoXiBMnEKdAUzQ+Y6BPoSx3Q3cvjh6+xbWS0peCHg1
   VfgIa5ulLmMbjRHqa3w7dFbPfPQ1xTPAetHtdIHM3C0fUpIsogvbZCeAx
   Q==;
IronPort-SDR: INGJR4uppNcNEF7lb3GBxQCYZ6qqEdx8SQ0l5tt8LWWmnsyoEgaoKDMjH555bSMvR93vJ0pmwz
 9vEwj72jMQ080827bxB8OxhUc4EF1kuoISBi4wKzPN8ANjR24xgXaLeBDQLqiqfJI+8xgnoOcl
 aIVUdpio1Zj6VpiP86Z871RXTOdgt2YKd7PEFZpSWtdxTZhhvGwfZqLyCmQ2BXsB0E4LJX69RF
 FrDuclSONcYkeMKRsp2UUnr+PN9bjuj5Kd9HGMtHY6sKuI7lVfbr9z2SVWOLZvfpbYCGNj39hm
 r58=
X-IronPort-AV: E=Sophos;i="5.73,390,1583164800"; 
   d="scan'208";a="137985608"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 14 May 2020 14:58:21 +0800
IronPort-SDR: tXuXqvhRK6ezaTEusSVGbw4k50Gid0KkxrdhOW85SwPH6w0pwZJ/ZVdrCJhDyv0/OYaGfTK+uF
 qk1pje5ROs1Ut1YzUuPgrVcBiJcESt7Qk=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2020 23:48:34 -0700
IronPort-SDR: 3muka8KvTa6xnEWniJ3JmJeimalLxxDU9I8aUCRbikqGt289fABnOEaqtp4neE1Rev4pzOxI6t
 5lXzgtCl2A0g==
WDCIronportException: Internal
Received: from washi.fujisawa.hgst.com ([10.149.53.254])
  by uls-op-cesaip01.wdc.com with ESMTP; 13 May 2020 23:58:19 -0700
From:   Damien Le Moal <damien.lemoal@wdc.com>
To:     linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        linux-nvme@lists.infradead.org, Keith Busch <kbusch@kernel.org>,
        dm-devel@redhat.com, Mike Snitzer <snitzer@redhat.com>
Subject: [PATCH] block: Improve io_opt limit stacking
Date:   Thu, 14 May 2020 15:58:19 +0900
Message-Id: <20200514065819.1113949-1-damien.lemoal@wdc.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

When devices with different physical sector sizes are stacked, the
largest value is used as the stacked device physical sector size. For
the optimal IO size, the lowest common multiple (lcm) of the underlying
devices is used for the stacked device. In this scenario, if only one of
the underlying device reports an optimal IO size, that value is used as
is for the stacked device but that value may not be a multiple of the
stacked device physical sector size. In this case, blk_stack_limits()
returns an error resulting in warnings being printed on device mapper
startup (observed with dm-zoned dual drive setup combining a 512B
sector SSD with a 4K sector HDD).

To fix this, rather than returning an error, the optimal IO size limit
for the stacked device can be adjusted to the lowest common multiple
(lcm) of the stacked physical sector size and optimal IO size, resulting
in a value that is a multiple of the physical sector size while still
being an optimal size for the underlying devices.

This patch is complementary to the patch "nvme: Fix io_opt limit
setting" which prevents the nvme driver from reporting an optimal IO
size equal to a namespace sector size for a device that does not report
an optimal IO size.

Suggested-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
---
 block/blk-settings.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/block/blk-settings.c b/block/blk-settings.c
index 9a2c23cd9700..9a2b017ff681 100644
--- a/block/blk-settings.c
+++ b/block/blk-settings.c
@@ -561,11 +561,8 @@ int blk_stack_limits(struct queue_limits *t, struct queue_limits *b,
 	}
 
 	/* Optimal I/O a multiple of the physical block size? */
-	if (t->io_opt & (t->physical_block_size - 1)) {
-		t->io_opt = 0;
-		t->misaligned = 1;
-		ret = -1;
-	}
+	if (t->io_opt & (t->physical_block_size - 1))
+		t->io_opt = lcm(t->io_opt, t->physical_block_size);
 
 	t->raid_partial_stripes_expensive =
 		max(t->raid_partial_stripes_expensive,
-- 
2.25.4

