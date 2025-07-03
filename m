Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48D3A2E7F0B
	for <linux-block@vger.kernel.org>; Thu,  3 Jul 2025 14:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751554065; cv=none; b=CBFRuiL56gAph2j2N4eIGBwgYxlyuffMrDuuXBp7KwKAcql3feDaLysMt8GrE+0bYsztDSvMwAkkHKouidkSV1WMj4Jh8igIyWE0/+2I8blg9aIV67WBoZv/VJC6wSK4IN8g6BKB/UDCZC7mU4zrwQxdWP3vhMu3mM3dKWUrfS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751554065; c=relaxed/simple;
	bh=+41I3uZo55oA1LXa7CCXtgoAnRr9kzXPuFUuywHZE1E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cHpT1kKNU2GiuMul0acwBDNnMCv6af2xWH1UZd9nPLaMpM1Mck1xLzeF8rrN/0l17/p0A1IsGv4t5vC1vmQjMNfxzQrwgML1h2WxXVjc98KeIHmRvACWLgvagEFMmCy8InbNcZpXQe8PgCy7ZBRdsBEb1UMtC7jxS3VuzkP8G9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sgfzM3xC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sgfzM3xC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06CC8C4CEE3;
	Thu,  3 Jul 2025 14:47:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751554065;
	bh=+41I3uZo55oA1LXa7CCXtgoAnRr9kzXPuFUuywHZE1E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sgfzM3xCqpFu8U2ri+U/qERj1bC9iGpSCQ9hL0jc2z2zzYV6Y9c2waSSOxEO2nau7
	 4bnvKLPSvY397sUXiFci4VOTzCAsn6/0cfYrJXRSkhBJ8+jpGxNca27BoNKipJv0zo
	 /QHAprZnoTF8a4PhdRyt8oS/OyiBn2rPrw0oXoa/vykH6JW9kskRTlBTdy7fv4Jc1t
	 tGrBaELr4R91GCO5fAK2I9+U57dyrjC94e1a/BoDGSmKBe0I6GUkuxyOBzZ6Uj64MV
	 8X6DP6Y19azp+xJEeE5Xn+80HA9WlL/hQ3Z3s4DT5DLOkoq8DrjcmJfgY2bNZuItgs
	 yCvl+h9n/2fQg==
Date: Thu, 3 Jul 2025 16:47:41 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Keith Busch <kbusch@meta.com>
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
	Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH 0/5] block: another block copy offload
Message-ID: <aGaYDa6K1jiYUtjY@ryzen>
References: <20250521223107.709131-1-kbusch@meta.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250521223107.709131-1-kbusch@meta.com>

Hello Keith,

On Wed, May 21, 2025 at 03:31:02PM -0700, Keith Busch wrote:
> From: Keith Busch <kbusch@kernel.org>
> 
> I was never happy with previous block copy offload attempts, so I had to
> take a stab at it. And I was recently asked to take a look at this, so
> here goes.
> 
> Some key implementation differences from previous approaches:
> 
>   1. Only one bio is needed to describe a copy request, so no plugging
>      or dispatch tricks required. Like read and write requests, these
>      can be artbitrarily large and will be split as needed based on the
>      request_queue's limits. The bio's are mergeable with other copy
>      commands on adjacent destination sectors.
> 
>   2. You can describe as many source sectors as you want in a vector in
>      a single bio. This aligns with the nvme protocol's Copy implementation,
>      which can be used to efficiently defragment scattered blocks into a
>      contiguous destination with a single command.
> 
> Oh, and the nvme-target support was included with this patchset too, so
> there's a purely in-kernel way to test out the code paths if you don't
> have otherwise capable hardware. I also used qemu since that nvme device
> supports copy offload too.

In order to test this series, I wrote a simple user space program to test
that does:

1) open() on the raw block device, without O_DIRECT.
2) pwrite() to a few sectors with some non-zero data.
3) pread() to those sectors, to make sure that the data was written, it was.

Since I haven't done any fsync(), both the read and the write will from/to
the page cache.

4) ioctl(.., BLKCPY_VEC, ..)

5) pread() on destination sector.


In step 5, I will read zero data.
I understand that BLKCPY_VEC is a copy offload command.

However, if I simply add an fsync() after the pwrite()s, then I will read
non-zero data in step 5, as expecting.

My question: is it expected that ioctl(.., BLKCPY_VEC, ..) will bypass/ignore
the page cache?

Because, as far as I understand, the most common thing for BLK* operations
is to do take the page cache into account, e.g. while BLKRESETZONE sends
down a command to the device, it also invalidates the corresponding pages
from the page cache.

With that logic, should ioctl(.., BLKCPY_VEC, ..) make sure that the src
pages are flushed down to the devices, before sending down the actual
copy command to the device?

I think that it is fine that the command ignores the data in the page cache,
since I guess in most cases, you will have a file system that is responsible
for the sectors being in sync, but perhaps we should document BLKCPY_VEC and
BLKCPY to more clearly highlight that they will bypass the page cache?

Which also makes me think, for storage devices that do not have a copy
command, blkdev_copy_range() will fall back to __blkdev_copy().
So in that case, I assume that the copy ioctl actually will take the page
cache into account?


Kind regards,
Niklas
