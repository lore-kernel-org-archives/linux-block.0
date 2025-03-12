Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EBD4156F5E;
	Wed, 12 Mar 2025 15:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741792165; cv=none; b=pdq4cRVhoCumZYrCBTNwaG9tXA7RtZpoLzOLBgh/c/WZChhSpMsvlszr5+XoNWNmZ+84XzCVvpc3z2IXuFr1Lm1ijy5A2zs4BgXDg1LWGQc+lpbuOPA7eiTONRSvCq0IPLpinRtFOfuMFcwS6Xy0p1xixx26upy+Wd40ZTpr+TA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741792165; c=relaxed/simple;
	bh=v+F7uvNiShi/lpOnpmp4ruCirlUBWTTArmGarxP0oRI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MyV4pHEgozIQhHA8IFiEW3fGL2QaS0+QONRFHPYwR4NeQAIuAODiPCcEzUNt6wNCJVM1ZsRToLZEnm904bWyp9vIuQ2w6Z9ZxF+zLlhtoESrX+xjIoLWkeQYg0ekVp2URAMCJabNT+PpRmV5gpPOwQTFuByYJBzNHZtu9JVSo3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=RPiamPKI; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="RPiamPKI"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=jCMKibseP4KFSn0ywhPyrWZOEKM611o1ZzvPtJMJlW8=; b=RPiamPKIDRtCu/NHULJqQaabpu
	bZl3BCeoXp1fgOmnUZ7V8Qj92YoTuw5JbZWLXq7kU1YX8oXoVZ59qSMpS3hVwOU09AY/uVrp8DXaB
	GGrzQRQAq9dW2aStt5cOjki/VZUzEmz3ZkOlmETuf6LnlBAaLXk+3hKCpeiDNqbJfxgp62eZraWIp
	b+kQ638CmwkdSlre8kzPANtz1pK2tfO00IWukGbToGtHJP4dPlRgZa9woBijz8QlMjP208CGvSAn9
	iO8rvjXnIq7P4KahTJH77b2CcpHsUYnnvp/OIx/NwHtfU12IL8dP+njjLfyNo0m+j2MnMVC62B9/V
	5BLL1rCA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tsNhu-00000008nLt-3CA3;
	Wed, 12 Mar 2025 15:09:18 +0000
Date: Wed, 12 Mar 2025 08:09:18 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Matthew Wilcox <willy@infradead.org>
Cc: Hannes Reinecke <hare@suse.de>, Vlastimil Babka <vbabka@suse.cz>,
	Hannes Reinecke <hare@suse.com>, Boris Pismenny <borisp@nvidia.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	linux-mm@kvack.org, Harry Yoo <harry.yoo@oracle.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: Networking people smell funny and make poor life choices
Message-ID: <Z9Gjnl5tfpY7xgea@infradead.org>
References: <Z8cm5bVJsbskj4kC@casper.infradead.org>
 <a4bbf5a7-c931-4e22-bb47-3783e4adcd23@suse.com>
 <Z8cv9VKka2KBnBKV@casper.infradead.org>
 <Z8dA8l1NR-xmFWyq@casper.infradead.org>
 <d9f4b78e-01d7-4d1d-8302-ed18d22754e4@suse.de>
 <27111897-0b36-4d8c-8be9-4f8bdbae88b7@suse.cz>
 <f53b1403-3afd-43ff-a784-bdd22e3d24f8@suse.com>
 <d6e65c4c-a575-4389-a801-2ba40e1d25e1@suse.cz>
 <7439cb2f-6a97-494b-aa10-e9bebb218b58@suse.de>
 <Z8iTzPRieLB7Ee-9@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z8iTzPRieLB7Ee-9@casper.infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Wed, Mar 05, 2025 at 06:11:24PM +0000, Matthew Wilcox wrote:
> Networking needs to follow block's lead and STOP GETTING REFCOUNTS ON
> PAGES.

The block layer never took references on pages.  The direct I/O helpers
that just happened to set in block/ did hold references and abused some
field in the bio for it (and still do for the pinning), but the reference
was (and the pin now is) owned by the submitter.

The block layer model has always been that the submitter needs to ensure
memory stays allocated until the I/O has completed.  Which IMHO is the
only sane model for dealing with memory lifetimes vs I/O, and something
networking absolutely should follow.

