Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C93E3169AD2;
	Sun, 26 Jul 2026 15:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785080781; cv=none; b=cv+0Y5QuhWToy8NTVxwBgPogXPAykNFq4qbhIJHSghY+En/csyATxQF68lAPCLdgYWBChyQ6OI2SQCz7jnrIENEpjLKH2SgQL1ULLP1zDFB6676ByF1wOuao12aDwOLG0Z0VH3oLtLoPbhz3NUEaDrK706PCSgkbLbS1N4huVvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785080781; c=relaxed/simple;
	bh=n7dhn7qE9jVag40HDcUTId5l7kGYRnvWaN24WZK4TzE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AJapQo86dtON7PfwdXhI/ouh6TzW2nKPWZiJYEh4tKDA46rePPcop2cAOZwYh7KMbz0NBMuCfzpTnWez4PeE7CRy+byCaVRKIRuoQYPoFYcJtz5lKmnn/X05ztQF7L3D+gc1fsvInVbgskVc/+uxveNQpKEu0PB5kdTLop5pbqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vivier.eu; spf=pass smtp.mailfrom=vivier.eu; dkim=pass (2048-bit key) header.d=vivier.eu header.i=laurent@vivier.eu header.b=Q4sDxZqi; arc=none smtp.client-ip=212.227.17.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vivier.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivier.eu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivier.eu header.i=laurent@vivier.eu header.b="Q4sDxZqi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivier.eu;
	s=s1-ionos; t=1785080772; x=1785685572; i=laurent@vivier.eu;
	bh=l1cJzNUZwpAXkY8+XZ7Vl98OAShBLpLlSidTOR8+wVU=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=Q4sDxZqiPGFX30AYu1cZFlrQgb4UYz3S8Igv3kW5ES6ZxXFxGQs68DFV2sPEGwhn
	 /Msna8jTV7gpgeaYpoBqfJE3oNG4ScQBl1cAkUQtHQ46jyuNtKWd+0/UTK64S+5pC
	 6apZO4102iCRpEw8f4ThvOmFDWfn31IvEnmIvBEaE5IoWCYo6LNiTDBhkPgWc6ltK
	 cM9d58PhDjIVM4byLYvZCYqmDcJQMWp0xLLowAS5dIuhUB30F7QNGujprBGNsTVZN
	 La4FLh8+7BvZDZ7+VDM97BB2rTnhbbZ5oy4HqqMN4avcBPyEMgChqWiGpzFLfuvCx
	 NdtAZTgX/kWeYzSttg==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from client.hidden.invalid by mrelayeu.kundenserver.de (mreue108
 [213.165.67.119]) with ESMTPSA (Nemesis) id 1MlwFp-1xEEro3N1X-00aDni; Sun, 26
 Jul 2026 17:46:11 +0200
Message-ID: <0e80449f-e315-42e7-b5a0-2cb2eb313256@vivier.eu>
Date: Sun, 26 Jul 2026 17:46:11 +0200
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 29/31] swim: Define macros for constants
To: Finn Thain <fthain@linux-m68k.org>, Jens Axboe <axboe@kernel.dk>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
 Joshua Thompson <funaho@jurai.org>, linux-block@vger.kernel.org,
 linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org
References: <cover.1784196135.git.fthain@linux-m68k.org>
 <960a50d4c5b3b23f7198f4a3dae03bdeddbf098a.1784196135.git.fthain@linux-m68k.org>
Content-Language: fr
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; keydata=
 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
In-Reply-To: <960a50d4c5b3b23f7198f4a3dae03bdeddbf098a.1784196135.git.fthain@linux-m68k.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:54ip6HaFgvuqlUOefZYbw3aeymkQDM5nnO76ohlg2xzrv/e5eDy
 RmmCvcQVEmmlUEZ9lgn5jamaZhkHJWugKo+rwjmobgXhBpXmG9b/5A/xcGGyIRgJkyhCQLR
 mS2ZRPC6urndPWBNrSRJ8rr+fvSApiwH+lCwVxdP1GDaTPMxnnheYqQR7A+6IswAu/P1u9f
 8t6NU49ujyniqpVMXmIkw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:J0xO8Ur0Rq8=;ubfuoH/VRGFLZhuABi6DRQDfqVz
 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

Le 16/07/2026 =C3=A0 12:02, Finn Thain a =C3=A9crit=C2=A0:
> Define a SEL_MASK macro to name the anonymous constant. Define STEPPING
> rather than re-use STEP because the latter is a command bit macro (see a=
lso
> GCR_MODE vs. SETGCR). No functional change, just better readability.
>=20
> Signed-off-by: Finn Thain <fthain@linux-m68k.org>
> ---
>   drivers/block/swim.c | 6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)

Reviewed-by: Laurent Vivier <laurent@vivier.eu>

>=20
> diff --git a/drivers/block/swim.c b/drivers/block/swim.c
> index 406792952e7f..460f74c19cfd 100644
> --- a/drivers/block/swim.c
> +++ b/drivers/block/swim.c
> @@ -112,9 +112,11 @@ struct iwm {
>   #define LSTRB		0x0F8
>  =20
>   #define CA_MASK		0x0F7
> +#define SEL_MASK	0x100
>  =20
>   /* Select values for swim_select and swim_readbit */
>  =20
> +#define STEPPING	0x0F1
>   #define READ_DATA_0	0x0F4
>   #define ONEMEG_DRIVE	0x0F5
>   #define SINGLE_SIDED	0x0F6
> @@ -271,7 +273,7 @@ static inline void swim_select(struct swim __iomem *=
base, int sel)
>   {
>   	swim_write(base, phase, RELAX);
>  =20
> -	via1_set_head(sel & 0x100);
> +	via1_set_head(sel & SEL_MASK);
>  =20
>   	swim_write(base, phase, sel & CA_MASK);
>   }
> @@ -369,7 +371,7 @@ static int swim_step(struct swim __iomem *base)
>   {
>   	swim_action(base, STEP);
>   	udelay(150);
> -	return swim_readbit_timeout_atomic(base, STEP, false, 20 * 1000);
> +	return swim_readbit_timeout_atomic(base, STEPPING, false, 20 * 1000);
>   }
>  =20
>   static int swim_track00(struct swim __iomem *base)

