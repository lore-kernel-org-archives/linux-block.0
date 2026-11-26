Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=213.95.11.211
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795682074;
	b=ZAptPxeo5aOdAd3MENI2C60EX1HpPF08hTGlLUI5m9KqhQlLsozIvyLHOx6jsz8+1UnR
	 LxenKr1oR8pJzFmf6BXpbbdbGaq08RMXpPXChIBzBWckmAqC5bjW79RWfeMJa8LnTSIyC
	 A1F9a580dHwqqS+H+B9SbEbpv8hxmf+mTqnFyNk/22mg4hzzcK1JJiHt1Zh7T8OreOH8S
	 naAGCFRq9poM9fIQJvSpdjJgTfLbUSsUAIKnC7XHWtXAiVrF4uTK3GrCuGx7kVV1qMCce
	 XHYtVS6+g3QkfQ0fIDbUJSJOQml5ZFyrmXLmzsGB7Gmd/8x0+fE6YHQ/J8AV6f/8Uxw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795682074;
	h=DMARC-Filter:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:User-Agent;
	bh=32OnbdWrDIj2Ts2l8BoTGaqRee+Hqtkn11b3BapuxLw=;
	b=kh/jH3JF3IdM1NAZgdBVaKjwCunT+BZqVhY2JKtooSAcGgei+7EgW2fdB9lKmAv2Ea2R
	 pUEKZxWGhapfVJwN6AiRuxiVpG5RTMTvd+yrbBbscMrVl5VRsO1BMDxvNvLDuFhFNjyvV
	 enYG58gbsLBHsY0PQZIJz+gQElLf14cBQk/KVo/iSr+PJPLKut1bqa43BFRECCvL28A4v
	 aeXiMQ+J2xSWZKEdkRRmVekBaXd0Be2BENDb4XGYOvgHGXRduh/rp0SgTYWCCZJe3DWEr
	 ExqWPfTLulmG8VvnCayFwzQVlQ8GqU3VUBvPzoGYZvBZIWN0L00ucjRyMZu2ttidb8w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=lst.de;
	spf=pass smtp.mailfrom=lst.de;
	arc=none smtp.remote-ip=213.95.11.211
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D02D606A31C;
	Thu, 26 Nov 2026 08:34:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2D02D606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id F3CC968B05; Thu, 26 Nov 2026 09:34:21 +0100 (CET)
Date: Thu, 26 Nov 2026 09:34:21 +0100
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Haris Iqbal <haris.iqbal@linux.dev>, Christoph Hellwig <hch@lst.de>,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	Keith Busch <kbusch@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	linux-doc@vger.kernel.org
Subject: Re: [v4 0/3] block: delay support for error injection
Message-ID: <20261126083421.GA7403@lst.de>
References: <20261111215838.103356-1-haris.iqbal@linux.dev> <179501806989.17649.3138860274842922761.b4-ty@b4> <20261120164416.GA32719@lst.de> <edb8249a-7bc3-430e-bbb7-243e1881a0b8@linux.dev> <1cf30693-44c6-4761-9900-e36259082e4e@kernel.dk>
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1cf30693-44c6-4761-9900-e36259082e4e@kernel.dk>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Wed, Nov 25, 2026 at 06:49:59PM -0700, Jens Axboe wrote:
> > I can resend with the fix, or send just the fix to be patched above
> > this, since these are already picked. Let me know whats preferable.
> 
> Send a fix please, that should always be the default as otherwise
> I have to rebase the tree.

Unless it is at the end of the branch.  And looking at your tree, it
seems like you have queued this up at the end, but in the 7.4 branch.
Which I hadn't noticed before, and which seems wrong.  Not only is
this a brand new feature and we're at -rc4, it also makes it really
hard to get the tree in sync for other features pending for 7.5.
(which we plan to send after this lands).

> 
> -- 
> Jens Axboe
---end quoted text---
