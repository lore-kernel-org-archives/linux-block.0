Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wm0-f42.google.com ([74.125.82.42]:54425 "EHLO
        mail-wm0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751265AbdJBPRB (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 2 Oct 2017 11:17:01 -0400
Received: by mail-wm0-f42.google.com with SMTP id i124so11288364wmf.3
        for <linux-block@vger.kernel.org>; Mon, 02 Oct 2017 08:17:01 -0700 (PDT)
From: =?utf-8?Q?Javier_Gonz=C3=A1lez?= <jg@lightnvm.io>
Message-Id: <5330486D-DD91-4980-B002-6BD9255835A4@lightnvm.io>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_785A5C65-68BF-4864-BF1B-59F931397921";
 protocol="application/pgp-signature"; micalg=pgp-sha512
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH 2/6] lightnvm: pblk: reduce arguments in
 __pblk_rb_update_l2p
Date: Mon, 2 Oct 2017 17:16:57 +0200
In-Reply-To: <0EF0B6C0-4335-43F8-85F3-3AF93225A01A@lightnvm.io>
Cc: Rakesh Pandit <rakesh@tuxera.com>,
        =?utf-8?Q?Matias_Bj=C3=B8rling?= <mb@lightnvm.io>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
To: =?utf-8?Q?Javier_Gonz=C3=A1lez?= <jg@lightnvm.io>
References: <20171001132352.GA5697@hercules.tuxera.com>
 <0EF0B6C0-4335-43F8-85F3-3AF93225A01A@lightnvm.io>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org


--Apple-Mail=_785A5C65-68BF-4864-BF1B-59F931397921
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

> On 2 Oct 2017, at 13.32, Javier Gonz=C3=A1lez <jg@lightnvm.io> wrote:
>=20
>> On 1 Oct 2017, at 15.23, Rakesh Pandit <rakesh@tuxera.com> wrote:
>>=20
>> We already pass the structure pointer so no need to pass the member.
>>=20
>> Signed-off-by: Rakesh Pandit <rakesh@tuxera.com>
>> ---
>> drivers/lightnvm/pblk-rb.c | 12 ++++++------
>> 1 file changed, 6 insertions(+), 6 deletions(-)
>>=20
>> diff --git a/drivers/lightnvm/pblk-rb.c b/drivers/lightnvm/pblk-rb.c
>> index 05e6b2e..920ffac 100644
>> --- a/drivers/lightnvm/pblk-rb.c
>> +++ b/drivers/lightnvm/pblk-rb.c
>> @@ -201,9 +201,9 @@ unsigned int pblk_rb_read_commit(struct pblk_rb =
*rb, unsigned int nr_entries)
>> 	return subm;
>> }
>>=20
>> -static int __pblk_rb_update_l2p(struct pblk_rb *rb, unsigned int =
*l2p_upd,
>> -				unsigned int to_update)
>> +static int __pblk_rb_update_l2p(struct pblk_rb *rb, unsigned int =
to_update)
>> {
>> +	unsigned int l2p_update =3D rb->l2p_update;
>> 	struct pblk *pblk =3D container_of(rb, struct pblk, rwb);
>> 	struct pblk_line *line;
>> 	struct pblk_rb_entry *entry;
>> @@ -213,7 +213,7 @@ static int __pblk_rb_update_l2p(struct pblk_rb =
*rb, unsigned int *l2p_upd,
>> 	int flags;
>>=20
>> 	for (i =3D 0; i < to_update; i++) {
>> -		entry =3D &rb->entries[*l2p_upd];
>> +		entry =3D &rb->entries[l2p_update];
>> 		w_ctx =3D &entry->w_ctx;
>>=20
>> 		flags =3D READ_ONCE(entry->w_ctx.flags);
>> @@ -230,7 +230,7 @@ static int __pblk_rb_update_l2p(struct pblk_rb =
*rb, unsigned int *l2p_upd,
>> 		line =3D &pblk->lines[pblk_tgt_ppa_to_line(w_ctx->ppa)];
>> 		kref_put(&line->ref, pblk_line_put);
>> 		clean_wctx(w_ctx);
>> -		*l2p_upd =3D (*l2p_upd + 1) & (rb->nr_entries - 1);
>> +		rb->l2p_update =3D (l2p_update + 1) & (rb->nr_entries - =
1);

This is wrong. It should be rb->l2p_update when doing +1, otherwise you
are not using the updated l2p_update value. The result is the pipeline
stalling as the l2p pointer is left behind.

I'll fix it when picking it up.

Please test the patches before submitting.

Javier.

--Apple-Mail=_785A5C65-68BF-4864-BF1B-59F931397921
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEm1mT7zen+vs9+T8kYx8FO3WZGMoFAlnSWGkACgkQYx8FO3WZ
GMqnAA//ZQGhx0evlyWMTVAaAfr916IjO1Ox2RMxYamvwiQPplEETlmbOJD61dQ2
8+oss8PypeQjxhPz2fLvMUPJmzxwH12X+DOajNBbmD9sl1NEMPgIDi/w/Ubo6YNo
Qjshnxt7oCzpwR1xVEVFD0wmPzpp6jNWES1GfbVCPUbBSC7ZG6ptlkcS2TgUGlqk
dIu36Jg8/jdV5BwClelgHyJqzGpfUc8frYybtx4MjzVr/x3aBA8uHu7dOQja6Nfl
njnHCj+cWnJe5MogRYWwT/qn7o/tRxzrcz6CF+rWqEcl9XLY0YXVoqQ0XK9QU55D
3kRDOEtM0r9LlXG09Y1+ljNA07q7eqBqRFs9ZhIqB4Ltz3cw9X5E4rz4324AA1KI
l3KfW7Q60E9Yk/m0XJKMbKL9ts2h/2dmjMBCh3x7fTcWVwBP0M+aVnuCd6phN7Dq
TPD6eeAmINqK+mJyQlQMXEee3p+IjutPMRii6Vyh36XVnz0auOcl9nOyck3l77rP
8Gf/v9TZ/I41MgN2J+bZAfxHDnsPthOFnZJn9pg+Fhkma+A+WpTtCAEKLLWmc/El
jymiQDL4AkD0mkdHK6chu7I1JB0/iGM2+6I6ta/ycL2xC9+coQvdTmh9x7DGyxoG
vDEq+c1jeflWsuv57j7PQsM6zxqwFmNbdh2NFrywm7uTn+waF78=
=07bw
-----END PGP SIGNATURE-----

--Apple-Mail=_785A5C65-68BF-4864-BF1B-59F931397921--
