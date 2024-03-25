Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C5AD38D595
	for <linux-block@vger.kernel.org>; Mon, 25 Mar 2024 03:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711335841; cv=none; b=h/tutczqauEhW0xqNNirOYwAhJ/Tk9k3dDW/b7Hq5nDswBQ/g5wciGyWfsFR5ULTLhUF0HvqYtYsr3ADTLykLaIpISUBTb4j766JrMilrLUIHuWahEjkYLVrkGdrGumvAVijCqbYgrCUZhn2FcpvYmERjFtCUkqpio9TdNJmsX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711335841; c=relaxed/simple;
	bh=SsZwsTQPGoRq8DsmOf3FwZDrEyxPF4BuacI8iAHPR7k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pc9qnDwnKzPrYFUoCbWdyYDG7lkGtNnwsNl1rHx6Fno7hsTDOQ/eitKuML0vzV9D/JN6ad+uCh7ukOsj8P5qfKYD7DtomD0oP8pPZTlqCFDSxUBlkq7yDIffsHpcm4IX3R3SBF4Qkds8uJh3j385bdeAiX1zuDvTX2hGau79idA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NhwDc5PM; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NhwDc5PM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711335837;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EuYBp3K/1LYyLHtThZ4W9rOXrFo+oIhHa5mqOmi1rMo=;
	b=NhwDc5PM469K8KVvdu99vH3ybwrHkGEftGpH2eEtTlX+ArtgISubLi2UNZl+Z4VRop4XPw
	+gub3mrTn+qzmkMhZK+85Q2BwOaJhLUgXI537rIfayncPobunxt/wldaiJDpESIce0hk9u
	TE9VkvkFBn/7ymt2NjkcGaAcVubZ23M=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-224-Ye4iJ2KKPiaQSEcJkNgvpQ-1; Sun,
 24 Mar 2024 23:03:53 -0400
X-MC-Unique: Ye4iJ2KKPiaQSEcJkNgvpQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 471402801E5B;
	Mon, 25 Mar 2024 03:03:53 +0000 (UTC)
Received: from fedora (unknown [10.72.116.37])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 314923C54;
	Mon, 25 Mar 2024 03:03:48 +0000 (UTC)
Date: Mon, 25 Mar 2024 11:03:25 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Keith Busch <kbusch@kernel.org>,
	Bart Van Assche <bvanassche@acm.org>,
	Mikulas Patocka <mpatocka@redhat.com>,
	Mike Snitzer <snitzer@kernel.org>, ming.lei@redhat.com
Subject: Re: [PATCH V2] block: fail unaligned bio from submit_bio_noacct()
Message-ID: <ZgDpfW8HRHrZgQYv@fedora>
References: <20240324133702.1328237-1-ming.lei@redhat.com>
 <ZgC2UPEBOSLW9Xdz@infradead.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZgC2UPEBOSLW9Xdz@infradead.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1

On Sun, Mar 24, 2024 at 04:25:04PM -0700, Christoph Hellwig wrote:
> On Sun, Mar 24, 2024 at 09:37:02PM +0800, Ming Lei wrote:
> > +static bool bio_check_alignment(struct bio *bio, struct request_queue *q)
> > +{
> > +	unsigned int bs = q->limits.logical_block_size;
> > +
> > +	if (bio->bi_iter.bi_size & (bs - 1))
> > +		return false;
> > +
> > +	if (bio->bi_iter.bi_sector & ((bs >> SECTOR_SHIFT) - 1))
> > +		return false;
> > +
> > +	return true;
> > +}
> 
> 
> This should still use bdev_logic_block_size.  And maybe it's just me,
> but I think dropping thelines after the false returns would actually
> make it more readle.

OK, will remove the blank line.

> 
> > diff --git a/block/fops.c b/block/fops.c
> > index 679d9b752fe8..75595c728190 100644
> > --- a/block/fops.c
> > +++ b/block/fops.c
> > @@ -37,8 +37,7 @@ static blk_opf_t dio_bio_write_op(struct kiocb *iocb)
> >  static bool blkdev_dio_unaligned(struct block_device *bdev, loff_t pos,
> >  			      struct iov_iter *iter)
> >  {
> > -	return pos & (bdev_logical_block_size(bdev) - 1) ||
> > -		!bdev_iter_is_aligned(bdev, iter);
> > +	return !bdev_iter_is_aligned(bdev, iter);
> 
> If you drop this:
> 
>  - we now actually go all the way down to building and submiting a
>    bio for a trivial bounds check.
>  - your get a trivial to trigger WARN_ON.
> 
> I'd strongly advise against dropping this check.

OK.

Also only q->limits.logical_block_size is fetched for small BS IO
fast path, I think log(lbs) can be cached in request_queue for avoiding the
extra fetch of q.limits. Especially, it could be easier to do so
with your recent queue limit atomic update changes.


Thanks, 
Ming

