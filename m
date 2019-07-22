Return-Path: <SRS0=hu+R=VT=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65488C76188
	for <linux-block@archiver.kernel.org>; Mon, 22 Jul 2019 12:27:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4460C218EA
	for <linux-block@archiver.kernel.org>; Mon, 22 Jul 2019 12:27:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727364AbfGVM1C (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 22 Jul 2019 08:27:02 -0400
Received: from mout.kundenserver.de ([217.72.192.74]:44531 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727040AbfGVM1C (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 22 Jul 2019 08:27:02 -0400
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue109 [212.227.15.145]) with ESMTPA (Nemesis) id
 1MS3rB-1i0ppS27tD-00TS5J; Mon, 22 Jul 2019 14:26:49 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Philipp Reisner <philipp.reisner@linbit.com>,
        Lars Ellenberg <lars.ellenberg@linbit.com>,
        Jens Axboe <axboe@kernel.dk>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Roland Kammerer <roland.kammerer@linbit.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Eric Biggers <ebiggers@google.com>,
        Kees Cook <keescook@chromium.org>, drbd-dev@lists.linbit.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com
Subject: [PATCH] [v2] drbd: dynamically allocate shash descriptor
Date:   Mon, 22 Jul 2019 14:26:34 +0200
Message-Id: <20190722122647.351002-1-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:TUkJdt6WnOtvIKaR0C75bjyJONsAuTghX9dFPBuK/8hnMLggk3n
 oaimOoXAU2Z5zyElT/gELYVsGJyidfA2ExueKc9APQYmKTBUXBWzq5pdcaRaVmUMkwDM8eK
 3TBy71px+BMkF5WdicIU/qxkzYwfULo/cL305TewpfFFQBaqDWboMCadDAH4olBURs/jRw1
 q6sUBbFtTzs7Kvn0ZEUiw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:c+P8+Y3Ft70=:cJiCb3/FiWtXQt/BwQwW7R
 NFYvnQ8N1hPvLKZIghEf+kKVLp7/kYyBTvTNO8WRdxBLi6aZP1xjhkRrR0kMmjCvamRDEfSMs
 gZJXxkU2vatLVaS2KQmDYMP4kGEuVjnlasytI3typK7ZlwrqSJ0NaCUqsTy7S333zZSGHs4we
 a3lsh2QvQ9+Jlfcdwp4v7OMZ6FEsjpqMaXDc/oaUbLiuh+19kl0pHsbyKASPN2c6+TCY25h37
 n6tWNAVq5qPl7ZWYUqCUpNg8bHxEic5Epqj2drDgWR2AR5syCs5UmqyyBf4puZkcwlf7ucH20
 Hdx+GYhU6FKYnr+i1WUNPUpKQCYSM6q2Zrx9MaYRxHg3ouuZYDuccKneHpBCS54imGAe21V2v
 ha+4JHczutkINYtlqy6nw/izraZz4BditGhG+wUcQ3N3LUDdt+FsixBVenTycVe4C4SlHiDPx
 7rO2CuGkxEe7xx9W8jU3EI9DjxPA9dte96y8Jp7VRRDTYgFnJ624Zn9GY7jnHggrs5plQwL4J
 c3piWuVfYT7abyUKKFYAd1J3URNK6RaAm9pWQKo/mvw8Shagyp2waz26zy8ZDYdpFE5J+jByH
 IsqSu8GRhkI2vZELyGUk7Ar/XDURoYk+OoZN4Myfw4LxBNIokSVNk/0g07x/2/5FsOC20P/5g
 Zc0ys9eBkBw/gcZfRv0XEfBZ+uZo+Lo6QuVzJOttdiEFxMlllL4gKq4yB9Bj1wnlh+aOP6rtC
 sfi5B0rcPguhvN9lACFtnrg2/8lpmleYob2zkw==
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

Link: https://lore.kernel.org/lkml/20190617132440.2721536-1-arnd@arndb.de/
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
v2:
- don't try to zero a NULL descriptor pointer,
  based on review from Roland Kammerer.
---
 drivers/block/drbd/drbd_receiver.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/block/drbd/drbd_receiver.c b/drivers/block/drbd/drbd_receiver.c
index 90ebfcae0ce6..2b3103c30857 100644
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
+		       crypto_shash_descsize(connection->cram_hmac_tfm),
+		       GFP_KERNEL);
+	if (!desc) {
+		rv = -1;
+		goto fail;
+	}
 	desc->tfm = connection->cram_hmac_tfm;
 
 	rv = crypto_shash_setkey(connection->cram_hmac_tfm, (u8 *)secret, key_len);
@@ -5571,7 +5578,10 @@ static int drbd_do_auth(struct drbd_connection *connection)
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
2.20.0

