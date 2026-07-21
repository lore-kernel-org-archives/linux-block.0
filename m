Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A79C2BE7DD;
	Tue, 21 Jul 2026 06:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784613803; cv=none; b=OHE6qmLUAkrhT+Rq94ZAs93lXNFIW2E2fHzr21KaujtTgXyXvR2iZz5hJNwke/msTmN0a0M06O8hToH3s1Q/UZiI0hGv+YkYjtpBcjwrOeIFwq9h1sTr/OsKg6YA/X0X2NECPjNxpGP8VQEnNLvTG5RwVo+QhHhpdL5uU/E0r5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784613803; c=relaxed/simple;
	bh=r8s9HmFvS4LchEp1JX5VWrk9H8sI40WvnsZfpHB1MVY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Y560GPcNfTcsOABlRVBwQctTgaqqxkLZrPv8sI4A+jh+/+DVepsEYEnpHCh/fKF6zocPjCji3nhBLJZlY/go6TjWJs99S2uh0R6heg2T8ltuA486+BEAiaX9I9BfYOP4QqPIMk7Z8MeoEU5tnvki2xNfFYIsYBGIFGNKT5a6XJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vivier.eu; spf=pass smtp.mailfrom=vivier.eu; dkim=pass (2048-bit key) header.d=vivier.eu header.i=laurent@vivier.eu header.b=SImjA2PV; arc=none smtp.client-ip=212.227.17.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vivier.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivier.eu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivier.eu header.i=laurent@vivier.eu header.b="SImjA2PV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivier.eu;
	s=s1-ionos; t=1784613797; x=1785218597; i=laurent@vivier.eu;
	bh=5jy/aNxoBQ7MOYujklIiGO1Rx0sDbGP81UyGjEwYbdQ=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=SImjA2PVua+1CpkXusyMNaOX/D5XKjSk4bKma1E+KQPJ8obZ/pvIg7hrXW/PqtIx
	 1a8r/BzAmyJARi1TVSVM4O1rQEmISmz9SHphAVgo5MA7D6xV3zZKM7fBbOV2tP5dg
	 GdNEqe/0HBD1S4zR9KwpRbxPUpRIFWv2xKGRokgmzNEKiiIg/sVFdAONa3uS+8jPr
	 ygeQew0USVG9Km4GxjZett3DTBjPRK2ldKwD9Tem6YF+0+UHOsY52p0cgQ7dUY1IY
	 hGtbIDtXWkvgVO/R6C94Rexhapq+BELHwz2/EL/HsR1TLdwsky4Y8ZZMkQabpi8Zy
	 4vRuVKe8sGOJOXYCWA==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from client.hidden.invalid by mrelayeu.kundenserver.de (mreue109
 [213.165.67.119]) with ESMTPSA (Nemesis) id 1Mbj3Y-1xHXEx1MkQ-00db65; Tue, 21
 Jul 2026 08:03:17 +0200
Message-ID: <71650fbe-572b-48f3-a5e3-de266bb5c69b@vivier.eu>
Date: Tue, 21 Jul 2026 08:03:16 +0200
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 17/31] swim: Convert to blocking queue
To: Finn Thain <fthain@linux-m68k.org>, Jens Axboe <axboe@kernel.dk>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
 Joshua Thompson <funaho@jurai.org>, linux-block@vger.kernel.org,
 linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org,
 Omar Sandoval <osandov@fb.com>
References: <cover.1784196135.git.fthain@linux-m68k.org>
 <33f99f4aad5a482c5465bcef4d3542cbb2a51dbf.1784196135.git.fthain@linux-m68k.org>
Content-Language: fr
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; keydata=
 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
In-Reply-To: <33f99f4aad5a482c5465bcef4d3542cbb2a51dbf.1784196135.git.fthain@linux-m68k.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:knhxwteij36lWcWaVQf7dPfVN59/J8W2232O6OY3WS4BEZnZe1J
 co0l72sMNHggr0+SZF1p0RgyJ5p5WjFOA5XS5sWic2+I/fkWIy8tgg0JJKEAEOUoLAQLy9Z
 8oVlSP1Ucx5spWty41iVXh57PZGspJAqpAdGc6ilMSQmyq74lFjkRt0dCRQSovmIrgM1adU
 eDPnAEe/D02WCcyrh9S5g==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Z4zfJ9DAojE=;sXlZAU18lEV7XTblDgSJXETuSUz
 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
 =

Le 16/07/2026 =C3=A0 12:02, Finn Thain a =C3=A9crit=C2=A0:
> These drives are slow: completing a request can take hundreds of
> milliseconds. Delays are managed by disabling interrupts judiciously and
> sleeping opportunistically.
>=20
> As of commit e3896d77b702 ("swim: convert to blk-mq"), a spinlock is
> taken in irq mode as soon as a request is issued. That lock is held for
> the duration of the request. Hence the driver sleeps while holding the
> lock which is forbidden.
>=20
> Adopt BLK_MQ_F_BLOCKING and remove the spinlock. Use a mutex to serializ=
e
> requests from the two request queues. (The chip cannot simultaneously
> process requests on both internal and external drive.)
>=20
> Cc: Omar Sandoval <osandov@fb.com>
> Fixes: e3896d77b702 ("swim: convert to blk-mq")
> Signed-off-by: Finn Thain <fthain@linux-m68k.org>
> ---
>   drivers/block/swim.c | 11 +++--------
>   1 file changed, 3 insertions(+), 8 deletions(-)
>=20

Reviewed-by: Laurent Vivier <laurent@vivier.eu>

> diff --git a/drivers/block/swim.c b/drivers/block/swim.c
> index e2a8c4ba4e39..6f93ebaaffb7 100644
> --- a/drivers/block/swim.c
> +++ b/drivers/block/swim.c
> @@ -211,7 +211,6 @@ enum head {
>  =20
>   struct swim_priv {
>   	struct swim __iomem *base;
> -	spinlock_t lock;
>   	int floppy_count;
>   	struct floppy_state unit[FD_MAX_UNIT];
>   };
> @@ -537,12 +536,10 @@ static blk_status_t swim_queue_rq(struct blk_mq_hw=
_ctx *hctx,
>   				  const struct blk_mq_queue_data *bd)
>   {
>   	struct floppy_state *fs =3D hctx->queue->queuedata;
> -	struct swim_priv *swd =3D fs->swd;
>   	struct request *req =3D bd->rq;
>   	blk_status_t err;
>  =20
> -	if (!spin_trylock_irq(&swd->lock))
> -		return BLK_STS_DEV_RESOURCE;
> +	mutex_lock(&swim_mutex);
>  =20
>   	blk_mq_start_request(req);
>  =20
> @@ -560,7 +557,7 @@ static blk_status_t swim_queue_rq(struct blk_mq_hw_c=
tx *hctx,
>  =20
>   	err =3D BLK_STS_OK;
>   out:
> -	spin_unlock_irq(&swd->lock);
> +	mutex_unlock(&swim_mutex);
>   	return err;
>  =20
>   }
> @@ -839,11 +836,9 @@ static int swim_floppy_init(struct platform_device =
*pdev)
>   		return -EBUSY;
>   	}
>  =20
> -	spin_lock_init(&swd->lock);
> -
>   	for (drive =3D 0; drive < swd->floppy_count; drive++) {
>   		err =3D blk_mq_alloc_sq_tag_set(&swd->unit[drive].tag_set,
> -				&swim_mq_ops, 2, 0);
> +				&swim_mq_ops, 2, BLK_MQ_F_BLOCKING);
>   		if (err)
>   			goto exit_put_disks;
>  =20

