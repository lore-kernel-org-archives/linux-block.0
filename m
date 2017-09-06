Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wm0-f49.google.com ([74.125.82.49]:33974 "EHLO
        mail-wm0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932553AbdIFOo2 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 6 Sep 2017 10:44:28 -0400
Received: by mail-wm0-f49.google.com with SMTP id 137so28267474wmj.1
        for <linux-block@vger.kernel.org>; Wed, 06 Sep 2017 07:44:28 -0700 (PDT)
From: =?utf-8?Q?Javier_Gonz=C3=A1lez?= <jg@lightnvm.io>
Message-Id: <F6BEA387-01C8-41F8-A8A6-5A2930E1F97B@lightnvm.io>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_6CDABC81-DD3A-4A79-AC5C-A7FAD0524E28";
 protocol="application/pgp-signature"; micalg=pgp-sha512
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH] lightnvm: Add error code for bad write pointer
Date: Wed, 6 Sep 2017 16:44:25 +0200
In-Reply-To: <20170906134456.GB3960@infradead.org>
Cc: =?utf-8?Q?Matias_Bj=C3=B8rling?= <mb@lightnvm.io>,
        Jens Axboe <axboe@fb.com>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
To: Christoph Hellwig <hch@infradead.org>
References: <1504693358-12702-1-git-send-email-javier@cnexlabs.com>
 <20170906134456.GB3960@infradead.org>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org


--Apple-Mail=_6CDABC81-DD3A-4A79-AC5C-A7FAD0524E28
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

> On 6 Sep 2017, at 15.44, Christoph Hellwig <hch@infradead.org> wrote:
>=20
> On Wed, Sep 06, 2017 at 12:22:38PM +0200, Javier Gonz=C3=A1lez wrote:
>> Add new error code introduced on the OCSSD spec 2.0 for write pointer
>> mismatch on the device side. This indicates to the host that a write =
on
>> a block (chunk) is not respecting the required sequentiality.
>=20
> Do you have a pointer to that spec?

No yet. Still writing it up nicely.

I'll wait to re-post until we have the spec out.

Javier

--Apple-Mail=_6CDABC81-DD3A-4A79-AC5C-A7FAD0524E28
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCgAGBQJZsAnJAAoJEGMfBTt1mRjKFhEQANFZBPNW1ElXmgUozwDwIJPQ
q0RDX4PGHBPvNeoKeh6ANgzRg8jXASf77W37DiRTaI4XBig5DJYkoQNFCh49FpYy
zqDAtPu3UnjNSu6R0Wtyg3GY+LJUjWloZjDinyXfIYZA+7BBahWa5USmcBydceld
vn3FaJYDTBXRZ67cm8WyXp2ygWv83X8wLAD3xXyDjdjkD/k2cm87wFXY39WlJRI2
ARqxUpqd0ytCD0T9w5vuPTEmnE6iQ0wlxDCGWQXgz4IjfBu9UYMru0+S3bCve6iV
HgCtWpKbYTJoR8UrTkg2wQ1jM7PRRIISoxY3pi+woiEqW0Z05EFH7WykgbS3trpQ
bMVbOudfFhGErAbv74EwQgtls0ugpGhB8968k5MrQuWWWYMUeoGq7/lqMMboNI54
p6lutSNyLrKyHzDi7mDj1peq4JHbcZ1cMERJ6ipa5ZaZjd5zRH9ctanRD4Ruu8en
pXHzNC7g8cPBnHPBPQNSXPAohGe253Bmdm0RoGxbECFt1nLSVHoK9sa6i4cVBvv2
OMmiMmG6UByMgelCWz4yWOTHQRyRTjmg3HD7q1CijoqPlFgGvk1f9cNoHJ+bjwjy
augNSvtJIZR0usF1V3NDcPJwfd9Yaa4BZbmcuePBh8KJKoLGlM62sOf9yN2o/GWD
Oe6pGCmVsEOyer5LRLDm
=vK10
-----END PGP SIGNATURE-----

--Apple-Mail=_6CDABC81-DD3A-4A79-AC5C-A7FAD0524E28--
