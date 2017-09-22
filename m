Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wm0-f50.google.com ([74.125.82.50]:43197 "EHLO
        mail-wm0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751852AbdIVIwW (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 22 Sep 2017 04:52:22 -0400
Received: by mail-wm0-f50.google.com with SMTP id m72so1159836wmc.0
        for <linux-block@vger.kernel.org>; Fri, 22 Sep 2017 01:52:21 -0700 (PDT)
From: =?utf-8?Q?Javier_Gonz=C3=A1lez?= <jg@lightnvm.io>
Message-Id: <D3D2476A-E07C-4012-A731-27552AFFCD5D@lightnvm.io>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_4B91884C-E5C2-476E-8AD7-F8DE12C7782D";
 protocol="application/pgp-signature"; micalg=pgp-sha512
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH 3/6] lightnvm: pblk: fix message if L2P MAP is in device
Date: Fri, 22 Sep 2017 10:52:19 +0200
In-Reply-To: <20170921112655.GA28539@dhcp-216.srv.tuxera.com>
Cc: =?utf-8?Q?Matias_Bj=C3=B8rling?= <mb@lightnvm.io>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
To: Rakesh Pandit <rakesh@tuxera.com>
References: <20170921112655.GA28539@dhcp-216.srv.tuxera.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org


--Apple-Mail=_4B91884C-E5C2-476E-8AD7-F8DE12C7782D
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

> On 21 Sep 2017, at 13.26, Rakesh Pandit <rakesh@tuxera.com> wrote:
>=20
> This usually happens if we are developing with qemu and ll2pmode has
> default value.  Even in that case message seems wrong.
>=20
> Signed-off-by: Rakesh Pandit <rakesh@tuxera.com>
> ---
> drivers/lightnvm/pblk-init.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/lightnvm/pblk-init.c =
b/drivers/lightnvm/pblk-init.c
> index 470ef04..c5c1337 100644
> --- a/drivers/lightnvm/pblk-init.c
> +++ b/drivers/lightnvm/pblk-init.c
> @@ -913,7 +913,7 @@ static void *pblk_init(struct nvm_tgt_dev *dev, =
struct gendisk *tdisk,
> 	int ret;
>=20
> 	if (dev->identity.dom & NVM_RSP_L2P) {
> -		pr_err("pblk: device-side L2P table not supported. =
(%x)\n",
> +		pr_err("pblk: device-side L2P table supported. (%x)\n",
> 							=
dev->identity.dom);
> 		return ERR_PTR(-EINVAL);
> 	}
> --
> 2.5.0

You're right. This is inherited from rrpc.

Can we instead write "pblk: full host-side L2P table not supported"?
People will not know about the hybrid device/host L2P as time goes by
and it will just be confusing. I'm not even sure this will be part of
the 2.0 spec, so it will probably go away with time...

Javier

--Apple-Mail=_4B91884C-E5C2-476E-8AD7-F8DE12C7782D
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCgAGBQJZxM9DAAoJEGMfBTt1mRjKh1MP/00losEuOeqD8C2pu+EmVmo3
umKlI4WPshPdL3A5/LvpFVzIswDFvr1RTxgR5lx8RePLRwghuJEsDqIuNpVtGd6p
wfzvpQz05p85QeAvMVPLv52xbl0ufC6ntIuelb9n1WafP/GIYV9YQEKvI/o+1Pmv
kg1aBjFkNmvlZ4nl6nmGMxV+r39f5qkqRqI4moIc1zxbUCD7fCGonlmx0BTUKO6r
z0mG4OuIMbDSyx/3pdnVScrgnGJmr+wCafjzFjRu92/bCOz2nhEtl7cV3DFAyQ6w
QcLYAT0r2aNKhkNNdPTMiLYKfsVpCQhkYCpj5eUDXdLuSVskalnbw2eRYNc2P0dE
X1znLyerHEVjXnLp1OyuGMxeqMEYs2wH3+QPzYepSIWscGqFX5Agdg4fi2wwDvKE
tWlv6uR69JKpNMz5OT5ugBE/1G75B16+tGhbozK38tUEynpndiCNFkwjo3F0crPh
Qx+kHc4kjW89XmCEKs5vczSnmkdeSy3X4cWX5QVnK+HBFy0Of6QDLdmwzr7Vb+Da
10ta/FZ6KpS3lxFR7Bwb3VNfr4Tp++uL1XaxMyTOphNw/zwTWfHHfz10Em0O2DFZ
CWHO5DVFnCJiQk8F/3E0CxRhX2kupgGpVbT2zFGxaxvFzMQX7njIImzY59qF0nhP
IxXeouRt/SOoe5Mq/FIz
=4RsC
-----END PGP SIGNATURE-----

--Apple-Mail=_4B91884C-E5C2-476E-8AD7-F8DE12C7782D--
