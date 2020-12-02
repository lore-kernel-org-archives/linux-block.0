Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A113C64E8A
	for <linux-block@archiver.kernel.org>; Wed,  2 Dec 2020 06:24:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E6FE522202
	for <linux-block@archiver.kernel.org>; Wed,  2 Dec 2020 06:24:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728527AbgLBGYj (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 2 Dec 2020 01:24:39 -0500
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:45258 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728517AbgLBGYj (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 2 Dec 2020 01:24:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1606890278; x=1638426278;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=DGst3WtKZogqGUvuhSXY1Do01tQZeR4MGYSWqYweif8=;
  b=XNNBl7uIjE0J66yDCijjwNDdeXJfqdNN5O6f2J9jl8bEgDF3CAm6eEAn
   668SxzHM9DsezdkGUjbvDB7o1PAnHhpQrv1Y8rPA1jeGztfvr6AbsjXde
   5xwbx/sKNYIJFuuzr8k4Wrill3r/eBSGZWbWHB35ZpSaCRO8ko7VoPti6
   kOEA5+FG4S7mO55+jBxOFuZHcUnrlyclX9qkCtNzDmeig7uoeMBxaHaoM
   ak4Lkbx8xysj2lma5YDicw8GuQlbn5h01rKV+N179tTfsrH40qscfZj24
   ESfkUEBy+nAgybPVqw/h02vKf7M6kQDNyqGn1TcrZYPIwMj9kpZZJzqtF
   A==;
IronPort-SDR: uoy2tXA22fDMsDp/Sn8oDPR2ydFl9p+4cG+DAV6S341MXNWO6ii0zZbBVV79RoQULEVm5/1Oim
 CcJ2xMlEtxi+AG4bCbW7b1SXCIsK35uQHfWqvpY/LcX0PXc3phccABN/FnHCjw2MrcqVTYf5YF
 eTQS6K8Pe5oVk3F/oV3ALZx+9HPTDFi+vI7MAU9zMKX/tIvhixmSYmV1pEE2gCmsYjCCRsaMbM
 HWRcOwdB+i9o/3N1cpVf+8l/qwiaj4J8+RhrGml+ROkKw2jgM3MP3mhLDrO1COyajYfvzDWfoy
 e/Y=
X-IronPort-AV: E=Sophos;i="5.78,385,1599494400"; 
   d="scan'208";a="154060516"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 02 Dec 2020 14:23:54 +0800
IronPort-SDR: gqOO1OhWPWyMC+WgqxCZgmGZ+QHqPjp0TibXzx5mFnZL1xgTo2NfHNOm9juEQTgDZl2i0R2md5
 L0kO8EwlIQiOrly3fk69rFTOHtLSiwAAU=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2020 22:09:29 -0800
IronPort-SDR: njVwyJp2xVsuqJqEziWlWXHeH9JfpNTAWREwm6IRzwIuh12ZmFU0s34CSNf0czw+//YGcXZNQp
 BD2YQhPZ8efg==
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
  by uls-op-cesaip02.wdc.com with ESMTP; 01 Dec 2020 22:23:54 -0800
From:   Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To:     linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Cc:     sagi@grimberg.me, hch@lst.de, damien.lemoal@wdc.com,
        johannes.thumshirn@wdc.com,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [PATCH V4 8/9] nvmet: add zns bdev config support
Date:   Tue,  1 Dec 2020 22:22:26 -0800
Message-Id: <20201202062227.9826-9-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1
In-Reply-To: <20201202062227.9826-1-chaitanya.kulkarni@wdc.com>
References: <20201202062227.9826-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

For zbd based bdev backend we need to override the ns->blksize_shift
with the physical block size instead of using the logical block size
so that SMR drives will not result in an error.

Update the nvmet_bdev_ns_enable() to reflect that.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 drivers/nvme/target/io-cmd-bdev.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/nvme/target/io-cmd-bdev.c b/drivers/nvme/target/io-cmd-bdev.c
index 125dde3f410e..e1f6d59dd341 100644
--- a/drivers/nvme/target/io-cmd-bdev.c
+++ b/drivers/nvme/target/io-cmd-bdev.c
@@ -86,6 +86,9 @@ int nvmet_bdev_ns_enable(struct nvmet_ns *ns)
 	if (IS_ENABLED(CONFIG_BLK_DEV_INTEGRITY_T10))
 		nvmet_bdev_ns_enable_integrity(ns);
 
+	if (bdev_is_zoned(ns->bdev) && !nvmet_bdev_zns_enable(ns))
+		return -EINVAL;
+
 	return 0;
 }
 
-- 
2.22.1

