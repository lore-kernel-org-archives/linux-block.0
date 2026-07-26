Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA1911624DF;
	Sun, 26 Jul 2026 14:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785077446; cv=none; b=HlEPWlheCgqKGymcYawuny/eQKZj+9lJKe95tRqrxI8CAYGJlHuqsi3xST5rm1NDv6Tb4wgcO7y4dUtwzaQFq9CavIy+OoNFdBL83gjhA8cEM2e3querULqaSL1DjknDzUXz09l2Ty/6/V39Fa36aTVC/yAio3Ae0QLIUHqqISA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785077446; c=relaxed/simple;
	bh=08cuKxFadpEJH2uFPJnxyWJ+73+BMYmFkYEaVGh2rbM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GEuO+XhV73BKi5d2VVO/qPXAkN/h6AAbDc7kzkEJHdvA61KN5OtwM4qq3vnf49yCnm0FvLQsaF4pMo0kZktFS4U6MHR+Mh1ADHR/O8qZVmRIa8hUx5OW5yDIAL3SBeIhLy4a18RJxuixvq6AsNpPynMBlLEsDCFwn4WMxuGK2yY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vivier.eu; spf=pass smtp.mailfrom=vivier.eu; dkim=pass (2048-bit key) header.d=vivier.eu header.i=laurent@vivier.eu header.b=F6No3Ir+; arc=none smtp.client-ip=217.72.192.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vivier.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivier.eu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivier.eu header.i=laurent@vivier.eu header.b="F6No3Ir+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivier.eu;
	s=s1-ionos; t=1785077437; x=1785682237; i=laurent@vivier.eu;
	bh=VQucAnJH4ck7mAHU/GOsQPUHgJGgj0b98CTyrnSuar4=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=F6No3Ir+YGVBmi6omikqpQ9NUcVcvFsWGfzbdedxQ0nFKE+vHcMyAnJ1xZW2IQOn
	 nJZK8jTnhPNznclStj+1Rb04zYlkYLiAR/Ftkll2wA+Q5bjv2RHA8GTKTMD1GkBUa
	 r7FI0D0d0rswgbpeyDQZO96G95V80W1a1OjE5tEwGZxM4sTF+VQ3sEdGkquOtZA3C
	 5VDXH7j6sSNUA4WPsV7XkP4ZdQoHUaOPkjSFqVurTXbkvmot3lDn/jBYpAN2UgWHF
	 WVI7xmzYZbmWU2hKxNtuvaAHSfsC5/GnFOyfYyQKluhus/+q/+BNqB+e0LP7ETLJn
	 dpPzdV45ykeVd9P+SA==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from client.hidden.invalid by mrelayeu.kundenserver.de (mreue109
 [213.165.67.119]) with ESMTPSA (Nemesis) id 1MfYHW-1xTuVR08Uq-00areL; Sun, 26
 Jul 2026 16:50:37 +0200
Message-ID: <2d9accb5-74fb-4513-a484-7176b57da91e@vivier.eu>
Date: Sun, 26 Jul 2026 16:50:36 +0200
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 21/31] swim: Revisit delays
To: Finn Thain <fthain@linux-m68k.org>, Jens Axboe <axboe@kernel.dk>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
 Joshua Thompson <funaho@jurai.org>, linux-block@vger.kernel.org,
 linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org
References: <cover.1784196135.git.fthain@linux-m68k.org>
 <71ee4a9aea796a452a32366cc1305fe33113c8fa.1784196135.git.fthain@linux-m68k.org>
Content-Language: fr
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; keydata=
 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
In-Reply-To: <71ee4a9aea796a452a32366cc1305fe33113c8fa.1784196135.git.fthain@linux-m68k.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:PvTGewgSLA6eNGZZJrHdXReKqXpbe1GwKW808BJf9ZwK9+8FDil
 OZ5RomC8TGTzHdt5QL5VJUPDRzDy28f8AMKgsndQncPwdF5UqU+xLaMoqVlQl6APaPIa7Sb
 vAXxDt1NtGurWFpWxKIi6fZINBvKE61vAQc1akD/U64LdzCYkOFMLgZD6uQUIBxrM9w5TS+
 2PFA3CuVTqCRfKeeNU7Fg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:pkAvSACFtA4=;mD1obTg98x/SJm3NyFfCqBmnIQp
 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

Le 16/07/2026 =C3=A0 12:02, Finn Thain a =C3=A9crit=C2=A0:
> AFAIK, timing requirements for the various FDHD drive mechanisms aren't
> well documented. But we do have the UPD72070 spec and secondary sources
> like swim3.c and mkLinux source code. This patch is needed to satisfy
> the requirements in the UPD72070 spec and follows mkLinux.
>=20
> Change the LSTRB pulse to 2 microseconds, because this is what mkLinux
> does. Inside Macintosh says, "Hold LSTRB high for at least one usec but
> not more than one msec".
>=20
> When a disk is ejected, pause before de-asserting /ENBL. Wait 150 us aft=
er
> the STEP command for valid signalling. Pause for 1 us after setting the
> step direction before sending the STEP command.
>=20
> Fixes: 8852ecd97488 ("m68k: mac - Add SWIM floppy support")
> Signed-off-by: Finn Thain <fthain@linux-m68k.org>
> ---
>   drivers/block/swim.c | 6 +++++-
>   1 file changed, 5 insertions(+), 1 deletion(-)

Reviewed-by: Laurent Vivier <laurent@vivier.eu>

>=20
> diff --git a/drivers/block/swim.c b/drivers/block/swim.c
> index 77d7ac3765ae..44fe7a79059c 100644
> --- a/drivers/block/swim.c
> +++ b/drivers/block/swim.c
> @@ -290,7 +290,7 @@ static inline void swim_action(struct swim __iomem *=
base, int action)
>   	swim_select(base, action);
>   	udelay(1);
>   	swim_write(base, phase, action | LSTRB);
> -	udelay(1);
> +	udelay(2);
>   	swim_write(base, phase, action);
>   	udelay(1);
>  =20
> @@ -340,6 +340,7 @@ static inline void swim_drive(struct swim __iomem *b=
ase,
>   		swim_write(base, mode0, EXTERNAL_DRIVE);
>   		swim_write(base, mode0, MOTON);
>   	}
> +	udelay(1);
>   }
>  =20
>   static inline void swim_motor(struct swim __iomem *base,
> @@ -358,6 +359,7 @@ static inline void swim_eject(struct swim __iomem *b=
ase)
>   {
>   	swim_action(base, EJECT);
>   	swim_readbit_timeout(base, DISK_IN, false, 2000 * 1000);
> +	msleep(1);
>   }
>  =20
>   static inline void swim_head(struct swim __iomem *base, enum head head=
)
> @@ -371,6 +373,7 @@ static inline void swim_head(struct swim __iomem *ba=
se, enum head head)
>   static inline int swim_step(struct swim __iomem *base)
>   {
>   	swim_action(base, STEP);
> +	udelay(150);
>   	return swim_readbit_timeout_atomic(base, STEP, false, 20 * 1000);
>   }
>  =20
> @@ -401,6 +404,7 @@ static inline int swim_seek(struct swim __iomem *bas=
e, int step)
>   		step =3D -step;
>   	} else if (step > 0)
>   		swim_action(base, SEEK_POSITIVE);
> +	udelay(1);
>  =20
>   	swim_READY_timeout(base);
>  =20

