Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AA23C2ED
	for <linux-block@vger.kernel.org>; Thu,  7 Nov 2024 01:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730942594; cv=none; b=T5Wnth8pbjkScPA887CS63YiCgGsJMOQeYxbK8xWMj81Nsrn0tifyH0dcZFJvgT2l7dII/fMvel/u5vwbzEFUc2Foj0RU+x1qGQMvbfpX1JasCIxS+y8t1uRFrg28s3677ghBNuE8OkNYE+8S4ZDblsnMoZQOezN1gOdyhcf2eo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730942594; c=relaxed/simple;
	bh=lO8jMmeciwyw3nKZRm4PImIztzFClbfNd6hS49UkEfM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pgwcM9XXrFpOjvKoyNDGmXkTlkmcFdSPblxqt1oii/zLVmOMvOjz/diC7uOwLpkdnEYycndhaBxrZC3ZIVncuunhzeZ9w/OsW26ovKjb3ZJSJd9QDgy/0MEluz2lDc4KgFI8ddQ2NZt7D4Vt40LND0mVm3Ja+HPQbIlXGFizvOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ejbC1rGU; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ejbC1rGU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730942591;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+GrivlArMJW6RGuGOgaXa80GXlOmJ0sRIUvVkMBG7pc=;
	b=ejbC1rGUvwVKO3mSV5JBvSzuD0Q4sE2QIWI2eQF7D4WgNhhTiPj8CW2dx5P8xc2g/xSfNX
	HMIYzjSJyEv48t1S3xGphvwZgRK+ALoLxjX8HILpzGKdK/yBUTN/3VKseGHDCR24Il+e4B
	bdI6Kqyel2miI8SlRcg7EIrA3Ifso7g=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-107-0wjN3JwzP56B0J-9M4CHBQ-1; Wed,
 06 Nov 2024 20:23:05 -0500
X-MC-Unique: 0wjN3JwzP56B0J-9M4CHBQ-1
X-Mimecast-MFC-AGG-ID: 0wjN3JwzP56B0J-9M4CHBQ
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 05950195604F;
	Thu,  7 Nov 2024 01:23:04 +0000 (UTC)
Received: from fedora (unknown [10.72.116.47])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2655519560AA;
	Thu,  7 Nov 2024 01:22:58 +0000 (UTC)
Date: Thu, 7 Nov 2024 09:22:53 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: io-uring@vger.kernel.org, Pavel Begunkov <asml.silence@gmail.com>,
	linux-block@vger.kernel.org,
	Uday Shankar <ushankar@purestorage.com>,
	Akilesh Kailash <akailash@google.com>
Subject: Re: [PATCH V9 4/7] io_uring: reuse io_mapped_buf for kernel buffer
Message-ID: <ZywWbb_RmuA9hp3Z@fedora>
References: <20241106122659.730712-1-ming.lei@redhat.com>
 <20241106122659.730712-5-ming.lei@redhat.com>
 <e27c7b11-4fa0-4c51-a596-67c0773a657a@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e27c7b11-4fa0-4c51-a596-67c0773a657a@kernel.dk>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

On Wed, Nov 06, 2024 at 08:15:13AM -0700, Jens Axboe wrote:
> On 11/6/24 5:26 AM, Ming Lei wrote:
> > Prepare for supporting kernel buffer in case of io group, in which group
> > leader leases kernel buffer to io_uring, and consumed by io_uring OPs.
> > 
> > So reuse io_mapped_buf for group kernel buffer, and unfortunately
> > io_import_fixed() can't be reused since userspace fixed buffer is
> > virt-contiguous, but it isn't true for kernel buffer.
> > 
> > Also kernel buffer lifetime is bound with group leader request, it isn't
> > necessary to use rsrc_node for tracking its lifetime, especially it needs
> > extra allocation of rsrc_node for each IO.
> 
> While it isn't strictly necessary, I do think it'd clean up the io_kiocb
> parts and hopefully unify the assign and put path more. So I'd strongly
> suggest you do use an io_rsrc_node, even if it does just map the
> io_mapped_buf for this.

Can you share your idea about how to unify buffer? I am also interested
in this area, so I may take it into account in this patch.

Will you plan to use io_rsrc_node for all buffer type(include buffer
select)?

> 
> > +struct io_mapped_buf {
> > +	u64		start;
> > +	unsigned int	len;
> > +	unsigned int	nr_bvecs;
> > +
> > +	/* kbuf hasn't refs and accounting, its lifetime is bound with req */
> > +	union {
> > +		struct {
> > +			refcount_t	refs;
> > +			unsigned int	acct_pages;
> > +		};
> > +		/* pbvec is only for kbuf */
> > +		const struct bio_vec	*pbvec;
> > +	};
> > +	unsigned int	folio_shift:6;
> > +	unsigned int	dir:1;		/* ITER_DEST or ITER_SOURCE */
> > +	unsigned int	kbuf:1;		/* kernel buffer or not */
> > +	/* offset in the 1st bvec, for kbuf only */
> > +	unsigned int	offset;
> > +	struct bio_vec	bvec[] __counted_by(nr_bvecs);
> > +};
> 
> And then I'd get rid of this union, and have it follow the normal rules
> for an io_mapped_buf in that the refs are valid. Yes it'll take 8b more,
> but honestly I think unifying these bits and keeping it consistent is a
> LOT more important than saving a bit of space.
> 
> This is imho the last piece missing to make this conform more nicely
> with how resource nodes are generally handled and used.

OK.


thanks,
Ming

