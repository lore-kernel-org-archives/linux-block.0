Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-bl2nam02on0060.outbound.protection.outlook.com ([104.47.38.60]:43868
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752028AbeF1IPd (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 28 Jun 2018 04:15:33 -0400
From: Javier Gonzalez <javier@cnexlabs.com>
To: =?utf-8?B?TWF0aWFzIEJqw7hybGluZw==?= <mb@lightnvm.io>
CC: Heiner Litz <hlitz@ucsc.edu>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Marcin Dziegielewski <marcin.dziegielewski@intel.com>,
        "Konopko, Igor J" <igor.j.konopko@intel.com>
Subject: Re: [PATCH] lightnvm: pblk: Add read memory barrier when reading from
 rb
Date: Thu, 28 Jun 2018 08:15:29 +0000
Message-ID: <2A35B284-70C5-4EB5-AF4F-63012383295B@cnexlabs.com>
References: <1529535298-15465-1-git-send-email-hlitz@ucsc.edu>
 <4ef758b3-f9f0-42b5-c202-6f1491f027aa@lightnvm.io>
 <CAJbgVnUmP6UgA1Mu_do0OLVg2gXrbp7opCVhA6aRD07fxjjk1g@mail.gmail.com>
 <3f640809-3093-55da-6014-91b98d7ae642@lightnvm.io>
In-Reply-To: <3f640809-3093-55da-6014-91b98d7ae642@lightnvm.io>
Content-Type: multipart/signed;
        boundary="Apple-Mail=_AF87FCAE-3725-4AE0-A983-51D6B7E78743";
        protocol="application/pgp-signature";
        micalg=pgp-sha512
MIME-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

--Apple-Mail=_AF87FCAE-3725-4AE0-A983-51D6B7E78743
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

> On 28 Jun 2018, at 09.59, Matias Bj=C3=B8rling <mb@lightnvm.io> wrote:
>=20
> On 06/28/2018 01:31 AM, Heiner Litz wrote:
>> There is a control dependency between two disjoint variables (only =
read data if flags =3D=3D WRITTEN). Because x86-TSO allows re-ordering =
of loads the control dependency can be violated.
>=20
> I'm sorry, I do not see it :)
>=20
> Here is my understanding:
>=20
> entry->w_ctx.flags is used as a flagging mechanism to wait for data to =
become available when "flags" has PBLK_WRITTEN_DATA.
>=20
> The later access to entry->data is independent of this. It is assumed =
that entry->w_ctx.flags is the guarding barrier.

This is correct. The motivation is to allow several producers to fill =
the
buffer simultaneously.

>=20
> Here is the titbit from the control dependency section that makes me
> say that the entry->data loads is not possible to be done before
> entry->w_ctx.flags:
>=20
> " (*) Control dependencies apply only to the then-clause and =
else-clause
>      of the if-statement containing the control dependency, including
>      any functions that these two clauses call.  Control dependencies
>      do -not- apply to code following the if-statement containing the
>      control dependency."
>=20
> The read of entry->data must come after the READ_ONCE of =
entry->w_ctx.flags.
>=20

I also understood it this way when implementing the barrier, but after
an offline discussion with Heiner, he convinced me that reordering could
occur.

>> BTW: ARM has an even more relaxed memory model and also allows to
>> re-order writes. If we want to support ARM correctly, I think we also
>> need to insert a memory barrier between writing data and writing
>> flags (and there might be a couple other places where we need to
>> check).

Heiner: Can you develop on this?

Javier

--Apple-Mail=_AF87FCAE-3725-4AE0-A983-51D6B7E78743
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE+ws7Qq+qZPG1bJoyIX4xUKFRnnQFAls0mR0ACgkQIX4xUKFR
nnRXyQ/9FZQt5lNqBAaPeJUSwsM4PjH61HGdFFMQdoHFgP0uSxX1NAaCBu1h+P7T
2h4p2u5uS1YUkWqLKqQbF067vVe5UKTS3TrQ2Sf/Ay2k02+5UEs7eXSQQZkHeZ32
5rZ2Z7rcDAun5Wo+iMCR7Vzh7gyx1+Iaic/fmjpkFY9lwVNO8Lf57VMf6icqHTOt
Yo4ZHwgbQ4ZB/6rMA7+9hcc7ZQ4zFoQivhpaNEvnjXbu8B/sQT9WRJ7NA99Ge7Ns
ob35jEhzS/qswwR5cSAjRKAmkZvq6X/T4xV/XmzlIdlNaOEs9m5msu554DEUtBTA
wHGpngyf90X1EKd0hftpOAV4M4M+ox0sXKxvI2K2+dPh7ko3Phsf+67t68p3ciqT
pk055aL/UZAi+u5OhcqTcf9JgwjotWHs24uD3zfwIjY+7SVjpDbckNo9vAHNlzio
q86OUn4M5Z78WDv+2sAos/lxKL6f5CPV9dvYF3yZ0KUQA9I4GhXrKe4Z8qRlv0ki
Ttn3oHaUI9Q2KUol2l8Vz0rnBtSA3AH7zmO9HUaUdd6X9BI77a+oHREh3zpxWace
IewwXmAMUccKEI2Oyuc0obqLJecs1N+tERD1AFyeDSUMoxelFFnZW0drVO0I5995
2s81FLE86tMUyP8DGiqu85p9h04HUmhTZx6DJ0E7wbe0Yhf74YY=
=7VDU
-----END PGP SIGNATURE-----

--Apple-Mail=_AF87FCAE-3725-4AE0-A983-51D6B7E78743--
