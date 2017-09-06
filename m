Return-Path: <jg@lightnvm.io>
Return-Path: <jg@lightnvm.io>
From: =?utf-8?Q?Javier_Gonz=C3=A1lez?= <jg@lightnvm.io>
Message-Id: <306D993B-11C3-4F60-A8D9-EE77E94C3B1F@lightnvm.io>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_086291E4-66E4-40FB-B5CF-1ACD7C10B927";
 protocol="application/pgp-signature"; micalg=pgp-sha512
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH 1/6] lightnvm: pblk: check for failed mempool alloc.
Date: Wed, 6 Sep 2017 17:14:53 +0200
In-Reply-To: <086e6df7-65d8-57b7-6605-d585985a3ddf@kernel.dk>
Cc: Johannes Thumshirn <jthumshirn@suse.de>,
 =?utf-8?Q?Matias_Bj=C3=B8rling?= <mb@lightnvm.io>,
 linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 =?utf-8?Q?Matias_Bj=C3=B8rling?= <matias@cnexlabs.com>
To: Jens Axboe <axboe@kernel.dk>
References: <1504710066-4699-1-git-send-email-javier@cnexlabs.com>
 <1504710066-4699-2-git-send-email-javier@cnexlabs.com>
 <20170906150811.sa3vrrkbpv5rffeb@linux-x5ow.site>
 <d8295f1b-5021-e20b-ffcf-4fbbbe7c70b4@kernel.dk>
 <B52A428A-99AA-4CE3-8C30-3C2BAA30678D@lightnvm.io>
 <086e6df7-65d8-57b7-6605-d585985a3ddf@kernel.dk>
List-ID: <linux-block@vger.kernel.org>


--Apple-Mail=_086291E4-66E4-40FB-B5CF-1ACD7C10B927
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

> On 6 Sep 2017, at 17.13, Jens Axboe <axboe@kernel.dk> wrote:
>=20
> On 09/06/2017 09:12 AM, Javier Gonz=C3=A1lez wrote:
>>> On 6 Sep 2017, at 17.09, Jens Axboe <axboe@kernel.dk> wrote:
>>>=20
>>> On 09/06/2017 09:08 AM, Johannes Thumshirn wrote:
>>>> On Wed, Sep 06, 2017 at 05:01:01PM +0200, Javier Gonz=C3=A1lez =
wrote:
>>>>> Check for failed mempool allocations and act accordingly.
>>>>=20
>>>> Are you sure it is needed? Quoting from mempool_alloc()s =
Documentation:
>>>> "[...] Note that due to preallocation, this function *never* fails =
when called
>>>> from process contexts. (it might fail if called from an IRQ =
context.) [...]"
>>>=20
>>> It's not needed, mempool() will never fail if __GFP_WAIT is set in =
the
>>> mask. The use case here is GFP_KERNEL, which does include =
__GFP_WAIT.
>>=20
>> Thanks for the clarification. Do you just drop the patch, or do you =
want
>> me to re-send the series?
>=20
> No need to resend. I'll pick up the others in a day or two, once =
people
> have had some time to go over them.
>=20

Thanks. And apologies for the delay on the patches...

Javier

--Apple-Mail=_086291E4-66E4-40FB-B5CF-1ACD7C10B927
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCgAGBQJZsBDuAAoJEGMfBTt1mRjKgPUQANeb0TWvWVxMFY6/FLjCeHQC
KBbaAU2ipGhisz48CqAMV3jksHjjgvdoSjtgThhrqooOM3bWlL8SnTMDh4FfyAHy
moL0uVYp+1FfUVIK3SqRrsDprqziR1lfZL68/4ApFIMSOvNF+QW7oL/4P+rNDzc/
+ldCaZiV59Uiszq/Ye6qG9OvaPHscIFm5jg0+U2xDbnyLSJtYt08KCNe5UnlCJ7Y
ZT/32aVIvU0oAgTNdfjKEQt0TXSzDHv5ld0l9nLxVFNPEx+bz8DtgJsyiDRHhrbh
SKQSprirkM3NT0JcVTb4RKMgUEIu6f4q4BtCacLeuWmiqtfAYqKk+Wfy/m+A5efC
AjJ1NGT6mITNhBJ4xHFHtyN3yNH03tDz/VcHXz/pqQLWVYZknKZ1PXMQRtGfW4G8
H+LHgTg1wioM47RZ8RIOIAkXlh3F4M3Ph/8UXdNB4kGo4LEJssPnsClUabEMQCTy
Jl9esuUCERkKTD1DN7mtt2jUhWK0oElGre0Zet9DJ9lvBz/uJtQF1vxz8fFXInZH
FxniQZDyZbIo82cAc3wgzFTTCuBAf4Fjhi4y6SFGA8txA31K6JD7k0MBcR8J11s1
QBupT62rQGtu6SYN+qHmQ5FlN3Mh5ZvlF4o8yOROPg1H2nzMVU/HZvh7fgjYQwcN
vV9tdGma/3pj945cGt/g
=80sm
-----END PGP SIGNATURE-----

--Apple-Mail=_086291E4-66E4-40FB-B5CF-1ACD7C10B927--
