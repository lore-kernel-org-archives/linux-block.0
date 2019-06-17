Return-Path: <SRS0=14Po=UQ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18867C31E57
	for <linux-block@archiver.kernel.org>; Mon, 17 Jun 2019 13:25:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E85BC206B7
	for <linux-block@archiver.kernel.org>; Mon, 17 Jun 2019 13:25:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725973AbfFQNZH (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 17 Jun 2019 09:25:07 -0400
Received: from mout.kundenserver.de ([212.227.126.187]:49635 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725884AbfFQNZH (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 17 Jun 2019 09:25:07 -0400
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue012 [212.227.15.129]) with ESMTPA (Nemesis) id
 1MXXZf-1i81xr1oqd-00YxKf; Mon, 17 Jun 2019 15:24:44 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Philipp Reisner <philipp.reisner@linbit.com>,
        Lars Ellenberg <lars.ellenberg@linbit.com>,
        Jens Axboe <axboe@kernel.dk>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Roland Kammerer <roland.kammerer@linbit.com>,
        Eric Biggers <ebiggers@google.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Kees Cook <keescook@chromium.org>, drbd-dev@lists.linbit.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drbd: dynamically allocate shash descriptor
Date:   Mon, 17 Jun 2019 15:24:13 +0200
Message-Id: <20190617132440.2721536-1-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:yiXEMLOB97u6ow4J7zGkKBjm/BFhumDE+NdcmaYm9WjfiCT/Cmn
 V/NLe0vmPNWXTdWF+BBYfUAJvJWRlM85gl+YQSPREoTkGVG39VyhcFa9g3lyJluG+07I775
 AXtdbkBvHkHTTl1uCy+pvzXhZzO6TmBcczsVNfxvFbO6tNJbIYOMsjyNsSRKdCTx99cap6Z
 ltLjUJek80sb/m+Ef1nZA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:EWEazgR7ph8=:/k+pVgzJoirHCvy+vku4GX
 U/pNEc+vgXaititlF5OBFvcboG67NR/1vD51ZrAxITevLt1CauK5gWVjqa+k8OpAS3/cA31QR
 h6LUzbIe4ZQgWUut73QRxyaownsijzM9ZRSIuh8sg3RXYgXmw5fTp6dUU91c1H/vHL03Bdcia
 G8j7M/5CuDcz0JSYRZ15tq0d0y63oOlPJKxWZ0XXkGdazN02xx2CgaF817+Dodb8CGKkENs1v
 3QMQL4n3tJNuNcb+94Nn1b5Q9FM7WAMS0dJ+CGHf+z4b9Z7wowoAR42sG/w7e7ykf26BMK1zw
 QWZ9uUWHzrXC+JJQKnWTNE13fkCjEK66aLl8pI7uJVZ3e44fW2Leig/7QnWzmSPoo7yWjbeCJ
 RLgOD/aBM5KZSM8ICvwgT3+7QzLPNjAEsHZu9itNaw32zC7wvBgqVKycY9gIkX7oQ4QputL6A
 FHOFtuox0HfQ6aPffkTc5tt6Ktl85//G5nugsQ0tXLdR5G4ogyEGVkVhxRuLi/apfdSC+RHaL
 IfsVmBzxOFDSduUK6ALIX7DtPYkCjAVaIVrkOWrg6+QU9qaEBYfwkJPUdpjyhPgPRcNOqCyjs
 S8wo+bJ7Gnv/JenkujJOyd9k3LI4kL2Tlw6KJFnsWWHo2QjF5+uHfMZiSZMUhby2dWlU7xDND
 RPkdtKAnd+tOxd8kDLeg50Xwxh8xRAS0T4HILVPT4dcjvF6l+WGmceFW6Br7H+PFBw0oPzqoq
 BB4pvfjgpbOiolEk4nYfpVFLgrGV0LAflSvSwA==
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Building with clang and KASAN, we get a warning about an overly large
stack frame on 32-bit architectures:

drivers/block/drbd/drbd_receiver.c:921:31: error: stack frame size of 1280 bytes in function 'conn_connect'
      [-Werror,-Wframe-larger-than=]

We already allocate other data dynamically in this function, so
just do the same for the shash descriptor, which makes up most of
this memory.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/block/drbd/drbd_receiver.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/block/drbd/drbd_receiver.c b/drivers/block/drbd/drbd_receiver.c
index 90ebfcae0ce6..10fb26e862d7 100644
--- a/drivers/block/drbd/drbd_receiver.c
+++ b/drivers/block/drbd/drbd_receiver.c
@@ -5417,7 +5417,7 @@ static int drbd_do_auth(struct drbd_connection *connection)
 	unsigned int key_len;
 	char secret[SHARED_SECRET_MAX]; /* 64 byte */
 	unsigned int resp_size;
-	SHASH_DESC_ON_STACK(desc, connection->cram_hmac_tfm);
+	struct shash_desc *desc;
 	struct packet_info pi;
 	struct net_conf *nc;
 	int err, rv;
@@ -5430,6 +5430,13 @@ static int drbd_do_auth(struct drbd_connection *connection)
 	memcpy(secret, nc->shared_secret, key_len);
 	rcu_read_unlock();
 
+	desc = kmalloc(sizeof(struct shash_desc) +
+			crypto_shash_descsize(connection->cram_hmac_tfm),
+		       GFP_KERNEL);
+	if (!desc) {
+		rv = -1;
+		goto fail;
+	}
 	desc->tfm = connection->cram_hmac_tfm;
 
 	rv = crypto_shash_setkey(connection->cram_hmac_tfm, (u8 *)secret, key_len);
@@ -5572,6 +5579,7 @@ static int drbd_do_auth(struct drbd_connection *connection)
 	kfree(response);
 	kfree(right_response);
 	shash_desc_zero(desc);
+	kfree(desc);
 
 	return rv;
 }
-- 
2.20.0

