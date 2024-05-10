Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2017713D24E
	for <linux-block@vger.kernel.org>; Fri, 10 May 2024 22:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715380647; cv=none; b=tTMroCXDrXquSbFfdwzhqXXonkOY5X6DBcxOeCUNKOqbN3Px3DmcTFvwIgvV5uqWV2rvl1KcVd7k3J61/yFWI99qGw2DgTf1+cq7Wy1VsITwG1bUr2U37WMfKpVHsZ7ntX/MjphRoWt8lvj5xxecLnp240HKJ9tfdgMv/45GxIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715380647; c=relaxed/simple;
	bh=j9tbXPu+iWxql5fJNJjwJmvxGdTMBUOyXClpFryy9nU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AEHpbioC/NPCBb5sUK5DStLKkRYhltNUsSLWrqHAN8hi4UAUiyTY67pSqy5nn956Ew1wewG327orkfEJpdrL0rs5iNfeaFRa0ejP5LpZjUBw1EFfokXzQWbb8Lfp45wUD9yMbIq6hffavbh00Yh9EtZ9Cw1cZyQB2l8yyDDDeEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=F6lUujE/; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="F6lUujE/"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=re3VoZzU2TIsrtRvUJ4q0JjRlgL7V/zeHjoJu92vi5c=; b=F6lUujE/CS42DjAijXt0Zr+hpk
	7MfNwJU218yFYQowlW/s/whrVtcUK52nFpST/m+6Z/eMLIuQ9hyMTewcfKj3bL2J697DLrSXtnx9/
	2qF5V1ZpL0d7l7FTFq4sOLxSbHTiE/grDRb2aOVqyP537WOMP4f7ALoI7sIhvEzmDGv9wwWwxTSuT
	m5IEtUj/jaMiI/fAaq7mKTBw3MzOgUNNvXNG9zZmMhmyetUkkTR3BjQ+uHx2TKJo8fsSABi8mQ1Ej
	RRR+h0zzNamMwFMad2wxACTW/WW1vg7InVI07qAdhmjPIppD6uvMSxMw5R/1+20lifcyeZmPz/q69
	/cOCey8g==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s5Yri-000000045OH-4ANm;
	Fri, 10 May 2024 22:37:23 +0000
Date: Fri, 10 May 2024 23:37:22 +0100
From: Matthew Wilcox <willy@infradead.org>
To: hare@kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Pankaj Raghav <kernel@pankajraghav.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
	Pankaj Raghav <p.raghav@samsung.com>
Subject: Re: [PATCH 5/5] nvme: enable logical block size > PAGE_SIZE
Message-ID: <Zj6hotHEsOSL9h1K@casper.infradead.org>
References: <20240510102906.51844-1-hare@kernel.org>
 <20240510102906.51844-6-hare@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240510102906.51844-6-hare@kernel.org>

On Fri, May 10, 2024 at 12:29:06PM +0200, hare@kernel.org wrote:
> From: Pankaj Raghav <p.raghav@samsung.com>
> 
> Don't set the capacity to zero for when logical block size > PAGE_SIZE
> as the block device with iomap aops support allocating block cache with
> a minimum folio order.

It feels like this should be something the block layer does rather than
something an individual block driver does.  Is there similar code to
rip out of sd.c?  Or other block drivers?
