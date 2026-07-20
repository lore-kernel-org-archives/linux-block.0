Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79C0B425893;
	Mon, 20 Jul 2026 13:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784553755; cv=none; b=UQhvcN1fbtP7dmhGBZdpI5ICJzF6Nbn6xFk7DIH8vqGhpu0wTj45tQGDF9UbIP3xJKRlzqip+6CPvEDvxYoI3MLJjTCse1L85TbTsjjypOhENy0jr9u8C8BOmAd9EaEE7dFW7uYPyv5/KYO3EtZzxLc1McK6rs4BHrj4rKVFCuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784553755; c=relaxed/simple;
	bh=R1CeUUmGlyZ8V6OKL8LfGdYG/GD3a2jatkU0ixGNjtc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Xt5ifUQ6RmEjk9d7pIiadOTKPsuAKTmlGwW8sQzwAJY5C5qjwXIc0qT78W59vutKUxpY1Z9hWIx8wXINSMXqtl+ltK5Vfc+5XzLPBcbItD8FhhZEbWI+7dY3o8UP6RH6nBM8oeKkJXkwvH5AFIftAKL4WBRHPo9gRgHSyokNthU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vivier.eu; spf=pass smtp.mailfrom=vivier.eu; dkim=pass (2048-bit key) header.d=vivier.eu header.i=laurent@vivier.eu header.b=lsG05Sal; arc=none smtp.client-ip=217.72.192.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vivier.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivier.eu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivier.eu header.i=laurent@vivier.eu header.b="lsG05Sal"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivier.eu;
	s=s1-ionos; t=1784553750; x=1785158550; i=laurent@vivier.eu;
	bh=52FB1fUO6weyGqBY9EnL11WrjXDeW95oj1dqhWO6rl4=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=lsG05SalASJA2o/kQ8jOh9XSUZC7FPZC9KoNBJy4rBgT69EHExBocBUUIbQ8BatI
	 30oH9japNIHSMWZmEWmoJsupjQIr2xxcDMUMbKoeSjXNNH9NZ33H7sTzpcY8teFJ8
	 IxQwZu5gzB6raNN6psq0uhRN0pkFWr4VVDHtVkJ5J69KSH0C3ZdwULqhUn9cSnTF+
	 v0cKzRzNm04CRcyZybh4LEkQWyhS3f6MhsVwl+1nvp/guGDkPxlgMDVctHIRiBrjj
	 ZXltUXGPMqFz3HcCLNnuZSn2pzkerVHMvGgpALrBRokSTV31SfmSpyPjupElwgy4I
	 oh1pYaTBcPZISG0bHQ==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from client.hidden.invalid by mrelayeu.kundenserver.de (mreue108
 [213.165.67.119]) with ESMTPSA (Nemesis) id 1Mv2pC-1x3buw0cD2-00zpbd; Mon, 20
 Jul 2026 15:22:30 +0200
Message-ID: <c71fd9de-6379-4d45-9443-b3036aab889b@vivier.eu>
Date: Mon, 20 Jul 2026 15:22:29 +0200
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/31] swim: Assert strobe with stable outputs
To: Finn Thain <fthain@linux-m68k.org>, Jens Axboe <axboe@kernel.dk>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
 Joshua Thompson <funaho@jurai.org>, linux-block@vger.kernel.org,
 linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org
References: <cover.1784196135.git.fthain@linux-m68k.org>
 <998aeb6ae4536503516df34ae38709835c61c8cb.1784196135.git.fthain@linux-m68k.org>
Content-Language: fr
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; keydata=
 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
In-Reply-To: <998aeb6ae4536503516df34ae38709835c61c8cb.1784196135.git.fthain@linux-m68k.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:mpz8CBijKy1tTStWH/QJAwFy3rDDYXTF+5qr3LeIgYdjx2knR5i
 q9uhfat12mruh39T5BD0VA034/hTxxeQRfsOXU0h4qeudoF9dvvYNzZOmF6czbKApvuhOx/
 8q/KIk8zx7l+KX2gRi+sw7B1DR74xlb8pZgHJSoIXv8QxcHxE8iYMM08Do36T1qzs3pfsKg
 ZmamGOPwGnI5Rv+983hCQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:LW7CBH3DgvM=;jV0GUupaKkwlOaxQHSf3R1luxPR
 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

Le 16/07/2026 =C3=A0 12:02, Finn Thain a =C3=A9crit=C2=A0:
> Inside Macintosh says, "Be sure that you don't change CA0-CA2 or SEL
> while LSTRB is high". Unfortunately, those bits do change. The CA0-CA2
> outputs become inputs when (LSTRB << 4) | LSTRB gets written to the
> phase register. Then when LSTRB is driven low, CA0-CA2 get driven high.
>=20
> This is a problem because the drive interprets a STEP command as an
> EJECT command when these pins float high. This occurs intermittently,
> perhaps because interrupts are disabled and the race condition happens
> to end well. However, when I add code to step the heads with interrupts
> enabled, the disk always ejects.
>=20
> Keep the four phase pin directions set to output and hold their levels
> constant during LSTRB signalling.

Perhaps you can also add a short comment to describe the changes you made =
to the defines.

Reviewed-by: Laurent Vivier <laurent@vivier.eu>

Thansk,
Laurent

> Fixes: 8852ecd97488 ("m68k: mac - Add SWIM floppy support")
> Signed-off-by: Finn Thain <fthain@linux-m68k.org>
> ---
>   drivers/block/swim.c | 52 ++++++++++++++++++++++----------------------
>   1 file changed, 26 insertions(+), 26 deletions(-)
>=20
> diff --git a/drivers/block/swim.c b/drivers/block/swim.c
> index 0ccc12a72388..b61e92d0e3e9 100644
> --- a/drivers/block/swim.c
> +++ b/drivers/block/swim.c
> @@ -89,35 +89,35 @@ struct iwm {
>  =20
>   /* bits in phase register */
>  =20
> -#define SEEK_POSITIVE	0x070
> -#define SEEK_NEGATIVE	0x074
> -#define STEP		0x071
> -#define MOTOR_ON	0x072
> -#define MOTOR_OFF	0x076
> -#define INDEX		0x073
> -#define EJECT		0x077
> -#define SETMFM		0x171
> -#define SETGCR		0x175
> +#define SEEK_POSITIVE	0x0F0
> +#define SEEK_NEGATIVE	0x0F4
> +#define STEP		0x0F1
> +#define MOTOR_ON	0x0F2
> +#define MOTOR_OFF	0x0F6
> +#define INDEX		0x0F3
> +#define EJECT		0x0F7
> +#define SETMFM		0x1F1
> +#define SETGCR		0x1F5
>  =20
> -#define RELAX		0x033
> -#define LSTRB		0x008
> +#define RELAX		0x0F3
> +#define LSTRB		0x0F8
>  =20
> -#define CA_MASK		0x077
> +#define CA_MASK		0x0F7
>  =20
>   /* Select values for swim_select and swim_readbit */
>  =20
> -#define READ_DATA_0	0x074
> -#define ONEMEG_DRIVE	0x075
> -#define SINGLE_SIDED	0x076
> -#define DRIVE_PRESENT	0x077
> -#define DISK_IN		0x170
> -#define WRITE_PROT	0x171
> -#define TRACK_ZERO	0x172
> -#define TACHO		0x173
> -#define READ_DATA_1	0x174
> -#define GCR_MODE	0x175
> -#define SEEK_COMPLETE	0x176
> -#define TWOMEG_MEDIA	0x177
> +#define READ_DATA_0	0x0F4
> +#define ONEMEG_DRIVE	0x0F5
> +#define SINGLE_SIDED	0x0F6
> +#define DRIVE_PRESENT	0x0F7
> +#define DISK_IN		0x1F0
> +#define WRITE_PROT	0x1F1
> +#define TRACK_ZERO	0x1F2
> +#define TACHO		0x1F3
> +#define READ_DATA_1	0x1F4
> +#define GCR_MODE	0x1F5
> +#define SEEK_COMPLETE	0x1F6
> +#define TWOMEG_MEDIA	0x1F7
>  =20
>   /* Bits in handshake register */
>  =20
> @@ -284,9 +284,9 @@ static inline void swim_action(struct swim __iomem *=
base, int action)
>  =20
>   	swim_select(base, action);
>   	udelay(1);
> -	swim_write(base, phase, (LSTRB<<4) | LSTRB);
> +	swim_write(base, phase, action | LSTRB);
>   	udelay(1);
> -	swim_write(base, phase, (LSTRB<<4) | ((~LSTRB) & 0x0F));
> +	swim_write(base, phase, action);
>   	udelay(1);
>  =20
>   	local_irq_restore(flags);

