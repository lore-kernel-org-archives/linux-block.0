Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4739C15E86
	for <linux-block@vger.kernel.org>; Fri, 10 May 2024 22:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715379852; cv=none; b=FDeDcJCP87o6O++8pocaCeI9uKrujLyaZu8R8O52nW7ENDRqvtKh/uNgB7lONISnMr9VKNXVrHR2ibmLFvfc6Es5m3zxpjRQ3hxwtP/7Eu1n0svNtFmKadJNRXA3C4SaTHDrpHk7TRbusXI7WHuzdpxY+4Xi+N82WtEoj8GATfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715379852; c=relaxed/simple;
	bh=cp2ot4ySX4yMCWZtnzrmx2O+0S2snCj5rZNy0uaAXyI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b1q47TTwnC/5g5lqGVpwACjANP9BXQ7yIVeStdXedI+XiEwQpLxiwyh24SOJ00Oaj2fKYDVdiQiapmYkvcefAE3J3/Y9uaJQoZ0QteGYcyZ+dzdk5bW+wnGazOg0/TEDYCXeedvkOtqH3ujj3e9y4bYIWoXIHn9JC/TRIcIL9QU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=FZX9429Y; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="FZX9429Y"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=e2CazBCTSgp1TUq9jpEmkZgMWYdjxt4eNofKqQj0BCk=; b=FZX9429YkWjp/wUG+nsLMnz/jv
	j+vjZd667ZnraKzIiTjENAUQXTGzjA/LURoGLW33SkrMRGvwUsthaw/qWgE70mWgPTVx5dwZ1Ri1e
	Lt7SxsXR2/rSeylWVFs0jvpvvVjJxr9eLe6d6ZHWMnlWYgWtOHFn/WLgk/ErB2LcbMiDEExgN8If5
	dIaIjai7GhxSPzAUvcfFWhNX0M/bIBj/j9DEd/K/S5VADTbe+m0fikplmMGkUmEce5kcdf7qxrg8b
	bN8e7gOzv7Q45YrBcTvvW+dIgkj/YOi0lmDPTxeJ9+LEFd65fy/aIiAB3UY5XxRYYE+KqWfjCjnlv
	B1MbFi2w==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s5Yes-000000043qU-2vi9;
	Fri, 10 May 2024 22:24:06 +0000
Date: Fri, 10 May 2024 23:24:06 +0100
From: Matthew Wilcox <willy@infradead.org>
To: hare@kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Pankaj Raghav <kernel@pankajraghav.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	linux-nvme@lists.infradead.org, linux-block@vger.kernel.org
Subject: Re: [PATCH 2/5] fs/mpage: avoid negative shift for large blocksize
Message-ID: <Zj6ehjm1iVcc_x2m@casper.infradead.org>
References: <20240510102906.51844-1-hare@kernel.org>
 <20240510102906.51844-3-hare@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240510102906.51844-3-hare@kernel.org>

On Fri, May 10, 2024 at 12:29:03PM +0200, hare@kernel.org wrote:
> -	block_in_file = (sector_t)folio->index << (PAGE_SHIFT - blkbits);
> +	block_in_file = (sector_t)(((loff_t)folio->index << PAGE_SHIFT) >> blkbits);

	block_in_file = folio_pos(folio) >> blkbits;

