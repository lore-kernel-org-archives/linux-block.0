Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D94843D1711
	for <linux-block@vger.kernel.org>; Mon, 25 May 2026 07:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779694549; cv=none; b=PDtj22tDnTd5EcFBXdEYcCu3K0nNVsjSg9qZuf5rtF1ors3prgbBKyR0iC1mxWMdXQYmMiFWDx+GLQcuuOsmH3BKpsCs6lKkmvqsWbOZ1RtbrGFL27OzLlfkGe4WiuGkZObwVdg8QXp+rdcIu8r8YDodHwtQEJkK6ZKhmd79IRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779694549; c=relaxed/simple;
	bh=x4Crvpr8+RBLI/bv0AFCKdYEQ2gZJ2aubKZQ5q06ZVc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gmbs6748G0VKSxDogV4zqtzv4JikakU7nytBxhAUSfS9p0pXWKUVz3a4Zg9z0gW7kZBX/owOBn76f5Df+3jF9aHKeKz2PNgNyGEN/TtXpZwsp1cleWl1wmi3SM18h/6URvx0qY7yAJEFLmY4lKXsGyZNymyV5cyobv5jrX+L9D0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 3E30668B05; Mon, 25 May 2026 09:35:44 +0200 (CEST)
Date: Mon, 25 May 2026 09:35:44 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@meta.com>
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
	axboe@kernel.dk, hch@lst.de, nilay@linux.ibm.com,
	Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH] block, nvme: export and use passthrough stats
Message-ID: <20260525073544.GB5305@lst.de>
References: <20260522151537.1509784-1-kbusch@meta.com> <20260525073219.GA5305@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260525073219.GA5305@lst.de>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, May 25, 2026 at 09:32:19AM +0200, Christoph Hellwig wrote:
> On Fri, May 22, 2026 at 08:15:37AM -0700, Keith Busch wrote:
> > From: Keith Busch <kbusch@kernel.org>
> > 
> > So stacking drivers can also report passthrough workloads through
> > iostat.
> 
> Except that this patch also wires it up in nvme.  So please split
> it and write proper commit messages for both parts.

.. and while we're at it - it actually is called from the lower nvme
drivers, just conditional on being a mpath request.  So this is
in many ways a bit weird, and the comments / commit logs should
probably explain it a bit.

