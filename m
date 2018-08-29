Return-Path: <javier@cnexlabs.com>
From: Javier Gonzalez <javier@cnexlabs.com>
To: =?utf-8?B?TWF0aWFzIEJqw7hybGluZw==?= <mb@lightnvm.io>
CC: Jens Axboe <axboe@kernel.dk>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/3] lightnvm: pblk: take write semaphore on metadata
Date: Wed, 29 Aug 2018 13:21:49 +0000
Message-ID: <0FD404FB-C660-412B-9658-454A9DCD7558@cnexlabs.com>
References: <1535532980-27672-1-git-send-email-javier@cnexlabs.com>
 <1535532980-27672-4-git-send-email-javier@cnexlabs.com>
 <f4f8c276-0269-5aa5-39fc-42aecc7bb309@lightnvm.io>
In-Reply-To: <f4f8c276-0269-5aa5-39fc-42aecc7bb309@lightnvm.io>
Content-Type: multipart/signed;
	boundary="Apple-Mail=_5EAEF27E-BF6A-4AC5-9593-2B3487445F49";
	protocol="application/pgp-signature";
	micalg=pgp-sha512
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

--Apple-Mail=_5EAEF27E-BF6A-4AC5-9593-2B3487445F49
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

> On 29 Aug 2018, at 15.08, Matias Bj=C3=B8rling <mb@lightnvm.io> wrote:
>=20
> On 08/29/2018 10:56 AM, Javier Gonz=C3=A1lez wrote:
>> pblk guarantees write ordering at a chunk level through a per open =
chunk
>> semaphore. At this point, since we only have an open I/O stream for =
both
>> user and GC data, the semaphore is per parallel unit.
>> For the metadata I/O that is synchronous, the semaphore is not needed =
as
>> ordering is guaranteed. However, if the metadata scheme changes or
>> multiple streams are open, this guarantee might not be preserved.
>> This patch makes sure that all writes go through the semaphore, even =
for
>> synchronous I/O. This is consistent with pblk's write I/O model. It =
also
>> simplifies maintenance since changes in the metadata scheme could =
cause
>> ordering issues.
>> Signed-off-by: Javier Gonz=C3=A1lez <javier@cnexlabs.com>
>> ---
>>  drivers/lightnvm/pblk-core.c | 16 +++++++++++++++-
>>  drivers/lightnvm/pblk.h      |  1 +
>>  2 files changed, 16 insertions(+), 1 deletion(-)
>> diff --git a/drivers/lightnvm/pblk-core.c =
b/drivers/lightnvm/pblk-core.c
>> index 767178185f19..1e4dc0c1ed88 100644
>> --- a/drivers/lightnvm/pblk-core.c
>> +++ b/drivers/lightnvm/pblk-core.c
>> @@ -558,6 +558,20 @@ int pblk_submit_io_sync(struct pblk *pblk, =
struct nvm_rq *rqd)
>>  	return ret;
>>  }
>>  +int pblk_submit_io_sync_sem(struct pblk *pblk, struct nvm_rq *rqd)
>> +{
>> +	struct ppa_addr *ppa_list;
>> +	int ret;
>> +
>> +	ppa_list =3D (rqd->nr_ppas > 1) ? rqd->ppa_list : =
&rqd->ppa_addr;
>> +
>> +	pblk_down_page(pblk, ppa_list, rqd->nr_ppas);
>=20
> If the debug stuff is killed inside __pblk_down_page, then ppa_list
> and rqd->nr_ppas does not need to be passed, and this function can be
> inlined in its caller. Can we kill it? I'll make the patch if you
> like.

Sounds good. Sure, please send - should I wait to resend this series?


--Apple-Mail=_5EAEF27E-BF6A-4AC5-9593-2B3487445F49
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE+ws7Qq+qZPG1bJoyIX4xUKFRnnQFAluGneoACgkQIX4xUKFR
nnT5cg/+O6T6RDBtaD0dsFcwIHkjh0rWfKUWi2QZzc+gc0V5e42ddjGCY5xcWZI6
300rie/FRJr0iSzfSiulppR3/FK86VTmFym5Ye2LUqaLO4dXY39DP58fKNOaotBM
xq+4RT4PdK7+Tatbe+XkndW3+Kvdi6G5+2EQNir+yAFEXI33GZVuxwhb+3vxcej/
Jsz3QhjRXTOE1bGZX4PWFRWe0cChfVsi2Uith2jqBXVMeplDsLcjgmp/1vPRlZGC
xpTOzgegmS4UqfNX/u4/2wHt8ID9qA5KQjVFGl00kUIpzFf0pNDBjoiD/to1QU6d
y0oicYcb5WdTvxHKL1qEJxCiZbV7yx52HpWzzgAwXBtCMEKknbtutXLXmpzaZfLJ
fKcci1nsLJ0i+5QX0V4/18i0lBxp6o6BmnerlQYAIDRXf06u4nE6FtgOP4Bku8Om
Xwf1QEQhNTHNcbviiUQ+7x2oSjTyiLhZTtfax6SDlRNWxGlQkvesI+IdcWvWy09W
MZ/sk4TEOzaPz3DFC1cjEb848gstgPIQUnb5IQdsvIK82sLjiu2o9xcc7C+3715p
pDCs6/3JmrKt5xv+s0kqh675uzqUCJ2JxT/VWCxQCigPfT466btO76BAHDTAVm4F
42dZDOS7sEofbr3utCJknPIF2sSzEikCmdy6iyBJcWskDLF4/pg=
=6jS2
-----END PGP SIGNATURE-----

--Apple-Mail=_5EAEF27E-BF6A-4AC5-9593-2B3487445F49--
