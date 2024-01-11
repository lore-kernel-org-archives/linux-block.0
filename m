Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A72755C10
	for <linux-block@vger.kernel.org>; Thu, 11 Jan 2024 16:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="eEviE5OB"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=BIePZ4LAzxtKfk2TMXljNP2aP5Qrys5xrwdd2vbgQqs=; b=eEviE5OBDA1NyoiBiXEeiqE/cN
	uVpt9qDB/orn7KgEPevSqMFWfO7Sgnog9byk47M/lrLE0zKt0Kiqf6wLp0rQNCBh2XoeiwWR1Rz1R
	Z+k2dOAK4COyFiQtOWl4hxW6z9fB1Rg/uH8XHjTcLJja2eh7d6UQVNJlaf7sPybWHCsFaQzwEqD7k
	l3Jedy/w1jIsNRe0jBg1FplS8Be4jiac9uVrR/Ws24d4HWIgBtsiwwKmWMFLIvfdVwbiU57Pl6UgF
	w/Ptli2QNigdsQI60WnXFYw4yenwF3ByQMacOkQK4Tz2sArxOCg9lodjABCDuhi4UU2HBjglvWVch
	imXwpm0w==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
	id 1rNxky-000ZUl-36;
	Thu, 11 Jan 2024 16:18:12 +0000
Date: Thu, 11 Jan 2024 08:18:12 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: Christoph Hellwig <hch@infradead.org>, linux-block@vger.kernel.org,
	martin.petersen@oracle.com
Subject: Re: [PATCH 2/3] block/integrity: flag the queue if it has an
 integrity profile
Message-ID: <ZaAUxDwwyUS2yPq0@infradead.org>
References: <20240111160226.1936351-1-axboe@kernel.dk>
 <20240111160226.1936351-3-axboe@kernel.dk>
 <ZaASADP4js2Oboqx@infradead.org>
 <ebfb6dc2-79e6-46a8-9dd6-7adfae0603f0@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ebfb6dc2-79e6-46a8-9dd6-7adfae0603f0@kernel.dk>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Thu, Jan 11, 2024 at 09:16:42AM -0700, Jens Axboe wrote:
> Before we can check that, we have to load
> bio->bi_bdev->bd_disk->queue->integrity, and we have to call in to
> bio_integrity_prep() as well needlessly. We could do that in patch 3 and
> then we just need to load q->integrity->profile, and while queue_flags
> is certainly hot, it's probably not a huge deal to load that cacheline.
> I think if we do that, we stick integrity before limits.
> 
> I can make that change, and then we can drop the flag.

If this is good enough in your benchmarks I'd prefer that over adding
a redundant flag.

