Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2359478E39;
	Mon, 20 Jul 2026 18:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784572273; cv=none; b=oxEXH3AL+dA86hKCmA71UcV0HjVj3b10cOWxabw8Ipmv5hRVTMOsXoQFXC/QzAaZ5ho69ybQl0SWRexbngpuIFGFy61c5QyGl7wvAYZPbmp4oCCElBATm1pqF8h6qwU0ktBGVzpgTueWYItJ1dNUqBfTwk9DGT08r7aKFM3hw30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784572273; c=relaxed/simple;
	bh=K3nl+ykPsZzpl7njS0jfjLzad8a+/vs6BPtCN4B39Z0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TUAHxQzrOyAbXSxSd8b2YqerCJdHY/5W2vuTmsyyjBqtMczAT6UCCVmBXqw+BRwze244gIcozJt81kWHhvDHUxwdnAEG9pa8/+BEBzRN8Y5nagtqtUHmU5wpqZMLjlWIxQjqmyXhkmK/Lqft9KaoIVQKSuxEMnPK4rXGEV4Rjhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vivier.eu; spf=pass smtp.mailfrom=vivier.eu; dkim=pass (2048-bit key) header.d=vivier.eu header.i=laurent@vivier.eu header.b=ugV/xZWP; arc=none smtp.client-ip=212.227.17.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vivier.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivier.eu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivier.eu header.i=laurent@vivier.eu header.b="ugV/xZWP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivier.eu;
	s=s1-ionos; t=1784572263; x=1785177063; i=laurent@vivier.eu;
	bh=p2O2gXV0Ylre/q8y0+sIgD6wS0wQwtYaxRKcmgGI558=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=ugV/xZWPXyt9cPqImapc/TdfIjcIdpAJy6GKlAFDEtsULViKZy3dagieqRxwEi3+
	 H6QdA/tNMzrWl3p8F/XAHVC5zRrvj2Ruz4VEX4l3shGayf3qnevimr3djcf2ZYcAs
	 K/2Hx82oeWsLrWhj2ElC08Df+J4MTNRewNzvlaqlZ+NIoAP8L6AXkLyBNIOviXhXa
	 rzRXcWiX4abIsEPWHdHqyI/j0Oc1vhPAt7xJnIxCoEvTBys8DFa3NyUr0QeI8ii4B
	 I1eN8FlFsdFhuaSmliurbMtL+FLzTOICzTdJ/LlaiAntUyDiptz0m0V+kbhYdshTw
	 swX/Fkraz5ddLkjg1A==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from client.hidden.invalid by mrelayeu.kundenserver.de (mreue107
 [213.165.67.119]) with ESMTPSA (Nemesis) id 1M4JVv-1wm9kU2yjx-00A93q; Mon, 20
 Jul 2026 20:31:03 +0200
Message-ID: <d0d22009-14e4-4f26-b5b7-39d9335ef812@vivier.eu>
Date: Mon, 20 Jul 2026 20:31:03 +0200
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/31] swim: Configure parameter memory
To: Finn Thain <fthain@linux-m68k.org>, Jens Axboe <axboe@kernel.dk>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
 Joshua Thompson <funaho@jurai.org>, linux-block@vger.kernel.org,
 linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org
References: <cover.1784196135.git.fthain@linux-m68k.org>
 <e18df7f66a9159421693b3e95fc6805b3bcc90e1.1784196135.git.fthain@linux-m68k.org>
Content-Language: fr
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; keydata=
 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
In-Reply-To: <e18df7f66a9159421693b3e95fc6805b3bcc90e1.1784196135.git.fthain@linux-m68k.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:NvOrEdpMdMM4psy8bTxCKDP0/RF/x6fYoABMNk3FFwArzSkMVTP
 HPuDyH/zFwubt0qVVaMwE47M6bS7k9ZWQRfqe8CA49GuOut7FtX9XNFIzFAPw2wz6qElhI0
 kB3DhpckGWTNkxu5+ninXsuEVvTNRO7GS9SrKDfCoBS7/DdVxMEEmHndSA2YSvv2X9LmEyo
 RDluRp16gVbL8H7aAaPJg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:XX7+5xTwXMw=;jtT1Pkh4yp4TzHp5FmgKrpUQgqr
 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

Le 16/07/2026 =C3=A0 12:02, Finn Thain a =C3=A9crit=C2=A0:
> The original SWIM chip has a 16 byte memory to store parameters which
> control read/write timing. The SWIM 2 chip retains the last 4 parameters
> which control write pre-compensation, but omits the first 12. Hence
> SWIM 2 can perform reads without any parameter memory setup but SWIM 1
> cannot.
>=20
> Configure the SWIM parameter memory with the appropriate values so that
> SWIM 1 can read too. The parameters used here were observed in SWIM chip
> memory, using Macsbug, while MacOS was reading from an MFM floppy disk.
>=20
> Fixes: 8852ecd97488 ("m68k: mac - Add SWIM floppy support")
> Signed-off-by: Finn Thain <fthain@linux-m68k.org>
> ---
>   drivers/block/swim.c | 13 +++++++++++++
>   1 file changed, 13 insertions(+)
>=20

Reviewed-by: Laurent Vivier <laurent@vivier.eu>

> diff --git a/drivers/block/swim.c b/drivers/block/swim.c
> index 7499ff250ca7..481fb1e63ac1 100644
> --- a/drivers/block/swim.c
> +++ b/drivers/block/swim.c
> @@ -796,6 +796,17 @@ static void swim_cleanup_floppy_disk(struct floppy_=
state *fs)
>   	blk_mq_free_tag_set(&fs->tag_set);
>   }
>  =20
> +static void swim_set_parameters(struct swim __iomem *base)
> +{
> +	unsigned int i;
> +	static const u8 mem[] =3D { 0x18, 0x41, 0x2e, 0x2e, 0x18, 0x18, 0x1b, =
0x1b,
> +				  0x2f, 0x2f, 0x19, 0x19, 0x97, 0x1b, 0x57, 0x3b, };
> +
> +	swim_write(base, mode0, 0); /* reset parameter memory index */
> +	for (i =3D 0; i < 16; ++i)
> +		swim_write(base, parameter, mem[i]);
> +}
> +
>   static int swim_floppy_init(struct swim_priv *swd)
>   {
>   	struct queue_limits lim =3D {
> @@ -805,6 +816,8 @@ static int swim_floppy_init(struct swim_priv *swd)
>   	int drive;
>   	struct swim __iomem *base =3D swd->base;
>  =20
> +	swim_set_parameters(base);
> +
>   	/* scan floppy drives */
>  =20
>   	swim_drive(base, INTERNAL_DRIVE);

