Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wr0-f193.google.com ([209.85.128.193]:36122 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751729AbeBUIMO (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 21 Feb 2018 03:12:14 -0500
Received: by mail-wr0-f193.google.com with SMTP id u15so1857343wrg.3
        for <linux-block@vger.kernel.org>; Wed, 21 Feb 2018 00:12:13 -0800 (PST)
From: =?utf-8?Q?Javier_Gonz=C3=A1lez?= <jg@lightnvm.io>
Message-Id: <1D95CDC0-51D9-4A5F-A3A7-BB3415079A83@lightnvm.io>
Content-Type: multipart/signed;
        boundary="Apple-Mail=_9AFAFDFF-1ACB-4F31-90F3-E3F94F650CD1";
        protocol="application/pgp-signature";
        micalg=pgp-sha512
Mime-Version: 1.0 (Mac OS X Mail 11.2 \(3445.5.20\))
Subject: Re: [PATCH 0/3] pblk bugfixes
Date: Wed, 21 Feb 2018 09:12:09 +0100
In-Reply-To: <40fb8893-3c8a-d471-e78a-4a2eea079884@lightnvm.io>
Cc: Hans Holmberg <hans.ml.holmberg@owltronix.com>,
        linux-block@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Hans Holmberg <hans.holmberg@cnexlabs.com>
To: =?utf-8?Q?Matias_Bj=C3=B8rling?= <mb@lightnvm.io>
References: <1519200181-10886-1-git-send-email-hans.ml.holmberg@owltronix.com>
 <40fb8893-3c8a-d471-e78a-4a2eea079884@lightnvm.io>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org


--Apple-Mail=_9AFAFDFF-1ACB-4F31-90F3-E3F94F650CD1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

> On 21 Feb 2018, at 09.09, Matias Bj=C3=B8rling <mb@lightnvm.io> wrote:
>=20
> On 02/21/2018 09:02 AM, hans.ml.holmberg@owltronix.com wrote:
>> From: Hans Holmberg <hans.holmberg@cnexlabs.com>
>> This is a slew of generic bugfixes to pblk
>> The patches apply on top of:
>> https://github.com/OpenChannelSSD/linux branch for-4.17/core
>> Hans Holmberg (3):
>>   lightnvm: pblk: delete writer kick timer before stopping thread
>>   lightnvm: pblk: allow allocation of new lines during shutdown
>>   lightnvm: pblk: prevent race in pblk_rb_flush_point_set
>>  drivers/lightnvm/pblk-core.c | 7 -------
>>  drivers/lightnvm/pblk-init.c | 2 +-
>>  drivers/lightnvm/pblk-rb.c   | 7 ++++---
>>  3 files changed, 5 insertions(+), 11 deletions(-)
>=20
> Thanks Hans. Applied.

You can add

Reviewed-by: Javier Gonz=C3=A1lez <javier@cnexlabs.com>


--Apple-Mail=_9AFAFDFF-1ACB-4F31-90F3-E3F94F650CD1
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEm1mT7zen+vs9+T8kYx8FO3WZGMoFAlqNKdkACgkQYx8FO3WZ
GMrOBhAAsaeSVtq1mUwNKKj2IiAyKZdWbnGdjCBNeb6JMrM60RXoHpkiTPAV9xna
rYKDJ3V7QD1wtqzMYyAgqyO0qDDDn+m3I2TjdBwWexvoHXEoKkVUHd25GQDa8oJP
eXVlVutFqo4hJmF+kxUSba4/dn8qeWknUxJGR+xQ/a9fcYJFYZyEp+aS4WGIc0id
Nwi6wliqNz6r0X2AwUpv3U92J4ms40dLU82IlbVEXVizmShns5Qfn/XQjKZWq7xe
KpgdSXKfAyEEhU9wRLrMG62d7ZmRZfbYo5gG89MCiPu7dF6jKcSxeYtio9fNhWKl
BRv+RjSEEAwWbBBv2tVxdJqGilqh8cLZ/m2KeD2lSTUqjX04wBCyg20778SnQz0C
7f0fOhc2Sj7sx/Bi87tsbZQ+O7CauUibP1updfOdSQ4n3Kywfrg1MuuPrMc6OtIu
55YmSAK8BmA5Gqbk+SDb+psdvksPTTMV54fEblAYEiKCAJRBGcz2lj9K7Gg/pnG/
rNkqOh9MmOI7NGgBDGQcTqtynila6vXGzAP331tqkZ3JQ+ojLXcwpQAsrECEgZ8k
7RjHxpHAfIVyDi1AfQ8/hmLrrz7fyeN1g+/Jk29SMLWoScw9htlTVuWU9eUDy0pf
6QjE/TedS2WLBmrXXWOr8eFi6sNB38Ob+8FEIDV/BidTZhT91R8=
=RaYO
-----END PGP SIGNATURE-----

--Apple-Mail=_9AFAFDFF-1ACB-4F31-90F3-E3F94F650CD1--
