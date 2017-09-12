Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wm0-f51.google.com ([74.125.82.51]:46109 "EHLO
        mail-wm0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751395AbdILNW7 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 12 Sep 2017 09:22:59 -0400
Received: by mail-wm0-f51.google.com with SMTP id i189so58015921wmf.1
        for <linux-block@vger.kernel.org>; Tue, 12 Sep 2017 06:22:58 -0700 (PDT)
From: =?utf-8?Q?Javier_Gonz=C3=A1lez?= <jg@lightnvm.io>
Message-Id: <EEE26368-B800-4483-AFA7-36E84773C401@lightnvm.io>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_A2261A1F-9C49-4CA9-9CCA-5B8F999554A5";
 protocol="application/pgp-signature"; micalg=pgp-sha512
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH V2] lightnvm: prevent bd removal if busy
Date: Tue, 12 Sep 2017 15:22:54 +0200
In-Reply-To: <20170910190712.GA7010@hercules.tuxera.com>
Cc: =?utf-8?Q?Matias_Bj=C3=B8rling?= <mb@lightnvm.io>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
To: Rakesh Pandit <rakesh@tuxera.com>
References: <20170910190712.GA7010@hercules.tuxera.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org


--Apple-Mail=_A2261A1F-9C49-4CA9-9CCA-5B8F999554A5
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

> On 10 Sep 2017, at 21.07, Rakesh Pandit <rakesh@tuxera.com> wrote:
>=20
> When a virtual block device is formatted and mounted after creating
> with "nvme lnvm create... -t pblk", a removal from "nvm lnvm remove"
> would result in this:
>=20
> 446416.309757] bdi-block not registered
> [446416.309773] ------------[ cut here ]------------
> [446416.309780] WARNING: CPU: 3 PID: 4319 at fs/fs-writeback.c:2159 =
__mark_inode_dirty+0x268/0x340
>=20
> Ideally removal should return -EBUSY as block device is mounted after
> formatting.  This patch tries to address this checking if whole device
> or any partition of it already mounted or not before removal.
>=20
> Whole device is checked using "bd_super" member of block device.  This
> member is always set once block device has been mounted using a
> filesystem.  Another member "bd_part_count" takes care of checking any
> if any partitions are under use.  "bd_part_count" is only updated
> under locks when partitions are opened or closed (first open and last
> release).  This at least does take care sending -EBUSY if removal is
> being attempted while whole block device or any partition is mounted.
>=20
> Signed-off-by: Rakesh Pandit <rakesh@tuxera.com>
> ---
>=20
> V2: Take a different approach. Instead of checking bd_openers use
> bd_super and bd_part_count.  This should address the removal of bdevs
> which are mounted from removal.
>=20
> drivers/lightnvm/core.c | 14 ++++++++++++++
> 1 file changed, 14 insertions(+)
>=20
> diff --git a/drivers/lightnvm/core.c b/drivers/lightnvm/core.c
> index c39f87d..9f9a137 100644
> --- a/drivers/lightnvm/core.c
> +++ b/drivers/lightnvm/core.c
> @@ -373,6 +373,7 @@ static void __nvm_remove_target(struct nvm_target =
*t)
> static int nvm_remove_tgt(struct nvm_dev *dev, struct nvm_ioctl_remove =
*remove)
> {
> 	struct nvm_target *t;
> +	struct block_device *bdev;
>=20
> 	mutex_lock(&dev->mlock);
> 	t =3D nvm_find_target(dev, remove->tgtname);
> @@ -380,6 +381,19 @@ static int nvm_remove_tgt(struct nvm_dev *dev, =
struct nvm_ioctl_remove *remove)
> 		mutex_unlock(&dev->mlock);
> 		return 1;
> 	}
> +	bdev =3D bdget_disk(t->disk, 0);
> +	if (!bdev) {
> +		pr_err("nvm: removal failed, allocating bd failed\n");
> +		mutex_unlock(&dev->mlock);
> +		return -ENOMEM;
> +	}
> +	if (bdev->bd_super || bdev->bd_part_count) {
> +		pr_err("nvm: removal failed, block device busy\n");
> +		bdput(bdev);
> +		mutex_unlock(&dev->mlock);
> +		return -EBUSY;
> +	}
> +	bdput(bdev);
> 	__nvm_remove_target(t);
> 	mutex_unlock(&dev->mlock);
>=20
> --
> 2.7.4

Looks good.

Reviewed-by: Javier Gonz=C3=A1lez <javier@cnexlabs.com>


--Apple-Mail=_A2261A1F-9C49-4CA9-9CCA-5B8F999554A5
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCgAGBQJZt9+vAAoJEGMfBTt1mRjKXdcP/3hNqjxFnaqnT2vRVh3TuIVO
eSb79pmu8Z7I2TlM7XKE4gKdkLRw1qiOrxuk62eAkGaFuOvm2cJmZrdsmawyP4M6
yGQkAyiaMPWLEgxyIifXyLg5dscbf1PM4lSvPVPTQp9s8lAS8LRYIDUG4yrcBdFp
6mNuz/zH8cGF1lkvNmxCWO6bsW5RBNado3rMhR7GbrITNPkookboT43ReBTI8mzM
z0LdV9fECUb9t91qv9rByHtqdKuoaaNh6C+w0TySKav5k67VXbokt7rsmFPxiHGB
W/QRDqGDCgQPPG2x99PAm+NijW+nFoVYV2WlJ5lrvC9Q+EgaGYa/4izVC+BfIqRU
PUj47T+riNWpXxobG+EkTF/VImUvM6gST1PLZ6y4dDcZNONBT2qZYUnWN81FSZdD
P4HB6cVH7bUAIXft5frD8gH0freUDLr0SNuF9z9yLA9zKcCZ+NVoDvSrSsi/mp9W
l6cRnSX7Ppzw/jPCWX9dTwxJFMvWLdDOH3wjlQ7Oxndbw8qfPliUxw1ypGwlhhbK
9MXfWP2DlDzTXMhc8wrb6i0+3XGbz7vUIr+Agi95A5Lpl0HKnZeVo/JBDMmhxIbw
WMqIq7qSPjlj2KXiImJKgNO4nGHwh7wRqtRWmIXOmFx+Dy63zbNQsLDoT+/wBreE
VgdA3UItnZrQ8zmXinQp
=NGYr
-----END PGP SIGNATURE-----

--Apple-Mail=_A2261A1F-9C49-4CA9-9CCA-5B8F999554A5--
