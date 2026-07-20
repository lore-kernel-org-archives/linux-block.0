Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE245346FA8;
	Mon, 20 Jul 2026 19:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784574153; cv=none; b=iPSgnHk9n9MXB1zLP5PH5WBfalIrCh0w/MXI+UWc1zuFTghvTEkpaoizImUwJY66fJ9AXAcwgkmdapIUFiSOTB8ECG1w5258gV6txwsuBHyfeXdhGhwyWf91DOmU8s6p0YkiyZUlUue8CZQaVkET2EQvqj9LNRoq79zayIUQ3JA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784574153; c=relaxed/simple;
	bh=NarvbAEr8ByGGJ32g6B1eGAqaYnHrdv+Q5zDsx7Z8wk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=umXJ70qUU/jTSvCtmWII3sdeRtrlHAYef6+Y1G8ZBJC60tBg91QyoeGur39mDcZPnAL2WF7K9ckbDXehMh/CN7PENd8gULCaa8ipPQ83nxM3O+/pbNbH1OEZVyNuDFmyHW0nfpnvtDvpQ0EYKAhfLUBUrw+WvanzwA4GVBlXHcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vivier.eu; spf=pass smtp.mailfrom=vivier.eu; dkim=pass (2048-bit key) header.d=vivier.eu header.i=laurent@vivier.eu header.b=tsq+Nf+P; arc=none smtp.client-ip=212.227.17.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vivier.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivier.eu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivier.eu header.i=laurent@vivier.eu header.b="tsq+Nf+P"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivier.eu;
	s=s1-ionos; t=1784574145; x=1785178945; i=laurent@vivier.eu;
	bh=TYI9KBiw8enAz7R+FxFPzxVOHbBfyqpWLoaRitQNSn4=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=tsq+Nf+PNp2+b9X8uL6SRppyU8o1Ac+SDlO9kZPmhbi6QMG3CbybjbduAgkAFPDd
	 kzqYg84ICgTaMES21lzYK7pIHy9HJFRth+SoIGq/10kC3VTEUMs3eNT1XUBDJSJad
	 liaG2l3Q4DcEAJbrA4Zpi/pJ7T2uWQBT41VhagWsmNiX/lpVC7KQ6nFEEmMcZyPEL
	 Go+mYreDB+vl9jrr/JNX4MZACQUvrEFoCvniLOwXkEfQVoVyUh4tmUmUxKr9tIhzC
	 1t4Y03RfEACtLSAM72ieUHgQStlX97AtVLHT7ue8WFUFZFwfmuThGpwjujf694iH7
	 UWpoLZbdDdkAg7PZnQ==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from client.hidden.invalid by mrelayeu.kundenserver.de (mreue107
 [213.165.67.119]) with ESMTPSA (Nemesis) id 1M3UIe-1wlLIB1HaE-00AyVJ; Mon, 20
 Jul 2026 21:02:25 +0200
Message-ID: <d011111d-6962-4fbf-ae87-4f03c9014831@vivier.eu>
Date: Mon, 20 Jul 2026 21:02:24 +0200
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/31] swim: Don't start motor until medium is present
To: Finn Thain <fthain@linux-m68k.org>, Jens Axboe <axboe@kernel.dk>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
 Joshua Thompson <funaho@jurai.org>, linux-block@vger.kernel.org,
 linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org
References: <cover.1784196135.git.fthain@linux-m68k.org>
 <b54674c57285acfba1179eead2c3b7868c1061a0.1784196135.git.fthain@linux-m68k.org>
Content-Language: fr
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; keydata=
 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
In-Reply-To: <b54674c57285acfba1179eead2c3b7868c1061a0.1784196135.git.fthain@linux-m68k.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:XQha+DDPrK52Er4C2UYnk7VoWGLW6uNVAzHQvRtlZ44bkodTgvE
 40hHf18kXk8OnQc7mmQ85Zu/MRbCWntovfBfWaLEug/+d6atlJmsvvjQJNYYvAdTvcHfSfM
 QZk0EqpZHKqBeBOTYRI33Ir5cHbB/nlLH9IM4vjdAdrn48hsqz2K+vSKNKPawD4r09jSTkv
 S0gm9T+yaK+R+CPSCJafw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Cm3CEV5s8pM=;Ia8Ht0n/KXlXAiiGW9JkYhgi/Qr
 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

Le 16/07/2026 =C3=A0 12:02, Finn Thain a =C3=A9crit=C2=A0:
> The spindle motor should not be running when a disk is to be inserted.
> Don't start the motor while the drive is empty.
>=20
> Fixes: 8852ecd97488 ("m68k: mac - Add SWIM floppy support")
> Signed-off-by: Finn Thain <fthain@linux-m68k.org>
> ---
>   drivers/block/swim.c | 6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)

Reviewed-by: Laurent Vivier <laurent@vivier.eu>

> diff --git a/drivers/block/swim.c b/drivers/block/swim.c
> index c49e584cd663..03a89916d4ed 100644
> --- a/drivers/block/swim.c
> +++ b/drivers/block/swim.c
> @@ -630,8 +630,7 @@ static int floppy_open(struct gendisk *disk, blk_mod=
e_t mode)
>   		fs->ref_count++;
>  =20
>   	swim_drive(base, fs->location);
> -	swim_motor(base, ON);
> -	swim_action(base, SETMFM);
> +
>   	if (fs->ejected)
>   		setup_medium(fs);
>   	if (!fs->disk_in) {
> @@ -639,6 +638,9 @@ static int floppy_open(struct gendisk *disk, blk_mod=
e_t mode)
>   		goto out;
>   	}
>  =20
> +	swim_motor(base, ON);
> +	swim_action(base, SETMFM);
> +
>   	set_capacity(fs->disk, fs->total_secs);
>  =20
>   	if (mode & BLK_OPEN_NDELAY)

