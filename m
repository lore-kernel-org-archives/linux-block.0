Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F00BBC56202
	for <linux-block@archiver.kernel.org>; Thu, 26 Nov 2020 02:42:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9B07020B1F
	for <linux-block@archiver.kernel.org>; Thu, 26 Nov 2020 02:42:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="aw0OXOY+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733007AbgKZCmI (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 25 Nov 2020 21:42:08 -0500
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:45567 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732947AbgKZCmH (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 25 Nov 2020 21:42:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1606358527; x=1637894527;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=5Iw7w/DZLZaDG8VLkQP5pskn7Zl3Ct/yjTxMj+mxhCQ=;
  b=aw0OXOY+o6o5AU6i07lYZhOA8/o/yQW60P1t1jo9IIUOet+P1No+VHQC
   QfVKWswci9ACeUeEzqDaickCDUX/Umu16y6a1kxYd/5oLUwM5iqCh1VRc
   w5VAqgEY5J/QuXPI8lEF0BRGVKymaxiKEcSarvNUPMDCf9WSitNgGEMki
   WH+Um64duZzn3Ye8yvkQEt4yShUQpRtjMlKue3xKY5AgLwSd8oNfX9YsQ
   KeFObQ8C3OdvhjhIAbDrU1BXlikNZ9gpucm7jPGVTIkCzItKVTyLptjKC
   OEl908fH5YUXJ7uMmbMKjsPr1l3Z9b/iMAn4AT3x1vnSKcR6jWKeSPfYo
   g==;
IronPort-SDR: lCEqps9FanX2TrF2s+gSVhOD7LZHYdeTu5LJlCu8VrVVrQ3iHn677h9IcolzD12featiu67fu+
 WV7UlL/x5EtfgOY9O6o4D50IGgS2RA/DBTIyA6rpYQIrFGjcEgYU4TCxPPAGeQz/EFCXkceV9d
 myx9d3hszkG4lXhvEwkhN4jT20Qerbet/kTa/bt37Vvac2msqYLajdG5U4mbNIF2IVld5DY4/T
 9o0Y6AGLFVH8B1UxMX7YH70L95i2QZ5ibUxWcDgcEkZTVyTwn0AsNeTPSaaODeoPM3yvS8IC7k
 eDw=
X-IronPort-AV: E=Sophos;i="5.78,370,1599494400"; 
   d="scan'208";a="153586948"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 26 Nov 2020 10:42:07 +0800
IronPort-SDR: KVSIO1TS52XX/8e0Cs/F/UDgdptx3lxVdaO3KvIMUp6nzOeNtE5yfeibXwsSa/K/bBBGuVJx4A
 NtFI4ltrMZ9T7DHww1bpGzoai9OXMHGYM=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2020 18:26:29 -0800
IronPort-SDR: OT+ipo9IUtxLKQzFh1Yo+PY1jKiSNkSqbQL8MrcRG0FJM8iIsfre24ixAEpDApW2GE+fu8X2+1
 8sVkgdza+FfA==
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
  by uls-op-cesaip02.wdc.com with ESMTP; 25 Nov 2020 18:42:07 -0800
From:   Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To:     linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Cc:     sagi@grimberg.me, hch@lst.de,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [PATCH 8/9] nvmet: add zns bdev config support
Date:   Wed, 25 Nov 2020 18:40:42 -0800
Message-Id: <20201126024043.3392-9-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1
In-Reply-To: <20201126024043.3392-1-chaitanya.kulkarni@wdc.com>
References: <20201126024043.3392-1-chaitanya.kulkarni@wdc.com>
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
index 125dde3f410e..f8a500983abd 100644
--- a/drivers/nvme/target/io-cmd-bdev.c
+++ b/drivers/nvme/target/io-cmd-bdev.c
@@ -86,6 +86,9 @@ int nvmet_bdev_ns_enable(struct nvmet_ns *ns)
 	if (IS_ENABLED(CONFIG_BLK_DEV_INTEGRITY_T10))
 		nvmet_bdev_ns_enable_integrity(ns);
 
+	if (bdev_is_zoned(ns->bdev) && !nvmet_bdev_zns_config(ns))
+		return -EINVAL;
+
 	return 0;
 }
 
-- 
2.22.1

