Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C8E33612F4;
	Mon, 20 Jul 2026 18:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784571053; cv=none; b=TwXToucclSjIbMqUfLFPuSjje+jkKBc+P4qwAHBNkM3PRnON6tv+aWDj9dK6MT+MxUQnmW/Y1PyYRpLjApkVnvY5nZ89A22H+FS9pn7f0Vl77Ct1VeiNWIfKUqrIhox5R/4DEiFiV+TMoL5+eiC2U4rYv2FLu07WOOBvpXG/OFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784571053; c=relaxed/simple;
	bh=SrcvSWApBMQsf1Y4yuwSaHILY+Vjyb+mFmuU/2R48X8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WzXvyJ8ENKptvAqhrjKyjmYXhLSrttWAMYykrqlKhGnryXmgNa4aVZTAZh3yo7chBf/pChptIoEgWK8SZokqg+GmWhm04ehPOPAlvtvGfQ/S1l4N+J7YM8M4sylXxarXSw3Xq0zMsAlvFhvCzQeatQKtLF0cqskiJKfVyXaFh4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vivier.eu; spf=pass smtp.mailfrom=vivier.eu; dkim=pass (2048-bit key) header.d=vivier.eu header.i=laurent@vivier.eu header.b=NI5hVn2I; arc=none smtp.client-ip=212.227.17.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vivier.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivier.eu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivier.eu header.i=laurent@vivier.eu header.b="NI5hVn2I"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivier.eu;
	s=s1-ionos; t=1784571043; x=1785175843; i=laurent@vivier.eu;
	bh=4n0bVAGooJQxTsucxNapc/D6DQHkh6TlqC/upEyYYfA=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=NI5hVn2IkSV4f+BqTlT2HKot8v4YtYmw0wWHBOiAAsp0d9tBHHN6EOVaPLhiJma6
	 Aeh5Y+QKOc7xEzc6DqwC4tGX45wLxQf/uT1v/xhIlSuxc4eoYzwr3b0y2XlneyrPU
	 Zpn/4+kLoEoAJlpVptXhdNdy8DpWlruXS2SzoIZ82LU4xM1W2BrIdFIIk25sdLK+b
	 ioblUf7Fou2ljx+ssqhlZGoBAPk0VHDIv30kH1wEArTMViVtWPWnFgevPIhZ98yBn
	 Z4Zmm6uBuUonhySkcvzLuwAPCSktX3gf6c23UycZe9bE6w8w1kvYtFbS674Rz+hIY
	 AlEO7lgT0RUYZWNvaw==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from client.hidden.invalid by mrelayeu.kundenserver.de (mreue107
 [213.165.67.119]) with ESMTPSA (Nemesis) id 1MuUWi-1x2zrM3q4I-011YiT; Mon, 20
 Jul 2026 20:10:42 +0200
Message-ID: <dec2c403-7161-458a-b5f2-cd1a02b1a6f2@vivier.eu>
Date: Mon, 20 Jul 2026 20:10:41 +0200
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/31] swim: Don't disable drive after every sector
To: Finn Thain <fthain@linux-m68k.org>, Jens Axboe <axboe@kernel.dk>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
 Joshua Thompson <funaho@jurai.org>, linux-block@vger.kernel.org,
 linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org
References: <cover.1784196135.git.fthain@linux-m68k.org>
 <5d8b1ca2808d723fc58aaa7be4bab7e4d9eb946c.1784196135.git.fthain@linux-m68k.org>
Content-Language: fr
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; keydata=
 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
In-Reply-To: <5d8b1ca2808d723fc58aaa7be4bab7e4d9eb946c.1784196135.git.fthain@linux-m68k.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:PRqgXoYdY6wDgSHHf4QWDB8R5yWqlIjW2U1I/iXW2HBzagPJAeU
 1e2kIjr+6w7H3+pOpPBny72B6OSSDiOmbuvH7fTVMiOT6DmNOcZizpRqHSEl3j5hHdoVuDt
 VgpmArx//VLXMTqqxdpqJFFeqVUR7PxF3Efar/2/S3do/8aL0eREW5MUTgT7dH5lAO1SThG
 TPrdIy4RMUcPMHIq+SMyg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:xkGk9RXg5tE=;JO/9NKTAhHLskU9ecDWJMwR1kal
 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
 =

Le 16/07/2026 =C3=A0 12:02, Finn Thain a =C3=A9crit=C2=A0:
> This fixes multi-sector reads on a Sony drive. The Mitsubishi drive
> doesn't seem to care either way.
>=20
> Fixes: 8852ecd97488 ("m68k: mac - Add SWIM floppy support")
> Signed-off-by: Finn Thain <fthain@linux-m68k.org>
> ---
>   drivers/block/swim.c | 4 ----
>   1 file changed, 4 deletions(-)
>=20
> diff --git a/drivers/block/swim.c b/drivers/block/swim.c
> index 2a400e544959..f9c59282b81f 100644
> --- a/drivers/block/swim.c
> +++ b/drivers/block/swim.c
> @@ -473,8 +473,6 @@ static inline int swim_read_sector(struct floppy_sta=
te *fs,
>   	short i;
>  =20
>   	swim_track(fs, track);
> -
> -	swim_write(base, mode1, MOTON);
>   	swim_head(base, side);
>   	swim_write(base, mode0, side);
>  =20
> @@ -490,8 +488,6 @@ static inline int swim_read_sector(struct floppy_sta=
te *fs,
>   	}
>   	local_irq_restore(flags);
>  =20
> -	swim_write(base, mode0, MOTON);
> -
>   	if ((header.side !=3D side)  || (header.track !=3D track) ||
>   	     (header.sector !=3D sector))
>   		return 0;

Reviewed-by: Laurent Vivier <laurent@vivier.eu>

