Return-Path: <SRS0=5K92=V6=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0DDAC433FF
	for <linux-block@archiver.kernel.org>; Fri,  2 Aug 2019 13:28:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 951CE217D4
	for <linux-block@archiver.kernel.org>; Fri,  2 Aug 2019 13:28:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564752505;
	bh=23B8luakk6bxCcsYaOoRRvGgRBG7IONl/QGkKxDbqvk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Vj2RXI9rcyw1F7t3Wxvh9QmFRaclmX3OW67AD6j3W0B090q9Wq2IhBEl59TALWfSN
	 WAFz0LCSk0L8Txop4SQJ9TWgE7sMDR/bIKYoJelm3JvQ6E+dNcplaUZDTziRfQTxJy
	 IAmEfuc0M0LdGbEZCA64XEwCm69AGnRhv0OodYpY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730313AbfHBN2U (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 2 Aug 2019 09:28:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:37042 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2394525AbfHBN0P (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 2 Aug 2019 09:26:15 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 565EB21852;
        Fri,  2 Aug 2019 13:26:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564752375;
        bh=23B8luakk6bxCcsYaOoRRvGgRBG7IONl/QGkKxDbqvk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=q4k1GU1DH4aJNt5ax34tXvn2EuLMi+BVwVufL7iQ6vdNu6u3k86a/mM38oAlnvHho
         F2T7capDVks/rgHeXHPUDxsYaCBq5exQCy0JteXpC+jvhTW+mMvp9UnFQNoCwca5Wb
         tUgtmF2dDh6v0m6JWXPnCBPgb4rH0ztjW1+UhJuc=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Arnd Bergmann <arnd@arndb.de>, Kees Cook <keescook@chromium.org>,
        Roland Kammerer <roland.kammerer@linbit.com>,
        Jens Axboe <axboe@kernel.dk>, Sasha Levin <sashal@kernel.org>,
        drbd-dev@lists.linbit.com, linux-block@vger.kernel.org,
        clang-built-linux@googlegroups.com
Subject: [PATCH AUTOSEL 4.9 15/22] drbd: dynamically allocate shash descriptor
Date:   Fri,  2 Aug 2019 09:25:39 -0400
Message-Id: <20190802132547.14517-15-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190802132547.14517-1-sashal@kernel.org>
References: <20190802132547.14517-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

[ Upstream commit 77ce56e2bfaa64127ae5e23ef136c0168b818777 ]

Building with clang and KASAN, we get a warning about an overly large
stack frame on 32-bit architectures:

drivers/block/drbd/drbd_receiver.c:921:31: error: stack frame size of 1280 bytes in function 'conn_connect'
      [-Werror,-Wframe-larger-than=]

We already allocate other data dynamically in this function, so
just do the same for the shash descriptor, which makes up most of
this memory.

Link: https://lore.kernel.org/lkml/20190617132440.2721536-1-arnd@arndb.de/
Reviewed-by: Kees Cook <keescook@chromium.org>
Reviewed-by: Roland Kammerer <roland.kammerer@linbit.com>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/block/drbd/drbd_receiver.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/block/drbd/drbd_receiver.c b/drivers/block/drbd/drbd_receiver.c
index 83957a1e15ed7..8e8e4ccb128f3 100644
--- a/drivers/block/drbd/drbd_receiver.c
+++ b/drivers/block/drbd/drbd_receiver.c
@@ -5297,7 +5297,7 @@ static int drbd_do_auth(struct drbd_connection *connection)
 	unsigned int key_len;
 	char secret[SHARED_SECRET_MAX]; /* 64 byte */
 	unsigned int resp_size;
-	SHASH_DESC_ON_STACK(desc, connection->cram_hmac_tfm);
+	struct shash_desc *desc;
 	struct packet_info pi;
 	struct net_conf *nc;
 	int err, rv;
@@ -5310,6 +5310,13 @@ static int drbd_do_auth(struct drbd_connection *connection)
 	memcpy(secret, nc->shared_secret, key_len);
 	rcu_read_unlock();
 
+	desc = kmalloc(sizeof(struct shash_desc) +
+		       crypto_shash_descsize(connection->cram_hmac_tfm),
+		       GFP_KERNEL);
+	if (!desc) {
+		rv = -1;
+		goto fail;
+	}
 	desc->tfm = connection->cram_hmac_tfm;
 	desc->flags = 0;
 
@@ -5452,7 +5459,10 @@ static int drbd_do_auth(struct drbd_connection *connection)
 	kfree(peers_ch);
 	kfree(response);
 	kfree(right_response);
-	shash_desc_zero(desc);
+	if (desc) {
+		shash_desc_zero(desc);
+		kfree(desc);
+	}
 
 	return rv;
 }
-- 
2.20.1

