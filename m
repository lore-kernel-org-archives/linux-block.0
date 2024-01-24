Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7447B17C64
	for <linux-block@vger.kernel.org>; Wed, 24 Jan 2024 09:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706088559; cv=none; b=jSpKtrYmvrvM4e4M90jLEerWfq5lHeMBY6UbxnRHqGjAQCnfWHlYavl+ADGhJ6hQ+Kg+/EV3W8RgvOFs80UnAIHhrVkpqhEyLHWJmDNH4v4Subfu1X+9iZ4TaRf7AOlzECKC546jsiiYnkmtBjqUWyesBbAVk9kr6AH9YwX9jYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706088559; c=relaxed/simple;
	bh=Y4wBsSQppKt2m5Q/N8NH3pssKUL/+ORqr8H2UnSa1wg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fI9OsJiESqBy517cIISjiVzENmAeqc3/Y9IZDN99h4boknd6Is9DMq1LhH/wK1YhUo4ZH/43pCBnPpoa/t+nlUU5M7VRbysHDEvzklf7WO6Swgq0lioowtSaI7dumx97W/WVt0EmliB31T85AniSuQVLzmwV/2XVGNlueqTapS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ykySItXN; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ykySItXN"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=gXZCnn9L6n1KJKT79rxWofcYFENwBh9lHzlMdxoIhOQ=; b=ykySItXNDW8CkGP6dKUyHl2Rge
	xcpvWVoiB5eu5JcC4bmhqDMNM4C2AX7t/3P7f09vnyiIO50dNcUTBegaLzgQ0XQN1H31OC8uJFfiz
	Y67K3rrVsgu9R2amaHinLoROu/QMcA8AEBDPItf4ufY4hKjrGAHN4Nr/fb9z218F/6Pk7plwUaCaR
	Wo/fbuGqYqMkLTXiosSszJ5wr6LDLWYH8wLvEHbUCYvfZ74Rct4I9Bf6dxKAuDnVqCZ5SnPQ7saMX
	ksyhTc+Tcmr6uu30zGwpFLtXdTsoHcRe47GYy3IbQjAj2QP0W5CmY+MZZDhwbr1ZWzpyw3TCS8Wow
	MINIl0iA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
	id 1rSZZN-002F56-2t;
	Wed, 24 Jan 2024 09:29:17 +0000
Date: Wed, 24 Jan 2024 01:29:17 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org
Subject: Re: [PATCH 5/6] block: shrink plug->{nr_ios, rq_count} to unsigned
 char
Message-ID: <ZbDYbVhKlqnf6Yk5@infradead.org>
References: <20240123173310.1966157-1-axboe@kernel.dk>
 <20240123173310.1966157-6-axboe@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240123173310.1966157-6-axboe@kernel.dk>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Tue, Jan 23, 2024 at 10:30:37AM -0700, Jens Axboe wrote:
> We never use more than 64 max in here, we can change them from unsigned
> short to just a byte. Add a BUILD_BUG_ON() check, in case the max plug
> count changes in the future.

Do we care about the size of this once per task structure?  byte-level
access tends to be quite a bit more expensive on various architectures.

