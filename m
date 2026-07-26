Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36A5923393B;
	Sun, 26 Jul 2026 15:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785080418; cv=none; b=WJ1aMWDy8iFI10Ux1OkbEBq9ROxp6oAL2XnwDvtceWROfDgGxEj0aps+SQY9r1a7zSrMVw+ZsVD+xKdtGmTlEXbAfez3/76R92pIkIYcD1NEkA4yfRsS7NxaIl+oR7Uj/F+2DzqQpIs6zSw4XQGYp7lYWEVK2YuIunZoxVKDDeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785080418; c=relaxed/simple;
	bh=nlxFD9J6ZxpE5+kdT5Tvk++ROqbqo69ohne+Ze40GMg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eXTxgUrmzXud9lJGwTROVt67sV8WM8kc/7Fjvn9qyKu4GcuxCo4XLRaTy8OOwUSGfPb+00x5d5Jsgr9FmbXcIu7LtiYK2HMAx/cjEGT1p6f6EnHp5qqwVMOrxXwK1jBtW5VjzBsowHlU8E3sdlY/dfZwKq1jvCAZTrVYU6BmQzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vivier.eu; spf=pass smtp.mailfrom=vivier.eu; dkim=pass (2048-bit key) header.d=vivier.eu header.i=laurent@vivier.eu header.b=oqdeXDxO; arc=none smtp.client-ip=212.227.17.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vivier.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivier.eu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivier.eu header.i=laurent@vivier.eu header.b="oqdeXDxO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivier.eu;
	s=s1-ionos; t=1785080408; x=1785685208; i=laurent@vivier.eu;
	bh=Y/hIwmQzXHzMWn6hmOjnS81pvPeIUVhWs293jDMbAbg=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=oqdeXDxOWkkwsEJqOyVplx53E8apGY2znRprZ/jhX274pG0bkTfTQeVDZhHsFWEq
	 BOrUyMG1h+ULiSR18e3zDOgWmRiQX9VYt8iYQjCg6r3QzRd5E0DHGSIgR2flIKJxC
	 Mz3sgtGxoiF3hPfvlvfvxelXQNEZZlxfuu8/w3bJv0VhxPNPdw5SPAkOdUdPS+gmv
	 Ahfvt/1TKXFbOxp1pEgmKpnNIqqxpt9ifieLSsx0hqhWBxJVs3lMwABOLbOg+KPSY
	 MRKo5e+5gxThDmgq3C8MYry57KVZAUWe6+I5frFeCSfH9DsMzZPqboYpBMDouL2rB
	 6v4RBwWVGwu1JqPYbg==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from client.hidden.invalid by mrelayeu.kundenserver.de (mreue109
 [213.165.67.119]) with ESMTPSA (Nemesis) id 1MHX3X-1wjsEL3FGj-00D7ts; Sun, 26
 Jul 2026 17:40:08 +0200
Message-ID: <2854883a-9200-4657-9a4a-620248c1fa19@vivier.eu>
Date: Sun, 26 Jul 2026 17:40:08 +0200
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 25/31] swim: Move swd initialization
To: Finn Thain <fthain@linux-m68k.org>, Jens Axboe <axboe@kernel.dk>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
 Joshua Thompson <funaho@jurai.org>, linux-block@vger.kernel.org,
 linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org
References: <cover.1784196135.git.fthain@linux-m68k.org>
 <2cc2eea25a2e1a444d037c3629fd8c144adb94f4.1784196135.git.fthain@linux-m68k.org>
Content-Language: fr
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; keydata=
 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
In-Reply-To: <2cc2eea25a2e1a444d037c3629fd8c144adb94f4.1784196135.git.fthain@linux-m68k.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:15xGKtkzdHGT9OilAaFi7TjLuouTBHEwV+nbxcqnqjr7js0OIml
 1UxkA4kUo8yHPGZ4KhGK+3SKb6rl+UXjQj2lf7WwFJ/wHs9jyi/sHS6l8e5kmbEuUxpLtPy
 J0zng1+3FvZfv2E7TFcV1y/XN+qHAPc7S5bDzd6zlB1s+y1GcJ9xW7zXKDry+/l7wmoW/4U
 XRT7b84Fj8BKL4pp8uTbA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Q4ynMp2cMng=;3kQgg7WbyGa29dcBVBxmXC2MaJh
 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

Le 16/07/2026 =C3=A0 12:02, Finn Thain a =C3=A9crit=C2=A0:
> For better readability, initialize the swd backpointer along with the
> other floppy_state struct members. No functional change.
>=20
> Signed-off-by: Finn Thain <fthain@linux-m68k.org>
> ---
>   drivers/block/swim.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)

Reviewed-by: Laurent Vivier <laurent@vivier.eu>

>=20
> diff --git a/drivers/block/swim.c b/drivers/block/swim.c
> index 4679f554fec5..c41d56ab6c04 100644
> --- a/drivers/block/swim.c
> +++ b/drivers/block/swim.c
> @@ -760,6 +760,7 @@ static int swim_add_floppy(struct swim_priv *swd, en=
um drive_location location)
>   	struct floppy_state *fs =3D &swd->unit[swd->floppy_count];
>   	struct swim __iomem *base =3D swd->base;
>  =20
> +	fs->swd =3D swd;
>   	fs->location =3D location;
>  =20
>   	swim_motor(base, OFF);
> @@ -855,8 +856,6 @@ static int swim_floppy_init(struct platform_device *=
pdev)
>   			err =3D PTR_ERR(swd->unit[drive].disk);
>   			goto exit_put_disks;
>   		}
> -
> -		swd->unit[drive].swd =3D swd;
>   	}
>  =20
>   	for (drive =3D 0; drive < swd->floppy_count; drive++) {

