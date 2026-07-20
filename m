Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C942F417D97;
	Mon, 20 Jul 2026 13:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784554050; cv=none; b=ShTfvGbk6xti0B2IRjrSTpiaYOWzIg3yTzZojNy5zdUivnrbIT03cnsDIA3MfdVX7TyfLxuFL0GE+15di/kKcKhs27mVPPArto8WI9Io81vH31tIFjwjQO4TzbF+s4/GIFhuAOBS/Cxhdkcr+Kmd7ggDv3uay71Mx7jwOfFU2DU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784554050; c=relaxed/simple;
	bh=6/IJk6o+sFQEPatxzUwWgfqMGX5bSs59exjnoLjfNWc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=U8dlh+pn70DckfYTs7LLZIjliiodlukgoBPffEt5H8vLy0V4PVDr2MC2h4xZttQgMW09FxO2jcHrkdDKnH/ENSN7H7dECwIhrDvOpgrc+LoXZ/fLgf7Bg5UMFcgImkSq4FmIJSju2tMQXU3NX+Rp2cIZIs4Nn+1No9WN4LngAuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vivier.eu; spf=pass smtp.mailfrom=vivier.eu; dkim=pass (2048-bit key) header.d=vivier.eu header.i=laurent@vivier.eu header.b=kRM5tRuw; arc=none smtp.client-ip=212.227.17.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vivier.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivier.eu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivier.eu header.i=laurent@vivier.eu header.b="kRM5tRuw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivier.eu;
	s=s1-ionos; t=1784554040; x=1785158840; i=laurent@vivier.eu;
	bh=lV89NhG2wez2vmHbDGAM+dTKkeg4z0jmAIyATRq2Pss=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=kRM5tRuwcEuhm128tTfbzeEoqvNPFp5KR2n7mjUqMzsf8f+4W++cK30btMZvugvW
	 xoqu5D064GI9cGD28gJ2Pykrf0zFYnY5vhRSWxtlU1ZepretCCO7wBVMExGJqImv2
	 pG9XyxoFrlLCWS+hL6gi+Sy7/oW1NCqXI2FUlYH75II5cfySdbnJbn3JPZfC0omGt
	 vNj24JlDcRJitM4R7LS4NIyQLc2XuqBsuCoRROchBVAS7ZW3dcnP087DQ0jIJPvmf
	 orGLFW3BaiH6XlboPuuPkCeJW14Wvjk4xuP3qpYXGdZb1AZm+Tb6lC4aGbPBhAJF8
	 ve9t5yPdWoUFoq43eg==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from client.hidden.invalid by mrelayeu.kundenserver.de (mreue108
 [213.165.67.119]) with ESMTPSA (Nemesis) id 1Mwwm5-1wwlIR3DVz-017EET; Mon, 20
 Jul 2026 15:27:20 +0200
Message-ID: <77c8cdef-4d20-4dd9-8619-9bf514acc62a@vivier.eu>
Date: Mon, 20 Jul 2026 15:27:20 +0200
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/31] swim: Select appropriate drive once only
To: Finn Thain <fthain@linux-m68k.org>, Jens Axboe <axboe@kernel.dk>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
 Joshua Thompson <funaho@jurai.org>, linux-block@vger.kernel.org,
 linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org
References: <cover.1784196135.git.fthain@linux-m68k.org>
 <de25705b252b0a8a3f38e0ac3e21721b80f3c7fd.1784196135.git.fthain@linux-m68k.org>
Content-Language: fr
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; keydata=
 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
In-Reply-To: <de25705b252b0a8a3f38e0ac3e21721b80f3c7fd.1784196135.git.fthain@linux-m68k.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:RHf9ncd6zZ4mj2jl+f3y5yjFQC1al3LrgJsmbWBQuGP8Wi8OO/3
 RAnw0S4p0WaBcpg7UDTStOglHm9WtSQCMwG/E92/rsv4NkneLdxrs3oh7QwLMA6IOcbAG4F
 kEseznaj7eaoEESnTFLDHNA4Es8ggQ60QgvGDhljyR9wkzKKnkZ97gAGTmc8RGCRpzncs5a
 1mY0s45DoKBnUexif0T+Q==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:+YGVUNcGb68=;m0BvxPuOShNqwxhWTMAe30iigXP
 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
 =

Le 16/07/2026 =C3=A0 12:02, Finn Thain a =C3=A9crit=C2=A0:
> Before turning off the spindle motor, call swim_drive() to select the
> appropriate drive. Remove the swim_drive() call from swim_add_floppy()
> because it was already called by swim_floppy_init().
>=20
> Fixes: 8852ecd97488 ("m68k: mac - Add SWIM floppy support")
> Signed-off-by: Finn Thain <fthain@linux-m68k.org>
> ---
>   drivers/block/swim.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)


Reviewed-by: Laurent Vivier <laurent@vivier.eu>

>=20
> diff --git a/drivers/block/swim.c b/drivers/block/swim.c
> index b61e92d0e3e9..2c52a210f4a6 100644
> --- a/drivers/block/swim.c
> +++ b/drivers/block/swim.c
> @@ -679,8 +679,10 @@ static void floppy_release(struct gendisk *disk)
>   	else if (fs->ref_count > 0)
>   		--fs->ref_count;
>  =20
> -	if (fs->ref_count =3D=3D 0)
> +	if (fs->ref_count =3D=3D 0) {
> +		swim_drive(base, fs->location);
>   		swim_motor(base, OFF);
> +	}
>   	mutex_unlock(&swim_mutex);
>   }
>  =20
> @@ -752,8 +754,6 @@ static int swim_add_floppy(struct swim_priv *swd, en=
um drive_location location)
>  =20
>   	fs->location =3D location;
>  =20
> -	swim_drive(base, location);
> -
>   	swim_motor(base, OFF);
>  =20
>   	fs->type =3D HD_MEDIA;

