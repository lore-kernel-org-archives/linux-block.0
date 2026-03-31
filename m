Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B35E5362156
	for <linux-block@vger.kernel.org>; Tue, 31 Mar 2026 07:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774941825; cv=none; b=SCcGka++wze2JLeCfRB0Kgr90JgdageZq25OdS4rlwpaJSZK3TN0QTvag97jJtTAYMMB3qBTFO3AaLCSANPh6DXMKohUP02V7R2ntIJDkFwejLU5nFM0D+vDxd13f1yvMHJ0ULv4AEPe7hVlmCBC3fnNPE976MkKoRDuEzFK7Co=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774941825; c=relaxed/simple;
	bh=S5MGcAplwPBdenJVaQOFQrkCx12JxcbCv4ZLkf1lIe0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Dkv8MuodmicMPxOSITtjRoB9LZXLPUjDSfqsHxzYmyl8w7P4+ltk+y5KecXXzbLrXPR+p5DcPA4CNJI1EmOmwHGswo1QMOgZLMueOjcFtl+xLRPI6CYOVKnuuEeRVubCnyJgdqwBijQY7GjwzQgMYB4tYvtfHaVL/stZSP2uwSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=If9ARQR+; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="If9ARQR+"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=8+Cn9Zs+wANnLplQQyLHmeNLRBUOFUncFZHUw9ImQbY=; b=If9ARQR+QCKWWCfgGHhQOi/0DY
	5sUrat6YehU/vLTjP7wrpjLnnN9wjcl57CrG9/WpzQlq9RaLMtVZLhbfJ9Q0755ASFTJ5bMluZSzy
	09ueVbI2Te0d7kiohWBtgkkzzcZZXSBAajIaHpfzELpbOy9lJ89dZm2COFS2JKnNggXV2X6CJaSZ5
	TCgxow6ryD3FZYhZT+5YtrQKTVIYcb2jbu01l4q1Ex8Uaj5CkTjgeMeYSKmfMAMURd8MK23YnuyC1
	ZlofoVixCi7BYXl7Ujtq+/tWH6GvfEmz/7szrMUqE21k0im+5gkbrFrTQZiB1S9AsgE43n/EbRVra
	g9lNivqA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w7TRv-0000000CTQx-0uGs;
	Tue, 31 Mar 2026 07:23:43 +0000
Date: Tue, 31 Mar 2026 00:23:43 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Daan De Meyer <daan.j.demeyer@gmail.com>
Cc: linux-block@vger.kernel.org, axboe@kernel.dk, brauner@kernel.org,
	Daan De Meyer <daan@amutable.com>
Subject: Re: [PATCH v2] loop: fix partition scan race between udev and
 loop_reread_partitions()
Message-ID: <act2f6C86rIHuwsC@infradead.org>
References: <20260330081819.652890-1-daan@amutable.com>
 <20260330110310.692144-1-daan@amutable.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260330110310.692144-1-daan@amutable.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Mon, Mar 30, 2026 at 11:03:10AM +0000, Daan De Meyer wrote:
> Fix this by clearing GD_NEED_PART_SCAN before sending the uevent when
> LO_FLAGS_PARTSCAN is set. Since loop_reread_partitions() will perform
> the authoritative partition scan, the lazy on-open scan triggered by
> GD_NEED_PART_SCAN is redundant. With the flag cleared, udev opening
> the device no longer triggers a scan in blkdev_get_whole(), and only
> the single explicit scan from loop_reread_partitions() runs.

Setting the flag and instantly clearing them seems like a bad idea.
So add a variant that doesn't set it instead, or audit the callers
for who even needs the flag set.  floppy doesn't because it doesn't
support partitions, and the other callers in loop also look
suspicious.

Also can you wire up a test for this in blktests?
