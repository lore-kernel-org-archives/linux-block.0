Return-Path: <SRS0=XolY=P5=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B54EAC282E9
	for <linux-block@archiver.kernel.org>; Mon, 21 Jan 2019 08:03:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E17820823
	for <linux-block@archiver.kernel.org>; Mon, 21 Jan 2019 08:03:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728530AbfAUIDt (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 21 Jan 2019 03:03:49 -0500
Received: from mx2.suse.de ([195.135.220.15]:35336 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728853AbfAUIDs (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 21 Jan 2019 03:03:48 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 75670AE65;
        Mon, 21 Jan 2019 04:39:26 +0000 (UTC)
From:   NeilBrown <neilb@suse.com>
To:     Mike Snitzer <snitzer@redhat.com>, dm-devel@redhat.com
Date:   Mon, 21 Jan 2019 15:39:18 +1100
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org,
        Ming Lei <ming.lei@redhat.com>
Subject: Re: [dm-devel] [PATCH 3/4] dm: fix missing bio_split() pattern code in __split_and_process_bio()
In-Reply-To: <20190119180506.1300-4-snitzer@redhat.com>
References: <20190119180506.1300-1-snitzer@redhat.com> <20190119180506.1300-4-snitzer@redhat.com>
Message-ID: <875zuifwuh.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sat, Jan 19 2019, Mike Snitzer wrote:

> Use the same BIO_QUEUE_ENTERED pattern that was established by commit
> cd4a4ae4683dc ("block: don't use blocking queue entered for recursive
> bio submits") by setting BIO_QUEUE_ENTERED after bio_split() and before
> recursing via generic_make_request().
>
> Also add trace_block_split() because it provides useful context about
> bio splits in blktrace.
>
> Depends-on: cd4a4ae4683dc ("block: don't use blocking queue entered for r=
ecursive bio submits")
> Fixes: 18a25da84354 ("dm: ensure bio submission follows a depth-first tre=
e walk")
> Cc: stable@vger.kernel.org # 4.16+
> Signed-off-by: Mike Snitzer <snitzer@redhat.com>
> ---
>  drivers/md/dm.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/md/dm.c b/drivers/md/dm.c
> index fbadda68e23b..6e29c2d99b99 100644
> --- a/drivers/md/dm.c
> +++ b/drivers/md/dm.c
> @@ -1654,7 +1654,9 @@ static blk_qc_t __split_and_process_bio(struct mapp=
ed_device *md,
>  						   sectors[op_stat_group(bio_op(bio))], ci.sector_count);
>  				part_stat_unlock();
>=20=20
> +				bio_set_flag(bio, BIO_QUEUE_ENTERED);
>  				bio_chain(b, bio);
> +				trace_block_split(md->queue, b, bio->bi_iter.bi_sector);
>  				ret =3D generic_make_request(bio);
>  				break;
>  			}
Thanks Mike...

If I understand this correctly, then we need to make the same change for
all other callers of bio_split(), except blk_queue_split().
Maybe we should just set the flag and do the trace in bio_split().
Do you see any harm with doing it that way (in the next merge-window, I
don't suggest you change this patch).

Thanks,
NeilBrown


> --=20
> 2.15.0
>
> --
> dm-devel mailing list
> dm-devel@redhat.com
> https://www.redhat.com/mailman/listinfo/dm-devel

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAlxFTPYACgkQOeye3VZi
gbknHA/+L74FoY7H1chUxUxQNjoX7+12hZ8Xe5OZJwB9BF5J8LuL55OoW9Rnjcj0
3mxkBlFGmjmnLeY8X4HdL+he8rmo8Ii8IQcHqOEpLzVFACWAgWdQfFwD8W4A7IBQ
swxTOoX31Zmo3qw6x2+mO38Xrsc7AGQ4vUhdGtXMt4R1MkJhcSNNieDERWg1gSzj
xfW591klJGLKOIwY4ENNHbrcc7vDqCrZxB9Is6b9P1RIC3lXFilm65aAlqJC7hqd
lB1xKNsQBTMTlxMiT/zkWb/RWMo8JXylY/chAs6NbVxrW7nempxBoEwNR0ejdviY
2wyCBVi1nPPYv8qFiQyPljkalssgcHZyRMDxpxXShJ8wveCJZTT1goV3irCWFKnf
GWTSTLCZN8IWccfyMgqCQEBYS5y4ao/8NOtuGetky2t7bgjdBb+2fcdA0dKFuFbc
dQ+tjMsxRTivUxNDBCGKc8lZiIXML9W157Y0sslOA2w6+bW3A4UeEvDojITPZ/R6
az0lPUKENKJZy1Cli/QrUau9MJGpXJ8wtcH+E9buLa2G07456INokurslxtkL8W1
VIIzCY1PUhkIDqkneeizhqpq/PqL9OYHaLq/SFW5qcdwKwWmh6DIPMTc5kHQpWBh
PbDLzY2axR4CspjtOi+AZqEKZh7gno7NItecfDTJIb26Qk2xDnk=
=iEj0
-----END PGP SIGNATURE-----
--=-=-=--
