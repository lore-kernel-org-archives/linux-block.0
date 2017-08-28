Return-Path: <javigon.napster@gmail.com>
Return-Path: <javigon.napster@gmail.com>
From: javigon <javigon.napster@gmail.com>
Message-Id: <373E3FB5-D8FC-41E3-8BDB-9474228BF7D6@gmail.com>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_1885577A-03F4-4243-9C41-A618A6D028F9";
 protocol="application/pgp-signature"; micalg=pgp-sha512
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH 07/10] nvme: track shared namespaces
Date: Mon, 28 Aug 2017 14:04:01 +0200
In-Reply-To: <20170823175815.3646-8-hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>,
 Keith Busch <keith.busch@intel.com>,
 linux-block@vger.kernel.org,
 Sagi Grimberg <sagi@grimberg.me>,
 linux-nvme@lists.infradead.org
To: Christoph Hellwig <hch@lst.de>
References: <20170823175815.3646-1-hch@lst.de>
 <20170823175815.3646-8-hch@lst.de>
List-ID: <linux-block@vger.kernel.org>


--Apple-Mail=_1885577A-03F4-4243-9C41-A618A6D028F9
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

> On 23 Aug 2017, at 19.58, Christoph Hellwig <hch@lst.de> wrote:
>=20
> Introduce a new struct nvme_ns_head [1] that holds information about
> an actual namespace, unlike struct nvme_ns, which only holds the
> per-controller namespace information.  For private namespaces there
> is a 1:1 relation of the two, but for shared namespaces this lets us
> discover all the paths to it.  For now only the identifiers are moved
> to the new structure, but most of the information in struct nvme_ns
> should eventually move over.
>=20
> To allow lockless path lookup the list of nvme_ns structures per
> nvme_ns_head is protected by SRCU, which requires freeing the nvme_ns
> structure through call_srcu.
>=20
> [1] comments welcome if you have a better name for it, the current one =
is
>    horrible.  One idea would be to rename the current struct nvme_ns
>    to struct nvme_ns_link or similar and use the nvme_ns name for the
>    new structure.  But that would involve a lot of churn.
>=20
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
> drivers/nvme/host/core.c     | 218 =
+++++++++++++++++++++++++++++++++++--------
> drivers/nvme/host/lightnvm.c |  14 +--

Nothing big here. Looks good.

Reviewed-by: Javier Gonz=C3=A1lez <javier@cnexlabs.com>

--Apple-Mail=_1885577A-03F4-4243-9C41-A618A6D028F9
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQEcBAEBCgAGBQJZpAaxAAoJEGn/+wzNTX/amp4H/RD/CYVyKahS+CweV97V9pd3
4HxYEaGSZZ+ZESbtucfnHIzvowZBox0pvwrAcspxBlMZO3z5y9+f5TaT3ci09qZO
RR2Z5TfV4Sz43wWkXYtoaeu1SLrLeBMCfbhvpo4W2us/EWwwQdpTpWkzZLKssOvv
k8F6ONEcgssKMbvbVvMb6LJYECK67YRfNJd6asShk8bzVcJBQfvSpoh4RR/OvrkE
L04dQ/5Q0GgVl0/p4NWZIi9qSf1aL0SATCB165wg2+ax66UEPF+YkAW1S5GPmYdG
IC0xLJkMd46BKN4MoBSdLwXEXCnsGiogaQFgRRXnh18KmM/QYpG8TBjOEWJrAys=
=HU1C
-----END PGP SIGNATURE-----

--Apple-Mail=_1885577A-03F4-4243-9C41-A618A6D028F9--
