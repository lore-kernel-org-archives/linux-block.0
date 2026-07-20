Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B2112FD69E;
	Mon, 20 Jul 2026 19:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784575304; cv=none; b=H0SOn7xUbgNIthr2wxYyayH27pqltGUVCMq1f6MSQ2DUR5vC0zaHNY7lrRMbNYxwqVsnX3K17S698q+b/3bgpZYYmVJACz6dVrzxuqKnWFM1U2nMmFmLGWGAzWwaC4ZdBAkNMHJpyvCVAlzLUAshBaES24+xJ0JoRGXXu/c2lVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784575304; c=relaxed/simple;
	bh=xE4aois9z1T4IQTX19UuPHI75EPmqUCBI01iJ5y1TfM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CmFiHAbSfLV53VGWEaE+TVllgXAvywZDwwTT45OkKXAp7XW34fUEh03NgDWCBc5/FMUHNbABUOY1jb1rQ4LhFpXUimKfcoRvIb5UdxZZSh6jGQYU1nuPixsdJ+bi1uDaX8OxLYVmLuP2eHykYVtklUNlpIEo98r45C0ZtSxFJ8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vivier.eu; spf=pass smtp.mailfrom=vivier.eu; dkim=pass (2048-bit key) header.d=vivier.eu header.i=laurent@vivier.eu header.b=nbzB/eh8; arc=none smtp.client-ip=217.72.192.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vivier.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivier.eu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivier.eu header.i=laurent@vivier.eu header.b="nbzB/eh8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivier.eu;
	s=s1-ionos; t=1784575292; x=1785180092; i=laurent@vivier.eu;
	bh=Zm3oyJ2nSHaeGNz+ov9Jx2hMq+/3tg62bEiWhwe2oIA=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=nbzB/eh8ZYd9VzhWTF1NhWPk63ctxbdaIVTRwTnRgSJmbn8bOryYuqupkr9gELu6
	 IRLnoTQWGqsN1EVTpTRLdMKMbQhobyVOI4FcSXFCKJixsibldGNwiOhJx3y/t02Oz
	 PmEHuEsKYyh7g240Q5lSImln08Tkc8Gb35R+mXbGoMxohunZKRyStrnODwn/Nnhvd
	 Jz/spGjni0Sk7EhWq3QwWQ2Kb77G3GKD1ry2gikf4MJAq3aoW5D65jYD8dRkGG+3d
	 61n2jW+czHvUawVj2Fqs64TWfIiT0wLopDZKpibSDdlo9nD6Q65DHX7AgkFE+bR2s
	 Sz5QBvvQp3aBapGMsQ==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from client.hidden.invalid by mrelayeu.kundenserver.de (mreue108
 [213.165.67.119]) with ESMTPSA (Nemesis) id 1MfpKZ-1xEtdt3HA1-00p0po; Mon, 20
 Jul 2026 21:21:32 +0200
Message-ID: <71b645bd-2453-4012-b30e-d55a1cce4ced@vivier.eu>
Date: Mon, 20 Jul 2026 21:21:32 +0200
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 12/31] swim: Simplify return value initialization
To: Finn Thain <fthain@linux-m68k.org>, Jens Axboe <axboe@kernel.dk>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
 Joshua Thompson <funaho@jurai.org>, linux-block@vger.kernel.org,
 linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org
References: <cover.1784196135.git.fthain@linux-m68k.org>
 <c79e0ce999ba5e71583960f75189c8f7ce6b3fc8.1784196135.git.fthain@linux-m68k.org>
Content-Language: fr
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; keydata=
 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
In-Reply-To: <c79e0ce999ba5e71583960f75189c8f7ce6b3fc8.1784196135.git.fthain@linux-m68k.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:mwyRhh11/T8k7IYuDEhFj1qxbIWqi7xxeBeMNkcvnkE2ZRaLHzK
 JvYClRPbX9DDaoYFzsyPLl3ysv5xo2mDSDyxIbs7jTYOKShrGEvRinYWMKhheqatLLw6LXj
 W4K14QEFawwoN6UqYTJYeGsTmpDLfPJIqhRXP5b8Gl/ncycnLlxKHQvPaVIXDv1jzy5+VnB
 f7hAXXHNOUBHFynacHePg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Y2R2R8odIhA=;uYDZjEbetCCHO/5a4x4SOQIR0Nj
 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

Le 16/07/2026 =C3=A0 12:02, Finn Thain a =C3=A9crit=C2=A0:
> Initialize the error result once only. Update the result only after a
> successful read.
>=20
> Signed-off-by: Finn Thain <fthain@linux-m68k.org>
> ---
>   drivers/block/swim_asm.S | 11 +++--------
>   1 file changed, 3 insertions(+), 8 deletions(-)

Reviewed-by: Laurent Vivier <laurent@vivier.eu>

>=20
> diff --git a/drivers/block/swim_asm.S b/drivers/block/swim_asm.S
> index 208622ac4aeb..31fc63b074dc 100644
> --- a/drivers/block/swim_asm.S
> +++ b/drivers/block/swim_asm.S
> @@ -47,6 +47,7 @@ swim_read_sector_header:
>   	link	%a6, #0
>   	moveml	%d1-%d5/%a0-%a4,%sp@-
>   	movel	%a6@(0x0c), %a4
> +	moveq	#-1, %d0
>   	bsr	mfm_read_addrmark
>   	moveml	%sp@+, %d1-%d5/%a0-%a4
>   	unlk	%a6
> @@ -61,7 +62,6 @@ mfm_read_addrmark:
>   	movel	%a6@(0x08), %a3
>   	lea	%a3@(read_handshake), %a2
>   	lea	%a3@(read_mark), %a3
> -	moveq	#-1, %d0
>   	movew	#seek_time, %d2
>  =20
>   wait_header_init:
> @@ -137,10 +137,7 @@ crc1:	tstb	%a2@
>   	tstb	%a3@(read_error - read_mark)
>  =20
>   	moveq	#0, %d0
> -	moveb	#0x18, %a3@(write_mode0 - read_mark)
> -	rts
>   signal_nonyb:
> -	moveq	#-1, %d0
>   	moveb	#0x18, %a3@(write_mode0 - read_mark)
>   	rts
>  =20
> @@ -149,6 +146,7 @@ swim_read_sector_data:
>   	link	%a6, #0
>   	moveml	%d1-%d5/%a0-%a5,%sp@-
>   	movel	%a6@(0x0c), %a4
> +	moveq	#-1, %d0
>   	bsr	mfm_read_data
>   	moveml	%sp@+, %d1-%d5/%a0-%a5
>   	unlk	%a6
> @@ -228,15 +226,12 @@ data_crc1:
>  =20
>   	tstb	%a3@(read_error - read_mark)
>  =20
> -	moveb	#0x18, %a3@(write_mode0 - read_mark)
> -
>   	/* return number of bytes read */
>  =20
>   	movel	#sector_size, %d0
>   	addw	#1, %d4
>   	subl	%d4, %d0
> -	rts
> +
>   data_exit:
>   	moveb	#0x18, %a3@(write_mode0 - read_mark)
> -	moveq	#-1, %d0
>   	rts

