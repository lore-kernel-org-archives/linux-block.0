Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-eopbgr710044.outbound.protection.outlook.com ([40.107.71.44]:28382
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728833AbeHCOMv (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 3 Aug 2018 10:12:51 -0400
From: Javier Gonzalez <javier@cnexlabs.com>
To: =?utf-8?B?TWF0aWFzIEJqw7hybGluZw==?= <mb@lightnvm.io>
CC: "Konopko, Igor J" <igor.j.konopko@intel.com>,
        "marcin.dziegielewski@intel.com" <marcin.dziegielewski@intel.com>,
        Hans Holmberg <hans.holmberg@cnexlabs.com>,
        Heiner Litz <hlitz@ucsc.edu>,
        Young Tack Tack Jin <youngtack.jin@circuitblvd.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] lightnvm: move device L2P detection to core
Date: Fri, 3 Aug 2018 12:16:39 +0000
Message-ID: <31319710-8A72-49DC-9CFA-521CA06843F3@cnexlabs.com>
References: <20180803085449.3436-1-mb@lightnvm.io>
In-Reply-To: <20180803085449.3436-1-mb@lightnvm.io>
Content-Type: multipart/signed;
        boundary="Apple-Mail=_5A4D8955-3463-4B10-BBFB-9A29FF12EA6E";
        protocol="application/pgp-signature";
        micalg=pgp-sha512
MIME-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

--Apple-Mail=_5A4D8955-3463-4B10-BBFB-9A29FF12EA6E
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

> On 3 Aug 2018, at 10.54, Matias Bj=C3=B8rling <mb@lightnvm.io> wrote:
>=20
> A 1.2 device is able to manage the logical to physical mapping
> table internally or leave it to the host.
>=20
> A target only supports one of those approaches, and therefore must
> check on initialization. Move this check to core to avoid each target
> implement the check.
>=20
> Signed-off-by: Matias Bj=C3=B8rling <mb@lightnvm.io>
> ---


I see where you want to go with these changes, but the way targets are
layered on top of the LightNVM subsystem does not align with it.
LightNVM can support different OCSSD versions and capabilities, but that
does not mean that a target (e.g., pblk) does. The way I see it, core
should only check for (i) the drive to expose itself in a known revision
and (ii) the reported structures to be consistent. However, specific
functionality is not for core to check upo.

In this particular case, the NVM_TGT_F_HOST_L2P check should be pblk
specific, as it is indeed a 1.2 capability not supported by pblk.
However, a different target supporting this 1.2 feature can be
implemented on top.

As mentioned before, I started looking at moving checks to core too and
my initial thought was to add a .capabilities entry to nvm_tgt_type{} so
that these can be checked prior target initialization. Alternatively, we
can move all these checks to pblk-init.c. At this point, it is safe to
push 1.2 / 2.0 specific functionality to core as registered targets
would have validated the spec and the actual supported capabilities.

Thoughts?

Javier

--Apple-Mail=_5A4D8955-3463-4B10-BBFB-9A29FF12EA6E
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE+ws7Qq+qZPG1bJoyIX4xUKFRnnQFAltkR6QACgkQIX4xUKFR
nnQKlg//eBcJdGKHmcQnEsjzkn6g+L/YnHFgEw9cfIfc8+rGnxwAd70Z4rFDlLYf
60r4p6aYnFVbdLYc1s+ibdVvCRZZ8778V4jGE8aVs18UD45XkIeYLWpHCEC9Lan7
7bBjj7fvqtfywmIgCLpdyH7ebXmPYYA3voGNBxUPEKEbSUPGQTTTY/1tOqOEs1vw
JAtXrZeVHn4n9uBKh97W5Y5r7h4v6sfgF6t3GvfuXuEDmx1CaGaZkdjKbxxgRTV8
8XujxINZU/2JJS+BYPx8X3a6jdL+9JNZfjfZtMZhc7XFyAHwanlSozAiH5++iS/e
e93OjF5o0Hjn/kygkgI4McB0RGLC0uj1cUmFlso8QmmRCA1vuWjY5B0lUM2zsfnY
9jv16w51mH1q1XeU/iEd3Jzqy1UBIr8W/HzZ5dPUTO4F/FSSsFAoIUM3q3CIPccs
rPfYRsA88nnikHC2WroBY897hwKAOpf0CoqgjjsA76RjySYd2uhopExV5ZHxPeK+
pY/sIukELilLyvqanIAlqdT4ys4HckHvCTgpW5Vu76l+FiC5tiQc8nl5wEbavwxF
vZLXAdzkr74g/GTFwprLSAcI36Q9ZbOfO0bbwlYfYiOR5tez6dDl0a6WQ6OBZm4M
NJn5NISO2IkuzwOFJNGkylk/FSqhMD5+V7pBadfhemnSl7jqqTw=
=DQPD
-----END PGP SIGNATURE-----

--Apple-Mail=_5A4D8955-3463-4B10-BBFB-9A29FF12EA6E--
