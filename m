Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DF15225DD
	for <linux-block@vger.kernel.org>; Sat, 11 May 2024 23:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715471497; cv=none; b=rmNxF0bVQejc85FAM1m7+VH1jXiKpXyb3CO/RJBaod1niqY8jjt/SJr7PSiw6DCLnGFa8FDRumdvisVUYL3ldvUmFvCgPrxVkYkJfjiSj5Q29imTrR6G7B5nvntrArMStU/qFMGEQUNGPWpDqHwwpiuwNp8TrRDvZW3tNoPXYI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715471497; c=relaxed/simple;
	bh=78jLJMUHQFPphzVrpUank3iJaKGqExdIxidg5AK1zfw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iUXUl21YbeMx8FFdWpbMqY6i7kvBEf4XBcn3dgoXFXCSOLsU79duJal8XkZG4o1MXcBQDLxt4jIdJpsmbuoKZ9QOD3w+5rupU47gaJM37cZKq4G67u5/xFi8Kd8xI8+IPmbpAY3JQYqkzDjwcWsDjMEEvgUI6fk2BLRV0/P4Xkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=xNAWC0Hn; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="xNAWC0Hn"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=u30s/X7RmhRmxcRFmrm1T3EjNuuh+CudoZ1sJYEmT/8=; b=xNAWC0HnxxaO+l94//zzhcEHmQ
	Ck9VLwDzUhLK+3NXGj/h9yJ6TlqvAIEPVkNOEwVuKlAEu8CiFynT4RVcl2O0hhWQV5YNYhjSoEfvW
	47tMcro9IXPXyKnEOttLm0I17JfxVdblSf/j+mDx1LZYzux599Z3YXPeIwEfLdAxa2MgiabqSORYr
	IyG2OdqTlgQ6VFs6nbeTqzelnlnL6a4HsdBUg9H+2a9wpoFAljJ510baTygu6VPjHOaym31SQLAxd
	oIOH2HCLx6dA1opONHfk/qz+iA8G5OibcFV+EwbJkw99h5MqxcRVP2DKCHuOi2gVS9o3pOp/HfKbx
	kJ2pjzrw==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s5wV2-00000008wz4-1n8l;
	Sat, 11 May 2024 23:51:32 +0000
Date: Sat, 11 May 2024 16:51:32 -0700
From: Luis Chamberlain <mcgrof@kernel.org>
To: Matthew Wilcox <willy@infradead.org>
Cc: hare@kernel.org, Andrew Morton <akpm@linux-foundation.org>,
	Pankaj Raghav <kernel@pankajraghav.com>,
	linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
	Pankaj Raghav <p.raghav@samsung.com>
Subject: Re: [PATCH 5/5] nvme: enable logical block size > PAGE_SIZE
Message-ID: <ZkAEhFLVD9gSk0y0@bombadil.infradead.org>
References: <20240510102906.51844-1-hare@kernel.org>
 <20240510102906.51844-6-hare@kernel.org>
 <Zj_6vDMwyb2O6ztI@bombadil.infradead.org>
 <Zj__oIGiY8xzrwnb@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zj__oIGiY8xzrwnb@casper.infradead.org>
Sender: Luis Chamberlain <mcgrof@infradead.org>

On Sun, May 12, 2024 at 12:30:40AM +0100, Matthew Wilcox wrote:
> On Sat, May 11, 2024 at 04:09:48PM -0700, Luis Chamberlain wrote:
> > We can't just do this, we need to consider the actual nvme cap (test it,
> > and if it crashes and below what the page cache supports, then we have
> > to go below) and so to make the enablment easier. So we could just move
> > this to helper [0]. Then when the bdev cache patch goes through the
> > check for CONFIG_BUFFER_HEAD can be removed, if this goes first.
> > 
> > We crash if we go above 1 MiB today, we should be able to go up to 2
> > MiB but that requires some review to see what stupid thing is getting
> > in the way.
> > 
> > [0] https://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux.git/commit/?h=20240408-lbs-scsi-kludge&id=1f7f4dce548cc11872e977939a872b107c68ad53
> 
> This is overengineered garbage.  What's the crash?

I had only tested it with iomap, I had not tested it with buffer-heads,
and so it would require re-testing. It's Saturday 5pm, I should be doing
something else other than being on my computer.

  Luis
