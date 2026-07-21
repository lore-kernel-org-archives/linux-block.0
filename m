Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 011D439FD4;
	Tue, 21 Jul 2026 05:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784612997; cv=none; b=Ck2OWMahBqIg9LxyJA5CWbeqQZMqA4JhZpiAEX+BKtDkgJ0ptx8GW5rU9+g7UFIa5yxMgRoPfvAt3YiZzkZSsSz3HrmbDhHZCuvpM5JIDjBR+KPukskaP7tzq01NO/EZc1F4qZ3IcbV83S/zGbSk/8NPHMNoZaJEsl4nuuq9NNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784612997; c=relaxed/simple;
	bh=FuZYnIrq3qmEuTRQrY/oPdKvxjN2PTG+Y8UR/oOfiGE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iyMmyc8EeEp/gp4lLyiKK1rlge2ZUsUwIz11aH2r5KaX5Fb8XPdkYw1rOdvd87jMRY9V96FTeZDV6MdNYb5ripJkofIE0JwVrAftGAkXhH+6RpBbafzWlfULLstnqr70h46QG6CCMDygfFkrtjwX07atJrsADouz5jQtVTXcnXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vivier.eu; spf=pass smtp.mailfrom=vivier.eu; dkim=pass (2048-bit key) header.d=vivier.eu header.i=laurent@vivier.eu header.b=lFoJnJ/Z; arc=none smtp.client-ip=217.72.192.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vivier.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivier.eu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivier.eu header.i=laurent@vivier.eu header.b="lFoJnJ/Z"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivier.eu;
	s=s1-ionos; t=1784612987; x=1785217787; i=laurent@vivier.eu;
	bh=l1EEmXual/CmENi0X75pDrQceWfSuMf0rOB6ltHG0S4=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=lFoJnJ/ZYg6j815c6N7gINbPCJ0fn3MPQBws44OpF+1wKx+II8alQY4YpxJBQsDP
	 gSPOhQKq0eBCZeDmpzUXdpokHooKABZHSVwavKarYOAxrh0NbjB9XkoUwSg6HjySN
	 cbv5FsQhD1AAGDgzJS4JF3x5fVednFaRGeE4W4kE4p57EHhNSk3LOaCJNH1Zf/Cuc
	 yqv7cbN174tGit5qCxh1jkchHCRrJq4XpbMD//mr/YQVLtUiIHtQslB725xTBu22G
	 N6Uc1Qx250Ajt0Iggf1oRBpbnL2aZt9L5uOxi20ipL+i9zH8bQWJfVJ81flT1DRI0
	 K4og/wJKSu336fbw/Q==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from client.hidden.invalid by mrelayeu.kundenserver.de (mreue107
 [213.165.67.119]) with ESMTPSA (Nemesis) id 1M8hEd-1whOeo1Juz-00EZ7p; Tue, 21
 Jul 2026 07:49:47 +0200
Message-ID: <91d2afca-fcdc-43fe-ae1d-217dbc6fe6e3@vivier.eu>
Date: Tue, 21 Jul 2026 07:49:46 +0200
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 15/31] swim: Don't use the mark register to read data
To: Finn Thain <fthain@linux-m68k.org>, Jens Axboe <axboe@kernel.dk>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
 Joshua Thompson <funaho@jurai.org>, linux-block@vger.kernel.org,
 linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org
References: <cover.1784196135.git.fthain@linux-m68k.org>
 <c25cd3fe9919ad85d1e2147a294bfbd6ae2a2c21.1784196135.git.fthain@linux-m68k.org>
Content-Language: fr
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; keydata=
 xsFNBFYFJhkBEAC2me7w2+RizYOKZM+vZCx69GTewOwqzHrrHSG07MUAxJ6AY29/+HYf6EY2
 WoeuLWDmXE7A3oJoIsRecD6BXHTb0OYS20lS608anr3B0xn5g0BX7es9Mw+hV/pL+63EOCVm
 SUVTEQwbGQN62guOKnJJJfphbbv82glIC/Ei4Ky8BwZkUuXd7d5NFJKC9/GDrbWdj75cDNQx
 UZ9XXbXEKY9MHX83Uy7JFoiFDMOVHn55HnncflUncO0zDzY7CxFeQFwYRbsCXOUL9yBtqLer
 Ky8/yjBskIlNrp0uQSt9LMoMsdSjYLYhvk1StsNPg74+s4u0Q6z45+l8RAsgLw5OLtTa+ePM
 JyS7OIGNYxAX6eZk1+91a6tnqfyPcMbduxyBaYXn94HUG162BeuyBkbNoIDkB7pCByed1A7q
 q9/FbuTDwgVGVLYthYSfTtN0Y60OgNkWCMtFwKxRaXt1WFA5ceqinN/XkgA+vf2Ch72zBkJL
 RBIhfOPFv5f2Hkkj0MvsUXpOWaOjatiu0fpPo6Hw14UEpywke1zN4NKubApQOlNKZZC4hu6/
 8pv2t4HRi7s0K88jQYBRPObjrN5+owtI51xMaYzvPitHQ2053LmgsOdN9EKOqZeHAYG2SmRW
 LOxYWKX14YkZI5j/TXfKlTpwSMvXho+efN4kgFvFmP6WT+tPnwARAQABzSJMYXVyZW50IFZp
 dmllciA8bGF1cmVudEB2aXZpZXIuZXU+wsF4BBMBAgAiBQJWBTDeAhsDBgsJCAcDAgYVCAIJ
 CgsEFgIDAQIeAQIXgAAKCRDzDDi9Py++PCEdD/oD8LD5UWxhQrMQCsUgLlXCSM7sxGLkwmmF
 ozqSSljEGRhffxZvO35wMFcdX9Z0QOabVoFTKrT04YmvbjsErh/dP5zeM/4EhUByeOS7s6Yl
 HubMXVQTkak9Wa9Eq6irYC6L41QNzz/oTwNEqL1weV1+XC3TNnht9B76lIaELyrJvRfgsp9M
 rE+PzGPo5h7QHWdL/Cmu8yOtPLa8Y6l/ywEJ040IoiAUfzRoaJs2csMXf0eU6gVBhCJ4bs91
 jtWTXhkzdl4tdV+NOwj3j0ukPy+RjqeL2Ej+bomnPTOW8nAZ32dapmu7Fj7VApuQO/BSIHyO
 NkowMMjB46yohEepJaJZkcgseaus0x960c4ua/SUm/Nm6vioRsxyUmWd2nG0m089pp8LPopq
 WfAk1l4GciiMepp1Cxn7cnn1kmG6fhzedXZ/8FzsKjvx/aVeZwoEmucA42uGJ3Vk9TiVdZes
 lqMITkHqDIpHjC79xzlWkXOsDbA2UY/P18AtgJEZQPXbcrRBtdSifCuXdDfHvI+3exIdTpvj
 BfbgZAar8x+lcsQBugvktlQWPfAXZu4Shobi3/mDYMEDOE92dnNRD2ChNXg2IuvAL4OW40wh
 gXlkHC1ZgToNGoYVvGcZFug1NI+vCeCFchX+L3bXyLMg3rAfWMFPAZLzn42plIDMsBs+x2yP
 +c7BTQRWBSYZARAAvFJBFuX9A6eayxUPFaEczlMbGXugs0mazbOYGlyaWsiyfyc3PStHLFPj
 rSTaeJpPCjBJErwpZUN4BbpkBpaJiMuVO6egrC8Xy8/cnJakHPR2JPEvmj7Gm/L9DphTcE15
 92rxXLesWzGBbuYxKsj8LEnrrvLyi3kNW6B5LY3Id+ZmU8YTQ2zLuGV5tLiWKKxc6s3eMXNq
 wrJTCzdVd6ThXrmUfAHbcFXOycUyf9vD+s+WKpcZzCXwKgm7x1LKsJx3UhuzT8ier1L363RW
 ZaJBZ9CTPiu8R5NCSn9V+BnrP3wlFbtLqXp6imGhazT9nJF86b5BVKpF8Vl3F0/Y+UZ4gUwL
 d9cmDKBcmQU/JaRUSWvvolNu1IewZZu3rFSVgcpdaj7F/1aC0t5vLdx9KQRyEAKvEOtCmP4m
 38kU/6r33t3JuTJnkigda4+Sfu5kYGsogeYG6dNyjX5wpK5GJIJikEhdkwcLM+BUOOTi+I9u
 tX03BGSZo7FW/J7S9y0l5a8nooDs2gBRGmUgYKqQJHCDQyYut+hmcr+BGpUn9/pp2FTWijrP
 inb/Pc96YDQLQA1q2AeAFv3Rx3XoBTGl0RCY4KZ02c0kX/dm3eKfMX40XMegzlXCrqtzUk+N
 8LeipEsnOoAQcEONAWWo1HcgUIgCjhJhBEF0AcELOQzitbJGG5UAEQEAAcLBXwQYAQIACQUC
 VgUmGQIbDAAKCRDzDDi9Py++PCD3D/9VCtydWDdOyMTJvEMRQGbx0GacqpydMEWbE3kUW0ha
 US5jz5gyJZHKR3wuf1En/3z+CEAEfP1M3xNGjZvpaKZXrgWaVWfXtGLoWAVTfE231NMQKGoB
 w2Dzx5ivIqxikXB6AanBSVpRpoaHWb06tPNxDL6SVV9lZpUn03DSR6gZEZvyPheNWkvz7bE6
 FcqszV/PNvwm0C5Ju7NlJA8PBAQjkIorGnvN/vonbVh5GsRbhYPOc/JVwNNr63P76rZL8Gk/
 hb3xtcIEi5CCzab45+URG/lzc6OV2nTj9Lg0SNcRhFZ2ILE3txrmI+aXmAu26+EkxLLfqCVT
 ohb2SffQha5KgGlOSBXustQSGH0yzzZVZb+HZPEvx6d/HjQ+t9sO1bCpEgPdZjyMuuMp9N1H
 ctbwGdQM2Qb5zgXO+8ZSzwC+6rHHIdtcB8PH2j+Nd88dVGYlWFKZ36ELeZxD7iJflsE8E8yg
 OpKgu3nD0ahBDqANU/ZmNNarBJEwvM2vfusmNnWm3QMIwxNuJghRyuFfx694Im1js0ZY3LEU
 JGSHFG4ZynA+ZFUPA6Xf0wHeJOxGKCGIyeKORsteIqgnkINW9fnKJw2pgk8qHkwVc3Vu+wGS
 ZiJK0xFusPQehjWTHn9WjMG1zvQ5TQQHxau/2FkP45+nRPco6vVFQe8JmgtRF8WFJA==
In-Reply-To: <c25cd3fe9919ad85d1e2147a294bfbd6ae2a2c21.1784196135.git.fthain@linux-m68k.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:zpO4/CF+YU6isRjZK1CNLpq5JtQDOjBNnYmGhYgnOKj1LgA60d3
 wO5uD4a45cYUA5Dklsd/gVq8N1/ey9JWL6IMjgU8Q8k4Apdk7pVLDk/cf1H8Q+n+y9duwQl
 8avN2exQ1Mn25o5IJgVXiAe9l5zrRl7WzDnKeXIkmYyaX9jmK6fwIYvTEzj5c8kOb23wefU
 lsmnIpoRJu2nSWMppR5JQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:i5H9MnOoeDE=;kKvyeidP4RSmLgTUZXuSvB+A3IW
 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
 lSaj1oQJDG747JJAFci+Owpc1UA50=

Le 16/07/2026 =C3=A0 12:02, Finn Thain a =C3=A9crit=C2=A0:
> If an unexpected mark byte were to be read from the data register, an
> error would be flagged. But no error gets flagged when such a byte is
> read from the mark register, which is misleading. Always use the data
> register except when a mark byte is expected.
>=20
> Fixes: 8852ecd97488 ("m68k: mac - Add SWIM floppy support")
> Signed-off-by: Finn Thain <fthain@linux-m68k.org>
> ---
>   drivers/block/swim_asm.S | 21 +++++++++++----------
>   1 file changed, 11 insertions(+), 10 deletions(-)

Reviewed-by: Laurent Vivier <laurent@vivier.eu>

>=20
> diff --git a/drivers/block/swim_asm.S b/drivers/block/swim_asm.S
> index 1d394ee930d6..5caeba3a75d8 100644
> --- a/drivers/block/swim_asm.S
> +++ b/drivers/block/swim_asm.S
> @@ -47,11 +47,11 @@
>   	.global swim_read_sector_header
>   swim_read_sector_header:
>   	link	%a6, #0
> -	moveml	%d1-%d5/%a0-%a4,%sp@-
> +	moveml	%d1-%d5/%a0-%a5,%sp@-
>   	movel	%a6@(0x0c), %a4
>   	moveq	#-1, %d0
>   	bsr	mfm_read_addrmark
> -	moveml	%sp@+, %d1-%d5/%a0-%a4
> +	moveml	%sp@+, %d1-%d5/%a0-%a5
>   	unlk	%a6
>   	rts
>  =20
> @@ -63,6 +63,7 @@ sector_data_mark:
>   mfm_read_addrmark:
>   	movel	%a6@(0x08), %a3
>   	lea	%a3@(read_handshake), %a2
> +	lea	%a3@(read_data), %a5
>   	lea	%a3@(read_mark), %a3
>   	movew	#seek_time, %d2
>  =20
> @@ -93,7 +94,7 @@ amark0:	tstb	%a2@
>   	dbmi	%d2, amark0
>   	bpl	signal_nonyb
>  =20
> -	moveb	%a3@, %a4@(o_track)
> +	moveb	%a5@, %a4@(o_track)
>  =20
>   	moveq	#max_retry, %d2
>  =20
> @@ -101,7 +102,7 @@ amark1:	tstb	%a2@
>   	dbmi	%d2, amark1
>   	bpl	signal_nonyb
>  =20
> -	moveb	%a3@, %a4@(o_side)
> +	moveb	%a5@, %a4@(o_side)
>  =20
>   	moveq	#max_retry, %d2
>  =20
> @@ -109,7 +110,7 @@ amark2:	tstb	%a2@
>   	dbmi	%d2, amark2
>   	bpl	signal_nonyb
>  =20
> -	moveb	%a3@, %a4@(o_sector)
> +	moveb	%a5@, %a4@(o_sector)
>  =20
>   	moveq	#max_retry, %d2
>  =20
> @@ -117,7 +118,7 @@ amark3:	tstb	%a2@
>   	dbmi	%d2, amark3
>   	bpl	signal_nonyb
>  =20
> -	moveb	%a3@, %a4@(o_size)
> +	moveb	%a5@, %a4@(o_size)
>  =20
>   	moveq	#max_retry, %d2
>  =20
> @@ -125,7 +126,7 @@ crc0:	tstb	%a2@
>   	dbmi	%d2, crc0
>   	bpl	signal_nonyb
>  =20
> -	moveb	%a3@, %a4@(o_crc0)
> +	moveb	%a5@, %a4@(o_crc0)
>  =20
>   	moveq	#max_retry, %d2
>  =20
> @@ -133,7 +134,7 @@ crc1:	moveb	%a2@, %d5
>   	dbmi	%d2, crc1
>   	bpl	signal_nonyb
>  =20
> -	moveb	%a3@, %a4@(o_crc1)
> +	moveb	%a5@, %a4@(o_crc1)
>  =20
>   	andb	#.Lhr_crc_error, %d5
>   	bne	signal_nonyb
> @@ -211,7 +212,7 @@ data_crc0:
>   	dbmi	%d2, data_crc0
>   	bpl	data_exit
>  =20
> -	moveb	%a3@, %d2
> +	moveb	%a5@, %d2
>  =20
>   	moveq	#max_retry, %d2
>  =20
> @@ -221,7 +222,7 @@ data_crc1:
>   	dbmi	%d2, data_crc1
>   	bpl	data_exit
>  =20
> -	moveb	%a3@, %d2
> +	moveb	%a5@, %d2
>  =20
>   	andb	#.Lhr_crc_error, %d5
>   	bne	data_exit

