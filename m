Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6B483AC0EB;
	Tue, 21 Jul 2026 05:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784612640; cv=none; b=q58ynuouSeWToRzFM19s72l/U0bir7FBI3LRiZp2bJTklkjAHcC5iqhGpiDQPk/FZVKLZup7HafuPAKt/JotOAF/6x0pCAr2zffjfQbyFRGRfpgcH3rTS5UNjBUZyJaCVx1Rw1+mnU1vRGJDn1oQ0PJe7LGQlwhWw8ccyyfFZSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784612640; c=relaxed/simple;
	bh=Y+RoXQ8rpdsoIM46ckhtQad/hZKdSrgL/zFAEbIPZlo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qbjMt/Xn3JUOL/hQJzddTTZGqF1vWYg//7L8CGahsXGgJJ5QBRsBHnvYcKLarYM8XD37JxcOl+sq2koISwWwlJYRl253KLxvMEHXMLH+C6n3XJ6gdAOgabyUKO9qnEi/I2ysLHmcY5/6ghMWcbqN7Rf1/ujjnEe10PgbBPA7dB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vivier.eu; spf=pass smtp.mailfrom=vivier.eu; dkim=pass (2048-bit key) header.d=vivier.eu header.i=laurent@vivier.eu header.b=X59xor2+; arc=none smtp.client-ip=217.72.192.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vivier.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivier.eu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivier.eu header.i=laurent@vivier.eu header.b="X59xor2+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivier.eu;
	s=s1-ionos; t=1784612628; x=1785217428; i=laurent@vivier.eu;
	bh=oe+tfPfWW2m/UkzjSowhiPwg5BIfQzm+rmug8w0ZoSQ=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=X59xor2+ab/eOpXIIwyxrupsGUJrg5PiwwhV7afFZ3p0B/O/kMXb26dUDWXQ7K0a
	 vXEBt/QDWZnBMi5RqtdHDvogl/xtE9NxXjs0tkSZqVr15QxOmPB+vhgYd3Xbaf0ay
	 3sAJuc7qt0Jvr+ZIqHL5Dd+wzcul4O4Qc8Hsp5Zm3VYUuCqhrvXPwnw8mXcsA2pAX
	 6+D/ExM0WjulMmmI1slKQZDiNL3cKRi5cPCDH4Vc18pzIp2UTrKcasvzUlGh4FxgL
	 QujDvIuO4Bwwrb386J3vAL0O4QROgCUz8WRvh6x3QSsZ9nGsNyhoRntGfBAweWG+z
	 s2c1TmNh5vY4U+ChyA==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from client.hidden.invalid by mrelayeu.kundenserver.de (mreue108
 [213.165.67.119]) with ESMTPSA (Nemesis) id 1MVNJ3-1wbQJP1V3v-00JekL; Tue, 21
 Jul 2026 07:43:48 +0200
Message-ID: <ca453fc0-967f-4676-8e0e-c3c3ee07b49b@vivier.eu>
Date: Tue, 21 Jul 2026 07:43:47 +0200
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 14/31] swim: Check error register during sector read
To: Finn Thain <fthain@linux-m68k.org>, Jens Axboe <axboe@kernel.dk>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
 Joshua Thompson <funaho@jurai.org>, linux-block@vger.kernel.org,
 linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org
References: <cover.1784196135.git.fthain@linux-m68k.org>
 <27750f91f40f6a276d777a91fda3c7e0a17fa396.1784196135.git.fthain@linux-m68k.org>
Content-Language: fr
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; keydata=
 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
In-Reply-To: <27750f91f40f6a276d777a91fda3c7e0a17fa396.1784196135.git.fthain@linux-m68k.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:yrWcZNIKtsYukibKIs2Jl3+HkFSIEx/k944GmeobzjlRu2T5Dnn
 NUA9uySN3R12GDUG0SngO7PpgCSbsRqBOgvlj59JUFP+2AbNNe95Xc0y+SQMlYqnx5oPCQ4
 1KxGk9H9QL0xbkCBU3Zvoz8XHZASHgEcgdbp5JiVQt4TjRwXHG9cJQaV1byVuvB3PzuovDV
 0bEPd+qSXbUW4KX7JyMeQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:dpGEptaUy/Y=;99rxeT0ZkSAyoPXSycUr2ZSxeUY
 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

Le 16/07/2026 =C3=A0 12:02, Finn Thain a =C3=A9crit=C2=A0:
> Clear the error register only once before a sector read operation. Don't
> clear it afterwards -- the caller needs it. Check the error register in
> swim_read_sector() and return the appropriate error when necessary. Full=
y
> validate the sector header. Don't terminate the search loop early just
> because an erroneous sector header showed up.
>=20
> Fixes: 8852ecd97488 ("m68k: mac - Add SWIM floppy support")
> Signed-off-by: Finn Thain <fthain@linux-m68k.org>
> ---
>   drivers/block/swim.c     | 13 +++++++------
>   drivers/block/swim_asm.S |  8 --------
>   2 files changed, 7 insertions(+), 14 deletions(-)

Reviewed-by: Laurent Vivier <laurent@vivier.eu>

> diff --git a/drivers/block/swim.c b/drivers/block/swim.c
> index 9755b86d4dd4..e2a8c4ba4e39 100644
> --- a/drivers/block/swim.c
> +++ b/drivers/block/swim.c
> @@ -483,20 +483,21 @@ static inline int swim_read_sector(struct floppy_s=
tate *fs,
>  =20
>   	local_irq_save(flags);
>   	for (i =3D 0; i < 36; i++) {
> -		ret =3D swim_read_sector_header(base, &header);
> -		if (!ret && (header.sector =3D=3D sector)) {
> +		if (swim_read_sector_header(base, &header) ||
> +		    swim_read(base, error) || header.track !=3D track ||
> +		    header.side !=3D side || header.size !=3D 2)
> +			continue;
> +		if (header.sector =3D=3D sector) {
>   			/* found */
>  =20
>   			ret =3D swim_read_sector_data(base, buffer);
> +			if (swim_read(base, error))
> +				ret =3D -EIO;
>   			break;
>   		}
>   	}
>   	local_irq_restore(flags);
>  =20
> -	if ((header.side !=3D side)  || (header.track !=3D track) ||
> -	     (header.sector !=3D sector))
> -		return 0;
> -
>   	return ret;
>   }
>  =20
> diff --git a/drivers/block/swim_asm.S b/drivers/block/swim_asm.S
> index f40e19e48021..1d394ee930d6 100644
> --- a/drivers/block/swim_asm.S
> +++ b/drivers/block/swim_asm.S
> @@ -67,7 +67,6 @@ mfm_read_addrmark:
>   	movew	#seek_time, %d2
>  =20
>   wait_header_init:
> -	tstb	%a3@(read_error - read_mark)
>   	moveb	#0x18, %a3@(write_mode0 - read_mark)
>   	moveb	#0x01, %a3@(write_mode1 - read_mark)
>   	moveb	#0x01, %a3@(write_mode0 - read_mark)
> @@ -139,8 +138,6 @@ crc1:	moveb	%a2@, %d5
>   	andb	#.Lhr_crc_error, %d5
>   	bne	signal_nonyb
>  =20
> -	tstb	%a3@(read_error - read_mark)
> -
>   	moveq	#0, %d0
>   signal_nonyb:
>   	moveb	#0x18, %a3@(write_mode0 - read_mark)
> @@ -165,7 +162,6 @@ mfm_read_data:
>   	movew	#seek_time, %d2
>  =20
>   wait_data_init:
> -	tstb	%a3@(read_error - read_mark)
>   	moveb	#0x18, %a3@(write_mode0 - read_mark)
>   	moveb	#0x01, %a3@(write_mode1 - read_mark)
>   	moveb	#0x01, %a3@(write_mode0 - read_mark)
> @@ -190,8 +186,6 @@ wait_data_mark_byte:
>  =20
>   	/* read data */
>  =20
> -	tstb	%a3@(read_error - read_mark)
> -
>   	movel	#sector_size-1, %d4		/* sector size */
>   read_new_data:
>   	movew	#max_retry, %d2
> @@ -232,8 +226,6 @@ data_crc1:
>   	andb	#.Lhr_crc_error, %d5
>   	bne	data_exit
>  =20
> -	tstb	%a3@(read_error - read_mark)
> -
>   	/* return number of bytes read */
>  =20
>   	movel	#sector_size, %d0

