Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89A9F1EB2C
	for <linux-block@vger.kernel.org>; Sun, 30 Jun 2024 13:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719755829; cv=none; b=Hxckk+j7iVlibD6Rtk0iqVghEUOOLslc8geUEgTHR9JAv/fxbw5EQGS0NI7zNwnhL95fJTbLQz1mEqSzykjfUwL9acp5Z4rEvyNUihmFjVxdV8ckq5sRyV5T8bEVhIuoGX2bKWfLuyYC+LeuQzadgHtfICOS2EknSwWEjKskg/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719755829; c=relaxed/simple;
	bh=NUszRWpN8BomzZSv5/cRbw7K29o5hTg0c4DXHTNcePI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aGqO4iGEAwwIyazPIskuGOI5woN6uNHcIgd9K8RFrVfdQoiWuTOwkxqYhrkAwwpKG17UgJxjvGP069ft+imzPkwhtFFoQPJfwFFyWxe8JuhdbeTE7XGS1AMbny3sySrCuYLhseZHePEgoatm11Z5QSMy7riaH8gSRMb64Q9/5ts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CLdaEvzm; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CLdaEvzm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719755826;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aJfwXGZ0L4yMqtMvAMqcE0BMExirj5kWfu/P3Ffskdg=;
	b=CLdaEvzmfFThzeOxe3xyOt/Ntu5dxsbeTRhrm1IxGXC3aqxbklrYPAkLnjDoede9l3vT8W
	m5KrMNSUVMF8J+OIWfohjED8nZxY+IcA6wMK/s5XXe5X3ctqwYVBsZF3IVJd1VEpk2hus4
	FwxghYifU+43OMbHntBPM1ycNCQsyZI=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-16-8e9GkeqJMS6P9zQA1I0_Vg-1; Sun,
 30 Jun 2024 09:57:04 -0400
X-MC-Unique: 8e9GkeqJMS6P9zQA1I0_Vg-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D8E6A1956080;
	Sun, 30 Jun 2024 13:56:47 +0000 (UTC)
Received: from fedora (unknown [10.72.112.39])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C172A19560AA;
	Sun, 30 Jun 2024 13:56:42 +0000 (UTC)
Date: Sun, 30 Jun 2024 21:56:36 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Uday Shankar <ushankar@purestorage.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	ming.lei@redhat.com
Subject: Re: [PATCH 2/4] ublk: refactor recovery configuration flag helpers
Message-ID: <ZoFkFB8Fcw5gCDln@fedora>
References: <20240617194451.435445-1-ushankar@purestorage.com>
 <20240617194451.435445-3-ushankar@purestorage.com>
 <ZnDs5zLc5oA1jPVA@fedora>
 <ZnxOYyWV/E54qOAM@dev-ushankar.dev.purestorage.com>
 <Zny9vr/2iHIkc2bC@fedora>
 <Zn2cuwpM+/dK/682@dev-ushankar.dev.purestorage.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zn2cuwpM+/dK/682@dev-ushankar.dev.purestorage.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On Thu, Jun 27, 2024 at 11:09:15AM -0600, Uday Shankar wrote:
> When I say "behavior A + 2," I mean behavior A and behavior 2 at the
> same time on the same ublk device. I still think this is not supported
> with current ublk_drv, see below.
> 
> > > the ublk server can "handle" the I/O error because during this time,
> > > there is no ublk server and all decisions on how to handle I/O are made
> > > by ublk_drv directly (based on configuration flags specified when the
> > > device was created).
> > > 
> > > If the ublk server created the device with UBLK_F_USER_RECOVERY, then
> > > when the ublk server has crashed (and not restarted yet), I/Os issued by
> > > the application will queue/hang until the ublk server comes back and
> > > recovers the device, because the underlying request_queue is left in a
> > > quiesced state. So in this case, behavior A is not possible.
> > 
> > When ublk server is crashed, ublk_abort_requests() will be called to fail
> > queued inflight requests. Meantime ubq->canceling is set to requeue
> > new request instead of forwarding it to ublk server.
> > 
> > So behavior A should be supported easily by failing request in
> > ublk_queue_rq() if ubq->canceling is set.
> 
> This argument only works for devices created without
> UBLK_F_USER_RECOVERY. If UBLK_F_USER_RECOVERY is set, then the
> request_queue for the device is left in a quiesced state and so I/Os
> will not even get to ublk_queue_rq. See the following as proof (using a
> build of ublksrv master):

I meant that the following one-line patch may address your issue:


diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 4e159948c912..a89240f4f7b0 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -1068,7 +1068,7 @@ static inline void __ublk_abort_rq(struct ublk_queue *ubq,
 		struct request *rq)
 {
 	/* We cannot process this rq so just requeue it. */
-	if (ublk_queue_can_use_recovery(ubq))
+	if (ublk_queue_can_use_recovery_reissue(ubq))
 		blk_mq_requeue_request(rq, false);
 	else
 		blk_mq_end_request(rq, BLK_STS_IOERR);


Thanks, 
Ming

