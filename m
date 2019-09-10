Return-Path: <SRS0=q0Gp=XF=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02E41C3A5A2
	for <linux-block@archiver.kernel.org>; Tue, 10 Sep 2019 06:36:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1B2120872
	for <linux-block@archiver.kernel.org>; Tue, 10 Sep 2019 06:36:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393542AbfIJGgO (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 10 Sep 2019 02:36:14 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35236 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2393539AbfIJGgO (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 10 Sep 2019 02:36:14 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 0DA828D65DF;
        Tue, 10 Sep 2019 06:36:14 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.70.39.226])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DD6466012A;
        Tue, 10 Sep 2019 06:36:11 +0000 (UTC)
From:   xiubli@redhat.com
To:     josef@toxicpanda.com, axboe@kernel.dk
Cc:     mchristi@redhat.com, linux-block@vger.kernel.org,
        Xiubo Li <xiubli@redhat.com>
Subject: [PATCH] nbd: remove the duplicated code
Date:   Tue, 10 Sep 2019 12:06:08 +0530
Message-Id: <20190910063608.10081-1-xiubli@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.69]); Tue, 10 Sep 2019 06:36:14 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Xiubo Li <xiubli@redhat.com>

The followed code will do the same check, and this part is redandant.

Signed-off-by: Xiubo Li <xiubli@redhat.com>
---
 drivers/block/nbd.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index 478aa86fc1f2..8c10ab51a086 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -1046,9 +1046,6 @@ static int nbd_reconnect_socket(struct nbd_device *nbd, unsigned long arg)
 	for (i = 0; i < config->num_connections; i++) {
 		struct nbd_sock *nsock = config->socks[i];
 
-		if (!nsock->dead)
-			continue;
-
 		mutex_lock(&nsock->tx_lock);
 		if (!nsock->dead) {
 			mutex_unlock(&nsock->tx_lock);
-- 
2.21.0

