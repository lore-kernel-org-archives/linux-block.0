Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BC1B17ADF8
	for <linux-block@vger.kernel.org>; Mon, 27 Jan 2025 18:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738002089; cv=none; b=RJafZiG3FRucIFs+B07nOB/FrQdR2N8na8wWCdnV56CGPUUjeg0I6XSPdrfQfAntKIawzbKIwyeWz0mHtOFN73dEzZvfP9FluanCOIgUNRjz1uLUwOqj0cgSu3K2LiFdlAUqZmnSDCu5chAsNeAZVwac+8LO7mxahLaqui7yBAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738002089; c=relaxed/simple;
	bh=9oX8XBT+ckRfQ+RBrNdl9bknDKxI5UM7mVVoNmjLB9U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eGEPat1fu+eAe5g69hhbhELR6yeLhO77E1hnRA0qke8MtgXolePcZSeRCgmmLGr781WW8R7k8DenRnsW/7laX8rWEnqqgDRKaeKvBfmHkwH9G214n6D72fnuaAgha0ORHY0Cy6KoxVtWzHGBeQlLApLc9QGmTHbTDUUNKFWaTBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=anarazel.de; spf=pass smtp.mailfrom=anarazel.de; dkim=pass (2048-bit key) header.d=anarazel.de header.i=@anarazel.de header.b=K0yBw62Y; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GwFb7Etg; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=anarazel.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=anarazel.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=anarazel.de header.i=@anarazel.de header.b="K0yBw62Y";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GwFb7Etg"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfhigh.stl.internal (Postfix) with ESMTP id EAFCE2540113;
	Mon, 27 Jan 2025 13:21:25 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Mon, 27 Jan 2025 13:21:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=anarazel.de; h=
	cc:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1738002085; x=1738088485; bh=cRP+DK217q
	jmvyi+zlvZh1DoEcriRk8x6tJpLrq4SHM=; b=K0yBw62Yb73WbXUBEHoqCbzA+7
	oawTh2Z2nU0/MMW6wXT6zqkMFcHCJptD84p8RdOGJHpMNYe+OY5nZ9JgprrWipuk
	286OUDsKkJIgSjiNHFGINcKfgajKgMsuQnjMWR32LoaQ1SSsCsO3nW+Io3fX66An
	DlJz0Kz40KWaiHgVOjcIr1lp6skGFNihS2pWuVokdyRum9vjD4hcOl/r1RvSicyn
	bZhut7QTzBuOlnAGatCNo6osy4Qj4Ah5i5tJnE3LpeXzPqd0PxXbKXFV3eZCINB/
	M0ujUbI+lep7UKZLJEFHR9qZQ8dTnJEpfcboyfUXPVcp2CKqX405+S/fPNJQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1738002085; x=1738088485; bh=cRP+DK217qjmvyi+zlvZh1DoEcriRk8x6tJ
	pLrq4SHM=; b=GwFb7Etgx0E50q70h1p1A1jM7hE3M4U17QQDLkBD7U74JQhxfnx
	aeWGhG3UsGp6Maglika6CmVq0G4cS5Ilbac8aAvCETRzcnmN9mbRKZhL8ih5bSTa
	iEDi6Czt5IVh48iwKe6wcVgHrRPKRfG3hHOcajbIOMMyE2xlPsu+qXrJqKBnahsp
	dppzmF0fx9s/iKkoc4nYYqArmXmtol8fsY+kbDlwNq4t3YMcgX3BN6R5kmiHWwi+
	0lwl8HmCL60t2gCeeuf48EfDvVG8ZA0K6t/R6UE382AmELji3D/nPxV0h1X3qrvd
	geB5uP6hKfh0lAXc6ocpWvVtpYLUG8fFz3A==
X-ME-Sender: <xms:pc6XZ907hJ1w2pjDWPNUWbuxIZ6Wa8tp0W8--HgDUXUkt5jXFO9kDQ>
    <xme:pc6XZ0EnyPxKxG_MluTi3IdPl-kosK8tf1S6ty1Hzc4gcR1RblcV1AVc-b7Y3RzEg
    jH4T5au3HfXDa4Rhg>
X-ME-Received: <xmr:pc6XZ950yfnZNdvFuqSTaW3D6xmua2bOLM4IgA43sLIRAb3L91HSWu7itZ18mLeB56kFBaq24yetVL_htO-WT3kkIj5UeYmCaHOk8WoUqg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudejgedgudefkeekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtsfdttddt
    vdenucfhrhhomheptehnughrvghsucfhrhgvuhhnugcuoegrnhgurhgvshesrghnrghrrg
    iivghlrdguvgeqnecuggftrfgrthhtvghrnhepfeffgfelvdffgedtveelgfdtgefghfdv
    kefggeetieevjeekteduleevjefhueegnecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomheprghnughrvghssegrnhgrrhgriigvlhdruggvpdhnsggp
    rhgtphhtthhopeejpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopeifihhllhihse
    hinhhfrhgruggvrggurdhorhhgpdhrtghpthhtoheprgigsghovgeskhgvrhhnvghlrdgu
    khdprhgtphhtthhopehlihhnuhigqdhmmheskhhvrggtkhdrohhrghdprhgtphhtthhope
    hmuhgthhhunhdrshhonhhgsehlihhnuhigrdguvghvpdhrtghpthhtohepjhgrnhgvrdgt
    hhhusehorhgrtghlvgdrtghomhdprhgtphhtthhopegurghvihgusehrvgguhhgrthdrtg
    homhdprhgtphhtthhopehlihhnuhigqdgslhhotghksehvghgvrhdrkhgvrhhnvghlrdho
    rhhg
X-ME-Proxy: <xmx:pc6XZ62iUd_iyq4TAVpDsDqCe90iLTTn-Ep6PLdJ89tZOCZunh2yhA>
    <xmx:pc6XZwF2qads1gBwWYkTbCDoY-RDvsfb2JdINLqn-7XbRz3proyUMw>
    <xmx:pc6XZ7_A_sq3t-ygPilTyxNPX4yZuXjla3MlcwBvRMBMiWk6hOH1JQ>
    <xmx:pc6XZ9k8VRTkq5WyEyOkKq0ZpMk8-MApYzByqwl8sDYEXrld8TwEuA>
    <xmx:pc6XZ70D_tpEWdJTmerntpCQS4iYfiuTronlWa0xfOfI2vbKiBp5FR6o>
Feedback-ID: id4a34324:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 27 Jan 2025 13:21:25 -0500 (EST)
Date: Mon, 27 Jan 2025 13:21:24 -0500
From: Andres Freund <andres@anarazel.de>
To: David Hildenbrand <david@redhat.com>
Cc: Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org, 
	linux-block@vger.kernel.org, Muchun Song <muchun.song@linux.dev>, 
	Jane Chu <jane.chu@oracle.com>, Jens Axboe <axboe@kernel.dk>
Subject: Re: Direct I/O performance problems with 1GB pages
Message-ID: <6ulkhmnl4rot5vrywoxvoewko7vbgkhypcwxjccghdu26kwsx5@bnseuzrsedte>
References: <Z5WF9cA-RZKZ5lDN@casper.infradead.org>
 <e0ba55af-23c4-455e-9449-e74de652fb7c@redhat.com>
 <Z5euIf-OvrE1suWH@casper.infradead.org>
 <f3710cc4-cbbf-4f1e-93a0-9eb6697df2d3@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f3710cc4-cbbf-4f1e-93a0-9eb6697df2d3@redhat.com>

Hi,

On 2025-01-27 17:09:57 +0100, David Hildenbrand wrote:
> > Andres shared some gists, but I don't want to send those to a
> > mailing list without permission.  Here's the kernel part of the
> > perf report:
> >
> >      14.04%  postgres         [kernel.kallsyms]          [k] try_grab_folio_fast
> >              |
> >               --14.04%--try_grab_folio_fast
> >                         gup_fast_fallback
> >                         |
> >                          --13.85%--iov_iter_extract_pages
> >                                    bio_iov_iter_get_pages
> >                                    iomap_dio_bio_iter
> >                                    __iomap_dio_rw
> >                                    iomap_dio_rw
> >                                    xfs_file_dio_read
> >                                    xfs_file_read_iter
> >                                    __io_read
> >                                    io_read
> >                                    io_issue_sqe
> >                                    io_submit_sqes
> >                                    __do_sys_io_uring_enter
> >                                    do_syscall_64
> >
> > Now, since postgres is using io_uring, perhaps there could be a path
> > which registers the memory with the iouring (doing the refcount/pincount
> > dance once), and then use that pinned memory for each I/O.  Maybe that
> > already exists; I'm not keeping up with io_uring development and I can't
> > seem to find any documentation on what things like io_provide_buffers()
> > actually do.

Worth noting that we'll not always use io_uring. Partially for portability to
other platforms, partially because it turns out that io_uring is disabled in
enough environments that we can't rely on it. The generic fallback
implementation is a pool of worker processes connected via shared memory. The
worker process approach did run into this issue, fwiw.

That's not to say that a legit answer to this scalability issue can't be "use
fixed bufs with io_uring", just wanted to give context.


> That's precisely what io-uring fixed buffers do :)

I looked at using them at some point - unfortunately it seems that there is
just {READ,WRITE}_FIXED not {READV,WRITEV}_FIXED. It's *exceedingly* common
for us to do reads/writes where source/target buffers aren't wholly
contiguous. Thus - unless I am misunderstanding something, entirely plausible
- using fixed buffers would unfortunately increase the number of IOs
noticeably.

Should have sent an email about that...

I guess we could add some heuristic to use _FIXED if it doesn't require
splitting an IO into too many sub-ios. But that seems pretty gnarly.


I dimly recall that I also ran into some around using fixed buffers as a
non-root user. It might just be the accounting of registered buffers as
mlocked memory and the difficulty of configuring that across
distributions. But I unfortunately don't remember any details anymore.


Greetings,

Andres Freund
