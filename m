Return-Path: <SRS0=iom0=XP=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39F40C3A5A2
	for <linux-block@archiver.kernel.org>; Fri, 20 Sep 2019 16:07:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FA56206B6
	for <linux-block@archiver.kernel.org>; Fri, 20 Sep 2019 16:07:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389583AbfITQHI (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 20 Sep 2019 12:07:08 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56666 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387662AbfITQHI (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 20 Sep 2019 12:07:08 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 51824315C005;
        Fri, 20 Sep 2019 16:07:08 +0000 (UTC)
Received: from asgard.redhat.com (ovpn-112-68.ams2.redhat.com [10.36.112.68])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 61C7B600C6;
        Fri, 20 Sep 2019 16:07:06 +0000 (UTC)
Date:   Fri, 20 Sep 2019 18:06:44 +0200
From:   Eugene Syromiatnikov <esyr@redhat.com>
To:     linux-block@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>,
        nbd@other.debian.org
Cc:     linux-kernel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH RESEND] nbd: avoid losing pointer to reallocated
 config->socks in nbd_add_socket
Message-ID: <20190920160644.GA15739@asgard.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.41]); Fri, 20 Sep 2019 16:07:08 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

In the (very unlikely) case of config->socks reallocation success
and nsock allocation failure config->nsock will not get updated
with the new pointer to socks array. Fix it by updating config->socks
right after reallocation successfulness check.

Fixes: 9561a7ade0c2 ("nbd: add multi-connection support")
Signed-off-by: Eugene Syromiatnikov <esyr@redhat.com>
Cc: stable@vger.kernel.org # 4.10+
---
 drivers/block/nbd.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index a8e3815..a04c686 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -987,14 +987,14 @@ static int nbd_add_socket(struct nbd_device *nbd, unsigned long arg,
 		sockfd_put(sock);
 		return -ENOMEM;
 	}
+	config->socks = socks;
+
 	nsock = kzalloc(sizeof(struct nbd_sock), GFP_KERNEL);
 	if (!nsock) {
 		sockfd_put(sock);
 		return -ENOMEM;
 	}
 
-	config->socks = socks;
-
 	nsock->fallback_index = -1;
 	nsock->dead = false;
 	mutex_init(&nsock->tx_lock);
-- 
2.1.4

