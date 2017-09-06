Return-Path: <jg@lightnvm.io>
Return-Path: <jg@lightnvm.io>
From: =?utf-8?Q?Javier_Gonz=C3=A1lez?= <jg@lightnvm.io>
Message-Id: <B52A428A-99AA-4CE3-8C30-3C2BAA30678D@lightnvm.io>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_EF8603E2-DC16-4D0C-B032-D45270BE037B";
 protocol="application/pgp-signature"; micalg=pgp-sha512
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH 1/6] lightnvm: pblk: check for failed mempool alloc.
Date: Wed, 6 Sep 2017 17:12:14 +0200
In-Reply-To: <d8295f1b-5021-e20b-ffcf-4fbbbe7c70b4@kernel.dk>
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
List-ID: <linux-block@vger.kernel.org>


--Apple-Mail=_EF8603E2-DC16-4D0C-B032-D45270BE037B
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

> On 6 Sep 2017, at 17.09, Jens Axboe <axboe@kernel.dk> wrote:
>=20
> On 09/06/2017 09:08 AM, Johannes Thumshirn wrote:
>> On Wed, Sep 06, 2017 at 05:01:01PM +0200, Javier Gonz=C3=A1lez wrote:
>>> Check for failed mempool allocations and act accordingly.
>>=20
>> Are you sure it is needed? Quoting from mempool_alloc()s =
Documentation:
>> "[...] Note that due to preallocation, this function *never* fails =
when called
>> from process contexts. (it might fail if called from an IRQ context.) =
[...]"
>=20
> It's not needed, mempool() will never fail if __GFP_WAIT is set in the
> mask. The use case here is GFP_KERNEL, which does include __GFP_WAIT.

Thanks for the clarification. Do you just drop the patch, or do you want
me to re-send the series?

I see that I do this other places, I'll clean it up for next window.

Thanks,
Javier

--Apple-Mail=_EF8603E2-DC16-4D0C-B032-D45270BE037B
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCgAGBQJZsBBOAAoJEGMfBTt1mRjKK2QQAJ0X7xaVN8t1gyngzWxoKTqq
IrNmu5qJ4o/QOV9sesbTW827hSlMvMyEuiDPQBuJC1CMqaMdGB8dnuxi+PTIg58x
fKQChFHu9ILWpapgwoWsKZUx1xktwVxziFVZ48nVhhPxS1tYieVDBdpvk0YNn47H
hbkg2rc/tMTjXCOLWyiTExDnxaOvyFpfIxEkyTbOuVo4wXwtfQFFRmWmrKJVoVau
HpJFy3xv26nbcXFhvWjP0a33MqHyyycIeaKyfSX8/+sLuClV2WQbOUb2L3+yuZFI
KGfDoDF0NzfvtvdhTpjYnxkB4tBoKVAsf7106l/oO7eWqbMj5V9/pgj1F1FhlAl3
AbKRZI3fcEvhXraQvpnq/oxlIPvqrgV0VTGWocLJJ4mmbABgzc9/1lo5Grv3W9hf
jFCJ7sdM8ogtVFGjOVjwy2RUyXZ6QryfhyXld0615yXynbOpBEhki0I8ZRN+t0cO
UstHVqndJq5eYr2wuWnhAISEaeYJ4Qgs61XihjXyL9zBLiQe5h47cOATh2U1Y6Fk
T7GXzarNejRU7pmQUP5QJpBEFFTwkapCUMXtnEZIecksFwfTSE3PobQVhF7UHsvP
s8tbWl7nRKFVEvdIZk8vj6teyxUmrSpuAglyULVnihI+MDz6pW9ROFI7MUb585k4
rzlO/gWMmQe9j/WcIADc
=q63e
-----END PGP SIGNATURE-----

--Apple-Mail=_EF8603E2-DC16-4D0C-B032-D45270BE037B--
