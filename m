Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62C8B149C6F
	for <linux-block@vger.kernel.org>; Fri, 26 Jun 2026 04:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782449814; cv=none; b=urA+5s+EgwzkqdKK4E15fvPO8rKHLoWbQwiWFhCD5L42CCMz1xLsDAhaBIXKuOUjQ83LDNb8rfvavTG+KnvAjx8tWKq7XuhMOSrYfUhSWDiEUr/HGdmVILqGZjyLTTL6pwmUkEnMa3laJrCjW5RZM5NFgdnuZIQVbJ57LTIxsY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782449814; c=relaxed/simple;
	bh=9RR3ntnfEKY7km1IK+/Tv0gM6YK1R+Pz2fh2vZmyUbA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hRZGvPII0y40JQ4CVrk0mVTcMEI0ACKeVKB+Z0mUPri6mcpd4JC29/3Q6CgqUSQfM5Kbi5q9B6L0wVlCjo873hDWUa2AnJ7VbrHeJSPc6FjQveS8q3fM3kq03WuJiLzilum2gB6GmGyFujZnbOmQtN1+10c9yZvzdyubv9o+Jyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id E64F368B05; Fri, 26 Jun 2026 06:56:50 +0200 (CEST)
Date: Fri, 26 Jun 2026 06:56:50 +0200
From: Christoph Hellwig <hch@lst.de>
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: Christoph Hellwig <hch@lst.de>, linux-block@vger.kernel.org
Subject: Re: [PATCH blktests] block/044: basic block error injection sanity
 test
Message-ID: <20260626045650.GA8752@lst.de>
References: <20260622160808.1552568-1-hch@lst.de> <ajzJiWqsQc2EgR3I@shinmob> <20260625115422.GA18348@lst.de> <aj3_nKfmUFj67jX6@shinmob>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aj3_nKfmUFj67jX6@shinmob>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Fri, Jun 26, 2026 at 01:31:06PM +0900, Shin'ichiro Kawasaki wrote:
> > > Nit: Majority of the blktests test cases have GPL-3.0+. If you do not mind,
> > > I suggest GPL-3.0+.
> > 
> > Well a mix of licenses is obviously bad, although I hate the GPL 3 with
> > passion.
> 
> I see, I respoect author's choice.

Well, if the common bits are GPLv3+ we can't actually legally combine
them with test that have a pure GPLv2 license.  So I need at least
GPL-2.0+.

And we need to as a few authors to also fix this up for:

block/029
block/030
block/031
block/040
block/042
block/043
block/044


