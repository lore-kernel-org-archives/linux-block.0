Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D836E3876D3
	for <linux-block@vger.kernel.org>; Tue, 10 Mar 2026 13:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773148826; cv=none; b=t8OZEmGFxWI3URTFxJDoC9YwNKVRO2gI+mrayWxXs9IesZ51Dg3EXa5E02FPM9PUmxGBUCJ4q2tpyEgNec26gf6mlkM6P3tAEQfD4CyFHyk79P1kGT/QZxHgGY2Yw819VjtQcp9ZMs4ZHYy2vp0aroLXwnOQslKCLLGx283djFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773148826; c=relaxed/simple;
	bh=tN0W9N3uDZq57PyC6qsd0jQfSLA2Jxp2HAPVsBO2If0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dhh+BAGL5DN70zK7Y4dpSpdYu8BqDogaQ+NPBVTQGOZE7qekDnQVR3YbM+dLR61S2sWCmpMgtX4ddPAllRMLC77ucNe1m6A/s8kR4cOIGoEU7bXqyiScx690/WfZDFFaDA56aPp3i08aCH8lWNXlMfpA67aTxhat6ZhcWHeXiYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=lCe/gKra; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="lCe/gKra"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=W+22HxNt7Q3LX5MfGmVOu2SOv4XYwyd95HXhECzcYUA=; b=lCe/gKraLgQYvcpgZLfMd1Mqgu
	e7R4KPA1S3CyU07/8Pp2iU5A/C3S7BfWRnfiCaR4qUc9Me3vb2BWQEqgwjrXur50nwbjfXKwNJIHi
	024Q4YEbiakTYJUa2O4TAL0G/N+UlBTbWKQZs+eNdq8DIU+aqUe2sBP/xeMo7GDtO77e9lETPSUpI
	U9T0E02UFmiqTP4MmNtl5VuAxUl7aLmMrG5U0SSoargXaoYu/pULFT/NfFBlLsXrxUU1Z9wC5YNOt
	HS55fqSQO0tNYVp1pwwIIe8f1yIjXD8ZCVjPftQiqNrRZeOfprdrIMa4knxMevUAcYzOigJSaHD37
	0iRlmCfw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vzx0b-00000009a1N-1hl4;
	Tue, 10 Mar 2026 13:20:25 +0000
Date: Tue, 10 Mar 2026 06:20:25 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Yi Zhang <yi.zhang@redhat.com>, Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] blk-cgroup: wait for blkcg cleanup before initializing
 new disk
Message-ID: <abAamVMoIHncU29q@infradead.org>
References: <20260309100906.1740351-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260309100906.1740351-1-ming.lei@redhat.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Mon, Mar 09, 2026 at 06:09:06PM +0800, Ming Lei wrote:
> +	if (READ_ONCE(q->root_blkg)) {
> +		/* 20s is a random timeout, disk_release() should be done well before */
> +		unsigned long end = jiffies + msecs_to_jiffies(20000);
> +
> +		while (READ_ONCE(q->root_blkg) &&
> +				time_before(jiffies, end))
> +			msleep(1);
> +		if (READ_ONCE(q->root_blkg))
> +			return -EEXIST;

Random sleeps are almost never a good idea.  If you don't want to waste
a waitqueue on this use wake_up_var/wait_on_var, but make it properly
wait for an event.

