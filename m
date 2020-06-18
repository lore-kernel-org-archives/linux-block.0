Return-Path: <SRS0=/Row=77=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64A01C433DF
	for <linux-block@archiver.kernel.org>; Thu, 18 Jun 2020 21:02:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4D4C420CC7
	for <linux-block@archiver.kernel.org>; Thu, 18 Jun 2020 21:02:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728718AbgFRVCu (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 18 Jun 2020 17:02:50 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:37765 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727982AbgFRVCu (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 18 Jun 2020 17:02:50 -0400
Received: from [189.110.235.168] (helo=localhost.localdomain)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <cascardo@canonical.com>)
        id 1jm1gM-00073w-EZ; Thu, 18 Jun 2020 21:02:46 +0000
From:   Thadeu Lima de Souza Cascardo <cascardo@canonical.com>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        nbd@other.debian.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, cascardo@canonical.com
Subject: [PATCH] nbd: allocate sufficient space for NBD_CMD_STATUS
Date:   Thu, 18 Jun 2020 18:02:39 -0300
Message-Id: <20200618210240.157566-1-cascardo@canonical.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The nest attribute NBD_ATTR_DEVICE_LIST was not accounted for when
allocating the message, resulting in -EMSGSIZE.

As __alloc_skb aligns size requests to SMP_CACHE_BYTES and SLUB will end up
allocating more than requested, this can hardly be reproduced on most
setups.

However, I managed to test this on a 32-bit x86 with 15 entries, by loading
with nbds_max=15. It failed with -EMSGSIZE, while it worked with 14 or 16
entries.

Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@canonical.com>
---
 drivers/block/nbd.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index 43cff01a5a67..19551d8ca355 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -2265,6 +2265,7 @@ static int nbd_genl_status(struct sk_buff *skb, struct genl_info *info)
 	msg_size = nla_total_size(nla_attr_size(sizeof(u32)) +
 				  nla_attr_size(sizeof(u8)));
 	msg_size *= (index == -1) ? nbd_total_devices : 1;
+	msg_size += nla_total_size(0); /* for NBD_ATTR_DEVICE_LIST */
 
 	reply = genlmsg_new(msg_size, GFP_KERNEL);
 	if (!reply)
-- 
2.25.1

