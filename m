Return-Path: <ps@pks.im>
Date: Mon, 30 Jul 2018 09:59:49 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Tomas Janousek <tomi@nomi.cz>
Cc: Ming Lei <tom.leiming@gmail.com>, Jens Axboe <axboe@kernel.dk>,
	linux-block <linux-block@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] block: fix NPE when resuming SCSI devices using blk-mq
Message-ID: <20180730075949.GA1755@xps.pks.im>
References: <b712b87a509dc64619a3aec7c673935ed09be5de.1531488173.git.ps@pks.im>
 <CACVXFVPoO7kcEnUVmqGVWDgiTVYup2sD9puBZ8FzY+mDaMp-bQ@mail.gmail.com>
 <20180729094131.4kwuukzgfgtisgya@notes.lisk.in>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="5vNYLRcllDrimb99"
In-Reply-To: <20180729094131.4kwuukzgfgtisgya@notes.lisk.in>
List-ID: <linux-block@vger.kernel.org>


--5vNYLRcllDrimb99
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jul 29, 2018 at 11:41:31AM +0200, Tomas Janousek wrote:
> Hi,
>=20
> On Fri, Jul 13, 2018 at 09:41:41PM +0800, Ming Lei wrote:
> > Now runtime PM is disabled for blk-mq/scsi_mq, not sure how this issue =
is
> > triggered on your machine.
>=20
> While Patrick did miss the following patch:
>=20
> * 765e40b675a9 ("block: disable runtime-pm for blk-mq"; July 2017).
>=20
> there is at least one other way to trigger it -- enable laptop-mode-tools
> or tlp which enable runtime-pm for all devices.
>=20
> The "disable runtime-pm for blk-mq" only disables it _by_default_, but do=
esn't
> prevent it from being enabled again from user-space, which it is unless o=
ne
> manually blacklists sd devices from runtime-pm enablement. It's bitten a =
few
> people already: https://github.com/rickysarraf/laptop-mode-tools/issues/1=
23
>=20
> (I found this thread because I'm also getting the NULL pointer dereferenc=
e at
> 00000000000001a8 on resume from suspend.)

Huh, I did send out some more details on how I reproduce the
issue, but it seems like my mail didn't get through. While I
don't use laptop-mode-tools, I do have some custom hotplugging
scripts which do in fact enable runtime-PM for most devices.

Regards
Patrick

--5vNYLRcllDrimb99
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEtmscHsieVjl9VyNUEXxntp6r8SwFAltexXUACgkQEXxntp6r
8SyzOg//T0tHxr7/QEE+jM9OHI6NouFFHh7CubJtlZk9Ocv0VQv/4AY9zSfkkqQ/
9gkGaRnSbM7J7IMdAMsjDkDB+5FUw7uKIFB+0zCxjUK09Zq9jnhw0yiWMCiwOedh
v96KLiacbIa/l6E+h+xMStNv0goGQcF3AzHlDKjgtstJSnL7aD7XX4URve4YeSuQ
AAq3yQUbk8tPZcnlJm9SwTXUd6MOoYjCsdl6ptPl7Z1iNrf3ZhGoUzPUaUoG3RE3
4ZqM74Y3KOHTBhXzyZkoz/SFkUghHJGdaZMm7zk8ApfhQAGw0573JPsH4pj4z7h6
b0ad2PYmLn8O2c22w6THQMyVO1HaUQg6ngJfTzZHSaGlwqxNFfAKcwYBbAFUS+fQ
Wb6YlIopC2MVYyAK21r+0p50SntCULRu04ptRFe0gILpfc0JnY89DYOPwk7yEClB
OXyUKbRXCm/+USe9kKx4vFRzJVdL5Ubohu6v7da6Lm8C6YqZC/o9fYYegrzZdIKB
TAZQWhRiscXPqdD2lZtmTpKFp2QuKcbWwi7PSrP4jz2gar/s8xN7LATQThSPOEkK
x+uuGQWFaqGQTHDwn7ViRCXX2rtTysu0Q6fztZ3wc75T7fIzkk98XfAPGGbG5pFV
qOUKuC7MJaGMOc9g3LJSXblqZUgW/liSvGB7aSecWXVAV2LLACI=
=RrcF
-----END PGP SIGNATURE-----

--5vNYLRcllDrimb99--
