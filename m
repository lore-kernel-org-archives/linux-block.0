Return-Path: <SRS0=9Hvz=O5=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5926C43387
	for <linux-block@archiver.kernel.org>; Thu, 20 Dec 2018 16:39:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 762C521773
	for <linux-block@archiver.kernel.org>; Thu, 20 Dec 2018 16:39:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729004AbeLTQji (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 20 Dec 2018 11:39:38 -0500
Received: from mail09.linbit.com ([212.69.161.110]:50122 "EHLO
        mail09.linbit.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729103AbeLTQjh (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 20 Dec 2018 11:39:37 -0500
Received: from soda.linbit (212-186-191-219.static.upcbusiness.at [212.186.191.219])
        by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id B6A2C1045C32;
        Thu, 20 Dec 2018 17:23:48 +0100 (CET)
From:   Lars Ellenberg <lars.ellenberg@linbit.com>
To:     Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org
Cc:     drbd-dev@lists.linbit.com
Subject: [PATCH 11/17] drbd: avoid spurious self-outdating with concurrent disconnect / down
Date:   Thu, 20 Dec 2018 17:23:38 +0100
Message-Id: <20181220162344.8430-12-lars.ellenberg@linbit.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181220162344.8430-1-lars.ellenberg@linbit.com>
References: <20181220162344.8430-1-lars.ellenberg@linbit.com>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

If peers are "simultaneously" told to disconnect from each other,
either explicitly, or implicitly by taking down the resource,
with bad timing, one side may see its disconnect "fail" with
a result of "state change failed by peer", and interpret this as
"please oudate yourself".

Try to catch this by checking for current connection status,
and possibly retry as local-only state change instead.

Signed-off-by: Lars Ellenberg <lars.ellenberg@linbit.com>
---
 drivers/block/drbd/drbd_nl.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/block/drbd/drbd_nl.c b/drivers/block/drbd/drbd_nl.c
index 1958eb33b643..82915880c5e9 100644
--- a/drivers/block/drbd/drbd_nl.c
+++ b/drivers/block/drbd/drbd_nl.c
@@ -2711,8 +2711,10 @@ int drbd_adm_connect(struct sk_buff *skb, struct genl_info *info)
 
 static enum drbd_state_rv conn_try_disconnect(struct drbd_connection *connection, bool force)
 {
+	enum drbd_conns cstate;
 	enum drbd_state_rv rv;
 
+repeat:
 	rv = conn_request_state(connection, NS(conn, C_DISCONNECTING),
 			force ? CS_HARD : 0);
 
@@ -2730,6 +2732,11 @@ static enum drbd_state_rv conn_try_disconnect(struct drbd_connection *connection
 
 		break;
 	case SS_CW_FAILED_BY_PEER:
+		spin_lock_irq(&connection->resource->req_lock);
+		cstate = connection->cstate;
+		spin_unlock_irq(&connection->resource->req_lock);
+		if (cstate <= C_WF_CONNECTION)
+			goto repeat;
 		/* The peer probably wants to see us outdated. */
 		rv = conn_request_state(connection, NS2(conn, C_DISCONNECTING,
 							disk, D_OUTDATED), 0);
-- 
2.17.1

