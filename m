Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D6663C3BE0;
	Sun, 26 Jul 2026 15:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785080717; cv=none; b=jNUNLXnMrmtYCoZmdfH3L2/dQ8kEPrRb5+Mn/XT8ec1T/JofZNbNN3VFj09pFGDb631xVApQXxdjPq2gLFbYX1jKbM53TLZzjWDZJroLxybak+ow2VzjVP9AjmIc3FmFytV0NfruSq3C41SZXbaHGE3X/H/gieDV8QNzRGktYp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785080717; c=relaxed/simple;
	bh=H2qNQ8oAvDhXqQN1cAkSRyMOHIihYX7k1dLHRrj30CA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lOw6bR87CMiK1Q5Oj8MTSEKUL9mVdhNILYU9sd+hzmdE0/WGDxpD66ifxMKldcV64czSYy1birs43ZEqT+6nKk6Nis8RThgN9NU6SA/1j9Q6KSqmlXwGLuOj5IYb5ORKoV9kHbmhlp4Mg+EUiWWZWS5jL0Eg6TOcA9kRqrhSCdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vivier.eu; spf=pass smtp.mailfrom=vivier.eu; dkim=pass (2048-bit key) header.d=vivier.eu header.i=laurent@vivier.eu header.b=q/4ZP1DB; arc=none smtp.client-ip=212.227.17.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vivier.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivier.eu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivier.eu header.i=laurent@vivier.eu header.b="q/4ZP1DB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivier.eu;
	s=s1-ionos; t=1785080707; x=1785685507; i=laurent@vivier.eu;
	bh=xAuAflx5WoYvb/7BGHEQE4UATb+tkAu4hFFftt0G7hg=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=q/4ZP1DB4gKoVXO+Cq376zTjlixjSOMU6OuyzyrgY+H+mHo9kyvSIKmcGUnllS2G
	 h+QcdHP4BQBbdgSXLBXvapeGQH2fh9tpAVJy8kp8dKAnWIyASr4ue55vaRImV77aC
	 U/dahBK1Wsp5+T0cjBDgUwrmdAyj1VkEvnD2Ad5aPfH0kEl7cHyQU/i8c+pNuzwGW
	 paA43NM+C1Scgf+8c6lqD3FHn15/yOAUh9BjIeuRAmq0/QnD9eGoCHzcqwYGLhJ2y
	 +0fyXYrffTTele4JyuSje43T0q/UoIDwDtlr1bTgkGzDcAXeq25kBTKaIgyTXnvxz
	 8Z+175iFBiYZqBcR/A==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from client.hidden.invalid by mrelayeu.kundenserver.de (mreue108
 [213.165.67.119]) with ESMTPSA (Nemesis) id 1MK3a4-1wX1sz1CsI-00UKwX; Sun, 26
 Jul 2026 17:45:07 +0200
Message-ID: <249db6ef-b752-4cf5-9350-a7660e29d735@vivier.eu>
Date: Sun, 26 Jul 2026 17:45:06 +0200
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 28/31] swim: Clean up whitespace
To: Finn Thain <fthain@linux-m68k.org>, Jens Axboe <axboe@kernel.dk>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
 Joshua Thompson <funaho@jurai.org>, linux-block@vger.kernel.org,
 linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org
References: <cover.1784196135.git.fthain@linux-m68k.org>
 <638c40ba880bd6b2ed1641d54eb65be14e89e3da.1784196135.git.fthain@linux-m68k.org>
Content-Language: fr
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; keydata=
 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
In-Reply-To: <638c40ba880bd6b2ed1641d54eb65be14e89e3da.1784196135.git.fthain@linux-m68k.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:dWPO2Tu9lNihAuDU3BZvsAjwnUH37TkUu4raFdiM1n+lYNigRDt
 vafdWddFs2jnlTe/pI0W+voc7n7eaEkvoUF3kvGOIQ8Jw9quXZByRDUmzmVDj9oZzu9adQi
 hUwjnyCPAsTlcRYDZpanuLlMjzJoRuwjzv+HZhd23DXGWSaCtxuyD7XQJMsqHIrH+jpL2HQ
 mmz0ch3K0MdwwNDT342Cw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:on+TM359ap0=;RjI5Gip3IYOGmHNqVQk+2B2RFhU
 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

Le 16/07/2026 =C3=A0 12:02, Finn Thain a =C3=A9crit=C2=A0:
> No functional changes.
>=20
> Signed-off-by: Finn Thain <fthain@linux-m68k.org>
> ---
>   drivers/block/swim.c     | 46 +++++++++++++++++++++-------------------
>   drivers/block/swim_asm.S | 15 ++-----------
>   2 files changed, 26 insertions(+), 35 deletions(-)

Reviewed-by: Laurent Vivier <laurent@vivier.eu>

>=20
> diff --git a/drivers/block/swim.c b/drivers/block/swim.c
> index 9661d8f7a5ed..406792952e7f 100644
> --- a/drivers/block/swim.c
> +++ b/drivers/block/swim.c
> @@ -2,7 +2,7 @@
>   /*
>    * Driver for SWIM (Sander Woz Integrated Machine) floppy controller
>    *
> - * Copyright (C) 2004,2008 Laurent Vivier <Laurent@lvivier.info>
> + * Copyright (C) 2004, 2008 Laurent Vivier <Laurent@lvivier.info>
>    *
>    * based on Alastair Bridgewater SWIM analysis, 2001
>    * based on SWIM3 driver (c) Paul Mackerras, 1996
> @@ -69,7 +69,7 @@ struct swim {
>   	REG(read_handshake)
>   } __attribute__((packed));
>  =20
> -#define swim_write(base, reg, v) 	out_8(&(base)->write_##reg, (v))
> +#define swim_write(base, reg, v)	out_8(&(base)->write_##reg, (v))
>   #define swim_read(base, reg)		in_8(&(base)->read_##reg)
>  =20
>   /* IWM registers */
> @@ -93,7 +93,7 @@ struct iwm {
>   	REG(q7H)
>   } __attribute__((packed));
>  =20
> -#define iwm_write(base, reg, v) 	out_8(&(base)->reg, (v))
> +#define iwm_write(base, reg, v)		out_8(&(base)->reg, (v))
>   #define iwm_read(base, reg)		in_8(&(base)->reg)
>  =20
>   /* bits in phase register */
> @@ -165,23 +165,23 @@ struct floppy_state {
>   	/* physical properties */
>  =20
>   	enum drive_location location;	/* internal or external drive */
> -	int		 head_number;	/* single- or double-sided drive */
> +	int head_number;		/* single- or double-sided drive */
>  =20
>   	/* media */
>  =20
> -	int		 disk_in;
> -	int		 ejected;
> -	enum media_type	 type;
> -	int		 write_protected;
> +	int disk_in;
> +	int ejected;
> +	enum media_type type;
> +	int write_protected;
>  =20
> -	unsigned int	 total_secs;
> -	unsigned int	 secpercyl;
> -	unsigned int	 secpertrack;
> +	unsigned int total_secs;
> +	unsigned int secpercyl;
> +	unsigned int secpertrack;
>  =20
>   	/* in-use information */
>  =20
> -	int		track;
> -	int		ref_count;
> +	int track;
> +	int ref_count;
>   	bool registered;
>  =20
>   	struct gendisk *disk;
> @@ -216,6 +216,7 @@ extern int swim_read_sector_data(struct swim __iomem=
 *base,
>   				 unsigned char *data);
>  =20
>   static DEFINE_MUTEX(swim_mutex);
> +
>   static void set_swim_mode(struct swim __iomem *base, int enable)
>   {
>   	struct iwm __iomem *iwm_base =3D (struct iwm __iomem *)base;
> @@ -405,7 +406,7 @@ static int swim_seek(struct swim __iomem *base, int =
step)
>   	if (step =3D=3D 0)
>   		return 0;
>  =20
> -	for ( ; step > 0; step--) {
> +	for (; step > 0; step--) {
>   		if (swim_step(base))
>   			return -1;
>   	}
> @@ -416,7 +417,7 @@ static int swim_seek(struct swim __iomem *base, int =
step)
>   	return 0;
>   }
>  =20
> -static int swim_track(struct floppy_state *fs,  int track)
> +static int swim_track(struct floppy_state *fs, int track)
>   {
>   	struct swim __iomem *base =3D fs->swd->base;
>   	int ret;
> @@ -560,10 +561,10 @@ static blk_status_t swim_queue_rq(struct blk_mq_hw=
_ctx *hctx,
>   }
>  =20
>   static struct floppy_struct floppy_type[4] =3D {
> -	{    0,  0, 0,  0, 0, 0x00, 0x00, 0x00, 0x00, NULL }, /* no testing   =
*/
> +	{    0,  0, 0,  0, 0, 0x00, 0x00, 0x00, 0x00, NULL }, /* no testing */
>   	{  720,  9, 1, 80, 0, 0x2A, 0x02, 0xDF, 0x50, NULL }, /* 360KB SS 3.5=
"*/
> -	{ 1440,  9, 2, 80, 0, 0x2A, 0x02, 0xDF, 0x50, NULL }, /* 720KB 3.5"   =
*/
> -	{ 2880, 18, 2, 80, 0, 0x1B, 0x00, 0xCF, 0x6C, NULL }, /* 1.44MB 3.5"  =
*/
> +	{ 1440,  9, 2, 80, 0, 0x2A, 0x02, 0xDF, 0x50, NULL }, /* 720KB 3.5" */
> +	{ 2880, 18, 2, 80, 0, 0x1B, 0x00, 0xCF, 0x6C, NULL }, /* 1.44MB 3.5" *=
/
>   };
>  =20
>   static int get_floppy_geometry(struct floppy_state *fs, int type,
> @@ -590,10 +591,11 @@ static void setup_medium(struct floppy_state *fs)
>  =20
>   	if (swim_readbit(base, DISK_IN)) {
>   		struct floppy_struct *g;
> +
>   		fs->disk_in =3D 1;
>   		fs->write_protected =3D swim_readbit(base, WRITE_PROT);
>   		fs->type =3D swim_readbit(base, TWOMEG_MEDIA) ?
> -			HD_MEDIA : DD_MEDIA;
> +			   HD_MEDIA : DD_MEDIA;
>   		fs->head_number =3D swim_readbit(base, SINGLE_SIDED) ? 1 : 2;
>   		get_floppy_geometry(fs, 0, &g);
>   		fs->total_secs =3D g->size;
> @@ -695,7 +697,7 @@ static int floppy_ioctl(struct block_device *bdev, b=
lk_mode_t mode,
>   	int err;
>  =20
>   	if ((cmd & 0x80) && !capable(CAP_SYS_ADMIN))
> -			return -EPERM;
> +		return -EPERM;
>  =20
>   	switch (cmd) {
>   	case FDEJECT:
> @@ -805,7 +807,7 @@ static int swim_floppy_init(struct platform_device *=
pdev)
>   	struct swim_priv *swd =3D platform_get_drvdata(pdev);
>   	unsigned int *data =3D pdev->dev.platform_data;
>   	struct queue_limits lim =3D {
> -		.features		=3D BLK_FEAT_ROTATIONAL,
> +		.features =3D BLK_FEAT_ROTATIONAL,
>   	};
>   	int err;
>   	int drive;
> @@ -963,7 +965,7 @@ static void swim_remove(struct platform_device *dev)
>   static struct platform_driver swim_driver =3D {
>   	.probe  =3D swim_probe,
>   	.remove =3D swim_remove,
> -	.driver   =3D {
> +	.driver =3D {
>   		.name	=3D CARDNAME,
>   	},
>   };
> diff --git a/drivers/block/swim_asm.S b/drivers/block/swim_asm.S
> index ae767da671e3..3d5ad525ccde 100644
> --- a/drivers/block/swim_asm.S
> +++ b/drivers/block/swim_asm.S
> @@ -5,7 +5,7 @@
>    * needs assembly language because is very timing dependent
>    * this controller exists only on macintosh 680x0 based
>    *
> - * Copyright (C) 2004,2008 Laurent Vivier <Laurent@lvivier.info>
> + * Copyright (C) 2004, 2008 Laurent Vivier <Laurent@lvivier.info>
>    *
>    * based on Alastair Bridgewater SWIM analysis, 2001
>    * based on netBSD IWM driver (c) 1997, 1998 Hauke Fath.
> @@ -80,7 +80,6 @@ wait_header_init:
>   	moveq	#3, %d1
>  =20
>   wait_addr_mark_byte:
> -
>   	tstb	%a2@
>   	dbmi	%d2, wait_addr_mark_byte
>   	bpl	signal_nonyb
> @@ -91,7 +90,6 @@ wait_addr_mark_byte:
>   	bne	wait_header_init
>  =20
>   	moveq	#max_retry, %d2
> -
>   amark0:	tstb	%a2@
>   	dbmi	%d2, amark0
>   	bpl	signal_nonyb
> @@ -99,7 +97,6 @@ amark0:	tstb	%a2@
>   	moveb	%a5@, %a4@(o_track)
>  =20
>   	moveq	#max_retry, %d2
> -
>   amark1:	tstb	%a2@
>   	dbmi	%d2, amark1
>   	bpl	signal_nonyb
> @@ -107,7 +104,6 @@ amark1:	tstb	%a2@
>   	moveb	%a5@, %a4@(o_side)
>  =20
>   	moveq	#max_retry, %d2
> -
>   amark2:	tstb	%a2@
>   	dbmi	%d2, amark2
>   	bpl	signal_nonyb
> @@ -115,7 +111,6 @@ amark2:	tstb	%a2@
>   	moveb	%a5@, %a4@(o_sector)
>  =20
>   	moveq	#max_retry, %d2
> -
>   amark3:	tstb	%a2@
>   	dbmi	%d2, amark3
>   	bpl	signal_nonyb
> @@ -123,7 +118,6 @@ amark3:	tstb	%a2@
>   	moveb	%a5@, %a4@(o_size)
>  =20
>   	moveq	#max_retry, %d2
> -
>   crc0:	tstb	%a2@
>   	dbmi	%d2, crc0
>   	bpl	signal_nonyb
> @@ -131,7 +125,6 @@ crc0:	tstb	%a2@
>   	moveb	%a5@, %a4@(o_crc0)
>  =20
>   	moveq	#max_retry, %d2
> -
>   crc1:	moveb	%a2@, %d5
>   	dbmi	%d2, crc1
>   	bpl	signal_nonyb
> @@ -177,7 +170,6 @@ wait_data_init:
>   	/* wait data address mark */
>  =20
>   wait_data_mark_byte:
> -
>   	tstb	%a2@
>   	dbmi	%d2, wait_data_mark_byte
>   	bpl	data_exit
> @@ -189,7 +181,7 @@ wait_data_mark_byte:
>  =20
>   	/* read data */
>  =20
> -	movel	#sector_size-1, %d4		/* sector size */
> +	movel	#sector_size - 1, %d4		/* sector size */
>   read_new_data:
>   	movew	#max_retry, %d2
>   read_data_loop:
> @@ -210,7 +202,6 @@ read_data_loop:
>  =20
>   	movew	#max_retry, %d2
>   data_crc0:
> -
>   	tstb	%a2@
>   	dbmi	%d2, data_crc0
>   	bpl	data_exit
> @@ -218,9 +209,7 @@ data_crc0:
>   	moveb	%a5@, %d2
>  =20
>   	moveq	#max_retry, %d2
> -
>   data_crc1:
> -
>   	moveb	%a2@, %d5
>   	dbmi	%d2, data_crc1
>   	bpl	data_exit

