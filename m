Return-Path: <SRS0=AbZH=R4=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 634DDC43381
	for <linux-block@archiver.kernel.org>; Mon, 25 Mar 2019 06:35:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2084C2082C
	for <linux-block@archiver.kernel.org>; Mon, 25 Mar 2019 06:35:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=javigon-com.20150623.gappssmtp.com header.i=@javigon-com.20150623.gappssmtp.com header.b="Hi25zDFs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729623AbfCYGfH (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 25 Mar 2019 02:35:07 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:40658 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729400AbfCYGfH (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 25 Mar 2019 02:35:07 -0400
Received: by mail-ed1-f67.google.com with SMTP id h22so6460966edw.7
        for <linux-block@vger.kernel.org>; Sun, 24 Mar 2019 23:35:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=javigon-com.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=9GA413kFH52UBqknFO4CPOQb30KIfmMtyTN70Rlc58I=;
        b=Hi25zDFsvjvbMh8IY+PFtCgWUXSkf8Ix7TwpNKYqXGJ6xnxC/2WQQs3yyg2Rkq0qjB
         jxihWkxWlllQP5gyjIQUed/uaQCPVUXI2D6f2HLk3G4DLva2StOzvfJ9t9eLMSQ6oUdA
         Pi55CfQ0VF54FONZvorXknlPl3lA1HkIUQluL9yMDxnolmCtSHmtADfGzSLXNT5T1RrQ
         mbIauITLR4gPoj1SWhjn0HiukAYXFO3zRyxv/f/nmlbHgoE82sZc9rgdfXUwhsx7vykm
         ypJoZ7VkQZPTbEj39qk5ltTlSM6SYqGutMwEEq7w4JAEfruDcBcGr4qeh/VGJq7Ngj8r
         mIhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=9GA413kFH52UBqknFO4CPOQb30KIfmMtyTN70Rlc58I=;
        b=IDhMlHJ1H1J5R7s9tiIn3W0M8vOhtXPKxzGF2/a/Kg7SpTnzFeaqVUaFXieA4PE2+w
         cI71IUfJUJkVJtmckPkbxHqYZwoSTwgP8tDaDKvuKCSsezw9T2UF4LOoOtL6qtemrD+5
         m+HCrJrGgp3r40fs4R+ZbB3RSZV/eQxT60ikkBTM7xJQTY2FJxGjIIjfqtC4Anq9rBPH
         rLAp7ny/LH/lkwVtm0jB/uch1CIfy70ceb9IASh/KoK1x/TeJeVUENqHxKrNGS+x2/4D
         fyTcZAoLXNekGDRO0o3M++FiVVgTZ6uRV5BNyizPFRhAEhv6pivm4InHLBt52gEyGeuQ
         QMBg==
X-Gm-Message-State: APjAAAVpW94+GpOz6uB+jD8bMyX28cBcqNyr6w23BMpklFMpH7xWyMzs
        EVKi26ayWlMUlQlXOYMYIlgKcQ==
X-Google-Smtp-Source: APXvYqydPmTHP5tfrTXWeNCgYDMYAFgGZ4K4Yqu7Zd67zu2zFyTCk5lHnl3jaHWinwT5l+eEKJF+jQ==
X-Received: by 2002:a50:e8cc:: with SMTP id l12mr14577268edn.125.1553495705485;
        Sun, 24 Mar 2019 23:35:05 -0700 (PDT)
Received: from [172.30.99.70] ([37.120.153.227])
        by smtp.gmail.com with ESMTPSA id j14sm3277784ejc.69.2019.03.24.23.35.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 24 Mar 2019 23:35:04 -0700 (PDT)
From:   =?utf-8?Q?Javier_Gonz=C3=A1lez?= <javier@javigon.com>
Message-Id: <796F80BA-E8ED-4AAC-880D-623C0C245B2A@javigon.com>
Content-Type: multipart/signed;
        boundary="Apple-Mail=_B947C0C4-40CC-45CB-B25E-8BAB57F8C935";
        protocol="application/pgp-signature";
        micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Subject: Re: [RFC PATCH v2] lightnvm: add mechanism to trigger pblk close on
 reboot
Date:   Mon, 25 Mar 2019 14:35:00 +0800
In-Reply-To: <1553278047-13115-1-git-send-email-marcin.dziegielewski@intel.com>
Cc:     =?utf-8?Q?Matias_Bj=C3=B8rling?= <mb@lightnvm.io>,
        Hans Holmberg <hans.holmberg@cnexlabs.com>,
        linux-block@vger.kernel.org,
        "Konopko, Igor J" <igor.j.konopko@intel.com>
To:     Marcin Dziegielewski <marcin.dziegielewski@intel.com>
References: <1553278047-13115-1-git-send-email-marcin.dziegielewski@intel.com>
X-Mailer: Apple Mail (2.3445.102.3)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


--Apple-Mail=_B947C0C4-40CC-45CB-B25E-8BAB57F8C935
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

> On 23 Mar 2019, at 02.07, Marcin Dziegielewski =
<marcin.dziegielewski@intel.com> wrote:
>=20
> Currently if we issue reboot to the system pblk will close
> ungracefully and in consequence it will need recovery on load.
>=20
> This patch propose utilize of reboot notifier feature to trigger
> gracefull pblk shutdown on reboot.
>=20
> Signed-off-by: Marcin Dziegielewski <marcin.dziegielewski@intel.com>
> =E2=80=94

Please, add changes since V1 next time.

> drivers/lightnvm/core.c | 65 =
++++++++++++++++++++++++++++++++++++++-----------
> 1 file changed, 51 insertions(+), 14 deletions(-)
>=20
> diff --git a/drivers/lightnvm/core.c b/drivers/lightnvm/core.c
> index 5f82036..4a421f5 100644
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
> @@ -1138,9 +1139,52 @@ struct nvm_dev *nvm_alloc_dev(int node)
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

Nip: Can you align all values at =E2=80=98=3D=E2=80=98?

> +};
> +
> int nvm_register(struct nvm_dev *dev)
> {
> 	int ret, exp_pool_size;
> +	bool is_first;
>=20
> 	if (!dev->q || !dev->ops)
> 		return -EINVAL;
> @@ -1161,32 +1205,25 @@ int nvm_register(struct nvm_dev *dev)
> 		return -ENOMEM;
> 	}
>=20
> -	/* register device with a supported media manager */
> 	down_write(&nvm_lock);
> +	is_first =3D list_empty(&nvm_devices);
> +
> +	/* register device with a supported media manager */
> 	list_add(&dev->devices, &nvm_devices);
> 	up_write(&nvm_lock);
>=20
> +	if (is_first)
> +		register_reboot_notifier(&nvm_notifier);
> +
> 	return 0;
> }
> EXPORT_SYMBOL(nvm_register);
>=20
> void nvm_unregister(struct nvm_dev *dev)
> {
> -	struct nvm_target *t, *tmp;
> -
> -	mutex_lock(&dev->mlock);
> -	list_for_each_entry_safe(t, tmp, &dev->targets, list) {
> -		if (t->dev->parent !=3D dev)
> -			continue;
> -		__nvm_remove_target(t, false);
> -	}
> -	mutex_unlock(&dev->mlock);
> -
> 	down_write(&nvm_lock);
> -	list_del(&dev->devices);
> +	_nvm_unregister(dev, false);
> 	up_write(&nvm_lock);
> -
> -	nvm_free(dev);
> }
> EXPORT_SYMBOL(nvm_unregister);
>=20
> --
> 1.8.3.1

Otherwise, it looks good to me.

Reviewed-by: Javier Gonz=C3=A1lez <javier@javigon.com>



--Apple-Mail=_B947C0C4-40CC-45CB-B25E-8BAB57F8C935
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEU1dMZpvMIkj0jATvPEYBfS0leOAFAlyYdpQACgkQPEYBfS0l
eOBGTA/9FyMeDxpb/Mgh5Kh/NY33exvGBjy1QXeP7ts/vDQ1KdWHbPbQPH1pEfWq
uOwEiLbkN31lMokgEmXKBavDN+XmWCK2Lm1P4X4F0gAeSrelHgr2zA3eXmM9qINC
oqWXaZUrNuuN8tIvBEkA0vXP6VAz615qXpRBNpwLMICjFE4L/8t9W8cvQDNL+qbE
yy7MFZLPcxwvczDMHwqthHPrtd5+T9mCOFPbyS4q1lSiVKEQ00CLJpW8QfnfP5GG
+app4qODu45pbm472lAki8Kd1vj5n1s5tm14gPaniJvCvWPUSkysXQr41kqGVEXo
zFPxXHT+1nbpHAFhyMPp11pvQrCnbhH7ZjiGN+b8BWEyCrQX9dCtEuYxcsIQiwD7
afWkVB7k7iu27UfZcTD9G/JnONwRExuPW5bo+vigQ4YYyW7b2eIc1LRlTOxwtHVY
1pFMq0tcJ+SMcIJmru2cR4hym60L+/fDhJ/vJyXpzIWw8NwK1+AgSG0zBgPUaWSx
Xgsi6MV4zjSgZHFE+drT9S5VHfWh8i+pUOeT843eU32IMv5MLrwTlpZj0im+sSKf
kQqCpTXkkyiAek+9mPPGpbsyirOL7jMMNSkqL2LFcE9Awhny7+o2zICDAq3SxdIg
XyiFyB6xLnHnIPcBb0RzjOhvvoxGPwUie/a+VChL00+Gtr8V82Q=
=ocvJ
-----END PGP SIGNATURE-----

--Apple-Mail=_B947C0C4-40CC-45CB-B25E-8BAB57F8C935--
