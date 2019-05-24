Return-Path: <SRS0=cawq=TY=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29CFDC072B5
	for <linux-block@archiver.kernel.org>; Fri, 24 May 2019 09:55:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBAEE21773
	for <linux-block@archiver.kernel.org>; Fri, 24 May 2019 09:55:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390098AbfEXJzo (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 24 May 2019 05:55:44 -0400
Received: from m9784.mail.qiye.163.com ([220.181.97.84]:30532 "EHLO
        m9784.mail.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389911AbfEXJzn (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 24 May 2019 05:55:43 -0400
X-Greylist: delayed 458 seconds by postgrey-1.27 at vger.kernel.org; Fri, 24 May 2019 05:55:42 EDT
Received: from kernel_test2.localdomain (unknown [120.132.1.243])
        by m9784.mail.qiye.163.com (Hmail) with ESMTPA id 1AA2E41CAB;
        Fri, 24 May 2019 17:48:52 +0800 (CST)
From:   Yao Liu <yotta.liu@ucloud.cn>
To:     Josef Bacik <josef@toxicpanda.com>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, nbd@other.debian.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] nbd: mark sock as dead even if it's the last one
Date:   Fri, 24 May 2019 17:43:56 +0800
Message-Id: <1558691036-16281-3-git-send-email-yotta.liu@ucloud.cn>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1558691036-16281-1-git-send-email-yotta.liu@ucloud.cn>
References: <1558691036-16281-1-git-send-email-yotta.liu@ucloud.cn>
X-HM-Spam-Status: e1kIGBQJHllBWVZKVUpLSUJCQkNLTU9LT0pKWVdZKFlBSUI3V1ktWUFJV1
        kJDhceCFlBWTU0KTY6NyQpLjc#WQY+
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6PBQ6Lhw*NDg0FCw2ITdNDyxN
        EjpPC0xVSlVKTk5DTUJKSEhJSENDVTMWGhIXVQIUDw8aVRcSDjsOGBcUDh9VGBVFWVdZEgtZQVlK
        SUtVSkhJVUpVSU9IWVdZCAFZQUlKQ083Bg++
X-HM-Tid: 0a6ae93e40cc2086kuqy1aa2e41cab
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

When sock dead, nbd_read_stat should return a ERR_PTR and then we should
mark sock as dead and wait for a reconnection if the dead sock is the last
one, because nbd_xmit_timeout won't resubmit while num_connections <= 1.

Signed-off-by: Yao Liu <yotta.liu@ucloud.cn>
---
 drivers/block/nbd.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index 22e86f4..a557a83 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -716,15 +716,7 @@ static struct nbd_cmd *nbd_read_stat(struct nbd_device *nbd, int index)
 			if (result <= 0) {
 				dev_err(disk_to_dev(nbd->disk), "Receive data failed (result %d)\n",
 					result);
-				/*
-				 * If we've disconnected or we only have 1
-				 * connection then we need to make sure we
-				 * complete this request, otherwise error out
-				 * and let the timeout stuff handle resubmitting
-				 * this request onto another connection.
-				 */
-				if (nbd_disconnected(config) ||
-				    config->num_connections <= 1) {
+				if (nbd_disconnected(config)) {
 					cmd->status = BLK_STS_IOERR;
 					goto out;
 				}
-- 
1.8.3.1

