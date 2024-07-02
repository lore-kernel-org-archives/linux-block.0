Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DAF6179AF
	for <linux-block@vger.kernel.org>; Tue,  2 Jul 2024 04:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719893269; cv=none; b=aWf0li6vBrd0oZZGBEsdkfcErFrnGKwPkqPfILajME7ytkrcugxrS9/WLpz0shE7QkLdauaCKg4+YTnw7IdC3Vv6+t1Q5Gem9YpKaOPdy3pUwnHykI3x0ZhUyW670QfQle2gn9TnelQ+JT3ctOyzKoYnVahM/ykgSosY5AfOn2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719893269; c=relaxed/simple;
	bh=n9Uv7Lg612H7kfDZRxwHPiO03reyWzef2B5d428Gj7A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X/hrbSJJggCgxc5ay20I3cy89cQ9jtgi2btt99nVF6T51rsKox+b/b+tfEMXGU0owECYW/0FHtTF/Fo2TP7s6XEdnXUrvT0KjmCFzH2la6kF/0wj5UKEu+qkt+lpb3efxr3Q+nMICoTrMlb1olxRk+E8IuuMUfccSIDE03/ENHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bGr2z1u0; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bGr2z1u0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719893266;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=S0CaLZl2ERm7GNxDGtayS0f5Prh3DdPwGYJckExMLKw=;
	b=bGr2z1u06u9TFv3gpcJi0SB+Zd/CzWe9QL51B1SmNZOk8LSaZT7V42QdPX/ssLlpe/3a/a
	342QVYzNXm5b8zyE1D+BqqXe9BZVFCuoDYljPKKO2eIg4bBlQusGr4g1m0DWrmMh0UK6hG
	/HEOf7xoboouoIYjNLUFxiiq0zIxiYA=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-664-ZEUE_xkkMXmtZVsVH3faVw-1; Tue,
 02 Jul 2024 00:07:41 -0400
X-MC-Unique: ZEUE_xkkMXmtZVsVH3faVw-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 76AD418D6506;
	Tue,  2 Jul 2024 04:07:33 +0000 (UTC)
Received: from fedora (unknown [10.72.112.45])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6102F19560A3;
	Tue,  2 Jul 2024 04:07:24 +0000 (UTC)
Date: Tue, 2 Jul 2024 12:07:18 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Uday Shankar <ushankar@purestorage.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: Re: [PATCH 2/4] ublk: refactor recovery configuration flag helpers
Message-ID: <ZoN89mOKhynY/zbn@fedora>
References: <20240617194451.435445-1-ushankar@purestorage.com>
 <20240617194451.435445-3-ushankar@purestorage.com>
 <ZnDs5zLc5oA1jPVA@fedora>
 <ZnxOYyWV/E54qOAM@dev-ushankar.dev.purestorage.com>
 <Zny9vr/2iHIkc2bC@fedora>
 <Zn2cuwpM+/dK/682@dev-ushankar.dev.purestorage.com>
 <ZoFkFB8Fcw5gCDln@fedora>
 <ZoMZeWrQclRu2k9s@dev-ushankar.dev.purestorage.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZoMZeWrQclRu2k9s@dev-ushankar.dev.purestorage.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On Mon, Jul 01, 2024 at 03:02:49PM -0600, Uday Shankar wrote:
> On Sun, Jun 30, 2024 at 09:56:36PM +0800, Ming Lei wrote:
> > I meant that the following one-line patch may address your issue:
> > 
> > 
> > diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> > index 4e159948c912..a89240f4f7b0 100644
> > --- a/drivers/block/ublk_drv.c
> > +++ b/drivers/block/ublk_drv.c
> > @@ -1068,7 +1068,7 @@ static inline void __ublk_abort_rq(struct ublk_queue *ubq,
> >  		struct request *rq)
> >  {
> >  	/* We cannot process this rq so just requeue it. */
> > -	if (ublk_queue_can_use_recovery(ubq))
> > +	if (ublk_queue_can_use_recovery_reissue(ubq))
> >  		blk_mq_requeue_request(rq, false);
> >  	else
> >  		blk_mq_end_request(rq, BLK_STS_IOERR);
> 
> It does not work (ran the same test from my previous email, got the same
> results), and how could it? As I've already mentioned several times, the
> root of the issue is that when UBLK_F_USER_RECOVERY is set, the request
> queue remains quiesced when the server has exited. Quiescing the queue
> means that the block layer will not call the driver's queue_rq when I/Os
> are submitted. Instead the block layer will queue those I/Os internally,
> only submitting them to the driver when the queue is unquiesced, which,
> in the current ublk_drv, only happens when the device is recovered or
> deleted.
> 
> Having ublk_drv return errors to I/Os issued while there is no ublk
> server requires the queue to be unquiesced. My patchset actually does
> this (see patch 4/4).

Sorry for ignoring the fact that queue is kept as quiesced after ublk
server is crashed, and I will review patch 4 soon.


Thanks,
Ming

