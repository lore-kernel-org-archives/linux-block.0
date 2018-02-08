Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-by2nam03on0068.outbound.protection.outlook.com ([104.47.42.68]:54599
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750961AbeBHNfL (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 8 Feb 2018 08:35:11 -0500
From: Javier Gonzalez <javier@cnexlabs.com>
To: =?utf-8?B?TWF0aWFzIEJqw7hybGluZw==?= <mb@lightnvm.io>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/4] lightnvm: add 2.0 geometry identification
Date: Thu, 8 Feb 2018 13:35:09 +0000
Message-ID: <EC9FE5B1-5E13-4B4F-A925-07572859FBE9@cnexlabs.com>
References: <20180205121505.27563-1-mb@lightnvm.io>
 <20180205121505.27563-4-mb@lightnvm.io>
In-Reply-To: <20180205121505.27563-4-mb@lightnvm.io>
Content-Type: multipart/signed;
        boundary="Apple-Mail=_2550ADA7-9B57-4AB8-8C94-2AE842416BB3";
        protocol="application/pgp-signature"; micalg=pgp-sha512
MIME-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

--Apple-Mail=_2550ADA7-9B57-4AB8-8C94-2AE842416BB3
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

> On 5 Feb 2018, at 13.15, Matias Bj=C3=B8rling <mb@lightnvm.io> wrote:
>=20
> Implement the geometry data structures for 2.0 and enable a drive
> to be identified as one, including exposing the appropriate 2.0
> sysfs entries.
>=20
> Signed-off-by: Matias Bj=C3=B8rling <mb@lightnvm.io>
> ---
> drivers/lightnvm/core.c      |   2 +-
> drivers/nvme/host/lightnvm.c | 334 =
+++++++++++++++++++++++++++++++++++++------
> include/linux/lightnvm.h     |  11 +-
> 3 files changed, 295 insertions(+), 52 deletions(-)
>=20
> diff --git a/drivers/lightnvm/core.c b/drivers/lightnvm/core.c
> index c72863b36439..250e74dfa120 100644
> --- a/drivers/lightnvm/core.c
> +++ b/drivers/lightnvm/core.c
> @@ -934,7 +934,7 @@ static int nvm_init(struct nvm_dev *dev)
> 	pr_debug("nvm: ver:%x nvm_vendor:%x\n",
> 			dev->identity.ver_id, dev->identity.vmnt);
>=20
> -	if (dev->identity.ver_id !=3D 1) {
> +	if (dev->identity.ver_id !=3D 1 && dev->identity.ver_id !=3D 2) =
{
> 		pr_err("nvm: device not supported by kernel.");
> 		goto err;
> 	}
> diff --git a/drivers/nvme/host/lightnvm.c =
b/drivers/nvme/host/lightnvm.c
> index 6412551ecc65..a9c010655ccc 100644
> --- a/drivers/nvme/host/lightnvm.c
> +++ b/drivers/nvme/host/lightnvm.c
> @@ -184,6 +184,58 @@ struct nvme_nvm_bb_tbl {
> 	__u8	blk[0];
> };
>=20
> +struct nvme_nvm_id20_addrf {
> +	__u8			grp_len;
> +	__u8			pu_len;
> +	__u8			chk_len;
> +	__u8			lba_len;
> +	__u8			resv[4];
> +};
> +
> +struct nvme_nvm_id20 {
> +	__u8			mjr;
> +	__u8			mnr;
> +	__u8			resv[6];
> +
> +	struct nvme_nvm_id20_addrf lbaf;
> +
> +	__u32			mccap;
> +	__u8			resv2[12];
> +
> +	__u8			wit;
> +	__u8			resv3[31];
> +
> +	/* Geometry */
> +	__u16			num_grp;
> +	__u16			num_pu;
> +	__u32			num_chk;
> +	__u32			clba;
> +	__u8			resv4[52];
> +
> +	/* Write data requirements */
> +	__u32			ws_min;
> +	__u32			ws_opt;
> +	__u32			mw_cunits;
> +	__u32			maxoc;
> +	__u32			maxocpu;
> +	__u8			resv5[44];
> +
> +	/* Performance related metrics */
> +	__u32			trdt;
> +	__u32			trdm;
> +	__u32			twrt;
> +	__u32			twrm;
> +	__u32			tcrst;
> +	__u32			tcrsm;
> +	__u8			resv6[40];
> +
> +	/* Reserved area */
> +	__u8			resv7[2816];
> +
> +	/* Vendor specific */
> +	__u8			vs[1024];
> +};
>=20

All __u16, __u32 should be __le16, __le32

Javier

--Apple-Mail=_2550ADA7-9B57-4AB8-8C94-2AE842416BB3
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="signature.asc"
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE+ws7Qq+qZPG1bJoyIX4xUKFRnnQFAlp8UgkACgkQIX4xUKFR
nnQCEg//fM0N4+uLOozhUHivEp7vlULcpFYyTJ1lnNit3UuGsSZcFTFeqWMSBBVH
4AitQD7QR+FuB38xugeX7RXHEiyf2HQliCseFPGLpPjUgB012xLCENhmsxWdTNJC
MVJUHJAGWotxAVnYuhgllatDiIquG3HfBRLhIxW07DgFaP3XNMSnD4JcNo+azQgy
bxROK+JNv6Ww/BW3L2zdk1R6c7SIZhf2qf89Fkg+5e/oTYK2YdXSiBNX5lxloA6W
cPVc0jZQ+B1hIUACucfgY4FQroc3kBy3RH6EP5LTbW9YujaTa1kin90FjDywjsjM
g9Wto3ZDmXdCMs1kcpXJSc6mlfElhcveuv4l57dJgFHIIAadAn/CLI1zM29xGqD1
Pwf9tN1J39YZysIAhqNQf9ouF096FUnHthJ+jgS1KWeRLErRm9YiE85vUiL74ONU
4vHHYOn49n6g3vd5GoLE2w85/FkVjo9UoZInxAVSk6CbVg9YAFN6lppF/wuIt8Nw
q1pFBEibHxFv4Wo3QbIj5zP+3pzKAElWrHX08ArHxzNIVPE0WXrGM5p032s+8NsH
DuFl1eH5G17XbXG8yfpQ/WF09oGTX6xZUUf09HcYLn5hGCaFGSXuOY8YDRb+EJy8
L61Co1S5LFL4EHciG8uGi2e8d9SCwlH5qQAQ7eo6O1/CE8germ8=
=rVcv
-----END PGP SIGNATURE-----

--Apple-Mail=_2550ADA7-9B57-4AB8-8C94-2AE842416BB3--
