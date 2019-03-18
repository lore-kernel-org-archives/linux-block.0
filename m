Return-Path: <SRS0=WbMh=RV=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41B81C43381
	for <linux-block@archiver.kernel.org>; Mon, 18 Mar 2019 07:49:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1080D20828
	for <linux-block@archiver.kernel.org>; Mon, 18 Mar 2019 07:49:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=javigon-com.20150623.gappssmtp.com header.i=@javigon-com.20150623.gappssmtp.com header.b="fojxzmGz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727173AbfCRHt6 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 18 Mar 2019 03:49:58 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:36526 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727086AbfCRHt6 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 18 Mar 2019 03:49:58 -0400
Received: by mail-ed1-f67.google.com with SMTP id e4so12645961edi.3
        for <linux-block@vger.kernel.org>; Mon, 18 Mar 2019 00:49:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=javigon-com.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=sNgccMIlfCDVQo6Pj7zW2Om/wRKQrm9buvNvWAU+8OI=;
        b=fojxzmGzfxL1phBfWAmFAQW3G5aFTmbSXnHkAYasdu1JOpiAszh6T9XuaMMhRazy/q
         B5wOlF205HICnNEQCLem4RJvRa1f+JqeUc+kp8wbirCB6Vv3hQypM5JaVawPtAtbCU2m
         lpWrpWkNQzwErFlCZ/C7aq5W5GpiwbfC27My2zCULokLGtoOUw45B2OiWJhU9H0yFvzQ
         zUB13nWwpP0nkgOS6MmxR3JDS7dAc62XrFI0wrEsh5zALAlSRDtL2K1jTRtAD/PXIhGY
         lxN0iSMxCqmmN+PRmRO07m311Z8KeFz1BYijrELb+yHvpUdGLQEVDCJQyKH1jtDgm6Hc
         9yjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=sNgccMIlfCDVQo6Pj7zW2Om/wRKQrm9buvNvWAU+8OI=;
        b=T1AJN4x190kn4hYgWg3SGyn0URhnGPne8zVD9mNNw9t/LxgTCuBQBYlvrWg4EAvEFR
         GRETCHvWaxOWSxa6KpdRBIBcHj78UTuRhnr8Gdrf0DO3unGU/Y85iUFlTKN9Z6Tb69IB
         4xY/i5xjckBb9T7IR8U/pi7Wt6ALNcZob94O1aVzsCn4hkTclsjcP319ImFphD97WBts
         MU0QhAz9EpV2k2kqyY7g4EnhoyCgGm4aUKDIMgMxfUX7PaBce1Hic1nNAm2fvF4KXKh7
         78P7pWS+Y0f8U4TklNhJrlhtnMFHDxLkvrFwq4Ux4fn8QvXThZm5UKYHLHEMLswg8PbV
         CIuQ==
X-Gm-Message-State: APjAAAVJSoJmmdIiBk+QoHhWaIosBurdm+q1H7H6OU1Q2FqqjCZKv9fG
        qV2fpXlkX0gZMBMto/TryMGWKA==
X-Google-Smtp-Source: APXvYqyq5wf2mG/LwDsOg5IDs0T+vlhxFrbtUtXR4aW9hSm2Pf4TyIZfzGviyDb3TCQlMegQLpn0Rw==
X-Received: by 2002:a50:8916:: with SMTP id e22mr12211361ede.242.1552895395965;
        Mon, 18 Mar 2019 00:49:55 -0700 (PDT)
Received: from [192.168.1.119] (ip-5-186-122-168.cgn.fibianet.dk. [5.186.122.168])
        by smtp.gmail.com with ESMTPSA id w9sm653483edw.41.2019.03.18.00.49.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Mar 2019 00:49:55 -0700 (PDT)
From:   =?utf-8?Q?Javier_Gonz=C3=A1lez?= <javier@javigon.com>
Message-Id: <F9876AA5-6EB3-42D3-B27C-7E9C46CC94ED@javigon.com>
Content-Type: multipart/signed;
        boundary="Apple-Mail=_6510140C-D31E-45E2-9D28-0AEBF977E6D9";
        protocol="application/pgp-signature";
        micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Subject: Re: [PATCH 17/18] lightnvm: allow to use full device path
Date:   Mon, 18 Mar 2019 08:49:54 +0100
In-Reply-To: <20190314160428.3559-18-igor.j.konopko@intel.com>
Cc:     =?utf-8?Q?Matias_Bj=C3=B8rling?= <mb@lightnvm.io>,
        Hans Holmberg <hans.holmberg@cnexlabs.com>,
        linux-block@vger.kernel.org
To:     "Konopko, Igor J" <igor.j.konopko@intel.com>
References: <20190314160428.3559-1-igor.j.konopko@intel.com>
 <20190314160428.3559-18-igor.j.konopko@intel.com>
X-Mailer: Apple Mail (2.3445.102.3)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


--Apple-Mail=_6510140C-D31E-45E2-9D28-0AEBF977E6D9
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

> On 14 Mar 2019, at 17.04, Igor Konopko <igor.j.konopko@intel.com> =
wrote:
>=20
> This patch adds the possibility to provide full device path (like
> /dev/nvme0n1) when specifying device on top of which pblk instance
> should be created/removed.
>=20
> This makes creation of targets from nvme-cli (or other ioctl based
> tools) more unified with other commands in comparison with current
> situation where almost all commands uses full device path with except
> of lightnvm creation/removal parameter which uses just 'nvme0n1'
> naming convention. After this changes both approach will be valid.
>=20
> Signed-off-by: Igor Konopko <igor.j.konopko@intel.com>
> ---
> drivers/lightnvm/core.c | 23 ++++++++++++++++++-----
> 1 file changed, 18 insertions(+), 5 deletions(-)
>=20
> diff --git a/drivers/lightnvm/core.c b/drivers/lightnvm/core.c
> index c01f83b..838c3d8 100644
> --- a/drivers/lightnvm/core.c
> +++ b/drivers/lightnvm/core.c
> @@ -1195,6 +1195,21 @@ void nvm_unregister(struct nvm_dev *dev)
> }
> EXPORT_SYMBOL(nvm_unregister);
>=20
> +#define PREFIX_STR "/dev/"
> +static void nvm_normalize_path(char *path)
> +{
> +	path[DISK_NAME_LEN - 1] =3D '\0';
> +	if (!memcmp(PREFIX_STR, path,
> +				sizeof(char) * strlen(PREFIX_STR))) {
> +		/*
> +		 * User provide name in '/dev/nvme0n1' format,
> +		 * so we need to skip '/dev/' for comparison
> +		 */
> +		memmove(path, path + sizeof(char) * strlen(PREFIX_STR),
> +			(DISK_NAME_LEN - strlen(PREFIX_STR)) * =
sizeof(char));
> +	}
> +}
> +
> static int __nvm_configure_create(struct nvm_ioctl_create *create)
> {
> 	struct nvm_dev *dev;
> @@ -1304,9 +1319,9 @@ static long nvm_ioctl_dev_create(struct file =
*file, void __user *arg)
> 		return -EINVAL;
> 	}
>=20
> -	create.dev[DISK_NAME_LEN - 1] =3D '\0';
> +	nvm_normalize_path(create.dev);
> +	nvm_normalize_path(create.tgtname);
> 	create.tgttype[NVM_TTYPE_NAME_MAX - 1] =3D '\0';
> -	create.tgtname[DISK_NAME_LEN - 1] =3D '\0';
>=20
> 	if (create.flags !=3D 0) {
> 		__u32 flags =3D create.flags;
> @@ -1333,7 +1348,7 @@ static long nvm_ioctl_dev_remove(struct file =
*file, void __user *arg)
> 	if (copy_from_user(&remove, arg, sizeof(struct =
nvm_ioctl_remove)))
> 		return -EFAULT;
>=20
> -	remove.tgtname[DISK_NAME_LEN - 1] =3D '\0';
> +	nvm_normalize_path(remove.tgtname);
>=20
> 	if (remove.flags !=3D 0) {
> 		pr_err("nvm: no flags supported\n");
> @@ -1373,8 +1388,6 @@ static long nvm_ioctl_dev_factory(struct file =
*file, void __user *arg)
> 	if (copy_from_user(&fact, arg, sizeof(struct =
nvm_ioctl_dev_factory)))
> 		return -EFAULT;
>=20
> -	fact.dev[DISK_NAME_LEN - 1] =3D '\0';
> -
> 	if (fact.flags & ~(NVM_FACTORY_NR_BITS - 1))
> 		return -EINVAL;
>=20
> --
> 2.9.5

Looks good to me.

Reviewed-by: Javier Gonz=C3=A1lez <javier@javigon.com>


--Apple-Mail=_6510140C-D31E-45E2-9D28-0AEBF977E6D9
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEU1dMZpvMIkj0jATvPEYBfS0leOAFAlyPTaIACgkQPEYBfS0l
eODCTRAAxgHzWSfX+hr2DJxci40kGt1wqLYkuc4Z8qaMNMxMTwHmNdUD86k7VgnB
VypH2DXSUewgEGc4cAqmoTOfMw4p2O2cyBBn9fQVwthVOeg2wgq5ED6bIiof1+Qv
xQuXEUQgYLVKEUxFS0JHkaYfsY1ziA+OeunQJrbJJ1aLUfqdlWeIDzzBdNxjVxiM
jqRYOkWf7LrteMEiOhP/c7kEhpvotKytJRpO6DrMysqfqpDi4Ywnbktpo6tzzs/l
lIT+P4TCVko82sfNdybxamSKYArG6si12izOnyKVx/CFrsLq0RWsebYV70g/8B0+
OF3EY7Yah7Hhz/PFilPLHUshTl5KYA+pYIf6tkHPhBtYJRiglZQ0S2u3J7JdkUMU
s02kLCGGi7HnvD9KCcvXUJew4CuAZaWjxID5wwGVGFiG8hICgN0feUKDedi3w/ZA
rkEgoV/TUhFPZIJyMSe79v2ySgcNAaZ2L5Nupch/6y/mdDYCXwgqNLULSF66EHcu
8V18rjC/RKb3dB+bg+/U07+Nsg2Rir7D6QRsIIxN632BM0YxEafPW0dPSg672v4g
sGn9fKje8+NXY4a1UEGgPOQAa7HB4AxiK1kiqBKdtUJeK3GbiTH2AY/iZ7DykS+b
0qS8AMLlEzFRzAnok6EE2j2qQMYtxYcADVY+vwT34SSYuW/GyXk=
=w/X/
-----END PGP SIGNATURE-----

--Apple-Mail=_6510140C-D31E-45E2-9D28-0AEBF977E6D9--
