Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8452CC8F3
	for <linux-block@vger.kernel.org>; Sat, 11 May 2024 23:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715470254; cv=none; b=JpGFMvn4YzQDox8ZevA4hkjvbzGhMKHT0CyDkIce+1m+QVrigAaAnVdoagc40D2KW8+4NchSc4okQSnKVxsSWYZ9Wt7K7437CTufQmpPtk540Zz5dPZfYAHS7n9Ni75W/CINO3ZZt2+xwX+M2lgGyzi0JndmBCwNSrlwMpGy93g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715470254; c=relaxed/simple;
	bh=8izEPBuMtDk75QxUh6dCXPuqnlHsQCZxyVAmZI5ABO8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IfRRMaNBW2dL+pVnb5Er2vl2XR8xkdDCtNsGHfP3F2clwfFSrSHxxoIaCj+4WER0FlzCA92dpkeO1JHFD5lx+Z1SDpjpJPtoILT9Ay0kMIEShVL7VAR/j4/V1GltEfz9qnqZDQ9FKZGtPORRTonPpxd1lZnPJIAZOoub0TOyzjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=UeBYxAt8; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="UeBYxAt8"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=ilZDQ3gO3WRFbyjKsCdBHSNTW+HmM2JZ+ueALYHIBAU=; b=UeBYxAt85ahfW84k6/DSwS3fhx
	ZKOHNs4OHgXn5M4I2diIK3lICP6CzGJlFilBcJbXMZox1gCYv8x/uqKu24Dx5Z0mMqnVe6y2Mtb5F
	b0guprS/GMEMMitfkz2St6Xd9wnTIAbOJ5imkAvslr7kKP/uWXnuuSMhFvm8qremgWjEoqlpGUEqI
	+AmvqToV+72d8MzMePtKP53HbdZ28vHUVINfYg/tkOnspti6R8TwTRHm8U/1+r9gu9tsz2boqbPh+
	vqJ9UDGY1nIUK/FBIEbVtDkOiuBGa/i1tt5hnz3L43u4Qzae5uTupGvVrlaw9Kh1PttD8YglEQGcm
	kFejKWCw==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s5wAq-00000006Bq9-3FLh;
	Sat, 11 May 2024 23:30:41 +0000
Date: Sun, 12 May 2024 00:30:40 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Luis Chamberlain <mcgrof@kernel.org>
Cc: hare@kernel.org, Andrew Morton <akpm@linux-foundation.org>,
	Pankaj Raghav <kernel@pankajraghav.com>,
	linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
	Pankaj Raghav <p.raghav@samsung.com>
Subject: Re: [PATCH 5/5] nvme: enable logical block size > PAGE_SIZE
Message-ID: <Zj__oIGiY8xzrwnb@casper.infradead.org>
References: <20240510102906.51844-1-hare@kernel.org>
 <20240510102906.51844-6-hare@kernel.org>
 <Zj_6vDMwyb2O6ztI@bombadil.infradead.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zj_6vDMwyb2O6ztI@bombadil.infradead.org>

On Sat, May 11, 2024 at 04:09:48PM -0700, Luis Chamberlain wrote:
> We can't just do this, we need to consider the actual nvme cap (test it,
> and if it crashes and below what the page cache supports, then we have
> to go below) and so to make the enablment easier. So we could just move
> this to helper [0]. Then when the bdev cache patch goes through the
> check for CONFIG_BUFFER_HEAD can be removed, if this goes first.
> 
> We crash if we go above 1 MiB today, we should be able to go up to 2
> MiB but that requires some review to see what stupid thing is getting
> in the way.
> 
> [0] https://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux.git/commit/?h=20240408-lbs-scsi-kludge&id=1f7f4dce548cc11872e977939a872b107c68ad53

This is overengineered garbage.  What's the crash?
