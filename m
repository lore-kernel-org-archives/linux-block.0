Return-Path: <SRS0=i0oD=EB=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFDAAC388F9
	for <linux-block@archiver.kernel.org>; Mon, 26 Oct 2020 21:51:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B48C521655
	for <linux-block@archiver.kernel.org>; Mon, 26 Oct 2020 21:51:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1603749067;
	bh=f18+YYO36+VPphTtiqB2BItLkQXJGL58MdoL6F+07ws=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ojCXlIlDighz8r9zGwxGD+KIQQZ2d98CzD3e6deBUXtOO/PZuptYm+84l6v7FSwlV
	 sgaNTNiZIbrknjlm+o4CBLlGNPvhPViyP4ZURn8sGaGz79iX3Fn+wSSnEOBJdID/Rh
	 PrTNE+id/UKg38iCb1yziXO4sOwZCQ2IFNtmMBRE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390904AbgJZVvE (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 26 Oct 2020 17:51:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:51368 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390902AbgJZVvE (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 26 Oct 2020 17:51:04 -0400
Received: from localhost.localdomain (unknown [192.30.34.233])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1D396207E8;
        Mon, 26 Oct 2020 21:51:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603749063;
        bh=f18+YYO36+VPphTtiqB2BItLkQXJGL58MdoL6F+07ws=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=arg345ekDPB+aYgx7YEhAXpCXOxypeKaeML9Sk4wxNp2TKPUrXFcnxv1RB8ks2+BH
         eems8pMSm3vn4pcR3xmKraOxrUT4zePERaecUbGd4YRU64BDl48+lSwgLW5hSIEBX6
         TMPZ4znkbFJuR9ZeyVBTJUTCqdYvNmJdeMGYwhAE=
From:   Arnd Bergmann <arnd@kernel.org>
To:     Philipp Reisner <philipp.reisner@linbit.com>,
        Lars Ellenberg <lars.ellenberg@linbit.com>,
        Jens Axboe <axboe@kernel.dk>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Jan Kara <jack@suse.cz>, drbd-dev@lists.linbit.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] drbd: address enum mismatch warnings
Date:   Mon, 26 Oct 2020 22:50:34 +0100
Message-Id: <20201026215043.3893318-2-arnd@kernel.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20201026215043.3893318-1-arnd@kernel.org>
References: <20201026215043.3893318-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

gcc -Wextra warns about mixing drbd_state_rv with drbd_ret_code
in a couple of places:

drivers/block/drbd/drbd_nl.c: In function 'drbd_adm_set_role':
drivers/block/drbd/drbd_nl.c:777:14: warning: comparison between 'enum drbd_state_rv' and 'enum drbd_ret_code' [-Wenum-compare]
  777 |  if (retcode != NO_ERROR)
      |              ^~
drivers/block/drbd/drbd_nl.c:784:12: warning: implicit conversion from 'enum drbd_ret_code' to 'enum drbd_state_rv' [-Wenum-conversion]
  784 |    retcode = ERR_MANDATORY_TAG;
      |            ^
drivers/block/drbd/drbd_nl.c: In function 'drbd_adm_attach':
drivers/block/drbd/drbd_nl.c:1965:10: warning: implicit conversion from 'enum drbd_state_rv' to 'enum drbd_ret_code' [-Wenum-conversion]
 1965 |  retcode = rv;  /* FIXME: Type mismatch. */
      |          ^
drivers/block/drbd/drbd_nl.c: In function 'drbd_adm_connect':
drivers/block/drbd/drbd_nl.c:2690:10: warning: implicit conversion from 'enum drbd_state_rv' to 'enum drbd_ret_code' [-Wenum-conversion]
 2690 |  retcode = conn_request_state(connection, NS(conn, C_UNCONNECTED), CS_VERBOSE);
      |          ^
drivers/block/drbd/drbd_nl.c: In function 'drbd_adm_disconnect':
drivers/block/drbd/drbd_nl.c:2803:11: warning: implicit conversion from 'enum drbd_state_rv' to 'enum drbd_ret_code' [-Wenum-conversion]
 2803 |   retcode = rv;  /* FIXME: Type mismatch. */
      |           ^

In each case, both are passed into drbd_adm_finish(), which just takes
a 32-bit integer and is happy with either, presumably intentionally.

Restructure the code to pass either type directly in there in most
cases, avoiding the warnings.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/block/drbd/drbd_nl.c | 23 ++++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

diff --git a/drivers/block/drbd/drbd_nl.c b/drivers/block/drbd/drbd_nl.c
index bf7de4c7b96c..3d6995ee675b 100644
--- a/drivers/block/drbd/drbd_nl.c
+++ b/drivers/block/drbd/drbd_nl.c
@@ -770,6 +770,7 @@ int drbd_adm_set_role(struct sk_buff *skb, struct genl_info *info)
 	struct set_role_parms parms;
 	int err;
 	enum drbd_ret_code retcode;
+	enum drbd_state_rv rv;
 
 	retcode = drbd_adm_prepare(&adm_ctx, skb, info, DRBD_ADM_NEED_MINOR);
 	if (!adm_ctx.reply_skb)
@@ -790,12 +791,14 @@ int drbd_adm_set_role(struct sk_buff *skb, struct genl_info *info)
 	mutex_lock(&adm_ctx.resource->adm_mutex);
 
 	if (info->genlhdr->cmd == DRBD_ADM_PRIMARY)
-		retcode = drbd_set_role(adm_ctx.device, R_PRIMARY, parms.assume_uptodate);
+		rv = drbd_set_role(adm_ctx.device, R_PRIMARY, parms.assume_uptodate);
 	else
-		retcode = drbd_set_role(adm_ctx.device, R_SECONDARY, 0);
+		rv = drbd_set_role(adm_ctx.device, R_SECONDARY, 0);
 
 	mutex_unlock(&adm_ctx.resource->adm_mutex);
 	genl_lock();
+	drbd_adm_finish(&adm_ctx, info, rv);
+	return 0;
 out:
 	drbd_adm_finish(&adm_ctx, info, retcode);
 	return 0;
@@ -1962,7 +1965,7 @@ int drbd_adm_attach(struct sk_buff *skb, struct genl_info *info)
 	drbd_flush_workqueue(&connection->sender_work);
 
 	rv = _drbd_request_state(device, NS(disk, D_ATTACHING), CS_VERBOSE);
-	retcode = rv;  /* FIXME: Type mismatch. */
+	retcode = (enum drbd_ret_code)(int)rv;  /* FIXME: Type mismatch. */
 	drbd_resume_io(device);
 	if (rv < SS_SUCCESS)
 		goto fail;
@@ -2568,6 +2571,7 @@ int drbd_adm_connect(struct sk_buff *skb, struct genl_info *info)
 	struct drbd_resource *resource;
 	struct drbd_connection *connection;
 	enum drbd_ret_code retcode;
+	enum drbd_state_rv rv;
 	int i;
 	int err;
 
@@ -2687,11 +2691,11 @@ int drbd_adm_connect(struct sk_buff *skb, struct genl_info *info)
 	}
 	rcu_read_unlock();
 
-	retcode = conn_request_state(connection, NS(conn, C_UNCONNECTED), CS_VERBOSE);
+	rv = conn_request_state(connection, NS(conn, C_UNCONNECTED), CS_VERBOSE);
 
 	conn_reconfig_done(connection);
 	mutex_unlock(&adm_ctx.resource->adm_mutex);
-	drbd_adm_finish(&adm_ctx, info, retcode);
+	drbd_adm_finish(&adm_ctx, info, rv);
 	return 0;
 
 fail:
@@ -2799,11 +2803,12 @@ int drbd_adm_disconnect(struct sk_buff *skb, struct genl_info *info)
 
 	mutex_lock(&adm_ctx.resource->adm_mutex);
 	rv = conn_try_disconnect(connection, parms.force_disconnect);
-	if (rv < SS_SUCCESS)
-		retcode = rv;  /* FIXME: Type mismatch. */
-	else
-		retcode = NO_ERROR;
 	mutex_unlock(&adm_ctx.resource->adm_mutex);
+	if (rv < SS_SUCCESS) {
+		drbd_adm_finish(&adm_ctx, info, rv);
+		return 0;
+	}
+	retcode = NO_ERROR;
  fail:
 	drbd_adm_finish(&adm_ctx, info, retcode);
 	return 0;
-- 
2.27.0

