Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E889B24B23
	for <linux-block@vger.kernel.org>; Sat, 11 May 2024 23:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715469128; cv=none; b=ObZ1CUibEf9EgjVO8cOaXqfzJ33OSeqlL9uiMjq/LrCDaI0AeXChV+sGkT0P/RdEB2fuFG2d7kHdZ0IhLLY4GGjx+TSNT+D1JK/6CbfXW9oH7k8pTi6dckyjr/z723VQPc+RO7rkhprVgp2Nuxx9+8rNiw+Vh0JqHpC7bzmNS54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715469128; c=relaxed/simple;
	bh=CrwvGsJCK3lvrqdSsA7KMtLLU+61PMchtNh8aC5CpwE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GUv54t7bs13wZw8nCt/1PauSExkcX3zZmdTi1fMBq+vg9DsncN06Lrt6gkHlH5OarhQt9q/Kfxg7FYEVGHDwIFaod9/TRIx8KjywK7ncKhs2Twxqq7yNzEyQyxXeylVG7ecwlJbqDUGVJ0arxpLcr6i0klqzcxEzA8KJS25Twr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=qcNL/RBq; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="qcNL/RBq"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=zfu76T4DPAp48niDxAaHqRJdPWrA+RjCKXbxAlaC2mQ=; b=qcNL/RBqfftl8T659v7Uglch7i
	KB4gSsjXk1y4eSEy4x9sae47mKCrS+A7e9EMhWbvgX9Xon2dcosgLTaxCKK8L3qJCsC5h2QAlyQfV
	91eC+/6tcXpg0Hp7m4HOGDwR1vYxeI5F8GT735PqTEp2tKV+IBVthvRTtfPGpF1hp2ULftjWwq/k0
	x5ylGX/4I9Tbi53/Dy51oxaSdVGVAjnBtAIb8DQJHVlkgaA3VRL6W5BQfm5QDaMokVPFESbS9RcPY
	mOrCtnp8eZppBS1LMWdvUVUFmjbO0Av1mwfuNGund/OFlAAKNNbEBbgxoeSoIeWt6rihLzX6vL1/Z
	ttbgkl5Q==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s5vsr-00000008taW-2AMf;
	Sat, 11 May 2024 23:12:05 +0000
Date: Sat, 11 May 2024 16:12:05 -0700
From: Luis Chamberlain <mcgrof@kernel.org>
To: hare@kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Matthew Wilcox <willy@infradead.org>,
	Pankaj Raghav <kernel@pankajraghav.com>,
	linux-nvme@lists.infradead.org, linux-block@vger.kernel.org
Subject: Re: [PATCH 0/5] enable bs > ps for block devices
Message-ID: <Zj_7RUso13b4FXSZ@bombadil.infradead.org>
References: <20240510102906.51844-1-hare@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240510102906.51844-1-hare@kernel.org>
Sender: Luis Chamberlain <mcgrof@infradead.org>

On Fri, May 10, 2024 at 12:29:01PM +0200, hare@kernel.org wrote:
> From: Hannes Reinecke <hare@kernel.org>
> 
> Hi all,
> 
> based on the patch series from Pankaj '[PATCH v5 00/11] enable bs > ps in XFS'
> it's now quite simple to enable support for block devices with block sizes
> larger than page size even without having to disable CONFIG_BUFFER_HEAD.
> The patchset really is just two rather trivial patches to fs/mpage,
> and two patches to remove hardcoded restrictions on the block size.
> 
> As usual, comments and reviews are welcome.

What's the test plan?

  Luis
