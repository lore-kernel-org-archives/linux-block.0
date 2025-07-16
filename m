Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57DB7C2D1
	for <linux-block@vger.kernel.org>; Wed, 16 Jul 2025 01:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752628475; cv=none; b=pEjIdoiqjBE2+8Oua6MPuIjXn1F3cVoLeKbpTMgsfTlhiPD8AW53d0IaczZEjxMgevYXlX++AmTwcm5EzxZNZz8jbwnybEjlkjfvUwPzs054J+PV2jBv9k7HojChsfPBiyhXBPivyzRMvtTwk5Iro9qt9rfZt7n/tOw8LX2oXSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752628475; c=relaxed/simple;
	bh=BIobLUhCRywcqD9DTRaeIFV04RlNHS5NSlp/K47bkCg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iNuYwVoTPQluka3Ocp8lyX9ub4002Il+22pHFpoWOM1RobwpzuO+YScFmSX9L806m1cmvH0UBoWt1o4rjPmL++0OuM7t4EK4kcZZsm0265keJUuMLvRUociJyjoAKJt0dvDS678dbiY0bC00vlVPFhVoTgkyakud8K+zz4PKL9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FlTL1JpQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FlTL1JpQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A240FC4CEE3;
	Wed, 16 Jul 2025 01:14:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752628474;
	bh=BIobLUhCRywcqD9DTRaeIFV04RlNHS5NSlp/K47bkCg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FlTL1JpQ4cjIeHm4K8OKTt8Q36Y4QBwkInPrs5DLj6GijS91mP1j37SVNj+x0oCxR
	 iJ+D4Xd1Yb/FrbIY1uI6kJg73rL7JAQB/qYo2Uq4zuFNY3NAsDyx9lUjlDDXs14A+N
	 ZxECsKEyZIjOvFs9cMvNFdab8KKPf+OWxYjMnLtHMrfi9Dx57LcVSQz+IrTRkm4uvb
	 rQ9baXTU+4c5cUwubKfsZMjGAKrRQF50v4onCCzB1h8ideAyz9Iz0hBxafMilVqTfJ
	 wYr4Ap1aHvBDjxbotYHcbD5CrL5bqtdzyKALrO8PCHd3p7mPhjCrc35D8eMZbCuG01
	 aL6tV/f5zqnuA==
Date: Wed, 16 Jul 2025 01:14:32 +0000
From: Eric Biggers <ebiggers@kernel.org>
To: Bart Van Assche <bvanassche@acm.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v3 0/7] Fix bio splitting by the crypto fallback code
Message-ID: <20250716011432.GB765749@google.com>
References: <20250715201057.1176740-1-bvanassche@acm.org>
 <20250715214456.GA765749@google.com>
 <9ed44419-ec53-431d-ad71-c19f83c3f98d@acm.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9ed44419-ec53-431d-ad71-c19f83c3f98d@acm.org>

On Tue, Jul 15, 2025 at 03:35:19PM -0700, Bart Van Assche wrote:
> On 7/15/25 2:44 PM, Eric Biggers wrote:
> > But if the actual encryption is done using code
> > whose developers / maintainers don't really consider encryption to be a
> > priority, that's not a great place to be.
> 
> Why does the crypto fallback code clone a bio instead of encrypting /
> decrypting in place?

Decryption is already in-place.  Encryption is not, and unfortunately it
can't be since the source data must not be changed.  If you encrypt
in-place, then the data would get corrupted every time it's written.

- Eric
