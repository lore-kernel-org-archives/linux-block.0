Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6446E239E6C
	for <linux-block@vger.kernel.org>; Tue, 21 Oct 2025 05:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761024492; cv=none; b=M42jF4ds9hSPyNJcDq5TPE1XbnLgMUzwlkj95/qlGci+Y5ejeStfeCk7x6GbJt4MPFUpamaYm7RK+2xdvHeKL85uOgU8Fl7I6Kc/jDhqG0zObRiwmUWMzm1b7eHn31a/lS9MCoGgnrZFGwb5UPxttv2G0M1SRKuPzawLx+OHi/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761024492; c=relaxed/simple;
	bh=P6Jg8YHEIbtliCnDae6SM4ZISfr/+YfYceCBNJda4YE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EMg1pgVikd9WucT2fQmb6qutQYYqHTRpKVQE4opNQnZbJ5J0B6+RDTb1KJPD76aZIxPXN13A4xHZCG224qORQ/oFlrLl5Ob7UCIAKd7JOLYD7hWbyb0zCUner+66zwOm6cjh3s3IdVbL1ejj9sg5/j2Suoju0MU1s99p86ZjJ9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=HaKOFnaQ; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="HaKOFnaQ"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=W69f0tQ4CMv4ZlT9/HB4fwJpQYzoqAxGNB4QgadbVLo=; b=HaKOFnaQXjadFuUF4fofRP6EBy
	Xwrn6yJUt2ITT2E10/ISz0OId6Yuo0+xee7+RSw0GuBO+8/qI2KV4JBukHKBLkNe9S2p0F9bK0mlA
	tCBIa2GfmlU/oc3NLE8TMClbobIU6Xm/R4fhbSWPJhEYlju/Ou53Lu8xNOZjFrbh1Y9chQLv6RBO0
	KM+ufGJgS4EOadcVSMTI2Zt8UmcihsCDQU/TkBFGSwXQCLCRkST1/LIRIZFzWRbmz7HpJHKzc2t+m
	mIo1H6L+RjphT5W3jtjYuSWJVFKuk6RnS/BirP5uqMrFv3zvpUtLsdP78bPV0RcEGdMJhdsQNNie2
	KpwCnw2w==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vB4un-0000000Fr5n-2UoA;
	Tue, 21 Oct 2025 05:28:09 +0000
Date: Mon, 20 Oct 2025 22:28:09 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Keith Busch <kbusch@kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>, Keith Busch <kbusch@meta.com>,
	linux-block@vger.kernel.org, shinichiro.kawasaki@wdc.com
Subject: Re: [PATCH blktests] create a test for direct io offsets
Message-ID: <aPcZ6ZnAGVwgK1DO@infradead.org>
References: <20251014205420.941424-1-kbusch@meta.com>
 <aPIk3Ng8JXs-3Pye@infradead.org>
 <aPZhWIokZf0K-Ma9@kbusch-mbp>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aPZhWIokZf0K-Ma9@kbusch-mbp>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Mon, Oct 20, 2025 at 10:20:40AM -0600, Keith Busch wrote:
> In addition to a flag to say direct-io can use block data split among
> multiple vectors, there's two currently unreported attributes you need
> to know in order to successfuly use direct-io like this: max sectors and
> virtual boundary mask. The max sectors attribute is needed to know
> exactly how many vectors you can insert before the total length needs to
> add up to a block size.
> 
> Adding these to statx or fsxattr will help remove a ton of crap from
> this test since I could remove all the stuff extracting it out of sysfs
> from any given file.

Yes.  And all the applications would have to do the same things, so this
seems like a huge win.  Any chance you could try to get this done ASAP
so that we could make the interface fully discoverable before 6.18 is
released?
