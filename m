Return-Path: <SRS0=9Hvz=O5=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86C21C43387
	for <linux-block@archiver.kernel.org>; Thu, 20 Dec 2018 16:40:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C43B21773
	for <linux-block@archiver.kernel.org>; Thu, 20 Dec 2018 16:40:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730566AbeLTQjj (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 20 Dec 2018 11:39:39 -0500
Received: from mail09.linbit.com ([212.69.161.110]:50125 "EHLO
        mail09.linbit.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729140AbeLTQji (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 20 Dec 2018 11:39:38 -0500
Received: from soda.linbit (212-186-191-219.static.upcbusiness.at [212.186.191.219])
        by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 7DF341045C34;
        Thu, 20 Dec 2018 17:23:49 +0100 (CET)
From:   Lars Ellenberg <lars.ellenberg@linbit.com>
To:     Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org
Cc:     drbd-dev@lists.linbit.com
Subject: [PATCH 13/17] drbd: don't retry connection if peers do not agree on "authentication" settings
Date:   Thu, 20 Dec 2018 17:23:40 +0100
Message-Id: <20181220162344.8430-14-lars.ellenberg@linbit.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181220162344.8430-1-lars.ellenberg@linbit.com>
References: <20181220162344.8430-1-lars.ellenberg@linbit.com>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

emma: "Unexpected data packet AuthChallenge (0x0010)"
 ava: "expected AuthChallenge packet, received: ReportProtocol (0x000b)"
      "Authentication of peer failed, trying again."

Pattern repeats.

There is no point in retrying the handshake,
if we expect to receive an AuthChallenge,
but the peer is not even configured to expect or use a shared secret.

Signed-off-by: Lars Ellenberg <lars.ellenberg@linbit.com>
---
 drivers/block/drbd/drbd_receiver.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/drbd/drbd_receiver.c b/drivers/block/drbd/drbd_receiver.c
index 3a0fe357b68b..02a327891568 100644
--- a/drivers/block/drbd/drbd_receiver.c
+++ b/drivers/block/drbd/drbd_receiver.c
@@ -5332,7 +5332,7 @@ static int drbd_do_auth(struct drbd_connection *connection)
 	if (pi.cmd != P_AUTH_CHALLENGE) {
 		drbd_err(connection, "expected AuthChallenge packet, received: %s (0x%04x)\n",
 			 cmdname(pi.cmd), pi.cmd);
-		rv = 0;
+		rv = -1;
 		goto fail;
 	}
 
-- 
2.17.1

