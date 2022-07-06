Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B129C433EF
	for <linux-block@archiver.kernel.org>; Wed,  6 Jul 2022 13:32:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233387AbiGFNcG (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 6 Jul 2022 09:32:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233353AbiGFNcE (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 6 Jul 2022 09:32:04 -0400
Received: from out1.migadu.com (out1.migadu.com [IPv6:2001:41d0:2:863f::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85727240B0
        for <linux-block@vger.kernel.org>; Wed,  6 Jul 2022 06:32:03 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1657114322;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Tl7Mo99YOAlo+TEKwF1XWB4mERBuWlGTwJusKIPIeyU=;
        b=gF3RZD9Nbxo63BgKaajdSMihjmVYkDzUwR/iuNxWbNhfArSY3VPnmYiXyiZRMvY+tU/bid
        werOHczKIF595kIPCfoHYL60U8pGW6aBNkJofmy07Dn7fu96KUF5ceEycEkHh7hQJpw+8T
        VQpYjQUFNQzRIGPJ0/0y7PadmjoFJxY=
From:   Guoqing Jiang <guoqing.jiang@linux.dev>
To:     axboe@kernel.dk
Cc:     haris.iqbal@ionos.com, jinpu.wang@ionos.com,
        linux-block@vger.kernel.org
Subject: [PATCH V2 3/8] rnbd-clt: kill read_only from struct rnbd_clt_dev
Date:   Wed,  6 Jul 2022 21:31:47 +0800
Message-Id: <20220706133152.12058-4-guoqing.jiang@linux.dev>
In-Reply-To: <20220706133152.12058-1-guoqing.jiang@linux.dev>
References: <20220706133152.12058-1-guoqing.jiang@linux.dev>
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
index 9e0521a733c3..e01d37e4285d 100644
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
2.31.1

