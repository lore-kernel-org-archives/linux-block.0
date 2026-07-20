Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63048282F35;
	Mon, 20 Jul 2026 19:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784575075; cv=none; b=MNUUKEnik1TFTVJ43z6w+ZaeuC/RS0dyFzIiwsc7VuP67/tkJJz5xhaSejMD7FxEljTrCB9pwCqUlW0ys3/8hI8G+iq7IWNwIQHuXR19H51awBQJeS1PghOEgysDbNwlB3C4c4urJWwtWBPD2+NXKmavbarzFu1uaoTV4f1oHBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784575075; c=relaxed/simple;
	bh=YNOD1dSeV6ea2Db4CdlfQNtsq//UwYu4UwKaQsEsWd0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Od3r+VhdZ+8e54jy2msImD6w3LrzAAyxoOzJ1QgLQz7aIltn0MQZg+clVoZ9I4yaaKN9Wc7gcaixWcKOnXosUYTgOUtoJ9uqb8xc8LWD60/QJTSlCU8GCl7cG51gLDn7Ho7Ox6Kwv3d5Ve9ERZsyMKa6Ia7SeYfg+VCBL0BYA1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vivier.eu; spf=pass smtp.mailfrom=vivier.eu; dkim=pass (2048-bit key) header.d=vivier.eu header.i=laurent@vivier.eu header.b=16tobNKp; arc=none smtp.client-ip=217.72.192.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vivier.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivier.eu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivier.eu header.i=laurent@vivier.eu header.b="16tobNKp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivier.eu;
	s=s1-ionos; t=1784575071; x=1785179871; i=laurent@vivier.eu;
	bh=MRDYg2gFO1hubxx+v6oMgaIyLqarb65CN772wyVb7kg=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=16tobNKp1X3SkDcUqz+mxMVzrJPrUDRKdny5TxA4AfFk8gXwn6p1ycWUj+Q7oBBc
	 wMxAQL9IfLZ28Ds0gJBCvueAOsqGpz2M8XytQdorLTLNAqM+3m4iblaj9YdZCcBtV
	 dCbCEEPUxRvrW8iPztniuwAL8BSP9Xso395aiH+J2TSc1PriFzSV7Bvy5Z5DZihwA
	 2Z7aztuXCLIu3Sr97myIGiAXDQ2pZce7eIJx7DsQi9aTBgtFM3r+S9ZEcZsF8/HsM
	 C9i2gRMJKhDFPZotezx2qj6rI/NVqIu/WHhKoP6WymvoePfsHNSwndWl0cAxk9lpC
	 5GDYIXh+Bx95sG3ckg==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from client.hidden.invalid by mrelayeu.kundenserver.de (mreue108
 [213.165.67.119]) with ESMTPSA (Nemesis) id 1MvsR7-1x2Baq06qN-011kwx; Mon, 20
 Jul 2026 21:17:51 +0200
Message-ID: <56132071-16d0-41c6-b133-5dbfdf054142@vivier.eu>
Date: Mon, 20 Jul 2026 21:17:50 +0200
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/31] swim: Handle FIFO timeout error
To: Finn Thain <fthain@linux-m68k.org>, Jens Axboe <axboe@kernel.dk>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
 Joshua Thompson <funaho@jurai.org>, linux-block@vger.kernel.org,
 linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org
References: <cover.1784196135.git.fthain@linux-m68k.org>
 <8e4b8cbf93d5091df2fa3d652eaeb3793a2388b0.1784196135.git.fthain@linux-m68k.org>
Content-Language: fr
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; keydata=
 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
In-Reply-To: <8e4b8cbf93d5091df2fa3d652eaeb3793a2388b0.1784196135.git.fthain@linux-m68k.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:1BbTU49HIAZv3YRUSaQtTaYTyTQaOxtz8KR2SCxlP+aMD7t424Q
 qf0PsQ5ub+yIqc2bn8whPKghIm/C80bR0u3Q2pOVoc66g82H7CXok1FloN9Mnsl10mo9r/a
 xMFyS/Wnqoqy/qgAKnKe4X9PvMCU67U1V7vujmozWNzBwjUnK8JM3TCvCJdVuneOnB9bTtD
 +Tyql8vdHCVw4aJhqzM0A==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:dIkY1coljRs=;1U0kY15ku+kFP1k4rW30gGHGAb+
 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
 EQiU2xyjyCIJImWMDyNdEq7zu1ORM=

Le 16/07/2026 =C3=A0 12:02, Finn Thain a =C3=A9crit=C2=A0:
> When polling the FIFO for a mark byte in the sector header, don't
> return zero if the timeout counter has expired, return an error code.
>=20
> Fixes: 8852ecd97488 ("m68k: mac - Add SWIM floppy support")
> Signed-off-by: Finn Thain <fthain@linux-m68k.org>
> ---
>   drivers/block/swim_asm.S | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)

Reviewed-by: Laurent Vivier <laurent@vivier.eu>

>=20
> diff --git a/drivers/block/swim_asm.S b/drivers/block/swim_asm.S
> index 3d7a2d87595a..208622ac4aeb 100644
> --- a/drivers/block/swim_asm.S
> +++ b/drivers/block/swim_asm.S
> @@ -79,7 +79,7 @@ wait_addr_mark_byte:
>  =20
>   	tstb	%a2@
>   	dbmi	%d2, wait_addr_mark_byte
> -	bpl	header_exit
> +	bpl	signal_nonyb
>  =20
>   	moveb	%a3@, %d3
>   	cmpb	%a0@+, %d3
> @@ -136,7 +136,6 @@ crc1:	tstb	%a2@
>  =20
>   	tstb	%a3@(read_error - read_mark)
>  =20
> -header_exit:
>   	moveq	#0, %d0
>   	moveb	#0x18, %a3@(write_mode0 - read_mark)
>   	rts

