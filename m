Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA60D298CAB
	for <linux-block@vger.kernel.org>; Mon, 15 Jun 2026 22:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781561360; cv=none; b=LU2eyjv6Mbx+KxJzXDhfnhvzRHQcSJz7WhG4AbrhzyoK7c1Gi4Iq65VEsj2ZLKWVrC7FzLAPWmO2lO04ZUnSshYKlYVFg3SrdP+NOxpghlkU6kIaw5/OkYH71nNMVtb+stJYpi5I7RTf7dWzQIlhHd21aW5WFhK7faP8z2iFdSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781561360; c=relaxed/simple;
	bh=yTenFTQNvTUGkSnyKRHZ7LLN3gHxZkLZ+0yCrhGH8w8=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ezDY2/lmC2uAaq9PHGrwV0/+ajt3L+3xfD2fzRwqLAN6MWAbsu5YJ9YCsGZQvj0Jdp1MMcMuJwteZJLvfo/bFbOkyn/oAWsE+Zemax0cie3NTXjCQ5LF+R05qItnxDU/4qfx6AS/g67Yd7gDAsqNPbLAjLzj663uKxxOcV59Jm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=QLeOj26b; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="QLeOj26b"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:From:
	Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=bw2WOYcZP37ufsfhHyntBVoqWX30O/l/VSyR6jXSk2k=; t=1781561356;
	x=1782166156; b=QLeOj26bASZwBXxFzJpc2FslDOYw2oy0rPRochxToYgMXprh2cghw+vA/it5U
	JUhZSk4IHxO2ZNjf1TqZnjm2Zk8mAutCCc5oVhTz5gt2cpOpS3cYfc2ll2ZoBBPPJZRl0CMzJdNFd
	AZkkAaTbWDf8yH4V9N5/AvvhC8J4bqWuvieTlD34JA/4+iR/258TMBv1iJwfp+h3ahmp35u83DxJX
	2Ne2B2/K01ci5NKY3tZ6Vdwgk30dsaiRLqdJfHfCZqaUFQvsVMJLK0EAeb3FaraVMVhE9/D2jpryb
	N0mwNekSmJsjEr/X+NT0ZBWBTAnCJ7hD6tIXDeQCFEMvvHlEhw==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.99)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1wZFUT-00000004Bxt-1y0c; Tue, 16 Jun 2026 00:09:09 +0200
Received: from p57bd94c1.dip0.t-ipconnect.de ([87.189.148.193] helo=[192.168.178.61])
          by inpost2.zedat.fu-berlin.de (Exim 4.99)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1wZFUT-00000000HHs-162r; Tue, 16 Jun 2026 00:09:09 +0200
Message-ID: <e4e9e90072ffdec95ec50b0df26fd7177d4ee0ca.camel@physik.fu-berlin.de>
Subject: Re: [PATCH] sunvdc: fix -EIO issue due to lack of retries
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Jens Axboe <axboe@kernel.dk>, "linux-block@vger.kernel.org"
	 <linux-block@vger.kernel.org>
Date: Tue, 16 Jun 2026 00:09:08 +0200
In-Reply-To: <418310b3-2b77-4534-b2fd-27dcc11e333c@kernel.dk>
References: <418310b3-2b77-4534-b2fd-27dcc11e333c@kernel.dk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-ZEDAT-Hint: PO

Hi,

On Mon, 2025-10-06 at 08:59 -0600, Jens Axboe wrote:
> John reports that since commit:
>=20
> a11f6ca9aef9 ("sunvdc: Do not spin in an infinite loop when vio_ldc_send(=
) returns EAGAIN")
>=20
> users of Linux inside Solaris ldom see occasional -EIO errors because
> the request send loop now times out. The current loop does 10 retries,
> and inside vio_ldc_send() a further 1000 1usec retries are done as well.
> Even with 10.5 msec of busy loop retries that's apparently not enough to
> always succeed.
>=20
> Rather than introduce continued busy looping, requeue the request and
> have the delayed queue kicking retry the request after another 10ms.
> This obviously isn't ideal, but there's seemingly no way to wait for
> this type of event. And if 10ms of busy looping was not enough to make
> progress, then presumably this is an edge condition and we just need to
> guarantee to make forward progress at some later point in time. That's
> more suitably done through letting the CPU tend to other work, rather
> than sitting in a tight loop retrying.
>=20
> Reported-by: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
> Link: https://lore.kernel.org/all/20251006100226.4246-2-glaubitz@physik.f=
u-berlin.de/
> Signed-off-by: Jens Axboe <axboe@kernel.dk>
>=20
> ---
>=20
> Caveat: 100% untested, not even compiled. Sending out on John's behest.
>=20
> diff --git a/drivers/block/sunvdc.c b/drivers/block/sunvdc.c
> index db1fe9772a4d..aa49dffb1b53 100644
> --- a/drivers/block/sunvdc.c
> +++ b/drivers/block/sunvdc.c
> @@ -539,6 +539,7 @@ static blk_status_t vdc_queue_rq(struct blk_mq_hw_ctx=
 *hctx,
>  	struct vdc_port *port =3D hctx->queue->queuedata;
>  	struct vio_dring_state *dr;
>  	unsigned long flags;
> +	int ret;
> =20
>  	dr =3D &port->vio.drings[VIO_DRIVER_TX_RING];
> =20
> @@ -560,7 +561,13 @@ static blk_status_t vdc_queue_rq(struct blk_mq_hw_ct=
x *hctx,
>  		return BLK_STS_DEV_RESOURCE;
>  	}
> =20
> -	if (__send_request(bd->rq) < 0) {
> +	ret =3D __send_request(bd->rq);
> +	if (ret =3D=3D -EAGAIN) {
> +		spin_unlock_irqrestore(&port->vio.lock, flags);
> +		/* already spun for 10msec, defer 10msec and retry */
> +		blk_mq_delay_kick_requeue_list(hctx->queue, 10);
> +		return BLK_STS_DEV_RESOURCE;
> +	} else if (ret < 0) {
>  		spin_unlock_irqrestore(&port->vio.lock, flags);
>  		return BLK_STS_IOERR;
>  	}

I will give this patch a try this week as I finally want to get this fixed.

Adrian

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
