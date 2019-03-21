Return-Path: <SRS0=o3qj=RY=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A20F9C43381
	for <linux-block@archiver.kernel.org>; Thu, 21 Mar 2019 09:32:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67E06218D4
	for <linux-block@archiver.kernel.org>; Thu, 21 Mar 2019 09:32:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=javigon-com.20150623.gappssmtp.com header.i=@javigon-com.20150623.gappssmtp.com header.b="jdRgbRcq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728158AbfCUJco (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 21 Mar 2019 05:32:44 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:44053 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727829AbfCUJco (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 21 Mar 2019 05:32:44 -0400
Received: by mail-ed1-f67.google.com with SMTP id x10so4375338edh.11
        for <linux-block@vger.kernel.org>; Thu, 21 Mar 2019 02:32:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=javigon-com.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=2YL8P1Gud+kgyP0gictAjePRXnBRtIJhyaGlPAgKDn4=;
        b=jdRgbRcqGepgm/tCAOF2UPJ5D1BEc2qmZTw0u7kYF4lt2uYUOL9Mdzel9MsCfFBYzL
         LEtW5heriqf/UeosIdVdeKi8W8hrtc+e2JIES20r0rHN6sGm/5av/GVff05RhvV+vWFH
         PMhdx63wToxx0G1r8Ux/dZ5zNSVW3Q2bQCPHdTU7xkdHdosLXXr9XzExJMsvo99EHOIv
         ArNYaN1LacT8LJeQ0m030/ufpY4RimgrZBnvxYJWXQa2c2r8Cf/FwWQkCIiBQKHEB71h
         bmlBxgZBVqrbviZaHZ2OATqRiWx4bcWLfw+uyx8jNKTDVOrsjiZSUMd9vUvU5ijdvvZX
         5DPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=2YL8P1Gud+kgyP0gictAjePRXnBRtIJhyaGlPAgKDn4=;
        b=g9qUQ8GHCp1CCyaN5aH1Lnad1Tesoo8FkDV9lVgET76U1bJtEL8/0iS0hox9QSTeNs
         9d6bHXTb8dMhMYSBh9NCfwyXzrcyuvSr8GjPhYx3gFH0aH6Mg0IH3HunPWgDwo7HT/ch
         pIw2tMXYpTkvzCmUxtLx2gNdXslEuYcGP++Yt42uGpd+uy1rYvpO0mKD27WziNxf3e7G
         kcT0dqGfBsvQoOiUYSAKopmiDLZd7/JzWvjw1B3EbSCXJF/GGfW5LAoclyh/cinbyXis
         pJpvr7kGl2O4wANu5NfN+bmV4wBAor23LnYRu05IAoEG0bplz8xPrt9wFjI5vc/61hQ0
         4FgQ==
X-Gm-Message-State: APjAAAUOfs+XnaOJY5wHX3z0QSRzgotkopprUXjseCl+7nF+3WKkCzCI
        bPpbMjA5jWpIyvFQlN0HgChpFw==
X-Google-Smtp-Source: APXvYqy7Rsr/eFKPDH6mxtRxWIo3rPh5lW0p84ivdkWBjWzMm8Xbx14TvCVlfOSEbuad4gHhjISgBw==
X-Received: by 2002:a17:906:46d1:: with SMTP id k17mr1715383ejs.104.1553160762590;
        Thu, 21 Mar 2019 02:32:42 -0700 (PDT)
Received: from [192.168.1.119] (ip-5-186-122-168.cgn.fibianet.dk. [5.186.122.168])
        by smtp.gmail.com with ESMTPSA id l15sm940682ejn.77.2019.03.21.02.32.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Mar 2019 02:32:41 -0700 (PDT)
From:   =?utf-8?Q?Javier_Gonz=C3=A1lez?= <javier@javigon.com>
Message-Id: <3925EE02-8AE8-4F99-BF85-A73B195C601C@javigon.com>
Content-Type: multipart/signed;
        boundary="Apple-Mail=_A85360AE-6771-4B46-AAE1-DDB6C7384268";
        protocol="application/pgp-signature";
        micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Subject: Re: [RFC PATCH] lightnvm: add mechanism to trigger pblk close on
 reboot
Date:   Thu, 21 Mar 2019 10:32:40 +0100
In-Reply-To: <1553096315-11128-1-git-send-email-marcin.dziegielewski@intel.com>
Cc:     =?utf-8?Q?Matias_Bj=C3=B8rling?= <mb@lightnvm.io>,
        Hans Holmberg <hans.holmberg@cnexlabs.com>,
        linux-block@vger.kernel.org,
        "Konopko, Igor J" <igor.j.konopko@intel.com>
To:     Marcin Dziegielewski <marcin.dziegielewski@intel.com>
References: <1553096315-11128-1-git-send-email-marcin.dziegielewski@intel.com>
X-Mailer: Apple Mail (2.3445.102.3)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


--Apple-Mail=_A85360AE-6771-4B46-AAE1-DDB6C7384268
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

> On 20 Mar 2019, at 16.38, Marcin Dziegielewski =
<marcin.dziegielewski@intel.com> wrote:
>=20
> Currently if we issue reboot to the system pblk will close
> ungracefully and in consequence it will need recovery on load.
>=20
> This patch propose utilize of reboot notifier feature to trigger
> gracefull pblk shutdown on reboot.
>=20
> Signed-off-by: Marcin Dziegielewski <marcin.dziegielewski@intel.com>
> ---
> drivers/lightnvm/core.c | 64 =
+++++++++++++++++++++++++++++++++++++++----------
> 1 file changed, 51 insertions(+), 13 deletions(-)
>=20
> diff --git a/drivers/lightnvm/core.c b/drivers/lightnvm/core.c
> index 5f82036..5488051 100644
> --- a/drivers/lightnvm/core.c
> +++ b/drivers/lightnvm/core.c
> @@ -27,6 +27,7 @@
> #include <linux/miscdevice.h>
> #include <linux/lightnvm.h>
> #include <linux/sched/sysctl.h>
> +#include <linux/reboot.h>
>=20
> static LIST_HEAD(nvm_tgt_types);
> static DECLARE_RWSEM(nvm_tgtt_lock);
> @@ -1138,6 +1139,48 @@ struct nvm_dev *nvm_alloc_dev(int node)
> }
> EXPORT_SYMBOL(nvm_alloc_dev);
>=20
> +static void _nvm_unregister(struct nvm_dev *dev, bool graceful)
> +{
> +	struct nvm_target *t, *tmp;
> +
> +	mutex_lock(&dev->mlock);
> +	list_for_each_entry_safe(t, tmp, &dev->targets, list) {
> +		if (t->dev->parent !=3D dev)
> +			continue;
> +		__nvm_remove_target(t, graceful);
> +	}
> +	mutex_unlock(&dev->mlock);
> +
> +	list_del(&dev->devices);
> +
> +	nvm_free(dev);
> +}
> +
> +static int nvm_notify_reboot(struct notifier_block *this,
> +			    unsigned long code, void *x)
> +{
> +	struct nvm_dev *dev, *t;
> +
> +	down_write(&nvm_lock);
> +	if (list_empty(&nvm_devices)) {
> +		up_write(&nvm_lock);
> +		return NOTIFY_DONE;
> +	}
> +
> +	list_for_each_entry_safe(dev, t, &nvm_devices, devices)
> +		_nvm_unregister(dev, true);
> +
> +	up_write(&nvm_lock);
> +
> +	return NOTIFY_DONE;
> +}
> +
> +static struct notifier_block nvm_notifier =3D {
> +	.notifier_call	=3D nvm_notify_reboot,
> +	.next		=3D NULL,
> +	.priority	=3D INT_MAX, /* before any real devices */

Why this priority?

> +};
> +
> int nvm_register(struct nvm_dev *dev)
> {
> 	int ret, exp_pool_size;
> @@ -1161,8 +1204,11 @@ int nvm_register(struct nvm_dev *dev)
> 		return -ENOMEM;
> 	}
>=20
> -	/* register device with a supported media manager */
> 	down_write(&nvm_lock);
> +	if (list_empty(&nvm_devices))
> +		register_reboot_notifier(&nvm_notifier);
> +
> +	/* register device with a supported media manager */
> 	list_add(&dev->devices, &nvm_devices);
> 	up_write(&nvm_lock);
>=20
> @@ -1172,21 +1218,13 @@ int nvm_register(struct nvm_dev *dev)
>=20
> void nvm_unregister(struct nvm_dev *dev)
> {
> -	struct nvm_target *t, *tmp;
> +	down_write(&nvm_lock);
>=20
> -	mutex_lock(&dev->mlock);
> -	list_for_each_entry_safe(t, tmp, &dev->targets, list) {
> -		if (t->dev->parent !=3D dev)
> -			continue;
> -		__nvm_remove_target(t, false);
> -	}
> -	mutex_unlock(&dev->mlock);
> +	_nvm_unregister(dev, false);

You are adding an extra lock dependency here. I cannot see any obvious
problem with it, but you probably want to test this with lock debugging
enabled.

>=20
> -	down_write(&nvm_lock);
> -	list_del(&dev->devices);
> +	if (list_empty(&nvm_devices))
> +		unregister_reboot_notifier(&nvm_notifier);
> 	up_write(&nvm_lock);
> -
> -	nvm_free(dev);
> }
> EXPORT_SYMBOL(nvm_unregister);
>=20
> --
> 1.8.3.1

Otherwise, I think adding this functionality is beneficial.



--Apple-Mail=_A85360AE-6771-4B46-AAE1-DDB6C7384268
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEU1dMZpvMIkj0jATvPEYBfS0leOAFAlyTWjgACgkQPEYBfS0l
eOBkgA/8DA3M4WM1eP4evOI4RLwlxOFTSkVd3xtsNI5YrYSNHsJtJiPHYztHwH1b
IF7XqzTgpttmRaPmZ6XFWlEi+st9hietA0JIhI2cVQiyo6zBSCYlQ8SZYgLRO03f
4GupLDGigCtNCAcmaeNjXXbRp9KL+4tMqgSVchfTgQ9ZlVsP5bDoswKvOQ/Gb1Pg
9lPqLT4SnV7snxm3Ar/HWUAH/6s0Yf1cBJMRiO0twHSDfusR0g9Z/Ovp19KBZW8B
oBa5HgIHWLR6Ifam9uilbqZ3EF9rtRQ7RyAEgUEyl7sv/OQ7+BeOhXLrI9qjEmS5
i2slUW+39i28K2z00ENtbCKRCSPcZm7TWNHNvhnZBbnBbp+w5eCVC45w836bnUs2
PDHm1Qlon2WYvp6nOi7C75FUAy1nRXIkZ/Ch27ay5iKk4+h/CoqDQAjB2z9tLi20
l1zriMFfUy7Q48MxeOMr0Y1xCRkEgnodPOOETg8NA5k4iT/thmL3n6u+bi2EgHz8
JIRZva0d/qi6l9G5Q+/lXz1eBgMoL/HAx5gF56/l6ztdU5K8N1kgarUK8ld8ClpE
8GKYkSUz9zjSzbKbE8pM3nHpEDDwK7gbbEFk5WU/PJ8ylW6nM+LslYZ28zCAXo5I
lCHhFr52Wj+mPYKxQ90+Rv4QT7660nZ1Mtp7StKTRHEhiMFf/QE=
=gc1/
-----END PGP SIGNATURE-----

--Apple-Mail=_A85360AE-6771-4B46-AAE1-DDB6C7384268--
