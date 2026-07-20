Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0280923D2B1;
	Mon, 20 Jul 2026 18:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784573376; cv=none; b=ehznftKClrIdTuCFPiyHp6NlmvHVfQYNdtAXB0Z9qmZKAHpY3p6Uf8D4tqkGKh0BzT7bOQLu995rtHs94aaQQa6MUK1lshmafUnLV27iHJ+7N6bOBRtMnMebJPNgOTjRdFfNzMyOYQsx7Y5x1fnLKgObiHf7iKybcw5iFdbVb/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784573376; c=relaxed/simple;
	bh=OhNzCATyQBeJ/tFrKYJcGPdhwSupL9fu7lJgTKOLqfo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WetjOztylUqE2ZJ3R1MfFuiy60GHKeVz3RJAA1pfYFkNe2ka2XmjxeWGwVpBJVomOg9fJMzXNBqMWODnXnFSfXFHHxBdP4gfAnL6aH+WwgEajoXbRJwolWR8/8zyj38MTOCD3v2giqBllzAEpupFPsIly3N6zSnNK/qkYE7AM10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vivier.eu; spf=pass smtp.mailfrom=vivier.eu; dkim=pass (2048-bit key) header.d=vivier.eu header.i=laurent@vivier.eu header.b=RxFttJ3V; arc=none smtp.client-ip=212.227.17.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vivier.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivier.eu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivier.eu header.i=laurent@vivier.eu header.b="RxFttJ3V"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivier.eu;
	s=s1-ionos; t=1784573366; x=1785178166; i=laurent@vivier.eu;
	bh=IgTEkYUuClOCbRFuXb52Qc4uye6iryj6alPBPksO8yI=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=RxFttJ3VFcdUkREK05NPeH5sGR8bjR0Q4oybJXd4KQpZjXsKVrEzTrM4fO9VKPKi
	 Qsr8c4COelOz/00LJQ35Q/AOvnZOif1hiHoz1fY0JDeCKhfHZLtSA2acZ1QxiLRhD
	 psdi21Bpv4x7d+l4JmuYHJfFPzBJ852KorbdUhjp2HdPQnTGCNszS9+6hmYqJLan7
	 iUd1swu8Z+rYdHKB+sV1xnfr27nSrdGZRUw2XRX2gnn9HNVAULDZD0th5KFsHmJ7i
	 uEU7nXtbHjBY3ANpryoWjrLRXBxkY6BHfA+lwx6HQwUh8++Y+FA5GFPSQi962cHYA
	 8Dqs8z2XyI8GTi9acg==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from client.hidden.invalid by mrelayeu.kundenserver.de (mreue109
 [213.165.67.119]) with ESMTPSA (Nemesis) id 1MMGZM-1wSZFY1lZO-00OQ6Q; Mon, 20
 Jul 2026 20:49:26 +0200
Message-ID: <3c341f2e-8c58-4c7f-81b4-488064af9ff5@vivier.eu>
Date: Mon, 20 Jul 2026 20:49:25 +0200
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/31] swim: Enable clock divider only where appropriate
To: Finn Thain <fthain@linux-m68k.org>, Jens Axboe <axboe@kernel.dk>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
 Joshua Thompson <funaho@jurai.org>, linux-block@vger.kernel.org,
 linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org
References: <cover.1784196135.git.fthain@linux-m68k.org>
 <043de8859e96216310712deacbbf9e622e5c77cf.1784196135.git.fthain@linux-m68k.org>
Content-Language: fr
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; keydata=
 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
In-Reply-To: <043de8859e96216310712deacbbf9e622e5c77cf.1784196135.git.fthain@linux-m68k.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:xRIHGBKQcRE7H+TpLPP3iEEw7LJ0RRZ8s8iIV8hfcq52QmKgDln
 Wikn4lyTCCbhEUUx1GcnEhCQxW7xlSsHo/ujZewyJBeh8zJHIcLV6JWj5qe6O1PUACEBuk1
 uSb1PK1Fgr0O8xWiZpZaaRPm7hOxI4+qX3frstwV4NjHz+CDib+tdZhWm7fyJAI2YU9dVyk
 Mgi9lJ8oH+JfhvLmQDVAQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:fP2Y0AtmYMA=;uk2h0NfF/Rg0kD7E7z+bDa1tTO1
 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

Le 16/07/2026 =C3=A0 12:02, Finn Thain a =C3=A9crit=C2=A0:
> Some models have a 16 MHz FCLK oscillator and others 32 MHz. Put this
> information into the swim device platform_data so that the driver can
> correctly enable the clock divider. When this is enabled incorrectly,
> nothing can be read and failures from the Error Correction Machine are
> flagged in the error register.
>=20
> This is chip initialization, so do this in swim_floppy_init() rather
> than floppy_open(). Drop the udelay() which was apparently copied and
> pasted from swim3.c, where it relates to interrupts (of which this chip
> has none).
>=20
> Cc: Joshua Thompson <funaho@jurai.org>
> Fixes: 8852ecd97488 ("m68k: mac - Add SWIM floppy support")
> Signed-off-by: Finn Thain <fthain@linux-m68k.org>
> ---
>   arch/m68k/mac/config.c | 31 ++++++++++++++++++++++++++++++-
>   drivers/block/swim.c   | 11 +++++++----
>   2 files changed, 37 insertions(+), 5 deletions(-)
>=20

Reviewed-by: Laurent Vivier <laurent@vivier.eu>

> diff --git a/arch/m68k/mac/config.c b/arch/m68k/mac/config.c
> index c0033f885ed4..dba3de21c3c4 100644
> --- a/arch/m68k/mac/config.c
> +++ b/arch/m68k/mac/config.c
> @@ -984,8 +984,37 @@ static int __init mac_platform_init(void)
>   			.start =3D swim_base,
>   			.end   =3D swim_base + 0x1FFF,
>   		};
> +		unsigned int data =3D 0;
> +
> +		/* Models in this list are supposed to run FCLK at 32 MHz */
> +		switch (macintosh_config->ident) {
> +		case MAC_MODEL_CCL:
> +		case MAC_MODEL_CCLII:
> +		case MAC_MODEL_LCIII:
> +		case MAC_MODEL_Q605:
> +		case MAC_MODEL_Q605_ACC:
> +		case MAC_MODEL_Q610:
> +		case MAC_MODEL_Q630:
> +		case MAC_MODEL_Q650:
> +		case MAC_MODEL_Q800:
> +		case MAC_MODEL_P460:
> +		case MAC_MODEL_P475:
> +		case MAC_MODEL_P475F:
> +		case MAC_MODEL_P520:
> +		case MAC_MODEL_P550:
> +		case MAC_MODEL_P575:
> +		case MAC_MODEL_P588:
> +		case MAC_MODEL_TV:
> +		case MAC_MODEL_C610:
> +		case MAC_MODEL_C650:
> +		case MAC_MODEL_PB190:
> +		case MAC_MODEL_PB520:
> +			data =3D 1;
> +			break;
> +		}
>  =20
> -		platform_device_register_simple("swim", -1, &swim_rsrc, 1);
> +		platform_device_register_resndata(NULL, "swim", -1, &swim_rsrc, 1,
> +						  &data, sizeof(data));
>   	}
>  =20
>   	/*
> diff --git a/drivers/block/swim.c b/drivers/block/swim.c
> index 481fb1e63ac1..c49e584cd663 100644
> --- a/drivers/block/swim.c
> +++ b/drivers/block/swim.c
> @@ -628,8 +628,7 @@ static int floppy_open(struct gendisk *disk, blk_mod=
e_t mode)
>   		fs->ref_count =3D -1;
>   	else
>   		fs->ref_count++;
> -	swim_write(base, setup, S_IBM_DRIVE  | S_FCLK_DIV2);
> -	udelay(10);
> +
>   	swim_drive(base, fs->location);
>   	swim_motor(base, ON);
>   	swim_action(base, SETMFM);
> @@ -807,8 +806,10 @@ static void swim_set_parameters(struct swim __iomem=
 *base)
>   		swim_write(base, parameter, mem[i]);
>   }
>  =20
> -static int swim_floppy_init(struct swim_priv *swd)
> +static int swim_floppy_init(struct platform_device *pdev)
>   {
> +	struct swim_priv *swd =3D platform_get_drvdata(pdev);
> +	unsigned int *data =3D pdev->dev.platform_data;
>   	struct queue_limits lim =3D {
>   		.features		=3D BLK_FEAT_ROTATIONAL,
>   	};
> @@ -816,6 +817,8 @@ static int swim_floppy_init(struct swim_priv *swd)
>   	int drive;
>   	struct swim __iomem *base =3D swd->base;
>  =20
> +	swim_write(base, setup, S_IBM_DRIVE | (*data ? S_FCLK_DIV2 : 0));
> +
>   	swim_set_parameters(base);
>  =20
>   	/* scan floppy drives */
> @@ -930,7 +933,7 @@ static int swim_probe(struct platform_device *dev)
>  =20
>   	swd->base =3D swim_base;
>  =20
> -	ret =3D swim_floppy_init(swd);
> +	ret =3D swim_floppy_init(dev);
>   	if (ret)
>   		goto out_kfree;
>  =20

