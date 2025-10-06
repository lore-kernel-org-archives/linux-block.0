Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4E347081C;
	Mon,  6 Oct 2025 14:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759759941; cv=none; b=jxs5dM5lCuADzKZty1JtIft780a4gfCsl2G7EuwXyYPq/TcBf9TFDuVEfobDDAo+VmOoSwF4QCYHsgZdS9scf7rN1oyCaUdh6QAoRs+j5uzlEIbH+7SLhcw6eQ6Ty3oKgcL0UZZpvNLyzb61ntlN9avg8hbXb8mhOzHsH2YEzGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759759941; c=relaxed/simple;
	bh=oX0hxl9y2RR15gDl1PquBggQpEN7Bar/5nFx6gYMVkQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fVNV0MQuQYb4exvK1f/qmiX4yubvjFizgFdSieosXBuZ4vQDagoyZ7v7qpKCDN/1NymJDFotuvGnETHfXErfBTRy029UPPvmSYrLEtd7e/DlE2NXuF/E6BApoMybwYy0dQ91SrTLkrIuxtG5A4mz3Vr4hXlxaw6kmrqlny54RqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=GEzwgLzf; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="GEzwgLzf"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:From:
	Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=23CVLylcgnapJ6jlYQdsh4lJ2r8jytwkumAM2tRh278=; t=1759759937;
	x=1760364737; b=GEzwgLzfpVbYuZIy7eRCTrkqAGA2EvfozW7j9CIQ6HkqNZaDv+nTKCO6JtuUx
	PgKRY+/hJCyNL2Tel4MhWGB3yowQA4gcefW3bSB4KRr65uMhIbh+XvR+wxcNSl46t/ml2X0mZVnXP
	9RQoqnVDDstENpXHaPTwal13oEVdLn4sVZ0je+LiiCMjzi6YfMJUt2a7XDYB5yrAN+JCjK3WuBGSr
	JCyoC1VbhjNdxAgiFY+ersB86zczr45USVpx1U/FLkjRdYTSOpo7QevKtEv+ivuLQmsQWfkOu/a9H
	qoe+5f2EtmR7V4yD915gVbwWLTRm0lut+ZLCj+eCrb69L4qRQQ==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.98)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1v5lwi-00000000WeH-3Sgl; Mon, 06 Oct 2025 16:12:12 +0200
Received: from p5b13aa34.dip0.t-ipconnect.de ([91.19.170.52] helo=[192.168.178.61])
          by inpost2.zedat.fu-berlin.de (Exim 4.98)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1v5lwi-00000003G0x-2LVk; Mon, 06 Oct 2025 16:12:12 +0200
Message-ID: <6ed7112cb4f338ba02d9ab67c14e7a3af4afbca0.camel@physik.fu-berlin.de>
Subject: Re: [PATCH v2] Revert "sunvdc: Do not spin in an infinite loop when
 vio_ldc_send() returns EAGAIN"
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Cc: Andreas Larsson <andreas@gaisler.com>, Anthony Yznaga	
 <anthony.yznaga@oracle.com>, Sam James <sam@gentoo.org>, "David S . Miller"
	 <davem@davemloft.net>, Michael Karcher
 <kernel@mkarcher.dialup.fu-berlin.de>, 	sparclinux@vger.kernel.org
Date: Mon, 06 Oct 2025 16:12:11 +0200
In-Reply-To: <ecb74c6c-8de6-4774-8159-2ec118437c57@kernel.dk>
References: <20251006100226.4246-2-glaubitz@physik.fu-berlin.de>
	 <d78a1704-31dc-4eaa-8189-e3aba51d3fe2@kernel.dk>
	 <4e45e3182c4718cafad1166e9ef8dcca1c301651.camel@physik.fu-berlin.de>
	 <a80a1c5f-da21-4437-b956-a9f659c355a4@kernel.dk>
	 <e6a7e68ff9e23aee448003ee1a279a4ab13192c0.camel@physik.fu-berlin.de>
	 <cef07e8f-a919-4aa1-9904-84b16dfa8fe6@kernel.dk>
	 <5b3caa0e218dd473c8871c1b1f09a8dc1c356f1e.camel@physik.fu-berlin.de>
	 <ecb74c6c-8de6-4774-8159-2ec118437c57@kernel.dk>
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

On Mon, 2025-10-06 at 08:03 -0600, Jens Axboe wrote:
> > To be fair, the sunvdc driver is fairly old and I'm not sure whether th=
ese
> > tools already existed back then. FWIW, Oracle engineers did actually wo=
rk
> > on the Linux for SPARC code for a while and it might be possible that t=
heir
> > UEK kernel tree [1] contains some improvements in this regard.
>=20
> Requeueing and retry has always been available on the block side. It's
> not an uncommon thing for a driver to need, in case of resource
> starvation. And sometimes those resources can be unrelated to the IO, eg
> iommu shortages. Or this busy condition.

I see. Makes sense.

> But that's fine, it's not uncommon for drivers to miss things like that,
> and then we fix them up when noticed. It was probably written by someone
> not super familiar with the IO stack.

FWIW, Oracle engineers actually made some significant changes to the driver
that they never upstreamed, see:

https://github.com/oracle/linux-uek/commits/uek4/qu7/drivers/block/sunvdc.c

In particular, they added support for out-of-order execution:

https://github.com/oracle/linux-uek/commit/68f7c9c17fb80d29cbc1e5110f6c021f=
8da8d610

and they also changed the driver to use the BIO-based interface for VDC I/O=
 requests:

https://github.com/oracle/linux-uek/commit/4b725eb64cc10a4877f2af75ff3a7765=
86f68eb7

Could you review these two changes and tell me whether these would actually=
 implement
the changes you would want to see? I think the BIO layer is a generic inter=
face of
the block layer in the kernel, isn't it?

> > > > > > And unlike the change in adddc32d6fde ("sunvnet: Do not spin in=
 an infinite
> > > > > > loop when vio_ldc_send() returns EAGAIN"), we can't just drop d=
ata as this
> > > > > > driver concerns a block device while the other driver concerns =
a network
> > > > > > device. Dropping network packages is expected, dropping bytes f=
rom a block
> > > > > > device driver is not.
> > > > >=20
> > > > > Right, but we can sanely retry it rather than sit in a tight loop=
.
> > > > > Something like the entirely untested below diff.
> > > > >=20
> > > > > diff --git a/drivers/block/sunvdc.c b/drivers/block/sunvdc.c
> > > > > index db1fe9772a4d..aa49dffb1b53 100644
> > > > > --- a/drivers/block/sunvdc.c
> > > > > +++ b/drivers/block/sunvdc.c
> > > > > @@ -539,6 +539,7 @@ static blk_status_t vdc_queue_rq(struct blk_m=
q_hw_ctx *hctx,
> > > > >  	struct vdc_port *port =3D hctx->queue->queuedata;
> > > > >  	struct vio_dring_state *dr;
> > > > >  	unsigned long flags;
> > > > > +	int ret;
> > > > > =20
> > > > >  	dr =3D &port->vio.drings[VIO_DRIVER_TX_RING];
> > > > > =20
> > > > > @@ -560,7 +561,13 @@ static blk_status_t vdc_queue_rq(struct blk_=
mq_hw_ctx *hctx,
> > > > >  		return BLK_STS_DEV_RESOURCE;
> > > > >  	}
> > > > > =20
> > > > > -	if (__send_request(bd->rq) < 0) {
> > > > > +	ret =3D __send_request(bd->rq);
> > > > > +	if (ret =3D=3D -EAGAIN) {
> > > > > +		spin_unlock_irqrestore(&port->vio.lock, flags);
> > > > > +		/* already spun for 10msec, defer 10msec and retry */
> > > > > +		blk_mq_delay_kick_requeue_list(hctx->queue, 10);
> > > > > +		return BLK_STS_DEV_RESOURCE;
> > > > > +	} else if (ret < 0) {
> > > > >  		spin_unlock_irqrestore(&port->vio.lock, flags);
> > > > >  		return BLK_STS_IOERR;
> > > > >  	}
> > > >=20
> > > > We could add this particular change on top of mine after we have
> > > > extensively tested it.
> > >=20
> > > It doesn't really make sense on top of yours, as that removes the
> > > limited looping that sunvdc would do...
> >=20
> > Why not? From what I understood, you're moving the limited looping to a
> > different part of the driver where it can delegate the request back up
> > the stack meaning that the current place to implement the limitation is
> > not correct anyway, is it?
>=20
> Because your change never gives up, hence it'd never trigger the softer
> retry condition. It'll just keep busy looping.

Ah, that makes sense.

> > > > For now, I would propose to pick up my patch to revert the previous
> > > > change. I can then pick up your proposed change and deploy it for
> > > > extensive testing and see if it has any side effects.
> > >=20
> > > Why not just test this one and see if it works? As far as I can tell,
> > > it's been 6.5 years since this change went in, I can't imagine there'=
s a
> > > huge sense of urgency to fix it up that can't wait for testing a more
> > > proper patch rather than a work-around?
> >=20
> > Well, the thing is that a lot of people have been running older kernels
> > on SPARC because of issues like these and I have started working on try=
ing
> > to track down all of these issues now [2] for users to be able to run a
> > current kernel. So, the 6.5 years existence of this change shouldn't
> > be an argument I think.
>=20
> While I agree that the bug is unfortunate, it's also a chance to
> properly fix it rather than just go back to busy looping. How difficult
> is it to test an iteration of the patch? It'd be annoying to queue a
> bandaid only to have to revert that again for a real fix. If this was a
> regression from the last release or two then that'd be a different
> story, but the fact that this has persisted for 6.5 years and is only
> bubbling back up to mainstream now would seem to indicate that we should
> spend a bit of extra time to just get it right the first time.

We could do that for sure. But I would like to hear your opinion on the cha=
nges
contributed by Oracle engineers first. Maybe their improvements are much be=
tter
so that it might make sense to try to upstream them.

Adrian

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
