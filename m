Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39EA3B664
	for <linux-block@vger.kernel.org>; Thu, 20 Mar 2025 06:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742450524; cv=none; b=XVYo7cbKQxIehkPmv8LDrLM5H/hHeSwnhFZ90eIP2VHygIrlV4HH0Qv7IgqvmkM3ZirUELMf1Fgk+9k7BVr4hRtscjlHAySJXr21VLBStVpmxgSTbUStujaT+nnxhhtNpa/mHceP4xnVJFawwvhP1jUxK1f6Lv/wHgq3qjFm0wI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742450524; c=relaxed/simple;
	bh=mswW+k81FxifnE2f1MoT4/5F3Vii3bGIjFRx8ZVlMcQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DKg/kK/cKF7I4EISdjw3L3HObkwzeMfqkwcwImhkuPfGObN+nhYmZGpVK05r7r++3O+jMW9Np0F6U38dPBYXjtcy3jHudabe1KGSP8dFoHqohQBH2zGhtItajUp6O4RSQ4Y9syfe9YSci4RRs01WsKi+KZsFfY2OBDkj6WLNQDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=a0HYpfvs; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="a0HYpfvs"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=mLq5T359eDl4MxJtcr++fdAEbQ1ODOs9MC4nmivHVL0=; b=a0HYpfvs/pCpZwVm1SeOFmDmqP
	87UpB+a2xrONeDz8t6hgXR6La701raHpbGh/6ejw71CPWXOqWt1TdWT6QAprvYLJCjaGHnrJM+Azs
	SIf6bg7VWA8TtGUa2Tqzzqbh03aekzsadciwkYgHwwMZrIReSP54+vwvr7Dcix8ovByBcW/MW8pom
	dQxkoFgMbaF492E/croo4tLAz2UCDyxEMqbkzN1A0a5JbG4+pmm4iFWyHFk91lmx/FtxOKxUlPlTA
	2O9ABCZtNetdRF0wCgwnJ/IKHxPFUVRP8GLhFccLbPiKPnVl7Tc2tuANqWox2iXv3PtzNWTl0yUxt
	gmSbKiqg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tv8yf-0000000BH5J-3j0v;
	Thu, 20 Mar 2025 06:02:01 +0000
Date: Wed, 19 Mar 2025 23:02:01 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Matthew Wilcox <willy@infradead.org>
Cc: Hannes Reinecke <hare@suse.de>, lsf-pc@lists.linuxfoundation.org,
	linux-mm@kvack.org,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [LSF/MM BPF Topic] Warming up to frozen pages
Message-ID: <Z9uvWXmKdphoQISk@infradead.org>
References: <2a2e5822-d8a6-4460-b92a-01d113e18ead@suse.de>
 <Z9mMyUK1sQjJ6faZ@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z9mMyUK1sQjJ6faZ@casper.infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Tue, Mar 18, 2025 at 03:10:01PM +0000, Matthew Wilcox wrote:
> My only concern is that we might not have anybody from networking to talk
> about their side of all this.  We need Dave Howells for this as one of
> the network filesystem people, he probably understands this fairly well.
> Anna might have some network stack knowledge too.  Maybe we can get some
> of the BPF people to join in; although their track looks very dense,
> so we'll have to try hard to find a time when there's a topic that the
> networking-BPF people aren't so interested in.

The problem isn't the network file systems, they'd do much better
by not having the network stack play silly refcount games.  This
needs the core networking folks to agree to this and then someone
to do the work, which might or might not reach deep down in all
the various network protocols supported.

