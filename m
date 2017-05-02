Return-Path: <neilb@suse.de>
From: NeilBrown <neilb@suse.com>
To: Christoph Hellwig <hch@infradead.org>
Date: Wed, 03 May 2017 07:47:29 +1000
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org, Ming Lei <tom.leiming@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 02/13] blk: replace bioset_create_nobvec() with a flags arg to bioset_create()
In-Reply-To: <20170502080617.GA5578@infradead.org>
References: <149369628671.5146.4865312503373040039.stgit@noble> <149369654407.5146.12779672368228096310.stgit@noble> <20170502080617.GA5578@infradead.org>
Message-ID: <8760hjq6by.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha256; protocol="application/pgp-signature"
List-ID: <linux-block@vger.kernel.org>

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, May 02 2017, Christoph Hellwig wrote:

>> diff --git a/include/linux/bio.h b/include/linux/bio.h
>> index d1b04b0e99cf..0975da6bebd9 100644
>> --- a/include/linux/bio.h
>> +++ b/include/linux/bio.h
>> @@ -373,8 +373,10 @@ static inline struct bio *bio_next_split(struct bio=
 *bio, int sectors,
>>  	return bio_split(bio, sectors, gfp, bs);
>>  }
>>=20=20
>> -extern struct bio_set *bioset_create(unsigned int, unsigned int);
>> -extern struct bio_set *bioset_create_nobvec(unsigned int, unsigned int);
>> +extern struct bio_set *bioset_create(unsigned int, unsigned int, int fl=
ags);
>> +enum {
>> +	BIOSET_NEED_BVECS =3D BIT(0),
>> +};
>
> I really hate the BIT macro as it obsfucates what's going on.

So post a patch to remove it from the tree.
I happen to like it, but I wouldn't fight for it.

>
> Why not just
>
> 	BIOSET_NEED_BVECS	=3D (1 << 0),
>
> which is a lot more intuitive.
>
> Otherwise looks fine to me:
>
> Reviewed-by: Christoph Hellwig <hch@lst.de>

Thanks,
NeilBrown

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAlkI/nEACgkQOeye3VZi
gblIPBAAiMFgYoae49mqKbyBBi1tqWvecYRuvJqumWf4241UfHaqq/h4fAgViIQJ
YtQKiex9mEZWtr+OknPWeKk2oEhF+pGYJTeRUHnLyaVqMgsyh5dDHhCCeo6bg/FH
jMmaLkAjsWPtiITvZ5lFHVEXTsusjsWyBCB/vyS5n5uwsZrl5ZEPxV30XO0Yb3BN
Z/hoA70j3kWGc6FkrK38r+4MQDK4n+wz3EO16YasDV3VoVuue+ji834dlrhbkMMH
SoIWkIM7Ka3ih4105NdP5BgvjfZ6u21Kd/KKttIOopRSGLDTvD7gYZullsyTrSWJ
4rScg4ZlaoZ9vekF3i10LkblfrbAG+Rz7yaAjbB+bw4fv5TXfix5air5PtPFjBHU
1+Q2anbHfVnoshnok72Y3Y4fuPxBbwWNzC656lDg3b3FNXe4P/yrn0GfLnztqyUe
u0lQccJNiwhifVNqZaMPsAlDqGlqjIRtLpcUxIpwBUY4S04HYsyTYi4mLClf1JIf
fsJyT9JChutiMxrygaVCkfscI6RbZjnQwTVaP071JprvcS3N4c9w7wxotRiKfTBg
yhEbA1g6gMSz+ClNObzp/gP7BGv37+Xlx3Be0t/StMicSveijtIdCCUpLs+0C8nt
hBUW81U98FTLeJazbtMdrhmmX/5qpa9PuMYwX5B+YtlUcjQX4Gw=
=WfZO
-----END PGP SIGNATURE-----
--=-=-=--
