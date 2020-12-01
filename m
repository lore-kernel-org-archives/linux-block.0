Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 526C9C64E7A
	for <linux-block@archiver.kernel.org>; Tue,  1 Dec 2020 04:16:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D6FAB20715
	for <linux-block@archiver.kernel.org>; Tue,  1 Dec 2020 04:16:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="pPJovK4F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728049AbgLAEQP (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 30 Nov 2020 23:16:15 -0500
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:13185 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728039AbgLAEQP (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 30 Nov 2020 23:16:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1606796175; x=1638332175;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=DGst3WtKZogqGUvuhSXY1Do01tQZeR4MGYSWqYweif8=;
  b=pPJovK4FH9VSlnr7Li2pHPWKsdbPUWJlOXEPksRtZD2OqjzAOZl408cr
   YHVBsaLlH6DQxewhlRM5GABVoUZLSBv+x5e/ac5Th4lqaLiberLoDxSD1
   QQ+o3EA1XOySvRgerjPQjiz8x24F5LZdAhJlS6r9wTEWFDzRR+FG83Y74
   Usy/KRJ9uay6/S9Hgisf5D+EGKYQrMXu5u0jAEymDRAK2NQAnekPefQ0f
   /UpBvHPznYhsbKk0hHvMqMH1V1GMZLkMPGJPp7zSQrxsh6Qg3k1lvhZCC
   2Xxobfs76Xxc6M1p/h/xb2LN631trfW4A4wf+8N0MUAVHDKi6FRSnLT25
   A==;
IronPort-SDR: 3dbcpKrfSkblsgJUAVASGjMzc7ODDoO29Jz1FIkNvUVoNpYtRWgzrgQTNzZxunIligKdAihh8B
 wPSPD4T1Nr/JX9lfqtz9PFQDHf1rgzIbwn1okA+OnYa2DMSSCKEjwtkiLqET34LHuphZnMN/KV
 LNNSPkgIR9qkbqMpGWfr4SOnjrHp0UCE/pPTOf3Xu2Zl4ZtkINvFEjyAKjaPeVDmCcvcRL4p8e
 dnJGhQLKy1OawvsRl6Y7iXZJ2P6sm8oTrK0AQHRd1xSJgSwNSb4vahNLwfno0M0Fs4T+rLog2Q
 ycA=
X-IronPort-AV: E=Sophos;i="5.78,383,1599494400"; 
   d="scan'208";a="155078201"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 01 Dec 2020 12:15:27 +0800
IronPort-SDR: P+kmGW8GUScSXbGJXHtxlaV8GNbSLQz7XxLZPjcQVEGv/ksHK8dmbguNp0bikAocsQ/mqqsk5d
 aBQ2K4stmFy/ylW/hsW8P1B4I2g4eWflU=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2020 19:59:39 -0800
IronPort-SDR: oOK355WftzbW+cpLDbRUEOgaJ9Q54PUztkfR5GVdew0njI760zH51zNV2nucOhyUy42YzZnvQf
 NVwIxHV2/ttw==
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
  by uls-op-cesaip01.wdc.com with ESMTP; 30 Nov 2020 20:15:27 -0800
From:   Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To:     linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Cc:     sagi@grimberg.me, hch@lst.de, damien.lemoal@wdc.com,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [PATCH V3 8/9] nvmet: add zns bdev config support
Date:   Mon, 30 Nov 2020 20:14:15 -0800
Message-Id: <20201201041416.16293-9-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1
In-Reply-To: <20201201041416.16293-1-chaitanya.kulkarni@wdc.com>
References: <20201201041416.16293-1-chaitanya.kulkarni@wdc.com>
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

