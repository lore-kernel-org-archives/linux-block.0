Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1850F1624DF;
	Sun, 26 Jul 2026 14:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785077504; cv=none; b=nANsq7rDu1lTx0CG5QyFJuwre9EKRJhAjWe7VEku4Z+ZfVZCOe6kmOhZ93WpYvq5oQFHiozojhPiQZp0/NCvy8f4LnZnjUhFCd0xtPgh8GsuBOLFpCQMsTknnoVdOUzBZGeSW2zry53eemJ4J+yMvBHfBNBDlRdvNGEE30NMTu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785077504; c=relaxed/simple;
	bh=oFGX4EiXrHAMsUM+8bW4CzSsip5bl/Ddtk15+8Liru0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PaJloul0UoWvoYWI22fSDFBheOvjNB88zOuHbL5kkcOoJL5RZq79qJoDF4inVZnvhIZZHdpBu7ARgkSI20PTEdKYm/Hi54+osq667B4zZrw7ypCnV4EwwYzlOXhOcE40PPCG1muH3eA6MgKOf0J1xCxLkH/ZhJ6FDANpLvh1VTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vivier.eu; spf=pass smtp.mailfrom=vivier.eu; dkim=pass (2048-bit key) header.d=vivier.eu header.i=laurent@vivier.eu header.b=OTO09Uv9; arc=none smtp.client-ip=217.72.192.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vivier.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivier.eu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivier.eu header.i=laurent@vivier.eu header.b="OTO09Uv9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivier.eu;
	s=s1-ionos; t=1785077500; x=1785682300; i=laurent@vivier.eu;
	bh=AXgy2ReMx/9tbBr9/EJj1s+Pfb9NpNNl+XAEM9qJSko=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=OTO09Uv9y8a5Tb0ISLJncaA/Zntvdq7Bu1WlZrtWVvT417Im177ydCz1g0bzDrgx
	 WYvK8NOsmz2MeexVKeJWaQ01Z9IvkqxkFStmx1g7qp3pG+Vzqvz+jWIIWbnr2GHW8
	 FEXwFfE76tCcB8qFZnMZQjnzEsKD0za7uhK7fJF0Mcysatise06n1eLJKF/udJIwq
	 HT6XKFE3XiUyFgoJkJo84pyISYcZ2G9tuu3tS61kuiSUTjmnyM1hy4tct+LUNbzn3
	 LYj5HBsNYvxSKpu5wHO3xtY9qO74/hyU6O6qZDE4OW3CxzEVKNjT/Pkoi5QefcYmb
	 84f3zSigGJ+OybzZHg==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from client.hidden.invalid by mrelayeu.kundenserver.de (mreue109
 [213.165.67.119]) with ESMTPSA (Nemesis) id 1Md6V3-1xN3pw3qux-00hBKu; Sun, 26
 Jul 2026 16:51:39 +0200
Message-ID: <d13da9c3-c705-4611-8735-cb8226165cbb@vivier.eu>
Date: Sun, 26 Jul 2026 16:51:39 +0200
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 22/31] swim: Remove pointless mode0 register write
To: Finn Thain <fthain@linux-m68k.org>, Jens Axboe <axboe@kernel.dk>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
 Joshua Thompson <funaho@jurai.org>, linux-block@vger.kernel.org,
 linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org
References: <cover.1784196135.git.fthain@linux-m68k.org>
 <328f4893de7dbee26841757bd32eda7d7f3793d7.1784196135.git.fthain@linux-m68k.org>
Content-Language: fr
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; keydata=
 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
In-Reply-To: <328f4893de7dbee26841757bd32eda7d7f3793d7.1784196135.git.fthain@linux-m68k.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:wdNA8cA+tS5UfU82EdT0bzFhNwggTEam/T8XHvamMpIVoG3f3Tz
 8qAIiwfG/ACsMavo3lPxS2ILEWeDEblZvy/hxwLvOG7KKKotzOTwwBbM32OI20PhlR3P83G
 qbQmcqKXtZ1OJ6drEupE3imkLmzRnea0ntaDuqvaEyH3BGJhw9+RvccIRcZIAavRDgypfS9
 Gpw2VqXNdDJUy3eDqv+/A==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:fxgP8BKXw+4=;Cmmc5bS+uiuMKWA5OiMOIUp/5Rb
 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

Le 16/07/2026 =C3=A0 12:02, Finn Thain a =C3=A9crit=C2=A0:
> This write has no effect so remove it. (If side =3D=3D 0 then no mode bi=
t gets
> cleared. If side =3D=3D 1 then mode bit 0 gets cleared but that's pointl=
ess
> because that bit is already clear here.)
>=20
> Signed-off-by: Finn Thain <fthain@linux-m68k.org>
> ---
>   drivers/block/swim.c | 1 -
>   1 file changed, 1 deletion(-)

Reviewed-by: Laurent Vivier <laurent@vivier.eu>

>=20
> diff --git a/drivers/block/swim.c b/drivers/block/swim.c
> index 44fe7a79059c..0bab7ed3daa8 100644
> --- a/drivers/block/swim.c
> +++ b/drivers/block/swim.c
> @@ -467,7 +467,6 @@ static inline int swim_read_sector(struct floppy_sta=
te *fs,
>  =20
>   	swim_track(fs, track);
>   	swim_head(base, side);
> -	swim_write(base, mode0, side);
>  =20
>   	local_irq_save(flags);
>   	for (i =3D 0; i < 36; i++) {

