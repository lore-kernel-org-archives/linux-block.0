Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 764821C28E;
	Sun, 26 Jul 2026 15:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785080594; cv=none; b=USvdqUl47/8ZKx7lAtLYrmUQdUCdHGq/avRKlHG3oZLohyWb79P3YNxAeoUI2trveYaG2lb8b0SmDszY7VXABzfAmoIgkhlzx++Pelg54uVcrIvr4UWjcDRlJO6AAuusKAHxExekuDLI83zEPxPZP68wjx2TXRIjE6fdNEwB1T8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785080594; c=relaxed/simple;
	bh=n7iE/yntPI3uFNwpBVh40bqH3P6q9tzdbW1mUb0ASWw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=orYbxQ8thyyY4nZR62AkCLRIh+YFpRCyqiK2oarGMJS1z/zMn6/KkQgW0oXh8qOEEgGO3HVoVQgXfSp/WjGe6mdvYUZXn6EKIpwMmCyJN+hjQdAOdXPnCupH4kjoOLGn8p8Z9OaS+xwgOoKeuJmLyKIi8KpiNfzbQK3n5YD6zYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vivier.eu; spf=pass smtp.mailfrom=vivier.eu; dkim=pass (2048-bit key) header.d=vivier.eu header.i=laurent@vivier.eu header.b=Ck9Fg8O/; arc=none smtp.client-ip=212.227.17.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vivier.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivier.eu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivier.eu header.i=laurent@vivier.eu header.b="Ck9Fg8O/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivier.eu;
	s=s1-ionos; t=1785080581; x=1785685381; i=laurent@vivier.eu;
	bh=x8Z59e8xyy6tHJFJNMj3PmHwt5BxEra5gsGyWJcrDiU=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=Ck9Fg8O/rdT0Z7ZdMn/8pR6O0fKS6UM+LK6sOyUHxrouZiXWfm/fH4xfXV6foujn
	 yYqzq9H8vB2F6g/o2Ozg0Gy8MJeHwy3qq/UbIBe+iUQvJmmXEh749oukU4YnPyb3P
	 45HlNmg7QmV2GYUukd8gLPL/VmJsWH5jVhqmvg4UZYW+ZT3i9md7aZV887HCj7TZ9
	 LGHuGXI+fSuJa42cNfkUMUNGrDc2bDVEMGl70Net/7VmxoGc2X88YuIVFlWwNBBeV
	 vwHbHWi41L+OUmTRQx2C7pvadQhgSe5MkKcMEr3e95GK1JLvoB/w9RCPyhRHhB4tY
	 AjnfIn/alP1o7kFwfQ==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from client.hidden.invalid by mrelayeu.kundenserver.de (mreue107
 [213.165.67.119]) with ESMTPSA (Nemesis) id 1MSckp-1wQ7J62gFl-00L37H; Sun, 26
 Jul 2026 17:43:01 +0200
Message-ID: <792320f7-8741-4f90-b480-b47347588cdb@vivier.eu>
Date: Sun, 26 Jul 2026 17:43:00 +0200
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 27/31] swim: Remove unused macro definitions
To: Finn Thain <fthain@linux-m68k.org>, Jens Axboe <axboe@kernel.dk>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
 Joshua Thompson <funaho@jurai.org>, linux-block@vger.kernel.org,
 linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org
References: <cover.1784196135.git.fthain@linux-m68k.org>
 <38052482a1b7010beb01c0d96b0849875f5f8e16.1784196135.git.fthain@linux-m68k.org>
Content-Language: fr
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; keydata=
 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
In-Reply-To: <38052482a1b7010beb01c0d96b0849875f5f8e16.1784196135.git.fthain@linux-m68k.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:GhGrodRRs9IngcF6t58wAGbyyVRDyPBX/BkTjMxX4GtYWO/ViMb
 Ghokc09vk+csBlljrJN8cGevhWLAFsPcrdEwy4eGZSNQpDcCvwAQXDFpNcUmXiiIynTO1k+
 j1M5mfXtTgmmzCWeaP8pS/q0HmGj8jxu3LU+4hs3Tk1qj8IU7OhjvffC81VfdCWA3WyUYWX
 7LtZUwGv7d1CpeMieLQnA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:2MaZOBPbZCc=;f14RQxyE3TekY+kZU0jLZkKQ7/1
 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

Le 16/07/2026 =C3=A0 12:02, Finn Thain a =C3=A9crit=C2=A0:
> Also remove the horizontal rule at the end of the macro definitions as
> it doesn't any add value, IMO.
>=20
> Signed-off-by: Finn Thain <fthain@linux-m68k.org>
> ---
>   drivers/block/swim.c | 14 --------------
>   1 file changed, 14 deletions(-)

Reviewed-by: Laurent Vivier <laurent@vivier.eu>

>=20
> diff --git a/drivers/block/swim.c b/drivers/block/swim.c
> index 444c3f31ba48..9661d8f7a5ed 100644
> --- a/drivers/block/swim.c
> +++ b/drivers/block/swim.c
> @@ -130,25 +130,14 @@ struct iwm {
>  =20
>   /* Bits in handshake register */
>  =20
> -#define MARK_BYTE	0x01
> -#define CRC_ZERO	0x02
> -#define RDDATA		0x04
>   #define SENSE		0x08
> -#define MOTEN		0x10
> -#define ERROR		0x20
>   #define DAT2BYTE	0x40
>   #define DAT1BYTE	0x80
>  =20
>   /* bits in setup register */
>  =20
> -#define S_INV_WDATA	0x01
> -#define S_3_5_SELECT	0x02
> -#define S_GCR		0x04
>   #define S_FCLK_DIV2	0x08
> -#define S_ERROR_CORR	0x10
>   #define S_IBM_DRIVE	0x20
> -#define S_GCR_WRITE	0x40
> -#define S_TIMEOUT	0x80
>  =20
>   /* bits in mode register */
>  =20
> @@ -157,12 +146,9 @@ struct iwm {
>   #define ENBL2		0x04
>   #define ACTION		0x08
>   #define WRITE_MODE	0x10
> -#define HEDSEL		0x20
>   #define ISM_SELECT	0x40
>   #define MOTON		0x80
>  =20
> -/*---------------------------------------------------------------------=
=2D------*/
> -
>   enum drive_location {
>   	NO_DRIVE =3D 0,
>   	INTERNAL_DRIVE =3D BIT(1),

