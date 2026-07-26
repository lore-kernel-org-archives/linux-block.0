Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71DC11F419A;
	Sun, 26 Jul 2026 14:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785077326; cv=none; b=EcO+OT4MUKeXLYy/Wv1rjpD+cnbBnBF3HKxd9A+s82nCZ82ZHk36xZ/Il45nx/cR5OnT0JGkkvlMXxLtruJ0j5XF+ObSXSna1pWHeOY+VO5evvlSkrOLUTpam92j3ZpRBh0Yw/5/28DLy3e9eTT9inDyDWmAavqkusWC8OJT7iQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785077326; c=relaxed/simple;
	bh=9gyEWOfgN2YoZ8IJHSoxfcbee3uP8QQrBnFaa1rPjG8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pubYR2iltFiAT0DP38ukOia3n8iS9HCLSDgzKckEN+a9ZLm/BkMrmiLHnEBOIQ8/TBU7AOKP7P+89EbPmNGVe7uJxt1DLo842lod4g/7pGpEjyLia2b6pdOr83ldnn3C7Xa4V8uMkORuIyOG6zjrOX92iTdZeGioF/awsCVlMqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vivier.eu; spf=pass smtp.mailfrom=vivier.eu; dkim=pass (2048-bit key) header.d=vivier.eu header.i=laurent@vivier.eu header.b=LFqSShbg; arc=none smtp.client-ip=212.227.17.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vivier.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivier.eu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivier.eu header.i=laurent@vivier.eu header.b="LFqSShbg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivier.eu;
	s=s1-ionos; t=1785077309; x=1785682109; i=laurent@vivier.eu;
	bh=jDfvjNkFiQ+OasTIFOxuiHP06iaOb2UHNsfTATkk9Lo=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=LFqSShbgVnqkAkWIO8JZguhMLZAS11cQD42r8jxJVpIWT/zB1SCYEolYDVDH3j+Z
	 YzFpP+cWUoTZe8fo59t7hokne8KYYKDpek23hiBszqAtMDQCifvWBeMpCGyzJj/V5
	 HyptyRyQJ0BmYvDNeNNEUxSOqSYmf8sTa1Qv0TK5k0fCdaY38gubX7tnJQLNTJSZK
	 IEyKlX76j1QQ4fIDs/Q51UnoS4U+E3aGti6ABWNoRjzOG4S9al/4Hu1cZhzBZh1qR
	 evkqNLtFdPkYjHtLxP95/OwvH3OCoc07xbwiB9kxPDEL6OJ4s1ybX+a3f1zS4kEbk
	 /T7BRuPhW21oXJyMTg==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from client.hidden.invalid by mrelayeu.kundenserver.de (mreue108
 [213.165.67.119]) with ESMTPSA (Nemesis) id 1Mzz2e-1x8X8d3Uxi-015roa; Sun, 26
 Jul 2026 16:48:29 +0200
Message-ID: <39a7d036-8459-4d01-9114-6c5545b9f303@vivier.eu>
Date: Sun, 26 Jul 2026 16:48:29 +0200
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 20/31] swim: Check drive ready bit
To: Finn Thain <fthain@linux-m68k.org>, Jens Axboe <axboe@kernel.dk>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
 Joshua Thompson <funaho@jurai.org>, linux-block@vger.kernel.org,
 linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org
References: <cover.1784196135.git.fthain@linux-m68k.org>
 <627247b3983941eef4d5a4ccf60ba7963b46e887.1784196135.git.fthain@linux-m68k.org>
Content-Language: fr
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; keydata=
 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
In-Reply-To: <627247b3983941eef4d5a4ccf60ba7963b46e887.1784196135.git.fthain@linux-m68k.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:jMOrLgDvJxzvd71FjJqqqK3wrsq45w02Pc5NWMCm6Tj1H+zAGtU
 4rYS/DTOnk9QrJYk9g/Ej2eQKkl+mUcR5NR+NA+X1Z0eq3I4M6P9TtTQbc1XddUt5PCOvCl
 NUfFiJYtrWthTWzVFJV2+JTtMT2o4NHOpKNJeFAzFvMbn1NC+zoao5VL7BHtVDnBDYeFUBS
 TnFgvZHaMGOl5qQ56D/2g==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:FCWhGgJruGQ=;zG4CVyZrO2bJdDHh6eJSPjOHePu
 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
 LUdLl9XAq41OYdSIdVEKX0ENjcmfE=

Le 16/07/2026 =C3=A0 12:02, Finn Thain a =C3=A9crit=C2=A0:
> The drive provides a readiness signal that has to be tested before
> certain commands are issued to the drive. Rename the SEEK_COMPLETE flag
> as READY because that's how it's known in the documentation as well as
> the mkLinux source code.
>=20
> Poll for that signal after stepping the heads and also after switching
> to MFM mode, as that's what mkLinux does. Check for readiness when
> stepping because testing shows that some drives require this.
>=20
> Fixes: 8852ecd97488 ("m68k: mac - Add SWIM floppy support")
> Signed-off-by: Finn Thain <fthain@linux-m68k.org>
> ---
>   drivers/block/swim.c | 29 ++++++++++++++++++++++-------
>   1 file changed, 22 insertions(+), 7 deletions(-)

Reviewed-by: Laurent Vivier <laurent@vivier.eu>

>=20
> diff --git a/drivers/block/swim.c b/drivers/block/swim.c
> index c10ad1266c3b..77d7ac3765ae 100644
> --- a/drivers/block/swim.c
> +++ b/drivers/block/swim.c
> @@ -117,7 +117,7 @@ struct iwm {
>   #define TACHO		0x1F3
>   #define READ_DATA_1	0x1F4
>   #define GCR_MODE	0x1F5
> -#define SEEK_COMPLETE	0x1F6
> +#define READY		0x1F6
>   #define TWOMEG_MEDIA	0x1F7
>  =20
>   /* Bits in handshake register */
> @@ -316,6 +316,14 @@ static inline bool swim_readbit(struct swim __iomem=
 *base, int bit)
>   #define swim_readbit_timeout_atomic(base, bit, val, timeout_us) \
>   	poll_timeout_us_atomic(, swim_readbit(base, bit) =3D=3D val, 1, timeo=
ut_us, false)
>  =20
> +#define swim_READY_timeout(base) \
> +({ \
> +	int ret =3D swim_readbit_timeout(base, READY, true, 1000 * 1000); \
> +	if (ret) \
> +		printk(KERN_DEBUG "%s: drive not ready\n", __func__); \
> +	ret; \
> +})
> +
>   static inline void swim_drive(struct swim __iomem *base,
>   			      enum drive_location location)
>   {
> @@ -354,8 +362,6 @@ static inline void swim_eject(struct swim __iomem *b=
ase)
>  =20
>   static inline void swim_head(struct swim __iomem *base, enum head head=
)
>   {
> -	/* wait drive is ready */
> -
>   	if (head =3D=3D UPPER_HEAD)
>   		swim_select(base, READ_DATA_1);
>   	else if (head =3D=3D LOWER_HEAD)
> @@ -390,20 +396,25 @@ static inline int swim_track00(struct swim __iomem=
 *base)
>  =20
>   static inline int swim_seek(struct swim __iomem *base, int step)
>   {
> -	if (step =3D=3D 0)
> -		return 0;
> -
>   	if (step < 0) {
>   		swim_action(base, SEEK_NEGATIVE);
>   		step =3D -step;
> -	} else
> +	} else if (step > 0)
>   		swim_action(base, SEEK_POSITIVE);
>  =20
> +	swim_READY_timeout(base);
> +
> +	if (step =3D=3D 0)
> +		return 0;
> +
>   	for ( ; step > 0; step--) {
>   		if (swim_step(base))
>   			return -1;
>   	}
>  =20
> +	msleep(30);
> +	swim_READY_timeout(base);
> +
>   	return 0;
>   }
>  =20
> @@ -485,6 +496,8 @@ static blk_status_t floppy_read_sectors(struct flopp=
y_state *fs,
>  =20
>  =20
>   	swim_drive(base, fs->location);
> +	swim_READY_timeout(base);
> +
>   	for (i =3D req_sector; i < req_sector + sectors_nb; i++) {
>   		int x;
>   		track =3D i / fs->secpercyl;
> @@ -605,6 +618,8 @@ static int floppy_open(struct gendisk *disk, blk_mod=
e_t mode)
>  =20
>   	swim_motor(base, ON);
>   	swim_action(base, SETMFM);
> +	msleep(30);
> +	swim_READY_timeout(base);
>  =20
>   	set_capacity(fs->disk, fs->total_secs);
>  =20

