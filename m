Return-Path: <SRS0=14Po=UQ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45298C31E5B
	for <linux-block@archiver.kernel.org>; Mon, 17 Jun 2019 14:43:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2365620833
	for <linux-block@archiver.kernel.org>; Mon, 17 Jun 2019 14:43:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727467AbfFQOnz (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 17 Jun 2019 10:43:55 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:34476 "EHLO deadmen.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727417AbfFQOnz (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 17 Jun 2019 10:43:55 -0400
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
        by deadmen.hmeau.com with esmtps (Exim 4.89 #2 (Debian))
        id 1hcsrD-0001iw-Tl; Mon, 17 Jun 2019 22:43:39 +0800
Received: from herbert by gondobar with local (Exim 4.89)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1hcsr9-0003Za-JF; Mon, 17 Jun 2019 22:43:35 +0800
Date:   Mon, 17 Jun 2019 22:43:35 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Philipp Reisner <philipp.reisner@linbit.com>,
        Lars Ellenberg <lars.ellenberg@linbit.com>,
        Jens Axboe <axboe@kernel.dk>,
        Roland Kammerer <roland.kammerer@linbit.com>,
        Eric Biggers <ebiggers@google.com>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Kees Cook <keescook@chromium.org>, drbd-dev@lists.linbit.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drbd: dynamically allocate shash descriptor
Message-ID: <20190617144335.q243r7l7ox7galhl@gondor.apana.org.au>
References: <20190617132440.2721536-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190617132440.2721536-1-arnd@arndb.de>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Jun 17, 2019 at 03:24:13PM +0200, Arnd Bergmann wrote:
> Building with clang and KASAN, we get a warning about an overly large
> stack frame on 32-bit architectures:
> 
> drivers/block/drbd/drbd_receiver.c:921:31: error: stack frame size of 1280 bytes in function 'conn_connect'
>       [-Werror,-Wframe-larger-than=]
> 
> We already allocate other data dynamically in this function, so
> just do the same for the shash descriptor, which makes up most of
> this memory.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/block/drbd/drbd_receiver.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)

Does this patch fix the warning as well?

diff --git a/drivers/block/drbd/drbd_receiver.c b/drivers/block/drbd/drbd_receiver.c
index 90ebfcae0ce6..ead13a6b3887 100644
--- a/drivers/block/drbd/drbd_receiver.c
+++ b/drivers/block/drbd/drbd_receiver.c
@@ -5401,6 +5401,35 @@ static int drbd_do_auth(struct drbd_connection *connection)
 #else
 #define CHALLENGE_LEN 64
 
+static char *drbd_get_response(struct drbd_connection *connection,
+			       const char *challenge, unsigned int len)
+{
+	unsigned dlen = crypto_shash_digestsize(connection->cram_hmac_tfm);
+	SHASH_DESC_ON_STACK(desc, connection->cram_hmac_tfm);
+	char *response;
+	int err;
+
+	desc->tfm = connection->cram_hmac_tfm;
+
+	response = kmalloc(dlen, GFP_NOIO);
+	if (!response) {
+		drbd_err(connection, "kmalloc of response failed\n");
+		goto out;
+	}
+
+	err = crypto_shash_digest(desc, challenge, len, response);
+	if (err) {
+		drbd_err(connection, "crypto_shash_digest() failed with %d\n",
+			 err);
+		kfree(response);
+		response = NULL;
+	}
+
+out:
+	shash_desc_zero(desc);
+	return response;
+}
+
 /* Return value:
 	1 - auth succeeded,
 	0 - failed, try again (network error),
@@ -5417,7 +5446,6 @@ static int drbd_do_auth(struct drbd_connection *connection)
 	unsigned int key_len;
 	char secret[SHARED_SECRET_MAX]; /* 64 byte */
 	unsigned int resp_size;
-	SHASH_DESC_ON_STACK(desc, connection->cram_hmac_tfm);
 	struct packet_info pi;
 	struct net_conf *nc;
 	int err, rv;
@@ -5430,8 +5458,6 @@ static int drbd_do_auth(struct drbd_connection *connection)
 	memcpy(secret, nc->shared_secret, key_len);
 	rcu_read_unlock();
 
-	desc->tfm = connection->cram_hmac_tfm;
-
 	rv = crypto_shash_setkey(connection->cram_hmac_tfm, (u8 *)secret, key_len);
 	if (rv) {
 		drbd_err(connection, "crypto_shash_setkey() failed with %d\n", rv);
@@ -5496,16 +5522,8 @@ static int drbd_do_auth(struct drbd_connection *connection)
 	}
 
 	resp_size = crypto_shash_digestsize(connection->cram_hmac_tfm);
-	response = kmalloc(resp_size, GFP_NOIO);
+	response = drbd_get_response(connection, peers_ch, pi.size);
 	if (response == NULL) {
-		drbd_err(connection, "kmalloc of response failed\n");
-		rv = -1;
-		goto fail;
-	}
-
-	rv = crypto_shash_digest(desc, peers_ch, pi.size, response);
-	if (rv) {
-		drbd_err(connection, "crypto_hash_digest() failed with %d\n", rv);
 		rv = -1;
 		goto fail;
 	}
@@ -5544,17 +5562,9 @@ static int drbd_do_auth(struct drbd_connection *connection)
 		goto fail;
 	}
 
-	right_response = kmalloc(resp_size, GFP_NOIO);
+	right_response = drbd_get_response(connection, my_challenge,
+					   CHALLENGE_LEN);
 	if (right_response == NULL) {
-		drbd_err(connection, "kmalloc of right_response failed\n");
-		rv = -1;
-		goto fail;
-	}
-
-	rv = crypto_shash_digest(desc, my_challenge, CHALLENGE_LEN,
-				 right_response);
-	if (rv) {
-		drbd_err(connection, "crypto_hash_digest() failed with %d\n", rv);
 		rv = -1;
 		goto fail;
 	}
@@ -5571,7 +5581,6 @@ static int drbd_do_auth(struct drbd_connection *connection)
 	kfree(peers_ch);
 	kfree(response);
 	kfree(right_response);
-	shash_desc_zero(desc);
 
 	return rv;
 }
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
