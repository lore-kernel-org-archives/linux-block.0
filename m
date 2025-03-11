Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F1C225D8E8
	for <linux-block@vger.kernel.org>; Tue, 11 Mar 2025 15:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741706003; cv=none; b=MPYKnbofRfWVuL2R0mUSjrRtnr9I/7LMmNIV6LxzpuSIxqwDYQJhl7EIFYJ6+rw2Bh0lwtzL/iItm6QJjjYCen9+fyjJtOdvI0FRBKwJ4IEZbojpoxPbXDOINJaIvbkakK0Sbw2aobQrVrL//94XTNWG7b/BmjJF4qVK4NKo0Uo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741706003; c=relaxed/simple;
	bh=PxD6cAZe0tkZIMIX1U623z6imx0QQj/gQzeSzQs3IQo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S+WW3ktVe8Ow1ESRsaPOSBapc14Hg4Y6CsVVenNHumjUf++t6HENs9tfnYab5Kiy+lqiqReypTjfuDEXx5n510QKililaFQiOM9s/22EswuRGtWHXJKPAAS1UusPSOZmSPbJygajN0fBp53cmbfeoUVx+Ss64hC0S1C4LEu0Y90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HDoEbm4Y; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HDoEbm4Y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CF18C4CEE9;
	Tue, 11 Mar 2025 15:13:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741706003;
	bh=PxD6cAZe0tkZIMIX1U623z6imx0QQj/gQzeSzQs3IQo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HDoEbm4YS2cmkLDzUBpgptpcEbt97+zQflTaBJocn97W1P5wPcTk02Os0byJLl6G1
	 zFTnUyjwtko9AJfLjEBK7UfFPdXihqc2880AwiePlLBNs/q+OA9pab9D2k+mtmR/tF
	 vD/oK4cUB//ND0IuPCUUnEbukqQFhOEbjikBXepwLzw6bFuxYwTCuLE2udU/YMVIqi
	 bjWs5B3nMw6ijM+C5gIcWUb337HhEVFGJAug/C54huRH8YVcn1we6Q4c/BQ3lSybnS
	 /SwrskqrCy3/Q+gjSiVVUGUEP3IpumzSYOAPgX+67/dVyHD0KKiampF5me5tUCzRyd
	 uS9fcCpYELEdg==
Date: Tue, 11 Mar 2025 09:13:19 -0600
From: Keith Busch <kbusch@kernel.org>
To: Niklas Cassel <cassel@kernel.org>
Cc: Kent Overstreet <kent.overstreet@linux.dev>,
	Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Damien Le Moal <dlemoal@kernel.org>
Subject: Re: [PATCH] block: Allow REQ_FUA|REQ_READ
Message-ID: <Z9BTD_T3sEzk-Nim@kbusch-mbp>
References: <20250311133517.3095878-1-kent.overstreet@linux.dev>
 <Z9BOf7WljNX-Rnl7@ryzen>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z9BOf7WljNX-Rnl7@ryzen>

On Tue, Mar 11, 2025 at 03:53:51PM +0100, Niklas Cassel wrote:
> So IIUC, at least for ATA, if something is corrupted in the volatile
> write cache, setting the FUA bit will ensure that the corruption will
> get propagated to the non-volatile media.

It's not necessarily going to corrupt persistent media if the volatile
write cache is corrupted. It should just apply only to data written to
the volatile write cache that hasn't been flushed to the media. If the
device reads persisted media data into a corrupted cache, the FUA here
should catch that and see good data.

But if you haven't flushed previous writes from a corrupted volatile
write cache, then I believe you're right: the read FUA will presist that
corruption. Same is true for NVMe.
