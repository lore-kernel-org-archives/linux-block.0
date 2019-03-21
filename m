Return-Path: <SRS0=o3qj=RY=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA156C43381
	for <linux-block@archiver.kernel.org>; Thu, 21 Mar 2019 09:17:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BDA3218A2
	for <linux-block@archiver.kernel.org>; Thu, 21 Mar 2019 09:17:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=javigon-com.20150623.gappssmtp.com header.i=@javigon-com.20150623.gappssmtp.com header.b="daHtbDps"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728063AbfCUJR6 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 21 Mar 2019 05:17:58 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:33337 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727948AbfCUJR6 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 21 Mar 2019 05:17:58 -0400
Received: by mail-ed1-f65.google.com with SMTP id q3so4394483edg.0
        for <linux-block@vger.kernel.org>; Thu, 21 Mar 2019 02:17:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=javigon-com.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=vwa5JrEK55RlxHbAcABRazN+7NLv0KOkDRMhxHW1N7M=;
        b=daHtbDpsgUx52NcXZmeJfA5d4Cba8bm8XDqfQS3Jhfj7JO9LXrNCLroc2DlBKGzEM0
         xgO9WDcJiEZbFwh4u0z+cq1FExpgp/58+ED2seQgiP486WVLdWrL61HK1HBy468sRVMH
         a3jwQ9/rYMu/yzRPXDR9IntVzZU3e1f3MHrUxm8fLu8R5eq1u6H+7AQb9ZwB8CPP+/wL
         x+qIZgMNns66okLLELXL4q/x5IHjwwKDkCES5jstNRAM5VQwrScof4T2/rSFI7yuZAGS
         HILUDyAgQl3X3pMi3EVryrvPqse3mgz3SLaETkMZGfDKUPl+m40F4pgKNcpFjXzPXjIv
         kVag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=vwa5JrEK55RlxHbAcABRazN+7NLv0KOkDRMhxHW1N7M=;
        b=lO0LkkwMmZ4peYWfflnNmS0+IQsvM/+J8Zh/W4fu6vqvE/XKKTRr91CkpMnTiSl4WP
         wOLgis/soM8woUC/tNrrophRUY1YEmkX6lOtWKCdVzCZ1OZqk/Iengn6fytqa+S1hHlR
         O5BfSS5kPvumMT8IkmyDNehZLpSVtLHpUxerNP8MY5+WwUydpHxKnLLWRqOsMn6ShkrH
         Hj0v7H4aZbeLZ+3Z+/SwlfUmEhUSgb3AT76jcc1arwl1TnT7mz1y5gwrnIelIrn2CCoF
         e1QtY6RZ2196vwwt9GZ4ejKBJnq2HFWC28q9B7aJqEEzKcsQ+QUEcA16OzGDZyUC+hgK
         YW5g==
X-Gm-Message-State: APjAAAWCukIYoAQcYXq4XLde7QjV4Gm+U9YbbtFSFe10kOiqTOOzguEu
        fMj1qYvO6J+5HOtewTHV8z/D/Q==
X-Google-Smtp-Source: APXvYqwWsy6Lbue64XiAdF1a6zH6KzZacObsmClINaxR1dK1OB/PKMXSJeZMkP8YOb64ukYBniLXzg==
X-Received: by 2002:aa7:dd0e:: with SMTP id i14mr1827878edv.172.1553159876903;
        Thu, 21 Mar 2019 02:17:56 -0700 (PDT)
Received: from [192.168.1.119] (ip-5-186-122-168.cgn.fibianet.dk. [5.186.122.168])
        by smtp.gmail.com with ESMTPSA id x18sm1422023edd.4.2019.03.21.02.17.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Mar 2019 02:17:56 -0700 (PDT)
From:   =?utf-8?Q?Javier_Gonz=C3=A1lez?= <javier@javigon.com>
Message-Id: <0673B702-0816-4FB6-B8BB-A08F8369E422@javigon.com>
Content-Type: multipart/signed;
        boundary="Apple-Mail=_791C2103-65FA-480C-9B0F-C7F45A4C0E79";
        protocol="application/pgp-signature";
        micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Subject: Re: [PATCH] lightnvm: add a lock to prevent before the race condition
 on pblk remove
Date:   Thu, 21 Mar 2019 10:17:55 +0100
In-Reply-To: <1553005484-10584-1-git-send-email-marcin.dziegielewski@intel.com>
Cc:     =?utf-8?Q?Matias_Bj=C3=B8rling?= <mb@lightnvm.io>,
        Hans Holmberg <hans.holmberg@cnexlabs.com>,
        linux-block@vger.kernel.org,
        "Konopko, Igor J" <igor.j.konopko@intel.com>
To:     Marcin Dziegielewski <marcin.dziegielewski@intel.com>
References: <1553005484-10584-1-git-send-email-marcin.dziegielewski@intel.com>
X-Mailer: Apple Mail (2.3445.102.3)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


--Apple-Mail=_791C2103-65FA-480C-9B0F-C7F45A4C0E79
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

> On 19 Mar 2019, at 15.24, Marcin Dziegielewski =
<marcin.dziegielewski@intel.com> wrote:
>=20
> When we trigger nvm target remove during device hot unplug, we
> have a chance to hit general protection fault caused by use of
> nvm_dev which was freed from another (hot unplug) thread (in
> nvm_unregister function).
>=20
> This patch introduce lock in nvme_ioctl_dev_remove function to
> prevent us before a situation like described above.
>=20
> Signed-off-by: Marcin Dziegielewski <marcin.dziegielewski@intel.com>
> ---
> drivers/lightnvm/core.c | 2 ++
> 1 file changed, 2 insertions(+)
>=20
> diff --git a/drivers/lightnvm/core.c b/drivers/lightnvm/core.c
> index 5f82036..84f0b9a 100644
> --- a/drivers/lightnvm/core.c
> +++ b/drivers/lightnvm/core.c
> @@ -1335,11 +1335,13 @@ static long nvm_ioctl_dev_remove(struct file =
*file, void __user *arg)
> 		return -EINVAL;
> 	}
>=20
> +	down_read(&nvm_lock);
> 	list_for_each_entry(dev, &nvm_devices, devices) {
> 		ret =3D nvm_remove_tgt(dev, &remove);
> 		if (!ret)
> 			break;
> 	}
> +	up_read(&nvm_lock);
>=20
> 	return ret;
> }
> --
> 1.8.3.1

Looks good to me.


Reviewed-by: Javier Gonz=C3=A1lez <javier@javigon.com>


--Apple-Mail=_791C2103-65FA-480C-9B0F-C7F45A4C0E79
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEU1dMZpvMIkj0jATvPEYBfS0leOAFAlyTVsMACgkQPEYBfS0l
eOAZHRAAkkfvw1BV6xjspYhd3R8Hv3xnB/FS/V/mr8FY0AzATTnvJiwjWn25ydA0
sYrkjCx6KfLKNTRbbXdnHVIDkk1joEcdk56M9v7IOtd91mB7kjCSWQeLzV4ASFrr
pWkJog1rMnttBCTTL6Xo68t+uZx7FQPJbb273B4CdZLd6/mZqxygjo2YYTOYfTdD
S+9GTKJuUD0J1rOA6uc1NA3ni4LEuRx+YbF4JsRig0xpB5DZ/MSWF+q8QYmw2tzM
wz+MmDCXXk4JOBPpsTqFTowTICe3+a/isxnzQjTo05GxtE5TElmPahYfhrJWhlR/
LbPKKS0MzbNAjtN+Qp4vGql+c3IdUDxFn7sNYUlE4EFkPmuYvV5fiirJbc5pspwJ
9ufiHiJyfGbEvHTvULngbRcN9J4IYaY2dH64Ynrq4WwbuHr+v0gS7kygiXFKDxvp
ZitJ4s3Q5luR1Zcj8X+N+5DHIiHMuXGQUvXSzIi6IL8swBCPz25PLewKlzbd+aCZ
d1XXew1i4giPOFfdlunGXFVLPdK9nQc6mUfKuBj5tEjN3/Bsg+RYGvxYAszt8LFF
/imJaW706+Fu3mWUrtQnfWZaYYm1/F0yf7GfipYasBkfBUPPtub+eKEfKIXnJKis
Ph1JcWSe531gwIk+DwZ6xYN0wrn1N60U78p5+nA1EkjHu6lu/v8=
=mWK0
-----END PGP SIGNATURE-----

--Apple-Mail=_791C2103-65FA-480C-9B0F-C7F45A4C0E79--
