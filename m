Return-Path: <SRS0=YK6u=OP=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C17F3C67838
	for <linux-block@archiver.kernel.org>; Thu,  6 Dec 2018 16:48:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 855AB20838
	for <linux-block@archiver.kernel.org>; Thu,  6 Dec 2018 16:48:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 855AB20838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726326AbeLFQs0 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 6 Dec 2018 11:48:26 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:44127 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726331AbeLFQsZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 6 Dec 2018 11:48:25 -0500
Received: from [191.13.27.189] (helo=calabresa.spo.virtua.com.br)
        by youngberry.canonical.com with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <cascardo@canonical.com>)
        id 1gUwp6-0000io-2w; Thu, 06 Dec 2018 16:48:24 +0000
From:   Thadeu Lima de Souza Cascardo <cascardo@canonical.com>
To:     linux-nvme@lists.infradead.org
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Jens Axboe <axboe@fb.com>
Subject: [PATCH 3/4] nvme: Should not warn when a disk path is opened
Date:   Thu,  6 Dec 2018 14:48:11 -0200
Message-Id: <20181206164812.30925-4-cascardo@canonical.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181206164812.30925-1-cascardo@canonical.com>
References: <20181206164812.30925-1-cascardo@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

As we hide the disks used for nvme multipath, their open functions
should be allowed to be called, as their devices are not exposed.

However, not exposing the devices cause problems with lsblk, which won't
find the devices and show them, which is even more of a problem when
holders/slaves relationships are exposed.

Not warning here allow us to expose the disks without creating spurious
warnings. A failure should still be returned, which is the case here,
and still allows lsblk to work.

Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@canonical.com>
---
 drivers/nvme/host/core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 1dc29795f1ee..22424b2adfad 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1327,8 +1327,8 @@ static int nvme_open(struct block_device *bdev, fmode_t mode)
 	struct nvme_ns *ns = bdev->bd_disk->private_data;
 
 #ifdef CONFIG_NVME_MULTIPATH
-	/* should never be called due to GENHD_FL_HIDDEN */
-	if (WARN_ON_ONCE(ns->head->disk))
+	/* Should fail as it's hidden */
+	if (ns->head->disk)
 		goto fail;
 #endif
 	if (!kref_get_unless_zero(&ns->kref))
-- 
2.19.1

