Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37F3B801
	for <linux-block@vger.kernel.org>; Mon,  7 Apr 2025 03:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743995371; cv=none; b=UEdUQ18NSKOAVVPLgCaLUBxnp8eo4Ji7Y0ici/3hGnWRP7x5ID8lmU8AUHphg0W6AloUWgKRfQo2NyE4ZTun1EjNhtUFBd5pbKIWTnWnTVEFza6CTxtU0kFdD6SevQ3dV55KtHXmJ1jSTwcn5SB+VawqyWL26tUlS/gxutpG7Gk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743995371; c=relaxed/simple;
	bh=W4Iwh2VDzhx9yTZwOlkK44+6yP5fxW+YmI2XtqKSb5Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eTiWV0qn5DEZWEn6nKngM/IH+e/reDe8lPW4zCnQKIunFxYDLE8VdfREmwmgdiFJuUwLVtkHho60gS7+4CKtH2CyfC+CAsQLNK8BD0RWemoQmszVAfVpBmw+TgN71URFDoLkXmojkzgLTdecC9dMVgUt8BFF2lm83N6+UF/bpew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fEbTkWpB; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fEbTkWpB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743995368;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zZ9qWbxrVaDrrdVAGUqyBQcaTGf5JO9eEnM2mpnT3JM=;
	b=fEbTkWpBdltZ+Fb4jg9KHvEcWkacD74BCM5iaTpFadideBUp6ebnXJinhJI22LwcKVcCth
	5ckT/wCHuejT1qdxpsWxcXrkI7S7bo7G0KeoWy0NuDG5whlkug5PGN5rNNesyKye181Hvi
	d3shAyYa/gzwZkkFtR7Df/miOw1PPQM=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-329-g99s-vQEMS6BJUehTY7SNQ-1; Sun,
 06 Apr 2025 23:09:26 -0400
X-MC-Unique: g99s-vQEMS6BJUehTY7SNQ-1
X-Mimecast-MFC-AGG-ID: g99s-vQEMS6BJUehTY7SNQ_1743995365
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BEC6E180025A;
	Mon,  7 Apr 2025 03:09:24 +0000 (UTC)
Received: from fedora (unknown [10.72.120.20])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BBB693001D0E;
	Mon,  7 Apr 2025 03:09:19 +0000 (UTC)
Date: Mon, 7 Apr 2025 11:09:13 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org,
	syzbot+4c7e0f9b94ad65811efb@syzkaller.appspotmail.com
Subject: Re: [PATCH] block: don't grab elevator lock during queue
 initialization
Message-ID: <Z_NB2VA9D5eqf0yH@fedora>
References: <20250403105402.1334206-1-ming.lei@redhat.com>
 <20250404091037.GB12163@lst.de>
 <92feba7e-84fc-4668-92c3-aba4e8320559@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <92feba7e-84fc-4668-92c3-aba4e8320559@linux.ibm.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On Sat, Apr 05, 2025 at 07:44:19PM +0530, Nilay Shroff wrote:
> 
> 
> On 4/4/25 2:40 PM, Christoph Hellwig wrote:
> > On Thu, Apr 03, 2025 at 06:54:02PM +0800, Ming Lei wrote:
> >> Fixes the following lockdep warning:
> > 
> > Please spell the actual dependency out here, links are not permanent
> > and also not readable for any offline reading of the commit logs.
> > 
> >> +static void blk_mq_realloc_hw_ctxs(struct blk_mq_tag_set *set,
> >> +				   struct request_queue *q, bool lock)
> >> +{
> >> +	if (lock) {
> > 
> > bool lock(ed) arguments are an anti-pattern, and regularly get Linus
> > screaming at you (in this case even for the right reason :))
> > 
> >> +		/* protect against switching io scheduler  */
> >> +		mutex_lock(&q->elevator_lock);
> >> +		__blk_mq_realloc_hw_ctxs(set, q);
> >> +		mutex_unlock(&q->elevator_lock);
> >> +	} else {
> >> +		__blk_mq_realloc_hw_ctxs(set, q);
> >> +	}
> > 
> > I think the problem here is again that because of all the other
> > dependencies elevator_lock really needs to be per-set instead of
> > per-queue which will allows us to have much saner locking hierarchies.
> > 
> I believe you meant here q->tag_set->elevator_lock? 

I don't know what locks you are planning to invent.

For set->tag_list_lock, it has been very fragile:

blk_mq_update_nr_hw_queues
	set->tag_list_lock
		freeze_queue

If IO failure happens when waiting in above freeze_queue(), the nvme error
handling can't provide forward progress any more, because the error
handling code path requires set->tag_list_lock.

So all queues should be frozen first before calling blk_mq_update_nr_hw_queues,
fortunately that is what nvme is doing.


> If yes then it means that we should be able to grab ->elevator_lock
> before freezing the queue in __blk_mq_update_nr_hw_queues and so locking
> order should be in each code path,
> 
> __blk_mq_update_nr_hw_queues
>     ->elevator_lock 
>       ->freeze_lock

Now tagset->elevator_lock depends on set->tag_list_lock, and this way
just make things worse. Why can't we disable elevator switch during
updating nr_hw_queues?



Thanks,
Ming

