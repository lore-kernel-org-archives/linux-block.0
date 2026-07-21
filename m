Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D9703290B7;
	Tue, 21 Jul 2026 06:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784614218; cv=none; b=m5roHH1lb2fTAYPNYL/Dn2Y3IfiJJU1FmFuz71oF3vRGWQT0C+2Nx39fB6yCNGY6rKCBRaC/33X2gHOj/XKuBLpzLvX/wtNt4wUDmft7QcKTEqJd8/WG1iQqDUAxCJmpjN4Xlkg/Jc+eLN7s0Da/COvYuHx4q/MyDhdGrZHrh20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784614218; c=relaxed/simple;
	bh=Ez0kmVBDVgH/czqbSKTwTrF7hNc3+b1SIIrtv49gxNk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rBcp5XAWgfkxsQFmzbRQ2qxHYZ8ounrW3aU3z42s+MSNki5iCVdDZbaz1b/CL29FHyt+SYOiPc9RPEZ6rMlyJBBiZHEvIW+kLVC77RS8POxuAlLIJCb20N8YypdicI3CuNV79nA+bQnLL41sVu8ueJpVAwj4waf1MAXUUlgXRmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vivier.eu; spf=pass smtp.mailfrom=vivier.eu; dkim=pass (2048-bit key) header.d=vivier.eu header.i=laurent@vivier.eu header.b=CrWzPM+h; arc=none smtp.client-ip=212.227.17.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vivier.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivier.eu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivier.eu header.i=laurent@vivier.eu header.b="CrWzPM+h"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivier.eu;
	s=s1-ionos; t=1784614213; x=1785219013; i=laurent@vivier.eu;
	bh=+sPjVGOFsIs4O89gUm/+dj3GhZce6LDyhz7hqBx9UXI=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=CrWzPM+hWSHQsNG9pdWpEK01PC3RuyWwckYhLlLf8k3a5/fy95jBtbYy6pkO5q2G
	 hNpWGYjXkRE6dmraAlKK41Zp8u+U6tjjYPdk42U4pzp1kb/bK57ncBkSyTg4vOzHB
	 HHKO+fIRfEK2/QW/yfHOc/OlfLHiRIo5ozSwLwZZJkhC4cnjmICLw45hwi8bxUAZK
	 wNO7DMJGibUG7YrNFhkL1mqmTy28VLHMmXOGAtfeeAgFQ4G/H+0WavlO4a+rx8Fp6
	 wf2mePwftJlIbc6GxABgnI1na8Hkl2lw7mPgxtO/9VgUP11Uz9120MxGO6fbsLjgk
	 COU1ahE8b/Q/I/+o+Q==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from client.hidden.invalid by mrelayeu.kundenserver.de (mreue106
 [213.165.67.119]) with ESMTPSA (Nemesis) id 1M3UEW-1wlViR3E3e-008Egh; Tue, 21
 Jul 2026 08:10:13 +0200
Message-ID: <58552253-50c1-4add-82d7-567526a85d91@vivier.eu>
Date: Tue, 21 Jul 2026 08:10:13 +0200
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 18/31] swim: Remove redundant RELAX actions
To: Finn Thain <fthain@linux-m68k.org>, Jens Axboe <axboe@kernel.dk>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
 Joshua Thompson <funaho@jurai.org>, linux-block@vger.kernel.org,
 linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org
References: <cover.1784196135.git.fthain@linux-m68k.org>
 <46e56724a3d8a9268ff2d086e21e23b6a0b2d97e.1784196135.git.fthain@linux-m68k.org>
Content-Language: fr
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; keydata=
 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
In-Reply-To: <46e56724a3d8a9268ff2d086e21e23b6a0b2d97e.1784196135.git.fthain@linux-m68k.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:COeJ0ayWe7OVDsLvhin/4ssoX0Ar5D0yEpbBpMF0SwI7rNU/2SZ
 X9tPbai2hE+Z+kYfRHQld4KNyJKWYnznbrJUinfg2E4pI+gsQVeRT25HM+UoQQKjYQ4FWUB
 ZisWA7+gDsAKQNXN+mQVjzgAgXyXiuKquP8l9Sfsyh9E34FTfdM8W+az8JhMBsWMxNGMHxU
 tHfoQLEgvdtvtyRf6+6MQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:qa6JWVoF8uw=;/x/tm/S9fBsW1EEWXmp29rHQFNB
 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

Le 16/07/2026 =C3=A0 12:02, Finn Thain a =C3=A9crit=C2=A0:
> Wherever we have a swim_select() or swim_readbit() call there is an
> implicit RELAX. That means the caller doesn't have to do it. Remove the
> redundant code.
>=20
> BTW, Inside Macintosh says, "Be sure [...] that CA0 and CA1 are set high
> before changing SEL." Hence the RELAX found in swim_select(). The SwimII=
I
> driver in mkLinux also has that. But the swim3.c driver in Linux is odd:
> it scatters RELAX actions around as though SEL was not actually under it=
s
> control... In anycase, swim.c really does control SEL so there's no need
> for that here.
>=20
> Signed-off-by: Finn Thain <fthain@linux-m68k.org>
> ---
>   drivers/block/swim.c | 8 +-------
>   1 file changed, 1 insertion(+), 7 deletions(-)
>=20

Reviewed-by: Laurent Vivier <laurent@vivier.eu>

> diff --git a/drivers/block/swim.c b/drivers/block/swim.c
> index 6f93ebaaffb7..b4bf96a788db 100644
> --- a/drivers/block/swim.c
> +++ b/drivers/block/swim.c
> @@ -336,7 +336,6 @@ static inline void swim_motor(struct swim __iomem *b=
ase,
>   		swim_action(base, MOTOR_ON);
>  =20
>   		for (i =3D 0; i < 2*HZ; i++) {
> -			swim_select(base, RELAX);
>   			if (swim_readbit(base, MOTOR_ON))
>   				break;
>   			set_current_state(TASK_INTERRUPTIBLE);
> @@ -344,7 +343,7 @@ static inline void swim_motor(struct swim __iomem *b=
ase,
>   		}
>   	} else if (action =3D=3D OFF) {
>   		swim_action(base, MOTOR_OFF);
> -		swim_select(base, RELAX);
> +		swim_write(base, phase, RELAX);
>   	}
>   }
>  =20
> @@ -355,13 +354,11 @@ static inline void swim_eject(struct swim __iomem =
*base)
>   	swim_action(base, EJECT);
>  =20
>   	for (i =3D 0; i < 2*HZ; i++) {
> -		swim_select(base, RELAX);
>   		if (!swim_readbit(base, DISK_IN))
>   			break;
>   		set_current_state(TASK_INTERRUPTIBLE);
>   		schedule_timeout(1);
>   	}
> -	swim_select(base, RELAX);
>   }
>  =20
>   static inline void swim_head(struct swim __iomem *base, enum head head=
)
> @@ -385,7 +382,6 @@ static inline int swim_step(struct swim __iomem *bas=
e)
>   		set_current_state(TASK_INTERRUPTIBLE);
>   		schedule_timeout(1);
>  =20
> -		swim_select(base, RELAX);
>   		if (!swim_readbit(base, STEP))
>   			return 0;
>   	}
> @@ -399,8 +395,6 @@ static inline int swim_track00(struct swim __iomem *=
base)
>   	swim_action(base, SEEK_NEGATIVE);
>  =20
>   	for (try =3D 0; try < 100; try++) {
> -
> -		swim_select(base, RELAX);
>   		msleep(3);
>  =20
>   		if (swim_readbit(base, TRACK_ZERO))

