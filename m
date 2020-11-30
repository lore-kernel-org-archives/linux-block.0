Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E581C63777
	for <linux-block@archiver.kernel.org>; Mon, 30 Nov 2020 03:31:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 23B3420757
	for <linux-block@archiver.kernel.org>; Mon, 30 Nov 2020 03:31:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="LyC+ETmN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728316AbgK3Db6 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 29 Nov 2020 22:31:58 -0500
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:7754 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728166AbgK3Db6 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 29 Nov 2020 22:31:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1606707117; x=1638243117;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=DGst3WtKZogqGUvuhSXY1Do01tQZeR4MGYSWqYweif8=;
  b=LyC+ETmNEEk75e+9RRVGCR7a58Yte/yqeLiITa3Uajlcgem8P0VEHM1Q
   GGFHlOpuyYQun33wTw2FfmC6nomwHIseeeIxxxFSiQ2pg8jVHHhBT4sl1
   9rjbMBxOnqAZ/pU5wQCA3kB90IgdL7saUzSDls3tre0yFHp4SB6v55DnG
   Cvb4Vo1gRnQGeKVI2SoAcQKkEy7t/K7A2EeG6Hyps/S9+8+KJ2A74FApm
   j6QtRvZNtj32GtM9fpYkUsWTBb28JxEloRcrCnlqJIgSH+yXSQRy1ea3m
   p+fKlbajJHO3vPvAOv7dYatUn5dwpF65swbAnrGkW2SJ23EblHAwvv5aL
   A==;
IronPort-SDR: fWwqKBN5p0sp0weaEZO8F+IgocpMudEyjFkTKZFyG02ayFBNqknYvPq//IU9K/iebaHwUE5nSQ
 AKg7g3qsO4bHgHHrtgZiCndu8/R5LClcJKIf9rloaV83jyJio6Ace1dzsIyOgzJlrAD51KTTlT
 qMpeIIDoQNlZsRmvR4WMhXmfBTB6yALuN6pZqdtWtm8mgUcIjCY1JK4mhcXjSX3uKBgx9cH3tY
 yUDAXRbJz3uwuT6qRaWeOxhRoi/r0Ni+/QXoxRjkJnznCU9L0XSU4PDsSFTgOlbYD+oRYEpn9M
 fd0=
X-IronPort-AV: E=Sophos;i="5.78,379,1599494400"; 
   d="scan'208";a="153844153"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 30 Nov 2020 11:30:10 +0800
IronPort-SDR: 3BhrUJ7UJ81MNFjhPIi3V00CqXIowBMgqp6ebfIkRKKM2kjo8TwbrFPQdMPLABDZ6UCo9jQuP2
 TAKLd5/8wPEcnKYz4dg1qHgfB6G4R4Za4=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2020 19:14:24 -0800
IronPort-SDR: beHalbNxexlazcYB3ByP8QAzY/houumBdrNcMA4pNHhuKyW7zGlJZqaR49S4z1XNtqkK4G/8If
 2/OJqRDFfZEA==
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
  by uls-op-cesaip02.wdc.com with ESMTP; 29 Nov 2020 19:30:10 -0800
From:   Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To:     linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Cc:     hch@lst.de, sagi@grimberg.me, damien.lemoal@wdc.com,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [PATCH V2 8/9] nvmet: add zns bdev config support
Date:   Sun, 29 Nov 2020 19:29:08 -0800
Message-Id: <20201130032909.40638-9-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1
In-Reply-To: <20201130032909.40638-1-chaitanya.kulkarni@wdc.com>
References: <20201130032909.40638-1-chaitanya.kulkarni@wdc.com>
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

