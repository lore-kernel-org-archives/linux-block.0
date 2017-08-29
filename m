Return-Path: <linux-block-owner@vger.kernel.org>
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:49719 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751317AbdH2Qeb (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 29 Aug 2017 12:34:31 -0400
Message-ID: <1504024458.4448.18.camel@decadent.org.uk>
Subject: Re: [PATCH 1/2] bfq: Re-enable auto-loading when built as a module
From: Ben Hutchings <ben@decadent.org.uk>
To: Jens Axboe <axboe@kernel.dk>
Cc: Paolo Valente <paolo.valente@linaro.org>,
        linux-block@vger.kernel.org
Date: Tue, 29 Aug 2017 17:34:18 +0100
In-Reply-To: <6c0f654f-3a6e-a904-c67c-bb0fec03972a@kernel.dk>
References: <20170813170219.GG18698@decadent.org.uk>
         <20170829143130.GA4857@kernel.dk>
         <1504020486.4448.13.camel@decadent.org.uk>
         <42dfcdc3-6ba2-57d0-7cbc-9529498be365@kernel.dk>
         <6c0f654f-3a6e-a904-c67c-bb0fec03972a@kernel.dk>
Content-Type: multipart/signed; micalg="pgp-sha512";
        protocol="application/pgp-signature"; boundary="=-oYBidqajWsGMeItf6sBa"
Mime-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org


--=-oYBidqajWsGMeItf6sBa
Content-Type: multipart/mixed; boundary="=-bcmgzqlwkZBxNQmL7bOZ"


--=-bcmgzqlwkZBxNQmL7bOZ
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2017-08-29 at 09:53 -0600, Jens Axboe wrote:
> On 08/29/2017 09:48 AM, Jens Axboe wrote:
> > On 08/29/2017 09:28 AM, Ben Hutchings wrote:
> > > On Tue, 2017-08-29 at 08:31 -0600, Jens Axboe wrote:
> > > > On Sun, Aug 13 2017, Ben Hutchings wrote:
> > > > > The block core requests modules with the "-iosched" name
> > > > > suffix, but
> > > > > bfq no longer has that suffix.=C2=A0=C2=A0Add an alias.
> > > >=20
> > > > I'd apply these two, but both patches are mangled when saved.
> > > > It's
> > > > turning =3D=3D into =3D3D and so forth.
> > > >=20
> > > > Care to check your settings and resend?
> > >=20
> > > Just tried saving and applying with 'git am' successfully.=C2=A0=C2=
=A0I
> > > think the
> > > problem is at your end.
> >=20
> > Then yours is the only one, I apply patches people send me all day
> > long.
> > Was the case both in tbird and mutt, both of them showed the diffs
> > as mangled, and they showed up mangled when saved.
>=20
> Here's your email in the archive:
>=20
> https://marc.info/?l=3Dlinux-block&m=3D150264374920778&q=3Draw
>=20
> Note this part:
>=20
> Content-Transfer-Encoding: quoted-printable

What about it?  This is used for every mail with a non-ASCII name in
it, for example.  'git am' understands it.

> Problem is definitely at your end.

Or perhaps in the middle?  Anyway, here are the patches again as an
mbox.

Ben.

--=20
Ben Hutchings
Teamwork is essential - it allows you to blame someone else.


--=-bcmgzqlwkZBxNQmL7bOZ
Content-Type: application/mbox; name="block-sched-module-aliases.mbox"
Content-Disposition: attachment; filename="block-sched-module-aliases.mbox"
Content-Transfer-Encoding: base64

RnJvbSBjNzRhNzcwMjZlMTYxNjVkZTRiZmUwZDM5ZGEyYWQ4ZTgxMzVjOTEzIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBCZW4gSHV0Y2hpbmdzIDxiZW5AZGVjYWRlbnQub3JnLnVrPgpE
YXRlOiBTdW4sIDEzIEF1ZyAyMDE3IDE4OjAyOjE5ICswMTAwClN1YmplY3Q6IFtQQVRDSCAxLzJd
IGJmcTogUmUtZW5hYmxlIGF1dG8tbG9hZGluZyB3aGVuIGJ1aWx0IGFzIGEgbW9kdWxlCgpUaGUg
YmxvY2sgY29yZSByZXF1ZXN0cyBtb2R1bGVzIHdpdGggdGhlICItaW9zY2hlZCIgbmFtZSBzdWZm
aXgsIGJ1dApiZnEgbm8gbG9uZ2VyIGhhcyB0aGF0IHN1ZmZpeC4gIEFkZCBhbiBhbGlhcy4KCkZp
eGVzOiBlYTI1ZGE0ODA4NmQgKCJibG9jaywgYmZxOiBzcGxpdCBiZnEtaW9zY2hlZC5jIGludG8g
bXVsdGlwbGUgLi4uIikKU2lnbmVkLW9mZi1ieTogQmVuIEh1dGNoaW5ncyA8YmVuQGRlY2FkZW50
Lm9yZy51az4KLS0tCiBibG9jay9iZnEtaW9zY2hlZC5jIHwgMSArCiAxIGZpbGUgY2hhbmdlZCwg
MSBpbnNlcnRpb24oKykKCmRpZmYgLS1naXQgYS9ibG9jay9iZnEtaW9zY2hlZC5jIGIvYmxvY2sv
YmZxLWlvc2NoZWQuYwppbmRleCA0MzZiNmNhNmIxNzUuLjNhMDE1NjNiZDU2NCAxMDA2NDQKLS0t
IGEvYmxvY2svYmZxLWlvc2NoZWQuYworKysgYi9ibG9jay9iZnEtaW9zY2hlZC5jCkBAIC00OTk4
LDYgKzQ5OTgsNyBAQCBzdGF0aWMgc3RydWN0IGVsZXZhdG9yX3R5cGUgaW9zY2hlZF9iZnFfbXEg
PSB7CiAJLmVsZXZhdG9yX25hbWUgPQkiYmZxIiwKIAkuZWxldmF0b3Jfb3duZXIgPQlUSElTX01P
RFVMRSwKIH07CitNT0RVTEVfQUxJQVMoImJmcS1pb3NjaGVkIik7CiAKIHN0YXRpYyBpbnQgX19p
bml0IGJmcV9pbml0KHZvaWQpCiB7CgpGcm9tIDlhYjMzNGMyMTdjNDFhOTk1OWFjODVhYzI3Y2E5
ZTM1YTk5YzhmODIgTW9uIFNlcCAxNyAwMDowMDowMCAyMDAxCkZyb206IEJlbiBIdXRjaGluZ3Mg
PGJlbkBkZWNhZGVudC5vcmcudWs+CkRhdGU6IFN1biwgMTMgQXVnIDIwMTcgMTg6MDM6MTUgKzAx
MDAKU3ViamVjdDogW1BBVENIIDIvMl0gbXEtZGVhZGxpbmU6IEVuYWJsZSBhdXRvLWxvYWRpbmcg
d2hlbiBidWlsdCBhcyBtb2R1bGUKClRoZSBibG9jayBjb3JlIHJlcXVlc3RzIG1vZHVsZXMgd2l0
aCB0aGUgIi1pb3NjaGVkIiBuYW1lIHN1ZmZpeCwgYnV0Cm1xLWRlYWRsaW5lIGRvZXMgbm90IGhh
dmUgdGhhdCBzdWZmaXguICBBZGQgYW4gYWxpYXMuCgpGaXhlczogOTQ1ZmZiNjBjMTFkICgibXEt
ZGVhZGxpbmU6IGFkZCBibGstbXEgYWRhcHRhdGlvbiBvZiB0aGUgZGVhZGxpbmUgLi4uIikKU2ln
bmVkLW9mZi1ieTogQmVuIEh1dGNoaW5ncyA8YmVuQGRlY2FkZW50Lm9yZy51az4KLS0tCiBibG9j
ay9tcS1kZWFkbGluZS5jIHwgMSArCiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKykKCmRp
ZmYgLS1naXQgYS9ibG9jay9tcS1kZWFkbGluZS5jIGIvYmxvY2svbXEtZGVhZGxpbmUuYwppbmRl
eCAxYjk2NGEzODdhZmUuLjc4ZTc2OThmYTRlZCAxMDA2NDQKLS0tIGEvYmxvY2svbXEtZGVhZGxp
bmUuYworKysgYi9ibG9jay9tcS1kZWFkbGluZS5jCkBAIC02NjAsNiArNjYwLDcgQEAgc3RhdGlj
IHN0cnVjdCBlbGV2YXRvcl90eXBlIG1xX2RlYWRsaW5lID0gewogCS5lbGV2YXRvcl9uYW1lID0g
Im1xLWRlYWRsaW5lIiwKIAkuZWxldmF0b3Jfb3duZXIgPSBUSElTX01PRFVMRSwKIH07CitNT0RV
TEVfQUxJQVMoIm1xLWRlYWRsaW5lLWlvc2NoZWQiKTsKIAogc3RhdGljIGludCBfX2luaXQgZGVh
ZGxpbmVfaW5pdCh2b2lkKQogewo=


--=-bcmgzqlwkZBxNQmL7bOZ--

--=-oYBidqajWsGMeItf6sBa
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEErCspvTSmr92z9o8157/I7JWGEQkFAlmll4oACgkQ57/I7JWG
EQmFMg/+KAHYQHZPyP5WxAIvZNINSLluLhslWl4jW9GwjXmLLhnUEcwl4zz3emjp
YTYmtpBbJIEBs9eokZvUM5IOTV7UvPQd+pWhaZKiN6Entdm2lA0v2a5dceCbBbaq
kIkvMZPihrIjOSZE7n27ATR3FKPVUpgrHZTxycwsPTRDrOEk7N4zY1m2OLXbS3CP
JVjSTOX5CH+etzvNl5RJ9HfbMhmIhAkDl7weLdL7dB2BUEyNHNz3zlphwXCdbmWz
OhxP8kwJx2Cc2gFUX6VPdmTVVnXDMvuRbsFdZ/wrcSrQmURgYJqzoF0dL8QPcEA3
VmgHxEsPHcv1OGrOFBtSa+Gwc4BbbkodDHvTkLhxcwFuQbmXOOvDzrg0jfjobPB3
oq0HwcHcDhvgbKlweoy+iVE6BX/oWVQ4L8YoQ7TJyJLl+EfMsCAqr1UcL0+nAd3a
vwb8Da4Sjse0mu2GIIfO3lFyOGdQZL8oF3dMQ2dkMKkZZ3STncLnc8LB5xeDZSbl
ptBO9/0LVoCZA1V2m0rwvId64V0S1XrxoFGmnfiliFKGyKDHdmRaecDzsVy1Y9Ko
E/UgPkOXNH7BRWwYQAYdTeGqZ5eepfKMyFUV5/csKiiwNb9L05NzXTFHC4UPbjWF
ri2DXqtxg8awsv+zYA8foDWLh31sNt50bzpSr9qwaKpUAz1Dqmw=
=PEHA
-----END PGP SIGNATURE-----

--=-oYBidqajWsGMeItf6sBa--
