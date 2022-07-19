Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11D88C433EF
	for <linux-block@archiver.kernel.org>; Tue, 19 Jul 2022 04:46:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230427AbiGSEqf (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 19 Jul 2022 00:46:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229784AbiGSEqa (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 19 Jul 2022 00:46:30 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45E23DEB5
        for <linux-block@vger.kernel.org>; Mon, 18 Jul 2022 21:46:29 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 01161205D8;
        Tue, 19 Jul 2022 04:46:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1658205988; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ObXnOvjBr7M7SMAXZpFq6XwnINgLaQjuAOY9ZZwdnrw=;
        b=Hsl3uTnQiwFN26+zUiOE+ObpV5UE4bH0FKPIVhh0pbxvtVhMCBb1uJCLF7y4uYuaER7TlS
        gmsH1vLqLk/YAih+ucPbFFvIGvLA7nGDI93TKk3SbaVKlim3NW/RaFhxeiXlh7ImfFudmu
        aE3wsG4mYvci9wPHXZKbqUOqRhX7w9Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1658205988;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ObXnOvjBr7M7SMAXZpFq6XwnINgLaQjuAOY9ZZwdnrw=;
        b=AV3KwWIcPuVpk7MaV3ymcEx7dEuvL+xYGJIh4Tqj+fr0HzFX7mgu3p8Y5j7SlkHgtrosyW
        EHyunNmk26C3lEDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 665E613A72;
        Tue, 19 Jul 2022 04:46:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id R8wRCiI31mKlcAAAMHmgww
        (envelope-from <colyli@suse.de>); Tue, 19 Jul 2022 04:46:26 +0000
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.100.31\))
Subject: Re: [PATCH v3 32/63] md/bcache: Combine two uuid_io() arguments
From:   Coly Li <colyli@suse.de>
In-Reply-To: <20220714180729.1065367-33-bvanassche@acm.org>
Date:   Tue, 19 Jul 2022 12:46:23 +0800
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Mingzhe Zou <mingzhe.zou@easystack.cn>
Content-Transfer-Encoding: quoted-printable
Message-Id: <8BB7BC0A-CD95-4148-ACF4-822D0E79F71C@suse.de>
References: <20220714180729.1065367-1-bvanassche@acm.org>
 <20220714180729.1065367-33-bvanassche@acm.org>
To:     Bart Van Assche <bvanassche@acm.org>
X-Mailer: Apple Mail (2.3696.100.31)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



> 2022=E5=B9=B47=E6=9C=8815=E6=97=A5 02:06=EF=BC=8CBart Van Assche =
<bvanassche@acm.org> =E5=86=99=E9=81=93=EF=BC=9A
>=20
> Improve uniformity in the kernel of handling of request operation and
> flags by passing these as a single argument.
>=20
> Cc: Coly Li <colyli@suse.de>
> Cc: Mingzhe Zou <mingzhe.zou@easystack.cn>
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>

Acked-by: Coly Li <colyli@suse.de>

Thanks.

Coly Li

> ---
> drivers/md/bcache/super.c | 16 ++++++++--------
> 1 file changed, 8 insertions(+), 8 deletions(-)
>=20
> diff --git a/drivers/md/bcache/super.c b/drivers/md/bcache/super.c
> index 9dd752d272f6..a2f61a2225d2 100644
> --- a/drivers/md/bcache/super.c
> +++ b/drivers/md/bcache/super.c
> @@ -414,8 +414,8 @@ static void uuid_io_unlock(struct closure *cl)
> 	up(&c->uuid_write_mutex);
> }
>=20
> -static void uuid_io(struct cache_set *c, int op, unsigned long =
op_flags,
> -		    struct bkey *k, struct closure *parent)
> +static void uuid_io(struct cache_set *c, blk_opf_t opf, struct bkey =
*k,
> +		    struct closure *parent)
> {
> 	struct closure *cl =3D &c->uuid_write;
> 	struct uuid_entry *u;
> @@ -429,22 +429,22 @@ static void uuid_io(struct cache_set *c, int op, =
unsigned long op_flags,
> 	for (i =3D 0; i < KEY_PTRS(k); i++) {
> 		struct bio *bio =3D bch_bbio_alloc(c);
>=20
> -		bio->bi_opf =3D REQ_SYNC | REQ_META | op_flags;
> +		bio->bi_opf =3D opf | REQ_SYNC | REQ_META;
> 		bio->bi_iter.bi_size =3D KEY_SIZE(k) << 9;
>=20
> 		bio->bi_end_io	=3D uuid_endio;
> 		bio->bi_private =3D cl;
> -		bio_set_op_attrs(bio, op, REQ_SYNC|REQ_META|op_flags);
> 		bch_bio_map(bio, c->uuids);
>=20
> 		bch_submit_bbio(bio, c, k, i);
>=20
> -		if (op !=3D REQ_OP_WRITE)
> +		if ((opf & REQ_OP_MASK) !=3D REQ_OP_WRITE)
> 			break;
> 	}
>=20
> 	bch_extent_to_text(buf, sizeof(buf), k);
> -	pr_debug("%s UUIDs at %s\n", op =3D=3D REQ_OP_WRITE ? "wrote" : =
"read", buf);
> +	pr_debug("%s UUIDs at %s\n", (opf & REQ_OP_MASK) =3D=3D =
REQ_OP_WRITE ?
> +		 "wrote" : "read", buf);
>=20
> 	for (u =3D c->uuids; u < c->uuids + c->nr_uuids; u++)
> 		if (!bch_is_zero(u->uuid, 16))
> @@ -463,7 +463,7 @@ static char *uuid_read(struct cache_set *c, struct =
jset *j, struct closure *cl)
> 		return "bad uuid pointer";
>=20
> 	bkey_copy(&c->uuid_bucket, k);
> -	uuid_io(c, REQ_OP_READ, 0, k, cl);
> +	uuid_io(c, REQ_OP_READ, k, cl);
>=20
> 	if (j->version < BCACHE_JSET_VERSION_UUIDv1) {
> 		struct uuid_entry_v0	*u0 =3D (void *) c->uuids;
> @@ -511,7 +511,7 @@ static int __uuid_write(struct cache_set *c)
>=20
> 	size =3D  meta_bucket_pages(&ca->sb) * PAGE_SECTORS;
> 	SET_KEY_SIZE(&k.key, size);
> -	uuid_io(c, REQ_OP_WRITE, 0, &k.key, &cl);
> +	uuid_io(c, REQ_OP_WRITE, &k.key, &cl);
> 	closure_sync(&cl);
>=20
> 	/* Only one bucket used for uuid write */

