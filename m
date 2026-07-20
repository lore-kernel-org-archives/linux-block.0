Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1015391E58;
	Mon, 20 Jul 2026 18:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784571665; cv=none; b=i/dnQqa0Jt8yZlyU5pNhnVrZEW6oDEwo1Q+CIN9auaEPrSNU1OhB6KNvWx6YF2i2AOd9hgIRN99+9oAD7exxU1XJSRUYq3CeQV20p/NLdZB8ogsaQdmQ0eNtT3PiEtIxcYH3LRaJFAycO+63Jih9Y8TU3M8hGoF6b0CjU3hVAuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784571665; c=relaxed/simple;
	bh=aRvLuDb/k36CjbOTyk3JyTCNSGM0gJYfIF0L+GOdxHE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iBEu2U/UKUEmL0XjvU4imtTTDJn0NNRvqdH+F1Yw4U34c+VwfTK4i+kahNGgEYP7nG7ml/9ztmLYULZD6yhEtX+PfFmmatcBADSJB7ape/xfFECTe/5qVj1D9kym8kW3OTFQMtITT2vCWH2mv9vjIhkTfAq7D1InqomVNgZ5NaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vivier.eu; spf=pass smtp.mailfrom=vivier.eu; dkim=pass (2048-bit key) header.d=vivier.eu header.i=laurent@vivier.eu header.b=QIqIN22l; arc=none smtp.client-ip=217.72.192.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vivier.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivier.eu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivier.eu header.i=laurent@vivier.eu header.b="QIqIN22l"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivier.eu;
	s=s1-ionos; t=1784571654; x=1785176454; i=laurent@vivier.eu;
	bh=u8YlWEIOHxcF7x0HRDxnEOeJDCqaIs1YuZYk8KJTbEk=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=QIqIN22l4BnejypRtPOKZIt3ggw80uo5SwCVJl6phDn+480QlO9p0EDWu4Vm2IUG
	 KTQaGRIy11iyt7KBCohSnedBKNw/LPuV65XcWUcA9gSyPfqR1LnbaCOw3EFxgkpiC
	 Ul1OxbNMw8RsUAzBdQjurHRX5UsngaoZspVdxH0K3xpdhPtrdMJ7NrES6CVsKCLku
	 s/5TEnrelMblFqqw6EXQWirkw/QmABGVZoeNHurknM8b69ctHHPE/LX9BvtyOXtGE
	 CwbzxeyjINClSmZtgKCZfokimhvl2Lfwlv9sI4FN7bILuk3SNYULz5fGt7caFQ+M3
	 YSuJ+oKrYho00SOOmA==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from client.hidden.invalid by mrelayeu.kundenserver.de (mreue106
 [213.165.67.119]) with ESMTPSA (Nemesis) id 1MoOpq-1xNPIc2IQq-00k0GT; Mon, 20
 Jul 2026 20:20:54 +0200
Message-ID: <f5ce64bb-2ec9-4d48-a7fd-3a79d45d34e5@vivier.eu>
Date: Mon, 20 Jul 2026 20:20:53 +0200
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/31] swim: Perform ISM/IWM mode switching according to
 specs
To: Finn Thain <fthain@linux-m68k.org>, Jens Axboe <axboe@kernel.dk>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
 Joshua Thompson <funaho@jurai.org>, linux-block@vger.kernel.org,
 linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org
References: <cover.1784196135.git.fthain@linux-m68k.org>
 <05ab4a40a3fc2fb8e80c2ad0e73d0fbc853c95f5.1784196135.git.fthain@linux-m68k.org>
Content-Language: fr
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; keydata=
 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
In-Reply-To: <05ab4a40a3fc2fb8e80c2ad0e73d0fbc853c95f5.1784196135.git.fthain@linux-m68k.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:rU3oZFodBAmCEnxsrEe9SyZTT2pwKkXuF3Qt+DeEHV98KlsUz2F
 7I2eCHGPuvv8UaEXJ/38qLyTLqI7KbipylePEtp8rOhJbWtfr2LcvYcdvqKV9shDm2tizS4
 5pVKm6Ku8SzB4dus3jSR0lzQfbm+6NHBbnCVBNWT8xZDqUkcU1Jz+20C47+lKPHhzW1zWGD
 i0JRX5PVlrndTZRr7XnJw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:YwO29iyiQuA=;5bJkqdPR3HTBr7g8bsXmDLPXQKE
 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

Le 16/07/2026 =C3=A0 12:02, Finn Thain a =C3=A9crit=C2=A0:
> The SWIM spec says, "MOTOREN must be low to switch modes" and "after
> switching from ISM to IWM, the very first command must be a clear L7".
>=20
> The ISM spec says, MOTOREN "must not be cleared until after the Action
> bit is cleared". Perform those operations in the correct sequence.
>=20
> When switching to ISM mode, the Mode register has to be selected with a
> particular sequence of bit flips. Set q7 low then q6 low then mtrOff.
>=20
> Fixes: 8852ecd97488 ("m68k: mac - Add SWIM floppy support")
> Signed-off-by: Finn Thain <fthain@linux-m68k.org>
> ---
>   drivers/block/swim.c | 10 +++++++---
>   1 file changed, 7 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/block/swim.c b/drivers/block/swim.c
> index f9c59282b81f..7499ff250ca7 100644
> --- a/drivers/block/swim.c
> +++ b/drivers/block/swim.c
> @@ -149,6 +149,7 @@ struct iwm {
>   #define ACTION		0x08
>   #define WRITE_MODE	0x10
>   #define HEDSEL		0x20
> +#define ISM_SELECT	0x40
>   #define MOTON		0x80
>  =20
>   /*--------------------------------------------------------------------=
=2D-------*/
> @@ -223,18 +224,21 @@ extern int swim_read_sector_data(struct swim __iom=
em *base,
>   static DEFINE_MUTEX(swim_mutex);
>   static inline void set_swim_mode(struct swim __iomem *base, int enable=
)
>   {
> -	struct iwm __iomem *iwm_base;
> +	struct iwm __iomem *iwm_base =3D (struct iwm __iomem *)base;
>   	unsigned long flags;
>  =20
>   	if (!enable) {
> -		swim_write(base, mode0, 0xf8);
> +		swim_write(base, mode0, ACTION);
> +		swim_write(base, mode0, ENBL1 | ENBL2 | MOTON);
> +		swim_write(base, mode0, ISM_SELECT);
> +		iwm_read(iwm_base, q7L);
>   		return;
>   	}
>  =20
> -	iwm_base =3D (struct iwm __iomem *)base;
>   	local_irq_save(flags);
>  =20
>   	iwm_read(iwm_base, q7L);
> +	iwm_read(iwm_base, q6L);
>   	iwm_read(iwm_base, mtrOff);
>   	iwm_read(iwm_base, q6H);
>  =20

Reviewed-by: Laurent Vivier <laurent@vivier.eu>

