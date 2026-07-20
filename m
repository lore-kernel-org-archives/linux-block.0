Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F11412F39C7;
	Mon, 20 Jul 2026 19:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784574883; cv=none; b=I56Uy3TpX1oMS/dg9syy9wBh0uQLeLhz7UhKoqEtEv85+z1HsELXMLQFhlrMbI3b4h1ZydeAwyDKq3P/Ux4aCs6wS6LP3LN7MIilpXzD4kbvd92PXNSfw8ltSnJgG2mMhDIAtjclBErUYfi9dzgZKGoYzyJdmahbkQkFmEDs1ao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784574883; c=relaxed/simple;
	bh=wurvg1Bcb/LpF5nN4KmOFGProuWYaepeVVI2s4Lsw98=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QMOa7jbGmP59CGS7vazekRD266Ds2LvFzUUqutq58IO2fegsKNYwxDCfVlhs5TCv8kCdn+BzhdT4Z4CxU8vXEnB9QFcOxfTay9cy4EBnPGrk7g5TFGGsZlP00UTZtF2lLUAkk6TfTfQg6J5jsvJPE9xIHR+Q7Nj1/UJd4ESkntI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vivier.eu; spf=pass smtp.mailfrom=vivier.eu; dkim=pass (2048-bit key) header.d=vivier.eu header.i=laurent@vivier.eu header.b=oNvbRtrJ; arc=none smtp.client-ip=212.227.17.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vivier.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivier.eu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivier.eu header.i=laurent@vivier.eu header.b="oNvbRtrJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivier.eu;
	s=s1-ionos; t=1784574878; x=1785179678; i=laurent@vivier.eu;
	bh=4/AVLrjqDmBP1w6ua6BjwMs7px6WqRddV/iRtSVac7A=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=oNvbRtrJZhprH562R78zRyyoKwQUbAeTiRkT3VEfYLGHnYcXo7oyZOxtjD7OPfQU
	 cz9jsNkVd+VvJVvp9pInGQ61noC1ww8O4+guhvFQcTc/50nTm0EaWJNly3wZcRkn2
	 L4KubMEpMYXSDbiqztS7m7ZYPr+TAwPKcZvpa9GeUH/HJIRuDxe5DTAz52uotkF/1
	 neUs+z7S7BLDXoSeL0NISyf6OXAI+ve1qAatYsjrZNIZWygGJS5kdodGqJwjUv/Qm
	 x8LDNU7V3+HxPLZ+51ql2jHRSgX/Md6b+aiEDK8YGOEIt4XT8ArBkvs0kXP4Zrrzd
	 U2bsOgwXpQEV2WQMhg==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from client.hidden.invalid by mrelayeu.kundenserver.de (mreue107
 [213.165.67.119]) with ESMTPSA (Nemesis) id 1M6EOc-1wfHja13Ci-00H31t; Mon, 20
 Jul 2026 21:14:38 +0200
Message-ID: <0bb1758f-e8be-476f-af2d-946d65e21057@vivier.eu>
Date: Mon, 20 Jul 2026 21:14:37 +0200
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/31] swim: Add track zero recalibration delay
To: Finn Thain <fthain@linux-m68k.org>, Jens Axboe <axboe@kernel.dk>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
 Joshua Thompson <funaho@jurai.org>, linux-block@vger.kernel.org,
 linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org
References: <cover.1784196135.git.fthain@linux-m68k.org>
 <95b9285e4d2b77b010162e2c83e6d4f7917c4d85.1784196135.git.fthain@linux-m68k.org>
Content-Language: fr
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; keydata=
 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
In-Reply-To: <95b9285e4d2b77b010162e2c83e6d4f7917c4d85.1784196135.git.fthain@linux-m68k.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:S7ZIWU6QlE3gjHw+vsqrJMRdGDRCPCZ1n2CySoZClcrxffv368L
 XucHp4c/xdJa2K1CiH9UtEwHGFzzRfClAnBxRsGdNVHi3G2gtEGP7OpcBwd1ouoh/y4CUlO
 wpNal+Ttt9chRaS2NX7dEot3nLRLfdj3StDzqkeEKtS620LzviTLQ6i5q9/+CBv0pLt4AzA
 fb5r4r08UO7tMaPb5WwEw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:bT6BLy8dQeM=;TxFn9xjfHsN5Ys/9E8wQtLMNyQh
 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
 pPpd++ypeZHyInj+DcLdqwIg7jHIU=

Le 16/07/2026 =C3=A0 12:02, Finn Thain a =C3=A9crit=C2=A0:
> The UPD72070 spec indicates that the track zero sensor can take 3 ms
> to stabilize following a STEP command so add a call to msleep().
> Remove the duplicate swim_readbit() call as there's no need for that
> once the sensor signal has stabilized.
>=20
> Fixes: 8852ecd97488 ("m68k: mac - Add SWIM floppy support")
> Signed-off-by: Finn Thain <fthain@linux-m68k.org>
> ---
>   drivers/block/swim.c | 9 ++++-----
>   1 file changed, 4 insertions(+), 5 deletions(-)
>=20

Reviewed-by: Laurent Vivier <laurent@vivier.eu>

> diff --git a/drivers/block/swim.c b/drivers/block/swim.c
> index 76f6cfa68432..9755b86d4dd4 100644
> --- a/drivers/block/swim.c
> +++ b/drivers/block/swim.c
> @@ -402,16 +402,15 @@ static inline int swim_track00(struct swim __iomem=
 *base)
>   	for (try =3D 0; try < 100; try++) {
>  =20
>   		swim_select(base, RELAX);
> +		msleep(3);
> +
>   		if (swim_readbit(base, TRACK_ZERO))
> -			break;
> +			return 0;
>  =20
>   		if (swim_step(base))
> -			return -1;
> +			break;
>   	}
>  =20
> -	if (swim_readbit(base, TRACK_ZERO))
> -		return 0;
> -
>   	pr_err("swim: track zero recalibration failed\n");
>   	return -1;
>   }

