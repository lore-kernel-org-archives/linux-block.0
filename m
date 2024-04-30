Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82F92DDA9
	for <linux-block@vger.kernel.org>; Tue, 30 Apr 2024 03:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714446220; cv=none; b=nP37poPj7fOIiIsnnVrS6KN26aa9WcPPH7l/zGxs17J7D5gO3OPsHfYm4Y3/B+brjt460RnwZ8bMv3kHzoc209kOtRK6aFTAWhHXg6+XVoRNqeLnnSijvIu6SvwT7YWhIwvP8V9eYCBmw19G1/LEx5elzWRyZIF29mwxkbGfBA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714446220; c=relaxed/simple;
	bh=724bnwq3poOO/YXi8I/mdQZqne72/WGpVE9I/VA1k3w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tBtu6ZsZlpsqQY5qDtBAi9J5yKoJozwuq0pAEScYATjprtcXCueU5405dwB6okhp/FJ1C+SF+Kh/MFuuf4G9DEl22nf3SS8u2A6oSZfDAcSiUgT4AjOlGjiiCDatgr5hREICHsFzkmlHavFh4W5eJFb8CZmBwJLdcfVPkNNnOTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hRFvyXFo; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hRFvyXFo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714446217;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gfJlemeuIzJ+EUzhfC63FdEeGAyELlOMrOyBrB8AaaU=;
	b=hRFvyXFocBDMqb/D3BwxobkoaTYVlVzGAQApmahfoMjVTSFVojigqiJgA/3NR0/qImiQ5W
	mXU/40KeJABzZArXgUzDGxTZFOYdaJJJKUxxeOoFGBDYE7nEszS7Ht8VeeeFcpd8jEmeCs
	tuXLkPWr9BbfBu0Bser13As+ehNK4Bc=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-373-EWOaW-S2Ofi4k-QwqSfjkw-1; Mon,
 29 Apr 2024 23:03:32 -0400
X-MC-Unique: EWOaW-S2Ofi4k-QwqSfjkw-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 545543C3D0C4;
	Tue, 30 Apr 2024 03:03:32 +0000 (UTC)
Received: from fedora (unknown [10.72.116.42])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id B178F400EB2;
	Tue, 30 Apr 2024 03:03:28 +0000 (UTC)
Date: Tue, 30 Apr 2024 11:03:24 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Pavel Begunkov <asml.silence@gmail.com>
Cc: Kevin Wolf <kwolf@redhat.com>, Jens Axboe <axboe@kernel.dk>,
	io-uring@vger.kernel.org, linux-block@vger.kernel.org,
	ming.lei@redhat.com
Subject: Re: [PATCH 5/9] io_uring: support SQE group
Message-ID: <ZjBffAzunso3lhsJ@fedora>
References: <20240408010322.4104395-1-ming.lei@redhat.com>
 <20240408010322.4104395-6-ming.lei@redhat.com>
 <e36cc8de-3726-4479-8fbd-f54fd21465a2@kernel.dk>
 <Ziey53aADgxDrXZw@redhat.com>
 <6077165e-a127-489e-9e47-6ec10b9d85d4@gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6077165e-a127-489e-9e47-6ec10b9d85d4@gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9

On Mon, Apr 29, 2024 at 04:32:35PM +0100, Pavel Begunkov wrote:
> On 4/23/24 14:08, Kevin Wolf wrote:
> > Am 22.04.2024 um 20:27 hat Jens Axboe geschrieben:
> > > On 4/7/24 7:03 PM, Ming Lei wrote:
> > > > SQE group is defined as one chain of SQEs starting with the first sqe that
> > > > has IOSQE_EXT_SQE_GROUP set, and ending with the first subsequent sqe that
> > > > doesn't have it set, and it is similar with chain of linked sqes.
> > > > 
> > > > The 1st SQE is group leader, and the other SQEs are group member. The group
> > > > leader is always freed after all members are completed. Group members
> > > > aren't submitted until the group leader is completed, and there isn't any
> > > > dependency among group members, and IOSQE_IO_LINK can't be set for group
> > > > members, same with IOSQE_IO_DRAIN.
> > > > 
> > > > Typically the group leader provides or makes resource, and the other members
> > > > consume the resource, such as scenario of multiple backup, the 1st SQE is to
> > > > read data from source file into fixed buffer, the other SQEs write data from
> > > > the same buffer into other destination files. SQE group provides very
> > > > efficient way to complete this task: 1) fs write SQEs and fs read SQE can be
> > > > submitted in single syscall, no need to submit fs read SQE first, and wait
> > > > until read SQE is completed, 2) no need to link all write SQEs together, then
> > > > write SQEs can be submitted to files concurrently. Meantime application is
> > > > simplified a lot in this way.
> > > > 
> > > > Another use case is to for supporting generic device zero copy:
> > > > 
> > > > - the lead SQE is for providing device buffer, which is owned by device or
> > > >    kernel, can't be cross userspace, otherwise easy to cause leak for devil
> > > >    application or panic
> > > > 
> > > > - member SQEs reads or writes concurrently against the buffer provided by lead
> > > >    SQE
> > > 
> > > In concept, this looks very similar to "sqe bundles" that I played with
> > > in the past:
> > > 
> > > https://git.kernel.dk/cgit/linux/log/?h=io_uring-bundle
> > > 
> > > Didn't look too closely yet at the implementation, but in spirit it's
> > > about the same in that the first entry is processed first, and there's
> > > no ordering implied between the test of the members of the bundle /
> > > group.
> > 
> > When I first read this patch, I wondered if it wouldn't make sense to
> > allow linking a group with subsequent requests, e.g. first having a few
> > requests that run in parallel and once all of them have completed
> > continue with the next linked one sequentially.
> > 
> > For SQE bundles, you reused the LINK flag, which doesn't easily allow
> > this. Ming's patch uses a new flag for groups, so the interface would be
> > more obvious, you simply set the LINK flag on the last member of the
> > group (or on the leader, doesn't really matter). Of course, this doesn't
> > mean it has to be implemented now, but there is a clear way forward if
> > it's wanted.
> 
> Putting zc aside, links, graphs, groups, it all sounds interesting in
> concept but let's not fool anyone, all the different ordering
> relationships between requests proved to be a bad idea.

As Jens mentioned, sqe group is very similar with bundle:

https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git/log/?h=io_uring-bundle

which is really something io_uring is missing.

> 
> I can complaint for long, error handling is miserable, user handling
> resubmitting a part of a link is horrible, the concept of errors is
> hard coded (time to appreciate "beautifulness" of IOSQE_IO_HARDLINK
> and the MSG_WAITALL workaround). The handling and workarounds are
> leaking into generic paths, e.g. we can't init files when it's the most
> convenient. For cancellation we're walking links, which need more care
> than just looking at a request (is cancellation by user_data of a
> "linked" to a group request even supported?). The list goes on

Only the group leader is linked, if the group leader is canceled, all
requests in the whole group will be canceled.

But yes, cancelling by user_data for group members can't be supported,
and it can be documented clearly, since user still can cancel the whole
group with group leader's user_data.

> 
> And what does it achieve? The infra has matured since early days,
> it saves user-kernel transitions at best but not context switching
> overhead, and not even that if you do wait(1) and happen to catch
> middle CQEs. And it disables LAZY_WAKE, so CQ side batching with
> timers and what not is effectively useless with links.

Not only the context switch, it supports 1:N or N:M dependency which
is missing in io_uring, but also makes async application easier to write by
saving extra context switches, which just adds extra intermediate states for
application.

> 
> So, please, please! instead of trying to invent a new uber scheme
> of request linking, which surely wouldn't step on same problems
> over and over again, and would definitely be destined to overshadow
> all previous attempts and finally conquer the world, let's rather
> focus on minimasing the damage from this patchset's zero copy if
> it's going to be taken.

One key problem for zero copy is lifetime of the kernel buffer, which
can't cross OPs, that is why sqe group is introduced, for aligning
kernel buffer lifetime with the group.


Thanks, 
Ming

