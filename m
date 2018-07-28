Return-Path: <ps@pks.im>
Date: Sat, 28 Jul 2018 20:50:49 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Bart Van Assche <Bart.VanAssche@wdc.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"axboe@kernel.dk" <axboe@kernel.dk>,
	"ming.lei@redhat.com" <ming.lei@redhat.com>
Subject: Re: [PATCH] block: fix NPE when resuming SCSI devices using blk-mq
Message-ID: <20180728185049.GA1663@xps.pks.im>
References: <b712b87a509dc64619a3aec7c673935ed09be5de.1531488173.git.ps@pks.im>
 <fda284b59b2401d3d44a1343f809b98a8ae69be7.camel@wdc.com>
 <20180726083850.GB1674@ncase>
 <62ddc886d005b91bd6a1bd8775259bb0b5cbe2b2.camel@wdc.com>
 <20180727123533.GA1588@xps>
 <6f00aeea242c20be1e2709bb00d27d79a8a8facf.camel@wdc.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="HcAYCG3uE/tztfnV"
In-Reply-To: <6f00aeea242c20be1e2709bb00d27d79a8a8facf.camel@wdc.com>
List-ID: <linux-block@vger.kernel.org>


--HcAYCG3uE/tztfnV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 27, 2018 at 03:03:09PM +0000, Bart Van Assche wrote:
> On Fri, 2018-07-27 at 14:35 +-0200, Patrick Steinhardt wrote:
> +AD4- +ADw-1+AD4AWw-   53.411700+AF0- BUG: unable to handle kernel NULL p=
ointer dereference at 00000000000001a8
> +AD4- +ADw-4+AD4AWw-   53.411733+AF0- RIP: 0010:blk+AF8-set+AF8-runtime+A=
F8-active+-0x2d/0x50
>=20
> Are you sure commit 4fd41a8552af (+ACI-SCSI: Fix NULL pointer dereference=
 in
> runtime PM+ACIAOw- December 2015) is in your kernel tree?
>=20
> Bart.

Yes, I am:

$ git describe
v4.17.10
$ git tag --contains 4fd41a8552af v4.17.10
v4.17.10

I've also manually verified that all changes from 4fd41a8552af
are contained in the sources, which they are.

Patrick

--HcAYCG3uE/tztfnV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEtmscHsieVjl9VyNUEXxntp6r8SwFAltcuwkACgkQEXxntp6r
8SzWcxAAo63TnLCelq2Qiiq8IhRmVpxmleOBbyoIjQp3aDailcssYYHlZx+kboC6
Sp660kZM6cihgb+13vecYE1+8kkQB4J7LL8eTSKviMFNyvjmFC55/DgBgbhKSTz9
JU5eBc4XOvEoTNC5rc25XnT8PbsQ5RezcjrG+6JNQjdHwZQqe24uc88aUhtSWT6C
p3REL2qUR8FOhpM1qoDfML73sXFQMc0defJFAQOrW9gd412qB3TJuNkNa7p5ezp2
NPN7yQ38bMHb7SP30VfyodL0gIL7LedrwzZFGUEXdTdUEgFlth98+7MXcrLV5lNc
bImL6K/t4jJmsy4OY/odt4urte2o9YIUvgXi87J1W7n5dl5K9okFobiGjLvSrTcq
NWDihpUEC8el2bK6txcMiXyGip7B0nr77YYZxALbd1cgJHAhK3mTWnjLN3wvGYDy
3NNVlpeDQ0F72p2tldeXosUu+wFdN0kowLXQLfnmIRn6rbBOnQ9231Sjx0EYa62t
2vEAJV8y4QGjaOBXTh6WycqvjAZdxkIxkZK+57BM0fYGZFHApfVvS+FJ/j81mFJm
Iis2VJYhPXUw+4Abbswn4mURFzznKE8Krz/emfXt+r/58OTbXGxjLt8mtbASTwOy
HDmEELKXUktzqY5W6dOOfevqpHn0ZXSes5yR61cjWcVcyaFH5h8=
=luaM
-----END PGP SIGNATURE-----

--HcAYCG3uE/tztfnV--
