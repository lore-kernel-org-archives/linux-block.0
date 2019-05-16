Return-Path: <SRS0=mde3=TQ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84E8FC072AD
	for <linux-block@archiver.kernel.org>; Thu, 16 May 2019 01:48:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57EAF2089E
	for <linux-block@archiver.kernel.org>; Thu, 16 May 2019 01:48:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727497AbfEPBqc (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 15 May 2019 21:46:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34146 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726812AbfEPAiD (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 15 May 2019 20:38:03 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 916EA308623C;
        Thu, 16 May 2019 00:38:03 +0000 (UTC)
Received: from rh2.redhat.com (ovpn-121-189.rdu2.redhat.com [10.10.121.189])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E87BB1001E67;
        Thu, 16 May 2019 00:38:02 +0000 (UTC)
From:   Mike Christie <mchristi@redhat.com>
To:     josef@toxicpanda.com, linux-block@vger.kernel.org
Cc:     Mike Christie <mchristi@redhat.com>
Subject: [PATCH 1/1] nbd: add netlink reconfigure resize support
Date:   Wed, 15 May 2019 19:38:00 -0500
Message-Id: <20190516003800.28373-1-mchristi@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.42]); Thu, 16 May 2019 00:38:03 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

If the device is setup with ioctl we can resize the device after the
initial setup, but if the device is setup with netlink we cannot use the
resize related ioctls and there is no netlink reconfigure size ATTR
handling code.

This patch adds netlink reconfigure resize support to match the ioctl
interface.

Signed-off-by: Mike Christie <mchristi@redhat.com>
---
 drivers/block/nbd.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index 053958a8a2ba..68b9d4b2d1be 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -1939,6 +1939,15 @@ static int nbd_genl_reconfigure(struct sk_buff *skb, struct genl_info *info)
 		goto out;
 	}
 
+	if (info->attrs[NBD_ATTR_SIZE_BYTES]) {
+		u64 bytes = nla_get_u64(info->attrs[NBD_ATTR_SIZE_BYTES]);
+		nbd_size_set(nbd, config->blksize,
+			     div64_u64(bytes, config->blksize));
+	}
+	if (info->attrs[NBD_ATTR_BLOCK_SIZE_BYTES]) {
+		u64 bsize = nla_get_u64(info->attrs[NBD_ATTR_BLOCK_SIZE_BYTES]);
+		nbd_size_set(nbd, bsize, div64_u64(config->bytesize, bsize));
+	}
 	if (info->attrs[NBD_ATTR_TIMEOUT]) {
 		u64 timeout = nla_get_u64(info->attrs[NBD_ATTR_TIMEOUT]);
 		nbd->tag_set.timeout = timeout * HZ;
-- 
2.21.0

