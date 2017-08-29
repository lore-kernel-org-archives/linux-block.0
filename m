Return-Path: <ben@decadent.org.uk>
Message-ID: <1504036184.4448.20.camel@decadent.org.uk>
Subject: Re: [PATCH 1/2] bfq: Re-enable auto-loading when built as a module
From: Ben Hutchings <ben@decadent.org.uk>
To: Jens Axboe <axboe@kernel.dk>
Cc: Paolo Valente <paolo.valente@linaro.org>, linux-block@vger.kernel.org
Date: Tue, 29 Aug 2017 20:49:44 +0100
In-Reply-To: <06a60078-1592-dc39-a2d9-df3320460bed@kernel.dk>
References: <20170813170219.GG18698@decadent.org.uk>
	 <20170829143130.GA4857@kernel.dk>
	 <1504020486.4448.13.camel@decadent.org.uk>
	 <42dfcdc3-6ba2-57d0-7cbc-9529498be365@kernel.dk>
	 <6c0f654f-3a6e-a904-c67c-bb0fec03972a@kernel.dk>
	 <1504024458.4448.18.camel@decadent.org.uk>
	 <06a60078-1592-dc39-a2d9-df3320460bed@kernel.dk>
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-prcHec1QC6w1Jitz+iOg"
Mime-Version: 1.0
List-ID: <linux-block@vger.kernel.org>


--=-prcHec1QC6w1Jitz+iOg
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2017-08-29 at 10:46 -0600, Jens Axboe wrote:
> On 08/29/2017 10:34 AM, Ben Hutchings wrote:
> > On Tue, 2017-08-29 at 09:53 -0600, Jens Axboe wrote:
> > > On 08/29/2017 09:48 AM, Jens Axboe wrote:
> > > > On 08/29/2017 09:28 AM, Ben Hutchings wrote:
> > > > > On Tue, 2017-08-29 at 08:31 -0600, Jens Axboe wrote:
> > > > > > On Sun, Aug 13 2017, Ben Hutchings wrote:
> > > > > > > The block core requests modules with the "-iosched" name
> > > > > > > suffix, but
> > > > > > > bfq no longer has that suffix.=C2=A0=C2=A0Add an alias.
> > > > > >=20
> > > > > > I'd apply these two, but both patches are mangled when saved.
> > > > > > It's
> > > > > > turning =3D=3D into =3D3D and so forth.
> > > > > >=20
> > > > > > Care to check your settings and resend?
> > > > >=20
> > > > > Just tried saving and applying with 'git am' successfully.=C2=A0=
=C2=A0I
> > > > > think the
> > > > > problem is at your end.
> > > >=20
> > > > Then yours is the only one, I apply patches people send me all day
> > > > long.
> > > > Was the case both in tbird and mutt, both of them showed the diffs
> > > > as mangled, and they showed up mangled when saved.
> > >=20
> > > Here's your email in the archive:
> > >=20
> > > https://marc.info/?l=3Dlinux-block&m=3D150264374920778&q=3Draw
> > >=20
> > > Note this part:
> > >=20
> > > Content-Transfer-Encoding: quoted-printable
> >=20
> > What about it?=C2=A0=C2=A0This is used for every mail with a non-ASCII =
name in
> > it, for example.=C2=A0=C2=A0'git am' understands it.
>=20
> What about it? It screws up the patch. Maybe git am understands it, but
> it's hard/impossible to read manually.

Where, other than the 'raw' link above, are you seeing the patch with
q-p encoding not decoded?

> I'm not going to apply anything
> that I can't personally read/review easily. Fix your setup, if you are
> going to be sending patches.

So you won't accept patches from anyone with a non-ASCII name?

Ben.

> > > Problem is definitely at your end.
> >=20
> > Or perhaps in the middle?=C2=A0=C2=A0Anyway, here are the patches again=
 as an
> > mbox.
>=20
> Feel free to browse other patches on the list, I don't see any that
> are quoted-printable. And I'd know, since I generally end up applying
> (or at least reviewing) most of them.
>=20
--=20
Ben Hutchings
Teamwork is essential - it allows you to blame someone else.


--=-prcHec1QC6w1Jitz+iOg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEErCspvTSmr92z9o8157/I7JWGEQkFAlmlxVkACgkQ57/I7JWG
EQnpmw/+IExJvsTYg9CQSCqhdJSr3cRrIfnVDUAQqanWmWNltG8A5vDVircEQlqB
K6f4fXNjbVymQDKQwP79bnrUSuxnbir8t+02DPK9CNbRgGRGIsW9FGtm6iGuLqU8
hvQsJTrAMuo1px+XAP+ojTdc8tp/AgeH+bgr8GoQuNBm6MfFVT9cWYJ/oaidxxVE
Ty8xh4uS4W9T7ON3UhcXo7twPBSzAPEIT5hfWrykf8nG7UPD/Mxc1SiIyC4XwIWd
jbNd4gh6tbLhRBVpRW54zY3naA1wSymsWYN2y2zR9wlrmrPV4AnqubvWF/dWSqcT
txSCk6aPNNpbbpTncNLZNCuVbCWcPrQ/GJhEurqLttiXUp+PyYhqTWcS3+ynJZOc
XYa7w7n9QPuyH4WvbdQVhNL6uKLOtCpxHmrAOZgSnskXPCVWAIMAT8pLT3PbU7Sl
idKeenJMusEqHH9wfCjVGYafwxFUq8S8s74WSO7f5DXZyftYXphJtvWBIO/3cI/h
8WZz6mjGZwSuo5vdTw9XKgDU22aCXx8lEClehX5S4aBI5KXbixB3OFd7TZG6BEHE
yuyB3zoGKfvvF1OS1LstJxmwQuvzFndsUYejCV81rSK25yDX5sAn9A87mmIqIIIv
A4lIVmmSnTFV6QLPuuMLOQ5Xn+8iricrvInCNlW+W43VGvJ7n3s=
=GFMx
-----END PGP SIGNATURE-----

--=-prcHec1QC6w1Jitz+iOg--
