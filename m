Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A16D920E003
	for <linux-block@vger.kernel.org>; Tue, 18 Mar 2025 15:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742310609; cv=none; b=XCgmfvwkYYTxDevM3jojUmCu8b0G+FMtwjKcq7cVEQ1kn1wGViWxu7YwMkCf0abjtQsS95aV8aIHyKzmtOzvwtdv1V6BCtQn2l7bc11g4B8YaKDGJIQKUvQ3U/NKiAsICjXD/iZvSWRd1sknFDlGNP4N3TnDeI7QLWdhSCC/J/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742310609; c=relaxed/simple;
	bh=yQocXpLkv9g7XgkJt1FLZOKtQHb/ujYDXpmmbzvL9cE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B+CPWAlsu9vjB2pS+EHaXGlj82yfVjtT7QuZoZ2PNe6oHrf4khye51NW656izxjY8++lRwUblKvX8VfAxF7pKWWgPfimn7t4Xnl8ZLpZG1JNO8zkm0Pv5jf9ZMMkoq+c3zEj5obR4LArcNTuE7/8KVHNhor6AheusVJkgkjER3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ta7DPw3a; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ta7DPw3a"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=KPzvqhNdA/noDOnnlw5z8tp+Ka++iM8I1Wys1c4Pbj4=; b=ta7DPw3akZ+xqYbWrGDcPexSNr
	RC1qLXeYFNz00BO5A5NB+fzKewOGE9In5lKVzwzUvvvsuAFfL0j+HQBusycR5h4j4qAP7XvB2uL88
	3n1vEirz8V23XhEoxJDf7GnvBlG4XStyF3Gh4JegTYoDQKl+Bc9V0IcG5n6WrqJ26eH00/Ygr57tw
	roSevqgG0Qvu6JmEK2bbvyj5vYiYpAEH6i560EApJIL0UoHncVUwDqI3twgp7WkR67Fc7o/Msj0Dq
	3zMtjb7HR5KoVVvbdqbYBwHCrWnaF5L6wAcUSI1s0v6YesGmfuCarimuvdIDEAxoBgeJ9kGuo6I16
	UOwq41Vw==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tuYZt-0000000Fe88-3FER;
	Tue, 18 Mar 2025 15:10:01 +0000
Date: Tue, 18 Mar 2025 15:10:01 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Hannes Reinecke <hare@suse.de>
Cc: lsf-pc@lists.linuxfoundation.org, linux-mm@kvack.org,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [LSF/MM BPF Topic] Warming up to frozen pages
Message-ID: <Z9mMyUK1sQjJ6faZ@casper.infradead.org>
References: <2a2e5822-d8a6-4460-b92a-01d113e18ead@suse.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2a2e5822-d8a6-4460-b92a-01d113e18ead@suse.de>

On Tue, Mar 18, 2025 at 03:47:31PM +0100, Hannes Reinecke wrote:
> 'Warming up to frozen pages'
> With the frozen pages patchset from Willy slab pages don't need
> (and, in fact, can have) a page reference anymore. While this easy
> to state, and to implement when using iov iterators, problems
> arise when these iov iterators get mangled eg when being passed
> via the various layers in the kernel.
> Case in point: 'recvmsg()', when called from userspace, is being
> passed an iov, and the iterator type defines if a page reference
> need to be taken. However, when called from other kernel subsystems
> (eg from nvme-tcp or iscsi), the iov is filled from a bvec which
> in itself is filled from an iov iter from userspace, so the iov
> iterator will assume it's a 'normal' bvec, and get a reference for
> all entries as it wouldn't know which entry is a 'normal' and which
> is a 'slab' page.
> As Christoph indicated this is _not_ how things should be, so
> a discussion on how to disentangle this would be good.
> Maybe we even manage to lay down some rules when a page reference
> should be taken and when not.

My only concern is that we might not have anybody from networking to talk
about their side of all this.  We need Dave Howells for this as one of
the network filesystem people, he probably understands this fairly well.
Anna might have some network stack knowledge too.  Maybe we can get some
of the BPF people to join in; although their track looks very dense,
so we'll have to try hard to find a time when there's a topic that the
networking-BPF people aren't so interested in.
