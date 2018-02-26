Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-sn1nam01on0050.outbound.protection.outlook.com ([104.47.32.50]:63840
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752081AbeBZSVQ (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 26 Feb 2018 13:21:16 -0500
From: Javier Gonzalez <javier@cnexlabs.com>
To: =?utf-8?B?TWF0aWFzIEJqw7hybGluZw==?= <mb@lightnvm.io>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH] lightnvm: pblk: remove unused variable
Date: Mon, 26 Feb 2018 18:21:13 +0000
Message-ID: <829B1AB7-A09B-4CA8-BA71-70B354E5E612@cnexlabs.com>
References: <1519651129-17897-1-git-send-email-javier@cnexlabs.com>
 <423c58a6-afde-5ebe-6199-78ff2661d8ac@lightnvm.io>
In-Reply-To: <423c58a6-afde-5ebe-6199-78ff2661d8ac@lightnvm.io>
Content-Type: multipart/signed;
        boundary="Apple-Mail=_BAFA84F7-84EA-44B1-B015-A0558FB01868";
        protocol="application/pgp-signature"; micalg=pgp-sha512
MIME-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

--Apple-Mail=_BAFA84F7-84EA-44B1-B015-A0558FB01868
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8


> On 26 Feb 2018, at 19.20, Matias Bj=C3=B8rling <mb@lightnvm.io> wrote:
>=20
> On 02/26/2018 02:18 PM, Javier Gonz=C3=A1lez wrote:
>> Remove unused variable after a previous cleanup (a8112b631adb)
>> Signed-off-by: Javier Gonz=C3=A1lez <javier@cnexlabs.com>
>> ---
>>  drivers/lightnvm/pblk-core.c | 3 ---
>>  1 file changed, 3 deletions(-)
>> diff --git a/drivers/lightnvm/pblk-core.c =
b/drivers/lightnvm/pblk-core.c
>> index ce6a7cfdba66..e6cb4317bb50 100644
>> --- a/drivers/lightnvm/pblk-core.c
>> +++ b/drivers/lightnvm/pblk-core.c
>> @@ -1071,7 +1071,6 @@ static int pblk_line_init_bb(struct pblk *pblk, =
struct pblk_line *line,
>>  	struct nvm_geo *geo =3D &dev->geo;
>>  	struct pblk_line_meta *lm =3D &pblk->lm;
>>  	struct pblk_line_mgmt *l_mg =3D &pblk->l_mg;
>> -	int nr_bb =3D 0;
>>  	u64 off;
>>  	int bit =3D -1;
>>  	int emeta_secs;
>> @@ -1087,8 +1086,6 @@ static int pblk_line_init_bb(struct pblk *pblk, =
struct pblk_line *line,
>>  		bitmap_or(line->map_bitmap, line->map_bitmap, =
l_mg->bb_aux,
>>  							=
lm->sec_per_line);
>>  		line->sec_in_line -=3D geo->c.clba;
>> -		if (bit >=3D lm->emeta_bb)
>> -			nr_bb++;
>>  	}
>>    	/* Mark smeta metadata sectors as bad sectors */
>=20
> Should Fixes be added?

It's not a bug as such, that's why I didn't add it. But be welcome to do
so if you think it's better.

--Apple-Mail=_BAFA84F7-84EA-44B1-B015-A0558FB01868
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="signature.asc"
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE+ws7Qq+qZPG1bJoyIX4xUKFRnnQFAlqUUBYACgkQIX4xUKFR
nnRV+g/+J8IE+6UZ07+VZzEzAWZhK4NZVuFg2q2+CeDgOyxw8RBkexwsp+oGANdx
+IZQE97sJwJrn08iyqh5jpgAkZ2w00rZw9zGa6TCfs0RZylC94M+cspjLABhPjl7
BxfHQvaN3Ui6akQI29LXb08yeOqreuYjm9Ef950cURrELGY7Dj+wb+sOiPNi9bxR
p5d92rtd2s3B4mChgj7cOYI7BoYox7gDUx04p0r7om2t0fDuEyT+gkXkHQ78LiMZ
9HBeYK9cmEzDNA6JNGowhnEqpctkNpSvjku9lLvI9bkKnyaDtWir3TvQcwg71tFi
+3wZcltm92Q2PefvakCEK0zSNxcbh99qHh9JxdArWD2cytORpPieHOMLAIVaTO8a
dNCkLsYwJluc5GbEZa/vv6IuN+4P0xmyJV9epTRBbaj4+4fwCJDoYrKeUYgI6Pc4
wgenujh7L23QhV0SvCA7sCKoKmPj2GWFAK4qn3oCP+qiE9PasL4j98J5eEgZ+G+L
gnB2n553hETw0FsudvnwVnFUb4+sdzX3FJp+nDzHrO1amAX2ac75kBNDWMB0J7t+
p3vM6zshh+K9wR/skLuKoSl+3JB0zqOcF8QgEQdiNGOUyr6h87bE5vepiqbeZhlr
Mz0cu1pG3sTrGakG/6dKytkKDN0iQXEQWrDrQEzV1KmmQlGUJp4=
=PodC
-----END PGP SIGNATURE-----

--Apple-Mail=_BAFA84F7-84EA-44B1-B015-A0558FB01868--
