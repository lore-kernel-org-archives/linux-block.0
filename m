Return-Path: <javier@cnexlabs.com>
From: Javier Gonzalez <javier@cnexlabs.com>
To: =?utf-8?B?TWF0aWFzIEJqw7hybGluZw==?= <mb@lightnvm.io>
CC: Jens Axboe <axboe@kernel.dk>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/3] lightnvm: pblk: take write semaphore on metadata
Date: Wed, 29 Aug 2018 13:41:59 +0000
Message-ID: <73B50ACA-C2CE-4A85-A352-94EBD5E6884C@cnexlabs.com>
References: <1535532980-27672-1-git-send-email-javier@cnexlabs.com>
 <1535532980-27672-4-git-send-email-javier@cnexlabs.com>
 <f4f8c276-0269-5aa5-39fc-42aecc7bb309@lightnvm.io>
 <0FD404FB-C660-412B-9658-454A9DCD7558@cnexlabs.com>
 <1911b06f-ddb5-40fd-f822-702ae725bade@lightnvm.io>
In-Reply-To: <1911b06f-ddb5-40fd-f822-702ae725bade@lightnvm.io>
Content-Type: multipart/signed;
	boundary="Apple-Mail=_105B497E-7AFF-4808-AEEC-204B0DF856DA";
	protocol="application/pgp-signature";
	micalg=pgp-sha512
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

--Apple-Mail=_105B497E-7AFF-4808-AEEC-204B0DF856DA
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8


> On 29 Aug 2018, at 15.40, Matias Bj=C3=B8rling <mb@lightnvm.io> wrote:
>=20
> On 08/29/2018 03:21 PM, Javier Gonzalez wrote:
>>> On 29 Aug 2018, at 15.08, Matias Bj=C3=B8rling <mb@lightnvm.io> =
wrote:
>>>=20
>>> On 08/29/2018 10:56 AM, Javier Gonz=C3=A1lez wrote:
>>>> pblk guarantees write ordering at a chunk level through a per open =
chunk
>>>> semaphore. At this point, since we only have an open I/O stream for =
both
>>>> user and GC data, the semaphore is per parallel unit.
>>>> For the metadata I/O that is synchronous, the semaphore is not =
needed as
>>>> ordering is guaranteed. However, if the metadata scheme changes or
>>>> multiple streams are open, this guarantee might not be preserved.
>>>> This patch makes sure that all writes go through the semaphore, =
even for
>>>> synchronous I/O. This is consistent with pblk's write I/O model. It =
also
>>>> simplifies maintenance since changes in the metadata scheme could =
cause
>>>> ordering issues.
>>>> Signed-off-by: Javier Gonz=C3=A1lez <javier@cnexlabs.com>
>>>> ---
>>>>  drivers/lightnvm/pblk-core.c | 16 +++++++++++++++-
>>>>  drivers/lightnvm/pblk.h      |  1 +
>>>>  2 files changed, 16 insertions(+), 1 deletion(-)
>>>> diff --git a/drivers/lightnvm/pblk-core.c =
b/drivers/lightnvm/pblk-core.c
>>>> index 767178185f19..1e4dc0c1ed88 100644
>>>> --- a/drivers/lightnvm/pblk-core.c
>>>> +++ b/drivers/lightnvm/pblk-core.c
>>>> @@ -558,6 +558,20 @@ int pblk_submit_io_sync(struct pblk *pblk, =
struct nvm_rq *rqd)
>>>>  	return ret;
>>>>  }
>>>>  +int pblk_submit_io_sync_sem(struct pblk *pblk, struct nvm_rq =
*rqd)
>>>> +{
>>>> +	struct ppa_addr *ppa_list;
>>>> +	int ret;
>>>> +
>>>> +	ppa_list =3D (rqd->nr_ppas > 1) ? rqd->ppa_list : =
&rqd->ppa_addr;
>>>> +
>>>> +	pblk_down_page(pblk, ppa_list, rqd->nr_ppas);
>>>=20
>>> If the debug stuff is killed inside __pblk_down_page, then ppa_list
>>> and rqd->nr_ppas does not need to be passed, and this function can =
be
>>> inlined in its caller. Can we kill it? I'll make the patch if you
>>> like.
>> Sounds good. Sure, please send - should I wait to resend this series?
>=20
> Will do. Yes, wait a bit. I'll post asap.

No hurry. Thanks!

--Apple-Mail=_105B497E-7AFF-4808-AEEC-204B0DF856DA
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE+ws7Qq+qZPG1bJoyIX4xUKFRnnQFAluGop0ACgkQIX4xUKFR
nnQVkxAAhf7eg7yCuhfAKee7f+/ggvjTOR2kijGo3WLX5SWbIJP47QIojHLt/3Hg
7D25WcW7pePOHPJZYjDHbtX6ytz824UnRggJlIt7s8kbJfFl1uauoaiU4D0yMn+R
8iK6w2jRTWsGUzqR3ZFx7EL2D10L65LO3aX8d8nDEza9dmjDzqgxTVlJScfVAZNG
EOAuS6vni8+7cuIEoGPcqL1d3Yk4y8X36eSE0ilZahfk/o1szSRShLHUJ32oBQ+7
UrGR8r64OgaaqOTu4dF2CVr4XIXD6ukyYCcoYhVERLK5dLSu2W0xIFvr0Lv1fs2i
ifanj08O4EWj5XM9+XT1iMAgvrGM7stADoPZCyf5Qo+fxKZuzZlCSgKz+F2yCfju
Nmp5q9MylavfAqX9sBED3vAnSp7RF7HgwCkgF9E/DaTTsCHTJqgIbpWyyBDkP864
r0TII37bzjRU3RUANk1KZiYrbvFB97wpCYU9PuQcVHP0Oj9NRvCbT6cSx2WowmzJ
gpL72/45BLnhoKC3eFJd+PDLwH+C/kBWSv66QPwS5+om9OpSzWeMUsB7+FiRVJHd
bdI1FBsoD1rfBNMhLbp+64XOCRq0zPdSb7wfdGV4SDoTC24G71gQMGZaJNp0QXX9
cckXY/fzDwWFqwMGrQqye9pgbx8ddFxUufkOMmHmvfdGDVQAshM=
=r0BM
-----END PGP SIGNATURE-----

--Apple-Mail=_105B497E-7AFF-4808-AEEC-204B0DF856DA--
