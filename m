Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C1F419F438
	for <linux-block@vger.kernel.org>; Thu,  3 Oct 2024 13:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727962721; cv=none; b=Xp1pGHagr0EP+C3fKM7fyx8qFEbkyhJwCqcBI4O9xDGEn+T0w+SBrKMaYbvN5PCZkFjEbSzbhBuf0pgMRoSYseEqMxM4/1vwA6QnoA063aaDP0MaRdKTL3w6MTY2lDoRVOyK8v8bMY9T70/70N+VNmnGsZNVKbOHo5gQ077A75s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727962721; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N9V4DnJjKyjj40K68yRdcxL34Wt89t1Ny8ewupmT/f56b507+BfZnbH6irvNI6GH7Nm+SeSJZgB2nP8oyaMTX4ZRbE7SCvrVQpniBx33543NxDPdE8IA5tSrR4kMryEOpBIhpyVrI5PPX53xMB6LHoAhwt8JdQM7O/r2Rs7KwS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=XFP7QLqy; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="XFP7QLqy"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=XFP7QLqyXtfN/OosuYdcjW6q6r
	U4i4Eno+/4ZkdBq2kJJC311FcLRI30rrXD7Gp2exfO3FMGSOtsE1q/y1+szYKkDDEwCvS/Kvr+CeI
	lk7F89TzdYfFT+xig2RG7C/bSyoBEwidrA55j00rnArRm4y+qYJFjZAk1fNCrhbvdm6cEv8M8lr7Y
	DisV9rB/EPuTpEW7b0+ASbpsuUHu36iW+sXFsoSZGWSe+VuSXC7A1Pz4Y9Y+o7bkrLMLxpeNi5KUM
	81iLKGrWusZLCzmNYEmEdu/R+k1Wf4Pzng+xBueqGyWVWtw/r6GWmjVUG82f9O/WHA0foymK+sZ6/
	IRvgcnkw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1swM2R-00000009E62-3Rnm;
	Thu, 03 Oct 2024 13:38:39 +0000
Date: Thu, 3 Oct 2024 06:38:39 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org
Subject: Re: [PATCH 2/2] block: kill blk_do_io_stat() helper
Message-ID: <Zv6eX8Fze6gXKX3b@infradead.org>
References: <20241003133646.167231-1-axboe@kernel.dk>
 <20241003133646.167231-3-axboe@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241003133646.167231-3-axboe@kernel.dk>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

