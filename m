Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-cys01nam02on0068.outbound.protection.outlook.com ([104.47.37.68]:16928
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753200AbeBUJfH (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 21 Feb 2018 04:35:07 -0500
From: Javier Gonzalez <javier@cnexlabs.com>
To: =?utf-8?B?TWF0aWFzIEJqw7hybGluZw==?= <mb@lightnvm.io>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH v2 0/6] lightnvm: base 2.0 implementation
Date: Wed, 21 Feb 2018 09:35:04 +0000
Message-ID: <A2E4F5B5-2545-48CC-9514-A5BCDF9A9D02@cnexlabs.com>
References: <20180215131200.3354-1-mb@lightnvm.io>
In-Reply-To: <20180215131200.3354-1-mb@lightnvm.io>
Content-Type: multipart/signed;
        boundary="Apple-Mail=_5735A141-5487-45A1-A32B-C49B7E1FCB0F";
        protocol="application/pgp-signature"; micalg=pgp-sha512
MIME-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

--Apple-Mail=_5735A141-5487-45A1-A32B-C49B7E1FCB0F
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

> On 15 Feb 2018, at 14.11, Matias Bj=C3=B8rling <mb@lightnvm.io> wrote:
>=20
> A couple of patches for 2.0 support for the lightnvm subsystem. They
> form the foundation for the integration.
>=20
> The first two patches is preparation for the 2.0 work. The third patch
> implements the 2.0 data structures, the geometry command, and exposes
> the sysfs attributes that comes with the 2.0 specification. Note that
> the attributes between 1.2 and 2.0 are different, and it is expected
> that user-space shall use the version sysfs attribute to know which
> attributes will be available.
>=20
> The next two patches removes max_phys_sect and max_rq_size, as they
> not used.
>=20
> The last patch implements support for using the nvme namespace logical
> block and metadata fields and sync it with the internal lightnvm
> identify structures.
>=20
> Changes since v2:
>=20
> - Removed blk_queue_block_size() setup in nvm_init and made sure
>   to only update csecs and sos in on the late setup path. No reason
>   to set it twice. =46rom discussion with Javier.
> - Added two extra patches, that removes max_phys_sect and
>   max_rq_size.
>=20
> Changes since v1:
>=20
> - pr_err fix from Randy.
> - Address type fix from Javier.
> - Also CC the nvme mailing list.
>=20
> Matias Bj=C3=B8rling (6):
>  lightnvm: make 1.2 data structures explicit
>  lightnvm: flatten nvm_id_group into nvm_id
>  lightnvm: add 2.0 geometry identification
>  lightnvm: remove max_rq_size
>  lightnvm: remove nvm_dev_ops->max_phys_sect
>  nvme: lightnvm: add late setup of block size and metadata
>=20
> drivers/lightnvm/core.c          |  61 ++---
> drivers/lightnvm/pblk-init.c     |   9 +-
> drivers/lightnvm/pblk-recovery.c |   8 +-
> drivers/nvme/host/core.c         |   2 +
> drivers/nvme/host/lightnvm.c     | 513 =
++++++++++++++++++++++++++++-----------
> drivers/nvme/host/nvme.h         |   2 +
> include/linux/lightnvm.h         |  71 +++---
> 7 files changed, 442 insertions(+), 224 deletions(-)
>=20
> --
> 2.11.0
>=20

The patches look good. I tested them together with pblk's 2.0 support
and all works as it should.

Reviewed-by: Javier Gonz=C3=A1lez <javier@cnexlabs.com>


--Apple-Mail=_5735A141-5487-45A1-A32B-C49B7E1FCB0F
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="signature.asc"
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE+ws7Qq+qZPG1bJoyIX4xUKFRnnQFAlqNPTwACgkQIX4xUKFR
nnSkDRAA2d4ihIDk58XZPqRuHmLdR3nREk5KpKvCXqZklv29NNjh0n2/JP38ZnJt
L4aJLkZSdU+ZMHzfdRp0Sbl9TTpPBQSHxJM332vzDy3GqHsV6G4YNgv2mYPlO9z5
x9bxO7JyWgLf9a5grjK737iHj7GsPCWYIIOOcec8d47LqDHofjrjSgb9uS07RYnR
9tWcjhl7JyOZBqW82So7uGaKYg9Rcv//4Af3nXoxebAqzOiVEoDncN2gbTsMEASi
p28brYAKQFn4LAuYiQ5XAsrjbkJwbRDdLuteacNEbnp4KbWAgIRAjc3zw+cojLTe
gFwXMKKWAX9jGvYf/JFXBfpbPR9QXTosukfc4vCa4sELe5nq9YDeQRkc9VPpotW7
HU8tbEUOQXRGCL+5rAwbl9Z5egAlVFUzMIaMfuS+sBxaPLp/MAPl+SoYVqXcSY4x
M0OROy+CxjLEDEBY+tVZggSIPU8p9452GN4RiwiDpLgYJV69+IWdsSUY0qTE1zBC
WROY32QdojX5MH09LcOZKQUGI0ommUp9oMCRcp5B+uVocVOETEIGsy7rMuOq7qNL
hm+7h6JdBgN9itBzfLwJCLZrPcSzS45Y0yc5udK/eEUpMHWkgzjKtXxdncgvHZu3
THsxOsfYppughEXr4z7l+DGjz6n19d+P0tTo9KkwEcQ+oACZThU=
=9oMq
-----END PGP SIGNATURE-----

--Apple-Mail=_5735A141-5487-45A1-A32B-C49B7E1FCB0F--
