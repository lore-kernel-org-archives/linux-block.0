Return-Path: <jg@lightnvm.io>
Return-Path: <jg@lightnvm.io>
From: =?utf-8?Q?Javier_Gonz=C3=A1lez?= <jg@lightnvm.io>
Message-Id: <C20F22B7-262E-4C58-972F-DA71AF8FA3B5@lightnvm.io>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_3A4DD65C-B589-4081-9474-6844CB3C2CB8";
 protocol="application/pgp-signature"; micalg=pgp-sha512
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH] lightnvm: pblk: advance bio according to lba index
Date: Thu, 27 Jul 2017 18:33:17 +0200
In-Reply-To: <11d126aa-e04c-bec3-80fd-77baa37a0575@kernel.dk>
Cc: =?utf-8?Q?Matias_Bj=C3=B8rling?= <mb@lightnvm.io>,
 linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org
To: Jens Axboe <axboe@kernel.dk>
References: <1501166990-24366-1-git-send-email-javier@javigon.com>
 <1501166990-24366-2-git-send-email-javier@javigon.com>
 <11d126aa-e04c-bec3-80fd-77baa37a0575@kernel.dk>
List-ID: <linux-block@vger.kernel.org>


--Apple-Mail=_3A4DD65C-B589-4081-9474-6844CB3C2CB8
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

> On 27 Jul 2017, at 18.31, Jens Axboe <axboe@kernel.dk> wrote:
>=20
> On 07/27/2017 08:49 AM, Javier Gonz=C3=A1lez wrote:
>> When a lba either hits the cache or corresponds to an empty entry in =
the
>> L2P table, we need to advance the bio according to the position in =
which
>> the lba is located. Otherwise, we will copy data in the wrong page, =
thus
>> causing data corruption for the application.
>>=20
>> In case of a cache hit, we assumed that bio->bi_iter.bi_idx would
>> contain the correct index, but this is no necessarily true. Instead, =
use
>> the local bio advance counter and iterator. This guarantees that lbas
>> hitting the cache are copied into the right bv_page.
>>=20
>> In case of an empty L2P entry, we omitted to advance the bio. In the
>> cases when the same I/O also contains a cache hit, data corresponding
>> to this lba will be copied to the wrong bv_page. Fix this by =
advancing
>> the bio as we do in the case of a cache hit.
>>=20
>> Fixes: a4bd217b4326 lightnvm: physical block device (pblk) target
>>=20
>> Signed-off-by: Javier Gonz=C3=A1lez <javier@javigon.com>
>> ---
>> drivers/lightnvm/pblk-rb.c   |  4 ++--
>> drivers/lightnvm/pblk-read.c | 19 ++++++++++++++-----
>> drivers/lightnvm/pblk.h      |  2 +-
>> 3 files changed, 17 insertions(+), 8 deletions(-)
>>=20
>> diff --git a/drivers/lightnvm/pblk-rb.c b/drivers/lightnvm/pblk-rb.c
>> index 5ecc154f6831..2e88c3d6d9a1 100644
>> --- a/drivers/lightnvm/pblk-rb.c
>> +++ b/drivers/lightnvm/pblk-rb.c
>> @@ -657,7 +657,7 @@ unsigned int pblk_rb_read_to_bio(struct pblk_rb =
*rb, struct nvm_rq *rqd,
>>  * be directed to disk.
>>  */
>> int pblk_rb_copy_to_bio(struct pblk_rb *rb, struct bio *bio, sector_t =
lba,
>> -			struct ppa_addr ppa, int bio_iter)
>> +			struct ppa_addr ppa, int bio_iter, int =
advanced_bio)
>=20
> This would be cleaner as a 'bool advance_bio' as both the type and as =
a
> reversed info on whether to do the advance or not.

I'll fix it.

Thanks Jens.

Javier

--Apple-Mail=_3A4DD65C-B589-4081-9474-6844CB3C2CB8
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCgAGBQJZehXOAAoJEGMfBTt1mRjKlgoP/3icKly/64VPNl+Oq1kgtDTG
YguVAacCNwGRkcsTsjyoY+5ffj4i41etzB1+FzxycXmVZzRTpLmJtFqn/G2VdzeC
TsdBnGIEUuvBbYAPuj7A8hTS2D7LZeKholjUOMaHtYqWQUx4usXMmmJzw+gfURYg
Kb1qXOy3dBIO/lk7dYc/doy4uJSJLnQak/USuhT4vnREsBf4ruQ9b86IDxbsOin8
/sYLV6Bc8lHIKkKqMxvATgg1l4hwESvcz9CythbOCUckKyilnqJDpR8fh+TUWeot
NmZHd9tYT+ud/wmyn4URMqv9Sd/U3jEU9QYWQ3+mdLVRz+nLgzXLvxrP5T9gtfhN
bkdKIIzXF6aE6sdR5eNtZTPGPBxtmMcraQFD1O3lPJ5qsiN7oMQ7z7XRlWHemop9
YR4Sza6X1fUIfU1mbwhQAvMYYQcakcU6/FhRKrbt6a0/26fUvklMnaMpZlGiMC8+
DjjA+5Eqgux7KIqG6qpBqLlv16256mofA4CmxnQJOv4orFtiVzeR6oat2Be8okv0
fWPoHkAfejFNr5FDIl+oCJIsRddYAQp6bQREolhAvL6BQ5GL/AX/mtvC8FGuMyAf
cki6ZhR2kLbzjb20IY/0K3mMjHK9BgSrMNxBbGIsgdDFIJnRPWq/qC8LPpxxrHd3
KYi9EHWhy3o5zb7exPv/
=9fZj
-----END PGP SIGNATURE-----

--Apple-Mail=_3A4DD65C-B589-4081-9474-6844CB3C2CB8--
