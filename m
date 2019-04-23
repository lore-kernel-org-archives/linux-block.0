Return-Path: <SRS0=N4qE=SZ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6406C10F14
	for <linux-block@archiver.kernel.org>; Tue, 23 Apr 2019 07:13:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 959CD20674
	for <linux-block@archiver.kernel.org>; Tue, 23 Apr 2019 07:13:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=javigon-com.20150623.gappssmtp.com header.i=@javigon-com.20150623.gappssmtp.com header.b="T+LpxIiA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725937AbfDWHNg (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 23 Apr 2019 03:13:36 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:41738 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725888AbfDWHNg (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 23 Apr 2019 03:13:36 -0400
Received: by mail-ed1-f68.google.com with SMTP id g6so11630639edc.8
        for <linux-block@vger.kernel.org>; Tue, 23 Apr 2019 00:13:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=javigon-com.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=o8l7IBljJCmQEhMSqjE9IIDXZSnmgKYMuhObq0BTPzQ=;
        b=T+LpxIiArfnlj7KuNFSLa47n1vdJ/vBSoad/BkFLsigFxW3Y2pNDVJhc7hQQVGdmev
         hwffwkbJURulLiGQPDuSxamf+Lk8Nu/FoloPP3wXXQ43eaULSa1eDAL//7YXhBlvgXFw
         EaMvaWYLR3KjJ8EbGbQs3v9XZ7eBGrlSFZIALRMF8MbCea+fnq2GJcfqdskI6jrpB87J
         1iIGIpmhhtJGfm6pX8xbH9oRx0IK8mDwS7Vb1eBIChoYDrKI1yFkQSLUHjZVt178VYXb
         /RRBnBXyMKmboGIMl0rjnPeWfh916/+jzstbs9ywru8O6LXHhYOESpCgqTvnOulZHgXT
         94xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=o8l7IBljJCmQEhMSqjE9IIDXZSnmgKYMuhObq0BTPzQ=;
        b=CCWLIz1NWgs5ThGyzN4cLPi2TA07M9ImgVeao0p36/KdqfxTkHEF+SdmGn2WHSIrBk
         L3hFFVxtKEWB7D2Ssh3U+2wIQFbEct22F4FB1HMc/16tSOBamRKWF3r3b/iEQOblf+1n
         klADAbtVpXoeFcRFStwOmHS4CNxD4LZTKDtioXYcal7Q0aszNYYjcuH3F40Rxnlv+xAt
         vMZrCYSSNTfHUKK1F6PBRvn74UgyRa/DoO2siur7zbkxJ/gvma38AEHuplqV+0K37lEE
         NfswzduvZKCZneNVRAwiQovDM2pnybOrlz3mflVA09mD7gt6Xo7sbP7nQPuSbhGdh8HR
         6CeA==
X-Gm-Message-State: APjAAAV97dlToA7GJImQxxZB4btH2NuCE2475WjIqbtMvGHIK6cOV+Nj
        O19/5RW7pDFDjmQG8PKrpvhrgQ==
X-Google-Smtp-Source: APXvYqxNZW/IjEfXVSMXgeDYl1NCitMQSckYuddjnHbmvBLYQUVkgDAHnmtoIrm5I0LyZRefEenMVg==
X-Received: by 2002:a50:8822:: with SMTP id b31mr15124931edb.53.1556003613665;
        Tue, 23 Apr 2019 00:13:33 -0700 (PDT)
Received: from [192.168.1.119] (ip-5-186-122-168.cgn.fibianet.dk. [5.186.122.168])
        by smtp.gmail.com with ESMTPSA id j18sm2708741edf.72.2019.04.23.00.13.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Apr 2019 00:13:32 -0700 (PDT)
From:   =?utf-8?Q?Javier_Gonz=C3=A1lez?= <javier@javigon.com>
Message-Id: <C85C0A87-4614-43F2-B007-E93858607293@javigon.com>
Content-Type: multipart/signed;
        boundary="Apple-Mail=_492FD766-1618-4F1B-BD5B-B0B89EA7F0F3";
        protocol="application/pgp-signature";
        micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.8\))
Subject: Re: [PATCH v4 7/7] lightnvm: do not remove instance under global lock
Date:   Tue, 23 Apr 2019 09:13:32 +0200
In-Reply-To: <20190416101648.10045-8-igor.j.konopko@intel.com>
Cc:     =?utf-8?Q?Matias_Bj=C3=B8rling?= <mb@lightnvm.io>,
        Hans Holmberg <hans.holmberg@cnexlabs.com>,
        linux-block@vger.kernel.org
To:     "Konopko, Igor J" <igor.j.konopko@intel.com>
References: <20190416101648.10045-1-igor.j.konopko@intel.com>
 <20190416101648.10045-8-igor.j.konopko@intel.com>
X-Mailer: Apple Mail (2.3445.104.8)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


--Apple-Mail=_492FD766-1618-4F1B-BD5B-B0B89EA7F0F3
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

> On 16 Apr 2019, at 12.16, Igor Konopko <igor.j.konopko@intel.com> =
wrote:
>=20
> Currently all the target instances are removed under global nvm_lock.
> This was needed to ensure that nvm_dev struct will not be freed by
> hot unplug event during target removal. However, current =
implementation
> has some drawbacks, since the same lock is used when new nvme =
subsystem
> is registered, so we can have a situation, that due to long process of
> target removal on drive A, registration (and listing in OS) of the
> drive B will take a lot of time, since it will wait for that lock.
>=20
> Now when we have kref which ensures that nvm_dev will not be freed in
> the meantime, we can easily get rid of this lock for a time when we =
are
> removing nvm targets.
>=20
> Signed-off-by: Igor Konopko <igor.j.konopko@intel.com>
> ---
> drivers/lightnvm/core.c | 34 ++++++++++++++++------------------
> 1 file changed, 16 insertions(+), 18 deletions(-)
>=20
> diff --git a/drivers/lightnvm/core.c b/drivers/lightnvm/core.c
> index 0e9f7996..0df7454 100644
> --- a/drivers/lightnvm/core.c
> +++ b/drivers/lightnvm/core.c
> @@ -483,7 +483,6 @@ static void __nvm_remove_target(struct nvm_target =
*t, bool graceful)
>=20
> /**
>  * nvm_remove_tgt - Removes a target from the media manager
> - * @dev:	device
>  * @remove:	ioctl structure with target name to remove.
>  *
>  * Returns:
> @@ -491,18 +490,27 @@ static void __nvm_remove_target(struct =
nvm_target *t, bool graceful)
>  * 1: on not found
>  * <0: on error
>  */
> -static int nvm_remove_tgt(struct nvm_dev *dev, struct =
nvm_ioctl_remove *remove)
> +static int nvm_remove_tgt(struct nvm_ioctl_remove *remove)
> {
> 	struct nvm_target *t;
> +	struct nvm_dev *dev;
>=20
> -	mutex_lock(&dev->mlock);
> -	t =3D nvm_find_target(dev, remove->tgtname);
> -	if (!t) {
> +	down_read(&nvm_lock);
> +	list_for_each_entry(dev, &nvm_devices, devices) {
> +		mutex_lock(&dev->mlock);
> +		t =3D nvm_find_target(dev, remove->tgtname);
> +		if (t) {
> +			mutex_unlock(&dev->mlock);
> +			break;
> +		}
> 		mutex_unlock(&dev->mlock);
> -		return 1;
> 	}
> +	up_read(&nvm_lock);
> +
> +	if (!t)
> +		return 1;
> +
> 	__nvm_remove_target(t, true);
> -	mutex_unlock(&dev->mlock);
> 	kref_put(&dev->ref, nvm_free);
>=20
> 	return 0;
> @@ -1348,8 +1356,6 @@ static long nvm_ioctl_dev_create(struct file =
*file, void __user *arg)
> static long nvm_ioctl_dev_remove(struct file *file, void __user *arg)
> {
> 	struct nvm_ioctl_remove remove;
> -	struct nvm_dev *dev;
> -	int ret =3D 0;
>=20
> 	if (copy_from_user(&remove, arg, sizeof(struct =
nvm_ioctl_remove)))
> 		return -EFAULT;
> @@ -1361,15 +1367,7 @@ static long nvm_ioctl_dev_remove(struct file =
*file, void __user *arg)
> 		return -EINVAL;
> 	}
>=20
> -	down_read(&nvm_lock);
> -	list_for_each_entry(dev, &nvm_devices, devices) {
> -		ret =3D nvm_remove_tgt(dev, &remove);
> -		if (!ret)
> -			break;
> -	}
> -	up_read(&nvm_lock);
> -
> -	return ret;
> +	return nvm_remove_tgt(&remove);
> }
>=20
> /* kept for compatibility reasons */
> --
> 2.9.5

Looks good to me


Reviewed-by: Javier Gonz=C3=A1lez <javier@javigon.com>


--Apple-Mail=_492FD766-1618-4F1B-BD5B-B0B89EA7F0F3
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEU1dMZpvMIkj0jATvPEYBfS0leOAFAly+uxwACgkQPEYBfS0l
eODrlQ//ZdWtuEn49PJmr6a1hdSBqtOCpp2mIfSWgWys6TZkuADYT6QYfqubFY0A
aKisF/VcQAZ8m3vhFS43t9W/0pnn1OAK59YAP7dvmK7QwhaWE1MK6LdI5jtEGgXj
ayVIApB/mNYLnpGx85nW/ZXgAZxzub3Ucn/aCs1CtNPgko3YENiuYQPS66VQhfxK
ZMoFx81oDXnjcwbuFXGI64Ob2y0e/VpoOQQBT4+76LoTQwMOflWuTdy0ABodgEBc
8GIhIf7sOw4tZPjxe4oj/ZRilRGSqTJUoHXM4/hKT7ta4GiF2IKnC+Gw04dgmTZK
pMX0x2uHtwvFIAEyY6+mD8V+mxYs3m1NpgOUFpqzWZxMGthLsnNldV5oPLwXWYGG
46f7YdwuXuNaDoQLdJzG+zRoyOO7xJLhuVgb2fE7QNE0EjjWreUkKOq8VBEmnjDM
5gZDiNoRrAIfrQZKTAP8U+r38sch9pcHLP5VcIPYmcv/rtu3Xng4Lfm5PxkmszYV
1afNTyOqbV/P3CqXa1KyID9eWa3pQjxQOpYExAFzwOAr/xi3gYZzP7cxL7wH4Yhb
vgL6qi1Cn9Iyx7g/VpZtEpk8+eS4iAdR49K884ZK3DdoVp1xzMyyk6kGRkqufUN8
MNY/FawoK6hAQ2ngYZz7NypHrHDbUfFC+Bpi4nL4wfg1HSOlYOI=
=/tRK
-----END PGP SIGNATURE-----

--Apple-Mail=_492FD766-1618-4F1B-BD5B-B0B89EA7F0F3--
