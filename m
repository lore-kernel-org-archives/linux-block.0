Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3C09C433C1
	for <linux-block@archiver.kernel.org>; Mon, 22 Mar 2021 21:23:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7302061984
	for <linux-block@archiver.kernel.org>; Mon, 22 Mar 2021 21:23:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229703AbhCVVX1 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 22 Mar 2021 17:23:27 -0400
Received: from mx2.suse.de ([195.135.220.15]:37716 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229548AbhCVVXH (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 22 Mar 2021 17:23:07 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 3CD68AFEC;
        Mon, 22 Mar 2021 21:23:06 +0000 (UTC)
From:   NeilBrown <neilb@suse.de>
To:     edwardh <edwardh@synology.com>, axboe@kernel.dk, neilb@suse.com
Date:   Tue, 23 Mar 2021 08:22:59 +1100
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        s3t@synology.com, bingjingc@synology.com, cccheng@synology.com,
        Edward Hsieh <edwardh@synology.com>
Subject: Re: [PATCH v2] block: fix trace completion for chained bio
In-Reply-To: <1614741726-28074-1-git-send-email-edwardh@synology.com>
References: <1614741726-28074-1-git-send-email-edwardh@synology.com>
Message-ID: <87zgyudgss.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 03 2021, edwardh wrote:

> From: Edward Hsieh <edwardh@synology.com>
>
> For chained bio, trace_block_bio_complete in bio_endio is currently called
> only by the parent bio once upon all chained bio completed.
> However, the sector and size for the parent bio are modified in bio_split.
> Therefore, the size and sector of the complete events might not match the
> queue events in blktrace.
>
> The original fix of bio completion trace <fbbaf700e7b1> ("block: trace
> completion of all bios.") wants multiple complete events to correspond
> to one queue event but missed this.
>
> md/raid5 read with bio cross chunks can reproduce this issue.
>
> To fix, move trace completion into the loop for every chained bio to call.

Thanks.  I think this is correct as far as tracing goes.
However the code still looks a bit odd.

The comment for the handling of bio_chain_endio suggests that the *only*
purpose for that is to avoid deep recursion.  That suggests it should be
at the end of the function.
As it is blk_throtl_bio_endio() and bio_unint() are only called on the
last bio in a chain.
That seems wrong.

I'd be more comfortable if the patch moved the bio_chain_endio()
handling to the end, after all of that.
So the function would end.

if (bio->bi_end_io =3D=3D bio_chain_endio) {
   bio =3D __bio_chain_endio(bio);
   goto again;
} else if (bio->bi_end_io)
   bio->bi_end_io(bio);

Jens:  can you see any reason why that functions must only be called on
the last bio in the chain?

Thanks,
NeilBrown


>
> Fixes: fbbaf700e7b1 ("block: trace completion of all bios.")
> Reviewed-by: Wade Liang <wadel@synology.com>
> Reviewed-by: BingJing Chang <bingjingc@synology.com>
> Signed-off-by: Edward Hsieh <edwardh@synology.com>
> ---
>  block/bio.c | 13 ++++++-------
>  1 file changed, 6 insertions(+), 7 deletions(-)
>
> diff --git a/block/bio.c b/block/bio.c
> index a1c4d29..2ff72cb 100644
> --- a/block/bio.c
> +++ b/block/bio.c
> @@ -1397,8 +1397,7 @@ static inline bool bio_remaining_done(struct bio *b=
io)
>   *
>   *   bio_endio() can be called several times on a bio that has been chai=
ned
>   *   using bio_chain().  The ->bi_end_io() function will only be called =
the
> - *   last time.  At this point the BLK_TA_COMPLETE tracing event will be
> - *   generated if BIO_TRACE_COMPLETION is set.
> + *   last time.
>   **/
>  void bio_endio(struct bio *bio)
>  {
> @@ -1411,6 +1410,11 @@ void bio_endio(struct bio *bio)
>  	if (bio->bi_bdev)
>  		rq_qos_done_bio(bio->bi_bdev->bd_disk->queue, bio);
>=20=20
> +	if (bio->bi_bdev && bio_flagged(bio, BIO_TRACE_COMPLETION)) {
> +		trace_block_bio_complete(bio->bi_bdev->bd_disk->queue, bio);
> +		bio_clear_flag(bio, BIO_TRACE_COMPLETION);
> +	}
> +
>  	/*
>  	 * Need to have a real endio function for chained bios, otherwise
>  	 * various corner cases will break (like stacking block devices that
> @@ -1424,11 +1428,6 @@ void bio_endio(struct bio *bio)
>  		goto again;
>  	}
>=20=20
> -	if (bio->bi_bdev && bio_flagged(bio, BIO_TRACE_COMPLETION)) {
> -		trace_block_bio_complete(bio->bi_bdev->bd_disk->queue, bio);
> -		bio_clear_flag(bio, BIO_TRACE_COMPLETION);
> -	}
> -
>  	blk_throtl_bio_endio(bio);
>  	/* release cgroup info */
>  	bio_uninit(bio);
> --=20
> 2.7.4

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJCBAEBCAAsFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAmBZCrQOHG5laWxiQHN1
c2UuZGUACgkQOeye3VZigbmoUw/+NPCgxNK4OL19KuY8ht9WrSSedcak9i5QrAMU
44d1w+ExXS+ILEX3fQqV5PqQjpnJGklOJ08CVdLoyZKWyyBges8fmfTtpp0o/wxk
pGHE9TveDerq2H9wHWIqZ/BSbp/ywcRpSNSnUf5qLR597gJxrPIy+KzOflA5XahF
PNjVCGCU1HWuujVzwtT6MGIZT48Rp+XFgHG9lCkkPNlMYiUm7At8zGVQo0qGH/7x
FUZC6w5+YBwKjjBkk9mMRfqpBfL1Cl2CrEG4BwHGtN2Yn1LPlIk6RvPff9sZn3Zn
KfMjdehS9A30iXYL5B/wPwRt7yDNBX1rIJfJvUOih4COETPnYZlVupgHZinTdzNI
yGQvEndAcMtWtsB1wEgK1ZS9vLVfZzDiyXgUPTLVLtOQHGjg6GkyKMSpoh8bb88J
MRTObiBSzS2fvpLlOiGtFB1+xn2Bl0H35HyLW2yZfnOntkyXIlFJVIHPWL/hLd0d
jGElqwwr2y77Z6QWYfwhjtdU3dyDnNeezIJT+dH7x1IAHt2nbqp2pvvGArjRNwTa
BZiAe0BmPUdVFaizlM3rDDLT5ZXS9lXDMAplIK+aNjW+UTaF8qzO7pAqxoEvX8I2
Fu/0ghzZYhCbfWNKyIle2ZRnqo8sQxDB2z9oINUrBkCiKZ8IiXXDM6+b0EMsfdkz
voej+NQ=
=wcgh
-----END PGP SIGNATURE-----
--=-=-=--
