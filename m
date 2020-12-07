Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40BF6C433FE
	for <linux-block@archiver.kernel.org>; Mon,  7 Dec 2020 14:55:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F36DB23602
	for <linux-block@archiver.kernel.org>; Mon,  7 Dec 2020 14:55:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725804AbgLGOza (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 7 Dec 2020 09:55:30 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:37469 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725772AbgLGOza (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 7 Dec 2020 09:55:30 -0500
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1kmHuZ-0005Ri-6i; Mon, 07 Dec 2020 14:54:47 +0000
From:   Colin King <colin.king@canonical.com>
To:     Danil Kipnis <danil.kipnis@cloud.ionos.com>,
        Jack Wang <jinpu.wang@cloud.ionos.com>,
        Jens Axboe <axboe@kernel.dk>, Jason Gunthorpe <jgg@ziepe.ca>,
        Bart Van Assche <bvanassche@acm.org>,
        linux-block@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] block/rnbd: fix a null pointer dereference on dev->blk_symlink_name
Date:   Mon,  7 Dec 2020 14:54:46 +0000
Message-Id: <20201207145446.169978-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Currently in the case where dev->blk_symlink_name fails to be allocates
the error return path attempts to set an end-of-string character to
the unallocated dev->blk_symlink_name causing a null pointer dereference
error. Fix this by returning with an explicity ENOMEM error (which also
is missing in the original code as was not initialized).

Addresses-Coverity: ("Dereference after null check")
Fixes: 1eb54f8f5dd8 ("block/rnbd: client: sysfs interface functions")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/block/rnbd/rnbd-clt-sysfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/rnbd/rnbd-clt-sysfs.c b/drivers/block/rnbd/rnbd-clt-sysfs.c
index c3c96a567568..a7caeedeb198 100644
--- a/drivers/block/rnbd/rnbd-clt-sysfs.c
+++ b/drivers/block/rnbd/rnbd-clt-sysfs.c
@@ -499,7 +499,7 @@ static int rnbd_clt_add_dev_symlink(struct rnbd_clt_dev *dev)
 	dev->blk_symlink_name = kzalloc(len, GFP_KERNEL);
 	if (!dev->blk_symlink_name) {
 		rnbd_clt_err(dev, "Failed to allocate memory for blk_symlink_name\n");
-		goto out_err;
+		return -ENOMEM;
 	}
 
 	ret = rnbd_clt_get_path_name(dev, dev->blk_symlink_name,
-- 
2.29.2

