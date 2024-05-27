Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99B1E17E919
	for <linux-block@vger.kernel.org>; Mon, 27 May 2024 15:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716824260; cv=none; b=RwRJKjgiTAXjRt3Olg8GIIx2JyoVGsRMtENPdirQkMlp2uqP3zcY6LTjccCXt/TBNc11Ykl4qVtzyBcTh+/chy4HfCQk+pXiCUOoSwI75DYcFE2lvPnyxk5E3K6zwicc6NjeSquzDgMz3Ht+qJ6m3er7yTJurFW7AhqmQnQKpBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716824260; c=relaxed/simple;
	bh=8DuBb4I+WmufWXyQTj6ZYCNJCfxzhPslFOkZ2ItMk78=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=VzZqYo+ylNaW/C1Ac5GeQcmruVaEQM5aSfxyQ7UlLR3xGekPDCN9MhFg5sUwBnCThWAgT2SGsNEzBBDLHGibqEnLzptB4n8lH8UdSO9NvBq5VpG5KQgmqi8ocDSYhHzm3A++PijoU84W7cxcWRfpCUM1p1HSuzv7ortr3gZOXSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=E5b8K1Rt; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E5b8K1Rt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716824257;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NeXGDE1Zd3UVqjc71kTNguAEIXxiL/niwqnfN+tZYHo=;
	b=E5b8K1RtHfeaIYrObeLTt3QuqYS2IEXpBVIILpO4TargTgKB8l9XrM/6ORrJ9/Oz5VlfhL
	24lEfLOLLjHmlEb/76KxbnL/Xn0NCw21PSYgiY+wP0SaSyWvZrz3wW77cMAxwr/dqzTU6n
	dRbRI08FBy1DIPpSpFFxZIFmd/cFUXY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-657-DwAo0QayNdKrhUU9T4FZLQ-1; Mon, 27 May 2024 11:37:30 -0400
X-MC-Unique: DwAo0QayNdKrhUU9T4FZLQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5CA56800169;
	Mon, 27 May 2024 15:37:29 +0000 (UTC)
Received: from file1-rdu.file-001.prod.rdu2.dc.redhat.com (unknown [10.11.5.21])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id E9C65105480A;
	Mon, 27 May 2024 15:37:28 +0000 (UTC)
Received: by file1-rdu.file-001.prod.rdu2.dc.redhat.com (Postfix, from userid 12668)
	id D2BB930C1C33; Mon, 27 May 2024 15:37:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by file1-rdu.file-001.prod.rdu2.dc.redhat.com (Postfix) with ESMTP id CEE993C542;
	Mon, 27 May 2024 17:37:28 +0200 (CEST)
Date: Mon, 27 May 2024 17:37:28 +0200 (CEST)
From: Mikulas Patocka <mpatocka@redhat.com>
To: Christoph Hellwig <hch@lst.de>
cc: Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>, 
    Sagi Grimberg <sagi@grimberg.me>, Mike Snitzer <snitzer@kernel.org>, 
    Milan Broz <gmazyland@gmail.com>, Anuj gupta <anuj1072538@gmail.com>, 
    linux-block@vger.kernel.org, dm-devel@lists.linux.dev, 
    linux-nvme@lists.infradead.org
Subject: Re: [PATCH 1/2 v3] block: change rq_integrity_vec to respect the
 iterator
In-Reply-To: <20240523171922.GA5892@lst.de>
Message-ID: <34bda7d9-378c-5d2-6fd-138a71140cf@redhat.com>
References: <a1d8771a-70ad-9eed-476c-af696d2f9ac2@redhat.com> <d27da881-e615-b081-d8db-17ac9b91d4be@redhat.com> <20240523171922.GA5892@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3



On Thu, 23 May 2024, Christoph Hellwig wrote:

> On Thu, May 23, 2024 at 06:54:47PM +0200, Mikulas Patocka wrote:
> > 
> > However, the function rq_integrity_vec has a bug - it returns the first
> > vector of the bio's metadata and completely disregards the metadata
> > iterator that was advanced when the bio was split. Thus, the second bio
> > uses the same metadata as the first bio and this leads to metadata
> > corruption.
> > 
> > This commit changes rq_integrity_vec, so that it calls mp_bvec_iter_bvec
> > instead of returning the first vector. mp_bvec_iter_bvec reads the
> > iterator and advances the vector by the iterator.
> 
> mp_bvec_iter_bvec does not advance the bvec_iter, it just uses the
> iter to build a bvec for the current position in the iter.
> 
> Also please fix the commit log to not use more than 73 characters,
> as-is it will be unreadable in git show output or email replies.

OK. I thought that the limit was 74.

> > -static inline struct bio_vec *rq_integrity_vec(struct request *rq)
> > +static inline struct bio_vec rq_integrity_vec(struct request *rq)
> >  {
> >  	if (WARN_ON_ONCE(queue_max_integrity_segments(rq->q) > 1))
> > +		return (struct bio_vec){ };
> > +	return mp_bvec_iter_bvec(rq->bio->bi_integrity->bip_vec,
> > +				 rq->bio->bi_integrity->bip_iter);
> 
> The queue_max_integrity_segments check can go away now.  Once you
> use the bvec_iter the function works just fine for multiple
> integrity segments and always returns the one at the current iter
> position.   That should preferably also documented in a comment.

Yes, I dropped this and I am resending a new version.

> (I'm also pretty sure I've already written this in reply to Anuj's
> version of the patch)

Mikulas

