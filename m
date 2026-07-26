Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A13BA3C0A03;
	Sun, 26 Jul 2026 15:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785080314; cv=none; b=o5+lWvGiZT9wfha3xWEC8LpK3xnP6xGr7nwzgVKDpASO2CZwuUx6sqYbtbTpxUAu/aw4x0gev/WG1+ytBGNIvF0jQEo1Q3qPKoktLKD+Op2Z+aALfIxQpSg92n6MqdCLAGmsNbUvcK4m+wrFGuOeCtY55dlMqEpvZrP1xqgJeNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785080314; c=relaxed/simple;
	bh=usL+o5tKKD4qzUYfULO8TCENVnNcex15NX8l315XZ1M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YjQRIl7to7Vt3pwFjUUl5rCveTXeJYdOX/1hWltETdMj/gsbQvjxpx6kIkGq7UO28mZ15JMioJi5KVub6k9Csoxxq2Y6zW/1/QZW1WUqX4mb33i6gUpKsGMSMjqsvE5COg12HcGbf/YQcSCvzOQp7tA21wFVseZxLU+glD8QbKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vivier.eu; spf=pass smtp.mailfrom=vivier.eu; dkim=pass (2048-bit key) header.d=vivier.eu header.i=laurent@vivier.eu header.b=N683nGWe; arc=none smtp.client-ip=212.227.17.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vivier.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivier.eu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivier.eu header.i=laurent@vivier.eu header.b="N683nGWe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivier.eu;
	s=s1-ionos; t=1785080308; x=1785685108; i=laurent@vivier.eu;
	bh=xoAdZMToSETUePoPJ5Lc6BUfdvmH2Gk6gKj5uZSj9+s=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=N683nGWeHlbk/IYZ8p9TUH7kSYcvBUqDzHNHWJL/h2ruNcHMXUatHkW9a0jJC5vP
	 j9ovHClZeUNucgZUzWqLGZrXj/ZexLhmxDYYc6BzVSi2DZ180gi8vJMTOUGrRfAoV
	 okJvdS+nDyaQHSs0yvK9gtAv/a/O9cvX+u84Hkj3lcJpxr/0ioWIB2Rv5XyghJEuu
	 wruIkX0PxUEHIf7lp+FcL/InOdD5Eqjb10paeVbepgtYUTvLMCnwJmqC3dkYydDPT
	 cOUtUi1WkkUXEeUUgn/ASuOzAsG7v9Hn6uXoTc3EdIrtax6/KBrhAxvBzTIjNr8xF
	 /9JCwbkNep1OLztktA==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from client.hidden.invalid by mrelayeu.kundenserver.de (mreue108
 [213.165.67.119]) with ESMTPSA (Nemesis) id 1MlNl5-1xFstN1HpN-00cy2l; Sun, 26
 Jul 2026 17:38:28 +0200
Message-ID: <fa675a72-3dd2-4d6f-a000-21001a898d50@vivier.eu>
Date: Sun, 26 Jul 2026 17:38:27 +0200
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 24/31] swim: Remove pointless specifiers
To: Finn Thain <fthain@linux-m68k.org>, Jens Axboe <axboe@kernel.dk>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
 Joshua Thompson <funaho@jurai.org>, linux-block@vger.kernel.org,
 linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org
References: <cover.1784196135.git.fthain@linux-m68k.org>
 <4c0b70c4f500c05d0b1a3430afc57e51e541ef36.1784196135.git.fthain@linux-m68k.org>
Content-Language: fr
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; keydata=
 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
In-Reply-To: <4c0b70c4f500c05d0b1a3430afc57e51e541ef36.1784196135.git.fthain@linux-m68k.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:xCmJvfZkBl0/I7Ot69tPBAgg1XQfnDngmdy3tJ+acN+jHTvFsZ9
 Kcbda2Nm86GtejceVCvzIbWAhwBiE4qLMiHTBGEgHObWx1YRqPaVflARGxSbvTFTiUXJLMG
 4x45UJ6/eTAL3Q1VB+yJsZ/xVIlAZRBow40brX/I0VSagjePlgduBtoaApFiSg9V3oWfLg5
 4ET0n6tkr2N3cuIymuSHg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:MlVKjfy2+Is=;QTwHBG44QsJQfrpQbgRYoCytUmt
 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

Le 16/07/2026 =C3=A0 12:02, Finn Thain a =C3=A9crit=C2=A0:
> If the compiler made these functions "as fast as possible" that wouldn't
> actually help because they involve slow mechanical operations. Remove
> pointless inline function specifiers.

In fact the idea was not to make them as fast as possible but a avoid the =
jump (to keep all the SWIM=20
operations in the same functional block).

>=20
> Signed-off-by: Finn Thain <fthain@linux-m68k.org>
> ---
>   drivers/block/swim.c | 20 ++++++++++----------
>   1 file changed, 10 insertions(+), 10 deletions(-)

Reviewed-by: Laurent Vivier <laurent@vivier.eu>

>=20
> diff --git a/drivers/block/swim.c b/drivers/block/swim.c
> index dae401e649d7..4679f554fec5 100644
> --- a/drivers/block/swim.c
> +++ b/drivers/block/swim.c
> @@ -222,7 +222,7 @@ extern int swim_read_sector_data(struct swim __iomem=
 *base,
>   				 unsigned char *data);
>  =20
>   static DEFINE_MUTEX(swim_mutex);
> -static inline void set_swim_mode(struct swim __iomem *base, int enable)
> +static void set_swim_mode(struct swim __iomem *base, int enable)
>   {
>   	struct iwm __iomem *iwm_base =3D (struct iwm __iomem *)base;
>   	unsigned long flags;
> @@ -250,7 +250,7 @@ static inline void set_swim_mode(struct swim __iomem=
 *base, int enable)
>   	local_irq_restore(flags);
>   }
>  =20
> -static inline int get_swim_mode(struct swim __iomem *base)
> +static int get_swim_mode(struct swim __iomem *base)
>   {
>   	unsigned long flags;
>  =20
> @@ -324,7 +324,7 @@ static inline bool swim_readbit(struct swim __iomem =
*base, int bit)
>   	ret; \
>   })
>  =20
> -static inline void swim_drive(struct swim __iomem *base,
> +static void swim_drive(struct swim __iomem *base,
>   			      enum drive_location location)
>   {
>   	if (location =3D=3D INTERNAL_DRIVE) {
> @@ -343,8 +343,8 @@ static inline void swim_drive(struct swim __iomem *b=
ase,
>   	udelay(1);
>   }
>  =20
> -static inline void swim_motor(struct swim __iomem *base,
> -			      enum motor_action action)
> +static void swim_motor(struct swim __iomem *base,
> +		       enum motor_action action)
>   {
>   	if (action =3D=3D ON) {
>   		swim_action(base, MOTOR_ON);
> @@ -355,7 +355,7 @@ static inline void swim_motor(struct swim __iomem *b=
ase,
>   	}
>   }
>  =20
> -static inline void swim_eject(struct swim __iomem *base)
> +static void swim_eject(struct swim __iomem *base)
>   {
>   	swim_action(base, EJECT);
>   	swim_readbit_timeout(base, DISK_IN, false, 2000 * 1000);
> @@ -370,14 +370,14 @@ static inline void swim_head(struct swim __iomem *=
base, enum head head)
>   		swim_select(base, READ_DATA_0);
>   }
>  =20
> -static inline int swim_step(struct swim __iomem *base)
> +static int swim_step(struct swim __iomem *base)
>   {
>   	swim_action(base, STEP);
>   	udelay(150);
>   	return swim_readbit_timeout_atomic(base, STEP, false, 20 * 1000);
>   }
>  =20
> -static inline int swim_track00(struct swim __iomem *base)
> +static int swim_track00(struct swim __iomem *base)
>   {
>   	int try;
>  =20
> @@ -397,7 +397,7 @@ static inline int swim_track00(struct swim __iomem *=
base)
>   	return -1;
>   }
>  =20
> -static inline int swim_seek(struct swim __iomem *base, int step)
> +static int swim_seek(struct swim __iomem *base, int step)
>   {
>   	if (step < 0) {
>   		swim_action(base, SEEK_NEGATIVE);
> @@ -422,7 +422,7 @@ static inline int swim_seek(struct swim __iomem *bas=
e, int step)
>   	return 0;
>   }
>  =20
> -static inline int swim_track(struct floppy_state *fs,  int track)
> +static int swim_track(struct floppy_state *fs,  int track)
>   {
>   	struct swim __iomem *base =3D fs->swd->base;
>   	int ret;

