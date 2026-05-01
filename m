Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52AAA3D16EC
	for <linux-block@vger.kernel.org>; Fri,  1 May 2026 19:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777664859; cv=none; b=jBkx0MeCMRPGLgeN5LFDgdzUPADXNlc8nuuIPfb3stfCAZXWzA2WtxQHgbW7SRLIQ26pXKbUgA2gpj84CPysBF0L8NlcNCdu1U/+1F5zW1fRHxMiCs+owrFCCnEjr7R2+7BjLybtUy8aJFCxykNI9R1F2KCqSHUPmCWd3SqP17U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777664859; c=relaxed/simple;
	bh=tTQxO1HFYqK2qYnCcDIbyhe18U+8nD8zRgYvECcGKNA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CM4L7de0XzO2uZjbGq0ohGNFn09cjwuD5WqXy4nlqtBc/d0lg0fcZIYZ8OcNdw37JMKvU+2/CBFMjPMS77ZhqKffejZLOUfeirOwez6U8lUW4OxJZ/apZDs2k2Q41Z5JLSRGQXOo4KZWnPptazrrnHepv02ycCiPZjdKoHWtASY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=uRAZUPir; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="uRAZUPir"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=GJ+oYQjemozvwpJlGqadgjG7lpeLN4I9Uzkg/dcZqmg=; b=uRAZUPire5BuHvjS4AaJDx39To
	DvXtIvSGEk3YT/ZoeHwMdzWRvjcnishSVw6/wHiQjTUBbNwR84SGUlr9RaX9CqAw8jhtzTZ/lpZat
	6h6iAz6FMOeP0D0P4RS0pmCASYgHTPNKQngMO5Y7LvK80FY05PGru28d8MZAqPpmFldWcmOHcL2+J
	HotuX2+V5sx2fPFS5xjpiAYtsIg6Q7Vbc0c+c4QUNY0cjlYGjjKgsxYKGZ4UAeZjV91PcESi9G3nI
	lybRmozIG7wlZSJl7oE6+0Yy48dckuwhjcGLhg/ezwreOQsVyV+lP9g40YKqQJdS/XvX/9BgVNJQC
	BmowYGkg==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wItpn-00000009Fkj-1HYP;
	Fri, 01 May 2026 19:47:35 +0000
Date: Fri, 1 May 2026 20:47:35 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Haris Iqbal <haris.iqbal@ionos.com>
Cc: lsf-pc@lists.linux-foundation.org, linux-block@vger.kernel.org,
	Jia Li <jia.li@ionos.com>
Subject: Re: [Lsf-pc] [LSF/MM/BPF TOPIC] A block level, active-active
 replication solution
Message-ID: <afUDV3ue45-shCNU@casper.infradead.org>
References: <CAJpMwyiVqqbR3ni+URv0uPnE0Bgt_+d+-_+_t6E3wzfiUOT-cg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJpMwyiVqqbR3ni+URv0uPnE0Bgt_+d+-_+_t6E3wzfiUOT-cg@mail.gmail.com>

On Tue, Feb 03, 2026 at 04:09:59PM +0100, Haris Iqbal via Lsf-pc wrote:
> We are working on a pair of kernel modules which would offer a new
> replication solution in the Linux kernel. It would be a block level,
> active-active replication solution for RDMA transport.

Why is active-active a good idea?

With an active-passive solution, network traffic is directed to the
active node.  Over time at some point we get close to saturating the
link and performance drops.  At that point, human intervention will
occur and the network link will be upgraded.

With an active-active solution, traffic goes to each node.  At smoe point
each link will be about 75% utilised and we won't see any performance
problems.  But then a node goes down and all of a sudden the remaining
node is being hit with 150% of the link capacity.  There's no gradual
degradation here; the whole solution just goes down.

Of course it doesn't have to be network capacity either; it could be CPU,
RAM or any other resource needed to service the requests.

Active-active is fragile and I would never recommend such a solution.
I won't be in your session, but I thought it worth raising this point.
