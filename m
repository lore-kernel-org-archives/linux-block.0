Return-Path: <SRS0=cawq=TY=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4D23C072B5
	for <linux-block@archiver.kernel.org>; Fri, 24 May 2019 09:55:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8677521773
	for <linux-block@archiver.kernel.org>; Fri, 24 May 2019 09:55:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390156AbfEXJzo (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 24 May 2019 05:55:44 -0400
Received: from m9784.mail.qiye.163.com ([220.181.97.84]:30680 "EHLO
        m9784.mail.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390046AbfEXJzo (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 24 May 2019 05:55:44 -0400
Received: from kernel_test2.localdomain (unknown [120.132.1.243])
        by m9784.mail.qiye.163.com (Hmail) with ESMTPA id D2F2B41C01;
        Fri, 24 May 2019 17:48:47 +0800 (CST)
From:   Yao Liu <yotta.liu@ucloud.cn>
To:     Josef Bacik <josef@toxicpanda.com>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, nbd@other.debian.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] nbd: notify userland even if nbd has already disconnected
Date:   Fri, 24 May 2019 17:43:55 +0800
Message-Id: <1558691036-16281-2-git-send-email-yotta.liu@ucloud.cn>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1558691036-16281-1-git-send-email-yotta.liu@ucloud.cn>
References: <1558691036-16281-1-git-send-email-yotta.liu@ucloud.cn>
X-HM-Spam-Status: e1kIGBQJHllBWVZKVUJNSktLS0lLT0tDTUhZV1koWUFJQjdXWS1ZQUlXWQ
        kOFx4IWUFZNTQpNjo3JCkuNz5ZBg++
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Ngg6EAw6Qjg6NiwQMTdODzw*
        VgwwCg5VSlVKTk5DTUJKSElDSkhDVTMWGhIXVQIUDw8aVRcSDjsOGBcUDh9VGBVFWVdZEgtZQVlK
        SUtVSkhJVUpVSU9IWVdZCAFZQUlKS0I3Bg++
X-HM-Tid: 0a6ae93e302f2086kuqyd2f2b41c01
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Some nbd client implementations have a userland's daemon, so we should
inform client daemon to clean up and exit.

Signed-off-by: Yao Liu <yotta.liu@ucloud.cn>
---
 drivers/block/nbd.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index ca69d6e..22e86f4 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -246,7 +246,7 @@ static int nbd_disconnected(struct nbd_config *config)
 static void nbd_mark_nsock_dead(struct nbd_device *nbd, struct nbd_sock *nsock,
 				int notify)
 {
-	if (!nsock->dead && notify && !nbd_disconnected(nbd->config)) {
+	if (!nsock->dead && notify) {
 		struct link_dead_args *args;
 		args = kmalloc(sizeof(struct link_dead_args), GFP_NOIO);
 		if (args) {
@@ -1891,7 +1891,6 @@ static void nbd_disconnect_and_put(struct nbd_device *nbd)
 {
 	mutex_lock(&nbd->config_lock);
 	nbd_disconnect(nbd);
-	nbd_clear_sock(nbd);
 	mutex_unlock(&nbd->config_lock);
 	if (test_and_clear_bit(NBD_HAS_CONFIG_REF,
 			       &nbd->config->runtime_flags))
-- 
1.8.3.1

