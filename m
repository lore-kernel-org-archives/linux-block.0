Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E04CC433EF
	for <linux-block@archiver.kernel.org>; Tue, 19 Jul 2022 04:43:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234713AbiGSEnT (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 19 Jul 2022 00:43:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232986AbiGSEnS (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 19 Jul 2022 00:43:18 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE447275F0
        for <linux-block@vger.kernel.org>; Mon, 18 Jul 2022 21:43:17 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 9CD2820536;
        Tue, 19 Jul 2022 04:43:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1658205796; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gOhJK+ZgvH2l4knrkmifFFVmoc8JHNm3fyaE+LwU/oc=;
        b=nxj/+N4Zs91tgngIFV/lN7jMSJrQlhgiidVAM4NVYXcU0wZ4fxjBPnyaqFSo0xsNXayaqe
        iid0gb/+AV/0fDbwxh3CliYFriuAJY+fiYKyQPUOZzc4FI07qynBN0qo4aN15slLdsl8WX
        ochGrNwMIlFB0z+ol89kwxoEkY8bJs8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1658205796;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gOhJK+ZgvH2l4knrkmifFFVmoc8JHNm3fyaE+LwU/oc=;
        b=1R27YQ857ErNn/w4R56Z5rbWOMiSsimLuI0+suBdhVtPc8kgYzkgsFdmnGPNHCBkKRdAfU
        I4gD0rCfAuI8RzDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0996E13A72;
        Tue, 19 Jul 2022 04:43:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id bfN7MWI21mKebwAAMHmgww
        (envelope-from <colyli@suse.de>); Tue, 19 Jul 2022 04:43:14 +0000
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.100.31\))
Subject: Re: [PATCH v3 33/63] md/bcache: Combine two prio_io() arguments
From:   Coly Li <colyli@suse.de>
In-Reply-To: <20220714180729.1065367-34-bvanassche@acm.org>
Date:   Tue, 19 Jul 2022 12:43:12 +0800
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Mingzhe Zou <mingzhe.zou@easystack.cn>
Content-Transfer-Encoding: quoted-printable
Message-Id: <4F9BFD24-C559-45E5-AFC0-D7B13954FA14@suse.de>
References: <20220714180729.1065367-1-bvanassche@acm.org>
 <20220714180729.1065367-34-bvanassche@acm.org>
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


Asked-by: Coly Li <colyli@suse.de>

Thanks.

Coly Li


> ---
> drivers/md/bcache/super.c | 9 ++++-----
> 1 file changed, 4 insertions(+), 5 deletions(-)
>=20
> diff --git a/drivers/md/bcache/super.c b/drivers/md/bcache/super.c
> index a2f61a2225d2..ba3909bb6bea 100644
> --- a/drivers/md/bcache/super.c
> +++ b/drivers/md/bcache/super.c
> @@ -587,8 +587,7 @@ static void prio_endio(struct bio *bio)
> 	closure_put(&ca->prio);
> }
>=20
> -static void prio_io(struct cache *ca, uint64_t bucket, int op,
> -		    unsigned long op_flags)
> +static void prio_io(struct cache *ca, uint64_t bucket, blk_opf_t opf)
> {
> 	struct closure *cl =3D &ca->prio;
> 	struct bio *bio =3D bch_bbio_alloc(ca->set);
> @@ -601,7 +600,7 @@ static void prio_io(struct cache *ca, uint64_t =
bucket, int op,
>=20
> 	bio->bi_end_io	=3D prio_endio;
> 	bio->bi_private =3D ca;
> -	bio_set_op_attrs(bio, op, REQ_SYNC|REQ_META|op_flags);
> +	bio->bi_opf =3D opf | REQ_SYNC | REQ_META;
> 	bch_bio_map(bio, ca->disk_buckets);
>=20
> 	closure_bio_submit(ca->set, bio, &ca->prio);
> @@ -661,7 +660,7 @@ int bch_prio_write(struct cache *ca, bool wait)
> 		BUG_ON(bucket =3D=3D -1);
>=20
> 		mutex_unlock(&ca->set->bucket_lock);
> -		prio_io(ca, bucket, REQ_OP_WRITE, 0);
> +		prio_io(ca, bucket, REQ_OP_WRITE);
> 		mutex_lock(&ca->set->bucket_lock);
>=20
> 		ca->prio_buckets[i] =3D bucket;
> @@ -705,7 +704,7 @@ static int prio_read(struct cache *ca, uint64_t =
bucket)
> 			ca->prio_last_buckets[bucket_nr] =3D bucket;
> 			bucket_nr++;
>=20
> -			prio_io(ca, bucket, REQ_OP_READ, 0);
> +			prio_io(ca, bucket, REQ_OP_READ);
>=20
> 			if (p->csum !=3D
> 			    bch_crc64(&p->magic, =
meta_bucket_bytes(&ca->sb) - 8)) {

