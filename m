Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:37573 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750907AbeAWHAM (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 23 Jan 2018 02:00:12 -0500
From: NeilBrown <neilb@suse.com>
To: Wang Sheng-Hui <shhuiw@foxmail.com>, axboe <axboe@fb.com>,
        linux-block <linux-block@vger.kernel.org>
Date: Tue, 23 Jan 2018 18:00:04 +1100
Cc: Goldwyn Rodrigues <rgoldwyn@suse.de>
Subject: Re: confusion about bio_split
In-Reply-To: <tencent_2CB1180FF26CF53DED88D66CCA27AA87DC0A@qq.com>
References: <tencent_2CB1180FF26CF53DED88D66CCA27AA87DC0A@qq.com>
Message-ID: <87o9ll83gr.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 15 2018, Wang Sheng-Hui wrote:

> Dear,
>
> Sorry to trouble you.
>
> I'm confused by the following code in bio.c/bio_split:
> -------------------------------------
> struct bio *bio_split(struct bio *bio, int sectors,
> ...
> 	if (bio_flagged(bio, BIO_TRACE_COMPLETION))
> 		bio_set_flag(bio, BIO_TRACE_COMPLETION);=20=20=20=20=20=20=20=20=20
> ...
> }
> EXPORT_SYMBOL(bio_split);
> ------------------------------------
>
> I think it maybe flag on the new split set, right?

Goldwyn Rodrigues posted a patch to fix this a couple of
months ago.
Jens - can you apply that?  Do you need it resent?

https://www.mail-archive.com/linux-block@vger.kernel.org/msg16039.html

Thanks,
NeilBrown
>
>
> Regards,
> shenghui

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAlpm3XQACgkQOeye3VZi
gbm99hAAnx0qYmpzanccM4OAj9m2T3XoQxBSnxivyW8zjr3mQjnMpHO0K44ePUB8
ygIGGRN6CjmUdBpKvvXwO+eLElaZ96Z+36yYW6iNFVWej83gozdO2WSLYl8P1/4j
3MdaE9XvbSNG086Pv0oJwdmT81Y51mrTPmDfUzZ9TqtqbkdG7KYzfis2KUYslhzd
G/rwCUcRPuN3YcnVpBmuQMwr5FFoPpl663kjdx3JuTCh7HLyYNrYDOEuDVvemBtj
Wwd1I7ZXn+YKL1ze2bcnUiLHyM8eUiuQzLU3WGvvbo6hNlIxaASEeMui0IuKiCP9
Px7F7mytp3GFr21gp+xQgUR6eaHIu1/MnyLHIYv+fD9aq6mKfL4E6mEDO3Ys4FFm
F0fuvErCqkNaIhGfQOxBloSqrH8Vz8NEuvkzhy41GM8Q4FtVd+ivmvBBZXKX+Cij
GoLeZTB9tQXPxZZNhsSQ2bJQ/fOSpl6J26IEG86/3ZSKvtzhiaw8H2tp9iaymk2K
w3wblDV6oUUYGa5DKXV99ZE/9E6A2CpxTURRtIEuVCLeQ+Htj0qHgrlBv80jpbM0
Nebq/xNFBDfBl675Z0ZERZrqMZBOOrqv2wRwVVZOBMQo3ijGgJgk93C8ruYrLvw1
wszDLtd0W/Hq+AquH+rtMXIosURgiWSOCASXAVsqsBcLaBBnVMY=
=NGgF
-----END PGP SIGNATURE-----
--=-=-=--
