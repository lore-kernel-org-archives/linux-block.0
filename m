Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 311CB3451A8
	for <linux-block@vger.kernel.org>; Tue, 11 Nov 2025 01:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762824164; cv=none; b=Q888I3WsbSfS3wW5xtsRMKGSNoE5u0xmOVDr/9NXp98y6m6Inkwgrj19xQ2mNcSCxIh96G94YgNcd1X/P8g0wQmN0ISbIF7GIV5nQweqZbs+mkLoNBGwRP3DLsGvaJsYk6IHRXl0gBKDz5dO3//efID7oorBpWWAURrpfUDxmQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762824164; c=relaxed/simple;
	bh=EwY1mUUQSmUNg/bnQGwuIvfCAxj9fZHnOjpw5NoP0mw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zn4hmYAh2YCC9gMJi1jFs06cPsmu2+rf+Wmcwg4I/g/NeR4yPHbsONR4a0ex8aZNnmyCGnUELdDg8nSPQVrA4fILwU2l0Fzt2PKYRj6nlRqeexK2r5B5PUW1KoksGTOYxNKLikL5ji89txEUsvlLqxWaSrkDXDLWMhsbLV7LujM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UvCvozKZ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UvCvozKZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762824162;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=no9fwGymXdAQv8M8IFgXqJIUpl2VhuFy6hctsstQJhY=;
	b=UvCvozKZ/6HCMX/mlszW74icjuyBa4aVxZ4mhAX73oMgD6HWOuZXX0qYnLWU2XBi8QihXM
	OK1szhOZZ+MixIpjfJdpAKdWU22lxCpf+NsRTI+kOSoAc7cF8a1tvm+BdikR+/gMNI8Qqc
	y4X1MFV/5QeZQC8nS2ouhgh1sovsD6k=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-379-rFCgNHIaPj24v2xp5QjEyQ-1; Mon,
 10 Nov 2025 20:22:38 -0500
X-MC-Unique: rFCgNHIaPj24v2xp5QjEyQ-1
X-Mimecast-MFC-AGG-ID: rFCgNHIaPj24v2xp5QjEyQ_1762824157
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4961819560A3;
	Tue, 11 Nov 2025 01:22:37 +0000 (UTC)
Received: from fedora (unknown [10.72.116.124])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 96A65180057B;
	Tue, 11 Nov 2025 01:22:32 +0000 (UTC)
Date: Tue, 11 Nov 2025 09:22:27 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Jens Axboe <axboe@kernel.dk>, Damien Le Moal <dlemoal@kernel.org>,
	Christoph Hellwig <hch@lst.de>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH 1/2] loop: use blk_rq_nr_phys_segments() instead of
 iterating bvecs
Message-ID: <aRKP03sNaFcp0Sjn@fedora>
References: <20251108230101.4187106-1-csander@purestorage.com>
 <20251108230101.4187106-2-csander@purestorage.com>
 <aRCG3OUThPCys92r@fedora>
 <CADUfDZocSmRC2uSiY=1gayxQ5TGAcCnKQRSg+4SeficpQ3Bfhw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADUfDZocSmRC2uSiY=1gayxQ5TGAcCnKQRSg+4SeficpQ3Bfhw@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

On Mon, Nov 10, 2025 at 08:47:46AM -0800, Caleb Sander Mateos wrote:
> On Sun, Nov 9, 2025 at 4:20 AM Ming Lei <ming.lei@redhat.com> wrote:
> >
> > On Sat, Nov 08, 2025 at 04:01:00PM -0700, Caleb Sander Mateos wrote:
> > > The number of bvecs can be obtained directly from struct request's
> > > nr_phys_segments field via blk_rq_nr_phys_segments(), so use that
> > > instead of iterating over the bvecs an extra time.
> > >
> > > Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
> > > ---
> > >  drivers/block/loop.c | 5 +----
> > >  1 file changed, 1 insertion(+), 4 deletions(-)
> > >
> > > diff --git a/drivers/block/loop.c b/drivers/block/loop.c
> > > index 13ce229d450c..8096478fad45 100644
> > > --- a/drivers/block/loop.c
> > > +++ b/drivers/block/loop.c
> > > @@ -346,16 +346,13 @@ static int lo_rw_aio(struct loop_device *lo, struct loop_cmd *cmd,
> > >       struct request *rq = blk_mq_rq_from_pdu(cmd);
> > >       struct bio *bio = rq->bio;
> > >       struct file *file = lo->lo_backing_file;
> > >       struct bio_vec tmp;
> > >       unsigned int offset;
> > > -     int nr_bvec = 0;
> > > +     unsigned short nr_bvec = blk_rq_nr_phys_segments(rq);
> > >       int ret;
> > >
> > > -     rq_for_each_bvec(tmp, rq, rq_iter)
> > > -             nr_bvec++;
> > > -
> >
> > The two may not be same, since one bvec can be splitted into multiple segments.
> 
> Hmm, io_buffer_register_bvec() already assumes
> blk_rq_nr_phys_segments() returns the number of bvecs iterated by
> rq_for_each_bvec(). I asked about this on the patch adding it, but
> Keith assures me they match:
> https://lore.kernel.org/io-uring/Z7TmrB4_aBnZdFbo@kbusch-mbp/.

blk_rq_nr_phys_segments() >= nr_bvec, would you like to cook a fix?

Thanks, 
Ming

