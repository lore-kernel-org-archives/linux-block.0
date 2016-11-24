Return-Path: <linux-block-owner@vger.kernel.org>
Received: from userp1040.oracle.com ([156.151.31.81]:33152 "EHLO
        userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964981AbcKXLfB (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 24 Nov 2016 06:35:01 -0500
Date: Thu, 24 Nov 2016 14:34:07 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: linux-block@vger.kernel.org, Jens Axboe <axboe@fb.com>
Cc: kernel-janitors@vger.kernel.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [patch] swim3: remove some dead code
Message-ID: <20161124112817.GO17225@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

The goto is correct.  "rc" is already set to -EBUSY so there is no need
to do anything with that.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

diff --git a/drivers/block/swim3.c b/drivers/block/swim3.c
index c264f2d..59b4a41 100644
--- a/drivers/block/swim3.c
+++ b/drivers/block/swim3.c
@@ -1179,7 +1179,6 @@ static int swim3_add_device(struct macio_dev *mdev, int index)
 		swim3_err("%s", "Couldn't request interrupt\n");
 		pmac_call_feature(PMAC_FTR_SWIM3_ENABLE, swim, 0, 0);
 		goto out_unmap;
-		return -EBUSY;
 	}
 
 	init_timer(&fs->timeout);
