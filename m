Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66DD9C43334
	for <linux-block@archiver.kernel.org>; Thu, 23 Jun 2022 06:22:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229881AbiFWGWJ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 23 Jun 2022 02:22:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229939AbiFWGV5 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 23 Jun 2022 02:21:57 -0400
Received: from out2.migadu.com (out2.migadu.com [188.165.223.204])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E76F3A1A7
        for <linux-block@vger.kernel.org>; Wed, 22 Jun 2022 23:21:53 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1655965311;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=avAzSxPMT7btn1FaLTKOLWeDIcL1SJ0fTt4C9zrJFyc=;
        b=r43v2g5GtlPx9NsQLbJzQWmjAPU0hU9sPTLF+dbbvyJBaNtU0egK+qrAchWdKF+x4+QXq9
        90+7ra1BNq1Kpt1+dOcypGTHkaS1968mqSj1QarPym3MpQgt1owjgCb2Eq/PAGW1LDijT2
        jaWC9Q2zXyClCfdikRBiOmbUZn0BAZI=
From:   Guoqing Jiang <guoqing.jiang@linux.dev>
To:     haris.iqbal@ionos.com, jinpu.wang@ionos.com, axboe@kernel.dk
Cc:     linux-block@vger.kernel.org
Subject: [PATCH V1 3/8] rnbd-clt: kill read_only from struct rnbd_clt_dev
Date:   Thu, 23 Jun 2022 14:21:11 +0800
Message-Id: <20220623062116.15976-4-guoqing.jiang@linux.dev>
In-Reply-To: <20220623062116.15976-1-guoqing.jiang@linux.dev>
References: <20220623062116.15976-1-guoqing.jiang@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The member is not needed since we can call get_disk_ro to achieve the
same goal.

Acked-by: Jack Wang <jinpu.wang@ionos.com>
Signed-off-by: Guoqing Jiang <guoqing.jiang@linux.dev>
---
 drivers/block/rnbd/rnbd-clt.c | 8 ++------
 drivers/block/rnbd/rnbd-clt.h | 1 -
 2 files changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/block/rnbd/rnbd-clt.c b/drivers/block/rnbd/rnbd-clt.c
index ef3e561faf61..0e93e529dd82 100644
--- a/drivers/block/rnbd/rnbd-clt.c
+++ b/drivers/block/rnbd/rnbd-clt.c
@@ -949,7 +949,7 @@ static int rnbd_client_open(struct block_device *block_device, fmode_t mode)
 {
 	struct rnbd_clt_dev *dev = block_device->bd_disk->private_data;
 
-	if (dev->read_only && (mode & FMODE_WRITE))
+	if (get_disk_ro(dev->gd) && (mode & FMODE_WRITE))
 		return -EPERM;
 
 	if (dev->dev_state == DEV_STATE_UNMAPPED ||
@@ -1402,12 +1402,8 @@ static int rnbd_clt_setup_gen_disk(struct rnbd_clt_dev *dev, int idx)
 
 	set_capacity(dev->gd, dev->nsectors);
 
-	if (dev->access_mode == RNBD_ACCESS_RO) {
-		dev->read_only = true;
+	if (dev->access_mode == RNBD_ACCESS_RO)
 		set_disk_ro(dev->gd, true);
-	} else {
-		dev->read_only = false;
-	}
 
 	/*
 	 * Network device does not need rotational
diff --git a/drivers/block/rnbd/rnbd-clt.h b/drivers/block/rnbd/rnbd-clt.h
index 2e2e8c4a85c1..26fb91d800e3 100644
--- a/drivers/block/rnbd/rnbd-clt.h
+++ b/drivers/block/rnbd/rnbd-clt.h
@@ -117,7 +117,6 @@ struct rnbd_clt_dev {
 	char			*pathname;
 	enum rnbd_access_mode	access_mode;
 	u32			nr_poll_queues;
-	bool			read_only;
 	bool			wc;
 	bool			fua;
 	u32			max_hw_sectors;
-- 
2.34.1

