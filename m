Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CB3837B016
	for <linux-block@vger.kernel.org>; Wed, 27 May 2026 15:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779895681; cv=none; b=G8iisuO28dVjPoqdinh9qrB6gN5IYbC98wgBcM8ebaya1iY2aev4YA2dboggkh6NOlqtY2Ne45EPmmm+3Lr6kSdbgz3uPbeCPp1Vl5E+xTb6XHvMSfnZ5TdHtzi7joBHQeBdZAgW2+ciW/jggrMrMCk/20AcBFDob1Wcpysja6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779895681; c=relaxed/simple;
	bh=yaF0/MGGRTEj1imgWupXLNVzXV1O7b9kuPu2JTQddOM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YT2T/BKm5zetgoD5hxJ7ntJ6ND5ZqMrL2VIB/jNVBFXy6x9CbwZbzZ+k+Pd+0Gk0356KVgDJRtHC5YCrk4qQ95KjzejlpjvMeLSi7qBMBYAI8tBsFSWycI9WLlc2xZEmsz6tb8HK4HV++nD23CV5VeNYaan+44wiRoUmcnAyHsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XuMntUYO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XuMntUYO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 096391F000E9;
	Wed, 27 May 2026 15:27:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779895680;
	bh=yaF0/MGGRTEj1imgWupXLNVzXV1O7b9kuPu2JTQddOM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=XuMntUYOJqdjIOXcFtuHx8vTau+gWZocyoiW0rYiOGwTHrmtMqorzoeTzXCtLJKt4
	 Q5b8HDkb/VTS0TGEUmoCjb6Ri9gzHZW7AEB5olg5Gf6w3kCET0wznB7mumvwod3HDB
	 3uyyAJULQB0v4049swOYwSet+jNEcLzrBLkUiRt3K9b5AgR5cKku/x4zJLNwZ/As5F
	 JHJTlVc/UqRZyLWDPrLlqTCqEZlKG+lrTKq5XGTvMkgXK+837z0BWOGvYqt8o7m6kE
	 jAzX1jVb19wtffQr9VljnTaZCFoWU8FMFZlqfLMJV2f7IWLC/drR2nSEqHxOPZ6ewU
	 A1e4lzZ4+sSUA==
Date: Wed, 27 May 2026 09:27:58 -0600
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: axboe@kernel.dk, linux-block@vger.kernel.org
Subject: Re: [PATCH] block: add a bio_endio_status helper
Message-ID: <ahcNfoJ2yulW4L1l@kbusch-mbp>
References: <20260527151247.2352145-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260527151247.2352145-1-hch@lst.de>

On Wed, May 27, 2026 at 05:12:47PM +0200, Christoph Hellwig wrote:
> Add a helper that sets bi_status and call bio_endio() as that is a very
> common pattern and convert the core block code over to it.

Thanks, this looks good.

Reviewed-by: Keith Busch <kbusch@kernel.org>
