Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 644AF155CB3
	for <linux-block@vger.kernel.org>; Fri,  4 Apr 2025 12:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743768591; cv=none; b=k8HX7+rn0elgp86W9oxBMpsVnqKonDfzTVS9noE36Y4kosBRzhqUFImlFCWnO6SfavhZEHaNq+kOzg4jflKvWYeg+PrftMpUL6g3SI5ukmqFLYygmAkRNz4hBYE4lchf5KZfPHJ5N8cHHgU2aXeHUNpSeB5xAyrghu8TomnouV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743768591; c=relaxed/simple;
	bh=0x8cCGl6Vpvei1KR3ogPvBCmXkI+nLy8aYHApSp1WBo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oSFC2KHXzdNLRJscoQf8d74/3AAz0pRXJarvKEbbgn0VYFRfcyU9jRLexJSl//Yl7dIvySuiwJQncngQmp8kv2ZimGfoDxgtnoIubns6mrmLTSOyjl9nLINOFgzQHzz1Q27eIqB8CeKA8lsF2bXV/RRDcAGtXYgGICuFUCbhAKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WakLtviG; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WakLtviG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743768588;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mXcGfDNrqRF7J5DqaXiQWLY0ZYgmxi/Vf7FAwwVfaMg=;
	b=WakLtviG96huHgXpVTCjTz9IjRoKdwQVZBNLT591O2djZFnZT7Eo8OI5tMtswL0iWAAyaH
	53APXB5Cu6UJtfxV5Luz6MwMM+xJqshEdhxdd55ioRT0l476idLR9QP3BCRrfAjFVI/NkO
	8z1IpwKu1J4E5ylquz4ELVpz0t6sl5M=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-260-_TH5-dN3NHqp8kLQF4MwBQ-1; Fri,
 04 Apr 2025 08:09:45 -0400
X-MC-Unique: _TH5-dN3NHqp8kLQF4MwBQ-1
X-Mimecast-MFC-AGG-ID: _TH5-dN3NHqp8kLQF4MwBQ_1743768583
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2B348195608A;
	Fri,  4 Apr 2025 12:09:43 +0000 (UTC)
Received: from fedora (unknown [10.72.120.26])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id AF2C2195DF8C;
	Fri,  4 Apr 2025 12:09:38 +0000 (UTC)
Date: Fri, 4 Apr 2025 20:09:31 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Nilay Shroff <nilay@linux.ibm.com>,
	syzbot+4c7e0f9b94ad65811efb@syzkaller.appspotmail.com
Subject: Re: [PATCH] block: don't grab elevator lock during queue
 initialization
Message-ID: <Z-_L-_9fG0Z6CYQM@fedora>
References: <20250403105402.1334206-1-ming.lei@redhat.com>
 <20250404091037.GB12163@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250404091037.GB12163@lst.de>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On Fri, Apr 04, 2025 at 11:10:37AM +0200, Christoph Hellwig wrote:
> On Thu, Apr 03, 2025 at 06:54:02PM +0800, Ming Lei wrote:
> > Fixes the following lockdep warning:
> 
> Please spell the actual dependency out here, links are not permanent
> and also not readable for any offline reading of the commit logs.
> 
> > +static void blk_mq_realloc_hw_ctxs(struct blk_mq_tag_set *set,
> > +				   struct request_queue *q, bool lock)
> > +{
> > +	if (lock) {
> 
> bool lock(ed) arguments are an anti-pattern, and regularly get Linus
> screaming at you (in this case even for the right reason :))
> 
> > +		/* protect against switching io scheduler  */
> > +		mutex_lock(&q->elevator_lock);
> > +		__blk_mq_realloc_hw_ctxs(set, q);
> > +		mutex_unlock(&q->elevator_lock);
> > +	} else {
> > +		__blk_mq_realloc_hw_ctxs(set, q);
> > +	}
> 
> I think the problem here is again that because of all the other
> dependencies elevator_lock really needs to be per-set instead of
> per-queue which will allows us to have much saner locking hierarchies.

per-set lock is required in error handling code path, anywhere it is used
with freezing together can be one deadlock risk if hardware error happens.

Or can you explain the idea in details?

Thanks,
Ming

