Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B72C2FD685
	for <linux-block@vger.kernel.org>; Wed, 22 Oct 2025 14:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761142994; cv=none; b=F20pY3dXOvysc2B+tUxCHUHyI7ardPtzkHIjAqKfE26zd/bXUl19yGm9BqgFydgo6d3XnsRZ1YIyyMxU+B89v7Y7h3zQO+j2Qv9I4A/GkrMul7U9NQUzhbYfmvuwMAYAKp8QC6x9jd1bhzBukNaEYXxWcYGcn+kBqr0BP8njRl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761142994; c=relaxed/simple;
	bh=BUh88woEez164Y5BCw9yMJ5sfIxn/3Fp5M5aZ9/UQHY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rlF1yQraTO3JIL9wk9z8NI7kiA/hRRlKbDrRD0jNWj7cv13uNL9qhkYUqJ4P42B7ecZfeRlsnndNhcArNzrePJD/u+CyKHiKgs37fyxF/Z+cjO5445tCNtXLPNjwWWt9Q/mbbOSbu09mqo1PbG7PfyiaPP1h1HkYO4Z4uGSFjIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S5gc6C0a; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S5gc6C0a"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4178AC4CEF5;
	Wed, 22 Oct 2025 14:23:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761142990;
	bh=BUh88woEez164Y5BCw9yMJ5sfIxn/3Fp5M5aZ9/UQHY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=S5gc6C0aIBFPxqrZmaheYRg6Aobnk/ZQJbRNfL34DpckcHfluEZqycRb09jc+gZqP
	 5fPbczXCrsgw6ItDrILlGcObXw8myF4rw+er5LVHbfMrGFb/XctuCM6meNWPoDXwFn
	 ux+6hJPNzUSuCW/ugYWqzdRWQCr62GsmtQ9j8osyC0YNYSD8Bd09Jr30ufsuAMvmDf
	 gcBqTDE5XC2dQf1ZbbsPMonWbdoRrd/BYpV+ptXcgHOnp6flhcP2jwP6i00uSKtyhN
	 JWHA0M39/FqFj0lxFffP8wybkrNY4Tm+ggOdI7MYUhTLFlcE0FXz5Zo8e1sygsukkw
	 C6x2OWEgw5ZDg==
Date: Wed, 22 Oct 2025 08:23:08 -0600
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: axboe@kernel.dk, linux-block@vger.kernel.org,
	martin.petersen@oracle.com
Subject: Re: [PATCH] block: require LBA dma_alignment when using PI
Message-ID: <aPjozAAE9V-jmqUI@kbusch-mbp>
References: <20251022083335.2147105-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251022083335.2147105-1-hch@lst.de>

On Wed, Oct 22, 2025 at 10:33:31AM +0200, Christoph Hellwig wrote:
> The block layer PI generation / verification code expects the bio_vecs
> to have at least LBA size (or more correctly integrity internal)
> granularity.  With the direct I/O alignment relaxation in 2022, user
> space can now feed bios with less alignment than that, leading to
> scribbling outside the PI buffers.  Apparently this wasn't noticed so far
> because none of the tests generate such buffers, but since 851c4c96db00
> ("xfs: implement XFS_IOC_DIOINFO in terms of vfs_getattr"), xfstests
> generic/013 by default generates such I/O now that the relaxed alignment
> is advertised by the XFS_IOC_DIOINFO ioctl.
> 
> Fix this by increasing the required alignment when using PI, although
> handling arbitrary alignment in the long run would be even nicer.
> 
> Fixes: bf8d08532bc1 ("iomap: add support for dma aligned direct-io")
> Fixes: b1a000d3b8ec ("block: relax direct io memory alignment")

Wow! Looks good for now and stable. I agree handling block data across
discontiguous segments is a good plan for after this.

Reviewed-by: Keith Busch <kbusch@kernel.org>
