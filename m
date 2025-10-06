Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03761244661;
	Mon,  6 Oct 2025 13:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759757669; cv=none; b=mVGqlsjRhu7Cou6PIdCLTLO/M/oYxrOepZ7VLFsIu68sLeKrNoY/Erz4CsJIRTtPKtKLSxnGk6r+dWIJFObc6t3Gtc8bAVhtKemZBkjn8nt+iBC3+LxURcVDW9PAMIMWdufr4Zpni0mOuEAcVI3MtCjh2/ItqLbATaFipxzQGi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759757669; c=relaxed/simple;
	bh=/nIk+ETFaJzymOk3UsTFl1HIEE9ttd0YV9z8+/gtL4o=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=shXpkHFqn+UxNMaK+cBa9fPE/8iYR/DbMWU6gD7k2QeN7kcDqrHEPEczfVndAQqyFX3InZkMzC1/qmaNIIv8UadUu01zSBr5G1JqZ5CGj1pyLvPIl7pmlbuD7nxuGrk8IpywGCMgzniV4HRMwcy4hdDgYrLd7sjx5WZSNc9AQ8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=n6yFTlCi; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="n6yFTlCi"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:From:
	Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=tx9LrM33NaI46YTL1Cn2+ml+IDlJje7NZ2NowEuRVQ0=; t=1759757666;
	x=1760362466; b=n6yFTlCiCJB2GI34RAmvZ7z9GkvC7+RJvpyRhJwTtcgdFH7nO16uBnzlEYdpd
	rlHQWcIByE76lryMJsU+yMvHZb4b1Clpe9yKomBaKEilIQXOdQPK+PPqkJMRGuSqyvh5feh2F/6VL
	5uUWboAN8qkuNeeMAwGGmXGcqJqM9JyCP2IzJ5WfgKyJ7A2NbiDu2s2ZCy7JL4jxQkKLkgoBjY5g+
	xN19i3e4DNv4tw8T4940em4l8tTbW6R8dEx41Dp+nypT0LiAKZbE7O20kX38z3XkyNF+2AU1g6m1f
	bCqSQjAm5KwyBtmBlqHnnmMnJUkh1YR0Un3Fdvs0uwttI0Ggaw==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.98)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1v5lM7-00000000II1-24Qh; Mon, 06 Oct 2025 15:34:23 +0200
Received: from p5b13aa34.dip0.t-ipconnect.de ([91.19.170.52] helo=[192.168.178.61])
          by inpost2.zedat.fu-berlin.de (Exim 4.98)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1v5lM7-00000003AdQ-11l2; Mon, 06 Oct 2025 15:34:23 +0200
Message-ID: <e6a7e68ff9e23aee448003ee1a279a4ab13192c0.camel@physik.fu-berlin.de>
Subject: Re: [PATCH v2] Revert "sunvdc: Do not spin in an infinite loop when
 vio_ldc_send() returns EAGAIN"
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Cc: Andreas Larsson <andreas@gaisler.com>, Anthony Yznaga	
 <anthony.yznaga@oracle.com>, Sam James <sam@gentoo.org>, "David S . Miller"
	 <davem@davemloft.net>, Michael Karcher
 <kernel@mkarcher.dialup.fu-berlin.de>, 	sparclinux@vger.kernel.org
Date: Mon, 06 Oct 2025 15:34:22 +0200
In-Reply-To: <a80a1c5f-da21-4437-b956-a9f659c355a4@kernel.dk>
References: <20251006100226.4246-2-glaubitz@physik.fu-berlin.de>
	 <d78a1704-31dc-4eaa-8189-e3aba51d3fe2@kernel.dk>
	 <4e45e3182c4718cafad1166e9ef8dcca1c301651.camel@physik.fu-berlin.de>
	 <a80a1c5f-da21-4437-b956-a9f659c355a4@kernel.dk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.0 
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-ZEDAT-Hint: PO

Hi Jens,

On Mon, 2025-10-06 at 07:19 -0600, Jens Axboe wrote:
> > The problem is that giving up can lead to filesystem corruption which
> > is problem that was never observed before the change from what I know.
>=20
> Yes, I get that.
>=20
> > We have deployed a kernel with the change reverted on several LDOMs tha=
t
> > are seeing heavy use such as cfarm202.cfarm.net and we have seen any sy=
stem
> > lock ups or similar.
>=20
> I believe you. I'm just wondering how long you generally need to spin,
> as per the question above: how many times does it generally spin where
> it would've failed before?

I don't have any data on that, unfortunately. All I can say that we have se=
en
filesystem corruption when installing Linux inside an LDOM and this particu=
lar
issue was eventually tracked down to this commit.

> > > Not that it's _really_ that important as this is a pretty niche drive=
r,
> > > but still pretty ugly... Does it work reliably with a limit of 100
> > > spins? If things get truly stuck, spinning forever in that loop is no=
t
> > > going to help. In any case, your patch should have
> >=20
> > Isn't it possible that the call to vio_ldc_send() will eventually succe=
ed
> > which is why there is no need to abort in __vdc_tx_trigger()?
>=20
> Of course. Is it also possible that some conditions will lead it to
> never succeed?

I would assume that this would require for the virtual disk server to not
respond which should never happen since it's a virtualized environment.

If hardware issues would cause vio_ldc_send() to never succeed, these would
have to be handled by the virtualization environment, I guess.

> The nicer approach would be to have sunvdc punt retries back up to the
> block stack, which would at least avoid a busy spin for the condition.
> Rather than return BLK_STS_IOERR which terminates the request and
> bubbles back the -EIO as per your log. IOW, if we've already spent
> 10.5ms in that busy loop as per the above rough calculation, perhaps
> we'd be better off restarting the queue and hence this operation after a
> small sleeping delay instead. That would seem a lot saner than hammering
> on it.

I generally agree with this remark. I just wonder whether this behavior sho=
uld
apply for a logical domain as well. I guess if a request doesn't succeed im=
mediately,
it's an urgent problem if the logical domain locks up, is it?

I have to admit though that I'm absolutely not an expert on the block layer=
.

> > And unlike the change in adddc32d6fde ("sunvnet: Do not spin in an infi=
nite
> > loop when vio_ldc_send() returns EAGAIN"), we can't just drop data as t=
his
> > driver concerns a block device while the other driver concerns a networ=
k
> > device. Dropping network packages is expected, dropping bytes from a bl=
ock
> > device driver is not.
>=20
> Right, but we can sanely retry it rather than sit in a tight loop.
> Something like the entirely untested below diff.
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

We could add this particular change on top of mine after we have extensivel=
y tested it.

For now, I would propose to pick up my patch to revert the previous change.=
 I can then
pick up your proposed change and deploy it for extensive testing and see if=
 it has any
side effects.

Adrian

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
