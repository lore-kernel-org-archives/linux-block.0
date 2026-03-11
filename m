Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF38D3AEF57
	for <linux-block@vger.kernel.org>; Wed, 11 Mar 2026 09:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773221956; cv=none; b=VGCJNY9dbrH/HSy7xfEaSvL3SwPTR/HTiObSI2q0X+SDLPTYB8As8fay7Y8cUxFN9t2zqnNiwDJk2plzcYe8JtkbO585Pim9NxDuqzbsSEHUcxVwPMlex1VcTqpr3krOtz9nwf9RH9s9cv+Dza07FD8G7k0F8bWC/xxPC3xGBgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773221956; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pp0xAm2jwgkAWKRxAY7bF4ID8yBE8fkSMqEhVf/jLF7hefARSc3xf38xNHyOv8y9QhO7OIrI5jo4I7q/TtgUbh5mc4+NNp4wiV9BsTDt2Xu+xe8KXeFK96bvBQgbgT/8gKj7JX9+0vCSJrBk0/bHHTu4OBrjJiLN1gfCxwSoq/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=VT/tOstL; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="VT/tOstL"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=VT/tOstLeYMmsnRlXpWeRMzlta
	6Pi8idqK9/V/gnDkxgIrOzaCnNXw6MlXQcsYtWj5Zp9WUHXzDIU9HL9yKvppo1zs0oq9TT0B7JKBE
	Sm1ohhWiA4AtSZHjAurTyym/WDl+15pOGMacogd4F8EDGpbYNtvUMnGS/acFV1emMWbH8oGtUamod
	0vzWXc48WUXj/jZCiUuBasa6co3RkNXwCXx815tJCmHKdycz11ZBrx0BxV759B3tiWLBumTnoUdFk
	q/KFFThVgtMUs5nq4HfvsuJNB2QwjvdVFF+zsno0thgejhadKuexscj/NCaBtReqbil883t7Xk70H
	II9SAnqw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w0G25-0000000BIfl-0HGd;
	Wed, 11 Mar 2026 09:39:13 +0000
Date: Wed, 11 Mar 2026 02:39:13 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Yi Zhang <yi.zhang@redhat.com>
Subject: Re: [PATCH V2] blk-cgroup: wait for blkcg cleanup before
 initializing new disk
Message-ID: <abE4QXWTmL80Stz3@infradead.org>
References: <20260311032837.2368714-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260311032837.2368714-1-ming.lei@redhat.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

