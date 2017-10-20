Return-Path: <jg@lightnvm.io>
Return-Path: <jg@lightnvm.io>
From: =?utf-8?Q?Javier_Gonz=C3=A1lez?= <jg@lightnvm.io>
Message-Id: <13C5EC7C-6E04-4D10-8F6D-B816BB39CF9A@lightnvm.io>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_8B0F9BD9-DEEA-4B41-A6FF-476EF54F9554";
 protocol="application/pgp-signature"; micalg=pgp-sha512
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH 15/17] nvme: track shared namespaces
Date: Fri, 20 Oct 2017 21:03:46 +0200
In-Reply-To: <20171018165258.23212-16-hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>,
 linux-block@vger.kernel.org,
 Sagi Grimberg <sagi@grimberg.me>,
 linux-nvme@lists.infradead.org,
 Keith Busch <keith.busch@intel.com>,
 Hannes Reinecke <hare@suse.de>,
 Johannes Thumshirn <jthumshirn@suse.de>
To: Christoph Hellwig <hch@lst.de>
References: <20171018165258.23212-1-hch@lst.de>
 <20171018165258.23212-16-hch@lst.de>
List-ID: <linux-block@vger.kernel.org>


--Apple-Mail=_8B0F9BD9-DEEA-4B41-A6FF-476EF54F9554
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

Javier
> On 18 Oct 2017, at 18.52, Christoph Hellwig <hch@lst.de> wrote:
>=20
> Introduce a new struct nvme_ns_head that holds information about an =
actual
> namespace, unlike struct nvme_ns, which only holds the per-controller
> namespace information.  For private namespaces there is a 1:1 relation =
of
> the two, but for shared namespaces this lets us discover all the paths =
to
> it.  For now only the identifiers are moved to the new structure, but =
most
> of the information in struct nvme_ns should eventually move over.
>=20
> To allow lockless path lookup the list of nvme_ns structures per
> nvme_ns_head is protected by SRCU, which requires freeing the nvme_ns
> structure through call_srcu.
>=20
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Keith Busch <keith.busch@intel.com>
> ---
> drivers/nvme/host/core.c     | 192 =
+++++++++++++++++++++++++++++++++++++------
> drivers/nvme/host/lightnvm.c |  14 ++--
> drivers/nvme/host/nvme.h     |  21 ++++-
> 3 files changed, 192 insertions(+), 35 deletions(-)
>=20
>=20
LGTM

Reviewed-by: Javier Gonz=C3=A1lez <javier@cnexlabs.com>


--Apple-Mail=_8B0F9BD9-DEEA-4B41-A6FF-476EF54F9554
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEm1mT7zen+vs9+T8kYx8FO3WZGMoFAlnqSJIACgkQYx8FO3WZ
GMqBSxAAz42iQQngHycI5BjgxA4lczEo2/snvNJ9/DOsL0RwlywQAEs8Mpo/zlCC
LqPmbfYkKHl+vcMGUmCTnbT2u88MEw+S+zNWV2bpZ8wiy8b7I6QOsCfB9pffZDMk
+Fe7MOsNEHwGkYvbQxICezC3HZF4Qx+OBHvy3Ap2voLTk3HkU33/FAHD4bsyjsdc
1JUBj4QnpsPKfvdCYmFJDUaRM+/FD6iGtZ1UbSVB4uQK9QVyFPvpShdyQiJrxRuI
DDTfk/XxKxkKuKAYoL94NUMC/yqwq4RnhQz/op4N/X48rDsAeLlWgmTuKDZ2ppvk
PAx/Wnb6NBgAQDrgGuF2kGsqWo193sRwSFgZkohnNLf46mrG7HoSDqzWWwj04lvq
OJzZYijs3NVWH2QDfzxc8DbhTDCAAPNsqlQA2LkMAKT9f6t5KNJHQVAFHUuwd6aU
bOc0idAN4xr2uynuSN9Fk+PxUnxbWIJUDdfn3IkSFAPnKbsjyGg73f+vrZuoysFh
wa4RGLC3qnfn06Ri5wRM/jVoy1vcXLb3bbSuy0P9OLzdYfNlrekS9BHuY4hKHkyE
U4mOu4d0pqReHDBhPs+tWewu+g5eVAb4rpUPVMaiggl7QcpTzk0eOHj70V2zlv3m
k58dZ8QDjYTx51apYjlIkxPRCochfcl/gQ+pT5wevw4r/+MHx3k=
=nq5B
-----END PGP SIGNATURE-----

--Apple-Mail=_8B0F9BD9-DEEA-4B41-A6FF-476EF54F9554--
