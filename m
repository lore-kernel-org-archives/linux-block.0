Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4911C3033DE
	for <linux-block@vger.kernel.org>; Thu,  8 Jan 2026 13:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767880116; cv=none; b=rNWm2IclbQZz+gNs5/OawdACB2ZfvDJIQE4BJ7ldM3koRlxVyhf+LOYLWZOyIsD41R192P7IRhYiQ2JDSd+cgJMnYTrdnzPOOLQYMf/OSI4bACKdTkdgHNpvRCb4UV6F8hC1+7qtLyPhqvC9DQvPTcooPQlfqv4GAyw/59uJ4tI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767880116; c=relaxed/simple;
	bh=q2gktZaI3iJ68ali07j63J50uSZdm6RWZIyWubdy33E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EHX/LDFilvC7SFCa7nCwSOfjlJ1acrPlR1y4zVjKubTbb+mXo5bbY8rcPRwWq2cLDWpMGb8kCrhBLwaBDrPu4VxWGz4bPBe98UH/QBkHW2sIvijLr3L8/mh7YzOxPhFO7UjjWloEnZSExRwPpxBPN1+2c2s2nzkX2nKUKNZ07YI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=FgMzYBXb; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="FgMzYBXb"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=p1sZS3m0lsESovdK/nVUcC9uG25QhRuYoiAvNbpXvm4=; b=FgMzYBXbn+a6ApaHjuElokETE/
	5OjC7EwnasWA45TjwvV9et5mVxnNABAA7o8j/0FpJn0DQgJoocD0yuxK5+8o5tk2YbL474KMrPj44
	EGSDJ5TBka50sqPXWOcBD5ScgDx6N8jnEaAtXQvyN0efU3nZSMSyO4X4hRuDPP6LwzHPjiolCxFfl
	fLM/zX7dm5+mycbjGbkfmpKKJN2tPUm5PO+9VfiQhRSM8iZHlmqsys826vnt9tdFpIP+d0fmjIyls
	xZvzPEO3BnFM+P1ohyLj+YF0V96dU86GCRZ0Cr/8QfvXUhogmg+nxw2bWh4ZApENwvx3zIpIOVmCp
	LPXX6Ykw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vdqNG-0000000HE6z-0dfN;
	Thu, 08 Jan 2026 13:48:26 +0000
Date: Thu, 8 Jan 2026 05:48:26 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Yang Xiuwei <yangxiuwei2025@163.com>
Cc: axboe@kernel.dk, linux-block@vger.kernel.org,
	Yang Xiuwei <yangxiuwei@kylinos.cn>
Subject: Re: [PATCH] block: remove redundant kill_bdev() call in
 set_blocksize()
Message-ID: <aV-1qjWsdCtsUjds@infradead.org>
References: <20260106024257.144974-1-yangxiuwei2025@163.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260106024257.144974-1-yangxiuwei2025@163.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Tue, Jan 06, 2026 at 10:42:57AM +0800, Yang Xiuwei wrote:
> From: Yang Xiuwei <yangxiuwei@kylinos.cn>
> 
> The second kill_bdev() call in set_blocksize() is redundant as the first
> call already clears all buffers and pagecache, and locks prevent new
> pagecache creation between the calls.

Indeed.  Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

