Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 778CE1D47B4
	for <linux-block@vger.kernel.org>; Tue,  2 Dec 2025 01:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764638978; cv=none; b=qGMLYR1YuaU+RIubFviG+cAEuk5R2z0T+I7i8LAc8DKMm6gTRdU8TpLGPjedc5cfQ520RXWzsx6D+iCgAPuyWx/3W0Pm2I0IamUGjmCja49oM7bf3IY/HbVq3tNgwq9kLjBrO/MA85VOZuIqwcJtIUNu0hdx0hQxWscr1KIyT88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764638978; c=relaxed/simple;
	bh=I397lrFdGtNJtSo/VgaY3l1RmuCwilrREeiVjcl8zo8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VVbXLxwbdKJ28DZK7SQQryKRUJ7NLbOhu4ltZhL6qafEAEj1cD5acxLUlDYPHmcBWEKUT1J3OONEBRDOaMuLnfYkiyk1P8WTe/dYRc2y0+9cpy9q+S1JCEiv2XDDDEGRijPMZUufPZjIGkRjs6KHiQiD2AhlMcv63O3uG7p5QPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QeNwQXYV; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QeNwQXYV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764638975;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Errt+PLFAL+80J+0Ew6Y2J8hFrZW8rhnsVT3aRf/DZI=;
	b=QeNwQXYVxsFrRLzbSS4dhczWoigkLjx+2Z23Im4sXPHaNl7JPIRh/wSW/ws9XFVE1ezfzD
	jJsBD6acB7yIRgYPPccwUQD1d+0LGWy7bE9S0lFFTY2vHd5sN8fngFQuOWxOKyt6nNY0Hr
	Bz+Jwvj0/85j8EMXsqK83zfrXVoqORI=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-19-YGZFKb5ZMwmYHdYQbGE7ww-1; Mon,
 01 Dec 2025 20:29:32 -0500
X-MC-Unique: YGZFKb5ZMwmYHdYQbGE7ww-1
X-Mimecast-MFC-AGG-ID: YGZFKb5ZMwmYHdYQbGE7ww_1764638971
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DFFF5180034A;
	Tue,  2 Dec 2025 01:29:30 +0000 (UTC)
Received: from fedora (unknown [10.72.116.20])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0E18A1955F1A;
	Tue,  2 Dec 2025 01:29:25 +0000 (UTC)
Date: Tue, 2 Dec 2025 09:29:21 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Uday Shankar <ushankar@purestorage.com>,
	Stefani Seibold <stefani@seibold.net>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH V4 15/27] ublk: abort requests filled in event kfifo
Message-ID: <aS5A8SvQ8ww9JkHa@fedora>
References: <20251121015851.3672073-1-ming.lei@redhat.com>
 <20251121015851.3672073-16-ming.lei@redhat.com>
 <CADUfDZrGq31ayxH-UkU6RcsApQdaqEgehcrVtPyuxXnkTOze1Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADUfDZrGq31ayxH-UkU6RcsApQdaqEgehcrVtPyuxXnkTOze1Q@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On Mon, Dec 01, 2025 at 10:52:22AM -0800, Caleb Sander Mateos wrote:
> On Thu, Nov 20, 2025 at 6:00 PM Ming Lei <ming.lei@redhat.com> wrote:
> >
> > In case of BATCH_IO, any request filled in event kfifo, they don't get
> > chance to be dispatched any more when releasing ublk char device, so
> > we have to abort them too.
> >
> > Add ublk_abort_batch_queue() for aborting this kind of requests.
> >
> > Signed-off-by: Ming Lei <ming.lei@redhat.com>
> > ---
> >  drivers/block/ublk_drv.c | 26 +++++++++++++++++++++++++-
> >  1 file changed, 25 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> > index 2e5e392c939e..849199771f86 100644
> > --- a/drivers/block/ublk_drv.c
> > +++ b/drivers/block/ublk_drv.c
> > @@ -2241,7 +2241,8 @@ static int ublk_ch_mmap(struct file *filp, struct vm_area_struct *vma)
> >  static void __ublk_fail_req(struct ublk_device *ub, struct ublk_io *io,
> >                 struct request *req)
> >  {
> > -       WARN_ON_ONCE(io->flags & UBLK_IO_FLAG_ACTIVE);
> > +       WARN_ON_ONCE(!ublk_dev_support_batch_io(ub) &&
> > +                       io->flags & UBLK_IO_FLAG_ACTIVE);
> >
> >         if (ublk_nosrv_should_reissue_outstanding(ub))
> >                 blk_mq_requeue_request(req, false);
> > @@ -2251,6 +2252,26 @@ static void __ublk_fail_req(struct ublk_device *ub, struct ublk_io *io,
> >         }
> >  }
> >
> > +/*
> > + * Request tag may just be filled to event kfifo, not get chance to
> > + * dispatch, abort these requests too
> > + */
> > +static void ublk_abort_batch_queue(struct ublk_device *ub,
> > +                                  struct ublk_queue *ubq)
> > +{
> > +       while (true) {
> > +               struct request *req;
> > +               short tag;
> 
> unsigned short?

OK.

> 
> > +
> > +               if (!kfifo_out(&ubq->evts_fifo, &tag, 1))
> > +                       break;
> > +
> > +               req = blk_mq_tag_to_rq(ub->tag_set.tags[ubq->q_id], tag);
> > +               if (req && blk_mq_request_started(req))
> 
> If the tag is in the evts_fifo, how would it be possible for the
> request not to have been started yet?

Good point, the above check can be replaced with warn_on_once().


Thanks,
Ming

