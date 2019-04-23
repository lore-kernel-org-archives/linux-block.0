Return-Path: <SRS0=N4qE=SZ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01E18C10F14
	for <linux-block@archiver.kernel.org>; Tue, 23 Apr 2019 07:12:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1A1820674
	for <linux-block@archiver.kernel.org>; Tue, 23 Apr 2019 07:12:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=javigon-com.20150623.gappssmtp.com header.i=@javigon-com.20150623.gappssmtp.com header.b="dElFWff/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725946AbfDWHMp (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 23 Apr 2019 03:12:45 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:35120 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725888AbfDWHMp (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 23 Apr 2019 03:12:45 -0400
Received: by mail-ed1-f67.google.com with SMTP id y67so11660538ede.2
        for <linux-block@vger.kernel.org>; Tue, 23 Apr 2019 00:12:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=javigon-com.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=V8z1tK7Gdk9DVZWlh0R69re1W7Qu89u9WCcc8yIWzBc=;
        b=dElFWff/GGnyEUk7bbTIfDR39+uCajMuaiH60YLzhryGp87bHAPABVXDE0pU5IAoQ6
         QVhCcWDb2BUsLh6K5NB/OiN7fkA3vALmrDdU2+txylyIBM7iRN35sCz5+H9QlUKEb3D9
         8GDgC6WcNFvP4nBPKsRJwhhSl/gxkgu4VxqVYQ2qqeLKy/SgJPdOsHMTR1s5CAMuSE7u
         Ob9FVVvtq674tMMswRezy2OlxLH6KrYqydsgHTbMjFqnYkZIzJPyYFjID5z1xmhJWx+2
         nIOqYadzTn4gmldhZmtQ3yJJ3/N2VmUkBoeXG+RwJt83NbYdVTozJmv+CNhhPG1lv2v0
         W8bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=V8z1tK7Gdk9DVZWlh0R69re1W7Qu89u9WCcc8yIWzBc=;
        b=GLLz02AXtbfjdFHm0tSilQt5MgnNQmVwQNL4lCULQcSOg4/Sq+FEUqPm9AvRuqpEU/
         W41yMY2YlqtMC4b0HTGKeGlu/00N3h+LuEPav1wBoL95zGkiZ9M7VD+AoTuKNEG1gyuO
         S4mVVCXsbz2EhwMquldvfpLx8bDFEdRI1chB4TEVc8XvAc5bRPjVP1I0r6sMJEh0ZDE/
         Sk85uGJGXsc31Rd/XTRpH6W/+zzUeiTxFh9pjYU5q16Dj3ITXLyIM/OxF7bTruGVaWE/
         tGTLW9nGZm5axqAwThlL7jBYXz5HV24fkbnqm+bv0n2a0vZDs5H7MESYKwH8bhEMozd+
         QFyw==
X-Gm-Message-State: APjAAAXeugrBHi0MrjZ/ik7lkR253wLHaUBdCrf7+UTdoFJ6IdPgDXTc
        rwMUaI8KBvnE6kLooJyMvbkBbQ==
X-Google-Smtp-Source: APXvYqyRgo0gVKhPGGuY7wuwdei9eUoOVpDjQi0sbhuiEo2+ZzRx5xty/f18LYXhHrlxQGjvF8oDrQ==
X-Received: by 2002:aa7:d50a:: with SMTP id y10mr14703530edq.261.1556003562917;
        Tue, 23 Apr 2019 00:12:42 -0700 (PDT)
Received: from [192.168.1.119] (ip-5-186-122-168.cgn.fibianet.dk. [5.186.122.168])
        by smtp.gmail.com with ESMTPSA id j18sm2708741edf.72.2019.04.23.00.12.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Apr 2019 00:12:42 -0700 (PDT)
From:   =?utf-8?Q?Javier_Gonz=C3=A1lez?= <javier@javigon.com>
Message-Id: <492AAEF8-5176-44FF-9F6D-BB729E8AE708@javigon.com>
Content-Type: multipart/signed;
        boundary="Apple-Mail=_741DBE0D-1E77-4446-BF5E-F707C030551E";
        protocol="application/pgp-signature";
        micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.8\))
Subject: Re: [PATCH v4 6/7] lightnvm: track inflight target creations
Date:   Tue, 23 Apr 2019 09:12:41 +0200
In-Reply-To: <20190416101648.10045-7-igor.j.konopko@intel.com>
Cc:     =?utf-8?Q?Matias_Bj=C3=B8rling?= <mb@lightnvm.io>,
        Hans Holmberg <hans.holmberg@cnexlabs.com>,
        linux-block@vger.kernel.org
To:     "Konopko, Igor J" <igor.j.konopko@intel.com>
References: <20190416101648.10045-1-igor.j.konopko@intel.com>
 <20190416101648.10045-7-igor.j.konopko@intel.com>
X-Mailer: Apple Mail (2.3445.104.8)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


--Apple-Mail=_741DBE0D-1E77-4446-BF5E-F707C030551E
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

> On 16 Apr 2019, at 12.16, Igor Konopko <igor.j.konopko@intel.com> =
wrote:
>=20
> When creation process is still in progress, target is not yet on
> targets list. This causes a chance for removing whole lightnvm
> subsystem by calling nvm_unregister() in the meantime and finally by
> causing kernel panic inside target init function.
>=20
> This patch changes the behaviour by adding kref variable which tracks
> all the users of nvm_dev structure. When nvm_dev is allocated, kref
> value is set to 1. Then before every target creation the value is
> increased and decreased after target removal. The extra reference
> is decreased when nvm subsystem is unregistered.
>=20
> Signed-off-by: Igor Konopko <igor.j.konopko@intel.com>
> ---
> drivers/lightnvm/core.c  | 41 =
+++++++++++++++++++++++++++++++----------
> include/linux/lightnvm.h |  1 +
> 2 files changed, 32 insertions(+), 10 deletions(-)
>=20
> diff --git a/drivers/lightnvm/core.c b/drivers/lightnvm/core.c
> index e2abe88..0e9f7996 100644
> --- a/drivers/lightnvm/core.c
> +++ b/drivers/lightnvm/core.c
> @@ -45,6 +45,8 @@ struct nvm_dev_map {
> 	int num_ch;
> };
>=20
> +static void nvm_free(struct kref *ref);
> +
> static struct nvm_target *nvm_find_target(struct nvm_dev *dev, const =
char *name)
> {
> 	struct nvm_target *tgt;
> @@ -501,6 +503,7 @@ static int nvm_remove_tgt(struct nvm_dev *dev, =
struct nvm_ioctl_remove *remove)
> 	}
> 	__nvm_remove_target(t, true);
> 	mutex_unlock(&dev->mlock);
> +	kref_put(&dev->ref, nvm_free);
>=20
> 	return 0;
> }
> @@ -1094,15 +1097,16 @@ static int nvm_core_init(struct nvm_dev *dev)
> 	return ret;
> }
>=20
> -static void nvm_free(struct nvm_dev *dev)
> +static void nvm_free(struct kref *ref)
> {
> -	if (!dev)
> -		return;
> +	struct nvm_dev *dev =3D container_of(ref, struct nvm_dev, ref);
>=20
> 	if (dev->dma_pool)
> 		dev->ops->destroy_dma_pool(dev->dma_pool);
>=20
> -	nvm_unregister_map(dev);
> +	if (dev->rmap)
> +		nvm_unregister_map(dev);
> +
> 	kfree(dev->lun_map);
> 	kfree(dev);
> }
> @@ -1139,7 +1143,13 @@ static int nvm_init(struct nvm_dev *dev)
>=20
> struct nvm_dev *nvm_alloc_dev(int node)
> {
> -	return kzalloc_node(sizeof(struct nvm_dev), GFP_KERNEL, node);
> +	struct nvm_dev *dev;
> +
> +	dev =3D kzalloc_node(sizeof(struct nvm_dev), GFP_KERNEL, node);
> +	if (dev)
> +		kref_init(&dev->ref);
> +
> +	return dev;
> }
> EXPORT_SYMBOL(nvm_alloc_dev);
>=20
> @@ -1147,12 +1157,16 @@ int nvm_register(struct nvm_dev *dev)
> {
> 	int ret, exp_pool_size;
>=20
> -	if (!dev->q || !dev->ops)
> +	if (!dev->q || !dev->ops) {
> +		kref_put(&dev->ref, nvm_free);
> 		return -EINVAL;
> +	}
>=20
> 	ret =3D nvm_init(dev);
> -	if (ret)
> +	if (ret) {
> +		kref_put(&dev->ref, nvm_free);
> 		return ret;
> +	}
>=20
> 	exp_pool_size =3D max_t(int, PAGE_SIZE,
> 			      (NVM_MAX_VLBA * (sizeof(u64) + =
dev->geo.sos)));
> @@ -1162,7 +1176,7 @@ int nvm_register(struct nvm_dev *dev)
> 						  exp_pool_size);
> 	if (!dev->dma_pool) {
> 		pr_err("nvm: could not create dma pool\n");
> -		nvm_free(dev);
> +		kref_put(&dev->ref, nvm_free);
> 		return -ENOMEM;
> 	}
>=20
> @@ -1184,6 +1198,7 @@ void nvm_unregister(struct nvm_dev *dev)
> 		if (t->dev->parent !=3D dev)
> 			continue;
> 		__nvm_remove_target(t, false);
> +		kref_put(&dev->ref, nvm_free);
> 	}
> 	mutex_unlock(&dev->mlock);
>=20
> @@ -1191,13 +1206,14 @@ void nvm_unregister(struct nvm_dev *dev)
> 	list_del(&dev->devices);
> 	up_write(&nvm_lock);
>=20
> -	nvm_free(dev);
> +	kref_put(&dev->ref, nvm_free);
> }
> EXPORT_SYMBOL(nvm_unregister);
>=20
> static int __nvm_configure_create(struct nvm_ioctl_create *create)
> {
> 	struct nvm_dev *dev;
> +	int ret;
>=20
> 	down_write(&nvm_lock);
> 	dev =3D nvm_find_nvm_dev(create->dev);
> @@ -1208,7 +1224,12 @@ static int __nvm_configure_create(struct =
nvm_ioctl_create *create)
> 		return -EINVAL;
> 	}
>=20
> -	return nvm_create_tgt(dev, create);
> +	kref_get(&dev->ref);
> +	ret =3D nvm_create_tgt(dev, create);
> +	if (ret)
> +		kref_put(&dev->ref, nvm_free);
> +
> +	return ret;
> }
>=20
> static long nvm_ioctl_info(struct file *file, void __user *arg)
> diff --git a/include/linux/lightnvm.h b/include/linux/lightnvm.h
> index d3b0270..4d0d565 100644
> --- a/include/linux/lightnvm.h
> +++ b/include/linux/lightnvm.h
> @@ -428,6 +428,7 @@ struct nvm_dev {
> 	char name[DISK_NAME_LEN];
> 	void *private_data;
>=20
> +	struct kref ref;
> 	void *rmap;
>=20
> 	struct mutex mlock;
> --
> 2.9.5

Much better with the kref()


Reviewed-by: Javier Gonz=C3=A1lez <javier@javigon.com>


--Apple-Mail=_741DBE0D-1E77-4446-BF5E-F707C030551E
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEU1dMZpvMIkj0jATvPEYBfS0leOAFAly+uukACgkQPEYBfS0l
eOCmlg//dN7YGjg4noYpEm00aGFqsWRsTl33ba2qTrb4HCo74FClc3DRD+mjVhD3
0O+ogUjuGwdaMB99Ayukkg3TS3xz5jp7O9PdW+Hf6xzGozRahLQ5OSDV7QWUNjhS
xggLNKva0+XyDQfiOcAv+QvIe3fs2q366UGCYFRuhmqTJTRsDaxlIVIvJMvqCHeT
AHza5wls0Z/u+kdn2TsfmhyODDxpD7gRFfgVovEyEFdnAiWHA4Y/vhHRZhe1bTHS
nd1Y3+EBJM1IVCuQfY5WzpnmiShqDmBg2MSvUcDcvD1VNknmGn79VMQudUsCmEUi
eoXOusdvuIj9So9SkdOIxVs9R1RojGhbSWjDFhDmYXG1oG52aSZf2RTK/NM4g6uY
z8W1gN5en9S0+lYr8qAoSMPlCL8EUTYu6kqjsc2YyfRGo9XhthWp/DiTRi4oDSbn
va8Vshsl2ygWfEEZtUfd609+0/dBdvY3x9HY3ehIE8+2sw73UFN2muY31b8g4py4
lFM5DgKB/gO9hwMZy/ghrJ1QcwmT194fBaRRJmXp1wDotONVagpdQcLws0owYNxD
5YjIfO9gdWZ/3KLUVzI0zSri1kfMMgYYphEq/v7fiGR3HAr6VXbFZrzdiZEud6on
fXzazxGm4GtNTpqzqrzSczapCKBq1U0L12Zc7eNt3rIgIpALCKI=
=9gdG
-----END PGP SIGNATURE-----

--Apple-Mail=_741DBE0D-1E77-4446-BF5E-F707C030551E--
