Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2820EB64DD
	for <linux-block@archiver.kernel.org>; Wed,  9 Aug 2023 06:55:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229621AbjHIGzG (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 9 Aug 2023 02:55:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbjHIGzF (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 9 Aug 2023 02:55:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF4461BF7
        for <linux-block@vger.kernel.org>; Tue,  8 Aug 2023 23:55:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 797E562FB0
        for <linux-block@vger.kernel.org>; Wed,  9 Aug 2023 06:55:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0852C433C8;
        Wed,  9 Aug 2023 06:55:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691564103;
        bh=Cu9SiMceKGmUqeA9OpIibQCj0x4h8rw7+OKqH2+IWSs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rA/fj9AHfdN3Q7jMWdkrOwcJkbRxahLPlzTkUPk8hYHdMydCJQhPGK5J6C1dtPDFR
         xXoUpf8tF2ptuRuWrsyeSUaB/Y5yXAHlpcx4FwoaesbPDWIhEUGS95/dZkud58wwAl
         1VAm9f0FUnV5lPI8e8EWEcHrXwjVOc8KCWAPfTwlJ9eXVjVUBAnHIwUgQcHFWzJvQM
         Zp4ZvmBAXfrwPqdGivgj+8v8FHJ1Fzg1KVjYpiMDmFt/0ALs8iW7ZfGE7XDV9Q4OVd
         UVlla39iCQTg3uuEYaJ0KUbuEPsX8V0NFsvTpBFeBdiyKRqJCvo8fCv767NrDBzsFW
         BzqMaNGZEylkQ==
Date:   Tue, 8 Aug 2023 23:55:02 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
Cc:     Jens Axboe <axboe@kernel.dk>, Satya Tangirala <satyat@google.com>,
        linux-block@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH] blk-crypto: dynamically allocate fallback profile
Message-ID: <20230809065502.GA1571@sol.localdomain>
References: <20230808172536.211434-1-sweettea-kernel@dorminy.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230808172536.211434-1-sweettea-kernel@dorminy.me>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Aug 08, 2023 at 01:25:30PM -0400, Sweet Tea Dorminy wrote:
> blk_crypto_profile_init() calls lockdep_register_key(), which asserts
> that the provided memory is not a static object. Unfortunately,
> blk-crypto-fallback currently has a single static blk_crypto_profile,
> which means trying to use the fallback with lockdep explodes in
> blk_crypto_fallback_init().
> 
> Fortunately it is simple enough to use a dynamically allocated profile
> for fallback, allowing the use of lockdep.
> 
> Fixes: 488f6682c832e ("block: blk-crypto-fallback for Inline Encryption")
> Signed-off-by: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
> ---
>  block/blk-crypto-fallback.c | 27 +++++++++++++++------------
>  1 file changed, 15 insertions(+), 12 deletions(-)

Thanks for catching this!  My bad for not running xfstests with the inlinecrypt
mount option recently.  Can you use the correct Fixes tag:?

    Fixes: 2fb48d88e77f ("blk-crypto: use dynamic lock class for blk_crypto_profile::lock")
    Cc: stable@vger.kernel.org

Also, when describing the problem please try to be more specific than
"explodes".  I just get a WARN_ON.  Beyond that, presumably it just makes
lockdep not track blk_crypto_fallback_profile.lock?

> @@ -534,29 +534,32 @@ static int blk_crypto_fallback_init(void)
>  {
>  	int i;
>  	int err;
> -	struct blk_crypto_profile *profile = &blk_crypto_fallback_profile;
>  
>  	if (blk_crypto_fallback_inited)
>  		return 0;
>  
>  	get_random_bytes(blank_key, BLK_CRYPTO_MAX_KEY_SIZE);
>  
> +	blk_crypto_fallback_profile =
> +		kzalloc(sizeof(*blk_crypto_fallback_profile), GFP_KERNEL);
> +

Maybe add a comment:

    /* Dynamic allocation is needed because of lockdep_register_key(). */

Also, kzalloc() should be checked for failure.

Can you consider folding the following into your patch?

diff --git a/block/blk-crypto-fallback.c b/block/blk-crypto-fallback.c
index de94e9bffec6d..0764668a78157 100644
--- a/block/blk-crypto-fallback.c
+++ b/block/blk-crypto-fallback.c
@@ -540,17 +540,21 @@ static int blk_crypto_fallback_init(void)
 
 	get_random_bytes(blank_key, BLK_CRYPTO_MAX_KEY_SIZE);
 
-	blk_crypto_fallback_profile =
-		kzalloc(sizeof(*blk_crypto_fallback_profile), GFP_KERNEL);
-
 	err = bioset_init(&crypto_bio_split, 64, 0, 0);
 	if (err)
 		goto out;
 
+	/* Dynamic allocation is needed because of lockdep_register_key(). */
+	blk_crypto_fallback_profile =
+		kzalloc(sizeof(*blk_crypto_fallback_profile), GFP_KERNEL);
+	if (!blk_crypto_fallback_profile) {
+		err = -ENOMEM;
+		goto fail_free_bioset;
+	}
+
 	err = blk_crypto_profile_init(blk_crypto_fallback_profile,
 				      blk_crypto_num_keyslots);
 	if (err)
-		goto fail_free_bioset;
+		goto fail_free_profile;
 	err = -ENOMEM;
 
 	blk_crypto_fallback_profile->ll_ops = blk_crypto_fallback_ll_ops;
@@ -601,6 +605,8 @@ static int blk_crypto_fallback_init(void)
 	destroy_workqueue(blk_crypto_wq);
 fail_destroy_profile:
 	blk_crypto_profile_destroy(blk_crypto_fallback_profile);
+fail_free_profile:
+	kfree(blk_crypto_fallback_profile);
 fail_free_bioset:
 	bioset_exit(&crypto_bio_split);
 out:
