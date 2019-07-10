Return-Path: <SRS0=ACpf=VH=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DA94C73C68
	for <linux-block@archiver.kernel.org>; Wed, 10 Jul 2019 04:03:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48D952083D
	for <linux-block@archiver.kernel.org>; Wed, 10 Jul 2019 04:03:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="QV/bLBNA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726098AbfGJEDC (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 10 Jul 2019 00:03:02 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:47825 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725791AbfGJEDC (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 10 Jul 2019 00:03:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1562731383; x=1594267383;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=nL2Cp9xIWa4DFndjGytItZxL7ccXH8n5IsZyR6KogdM=;
  b=QV/bLBNArh55T8YxDQCOIlI8pLGgkHKpG/bV/Pu3LZVrp9llrK3j7s9s
   wNpcDGx6HoE4cgI+7r+OtEzkwF/j3mp1TMgNk5BHYTVDivnxySMXkXpwJ
   N0piBaspsieCPwgbnw/uqScEfnqUjGgFpqQUH/FvsaTVmdRFSMZewpyOi
   A5HRwKWzzdN7PF4koeo4gGDjNT9PZ5LbaP8CJrV0TMkukqWG5l33wh+gL
   Yvr3F4Y62OIRc7SOKaugtsEQoAkQs4YnDkRMf2uwRddsYuAuBDWYKE3dX
   /Gacu6NUUIB/jXdX+BihVQgiC82Hoeoh8jAPBQq9+2e22JZFBLyRHMsZN
   w==;
IronPort-SDR: Xuc+EqHe7ENMN2qy6/J7lbomAbmEMa3mfLwOpGzhi7qGX+mBv4Wj8XzqlUvQ8FUEMzvXWzAJan
 /0kkOqBRdDS9RHFpr9IFw6wvUNtP3RzYHqNdYw+NjWazVLz45sigAUVtO/+BYPrXl4IktG1YHx
 xkEXCo94uQ4Jy3o59ItTfk0fCDvf/Xr2DWfhWZzl13NpNjuil5VpED9dJilMx2nZyoQ5lQ6OnW
 69SoruqqTO+cecvDoTuXf1cc3EOomPPUpTvPePcAnMaL7O7ZpZp1TE1kRwb8oynBjIAFbn0O2m
 Eg8=
X-IronPort-AV: E=Sophos;i="5.63,473,1557158400"; 
   d="scan'208";a="117438991"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 10 Jul 2019 12:03:03 +0800
IronPort-SDR: 0Cj+9JBwxbrOaL7tNujq7JmlHVw67dhEzSG3pLdw/sCMukBJPHTAjqaL+yJcscWOZdtydwiwmj
 kWHTA0Ar+MTInH0rWti/olOCVFw5H6wST1FfPOh+o69SRoO1lp+wVuR61uNzoXSKFlXChTCYku
 3x5nmBWSIqFf0WSJF1YW9Niu39iZ5NO3q7MqdvJBxbEBfzbylOEzAwPCJE1kJJBh6dKj7UyPzd
 2rK6qJ/5tgkBEPEJeCS70SIoDICalLC9rXfAx+FY8h0mPAklBY8FbJTuNcXS8d4tESxki0BVGK
 tmaw3K/0k8cJwzvvoX5jxl0u
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP; 09 Jul 2019 21:01:48 -0700
IronPort-SDR: /X8Vt+Zq18Bwb2coxNIrxojPf8Yo13KFVlKeJ7Yl0ujah481Pl5HgfY8AfKhI34FQwSnHGQMKq
 UFu+bqlYqf8IAcI588VxqgOx+6as4TEizZ5FBBOzyCI8MA4J+XOZxGl2+98QJYUkyR7HcDSfUZ
 ihK7T8zuuX3MJioSPsmJObknPRQekH6dpENmAQxMSY2QqoVx1adDx2U8Nb6kMIkONBc68BQxXh
 Oet6XllqptIzuFez5WVlboHC0676TvOt5dL4mhG6fkZZrwHsDu9oID/kk2HvWP3k6khoTaezo6
 YE8=
Received: from cvenusqemu.hgst.com ([10.202.66.73])
  by uls-op-cesaip02.wdc.com with ESMTP; 09 Jul 2019 21:03:02 -0700
From:   Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To:     linux-block@vger.kernel.org
Cc:     Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>, axboe@kernel.dk,
        hch@lst.de
Subject: [PATCH 1/3] block: set ioprio for zone-reset bio
Date:   Tue,  9 Jul 2019 21:02:22 -0700
Message-Id: <20190710040224.12342-2-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190710040224.12342-1-chaitanya.kulkarni@wdc.com>
References: <20190710040224.12342-1-chaitanya.kulkarni@wdc.com>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Set the current process's iopriority to the bio for REQ_OP_ZONE_RESET.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 block/blk-zoned.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/block/blk-zoned.c b/block/blk-zoned.c
index ae7e91bd0618..0bd7981e9535 100644
--- a/block/blk-zoned.c
+++ b/block/blk-zoned.c
@@ -249,6 +249,7 @@ int blkdev_reset_zones(struct block_device *bdev,
 		bio->bi_iter.bi_sector = sector;
 		bio_set_dev(bio, bdev);
 		bio_set_op_attrs(bio, REQ_OP_ZONE_RESET, 0);
+		bio_set_prio(bio, get_current_ioprio());
 
 		sector += zone_sectors;
 
-- 
2.17.0

