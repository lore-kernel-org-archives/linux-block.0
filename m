Return-Path: <SRS0=FTzM=TI=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4823EC04A6B
	for <linux-block@archiver.kernel.org>; Wed,  8 May 2019 22:02:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DBD52173B
	for <linux-block@archiver.kernel.org>; Wed,  8 May 2019 22:02:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728648AbfEHWCL (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 8 May 2019 18:02:11 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:53933 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726837AbfEHWCL (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 8 May 2019 18:02:11 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1hOUdc-0007yV-Eg; Wed, 08 May 2019 22:02:08 +0000
From:   Colin King <colin.king@canonical.com>
To:     Josef Bacik <josef@toxicpanda.com>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org, nbd@other.debian.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] nbd: add null check on dev_list to avoid potential null pointer dereference
Date:   Wed,  8 May 2019 23:02:08 +0100
Message-Id: <20190508220208.26146-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

The call to nla_nest_start_noflag can return a null pointer and currently
this is not being checked and this can lead to a null pointer dereference
when the null pointer dev_list is passed to function nla_nest_end. Fix
this by adding in a null pointer check.

Addresses-Coverity: ("Dereference null return value")
Fixes: 47d902b90a32 ("nbd: add a status netlink command")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/block/nbd.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index 053958a8a2ba..ed263963e778 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -2117,6 +2117,10 @@ static int nbd_genl_status(struct sk_buff *skb, struct genl_info *info)
 	}
 
 	dev_list = nla_nest_start_noflag(reply, NBD_ATTR_DEVICE_LIST);
+	if (!dev_list) {
+		nlmsg_free(reply);
+		goto out;
+	}
 	if (index == -1) {
 		ret = idr_for_each(&nbd_index_idr, &status_cb, reply);
 		if (ret) {
-- 
2.20.1

