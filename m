Return-Path: <ben@decadent.org.uk>
Message-ID: <1504043508.4448.22.camel@decadent.org.uk>
Subject: Re: [PATCH 1/2] bfq: Re-enable auto-loading when built as a module
From: Ben Hutchings <ben@decadent.org.uk>
To: Jens Axboe <axboe@kernel.dk>
Cc: Paolo Valente <paolo.valente@linaro.org>, linux-block@vger.kernel.org
Date: Tue, 29 Aug 2017 22:51:48 +0100
In-Reply-To: <374764c0-eb64-311f-00dc-d4d4bb4c494a@kernel.dk>
References: <20170813170219.GG18698@decadent.org.uk>
	 <20170829143130.GA4857@kernel.dk>
	 <1504020486.4448.13.camel@decadent.org.uk>
	 <42dfcdc3-6ba2-57d0-7cbc-9529498be365@kernel.dk>
	 <6c0f654f-3a6e-a904-c67c-bb0fec03972a@kernel.dk>
	 <1504024458.4448.18.camel@decadent.org.uk>
	 <06a60078-1592-dc39-a2d9-df3320460bed@kernel.dk>
	 <1504036184.4448.20.camel@decadent.org.uk>
	 <374764c0-eb64-311f-00dc-d4d4bb4c494a@kernel.dk>
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-I1JmwGNHx6C9S1w31uky"
Mime-Version: 1.0
List-ID: <linux-block@vger.kernel.org>


--=-I1JmwGNHx6C9S1w31uky
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2017-08-29 at 13:57 -0600, Jens Axboe wrote:
> On 08/29/2017 01:49 PM, Ben Hutchings wrote:
> > On Tue, 2017-08-29 at 10:46 -0600, Jens Axboe wrote:
> > > On 08/29/2017 10:34 AM, Ben Hutchings wrote:
> > > > On Tue, 2017-08-29 at 09:53 -0600, Jens Axboe wrote:
> > > > > On 08/29/2017 09:48 AM, Jens Axboe wrote:
> > > > > > On 08/29/2017 09:28 AM, Ben Hutchings wrote:
> > > > > > > On Tue, 2017-08-29 at 08:31 -0600, Jens Axboe wrote:
> > > > > > > > On Sun, Aug 13 2017, Ben Hutchings wrote:
> > > > > > > > > The block core requests modules with the "-iosched" name
> > > > > > > > > suffix, but
> > > > > > > > > bfq no longer has that suffix.=C2=A0=C2=A0Add an alias.
> > > > > > > >=20
> > > > > > > > I'd apply these two, but both patches are mangled when save=
d.
> > > > > > > > It's
> > > > > > > > turning =3D=3D into =3D3D and so forth.
> > > > > > > >=20
> > > > > > > > Care to check your settings and resend?
> > > > > > >=20
> > > > > > > Just tried saving and applying with 'git am' successfully.=C2=
=A0=C2=A0I
> > > > > > > think the
> > > > > > > problem is at your end.
> > > > > >=20
> > > > > > Then yours is the only one, I apply patches people send me all =
day
> > > > > > long.
> > > > > > Was the case both in tbird and mutt, both of them showed the di=
ffs
> > > > > > as mangled, and they showed up mangled when saved.
> > > > >=20
> > > > > Here's your email in the archive:
> > > > >=20
> > > > > https://marc.info/?l=3Dlinux-block&m=3D150264374920778&q=3Draw
> > > > >=20
> > > > > Note this part:
> > > > >=20
> > > > > Content-Transfer-Encoding: quoted-printable
> > > >=20
> > > > What about it?=C2=A0=C2=A0This is used for every mail with a non-AS=
CII name in
> > > > it, for example.=C2=A0=C2=A0'git am' understands it.
> > >=20
> > > What about it? It screws up the patch. Maybe git am understands it, b=
ut
> > > it's hard/impossible to read manually.
> >=20
> > Where, other than the 'raw' link above, are you seeing the patch with
> > q-p encoding not decoded?
>=20
> When I save it and view it.

I don't understand why you wouldn't do that in your mailer.  You're
going to need to switch back to the mailer when you reply, after all.
But if you want to display a quoted-printable file in a terminal, you
can use 'qprint -d' to do that.

> > > I'm not going to apply anything
> > > that I can't personally read/review easily. Fix your setup, if you ar=
e
> > > going to be sending patches.
> >=20
> > So you won't accept patches from anyone with a non-ASCII name?
>=20
> You're being ridiculous.

Am I?  It seems like they would trigger the same problem in your
current workflow.

Ben.

--=20
Ben Hutchings
Teamwork is essential - it allows you to blame someone else.


--=-I1JmwGNHx6C9S1w31uky
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEErCspvTSmr92z9o8157/I7JWGEQkFAlml4fQACgkQ57/I7JWG
EQns6hAAucyzFp1bQQsHJqhqCLG4amfU+Ms5S9Y+pCrXt3202thWmpSouMabkDY/
Adk21mhz69GkbHLsvguwEpyolR1erRMBSV+yRkFzXA70K8tbXEI5g1gNJbtQDYI5
f5Nee6YP+HXyAXZu7XQvkcVeEECmgqOAOgbfB7HrvnM3sBfDdI+UZbyO7fUqQsz9
EDj1xt2MOAxPJQQIBpFnMIBXE1ii4hA/JN5nXpBBUj9xu7JvIq9bRsD5XwMn2EVh
bWSXq/VRYFKe+FP012B7osAsLuGDNfdGX8n7cWUvwbMssWsb5VchEjChdKu4dvsc
YbFtgKtkjTyHng8q8UUkOp2lni0V/MIL/PtyTHKekTu7FHc+pUYh9oPVovRh+4Ea
Jg2K24CHYJ6wnJ4bEDNzbBNc2Kfrvm57ZAeZPRLeQDks0OkodMRDLGEM92ZMloE+
/7mP0xwrlELlJlw3gXWZsppP3PTtZbNksjXfyZ3KEhoH8fX7nSDnoaLKl0gDcGH3
dNzd51gcBDBN6kWMDctGwe4caCtUwNiONnGB1oM27AUm3ra1soNT87fSQIM/YB6+
QO/a23L7sJqk13pY7nzPCZMwHIZP+uVaZPuRzanWYa2Usq6Y6ADotZ9/myXo2zkL
Mdw42mkBnhmNPNeDbZ8uIMHchZDjRb2EKTAX5MMPyEu8YfRP7Po=
=G0d3
-----END PGP SIGNATURE-----

--=-I1JmwGNHx6C9S1w31uky--
