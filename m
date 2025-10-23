Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AD772F5A18
	for <linux-block@vger.kernel.org>; Thu, 23 Oct 2025 14:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761230372; cv=none; b=akuTfgDdRKYrShnfJpAg8StcU7WZ5bk4/Fb0vHZCjkC1s9/x52cIVCIrDRRZwfZYNEznBLDKiez1VSdmELRStdJbrAwQSpmxQPIXfvX/2zlPJ9+bmoJUFB+w/F3lrPEBWkvLK6NqVdmeEFAvvq4s6DDCVVs4XpJ+a+Xxh1f6sJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761230372; c=relaxed/simple;
	bh=B7sLA840Y6xXi7x1J19mOIN2rSAkkDPSquU8+jExMXs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lwpHsN2LQhZVd5ffj/b1HJc3osuNBu2ILZVuik9Jc3HnDfSNK6yDXAvFOKQhjS60laZVtdEPnq28jJaRsA8KWtoa68izHOqOXgyKJverhkANkzvtaJJNufbHV5geQgNgxjNJZhNt+05xT+Od4kNE6XnLi+24xIwqDzvnTWM/6V8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YVubGghy; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YVubGghy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E961C116B1;
	Thu, 23 Oct 2025 14:39:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761230371;
	bh=B7sLA840Y6xXi7x1J19mOIN2rSAkkDPSquU8+jExMXs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YVubGghyAwJyltFnoGAijzBh2SOEfKl1REjh48MunV9E/CU8q49oVH48BZsRZrjwG
	 XUKYHC6oTZyuuCsyOieXyVzhStneU5Y8MxYzErESp3g34fTa6Lf9KJxI0sBdsFY8eT
	 hY//UcmdF2WPJvyrP2iRBcA6q8kAa37q8aCzp4IXkweQvfkFoVMbIDG3eBriMYCYOg
	 +ImpvvhtzXsDTxbbM5cxblOR/didApkadS3k1zgxXSIWyTMFtCT7JuI+OaKXcF0c1d
	 aaIN1jMQomLtwGS+T3bQrZ6Up9flCIK/fWvLSUxdKCj/7WfWK4f+ZHtWSzUNpCk2/u
	 jy6kSGc7/spBg==
Date: Thu, 23 Oct 2025 08:39:29 -0600
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@meta.com>, martin.petersen@oracle.com,
	linux-block@vger.kernel.org, axboe@devbig197.nha3.facebook.com
Subject: Re: [PATCH] blk-integrity: support bvec straddling block data
Message-ID: <aPo-IUIL8BTpe2BS@kbusch-mbp>
References: <20251022235231.1334134-1-kbusch@meta.com>
 <20251023082201.GA369@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251023082201.GA369@lst.de>

On Thu, Oct 23, 2025 at 10:22:01AM +0200, Christoph Hellwig wrote:
> On Wed, Oct 22, 2025 at 04:52:31PM -0700, Keith Busch wrote:
> > +	union {
> > +		u64		crc64;
> > +		__be16		t10pi;
> > +	};
> 
> Any good reason to keep the t10pi in be format except that is how
> the existing t10_pi_csum wrapper works?

I'm honestly confused how BLK_INTEGRITY_CSUM_IP works. It forces
coercion to __be16 type, but the csum calculation indicates it is not a
BE format. And it doesn't handle partials like how we have CSUM_CRC
working, so it seems broken on multiple fronts. But I don't have any IP
checksum capable drives to test with.
 
> > +		if (iter->remaining)
> > +			continue;
> 
> I find the structure with the remaining continue here a bit confusing.
> I guess the code would benefit from being split into an out loop over
> the integrity intervals and an inner loop over the potentially smaller
> buffers to make this clear.  Even more so with the skip case in the
> verify path.

We already do have an outer and inner loop, though iterating the data
buffers is currently the outer loop. I'll think about this a bit more to
find a more intuitive solution.
