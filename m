Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49BCA15E812
	for <linux-block@vger.kernel.org>; Mon, 25 Mar 2024 03:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711338661; cv=none; b=F+PrOqZ0WfrVTd/kStO9LqcYkr5OyhH8ujT4BMFckXMSMVuTh9cuuOizhWlLrwyly/f6wjeWlk1b7nPOoVeM7pYotkwS5adtqrMo5J4YwtQ+2moilnYOyFdbEqLKq41GcMc/ZdbXnKcxunsSkGcENPa68y2lRCaIS41VcyRFO0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711338661; c=relaxed/simple;
	bh=JTl2GthtGeVE+TzWv4mL3q1IBZWCwFN1cvvndRbca1o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=auJsn8pYMx5Fn6X2NvvuGTAMXaWTZ5tFVUarBFdzzLGYtlJt0sN9hxZQTf0RfpYtv9oLxgYTMkQ9IWex7+vOKaWhYnguFMeuwzW4NdOnAz9kEG4pxtye2yvqGL5BQSs4mxyReDlGHEUyJCyMkBtNtTlb693gQ/G8NaWeRNF9NNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dcPvLP4N; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dcPvLP4N"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711338658;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=afn8OOUI6B9CD/RsJZlQWcCmyXXiQNf58j5J5nr28n4=;
	b=dcPvLP4Nq/AYp85Rdc/+fLKfMF7Fx0VLe5Atr83f8LUSqThg2Z4hHCePFb3JNJ1B2NIWIC
	d5jnbOKmlKi9/wT84oho8uPMbaYWa8HvneXeF1YUwfOj8/ZzIJhWb/lqcRQfNJvBQaiv/2
	aSpI6JrrvHVHBjyrSi2HhR5LCYogXvs=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-119-t_tmNl7JO7qu2gWNkOJUSA-1; Sun, 24 Mar 2024 23:50:54 -0400
X-MC-Unique: t_tmNl7JO7qu2gWNkOJUSA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C2CE2185A786;
	Mon, 25 Mar 2024 03:50:53 +0000 (UTC)
Received: from fedora (unknown [10.72.116.37])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 7CD371121312;
	Mon, 25 Mar 2024 03:50:49 +0000 (UTC)
Date: Mon, 25 Mar 2024 11:50:41 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Keith Busch <kbusch@kernel.org>,
	Bart Van Assche <bvanassche@acm.org>,
	Mikulas Patocka <mpatocka@redhat.com>,
	Mike Snitzer <snitzer@kernel.org>
Subject: Re: [PATCH V2] block: fail unaligned bio from submit_bio_noacct()
Message-ID: <ZgD0kQCCQtu34q/D@fedora>
References: <20240324133702.1328237-1-ming.lei@redhat.com>
 <ZgC2UPEBOSLW9Xdz@infradead.org>
 <ZgDpfW8HRHrZgQYv@fedora>
 <ZgDrgTymGnW3KGuk@infradead.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZgDrgTymGnW3KGuk@infradead.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3

On Sun, Mar 24, 2024 at 08:12:01PM -0700, Christoph Hellwig wrote:
> On Mon, Mar 25, 2024 at 11:03:25AM +0800, Ming Lei wrote:
> > Also only q->limits.logical_block_size is fetched for small BS IO
> > fast path, I think log(lbs) can be cached in request_queue for avoiding the
> > extra fetch of q.limits. Especially, it could be easier to do so
> > with your recent queue limit atomic update changes.
> 
> So.  One thing I've been thinking of for a while (and which Bart also
> mentioned) is tht queue_limits currently is a bit of a mess between
> the actual queue limits, and the gneidks configuration.   The logical
> block size is firmly in the latter, and we should probably move it

lbs and pbs belong to disk, but some others may not be very obvious.

Strictly speaking elevator/blkcg belong to disk too, but still stay in
request_queue, :-)

Thanks, 
Ming

