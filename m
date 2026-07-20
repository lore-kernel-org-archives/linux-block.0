Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C602D3DCD83;
	Mon, 20 Jul 2026 18:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.75
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784570933; cv=none; b=e3XNnxToVnGR0NcYJHp7Avb74MH74yOqJrHBfp0LAl7HQ075lHyjLhLtJib+Q5w7t8SGJ5uFQaijklfHiFS/91h0Prl6eVwc51kBi466WHpgevL3JGbPgzR3NwgKY5PuHjkh4HH2KCyD4pS++FYmIzDHhx5yba9ZNDW5o/kV9Lg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784570933; c=relaxed/simple;
	bh=J8F788JD6T5u5CaI+AldRHLR8ZHPMZvo7w7uJf3nGFQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=n3CzQ+iB6svuiG20XeVqtMNeGSN4T/+oY6jJTx/YQV3X9rpU5tnqbQ5UOSgPmzm5kkBa6dxKEvv0nJfflSqB2LZTLNvYeNCZetEX3ZNSsjzTipctkWySasRfP8d4NczHokCdJIKau7ZimXDAm3/BmjYzCq/h+kOeVHZjzfite7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vivier.eu; spf=pass smtp.mailfrom=vivier.eu; dkim=pass (2048-bit key) header.d=vivier.eu header.i=laurent@vivier.eu header.b=HShbCOPS; arc=none smtp.client-ip=217.72.192.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vivier.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivier.eu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivier.eu header.i=laurent@vivier.eu header.b="HShbCOPS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivier.eu;
	s=s1-ionos; t=1784570918; x=1785175718; i=laurent@vivier.eu;
	bh=kEaYGwV3IGpW8+j603P3oIfvdicZxomkXcdTRTxxkfQ=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=HShbCOPSUH8FyTY+Lby1MNxQwJ64AHvVGQvy5ltrYxPIFsehjcwnMCsPYf1LXHG6
	 6oYs4ZKzp1xBwtzvONW1v6UNvJd5y0U7Q72wTzObAKnbw2Zn25vTXT+IZGVp9ke0k
	 yVUD0m3K7oT6ojuGRwO4gmrQmyPyc7V/1M1UZcNG5BxYrGGZlee4wSYvbShqbMkzG
	 9oP+K5AoW07FsxxxhXEiQYjshCXUIrUItWlc6FomtbYWc0YcHnWKprPi0RYbvky8t
	 JOvRh45RIqhYZNDWIaHe1wRByh2w9Bad/l/8RF0sJVJH4Rwze0/8+x3LSVzUUN4aS
	 tTZse0n7H0Yym2uSPg==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from client.hidden.invalid by mrelayeu.kundenserver.de (mreue109
 [213.165.67.119]) with ESMTPSA (Nemesis) id 1MFbeC-1wmPqS0xQ6-008zlq; Mon, 20
 Jul 2026 20:08:38 +0200
Message-ID: <f9f53811-e364-43fa-bf4f-c53d03e00236@vivier.eu>
Date: Mon, 20 Jul 2026 20:08:37 +0200
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/31] swim: Enable the drive when probing
To: Finn Thain <fthain@linux-m68k.org>, Jens Axboe <axboe@kernel.dk>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
 Joshua Thompson <funaho@jurai.org>, linux-block@vger.kernel.org,
 linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org
References: <cover.1784196135.git.fthain@linux-m68k.org>
 <899351f6515677eb6323d11ac2a84346924b2fb4.1784196135.git.fthain@linux-m68k.org>
Content-Language: fr
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; keydata=
 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
In-Reply-To: <899351f6515677eb6323d11ac2a84346924b2fb4.1784196135.git.fthain@linux-m68k.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:/9sNPYZ2o8ShsFtz0Vv2LFk5XSNqIHZhzhy4TUSLs6qgIaM+TEL
 YvIBd8yJzysh+L30ToLh9yeU8SZGvyD/vphOHBvIkeN1XQGtxdj11tGCrIueFnrjW+qiO3B
 4ipQKFC5hFa68c4FqfsSRajA5Nv/SfGcyUeY83kWkIkHp+LKyejkSPgjFNSo0HP2KWFvm4L
 PKePIGZ4lIGBy4BnqGkQQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:oLxuISUT1U0=;vQhE9rCr5DyeCGnwoOFwx+fsu6g
 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
 NdovfiRhEcvJl1GGsJa9hdfbd4Dug=

Le 16/07/2026 =C3=A0 12:02, Finn Thain a =C3=A9crit=C2=A0:
> According to the ISM spec, the MOTON bit "causes the Enable 1 and Enable=
 2
> signals to be turned on to the drive." It doesn't actually turn on the
> motor. When selecting a drive, enable MOTON. Disable it upon eject or
> release. This fixes detection of the Sony FDHD drive.
>=20
> Fixes: 8852ecd97488 ("m68k: mac - Add SWIM floppy support")
> Signed-off-by: Finn Thain <fthain@linux-m68k.org>
> ---
>   drivers/block/swim.c | 18 +++++++++++++++---
>   1 file changed, 15 insertions(+), 3 deletions(-)
>=20

Reviewed-by: Laurent Vivier <laurent@vivier.eu>

> diff --git a/drivers/block/swim.c b/drivers/block/swim.c
> index 2c52a210f4a6..2a400e544959 100644
> --- a/drivers/block/swim.c
> +++ b/drivers/block/swim.c
> @@ -154,8 +154,9 @@ struct iwm {
>   /*--------------------------------------------------------------------=
=2D-------*/
>  =20
>   enum drive_location {
> -	INTERNAL_DRIVE =3D 0x02,
> -	EXTERNAL_DRIVE =3D 0x04,
> +	NO_DRIVE =3D 0,
> +	INTERNAL_DRIVE =3D BIT(1),
> +	EXTERNAL_DRIVE =3D BIT(2),
>   };
>  =20
>   enum media_type {
> @@ -311,9 +312,15 @@ static inline void swim_drive(struct swim __iomem *=
base,
>   	if (location =3D=3D INTERNAL_DRIVE) {
>   		swim_write(base, mode0, EXTERNAL_DRIVE); /* clear drive 1 bit */
>   		swim_write(base, mode1, INTERNAL_DRIVE); /* set drive 0 bit */
> +		swim_write(base, mode1, MOTON);
>   	} else if (location =3D=3D EXTERNAL_DRIVE) {
>   		swim_write(base, mode0, INTERNAL_DRIVE); /* clear drive 0 bit */
>   		swim_write(base, mode1, EXTERNAL_DRIVE); /* set drive 1 bit */
> +		swim_write(base, mode1, MOTON);
> +	} else {
> +		swim_write(base, mode0, INTERNAL_DRIVE);
> +		swim_write(base, mode0, EXTERNAL_DRIVE);
> +		swim_write(base, mode0, MOTON);
>   	}
>   }
>  =20
> @@ -447,6 +454,7 @@ static int floppy_eject(struct floppy_state *fs)
>   	swim_drive(base, fs->location);
>   	swim_motor(base, OFF);
>   	swim_eject(base);
> +	swim_drive(base, NO_DRIVE);
>  =20
>   	fs->disk_in =3D 0;
>   	fs->ejected =3D 1;
> @@ -652,8 +660,10 @@ static int floppy_open(struct gendisk *disk, blk_mo=
de_t mode)
>   	else if (fs->ref_count > 0)
>   		--fs->ref_count;
>  =20
> -	if (fs->ref_count =3D=3D 0)
> +	if (fs->ref_count =3D=3D 0) {
>   		swim_motor(base, OFF);
> +		swim_drive(base, NO_DRIVE);
> +	}
>   	return err;
>   }
>  =20
> @@ -682,6 +692,7 @@ static void floppy_release(struct gendisk *disk)
>   	if (fs->ref_count =3D=3D 0) {
>   		swim_drive(base, fs->location);
>   		swim_motor(base, OFF);
> +		swim_drive(base, NO_DRIVE);
>   	}
>   	mutex_unlock(&swim_mutex);
>   }
> @@ -804,6 +815,7 @@ static int swim_floppy_init(struct swim_priv *swd)
>   	if (swim_readbit(base, DRIVE_PRESENT) &&
>   	    !swim_readbit(base, ONEMEG_DRIVE))
>   		swim_add_floppy(swd, EXTERNAL_DRIVE);
> +	swim_drive(base, NO_DRIVE);
>  =20
>   	/* register floppy drives */
>  =20

