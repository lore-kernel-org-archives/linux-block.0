Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E56BD1CA81
	for <linux-block@vger.kernel.org>; Wed, 21 Aug 2024 02:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724208928; cv=none; b=rM5SUCYFf70KQJYQP90Yow2FQ/QRsQ4aivG5brPBwpY8rTbbsQgLyXX2WCVO3QAyyIRNGj7nN/922tuOBIRA9FE1If4hNqY4Tlj4J06YhPpTXgdyTl0njyOp+M1PD9gk4rqntW8OPZ3peVm8Pd3u/U0CITIb9iKzgyFif9b4+xc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724208928; c=relaxed/simple;
	bh=xYtbIZN9AyCEi914ZJeTdlzwoaOrJfCbBZzvtmDTOtE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QJbDSxMJKSN+ic8lNdwkUuv5JoNtfkr9ExtSO6nzSYkSBxhgNzUl74ljte2OVuIcm6h8rbPU+moWNd0LgGaqnNWcRoEVgxseRRwFMjd8cNDnkr1a0yUszOq4pR72YFEHXWiVQPfu+CqhonuAaIJf24rF/5Zv6zKGpyi/xCgpbYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KQrAoAdc; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KQrAoAdc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724208925;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KSiSgD05DeHtm5VziINX4tjvKw+IZh1lV84+HlnOlgg=;
	b=KQrAoAdc5USyeb3tDvUQy2PVN2CQNkkqcqlQ9xkSlmb5Vi+0z9TzK8kXjj99zRUdCSisE1
	J/RiLPekgrmzP/c7KpoZgn/6vStlAivZQELh+0zZQO3M+kuTIWxoD8QQyec/g7Do5H0V2L
	4rC/i5GzOZZHMMH6gVhtYM0lylRLen4=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-179-ufT1cexHObWimM0gMNSokA-1; Tue,
 20 Aug 2024 22:55:20 -0400
X-MC-Unique: ufT1cexHObWimM0gMNSokA-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D31DD1955D4C;
	Wed, 21 Aug 2024 02:55:17 +0000 (UTC)
Received: from fedora (unknown [10.72.116.126])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E46CE19560AE;
	Wed, 21 Aug 2024 02:55:11 +0000 (UTC)
Date: Wed, 21 Aug 2024 10:55:06 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Pavel Begunkov <asml.silence@gmail.com>
Cc: Jens Axboe <axboe@kernel.dk>, io-uring@vger.kernel.org,
	Conrad Meyer <conradmeyer@meta.com>, linux-block@vger.kernel.org,
	linux-mm@kvack.org, Jan Kara <jack@suse.cz>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: Re: [RFC 5/5] block: implement io_uring discard cmd
Message-ID: <ZsVXClra11+yLjss@fedora>
References: <CAFj5m9+CXS_b5kgFioFHTWivb6O+R9HytsSQEHcEzUM5SqHfgw@mail.gmail.com>
 <fd357721-7ba7-4321-88da-28651754f8a4@kernel.dk>
 <e06fd325-f20f-44d8-8f72-89b97cf4186f@gmail.com>
 <Zr6S4sHWtdlbl/dd@fedora>
 <4d016a30-d258-4d0e-b3bc-18bf0bd48e32@kernel.dk>
 <Zr6vIt1uSe9/xguH@fedora>
 <e9562cf8-9cf1-409e-8fbd-546d11fcba93@kernel.dk>
 <ZsQBMjaBrtcFLpIj@fedora>
 <d8ef3e63-1a94-45a4-974a-01324d6ce310@kernel.dk>
 <c69d1769-ae86-4659-bbda-6f7760a8e83f@gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c69d1769-ae86-4659-bbda-6f7760a8e83f@gmail.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

On Tue, Aug 20, 2024 at 06:19:00PM +0100, Pavel Begunkov wrote:
> On 8/20/24 17:30, Jens Axboe wrote:
> > On 8/19/24 8:36 PM, Ming Lei wrote:
> > > On Mon, Aug 19, 2024 at 02:01:21PM -0600, Jens Axboe wrote:
> > > > On 8/15/24 7:45 PM, Ming Lei wrote:
> ...
> > > > > Meantime the handling has to move to io-wq for avoiding to block current
> > > > > context, the interface becomes same with IORING_OP_FALLOCATE?
> > > > 
> > > > I think the current truncate is overkill, we should be able to get by
> > > > without. And no, I will not entertain an option that's "oh just punt it
> > > > to io-wq".
> > > 
> > > BTW, the truncate is added by 351499a172c0 ("block: Invalidate cache on discard v2"),
> > > and block/009 serves as regression test for covering page cache
> > > coherency and discard.
> > > 
> > > Here the issue is actually related with the exclusive lock of
> > > filemap_invalidate_lock(). IMO, it is reasonable to prevent page read during
> > > discard for not polluting page cache. block/009 may fail too without the lock.
> > > 
> > > It is just that concurrent discards can't be allowed any more by
> > > down_write() of rw_semaphore, and block device is really capable of doing
> > > that. It can be thought as one regression of 7607c44c157d ("block: Hold invalidate_lock in
> > > BLKDISCARD ioctl").
> > > 
> > > Cc Jan Kara and Shin'ichiro Kawasaki.
> > 
> > Honestly I just think that's nonsense. It's like mixing direct and
> > buffered writes. Can you get corruption? Yes you most certainly can.
> > There should be no reason why we can't run discards without providing
> > page cache coherency. The sync interface attempts to do that, but that
> > doesn't mean that an async (or a different sync one, if that made sense)
> > should.
> 
> I don't see it as a problem either, it's a new interface, just need
> to be upfront on what guarantees it provides (one more reason why
> not fallocate), I'll elaborate on it in the commit message and so.

Fair enough.

> 
> I think a reasonable thing to do is to have one rule for all write-like
> operations starting from plain writes, which is currently allowing races
> to happen and shift it to the user. Purely in theory we can get inventive
> with likes of range lock trees, but that's unwarranted for all sorts of
> reasons.
> 
> > If you do discards to the same range as you're doing buffered IO, you
> > get to keep both potentially pieces. Fact is that most folks are doing
> > dio for performant IO exactly because buffered writes tend to be
> > horrible, and you could certainly use that with async discards and have
> > the application manage it just fine.
> > 
> > So I really think any attempts to provide page cache synchronization for
> > this is futile. And the existing sync one looks pretty abysmal, but it
> > doesn't really matter as it's a sync interfce. If one were to do
> 
> It should be a pain for sync as well, you can't even spin another process
> and parallelise this way.

Yes, this way has degraded some sync discard workloads perf a lot.

Thanks,
Ming

