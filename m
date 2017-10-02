Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wm0-f46.google.com ([74.125.82.46]:50492 "EHLO
        mail-wm0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750788AbdJBLoi (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 2 Oct 2017 07:44:38 -0400
Received: by mail-wm0-f46.google.com with SMTP id u138so9962247wmu.5
        for <linux-block@vger.kernel.org>; Mon, 02 Oct 2017 04:44:37 -0700 (PDT)
From: =?utf-8?Q?Javier_Gonz=C3=A1lez?= <jg@lightnvm.io>
Message-Id: <01F673AF-1707-4717-A822-3A554E4EA229@lightnvm.io>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_9D53BFE9-387A-4BB4-8474-EFF2FC982948";
 protocol="application/pgp-signature"; micalg=pgp-sha512
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH] lightnvm: pblk: fix changing GC group list for a line
Date: Mon, 2 Oct 2017 13:44:35 +0200
In-Reply-To: <20171002114344.GA3526@dhcp-216.srv.tuxera.com>
Cc: =?utf-8?Q?Matias_Bj=C3=B8rling?= <mb@lightnvm.io>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
To: Rakesh Pandit <rakesh@tuxera.com>
References: <20170928143828.GA7645@hercules.tuxera.com>
 <5656C93D-F3DF-4054-906C-C27542D265CA@lightnvm.io>
 <20171002114344.GA3526@dhcp-216.srv.tuxera.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org


--Apple-Mail=_9D53BFE9-387A-4BB4-8474-EFF2FC982948
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

> On 2 Oct 2017, at 13.43, Rakesh Pandit <rakesh@tuxera.com> wrote:
>=20
> On Mon, Oct 02, 2017 at 01:27:42PM +0200, Javier Gonz=C3=A1lez wrote:
>>> On 28 Sep 2017, at 16.40, Rakesh Pandit <rakesh@tuxera.com> wrote:
>>>=20
>>> pblk_line_gc_list seems to had a bug since the introduction of pblk =
in
>>> getting GC list for a line.  In b20ba1bc7 while redesigning GC
>>> algorithm it was not fixed correctly.  The problem is that even if
>>> valid sector count (vsc) is less that mid_thrs (threshold for GC mid
>>> list) it would always satisfy 'vsc < high_thrs' as high_thrs >
>>> mid_thrs always.
>>>=20
>>> Fixes: a4bd217b4("lightnvm: physical block device (pblk) target")
>>> Signed-off-by: Rakesh Pandit <rakesh@tuxera.com>
>>> ---
>>> drivers/lightnvm/pblk-core.c | 10 +++++-----
>>> 1 file changed, 5 insertions(+), 5 deletions(-)
>>>=20
>>> diff --git a/drivers/lightnvm/pblk-core.c =
b/drivers/lightnvm/pblk-core.c
>>> index 8150164..93a58ed 100644
>>> --- a/drivers/lightnvm/pblk-core.c
>>> +++ b/drivers/lightnvm/pblk-core.c
>>> @@ -295,16 +295,16 @@ struct list_head *pblk_line_gc_list(struct =
pblk *pblk, struct pblk_line *line)
>>> 			line->gc_group =3D PBLK_LINEGC_FULL;
>>> 			move_list =3D &l_mg->gc_full_list;
>>> 		}
>>> -	} else if (vsc < lm->high_thrs) {
>>> -		if (line->gc_group !=3D PBLK_LINEGC_HIGH) {
>>> -			line->gc_group =3D PBLK_LINEGC_HIGH;
>>> -			move_list =3D &l_mg->gc_high_list;
>>> -		}
>>> 	} else if (vsc < lm->mid_thrs) {
>>> 		if (line->gc_group !=3D PBLK_LINEGC_MID) {
>>> 			line->gc_group =3D PBLK_LINEGC_MID;
>>> 			move_list =3D &l_mg->gc_mid_list;
>>> 		}
>>> +	} else if (vsc < lm->high_thrs) {
>>> +		if (line->gc_group !=3D PBLK_LINEGC_HIGH) {
>>> +			line->gc_group =3D PBLK_LINEGC_HIGH;
>>> +			move_list =3D &l_mg->gc_high_list;
>>> +		}
>>> 	} else if (vsc < line->sec_in_line) {
>>> 		if (line->gc_group !=3D PBLK_LINEGC_LOW) {
>>> 			line->gc_group =3D PBLK_LINEGC_LOW;
>>> --
>>> 2.9.3
>>=20
>> You're right that the naming for high/mid/low was not updated when
>> aligning vsc with GC thresholds. But the fix should be making high,
>> being high, instead of reordering when moving into the GC bucket.
>>=20
>> Does it make sense to you?
>=20
> Yes.
>=20

Cool. I'll fix it when picking it up.

Javier

--Apple-Mail=_9D53BFE9-387A-4BB4-8474-EFF2FC982948
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEm1mT7zen+vs9+T8kYx8FO3WZGMoFAlnSJqMACgkQYx8FO3WZ
GMpruRAA3mQCua56fhSvDs30qB94NwS36SraQCQXfig1/S0GEVyDFiU4+9Tby45K
IhAkgQBh16BKNYRseWx1D8b63Ayh1bPJ0wXU0LzcJyNcTYp8CWgIguShK1F4TIiX
J/513i4V16knbZKDCqy2eJYy+YCYPwEJiAFA3OtqljO6LEpW3JrZk4qUvVPPB1Th
KGXbywvHeTvjWaC5D1feyjJZpZ1o9xGYIPw9JaiAMQv0GYDoJZtaTBPY+6Di1qzQ
hOaffR3FBWpGCWMP/Ue3PzIuwQ/U1AQaM/UQBoSldfjcCOBAdIYwHC1kVD7xrLgx
cGbDSU0Zo9f6gVTbXiOLiMrYAKpkZ5pNOTDBp0nT8K1dqM6yWSOkgaqh0qeEZASG
KKphFxSN1SNe2Z1vbRh4HUkYeCIQJvPSj+AxzDv2oKdtiRDMxZ55rnMMz/QcnOr7
YPTAaK/g5JuEfF5FfWH7SrezDy4HKI2ovYgBJgkuTsqnB6vZqIa84U861ViHl9BS
wuexdFN0kwmWxFRvcWga4YekUiYvup4kZzXZCIE/5zNv9RLNQz8aAtwf9kP5LXE2
l7GVAIVFVEHODscWTp01OfMExY+7OxXIWnNqIL4T2TGE/Q5/ArMSFFWslwk47F5X
lBPVu2fTbVR5tmewk1bhClFQDO8xg0uG8PskronPYJUpmsiqSX8=
=Qp3t
-----END PGP SIGNATURE-----

--Apple-Mail=_9D53BFE9-387A-4BB4-8474-EFF2FC982948--
