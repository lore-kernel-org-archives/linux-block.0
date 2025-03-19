Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50AD917C91
	for <linux-block@vger.kernel.org>; Wed, 19 Mar 2025 01:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742346314; cv=none; b=LC+8c6Dxwmx7gINN+FlzTmC2SYwRD+aHNPzN+1Cwlq3KRgYK0HrlZKdbjhVK3vfE5fH3y1pIglBxVjk3DU6T5jiXk4oV/eqP68Mwxhcd+Wb4Xf+Yj8gXIKmWXCNKTPUGepcwiOoNYhhGfU48V7I1i4XUS/UklIqPUBLTypRR3II=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742346314; c=relaxed/simple;
	bh=a913brFii2V9q/ytP03lwM1t6v1VUfpnjLK7QhvpxAw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RiZKxyvoG+Thqiecdy6HrME/seZja9ySiN0iRuqqrQ0Ic1f1sVBut+5+Px5fjlXwzuChZQ6wk3sN9DeRxEcw8asaOavi3z8BbGW3bSXuLdMuGKAR1JcprGKx4aeeO62pAKaXuwMwUqdMU32En9qV0kmOMu38Ox+cAj/NBqf/2Ps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NYolFUiE; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NYolFUiE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742346312;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ambuV+AJ2DaHe+8DQCz/IA8X3MOrFrz0Q8mKcYRVXXY=;
	b=NYolFUiE6g9lD901Dmrh2KNqwwsUHhfJ5yWmZAb+QOJGNzoUgbd2Tp47InY4DTA3GCXRaS
	fVGGyn6h77cRsb2kwOAxAYLMi5DJ80kY2r6G+aq3wSj3P2HwyDh7Z4UiCTNDfxGVddT7Y4
	qtrOTPFCoUzRH+dClehrjHExUvoqiVk=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-272-K6gMZRKMP-OpaS4q17kYJw-1; Tue,
 18 Mar 2025 21:05:08 -0400
X-MC-Unique: K6gMZRKMP-OpaS4q17kYJw-1
X-Mimecast-MFC-AGG-ID: K6gMZRKMP-OpaS4q17kYJw_1742346307
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B44F51955D97;
	Wed, 19 Mar 2025 01:05:07 +0000 (UTC)
Received: from fedora (unknown [10.72.120.14])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E453B1809B69;
	Wed, 19 Mar 2025 01:04:27 +0000 (UTC)
Date: Wed, 19 Mar 2025 09:04:21 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: Uday Shankar <ushankar@purestorage.com>, linux-block@vger.kernel.org
Subject: Re: [PATCH] ublk: remove io_cmds list in ublk_queue
Message-ID: <Z9oYFdWj1qAWH1q3@fedora>
References: <20250318-ublk_io_cmds-v1-1-c1bb74798fef@purestorage.com>
 <c91dfaf8-d925-4f6d-8ced-06ecb395a360@kernel.dk>
 <Z9m+3qMBXgqDz399@dev-ushankar.dev.purestorage.com>
 <097f0495-b2e8-4938-9a0d-c321f618d49b@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <097f0495-b2e8-4938-9a0d-c321f618d49b@kernel.dk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On Tue, Mar 18, 2025 at 12:48:44PM -0600, Jens Axboe wrote:
> On 3/18/25 12:43 PM, Uday Shankar wrote:
> > On Tue, Mar 18, 2025 at 12:22:57PM -0600, Jens Axboe wrote:
> >>>  struct ublk_rq_data {
> >>> -	struct llist_node node;
> >>> -
> >>>  	struct kref ref;
> >>>  };
> >>
> >> Can we get rid of ublk_rq_data then? If it's just a ref thing, I'm sure
> >> we can find an atomic_t of space in struct request and avoid it. Not a
> >> pressing thing, just tossing it out there...
> > 
> > Yeah probably - we do need a ref since one could complete a request
> > concurrently with another code path which references it (user copy and
> > zero copy). I see that struct request has a refcount in it already,
> 
> Right, at least with the current usage, we still do need that kref, or
> something similar. I would've probably made it just use refcount_t
> though, rather than rely on the indirect calls. kref doesn't really
> bring us anything here in terms of API.
> 
> > though I don't see any examples of drivers using it. Would it be a bad
> > idea to try and reuse that?
> 
> We can't reuse that one, and it's not for driver use - purely internal.
> But I _think_ you could easily grab space in the union that has the hash
> and ipi_list for it. And then you could dump needing this extra data per
> request.

It should be fine to reuse request->ref, since the payload shares same
lifetime with request.

But if it is exported, the interface is likely to be misused...


thanks,
Ming

