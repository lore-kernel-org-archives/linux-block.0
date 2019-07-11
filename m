Return-Path: <SRS0=DuRR=VI=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8448C71142
	for <linux-block@archiver.kernel.org>; Thu, 11 Jul 2019 17:54:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B5EC20872
	for <linux-block@archiver.kernel.org>; Thu, 11 Jul 2019 17:54:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="JLOzwGCf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728757AbfGKRyF (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 11 Jul 2019 13:54:05 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:2232 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728355AbfGKRyF (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 11 Jul 2019 13:54:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1562867645; x=1594403645;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=rc5d1BORUsGfUd0z/ZS6DHDg5KgvcI3LpvPn05LYeEM=;
  b=JLOzwGCfsJB3sPBO7o5p8eWs4E40sBAe3nJQp4pJnEbx3pkExb99cmaI
   XyW9bqFkB9GkkGYuAP0R2IncC13wWu5sd7+OgLuOF/A9Awcu5FsDKjstK
   Q7LX+WDmokMble3E47vWx0h+o01M7KOaBXLUUfpLXUEXQhgqImEYeQlrK
   3MHrBi4kFjxOf6OmA8JhDWZFY35GW4pEaP+eDjpHC/nHB7I//jVUDk/ue
   CwTu2W9Qgnh2H2lAcIuWylNUvxCAsnD99PGJF4stxsUy/F8+XFA5VgX6C
   n8SI+to8CAqXzmakI/WigZw7IayNGsEdwDF3RDKtDntzfIvDKLzoB9Sm7
   g==;
IronPort-SDR: SZaT0qaq8sLtl2n3IK8oojmfNiJMzLvxV3W1Ph6ZCHBcrHjT8THpLmazcFsEqwwWZncynPMQmQ
 WIv9Zn9Nwcb4tEs/KuoxLCzytX7yIdZlG6Vcj2eHV/JDYVPMBjSCWRjCxoUv4SzNh5Jk1WTeBr
 e/Vz82ra8R52KsaR8B2CZ5380pKt2W2thBUxKfbSmLEZ5ifszot7+zbhCdZXkRoQVzSicRbDt6
 2x4Zr2dXlmf+8Q7GKp2sqE+G9JSsS8SMj75JE2kZR+GLkd2budL35xf7Srt3Y+2/2WK8eMnaae
 pXg=
X-IronPort-AV: E=Sophos;i="5.63,479,1557158400"; 
   d="scan'208";a="112812805"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 12 Jul 2019 01:54:04 +0800
IronPort-SDR: 4VmuJ3YCcwVmJZ8wezX/9UebYvHE9vOM+EXiC4jJihLoYQR82jh52NFDpYU7uebuZK9lSw1EpF
 T+Ho/6jAClpSwjc8KG06bgvCRhNKbzvPi+DTXd/0T8D0Gi5iCxYkJ/iTUcqI4VXRFMQ01MrTb6
 d3Va9Kr/9f1K6K/TDz/E0Pz4hlN+9sBtWpG9iF7fMTi4/ZDOup6jvVy5hP0UD0yO6UC4nncm/q
 4ySxyf4dDt/NDBT74fkTTCStb9bnrUt/ETkxsVUQAjwDOAZcleZsSvgBWc+xl58+m1kWb+E6q9
 VNmv+qk3TNTGXqOmyzQL9V4f
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP; 11 Jul 2019 10:52:41 -0700
IronPort-SDR: 2mMyEIP42R8+9Ba9gJMRduVZWrGnRHYfzzwgFNSrSdnNySgR4bIeVVNAo1Bkczi8lm/epFHa15
 8q+LpnKyCVfmJHHErrk5Ist6bDh2Zy+/u3KkrMQ/cp3howCzLPnAMrqf2jIVTFZRESW2IRb9RD
 lPJRxFo/Yq+w57DynMASFLjdTGe6FhUcRSet4kiLPg2rOw2zA9NyYbGfxnDME6lFHmvnp5RXVs
 4IatW8z6k5HQZB/qsKJJXN3GXMunD6Pkh8whTW2XrNhxjt1rXAghNMbe8q/Yb9iHXUqIzMlsd7
 lNY=
Received: from cvenusqemu.hgst.com ([10.202.66.73])
  by uls-op-cesaip02.wdc.com with ESMTP; 11 Jul 2019 10:54:04 -0700
From:   Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To:     linux-block@vger.kernel.org
Cc:     axboe@kernel.dk, hch@lst.de,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [PATCH 3/8] null_blk: add support for write-zeroes
Date:   Thu, 11 Jul 2019 10:53:23 -0700
Message-Id: <20190711175328.16430-4-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190711175328.16430-1-chaitanya.kulkarni@wdc.com>
References: <20190711175328.16430-1-chaitanya.kulkarni@wdc.com>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This patch adds support to execute REQ_OP_WRITE_ZEROES operations on
the null_blk device when device is not memory-backed. Just like
REQ_OP_DISCARD we add a new module parameter to enable this support.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 drivers/block/null_blk_main.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/block/null_blk_main.c b/drivers/block/null_blk_main.c
index 20d60b951622..65da7c2d93b9 100644
--- a/drivers/block/null_blk_main.c
+++ b/drivers/block/null_blk_main.c
@@ -198,6 +198,10 @@ static bool g_discard;
 module_param_named(discard, g_discard, bool, 0444);
 MODULE_PARM_DESC(discard, "Allow REQ_OP_DISCARD processing. Default: false");
 
+static bool g_write_zeroes;
+module_param_named(write_zeroes, g_write_zeroes, bool, 0444);
+MODULE_PARM_DESC(write_zeroes, "Allow REQ_OP_WRITE_ZEROES processing. Default: false");
+
 static struct nullb_device *null_alloc_dev(void);
 static void null_free_dev(struct nullb_device *dev);
 static void null_del_dev(struct nullb *nullb);
@@ -535,7 +539,10 @@ static struct nullb_device *null_alloc_dev(void)
 	dev->zone_size = g_zone_size;
 	dev->zone_nr_conv = g_zone_nr_conv;
 	dev->discard = g_discard;
+	dev->write_zeroes = g_write_zeroes;
 	pr_info("discard : %s\n", dev->discard ? "TRUE" : "FALSE");
+	pr_info("write-zeroes : %s\n", dev->write_zeroes ? "TRUE" : "FALSE");
+
 	return dev;
 }
 
@@ -1419,6 +1426,13 @@ static void null_config_discard(struct nullb *nullb)
 	blk_queue_flag_set(QUEUE_FLAG_DISCARD, nullb->q);
 }
 
+static void null_config_write_zeroes(struct nullb *nullb)
+{
+	if (nullb->dev->write_zeroes == false)
+		return;
+	blk_queue_max_write_zeroes_sectors(nullb->q, UINT_MAX >> SECTOR_SHIFT);
+}
+
 static int null_open(struct block_device *bdev, fmode_t mode)
 {
 	return 0;
@@ -1710,6 +1724,7 @@ static int null_add_dev(struct nullb_device *dev)
 	blk_queue_physical_block_size(nullb->q, dev->blocksize);
 
 	null_config_discard(nullb);
+	null_config_write_zeroes(nullb);
 
 	sprintf(nullb->disk_name, "nullb%d", nullb->index);
 
-- 
2.17.0

