Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B8732F4333
	for <linux-block@vger.kernel.org>; Fri, 13 Jun 2025 04:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749790619; cv=none; b=J13MBhM7lGwHBKZeTcSL+ZaNHNvdzmCz0tpdJ0qkeeAuiuTjh4XJXr6PwwGl9TH5m2EeLWjeKihuCuvM4dfaC6A0ujxLaO3TsZOddULc/LGDABoFa01UC1brZ8e3rfjm6WdFPGBkbt3Y7ZOzak9DzlIhjrwiz59ZQxmBv7/b1q4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749790619; c=relaxed/simple;
	bh=gi7/BSDVNb7O2bJcvH7LRMv3hJdUoqoKrn7QiBdXi3M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UxSYwLmVksVg6TigTslLwysJCAZW2mfJtQxMlARMqw1VRKhIoYvg6Mduji5b06/pGKBa2Gwy1289VjUaGLhzg3/A43NZUak2sneFCmhnb8FsfD1579NGyrLk68cSINbP0ASHU4lHNNyVWL1ECWkqWQ8bq5+253xudBb4dKPNat8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZdkL6JRk; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZdkL6JRk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749790615;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=07mu1H2Fz6+UQ8LWJqAXuVs0XQYIbPBJGblMDKiU/bE=;
	b=ZdkL6JRkC2VbfDm2HWA/NTpVTcJBk7e1hWcWh7s6mbzU6wctZk9p75OgmXevvckLenxIiE
	GC3BE4PYK3xdv+bLjQbhRCKHYmd+B+oN6N+aqDeuhGdv4BqN21e4M6D1BmAGejwX65v7kg
	sjgaE6tDm2n2Qu3x/9S9x5pBA9fonE0=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-193-QZcifxZZPGqh1SdGkHd1Rg-1; Fri,
 13 Jun 2025 00:56:54 -0400
X-MC-Unique: QZcifxZZPGqh1SdGkHd1Rg-1
X-Mimecast-MFC-AGG-ID: QZcifxZZPGqh1SdGkHd1Rg_1749790612
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6A80519560AD;
	Fri, 13 Jun 2025 04:56:51 +0000 (UTC)
Received: from fedora (unknown [10.72.116.73])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C8B56195E340;
	Fri, 13 Jun 2025 04:56:45 +0000 (UTC)
Date: Fri, 13 Jun 2025 12:56:40 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: Sagi Grimberg <sagi@grimberg.me>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	linux-block <linux-block@vger.kernel.org>,
	Hannes Reinecke <hare@kernel.org>, Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	"hch@infradead.org" <hch@infradead.org>
Subject: Re: [PATCH 1/2] nvme-tcp: avoid race between nvme scan and reset
Message-ID: <aEuviL5O2kD70Sij@fedora>
References: <20250602043522.55787-1-shinichiro.kawasaki@wdc.com>
 <20250602043522.55787-2-shinichiro.kawasaki@wdc.com>
 <910b31ba-1982-4365-961e-435f5e7611b2@grimberg.me>
 <86e241dd-9065-4cf0-9c35-8b7502ab2d8a@grimberg.me>
 <6pt5u3fg3qts4jekun5ory5lr2jtfbibd76phqviheulpjqjtq@m3arkh44nrs2>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6pt5u3fg3qts4jekun5ory5lr2jtfbibd76phqviheulpjqjtq@m3arkh44nrs2>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

On Wed, Jun 04, 2025 at 11:17:05AM +0000, Shinichiro Kawasaki wrote:
> Cc+: Ming,
> 
> Hi Sagi, thanks for the background explanation and the suggestion.
> 
> On Jun 04, 2025 / 10:10, Sagi Grimberg wrote:
> ...
> > > This is a problem. We are flushing a work that is IO bound, which can
> > > take a long time to complete.
> > > Up until now, we have deliberately avoided introducing dependency
> > > between reset forward progress
> > > and scan work IO to completely finish.
> > > 
> > > I would like to keep it this way.
> > > 
> > > BTW, this is not TCP specific.
> 
> I see. The blktests test case nvme/063 is dedicated to tcp transport, so that's
> why it was reported for the TCP transport.
> 
> > 
> > blk_mq_unquiesce_queue is still very much safe to call as many times as we
> > want.
> > The only thing that comes in the way is this pesky WARN. How about we make
> > it go away and have
> > a debug print instead?
> > 
> > My preference would be to allow nvme to unquiesce queues that were not
> > previously quiesced (just
> > like it historically was) instead of having to block a controller reset
> > until the scan_work is completed (which
> > is admin I/O dependent, and may get stuck until admin timeout, which can be
> > changed by the user for 60
> > minutes or something arbitrarily long btw).
> > 
> > How about something like this patch instead:
> > --
> > diff --git a/block/blk-mq.c b/block/blk-mq.c
> > index c2697db59109..74f3ad16e812 100644
> > --- a/block/blk-mq.c
> > +++ b/block/blk-mq.c
> > @@ -327,8 +327,10 @@ void blk_mq_unquiesce_queue(struct request_queue *q)
> >         bool run_queue = false;
> > 
> >         spin_lock_irqsave(&q->queue_lock, flags);
> > -       if (WARN_ON_ONCE(q->quiesce_depth <= 0)) {
> > -               ;
> > +       if (q->quiesce_depth <= 0) {
> > +               printk(KERN_DEBUG
> > +                       "dev %s: unquiescing a non-quiesced queue,
> > expected?\n",
> > +                       q->disk ? q->disk->disk_name : "?", );
> >         } else if (!--q->quiesce_depth) {
> >                 blk_queue_flag_clear(QUEUE_FLAG_QUIESCED, q);
> >                 run_queue = true;
> > --
> 
> The WARN was introduced with the commit e70feb8b3e68 ("blk-mq: support
> concurrent queue quiesce/unquiesce") that Ming authored. Ming, may I
> ask your comment on the suggestion by Sagi?

I think it is bad to use one standard block layer API in this unbalanced way,
that is why WARN_ON_ONCE() is added. We shouldn't encourage driver to use
APIs in this way.

Question is why nvme have to unquiesce one non-quiesced queue?



Thanks,
Ming

