Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC18258203
	for <linux-block@vger.kernel.org>; Wed,  3 Apr 2024 19:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712172175; cv=none; b=t4mI+xtRWVPdiukUL1MPq9ON5sbm/UjR/TEzSUCI5kbSczgK1sWixL5I2MwFOpuA1j4t5/f/WuqWkZkpp7aFdVxAxRehsnd+CC4uJvMqSk5M9+AOQpzakMegccqFjsYcNEHVk2x+LG+IVDtaju+NNAAjj32BhXYVOyanOit83io=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712172175; c=relaxed/simple;
	bh=sUfH96JdVqlU90HFMw77izOcbcxgFTv5cD9g0Ts7NFQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bYHJnj7sjdN6URUFGPkn+cePhEbYpdtYCpIy0uCiR+DcsTiAz+jlmPaQqQJ2BzkWLkOKa+WEKfoNjnw80l840RZxAlVlXnVdhWriKdkWn+lfbfJPVxW6AV5eoCGwSen7s9yDNBb/n9HhgPGuvnJHfBFQlcKHktm2D3oYpz/FgZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=h7EJIinr; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="h7EJIinr"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=BkLRXqp90E2p5YmwO+vxgksMF4RSeTCofVlpX3z9hAY=; b=h7EJIinrOPDa1mguyqX0ocs1i6
	rPHEw/PhdrcDyv/n7ftw81tUjPsIujh8Abw1qGPNSgOSbcxoBv6uca9oHgzw42VlcQs9qqjpbbdph
	PGje/dC2UL7yev6u5aY1vNFzPx6Uf88lws8/nAE6i/MGRTSw9BzEsauLfBg7+H7QA+BG2D3vU4qkv
	Pk247Ytj23qrO9GCkEcDWCQem/SR0IrYOo9nZJNrmroM6PxtGAj1v3LD3btxG96vmWNcsPW1hHpdi
	TmA1AnD81r7IbYbRQ4u/U92DYWOcES7NFVwZqCIboK1JZ/IywS7HjkDVMgqddcyGyGtkitBbOXwKl
	U+OW66ww==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rs6C8-00000006HSt-4ACP;
	Wed, 03 Apr 2024 19:22:49 +0000
Date: Wed, 3 Apr 2024 20:22:48 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Christian Brauner <brauner@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Jan Kara <jack@suse.cz>,
	Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: Re: [PATCH 1/2] block: handle BLK_OPEN_RESTRICT_WRITES correctly
Message-ID: <Zg2siH3Im5DXhAK7@casper.infradead.org>
References: <20240323-seide-erbrachten-5c60873fadc1@brauner>
 <20240323-zielbereich-mittragen-6fdf14876c3e@brauner>
 <ZgZJ54rW2JcWsYPA@casper.infradead.org>
 <20240329-erosion-zerreden-c65a45286fae@brauner>
 <20240403-notsituation-verpfiffen-606e13449a54@brauner>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240403-notsituation-verpfiffen-606e13449a54@brauner>

On Wed, Apr 03, 2024 at 08:04:16AM +0200, Christian Brauner wrote:
> Willy, can you still reproduce this? I've been delaying the pull request
> to give you time to verify this but I would really like to send it
> before Friday. So it'd be really great if you could get back to me on
> this.

Looks like the latest version fixed it.  Just built & booted next-20240403
with no patches and it works fine.  Thanks for fixing.  (I took a few
days off over Easter, so didn't look at this before now)
