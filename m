Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 670A3125D6
	for <linux-block@vger.kernel.org>; Tue, 25 Mar 2025 00:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742863857; cv=none; b=M7HJwtsPqKSIYLdX9OZZ0Ai1R6zlUvIVug25pajgLfwkxdGwael3gRoEML9sZGtvZOhTLiOV6SAsjXVHONFGyhGFmYoNr8S8DOkna8Oh3AanqB0I93MMX2/XNCj4M+ImLLWsRcwKvGvUdnzQxLn6uQLBfrsXuZuqbCYn4GcDl2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742863857; c=relaxed/simple;
	bh=a6nmB6L6DUmBwFiW/YmfShsXkd7iR+WINYE2YlLTQvY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I4zURSqeyK5MLZI2VcXKuXUBFyJgDF5RposxTmGAshzmOSUvRAqgVawxSZl4fpVogVAfUAfiy3UTOqk1kYqwC8QeyVPWq4kkjcDtC4AOwXeRDROOZsnqH6BQqF+Ks+8q7oaMwGp+uD3vuBsg+9HsW/M7fWkllGnzEfBff3Lh6ms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WfxWBcPo; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WfxWBcPo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742863854;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=luROiX77+To1tgV51nB+9nLdqJWLeksXlSdAkkk3+zU=;
	b=WfxWBcPojog0IbGf9R+G9+dTaiRk9Efl9pmJ/bUtNOu5FSpQxMV/4bhS6TFldPQCGnR+F8
	UxbKT6zOyITf7ZK76YTKZfYa+DvAHL/zqPR7UNTKMLR0jIfCHHDZXbIf3VNSwwCjwgSL/O
	Mjx2BHohO9GzW8xKJvyGilyDCzQKzOc=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-648-Wfr3tyBUM8a7N0Cq_pxyRQ-1; Mon,
 24 Mar 2025 20:50:52 -0400
X-MC-Unique: Wfr3tyBUM8a7N0Cq_pxyRQ-1
X-Mimecast-MFC-AGG-ID: Wfr3tyBUM8a7N0Cq_pxyRQ_1742863851
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B22BF196D2CF;
	Tue, 25 Mar 2025 00:50:50 +0000 (UTC)
Received: from fedora (unknown [10.72.120.10])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6A802180A802;
	Tue, 25 Mar 2025 00:50:45 +0000 (UTC)
Date: Tue, 25 Mar 2025 08:50:40 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Keith Busch <kbusch@kernel.org>,
	Uday Shankar <ushankar@purestorage.com>
Subject: Re: [PATCH 3/8] ublk: truncate io command result
Message-ID: <Z-H94M9hrFd4b3Lt@fedora>
References: <20250324134905.766777-1-ming.lei@redhat.com>
 <20250324134905.766777-4-ming.lei@redhat.com>
 <CADUfDZrRqyPkG2cQdsfvjXBS9Y4aU7ETPv3T1t=K4NGqvRzH2Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADUfDZrRqyPkG2cQdsfvjXBS9Y4aU7ETPv3T1t=K4NGqvRzH2Q@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

On Mon, Mar 24, 2025 at 08:51:20AM -0700, Caleb Sander Mateos wrote:
> On Mon, Mar 24, 2025 at 6:49 AM Ming Lei <ming.lei@redhat.com> wrote:
> >
> > If io command result is bigger than request bytes, truncate it to request
> > bytes. This way is more reliable, and avoids potential risk, even though
> > both blk_update_request() and ublk_copy_user_pages() works fine in this
> > way.
> >
> > Signed-off-by: Ming Lei <ming.lei@redhat.com>
> > ---
> >  drivers/block/ublk_drv.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> >
> > diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> > index 6fa1384c6436..acb6aed7be75 100644
> > --- a/drivers/block/ublk_drv.c
> > +++ b/drivers/block/ublk_drv.c
> > @@ -1071,6 +1071,10 @@ static inline void __ublk_complete_rq(struct request *req)
> >                 goto exit;
> >         }
> >
> > +       /* truncate result in case it is bigger than request bytes */
> > +       if (io->res > blk_rq_bytes(req))
> > +               io->res = blk_rq_bytes(req);
> 
> Is this not already handled by the code below that caps io->res?
> 
> unmapped_bytes = ublk_unmap_io(ubq, req, io);
> // ...
> if (unlikely(unmapped_bytes < io->res))
>         io->res = unmapped_bytes;
> 
> ublk_unmap_io() returns either blk_rq_bytes(req) or the result of
> ublk_copy_user_pages(), which should be at most blk_rq_bytes(req)?

Indeed, this patch can be dropped.


thanks,
Ming

