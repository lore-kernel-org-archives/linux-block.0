Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-bl2nam02on0071.outbound.protection.outlook.com ([104.47.38.71]:58687
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751021AbeBLUVx (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 12 Feb 2018 15:21:53 -0500
From: Javier Gonzalez <javier@cnexlabs.com>
To: =?utf-8?B?TWF0aWFzIEJqw7hybGluZw==?= <mb@lightnvm.io>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH V2 4/4] nvme: lightnvm: add late setup of block size and
 metadata
Date: Mon, 12 Feb 2018 20:21:49 +0000
Message-ID: <098A1343-A9FB-47BD-A4B5-6E77A1861A4B@cnexlabs.com>
References: <20180209092719.10679-1-mb@lightnvm.io>
 <20180209092719.10679-5-mb@lightnvm.io>
In-Reply-To: <20180209092719.10679-5-mb@lightnvm.io>
Content-Type: multipart/signed;
        boundary="Apple-Mail=_E4450FA5-2150-4D0B-87C9-AC311466B328";
        protocol="application/pgp-signature"; micalg=pgp-sha512
MIME-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

--Apple-Mail=_E4450FA5-2150-4D0B-87C9-AC311466B328
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8


> On 9 Feb 2018, at 01.27, Matias Bj=C3=B8rling <mb@lightnvm.io> wrote:
>=20
> The nvme driver sets up the size of the nvme namespace in two steps.
> First it initializes the device with standard logical block and
> metadata sizes, and then sets the correct logical block and metadata
> size. Due to the OCSSD 2.0 specification relies on the namespace to
> expose these sizes for correct initialization, let it be updated
> appropriately on the LightNVM side as well.
>=20
> Signed-off-by: Matias Bj=C3=B8rling <mb@lightnvm.io>
> ---
>=20

This late initialization breaks ligthnvm's core init since the sector
size (csecs) is used on the first init part to set the logical block =
size.

nvm_core_init -> blk_queue_logical_block_size(dev->q, dev_geo->c.csecs);

We can do do a nvme_nvm_revalidate and set this on the revalidation path
instead of simply updating the info as in nvme_nvm_update_nvm_info().

Javier

--Apple-Mail=_E4450FA5-2150-4D0B-87C9-AC311466B328
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="signature.asc"
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE+ws7Qq+qZPG1bJoyIX4xUKFRnnQFAlqB91gACgkQIX4xUKFR
nnQxbxAAydq8diQ9d+x+W8742it3pffX7sqxY967LC2tcFvrmj8El2smPAD1P5wk
g2QWRAZ7gTkWX/dfVO9HxSCyV2+IAl1/TJVOK1PvL8IELGnuwgrhBFDyu3ox/83A
yzNEAFSklDVlboEcm6vpCmNkniJCbABXHfrZX6gHMgQNmGnL3fIgL3Os1IcABBHd
J0Hk9YRjuSnipuONTeZhLh/OLe1oxdXDuVvHMuW0HQXneLGjjfmylKXgzdHXQc08
ZVRRgrZSEYWWeIzb+dGZkEng7BaRm7W2/v8e+85G26TPZQcNz2Jbtys3iWAhAE6/
8nsub/hDr6KZWrhvpwz0aO7mhnDKXHYrlGhgiW9bGa/8lyJO+cXgp+k9Kpe+Xvv6
rUZinkiS8EEfSAPuGQHYMUOkc0yQdW3gUM8yDFOA+j/WpE+bIEH8LHdJQSptUwja
YF3bNv900ifSsXuUrHqS3cMlWUSdhaytAo5VS6kR2Xt1ULjCT6ftoK/0U39MCqP2
fBPI+gR0oaP6dG4pdR+AuEH3zfz4Bin6eMEIu82boPYbPlWgeVEO6vaTiZaLgMea
ln6Cthk/D8vu2vMVgVnRHYrk9GRc6Om2vomAY1i67RXZqx6gy8dvUWqPm/V9zttj
NS5rAOmcaWp7a3g2WIVZ0NoYaSdZ05k4j0D1uhBOd0XJRDz13iQ=
=0okX
-----END PGP SIGNATURE-----

--Apple-Mail=_E4450FA5-2150-4D0B-87C9-AC311466B328--
