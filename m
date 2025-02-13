Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FF2784D13
	for <linux-block@vger.kernel.org>; Thu, 13 Feb 2025 01:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739410210; cv=none; b=diM0tMRJt+D9GgKFFYUBcNPmRUW1/asuULD4xsbAXnQ37QZNh8GQLqOmXBw/+tnYkx0N0an6YBx/LH8VqGKh/5iCXTxD9Dvc/ihGwuAwUL4LDUxvIrCWt1NWSK75fEhFymNxrNEojoV8gH3C8oJHsdTu8YVVYvmvaOFoljd+UHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739410210; c=relaxed/simple;
	bh=EiC1zxjnBJ5sNjP95zBe28pRac4XL9P9q3glJoMkzdg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nNh3thvA5k+p1EXdq+f2FPm73xOTLWJ/5GeaTUa5IukC+MzMG9MMRWS9/S5v4+3eVSJ+Glc6Lz3DPRPpl+mjWSA0j9MBEIiiMffviTThZB7Fd/AGiAi8wORKzHWt3P51ZxmCxjHDO3jB4Kb+BBKY5c6vPa1V0VQeKwXs7GHA1G8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XW273efr; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XW273efr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739410207;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dfI/Q762oLXgRgsEmpqc24xuO0oeEhuZ9btILNENSPw=;
	b=XW273efrynNIhO9+tRDgqtkzvMmfeQsemx535SMH+e4Csg1WnYsWL1BuDZBT+2u+eJtZ5s
	xeRwdOwYitV/yEqwbz7aXHvEuuNrgSWsp5JyamAcgGdcwKHReJ56cE2QdZKceesLocSMN4
	s3xjIMbd3gbAdRbucjZDkzIBWKDI0+w=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-528-b6hIMJYFMxKYngcBoUMI8A-1; Wed,
 12 Feb 2025 20:30:03 -0500
X-MC-Unique: b6hIMJYFMxKYngcBoUMI8A-1
X-Mimecast-MFC-AGG-ID: b6hIMJYFMxKYngcBoUMI8A
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9AC0D1955D68;
	Thu, 13 Feb 2025 01:30:02 +0000 (UTC)
Received: from fedora (unknown [10.72.120.6])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 19CAD19560A3;
	Thu, 13 Feb 2025 01:29:58 +0000 (UTC)
Date: Thu, 13 Feb 2025 09:29:53 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Cheyenne Wills <cheyenne.wills@gmail.com>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>
Subject: Re: BUG: NULL pointer dereferenced within __blk_rq_map_sg
Message-ID: <Z61LEUdHI2Hx3bue@fedora>
References: <CAHpsFVeew-p9xB9DB52Pk_6mXfFxJbT8p14h5+YRTKabEfU3BQ@mail.gmail.com>
 <Z6s-3LndN-Gt5sZB@fedora>
 <Z6tss9YS98AEIwQy@fedora>
 <CAHpsFVcMnSJgJbGrqiBDmYkHyneJdby4DMkOKQKAuicA0kgJQA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHpsFVcMnSJgJbGrqiBDmYkHyneJdby4DMkOKQKAuicA0kgJQA@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

On Wed, Feb 12, 2025 at 04:24:43PM -0700, Cheyenne Wills wrote:
> On Tue, Feb 11, 2025 at 8:29 AM Ming Lei <ming.lei@redhat.com> wrote:
> >
> > On Tue, Feb 11, 2025 at 08:13:16PM +0800, Ming Lei wrote:
> > > On Fri, Feb 07, 2025 at 07:09:39PM -0700, Cheyenne Wills wrote:
> > > > While I was setting up to test with linux 6.14-rc1 (under Xen), I ran
> > > > into a consistent NULL ptr dereference within __blk_rq_map_sg when
> > > > booting the system.
> > > >
> > > > Using git bisect I was able to narrow down the "bad" commit to:
> > > >
> > > > block: add a dma mapping iterator (b7175e24d6acf79d9f3af9ce9d3d50de1fa748ec)
> > > >
> > > > Building a kernel with the parent commit
> > > > (2caca8fc7aad9ea9a6ea3ed26ed146b1e5f06fab) using the same .config does
> > > > not fail.
> > > >
> > > > Following is the console log showing the error as well as the Xen
> > > > (libvirt) configuration for the guest that I'm using.
> > > >
> > > > Please let me know if there is any additional information that I can provide.
> > >
> > > Can you test the following patch?
> > >
> >
> > Please try the revised one:
> >
> >
> > diff --git a/block/blk-merge.c b/block/blk-merge.c
> > index 15cd231d560c..a66d087a6b55 100644
> > --- a/block/blk-merge.c
> > +++ b/block/blk-merge.c
> > @@ -493,7 +493,7 @@ static bool blk_map_iter_next(struct request *req,
> >                 return true;
> >         }
> >
> > -       if (!iter->iter.bi_size)
> > +       if (!iter->bio || !iter->iter.bi_size)
> >                 return false;
> >
> >         bv = mp_bvec_iter_bvec(iter->bio->bi_io_vec, iter->iter);
> > @@ -514,6 +514,8 @@ static bool blk_map_iter_next(struct request *req,
> >                         if (!iter->bio->bi_next)
> >                                 break;
> >                         iter->bio = iter->bio->bi_next;
> > +                       if (!iter->bio)
> > +                               break;
> >                         iter->iter = iter->bio->bi_iter;
> >                 }
> >
> >
> >
> >
> > Thanks,
> > Ming
> >
> 
> Still getting a BUG at the same location.
> 
> I was able to capture the BUG using a xen gdbsx / gdb session (the
> offending instruction is a mov  0x28(%rdx),%r13d and the bug is that
> %rdx is zero. -- break *__blk_rq_map_sg+0x5e if $rdx == 0)
> 
> It appears in __blk_rq_map_sg that the rq->bio is NULL at the start of
> the routine.

Yeah, turns out oops is triggered in initializing req_iterator for
discard req, and the following patch should be enough:


diff --git a/block/blk-merge.c b/block/blk-merge.c
index 15cd231d560c..9d7e87052882 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -556,11 +556,13 @@ int __blk_rq_map_sg(struct request_queue *q, struct request *rq,
 {
 	struct req_iterator iter = {
 		.bio	= rq->bio,
-		.iter	= rq->bio->bi_iter,
 	};
 	struct phys_vec vec;
 	int nsegs = 0;
 
+	if (iter.bio)
+		iter.iter = iter.bio->bi_iter;
+
 	while (blk_map_iter_next(rq, &iter, &vec)) {
 		*last_sg = blk_next_sg(last_sg, sglist);
 		sg_set_page(*last_sg, phys_to_page(vec.paddr), vec.len,


Thanks,
Ming

