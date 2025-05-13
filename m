Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DFB72BCF5
	for <linux-block@vger.kernel.org>; Tue, 13 May 2025 03:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747105547; cv=none; b=GhmO3UMPN891OAh6SLrMVCxxVYB/eR0A15VezKe3X+FaNBsIHxdiUywnFRzxqcOwgEzL/fK+5xxYaBU+nXxDplh9HzTC2kXc+GuSNAl2PwjKI+uNJpGceVVVPtxanJln3F6JQ3+zCAAkCpwlWr7jpWL4Li41b055LdKGTXxDeWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747105547; c=relaxed/simple;
	bh=h/DkHv+Mj14bnYTHQID65JqdG68c4fwoHApdTQIrbFE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=buqokZ/Bu11RN3rSjrnxX2SaDs4gz5SmXDUFgRv838Ij8aO4uo47LJMW5r/L9bIRbO0r1axD+7bRVHMJLYwpdasvfzSCxaFVl/Q4I2P3Hw0Fgy8tUL3uQFeI4GMEa+lRRJN5LfXEwHCn+KJMYfwtORMpq2CRzzR6o2I5RNPdF2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dMUju/kw; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dMUju/kw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747105544;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YfkF0/l7CkpMl3qOGWz2One3ryadqDT3yVWqqE+i76o=;
	b=dMUju/kwiDB1YrRGlIatfycsm0w6FmYiOMpIQFeviNbK9AP3nKFs/f3OHlEUMrk0P/PQtJ
	df+GalcSYcMwk1rGHppPvWhFdAz1cAXXJ3zISUNg4FEyO8HxRxDD+bC53mU7Avnu0upfdV
	KZSTiGXxqu97rUSoUjKiWmG9JYYyzbw=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-551-QHU5S4HLM5Ww_GEzchk1gg-1; Mon,
 12 May 2025 23:05:38 -0400
X-MC-Unique: QHU5S4HLM5Ww_GEzchk1gg-1
X-Mimecast-MFC-AGG-ID: QHU5S4HLM5Ww_GEzchk1gg_1747105537
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B132B19560AF;
	Tue, 13 May 2025 03:05:37 +0000 (UTC)
Received: from fedora (unknown [10.72.116.23])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 97E261955EA0;
	Tue, 13 May 2025 03:05:33 +0000 (UTC)
Date: Tue, 13 May 2025 11:05:28 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Uday Shankar <ushankar@purestorage.com>,
	Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH V3 1/6] ublk: allow io buffer register/unregister command
 issued from other task contexts
Message-ID: <aCK2-MgeGZiBBzlF@fedora>
References: <20250509150611.3395206-1-ming.lei@redhat.com>
 <20250509150611.3395206-2-ming.lei@redhat.com>
 <CADUfDZpf=dXnjo4Jpf+U33_H1OYUwvvDA4O=aw2xM9zZY7-rOQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADUfDZpf=dXnjo4Jpf+U33_H1OYUwvvDA4O=aw2xM9zZY7-rOQ@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

On Mon, May 12, 2025 at 01:25:35PM -0700, Caleb Sander Mateos wrote:
> On Fri, May 9, 2025 at 8:06 AM Ming Lei <ming.lei@redhat.com> wrote:
> >
> > `ublk_queue` is read only for io buffer register/unregister command. Both
> > `ublk_io` and block layer request are read-only for IO buffer register/
> > unregister command.
> >
> > So the two command can be issued from other task contexts.
> >
> > Not same with other three ublk commands, these two are for handling target
> > IO only, we shouldn't limit their issue task context, otherwise it becomes
> > hard for ublk server(backend) to use zero copy feature.
> >
> > Reported-by: Uday Shankar <ushankar@purestorage.com>
> > Closes: https://lore.kernel.org/linux-block/20250410-ublk_task_per_io-v3-2-b811e8f4554a@purestorage.com/
> 
> I don't agree that this change obviates the need for per-io tasks.
> Being able to perform zero-copy buffer registration on other threads

You may misunderstand the concern, it isn't for solving load balancing,
it is just for making zero copy easier to use.

Not like other uring_cmd(FETCH, COMMIT_AND_FETCH), register io buffer is
for target IO handling, which shouldn't be limited in the ubq_daemon
context, Uday did mention this point in above link.

> can't help with spreading the load if the ublk server isn't using
> zero-copy in the first place. And sending I/Os between ublk server
> threads adds cross-CPU synchronization overhead (as Uday points out in
> the commit message for his change). Distributing I/Os among the ublk
> server threads at the point where the blk-mq request is queued seems
> like a natural place to do load balancing, as the request is already
> being sent between CPUs there.

I do agree load balancing should be addressed, together with relaxing
existing ublk server context limitation.

Uday's patch can be one good start from both driver and selftest code
side.

However, spread load in static way may not solve this problem completely,
which may be one transitional solution, IMO, but it is fine to move on
with it when comments are addressed.

We should support dynamic load balancing by allowing to migrate IO to
other context runtime in future:

- it should be enough to add one per-io spin lock in driver side, there
  isn't contention for good ublk implementation

	https://github.com/ming1/linux/commits/ublk_task_neutral/

- when load isn't balanced or some task contexts are saturated, IO need to
migrate to other task contexts

- IO migration should just happen when load isn't balanced, and it won't be
needed when load becomes balanced, so cross-CPU isn't one thing

- the migration logic need to be triggered from target code, but the
  mechanism can be implemented in library

Almost all Uday's selftest code can be reused for above, especially the
nice ublk_thread abstraction, maybe it can be named as ublk_task_ctx, then
ring_buf & eventfd & read_mshot notification can be added to it for
supporting IO migration.


Thanks,
Ming

