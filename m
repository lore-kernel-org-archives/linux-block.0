Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEDBCC43334
	for <linux-block@archiver.kernel.org>; Mon, 20 Jun 2022 03:50:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235340AbiFTDuF (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 19 Jun 2022 23:50:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235695AbiFTDuE (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 19 Jun 2022 23:50:04 -0400
Received: from out0.migadu.com (out0.migadu.com [IPv6:2001:41d0:2:267::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42520BC96
        for <linux-block@vger.kernel.org>; Sun, 19 Jun 2022 20:50:03 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1655697001;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cipyu60grgI3kGNsxlSxVjtkJHu2UegdtFeofUVLNKc=;
        b=oGJSD8r+1I0UH+liEUkn2N6aHc00PbO8fjnmXgSMlL8pUpzkzu0tI/lOF3jv0i1dwIS0jW
        mVELwoOX2cUhXcn+ArrZeKzSa7lxJ9sxkxmCyEzc95wOUu+rrZpmEQH6n4m8r+DLPUU1s/
        iFWKp2yr2m2jZj/gJf9Zhhq0udGNH28=
From:   Guoqing Jiang <guoqing.jiang@linux.dev>
To:     haris.iqbal@ionos.com, jinpu.wang@ionos.com, axboe@kernel.dk
Cc:     linux-block@vger.kernel.org
Subject: [RFC PATCH 3/6] rnbd-clt: kill read_only from struct rnbd_clt_dev
Date:   Mon, 20 Jun 2022 11:49:20 +0800
Message-Id: <20220620034923.35633-4-guoqing.jiang@linux.dev>
In-Reply-To: <20220620034923.35633-1-guoqing.jiang@linux.dev>
References: <20220620034923.35633-1-guoqing.jiang@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The member is not needed since we can call get_disk_ro to achieve the
same goal.

Signed-off-by: Guoqing Jiang <guoqing.jiang@linux.dev>
---
 drivers/block/rnbd/rnbd-clt.c | 8 ++------
 drivers/block/rnbd/rnbd-clt.h | 1 -
 2 files changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/block/rnbd/rnbd-clt.c b/drivers/block/rnbd/rnbd-clt.c
index 6c4970878d23..0bade2680eb9 100644
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

