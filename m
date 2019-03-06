Return-Path: <SRS0=tltz=RJ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0968CC43381
	for <linux-block@archiver.kernel.org>; Wed,  6 Mar 2019 07:28:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AEDB0206DD
	for <linux-block@archiver.kernel.org>; Wed,  6 Mar 2019 07:28:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=javigon-com.20150623.gappssmtp.com header.i=@javigon-com.20150623.gappssmtp.com header.b="0pZ+5zjY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729270AbfCFH2V (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 6 Mar 2019 02:28:21 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:41746 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729269AbfCFH2U (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 6 Mar 2019 02:28:20 -0500
Received: by mail-ed1-f67.google.com with SMTP id x7so9434792eds.8
        for <linux-block@vger.kernel.org>; Tue, 05 Mar 2019 23:28:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=javigon-com.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=yrWffL3K3UwNbSx2RkSiaaqXBoocm6fzYbUgjQLxduo=;
        b=0pZ+5zjY/COylS3KhjeNT/+J+pSeEr8Oqf46d1L5RFtI4NBszWghG09JLiB63wLvMY
         byx0E142BRkJESJnVEoMNYf3Y4T+PoGI1XRV44+RHQXahVO9MTN543TMWnzcjihSW5t+
         7KUTdWEFE9U0s4kuB3b8vtGKlLEovZGhMi95VmMU9vVvvqtP0FXU42WFq5J4aKdW1TnF
         rjJKl3ifSOiDlRVia5OjoYGDeJCcVW11ulA4obie7QZwymDl3k5rmUfY8e7qY5q/SOci
         fG/GyGwWRCcF5HyVo4OYWTvvXzWN5wowPhMtIJc6YhM6ENZcJmjVdbmyvhe5yuK3YflE
         RYXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=yrWffL3K3UwNbSx2RkSiaaqXBoocm6fzYbUgjQLxduo=;
        b=XFZdUAkYJUXmxDJM6gCnFGQdp0Hpfkl/NLEyduIMt4si5e/Kky/KAAhkwe0mOxrkwI
         cipNjd42iCKBlYx4kDsxhvIUt82541WvMcacX81kF9e0U0tMYUMmB/7Fyhs/zlYhqF3m
         3ODeYtsvgAENTNkUJSfYbAvX6AK7qMZIaRTs4hegBm1CN9cvw5xtq2wYKA+Q9K4MgNxA
         DJC4IyakuBy+WMdp0fNpuQJBC2v84DTGNDtUHkm3bPoNP9Vh4fo9KzDdwGpYWW0p1/fv
         VGab44VYBYP0fDO3WHLHW7x0eTidi1Hndn3JlLU0LgjNDnoEzIU860++MS0khP7dAPMN
         pyCA==
X-Gm-Message-State: APjAAAWegSgV9vMsw9ath07fZ7EEmZR4KuRhATBYSj8zi0xbJiA1HIOU
        N4ToQuLBsS88q09vgcHYyz6z/g==
X-Google-Smtp-Source: APXvYqx8p0RfJechmfiJpupMmXtgamGorEA/ZNxNNuyYLz3bS0GdzPCM6ko9Zi8OGFXvEiFCcRd8NA==
X-Received: by 2002:a50:81e4:: with SMTP id 91mr22452606ede.274.1551857298584;
        Tue, 05 Mar 2019 23:28:18 -0800 (PST)
Received: from [192.168.1.119] (ip-5-186-122-168.cgn.fibianet.dk. [5.186.122.168])
        by smtp.gmail.com with ESMTPSA id v4sm188551ejj.4.2019.03.05.23.28.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Mar 2019 23:28:17 -0800 (PST)
From:   =?utf-8?Q?Javier_Gonz=C3=A1lez?= <javier@javigon.com>
Message-Id: <7739757A-D33E-4E82-A050-09CBB32EDE46@javigon.com>
Content-Type: multipart/signed;
        boundary="Apple-Mail=_A542A857-6FFF-4D94-B8B4-6C326CBB7C6C";
        protocol="application/pgp-signature";
        micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Subject: Re: [PATCH v2 3/8] lightnvm: pblk: Count all read errors in stats
Date:   Wed, 6 Mar 2019 08:28:17 +0100
In-Reply-To: <20190305135120.29284-4-igor.j.konopko@intel.com>
Cc:     =?utf-8?Q?Matias_Bj=C3=B8rling?= <mb@lightnvm.io>,
        Hans Holmberg <hans.holmberg@cnexlabs.com>,
        linux-block@vger.kernel.org
To:     "Konopko, Igor J" <igor.j.konopko@intel.com>
References: <20190305135120.29284-1-igor.j.konopko@intel.com>
 <20190305135120.29284-4-igor.j.konopko@intel.com>
X-Mailer: Apple Mail (2.3445.102.3)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


--Apple-Mail=_A542A857-6FFF-4D94-B8B4-6C326CBB7C6C
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

> On 5 Mar 2019, at 14.51, Igor Konopko <igor.j.konopko@intel.com> =
wrote:
>=20
> Currently when unknown error occurs on read path there is only dmesg
> information about it, but it is not counted in sysfs statistics.
>=20
> We would also like to track the number of such a requests, so new type
> of counter 'read_ctrl_errors" is added in that patch.
>=20
> Signed-off-by: Igor Konopko <igor.j.konopko@intel.com>
> ---
> drivers/lightnvm/pblk-core.c  | 1 +
> drivers/lightnvm/pblk-init.c  | 1 +
> drivers/lightnvm/pblk-sysfs.c | 3 ++-
> drivers/lightnvm/pblk.h       | 1 +
> 4 files changed, 5 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/lightnvm/pblk-core.c =
b/drivers/lightnvm/pblk-core.c
> index 39280c1..64280e6 100644
> --- a/drivers/lightnvm/pblk-core.c
> +++ b/drivers/lightnvm/pblk-core.c
> @@ -493,6 +493,7 @@ void pblk_log_read_err(struct pblk *pblk, struct =
nvm_rq *rqd)
> 		atomic_long_inc(&pblk->read_failed);
> 		break;
> 	default:
> +		atomic_long_inc(&pblk->read_ctrl_errors);
> 		pblk_err(pblk, "unknown read error:%d\n", rqd->error);
> 	}
> #ifdef CONFIG_NVM_PBLK_DEBUG
> diff --git a/drivers/lightnvm/pblk-init.c =
b/drivers/lightnvm/pblk-init.c
> index 81e8ed4..f4b6d8f2 100644
> --- a/drivers/lightnvm/pblk-init.c
> +++ b/drivers/lightnvm/pblk-init.c
> @@ -1230,6 +1230,7 @@ static void *pblk_init(struct nvm_tgt_dev *dev, =
struct gendisk *tdisk,
> 	atomic_long_set(&pblk->read_empty, 0);
> 	atomic_long_set(&pblk->read_high_ecc, 0);
> 	atomic_long_set(&pblk->read_failed_gc, 0);
> +	atomic_long_set(&pblk->read_ctrl_errors, 0);
> 	atomic_long_set(&pblk->write_failed, 0);
> 	atomic_long_set(&pblk->erase_failed, 0);
>=20
> diff --git a/drivers/lightnvm/pblk-sysfs.c =
b/drivers/lightnvm/pblk-sysfs.c
> index 7d8958d..922273c 100644
> --- a/drivers/lightnvm/pblk-sysfs.c
> +++ b/drivers/lightnvm/pblk-sysfs.c
> @@ -94,11 +94,12 @@ static ssize_t pblk_sysfs_stats(struct pblk *pblk, =
char *page)
> 	ssize_t sz;
>=20
> 	sz =3D snprintf(page, PAGE_SIZE,
> -			"read_failed=3D%lu, read_high_ecc=3D%lu, =
read_empty=3D%lu, read_failed_gc=3D%lu, write_failed=3D%lu, =
erase_failed=3D%lu\n",
> +			"read_failed=3D%lu, read_high_ecc=3D%lu, =
read_empty=3D%lu, read_failed_gc=3D%lu, read_ctrl_errors=3D%lu, =
write_failed=3D%lu, erase_failed=3D%lu\n",
> 			atomic_long_read(&pblk->read_failed),
> 			atomic_long_read(&pblk->read_high_ecc),
> 			atomic_long_read(&pblk->read_empty),
> 			atomic_long_read(&pblk->read_failed_gc),
> +			atomic_long_read(&pblk->read_ctrl_errors),
> 			atomic_long_read(&pblk->write_failed),
> 			atomic_long_read(&pblk->erase_failed));
>=20
> diff --git a/drivers/lightnvm/pblk.h b/drivers/lightnvm/pblk.h
> index 381f074..6c82776 100644
> --- a/drivers/lightnvm/pblk.h
> +++ b/drivers/lightnvm/pblk.h
> @@ -684,6 +684,7 @@ struct pblk {
> 	atomic_long_t read_empty;
> 	atomic_long_t read_high_ecc;
> 	atomic_long_t read_failed_gc;
> +	atomic_long_t read_ctrl_errors;
> 	atomic_long_t write_failed;
> 	atomic_long_t erase_failed;
>=20
> --
> 2.9.5

The only nitpick would be that if any user space script is relying on
the syses output for the errors, this could break them. Maybe we could
add a sysfs version file to mange this? Otherwise, it looks good.

Reviewed-by: Javier Gonz=C3=A1lez <javier@javigon.com>

--Apple-Mail=_A542A857-6FFF-4D94-B8B4-6C326CBB7C6C
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEU1dMZpvMIkj0jATvPEYBfS0leOAFAlx/dpEACgkQPEYBfS0l
eOC2axAAx9wm98ps7sPolHa8RbEvp51qXnlCzq45c2NVwRrIyTbEk1x0ozDf64c+
GRVTztgj3J2l31jBdq++ckKvT1DMk/OQYCBtAUQOBzbYOcUuhUJ9amlk9k5p/8LE
EHbeMP8l8xoouJCWqWBB4SMYPfScqY13cxKoyCv+2d8CW7gGNOtLgcNZ1y+RtkyR
+V4b+HeCLee35pMGdU2N9cTy/hNgDP6BwFECKamsz07MBFFsCbbb+PXeFEMccBNv
iGpHjC3SMoQgCTixet5L8JxjkR0NUoZDgjYPeUbtR9nzt0ksAIU5BwBTWptMECt0
sAQBPKUYZ7YWY+SDcqHlTuxBFPObBol3DiXCZWM0+Wk78VrihLfj4pTMHk+GczhR
DUb0Fr2fTyVItKb5X9ueAHMrOvDxoKQNByEM9UfviMbqsfexlXY+K4I2aKvwnbMF
Tq174ZEGr4BmSyy8gOHWGWhOjhSN+NEKPU0OZ5/snIcgL1bC8n5xhCf2HKyIWeGa
Z49aiAXWDaPhkWOI1uwmxg71uSOU8KDcwa1h5HV6tnUR56EchFMJ2TCl9E9MlkJP
+GWoFtETbEZNRKFo5VbVy8xEBr9DWbegh0YKXZK3fRBda323L3d4D/hJ3Gnm2ejC
fWgl7DPB8WE71lQpaQZkGpYKCrfc0z+AUsb5IL3J8zhQ94/PpZI=
=qbPa
-----END PGP SIGNATURE-----

--Apple-Mail=_A542A857-6FFF-4D94-B8B4-6C326CBB7C6C--
