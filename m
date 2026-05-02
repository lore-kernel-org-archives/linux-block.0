Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B9B2273816
	for <linux-block@vger.kernel.org>; Sat,  2 May 2026 11:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777722105; cv=none; b=F89dYnjPBofYApjpaOH6D7V4baygCLMDyo3fRGdjS9N4ij3BacT17uikNMpQG4cRnJcKBoYWcZCD2bCTCIEq77KKndkmfDZXg34WEYFuBwNTHmLPGQ6Alguv7afIHy9W0Pdz6DNRttjlPDNItB/ZP4DLBUi1LlNZY/iqSpRAAe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777722105; c=relaxed/simple;
	bh=XQnsbGpN/kxMk5Zz8/L2zvlr+6flATk8ET1zzPBpmVA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I+cbhCmY1JgqRyh9ykU1VusHUyWyu5JxEKHo2buFuEmf7LKZoCCw47Yw4b/gtKgm+ZRGt98meftCfESAr0F4k4tt7LpNGDtntJcdxL4wcbtd3J7avXfjH041zK3dN5pSrOxk/G3WJlZhpulg6Ix24sa7zuRhfE/Gs/mC/FzsltE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VaDEa38c; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VaDEa38c"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08809C19425;
	Sat,  2 May 2026 11:41:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777722105;
	bh=XQnsbGpN/kxMk5Zz8/L2zvlr+6flATk8ET1zzPBpmVA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VaDEa38cgh6MTu3rs9rJ6eODBlK/PlEzqISK1EJ9eL7HhyDdC/kS45Ky7phwijzzm
	 oUdESmWKD7TmpYpCs+fKgfmrxJVMCLo06ofEIbo1LRxuVq0VpN1X5dPObD6DLWryC1
	 l+dVsw6qTBgghBSnfL5QZCPmXSItCeHajtZ59pMNNCojoJYtHFjaRFA0VUaYv7ejor
	 KsRsVY2PjukPP8Mlt9Oitig6khgvgxXjzI8IB0oqU6TeqJfPy6cRwT8aTY3lHGVLvt
	 BuRrTNLqh5e5MogxxlcaslQ5HULjYWGix1Y+IAKDAz5cUdxaJEqQqAN9aJ20MPMu2G
	 quK6ZcUb+iHhQ==
Date: Sat, 2 May 2026 12:41:41 +0100
From: Keith Busch <kbusch@kernel.org>
To: Matthew Wilcox <willy@infradead.org>
Cc: Haris Iqbal <haris.iqbal@ionos.com>, lsf-pc@lists.linux-foundation.org,
	linux-block@vger.kernel.org, Jia Li <jia.li@ionos.com>
Subject: Re: [Lsf-pc] [LSF/MM/BPF TOPIC] A block level, active-active
 replication solution
Message-ID: <afXi9crQyOnqJ4-1@kbusch-mbp>
References: <CAJpMwyiVqqbR3ni+URv0uPnE0Bgt_+d+-_+_t6E3wzfiUOT-cg@mail.gmail.com>
 <afUDV3ue45-shCNU@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <afUDV3ue45-shCNU@casper.infradead.org>

On Fri, May 01, 2026 at 08:47:35PM +0100, Matthew Wilcox wrote:
> On Tue, Feb 03, 2026 at 04:09:59PM +0100, Haris Iqbal via Lsf-pc wrote:
> > We are working on a pair of kernel modules which would offer a new
> > replication solution in the Linux kernel. It would be a block level,
> > active-active replication solution for RDMA transport.
> 
> Why is active-active a good idea?
> 
> With an active-passive solution, network traffic is directed to the
> active node.  Over time at some point we get close to saturating the
> link and performance drops.  At that point, human intervention will
> occur and the network link will be upgraded.
> 
> With an active-active solution, traffic goes to each node.  At smoe point
> each link will be about 75% utilised and we won't see any performance
> problems.  But then a node goes down and all of a sudden the remaining
> node is being hit with 150% of the link capacity.  There's no gradual
> degradation here; the whole solution just goes down.

Maybe I'm out of touch with reality, but I could swear active-passive
setups are often configured such that the passive node for one resource
is the active node for another. That would also suffer the same link
capacity issues you're describing.
