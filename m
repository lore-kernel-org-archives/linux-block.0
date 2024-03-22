Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAC93383
	for <linux-block@vger.kernel.org>; Fri, 22 Mar 2024 00:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711067509; cv=none; b=a7YKbeTkOY+TCFDHyPjR/xb163t6YLyHi5c9KRSVnyDDFbGk1cJgu/dCQSrpUXGuZMo9vmfMbYWXPXmsJEQVBBXfkRosLlm4WT2086bMvH5rO6TH0ftN04wJJBCIH4jvneK2kMBM8aDSgLL2gP9M9Ps7vOgVKe55+X9A2ItRJkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711067509; c=relaxed/simple;
	bh=9PH63nFUIq/57ewGTluRtlDJkAbEOUBlk70jxwjkggk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tKe9kfqKZZqXko3L5Z/nHXxf7P+O9ZQwTqZndMl60hjiFULallExjjPQssxsMhi03+3IfALBYTRnTdpQo8UfzmRgI/FTwqYkofE/HZIjSmEImVCZsMjAlIaalxORNUujZizZezagwdLl1MmKjaMg/p4HPOOJdZyU4leOANM85lM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=W8vfxg9/; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="W8vfxg9/"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Z9KExEvarTqwFybJG/uUm/gGhgkeHBZ9ThipJLUJgdQ=; b=W8vfxg9/c6tMGKRDDv/hO4VP4C
	4UNCNu7fUNupeGF6D0kTbHtARUrt0hT9yWN7aqSWyTZRxYr0pL2hdKm2iaUmKhZooMSj+RNsqH+Dm
	Fk+4gx6jPX5NmZILOVej6UWkiU11HKz/UbcdUK7FLWONRFl1PqMZp++ADspfteOD1diTq/AiccW5P
	R6ScfUfIAVHzyCMd1A1CVhyVMrox0WDMHKkAfk/oEdx/Or09R20pCBKGnFSe5B40YDrO/hmLMw3OX
	+ODBQuYnu1S2ssKzIKQ8xTZorqug1Y5SzDi24AhGxdeVei4r45BYBvBcneKUK1XTFadUwyoFwdHhT
	qHD7/MoQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rnSoz-00000005G5H-2Z1h;
	Fri, 22 Mar 2024 00:31:45 +0000
Date: Thu, 21 Mar 2024 17:31:45 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: Christoph Hellwig <hch@infradead.org>, Ming Lei <ming.lei@redhat.com>,
	linux-block@vger.kernel.org, Mikulas Patocka <mpatocka@redhat.com>,
	Mike Snitzer <snitzer@kernel.org>
Subject: Re: [PATCH] block: fail unaligned bio from submit_bio_noacct()
Message-ID: <ZfzRceN0-_ij6wcP@infradead.org>
References: <20240321131634.1009972-1-ming.lei@redhat.com>
 <979af2db-7482-4123-8a8b-e0354eb0bd45@kernel.dk>
 <ZfywBU9IRHGdqVqo@infradead.org>
 <1a0ac357-49e4-41fa-b0c3-f038ec995a00@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1a0ac357-49e4-41fa-b0c3-f038ec995a00@kernel.dk>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Thu, Mar 21, 2024 at 04:50:44PM -0600, Jens Axboe wrote:
> On 3/21/24 4:09 PM, Christoph Hellwig wrote:
> > On Thu, Mar 21, 2024 at 11:09:25AM -0600, Jens Axboe wrote:
> >> Where is this IO coming from? The normal block level dio has checks. And
> >> in fact they are expensive...
> > 
> > How is this expensive when we need the bio cache lines all the time
> > during I/O submission which follows instantly?
> 
> This part isn't expensive, it's the general dio checks that are which
> check memory alignment as well.

Well, the memory alignment has to walk over the whole iterator, so it
definitively is way more expensive.

