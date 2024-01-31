Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E34512DDB1
	for <linux-block@vger.kernel.org>; Wed, 31 Jan 2024 17:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706723072; cv=none; b=o6XFyoZ1crdvELjDgcPj5AborIlK5I/8bgnVtBaqWaOggmytA/6mQRwYXtCp8Sw/Ngk/avcAOtJgbnv2pOrtJSY9Kv8otFme7GpcA5HiE5Dj5hwhk/sZRzSPF+O6V1IXn4q4hT3RK5H++iOr4b1z/71+QF1ojsdsgHdwOuEr1fs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706723072; c=relaxed/simple;
	bh=IhbssACKJ6bbGjEfKqH6OrV56/EZX7aHwtSnjlNeiN0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gUFlbQYAtsLnGXJtKefaZcGrZRceoXO7R2my6Gh4j+RdxinZxSnmxJ0bkS9o/S8XA2D3kLYdhH1HUsw9J7nVlmCdHj9tko1GZIZhNH2faLEP0x6zymvdKvXY/RVvlmNoWfhqTWrfpLV+It5sZAl9a39ASeWC5fT9JkwIBg9RMNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hm5vMz/M; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hm5vMz/M"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9138DC433C7;
	Wed, 31 Jan 2024 17:44:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706723072;
	bh=IhbssACKJ6bbGjEfKqH6OrV56/EZX7aHwtSnjlNeiN0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Hm5vMz/MJTAoRVewFJIuWPPK3SEIUgWpLRsLeS6t1dP3MMaFWr/EtlBAG7sYR5kQc
	 w8AARUimTrqij9x3BnxbCdBnZZ3RTirow1QvoLy3z/RLOtcHsQ+Hukh9NsJQWRUKy9
	 WWxEO0P1sorKfe4jTzuMYiPJ72FM1xjBeMAiybDQtQ+tCBuzWg1Rg5ZtB+7UQAx+LO
	 Fhy01PmxhxRVjNe4tMrAZR0suHXdfFqr/3OTJcqkis1hkbmr0MbtUEk3yxQE6y+YSi
	 TB9SPReM4ALamtWTfaZiVPw5+68Nxt+9dqcNrbLcbx0YpFnaiYqu2JjbLjB+RNUlpC
	 /cwodAMIROWkg==
Date: Wed, 31 Jan 2024 10:44:29 -0700
From: Keith Busch <kbusch@kernel.org>
To: Kanchan Joshi <joshi.k@samsung.com>
Cc: axboe@kernel.dk, hch@lst.de, martin.petersen@oracle.com,
	sagi@grimberg.me, linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org, gost.dev@samsung.com
Subject: Re: [PATCH 0/3] Block integrity with flexibile-offset PI
Message-ID: <ZbqG_YswNw1OL6ke@kbusch-mbp.dhcp.thefacebook.com>
References: <CGME20240130171918epcas5p3cd0e3e9c7fb9a74c8464b06779c378ea@epcas5p3.samsung.com>
 <20240130171206.4845-1-joshi.k@samsung.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240130171206.4845-1-joshi.k@samsung.com>

On Tue, Jan 30, 2024 at 10:42:03PM +0530, Kanchan Joshi wrote:
> The block integrity subsystem can only work with PI placed in the first
> bytes of the metadata buffer.
> 
> The series makes block-integrity support the flexible placement of PI.
> And changes NVMe driver to make use of the new capability.
> 
> This helps to
> (i) enable the more common case for NVMe (PI in last bytes is the norm)
> (ii) reduce nop profile users (tried by Jens recently [1]).
> 
> /* For NS 4K+16b, 8b PI, last bytes */
> Before:
> # cat /sys/block/nvme0n1/integrity/format
> nop
> 
> After:
> # cat /sys/block/nvme0n1/integrity/format
> T10-DIF-TYPE1-CRC

Your series looks good to me.

Reviewed-by: Keith Busch <kbusch@kernel.org>

While reviewing, I realized O_DIRECT with DMA aligned offsets smaller
than block sized offsets can create segments that break PI iterations.
Not your problem, just mentioning it because I noticed ... and since I
introduced DMA aligned offsets, I should probably take a shot at fixing
that.
