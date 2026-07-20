Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 816FF38F255;
	Mon, 20 Jul 2026 19:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784576258; cv=none; b=rHSb/rLVoYAG1a7si0iQJIh45y5w5gCbv7ZMitzDiRzA1boGcMRJ/guOl8BTL8s9rZDzHSemT0ps62F1vpYw62+/3PgwRgELLfE0Zjx1ot6TnXlOYtgZ44TYGnD1bOcWJO4dHpg71umexDY7CAwRLBaG2SlDTvJLqBnT61bIaKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784576258; c=relaxed/simple;
	bh=j82a63OZKUwW0IwfSOSlydAh5UqThl5+gdLHr1RG5+0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NBfneIh7suZ4WSQXbSywyWOUnG3wyqfvrEm4FpXNmNWb8jEPYPWHVX38o08cEvzUx0PIIu9LW+VWRsSGUAV0645CgbNlmKSSdiA2aHav/oFhHwlc5wGT+Ok+FRn1M+Xj+VvEesY0zFgWWhiRZOII8yq9z7uN/VGKXYLf1KxyOgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vivier.eu; spf=pass smtp.mailfrom=vivier.eu; dkim=pass (2048-bit key) header.d=vivier.eu header.i=laurent@vivier.eu header.b=EAdPVG9I; arc=none smtp.client-ip=212.227.17.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vivier.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivier.eu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivier.eu header.i=laurent@vivier.eu header.b="EAdPVG9I"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivier.eu;
	s=s1-ionos; t=1784576247; x=1785181047; i=laurent@vivier.eu;
	bh=NY2lgDLpopFZBzjdYsSitgF3RpBAIVBgiqkZsGbhwwU=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=EAdPVG9IyZdqXRfLguyjVzjBTH5/konB6ewp2KpSoKIMcua6t5dFSm5yV22OknYk
	 aA1yyfIhTVpnIGZMA97tvvFG+Xv67Wv4VKQQ8UnNH118UVaYKOrbRaUzVfUAnLyvU
	 D4VqvrxBti6YmPB2MHJSZAsUDz/OjVZzfxMl0J1R7LzU5WwN7NLCkgMGZeATfbdA4
	 oTKAbz6Bst3tJm/olWi0QzJ8aHjxH2RtFr30A/aZ4iCB+UMez6QDibbpIEDpXqd+y
	 M4lOR322wKq8v9/X2torxnvMkZwwNhJInN9OimeJ2v5gAhp46luYGoyQi4RUYXyY0
	 6cGvq3DNwMYR74B/Hg==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from client.hidden.invalid by mrelayeu.kundenserver.de (mreue109
 [213.165.67.119]) with ESMTPSA (Nemesis) id 1M1HmG-1wj8ur3Jec-005dbe; Mon, 20
 Jul 2026 21:37:27 +0200
Message-ID: <c725beff-b1ad-4c64-b39d-6e69bb205dc2@vivier.eu>
Date: Mon, 20 Jul 2026 21:37:27 +0200
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 13/31] swim: Check for CRC errors
To: Finn Thain <fthain@linux-m68k.org>, Jens Axboe <axboe@kernel.dk>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
 Joshua Thompson <funaho@jurai.org>, linux-block@vger.kernel.org,
 linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org
References: <cover.1784196135.git.fthain@linux-m68k.org>
 <c680a69ca18822f0f27dbba0f9a22949431dcd08.1784196135.git.fthain@linux-m68k.org>
Content-Language: fr
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; keydata=
 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
In-Reply-To: <c680a69ca18822f0f27dbba0f9a22949431dcd08.1784196135.git.fthain@linux-m68k.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:UjQc7hz4Qynr7CBiD/J3kSqQsFqxI45trNRlCp5Q0WVawBPq4I1
 d6vPlhhyDRQGM9s/x49jugFBvPtN8hco/6pXFaBt/Qx74Po6NhSXNCGEj+sIwd6n6gFFg71
 QB+6FHjR7N8JMZ9L6tFL5v+U0V634cTuzGqxWHPx89Zl56LTj06143XFNIBPff7TKvc/31N
 UkayND6VqWFClkU9yMbmw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:/p90Rv2MKDY=;jNdebe+ZQMkb/KlcCXk2gKaYTsR
 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
 T9Tm3VL1dyRpj5iPQBtziPXv47Y5A=

Le 16/07/2026 =C3=A0 12:02, Finn Thain a =C3=A9crit=C2=A0:
> After reading either the sector header or sector data, examine that flag
> in the handshake register which holds the result of the CRC calculation.
> CRC validation has to take place with the last byte still in the FIFO.
> This flag can't be checked by the caller because by then all bytes will
> have been retrieved from the FIFO. Return an error code when appropriate=
.
>=20
> Fixes: 8852ecd97488 ("m68k: mac - Add SWIM floppy support")
> Signed-off-by: Finn Thain <fthain@linux-m68k.org>
> ---
>   drivers/block/swim_asm.S | 16 ++++++++++++----
>   1 file changed, 12 insertions(+), 4 deletions(-)

Reviewed-by: Laurent Vivier <laurent@vivier.eu>

>=20
> diff --git a/drivers/block/swim_asm.S b/drivers/block/swim_asm.S
> index 31fc63b074dc..f40e19e48021 100644
> --- a/drivers/block/swim_asm.S
> +++ b/drivers/block/swim_asm.S
> @@ -42,6 +42,8 @@
>   	.equ	max_retry, 40
>   	.equ	sector_size, 512
>  =20
> +	.equ	.Lhr_crc_error,		0x02
> +
>   	.global swim_read_sector_header
>   swim_read_sector_header:
>   	link	%a6, #0
> @@ -128,12 +130,15 @@ crc0:	tstb	%a2@
>  =20
>   	moveq	#max_retry, %d2
>  =20
> -crc1:	tstb	%a2@
> +crc1:	moveb	%a2@, %d5
>   	dbmi	%d2, crc1
>   	bpl	signal_nonyb
>  =20
>   	moveb	%a3@, %a4@(o_crc1)
>  =20
> +	andb	#.Lhr_crc_error, %d5
> +	bne	signal_nonyb
> +
>   	tstb	%a3@(read_error - read_mark)
>  =20
>   	moveq	#0, %d0
> @@ -212,17 +217,20 @@ data_crc0:
>   	dbmi	%d2, data_crc0
>   	bpl	data_exit
>  =20
> -	moveb	%a3@, %d5
> +	moveb	%a3@, %d2
>  =20
>   	moveq	#max_retry, %d2
>  =20
>   data_crc1:
>  =20
> -	tstb	%a2@
> +	moveb	%a2@, %d5
>   	dbmi	%d2, data_crc1
>   	bpl	data_exit
>  =20
> -	moveb	%a3@, %d5
> +	moveb	%a3@, %d2
> +
> +	andb	#.Lhr_crc_error, %d5
> +	bne	data_exit
>  =20
>   	tstb	%a3@(read_error - read_mark)
>  =20

