Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61D4B2DECCB;
	Tue, 21 Jul 2026 05:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784613597; cv=none; b=AYUB5+vEztWjRX0A+XRl02o/+EzMwmVjGOYutCnPK99l37XhiygFfrffQ2CtsDt7nye4mrw82T28bc6IGpasOetsDZXPD6iaQVwIYlrTwqFZu/Qe3kq3IkqHMQNSbb/wAGoR2R/e+5aUwr9hjYPkfgZkIKHRITa8VhJaMP+MKsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784613597; c=relaxed/simple;
	bh=wkK8Eik/JY5z7LKeR4wODhpZg74AKBRgJI3oOf9JvTs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PgA/B33dkR9WKVE3L6be7TK9ITuGazuR6J643XV7W9JT5Y+D5yvPHjiUuOzzRflG7rPOJE6pCYIM7BCWBJxNtsQec1LsbLhBIAirMBZCydEB5Tw/D9zDr2zcJxchFVrzdoKn8Ao8/hYMh33rDqqhxR9cmiMoO2LmRQ4ZeEHcnOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vivier.eu; spf=pass smtp.mailfrom=vivier.eu; dkim=pass (2048-bit key) header.d=vivier.eu header.i=laurent@vivier.eu header.b=SfbHMiHQ; arc=none smtp.client-ip=212.227.17.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vivier.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivier.eu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivier.eu header.i=laurent@vivier.eu header.b="SfbHMiHQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivier.eu;
	s=s1-ionos; t=1784613593; x=1785218393; i=laurent@vivier.eu;
	bh=EjrJI+iykxRjD1LXrVLRB66bUNOhQN8Hh9Hwg2NHqQ4=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=SfbHMiHQGGDcqX/i+9KLqG7L8eQk0gURCdQMvDN4onfEYDZRnRPcgZV5n5ne/Y/h
	 BgOO5rlQ+mPD1XN6d1dpywvKjc6bIpsCnbA4bpIIbVy81cWfQIEBYfA6oAtfLgpUF
	 yHz2b8D3iEzdU4q2TzDtH/bgQu9mQmJBAYA3FUu865cGEZ+5frMXkKVgiXfpK/g4k
	 3LyWqLV82P9e+9FyNGQA5W0SJzUYG8qkqnafUleZJ1q1bVtG95YqvcrvTjoJFmFiH
	 mxfVj6nkBeatvlAFBiEjK+OkFZa/kYZB5xEh6UbKTPly1wAUde4N1lSJatq9VCP4N
	 xUjeiLmEBQgTaAj8nA==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from client.hidden.invalid by mrelayeu.kundenserver.de (mreue107
 [213.165.67.119]) with ESMTPSA (Nemesis) id 1M5gAG-1weudn1ih8-00Hahv; Tue, 21
 Jul 2026 07:59:53 +0200
Message-ID: <d7af2b83-d5ff-4a98-9008-6209efb9a243@vivier.eu>
Date: Tue, 21 Jul 2026 07:59:52 +0200
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 16/31] swim: Fix buffer overflow
To: Finn Thain <fthain@linux-m68k.org>, Jens Axboe <axboe@kernel.dk>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
 Joshua Thompson <funaho@jurai.org>, linux-block@vger.kernel.org,
 linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org
References: <cover.1784196135.git.fthain@linux-m68k.org>
 <afaeaf8ed29a73e1b361519b542269c4a57a1713.1784196135.git.fthain@linux-m68k.org>
Content-Language: fr
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; keydata=
 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
In-Reply-To: <afaeaf8ed29a73e1b361519b542269c4a57a1713.1784196135.git.fthain@linux-m68k.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:zipMuL4y7zQYDA8iDwn8FPi0RjSB3U1Y0ljkz4O2bR3C3UIPmLX
 TARoL6OQCbF0n9xqwVAf6FZdJWTvN0jP4NYmjarYKvF9kjzsfNCzl87Dhm4XMBfJuxqBHRD
 V9Dbqtev8ryAVAvruNFIoOvf1lW7U1kceq6dj31EyI8L7FcWxNNpXYwSvz0F1aQoahijkpI
 qc6Dz3Yem23eE8zCY7cPg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:IkVs4cBbYH0=;2YlE3f+p5s+vDNewp0q3gF13oI+
 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
 XMyfmvriiSrG2YxLQ3SFx1zLb6/2s=

Le 16/07/2026 =C3=A0 12:02, Finn Thain a =C3=A9crit=C2=A0:
> The effect of this bug can be observed as swim_read_sector_data()
> inexplicably returning -5, or an error flag indicating that a mark byte
> was read from the data register, or other odd behviour.
>=20
> When copying bytes from the chip FIFO to the read buffer, the driver
> keeps count of the remaining buffer space using register %d4. A counter
> in register %d2 serves as a timeout. The driver polls (%a2), the handsha=
ke
> register, until flags indicate that byte(s) have arrived in the FIFO.
>=20
>          movel   #sector_size-1, %d4
> read_new_data:
>          movew   #max_retry, %d2
> read_data_loop:
>          moveb   %a2@, %d5
>          andb    #0xc0, %d5
>          dbne    %d2, read_data_loop
>          beq     data_exit
>          moveb   %a5@, %a4@+
>          andb    #0x40, %d5
>          dbne    %d4, read_new_data
>          beq     exit_loop
>=20
> Note that the exit_loop branch depends upon a flag in the handshake
> register and not on the remaining buffer space. Hence there may be no
> branch to exit_loop after %d4 is decremented to -1 (i.e. full buffer).
>=20
>          moveb   %a5@, %a4@+
>          dbra    %d4, read_new_data
> exit_loop:
>=20
> Here is a second decrement of %d4 which can now reach -2. But the buffer
> bounds check is a comparison with -1, which is now ineffective. Hence th=
e
> loop will continue copying until %d2 eventually reaches -1.
>=20
> Fix this bug by terminating the loop as soon as %d4 or %d2 reach -1.
> Reset the timeout whenever a byte is copied.
>=20
> Fixes: 8852ecd97488 ("m68k: mac - Add SWIM floppy support")
> Signed-off-by: Finn Thain <fthain@linux-m68k.org>
> ---
>   drivers/block/swim_asm.S | 15 +++++++++------
>   1 file changed, 9 insertions(+), 6 deletions(-)

Reviewed-by: Laurent Vivier <laurent@vivier.eu>

>=20
> diff --git a/drivers/block/swim_asm.S b/drivers/block/swim_asm.S
> index 5caeba3a75d8..ae767da671e3 100644
> --- a/drivers/block/swim_asm.S
> +++ b/drivers/block/swim_asm.S
> @@ -43,6 +43,8 @@
>   	.equ	sector_size, 512
>  =20
>   	.equ	.Lhr_crc_error,		0x02
> +	.equ	.Lhr_fifo_2bytes,	0x40
> +	.equ	.Lhr_fifo_1byte,	0x80
>  =20
>   	.global swim_read_sector_header
>   swim_read_sector_header:
> @@ -192,16 +194,17 @@ read_new_data:
>   	movew	#max_retry, %d2
>   read_data_loop:
>   	moveb	%a2@, %d5
> -	andb	#0xc0, %d5
> +	andb	#(.Lhr_fifo_2bytes + .Lhr_fifo_1byte), %d5
> +	beq	1f
> +	movew	#max_retry, %d2
> +	moveb	%a5@, %a4@+
> +	dbra	%d4, 1f
> +	bra	data_crc0
> +1:	andb	#.Lhr_fifo_2bytes, %d5
>   	dbne	%d2, read_data_loop
>   	beq	data_exit
>   	moveb	%a5@, %a4@+
> -	andb	#0x40, %d5
> -	dbne	%d4, read_new_data
> -	beq	exit_loop
> -	moveb	%a5@, %a4@+
>   	dbra	%d4, read_new_data
> -exit_loop:
>  =20
>   	/* read CRC */
>  =20

