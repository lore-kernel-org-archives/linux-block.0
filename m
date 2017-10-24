Return-Path: <jg@lightnvm.io>
Return-Path: <jg@lightnvm.io>
From: =?utf-8?Q?Javier_Gonz=C3=A1lez?= <jg@lightnvm.io>
Message-Id: <6E703CAF-4B4C-47BC-92FE-B6937ECBEF16@lightnvm.io>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_2DEDE1B2-519B-4A1B-9082-68BAD87F2110";
 protocol="application/pgp-signature"; micalg=pgp-sha512
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH 03/17] block: provide a direct_make_request helper
Date: Tue, 24 Oct 2017 19:57:25 +0200
In-Reply-To: <20171023145126.2471-4-hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>,
 linux-block@vger.kernel.org,
 Sagi Grimberg <sagi@grimberg.me>,
 linux-nvme@lists.infradead.org,
 Keith Busch <keith.busch@intel.com>,
 Hannes Reinecke <hare@suse.de>,
 Johannes Thumshirn <jthumshirn@suse.de>
To: Christoph Hellwig <hch@lst.de>
References: <20171023145126.2471-1-hch@lst.de>
 <20171023145126.2471-4-hch@lst.de>
List-ID: <linux-block@vger.kernel.org>


--Apple-Mail=_2DEDE1B2-519B-4A1B-9082-68BAD87F2110
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

> On 23 Oct 2017, at 16.51, Christoph Hellwig <hch@lst.de> wrote:
>=20
> This helper allows reinserting a bio into a new queue without much
> overhead, but requires all queue limits to be the same for the upper
> and lower queues, and it does not provide any recursion preventions.
>=20
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
> ---
> block/blk-core.c       | 34 ++++++++++++++++++++++++++++++++++
> include/linux/blkdev.h |  1 +
> 2 files changed, 35 insertions(+)
>=20


Reviewed-by: Javier Gonz=C3=A1lez <javier@cnexlabs.com>


--Apple-Mail=_2DEDE1B2-519B-4A1B-9082-68BAD87F2110
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEm1mT7zen+vs9+T8kYx8FO3WZGMoFAlnvfwUACgkQYx8FO3WZ
GMrdDhAAhOfitrEWu9PfR4sMZyQDM8jcTPm+WzK5Vuk6jLDi8DIeGxU7z/IdKAfH
yUI50TgRI3Ugqba2DkyU84imVdVutcx/b4vBATNrqD2BN+rIUD8MPW0o9bDboFbu
MmdilYPeDfKliRCRaLdROuD8UZPPS1Co66dmanAiIPtFhqEPjBdpvlvdCzNKNPZK
cWVF5fyo3FS2kJRrDMKuxO8HFNWNeEKqrnkKqDqOxEEWcNd1BLNLlmv3MoP4dJtC
YqN0GgCLlvcLtzZKDWfzgyJjeR/GwE1YbjXTjvph82CkWWZ3O3zL/v6XhppQTTbo
0dhoLbkEnpNY3PwDjZrC2UDUIRYCDaOuRFV0JkS9nSG9SdlJI/iyYTRU4fsCJeNF
UYeF0W6jITJgiU+/HlCw4mm8VqU9hancVFhYh5/+ZtLoGIFuChD+nQrO1FkN7iEB
GrOYnxhaG23qlPfOnEWZh3cQGA+h/bwEntBRS1Su6ZEydWs2t/jWYhY6yObvLPv2
xdkzttl9NmfF4L22Ad/NypEFoZC5PWUpCx3mIdYXXsurVjNovDyEzZXFkgG6M4wh
e1TLakGwTzrVyS9VDEmWgrOYIB07DRIGyavfTwXNoLxah9mbjtz8jOO6OtrFBfTf
fXSYPRchZ0VKRuP44VxpdyfdKu+a1N/mjAwcqOccBcPqusNz8wc=
=CyQH
-----END PGP SIGNATURE-----

--Apple-Mail=_2DEDE1B2-519B-4A1B-9082-68BAD87F2110--
