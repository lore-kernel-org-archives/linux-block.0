Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A12310F5
	for <linux-block@vger.kernel.org>; Tue, 12 Dec 2023 19:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oPUESg5D"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46448C433C8;
	Tue, 12 Dec 2023 19:03:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702407788;
	bh=qH/v/1M8wo+9OLbslSyNrrJBgO8nuXco7gFA0qHpIIQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oPUESg5DBSj54xloAYmg9YAJ5Jr6/VNOwjFjH2WXz3aiwuJp4ech2CX0lDJ0w3NwE
	 FWJgvDdDLk98/zCdD188Z0bu9FVDnNydASbs5dnW8LDqZoO5yR5cT6JiawqC4iAsVG
	 9cAF1sWWA0yOAExGEFgQQ0z6RKbpXxACiUBqsbiFPAMWgnHiM71tbPZOvXkiFsmoUK
	 eGWksM6XCFjApx98oLRxbUCmGe43XfpcmZtvb3/zv84eEErZgVOgSSTE0OhA6T7Uoh
	 /LCn+pYgSaEcsnIRYxfPYnF3YkaQsQtyXmAQw0NqMmkzhNKIhYpJZLIwc7ECu6tkFi
	 pYUxt0FUvojfA==
Date: Tue, 12 Dec 2023 11:03:06 -0800
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Bart Van Assche <bvanassche@acm.org>,
	Damien Le Moal <dlemoal@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Subject: Re: [PATCH 3/3] block/mq-deadline: Disable I/O prioritization in
 certain cases
Message-ID: <ZXiual-UkUY4OWY2@google.com>
References: <177773fd-c8ed-4822-9344-3058e820ddf0@kernel.org>
 <20231212154140.GB20933@lst.de>
 <42054848-2e8d-4856-b404-c042a4365097@acm.org>
 <20231212171846.GA28682@lst.de>
 <686cc853-96e2-4aa4-8f68-fdcc5cdabbba@acm.org>
 <20231212174802.GA30659@lst.de>
 <5b7be2e9-3691-409d-abff-f1fbf04cef7d@acm.org>
 <20231212181304.GA32666@lst.de>
 <19cd459e-d79e-4ecd-8ec8-778be0066e84@acm.org>
 <20231212182613.GA1216@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231212182613.GA1216@lst.de>

On 12/12, Christoph Hellwig wrote:
> On Tue, Dec 12, 2023 at 10:19:31AM -0800, Bart Van Assche wrote:
> > "Fundamentally broken model" is your personal opinion. I don't know anyone
> > else than you who considers zoned writes as a broken model.
> 
> No Bart, it is not.  Talk to Damien, talk to Martin, to Jens.  Or just
> look at all the patches you're sending to the list that play a never
> ending hac-a-mole trying to bandaid over reordering that should be
> perfectly fine.  You're playing a long term losing game by trying to
> prevent reordering that you can't win.

As one of users of zoned devices, I disagree this is a broken model, but even
better than the zone append model. When considering the filesystem performance,
it is essential to place the data per file to get better bandwidth. And for
NAND-based storage, filesystem is the right place to deal with the more efficient
garbage collecion based on the known data locations. That's why all the flash
storage vendors adopted it in the JEDEC. Agreed that zone append is nice, but
IMO, it's not practical for production.
