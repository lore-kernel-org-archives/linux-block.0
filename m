Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-by2nam03on0053.outbound.protection.outlook.com ([104.47.42.53]:31325
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727148AbeHCOOv (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 3 Aug 2018 10:14:51 -0400
From: Javier Gonzalez <javier@cnexlabs.com>
To: =?utf-8?B?TWF0aWFzIEJqw7hybGluZw==?= <mb@lightnvm.io>
CC: "Konopko, Igor J" <igor.j.konopko@intel.com>,
        "marcin.dziegielewski@intel.com" <marcin.dziegielewski@intel.com>,
        Hans Holmberg <hans.holmberg@cnexlabs.com>,
        Heiner Litz <hlitz@ucsc.edu>,
        Young Tack Tack Jin <youngtack.jin@circuitblvd.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] lightnvm: pblk: remove unnecessary drive version check
Date: Fri, 3 Aug 2018 12:18:29 +0000
Message-ID: <4382FFAE-0602-4A16-8120-E930141606ED@cnexlabs.com>
References: <20180802205841.22039-1-mb@lightnvm.io>
In-Reply-To: <20180802205841.22039-1-mb@lightnvm.io>
Content-Type: multipart/signed;
        boundary="Apple-Mail=_1AD2DCDC-FCD9-4104-BF12-23CFF23EA93E";
        protocol="application/pgp-signature";
        micalg=pgp-sha512
MIME-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

--Apple-Mail=_1AD2DCDC-FCD9-4104-BF12-23CFF23EA93E
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

> On 2 Aug 2018, at 22.58, Matias Bj=C3=B8rling <mb@lightnvm.io> wrote:
>=20
> The nvme driver checks for 1.2 and 2.0 compatibility. If an =
unsupported
> version is reported, the device will not be initialized.
>=20
> Signed-off-by: Matias Bj=C3=B8rling <mb@lightnvm.io>
> ---
> drivers/lightnvm/pblk-init.c | 8 --------
> 1 file changed, 8 deletions(-)
>=20
> diff --git a/drivers/lightnvm/pblk-init.c =
b/drivers/lightnvm/pblk-init.c
> index 537e98f2b24a..e9e2fedff387 100644
> --- a/drivers/lightnvm/pblk-init.c
> +++ b/drivers/lightnvm/pblk-init.c
> @@ -1202,14 +1202,6 @@ static void *pblk_init(struct nvm_tgt_dev *dev, =
struct gendisk *tdisk,
> 	pblk->state =3D PBLK_STATE_RUNNING;
> 	pblk->gc.gc_enabled =3D 0;
>=20
> -	if (!(geo->version =3D=3D NVM_OCSSD_SPEC_12 ||
> -					geo->version =3D=3D =
NVM_OCSSD_SPEC_20)) {
> -		pblk_err(pblk, "OCSSD version not supported (%u)\n",
> -							geo->version);
> -		kfree(pblk);
> -		return ERR_PTR(-EINVAL);
> -	}
> -
> 	if (geo->version =3D=3D NVM_OCSSD_SPEC_12 && geo->dom & =
NVM_RSP_L2P) {
> 		pblk_err(pblk, "host-side L2P table not supported. =
(%x)\n",
> 							geo->dom);
> --
> 2.11.0

The same comment goes for this patch. pblk does support 2.0 and 1.2
today, but it is not guaranteed it will support a new revision straight
away. So I think that a check wither here or through the .capabilities I
proposed on the other patch is necessary.

Javier

--Apple-Mail=_1AD2DCDC-FCD9-4104-BF12-23CFF23EA93E
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE+ws7Qq+qZPG1bJoyIX4xUKFRnnQFAltkSBEACgkQIX4xUKFR
nnQhVBAAkisfae1+/wXH0oRMNssZjaVUN9JSbo5mg1+dxwKo3tacGYyE4c1Vd43m
ZjPqY8am7NLO5hF9Vd6moz+l0T6feIQdYY17DJNY56aB+wZtszTB8uQmPmJYeLZT
kHWS0voZSDF1ILDhdvIiSPQIep7WjubVYRm7b/aSPac8iJ4yZtfSd2kpogirpK58
xrujIe1fu9VZ7ynM5sDnCbNPNzvARgehx8ow+0S06T0FinOwS+gYCTYvdi/RMycN
08yPauUrSDh9ywiycs0x/v8IK7zungHeK9kWOBP43dwDhj08vYA/TKJUgC0G8BiY
7UTGt7giuOdgrWqZi478XeweI5Qe8CwnOYMBYGbZW+H1XjLtp5U8h+FGcms+0JsI
cmaxG6mIh4YyQdVPzPr63RUOiDMt5xR2C1SroaiRXvNZsYlk6hqwOMYvvbBqiDJa
p6Cx0YAYdweTEGN4n9OiSCyhjdFa0cBuNkGAY41LBVNxeGl0RerYB/aR3tP4rRcn
0kvyWCK9ZiTGhzlBuU92C4njM8B5xFY9hzXiOmpMOa1yHgmrm6e1H1M6lIO8ToIK
gDFdkLYWedoB6/FNdWscywcZSRpKVNU8V/PUudO7VkA+NAwJjJKRBAMh5NYaxGhJ
x7A30GxDEvy+q6lNEcvQGDNKlB3QsHqboCLWO+eoAFvVyiqdGnw=
=W9X9
-----END PGP SIGNATURE-----

--Apple-Mail=_1AD2DCDC-FCD9-4104-BF12-23CFF23EA93E--
