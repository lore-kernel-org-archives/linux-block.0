Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2EDF2957CD;
	Mon,  6 Oct 2025 13:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759758985; cv=none; b=Bob/0MGAoNUld/P3HCr8rzReZxYnP+KCmjXuvu3/TJrClikTgiW6K/AJL8VgbaX37yL7UsBL2hE1IZLM5VvsaLPFIc91kU4iSJXGpDhbDr7cGbuJTVf0frpHTaQKNPDUHisoCygLJsHu9v7KN5LsQsLmzrbX7UhksiVZcAyTu80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759758985; c=relaxed/simple;
	bh=eKuE6ziTfgsX4a031s2nKsfSl0dP78mv8ey7p1zNP/4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=asqxhkSh8Geo+nGxhcOb/Mbb/X2mcI+CPce6w0OlkSkHLd57aQ7Z1jfRR+0bkRfZHN2SPyFG9KYw3uJ5KeJBY2ituEesbPY3Rg7k5F5cmC97/rD4xREfdjdTPVCZSxb3fygYEs3n+dUzBD0e/O5junEhBsUEG7ECY4HPVyb4dAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=cniM054q; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="cniM054q"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:From:
	Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=KC2LkXgWWyT/SD6PuMAcjwz6xmjyxeNgNLTmpMVykMQ=; t=1759758981;
	x=1760363781; b=cniM054qPwlSTMhjPElKhaeGtoe6VHjGa8vgvBaawyZAuxFCgyhzm91ueccbC
	mFtu8hGZP7Mw/FsFqQhTFITGOJu+PvJGW/U0lBwZuWUOJkj9La63K2Om9/nvQG80uHSkIS8lRAunE
	C1XcPWvfZI1rVCWkUfC3bDqa836gntpTY5ZoGCmqCbsbYtEgAjYO9fxlbS8uvdh4BU1rLggWffzpD
	vaQ1fR91v4Zyyc7Q82Fa5nPqdw7+F7Mgr/N0bknStfa8ZMp1zBQhozTcSzgSYNPvSu43G4DLC/dNS
	yuoMzUs15XzWqt1ZtfrOcQGkch1HK7qtzDXhlddbshLCaaw92w==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.98)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1v5lhL-00000000QCo-034E; Mon, 06 Oct 2025 15:56:19 +0200
Received: from p5b13aa34.dip0.t-ipconnect.de ([91.19.170.52] helo=[192.168.178.61])
          by inpost2.zedat.fu-berlin.de (Exim 4.98)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1v5lhK-00000003Dmc-3Ctj; Mon, 06 Oct 2025 15:56:18 +0200
Message-ID: <5b3caa0e218dd473c8871c1b1f09a8dc1c356f1e.camel@physik.fu-berlin.de>
Subject: Re: [PATCH v2] Revert "sunvdc: Do not spin in an infinite loop when
 vio_ldc_send() returns EAGAIN"
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Cc: Andreas Larsson <andreas@gaisler.com>, Anthony Yznaga	
 <anthony.yznaga@oracle.com>, Sam James <sam@gentoo.org>, "David S . Miller"
	 <davem@davemloft.net>, Michael Karcher
 <kernel@mkarcher.dialup.fu-berlin.de>, 	sparclinux@vger.kernel.org
Date: Mon, 06 Oct 2025 15:56:17 +0200
In-Reply-To: <cef07e8f-a919-4aa1-9904-84b16dfa8fe6@kernel.dk>
References: <20251006100226.4246-2-glaubitz@physik.fu-berlin.de>
	 <d78a1704-31dc-4eaa-8189-e3aba51d3fe2@kernel.dk>
	 <4e45e3182c4718cafad1166e9ef8dcca1c301651.camel@physik.fu-berlin.de>
	 <a80a1c5f-da21-4437-b956-a9f659c355a4@kernel.dk>
	 <e6a7e68ff9e23aee448003ee1a279a4ab13192c0.camel@physik.fu-berlin.de>
	 <cef07e8f-a919-4aa1-9904-84b16dfa8fe6@kernel.dk>
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

On Mon, 2025-10-06 at 07:46 -0600, Jens Axboe wrote:
>=20
> > > The nicer approach would be to have sunvdc punt retries back up to th=
e
> > > block stack, which would at least avoid a busy spin for the condition=
.
> > > Rather than return BLK_STS_IOERR which terminates the request and
> > > bubbles back the -EIO as per your log. IOW, if we've already spent
> > > 10.5ms in that busy loop as per the above rough calculation, perhaps
> > > we'd be better off restarting the queue and hence this operation afte=
r a
> > > small sleeping delay instead. That would seem a lot saner than hammer=
ing
> > > on it.
> >=20
> > I generally agree with this remark. I just wonder whether this
> > behavior should apply for a logical domain as well. I guess if a
> > request doesn't succeed immediately, it's an urgent problem if the
> > logical domain locks up, is it?
>=20
> It's just bad behavior. Honestly most of this just looks like either a
> bad implementation of the protocol as it's all based on busy looping, or
> a badly designed protocol. And then the sunvdc usage of it just
> proliferates that problem, rather than utilizing the tools that exist in
> the block stack to take a breather rather than repeatedly hammering on
> the hardware for conditions like this.

To be fair, the sunvdc driver is fairly old and I'm not sure whether these
tools already existed back then. FWIW, Oracle engineers did actually work
on the Linux for SPARC code for a while and it might be possible that their
UEK kernel tree [1] contains some improvements in this regard.

> > > > And unlike the change in adddc32d6fde ("sunvnet: Do not spin in an =
infinite
> > > > loop when vio_ldc_send() returns EAGAIN"), we can't just drop data =
as this
> > > > driver concerns a block device while the other driver concerns a ne=
twork
> > > > device. Dropping network packages is expected, dropping bytes from =
a block
> > > > device driver is not.
> > >=20
> > > Right, but we can sanely retry it rather than sit in a tight loop.
> > > Something like the entirely untested below diff.
> > >=20
> > > diff --git a/drivers/block/sunvdc.c b/drivers/block/sunvdc.c
> > > index db1fe9772a4d..aa49dffb1b53 100644
> > > --- a/drivers/block/sunvdc.c
> > > +++ b/drivers/block/sunvdc.c
> > > @@ -539,6 +539,7 @@ static blk_status_t vdc_queue_rq(struct blk_mq_hw=
_ctx *hctx,
> > >  	struct vdc_port *port =3D hctx->queue->queuedata;
> > >  	struct vio_dring_state *dr;
> > >  	unsigned long flags;
> > > +	int ret;
> > > =20
> > >  	dr =3D &port->vio.drings[VIO_DRIVER_TX_RING];
> > > =20
> > > @@ -560,7 +561,13 @@ static blk_status_t vdc_queue_rq(struct blk_mq_h=
w_ctx *hctx,
> > >  		return BLK_STS_DEV_RESOURCE;
> > >  	}
> > > =20
> > > -	if (__send_request(bd->rq) < 0) {
> > > +	ret =3D __send_request(bd->rq);
> > > +	if (ret =3D=3D -EAGAIN) {
> > > +		spin_unlock_irqrestore(&port->vio.lock, flags);
> > > +		/* already spun for 10msec, defer 10msec and retry */
> > > +		blk_mq_delay_kick_requeue_list(hctx->queue, 10);
> > > +		return BLK_STS_DEV_RESOURCE;
> > > +	} else if (ret < 0) {
> > >  		spin_unlock_irqrestore(&port->vio.lock, flags);
> > >  		return BLK_STS_IOERR;
> > >  	}
> >=20
> > We could add this particular change on top of mine after we have
> > extensively tested it.
>=20
> It doesn't really make sense on top of yours, as that removes the
> limited looping that sunvdc would do...

Why not? From what I understood, you're moving the limited looping to a
different part of the driver where it can delegate the request back up
the stack meaning that the current place to implement the limitation is
not correct anyway, is it?

> > For now, I would propose to pick up my patch to revert the previous
> > change. I can then pick up your proposed change and deploy it for
> > extensive testing and see if it has any side effects.
>=20
> Why not just test this one and see if it works? As far as I can tell,
> it's been 6.5 years since this change went in, I can't imagine there's a
> huge sense of urgency to fix it up that can't wait for testing a more
> proper patch rather than a work-around?

Well, the thing is that a lot of people have been running older kernels
on SPARC because of issues like these and I have started working on trying
to track down all of these issues now [2] for users to be able to run a
current kernel. So, the 6.5 years existence of this change shouldn't
be an argument I think.

Adrian

> [1] https://github.com/oracle/linux-uek/tree/uek4/qu7
> [2] https://github.com/sparclinux/issues/issues

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
