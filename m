Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E5EB2629C
	for <linux-block@vger.kernel.org>; Thu, 16 Oct 2025 02:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760581167; cv=none; b=oSqxzdwb834psc90/CnEUgX6PQctckz1hXnUs9mRvsrFeQudWSLeqEYrGzHS1UDLC6abJO9SY3uA0K1wGvVlj8q7LbXO4enAgmZFBFp3oSpuYz0HaPu5KJcNzk2odKRbexYcwpEM+l+wEiC+1kKftLgLoGs4dRNPq1T6sN+xESY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760581167; c=relaxed/simple;
	bh=Wu0eposp83romZJaWXR9fKcBndo/CKDuOlus6T/glnk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HLjQaMLfuLW8W1IWH9bvXnXduqFiGIoLg1Ch+B7NNan4qOzMawBdfz9OmHRKoxyYVwuomA8s1ccRrtsRBeF5l2a/G4zPo8i9CO8tR5g3bkgyNWesRoYG3XVwNAlsQTaSR5ISfY98Pkj9Wxva97gAlJHI0qZ7qTxOZmgln1Oem2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MkHjv6o0; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MkHjv6o0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760581164;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yeP54ynFaqjb+EM3IhJwrQKXgrfPYlUaPvL1iYmjTHo=;
	b=MkHjv6o0yZymxhXHKqYVJ2e9PujUns0+HvZyEN9hbRWOjI6v5NE3icIyvl66FOvOWpfeGH
	xue4dxHz8yC+ev5/VxCRgBjjysljDbxsHXbaEScs99vXETMNwKfd6YAcSpbsKo55ZhTOT7
	990t2A+FCskmrIqNNunG5CPre5jeyO8=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-66-jLDdPPQ8OuWsK1FsRM03VA-1; Wed,
 15 Oct 2025 22:19:20 -0400
X-MC-Unique: jLDdPPQ8OuWsK1FsRM03VA-1
X-Mimecast-MFC-AGG-ID: jLDdPPQ8OuWsK1FsRM03VA_1760581159
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id EBFF3195608F;
	Thu, 16 Oct 2025 02:19:18 +0000 (UTC)
Received: from fedora (unknown [10.72.120.7])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6518830001A1;
	Thu, 16 Oct 2025 02:19:12 +0000 (UTC)
Date: Thu, 16 Oct 2025 10:19:07 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Bart Van Assche <bvanassche@acm.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Mikulas Patocka <mpatocka@redhat.com>,
	Zhaoyang Huang <zhaoyang.huang@unisoc.com>,
	Dave Chinner <dchinner@redhat.com>, linux-fsdevel@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH V5 1/6] loop: add helper lo_cmd_nr_bvec()
Message-ID: <aPBWGzcuqENGqwAJ@fedora>
References: <20251015110735.1361261-1-ming.lei@redhat.com>
 <20251015110735.1361261-2-ming.lei@redhat.com>
 <5692dd74-ab1c-4451-9d28-b436ee658f6e@acm.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5692dd74-ab1c-4451-9d28-b436ee658f6e@acm.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On Wed, Oct 15, 2025 at 08:49:45AM -0700, Bart Van Assche wrote:
> On 10/15/25 4:07 AM, Ming Lei wrote:
> > +static inline unsigned lo_cmd_nr_bvec(struct loop_cmd *cmd)
> > +{
> > +	struct request *rq = blk_mq_rq_from_pdu(cmd);
> > +	struct req_iterator rq_iter;
> > +	struct bio_vec tmp;
> > +	int nr_bvec = 0;
> > +
> > +	rq_for_each_bvec(tmp, rq, rq_iter)
> > +		nr_bvec++;
> > +
> > +	return nr_bvec;
> > +}
> 
> 'cmd' is not used in this function other than in the conversion to a
> struct request. Has it been considered to change the argument type of
> this function from 'struct loop_cmd *' into 'struct request *'? That
> will allow to leave out the blk_mq_rq_from_pdu() from this function.
> Otherwise this patch looks good to me.

It isn't one big deal, I can switch to `request *` if respin is needed,
otherwise I'd leave it as it is. 


Thanks,
Ming

