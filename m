Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18A0A43152;
	Wed,  4 Sep 2024 04:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725424175; cv=none; b=LMIpGYeyUdiDBnBQniLo692FQvBPEr0R7+9nEmu/lUyjvx1jJHRSc26QxTJRcIIYqlCQeYG4rS7GbSfP397Kmk75L7qNkpwJJBzjMrvgzvvozOpepsl0N43I/US9mc6b9KKEzMo0lN2F6hRdi0cTk+QhOT7GAT0lpzz2zuZihBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725424175; c=relaxed/simple;
	bh=Y8IXN1rN2RoNHDeeGDPC4uyggAqYskHFl46L+lSWZZM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SHHmXlg10m387s7pCbumR/7AWGUDJJaMbSd/1MeZHynIn16SM4SaIfP6nULlz88sD6s8UEDGJ4s1NwtrUfnM2zpJKm6bM29PpjTHdbQettXhKqGOE/BrOWsIWN7jJo2SPVRAgH+UjpYOqiVGHA6NsMS9tw1rbFg4MqBBwB7bsmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Xfldbzlh; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Xfldbzlh"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=BBc8Ka/vR8SFvHYVTELQXwp9sVABJ6GRH/edBy/xYJw=; b=XfldbzlhVwTQcy2y56lbSO/SZ2
	ku/6kecuHVgT33L6kVM8CaNM7t62Ycsq1Q+tbQkYjmTZ9OBqPDecadEcLHmrrZ+Hehosl2XFG8kZ0
	eYhE+axQCaqiwy8oiJbDwvtt1iuDQjKMJ8Zc8ip+fh/0elRzFgSdsidDSlgDK1+7VypWjeQoyeGf1
	IrNSlgNatfzHyCOldQwpOuotpheeIy66hO0tYtsNrLu+J+Y4CLhCkZyhyBFI0oDmlWw3Njom/Z3Jv
	nx+ZHwWJCZe3gKx09dG6cG4+SNgfu9OXFN1IQ97rPdCrGPQ3NSX3VCzYpHJfcY/fqlNu0Mfqfpvzz
	cI2455gA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1slhe7-00000002nJS-3YSH;
	Wed, 04 Sep 2024 04:29:31 +0000
Date: Tue, 3 Sep 2024 21:29:31 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: ZhangHui <zhanghui31@xiaomi.com>, bvanassche@acm.org,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] block: move non sync requests complete flow to softirq
Message-ID: <ZtfiK1xg2RVzkXW9@infradead.org>
References: <20240903115437.42307-1-zhanghui31@xiaomi.com>
 <dd859c1b-40d0-4a10-a6af-0d7fae28da41@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dd859c1b-40d0-4a10-a6af-0d7fae28da41@kernel.dk>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Tue, Sep 03, 2024 at 11:49:28AM -0600, Jens Axboe wrote:
> The elephant in the room here is why an 80M completion takes 100 msec?
> That seems... insane.
> 
> That aside, doing writes that big isn't great for latencies in general,
> even if they are orders of magnitude smaller (as they should be). Maybe
> this is solvable by just limiting the write size here.
> 
> But it really seems out of line for a write that size to take 100 msec
> to process.

pagecache state processing is quite inefficient, we had to limit
the number of them for XFS to avoid latency problems a while ago.
Note that moving to folios means you can process a lot more data
with the same number of completion iterations as well.  I'd suggest
the submitter looks into that for whatever file system they are using.

