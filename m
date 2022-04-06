Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C93DBC433F5
	for <linux-block@archiver.kernel.org>; Wed,  6 Apr 2022 20:49:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229539AbiDFUvu (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 6 Apr 2022 16:51:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229840AbiDFUve (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 6 Apr 2022 16:51:34 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17EC02FF588
        for <linux-block@vger.kernel.org>; Wed,  6 Apr 2022 12:07:34 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id ot30so6169567ejb.12
        for <linux-block@vger.kernel.org>; Wed, 06 Apr 2022 12:07:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linbit-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=c/zihez/h+mzXfDfKYfT6QVLBkQq8Rn6YB77YCPC8z0=;
        b=vB0aQHaGkI3teNHscNCb9ZmZXWEHRU+XumY9K6E9fOqNCVDebbIZFBygMSg425zqKV
         vdNgtKhGaiH/WSzEKdWbJU/69wMElpiqe3z3skLzQ8GWjHSVxjVBt9CzxklRuW1tNyPi
         iRmKFWpsIerNIOwQ53m9IM6+rwjRNTHDGwLkRPbhYjDYl71MARSx7UhaeWILT0KB0IJX
         Pq/jFCj+Gruco/niVvr75/9vgPTxFteWDGVDi3JbHIrGDi0ow/EoDv7u+TSbglue828y
         GzrN9R/pvt1SHeEg0LbcRSSPptGZnYMtxXCe3rqVlFaXKkESgYidWE+ctAbXVlxInWZU
         nDTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=c/zihez/h+mzXfDfKYfT6QVLBkQq8Rn6YB77YCPC8z0=;
        b=CTBZ2JW0hrQPlDqPWU2RgDGRWF2avJeH9LyvhYip+0j5mUAZTnQtxL4ubXwAJ5NlBw
         4TUdrDqqZGiC74hwB3H4juRNNYCIgJtSiFCddWWTHG7ZOq9eNDOQJaueM/temvE2ex4C
         /gG3mhw2z21FU+QTVX1ELHfRptvVEhUuv4+i7mYXBNMB5GvTtMrioMScYHcFoBLWdGpl
         +qlUI3IREImaAu+/Qe6xOI5LkBBMdIX+84k4F2izqvLQO+N91AYHoxORURGbE1pvDngD
         5GDeX+R6I3rRxVzXqNxfk6Jj3OlkSLumzkjjWjjIJuFJiDsTNmHaaUTjTMqOVDCAIyMf
         FEhw==
X-Gm-Message-State: AOAM532dEBC2pUgICnKbOkYsBC+ojgAvqYiuS+ellJp76MD0jse71NRB
        iB8zV2aLj2ASTB89lDPL/h3I4w==
X-Google-Smtp-Source: ABdhPJxWI/reqSRbs4HBj3AoEgi/XmuoEqdfIbNcLAijgQMdbFysWX+mVK3VuK2IqRmMkXOekoatlg==
X-Received: by 2002:a17:907:7f04:b0:6e0:39a2:79a6 with SMTP id qf4-20020a1709077f0400b006e039a279a6mr9472703ejc.243.1649272052611;
        Wed, 06 Apr 2022 12:07:32 -0700 (PDT)
Received: from localhost (85-127-190-169.dsl.dynamic.surfer.at. [85.127.190.169])
        by smtp.gmail.com with ESMTPSA id gv55-20020a1709072bf700b006e82ef9b910sm110685ejc.70.2022.04.06.12.07.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Apr 2022 12:07:32 -0700 (PDT)
From:   =?UTF-8?q?Christoph=20B=C3=B6hmwalder?= 
        <christoph.boehmwalder@linbit.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     drbd-dev@lists.linbit.com, linux-kernel@vger.kernel.org,
        Lars Ellenberg <lars.ellenberg@linbit.com>,
        Philipp Reisner <philipp.reisner@linbit.com>,
        linux-block@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        =?UTF-8?q?Christoph=20B=C3=B6hmwalder?= 
        <christoph.boehmwalder@linbit.com>
Subject: [PATCH 2/7] drbd: address enum mismatch warnings
Date:   Wed,  6 Apr 2022 21:07:10 +0200
Message-Id: <20220406190715.1938174-3-christoph.boehmwalder@linbit.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220406190715.1938174-1-christoph.boehmwalder@linbit.com>
References: <20220406190715.1938174-1-christoph.boehmwalder@linbit.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
Reviewed-by: Christoph Böhmwalder <christoph.boehmwalder@linbit.com>
---
 drivers/block/drbd/drbd_nl.c | 24 +++++++++++++-----------
 1 file changed, 13 insertions(+), 11 deletions(-)

diff --git a/drivers/block/drbd/drbd_nl.c b/drivers/block/drbd/drbd_nl.c
index 02030c9c4d3b..074b884ec225 100644
--- a/drivers/block/drbd/drbd_nl.c
+++ b/drivers/block/drbd/drbd_nl.c
@@ -770,6 +770,7 @@ int drbd_adm_set_role(struct sk_buff *skb, struct genl_info *info)
 	struct set_role_parms parms;
 	int err;
 	enum drbd_ret_code retcode;
+	enum drbd_state_rv rv;
 
 	retcode = drbd_adm_prepare(&adm_ctx, skb, info, DRBD_ADM_NEED_MINOR);
 	if (!adm_ctx.reply_skb)
@@ -790,14 +791,14 @@ int drbd_adm_set_role(struct sk_buff *skb, struct genl_info *info)
 	mutex_lock(&adm_ctx.resource->adm_mutex);
 
 	if (info->genlhdr->cmd == DRBD_ADM_PRIMARY)
-		retcode = (enum drbd_ret_code)drbd_set_role(adm_ctx.device,
-						R_PRIMARY, parms.assume_uptodate);
+		rv = drbd_set_role(adm_ctx.device, R_PRIMARY, parms.assume_uptodate);
 	else
-		retcode = (enum drbd_ret_code)drbd_set_role(adm_ctx.device,
-						R_SECONDARY, 0);
+		rv = drbd_set_role(adm_ctx.device, R_SECONDARY, 0);
 
 	mutex_unlock(&adm_ctx.resource->adm_mutex);
 	genl_lock();
+	drbd_adm_finish(&adm_ctx, info, rv);
+	return 0;
 out:
 	drbd_adm_finish(&adm_ctx, info, retcode);
 	return 0;
@@ -2502,6 +2503,7 @@ int drbd_adm_connect(struct sk_buff *skb, struct genl_info *info)
 	struct drbd_resource *resource;
 	struct drbd_connection *connection;
 	enum drbd_ret_code retcode;
+	enum drbd_state_rv rv;
 	int i;
 	int err;
 
@@ -2621,12 +2623,11 @@ int drbd_adm_connect(struct sk_buff *skb, struct genl_info *info)
 	}
 	rcu_read_unlock();
 
-	retcode = (enum drbd_ret_code)conn_request_state(connection,
-					NS(conn, C_UNCONNECTED), CS_VERBOSE);
+	rv = conn_request_state(connection, NS(conn, C_UNCONNECTED), CS_VERBOSE);
 
 	conn_reconfig_done(connection);
 	mutex_unlock(&adm_ctx.resource->adm_mutex);
-	drbd_adm_finish(&adm_ctx, info, retcode);
+	drbd_adm_finish(&adm_ctx, info, rv);
 	return 0;
 
 fail:
@@ -2734,11 +2735,12 @@ int drbd_adm_disconnect(struct sk_buff *skb, struct genl_info *info)
 
 	mutex_lock(&adm_ctx.resource->adm_mutex);
 	rv = conn_try_disconnect(connection, parms.force_disconnect);
-	if (rv < SS_SUCCESS)
-		retcode = (enum drbd_ret_code)rv;
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
2.35.1

