Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1E4426E146
	for <linux-block@vger.kernel.org>; Tue, 11 Nov 2025 15:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762875960; cv=none; b=HJWRub5PhEWAV/Aka5s4OL3LHLvjaEFLFGdz9Xs7V52VRKxqHjvkY7+86UKmZjJqgZGbdEpOlRO3olCLxdmFHCQUDkxxxlb4VScADOiz4H5nrEShHnIOHqcfrBrrsylUT5n5TuuGmF5nyB4Pxr6PszEYVGSS94HStzBWnhMGeXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762875960; c=relaxed/simple;
	bh=65IIfHx9n905I9XEdv3qUmzzmJCOLnHLhe/TM43czto=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hEjZ9OS/cUfd3xB+REMbVLz1/m52oh6iz7242uC5EM4+L7GijvOHP0eOLrMfwS9G8nFGpWdWWtppZfEUd/v+r8SOvIJXGl6oh/FdRlWRtGhEAbHqhiQI/wqL22a2DD11olG9CPlfvbwajDnAuqmnP5OogSQCB5SAYhMUkRznZFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=g1QYfQsy; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="g1QYfQsy"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=28A5mK1IkUpDAMg4NjTUhyZ7Ncj8WxM82D2zmDzwM7U=; b=g1QYfQsy1iv/MHBsKHIawSoC6+
	gayLrMKLy7CJSkXU6WLcYonZAkkoU0hGJqzOksSU01sBR5nNKPm2YIiXC6n4BOI9EM9GIQCk18piT
	Eq4AoVPT6Q15Hb6RAuPpbEk+DI6eYYUYyY+PM996C+2fpD5ndmrrvHQecoWfb0V3d4W94KG7V/Thw
	iU14Ip+ToG1gwoMTsEnlEjTBUd+ZzWIAB6/IWb1oa/m3qmtfHJR7YwIwGPoKte9ld1tqxZ3ArTs4w
	3lim6Jc3N1Os0RtyAgUa+RME5Okq6sNspiiU0oPpBNN52j7r/cU7OOcf3mQ9RE9X845R/UgZ28gG9
	dVr02lFQ==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vIqZ5-00000004VVe-3ja6;
	Tue, 11 Nov 2025 15:45:51 +0000
Date: Tue, 11 Nov 2025 15:45:51 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Keith Busch <kbusch@meta.com>
Cc: linux-block@vger.kernel.org, axboe@kernel.dk, hch@lst.de,
	yukuai@fnnas.com, Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH] block: fix merging data-less bios
Message-ID: <aRNaLwRtmLXvSfbe@casper.infradead.org>
References: <20251111140620.2606536-1-kbusch@meta.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251111140620.2606536-1-kbusch@meta.com>

On Tue, Nov 11, 2025 at 06:06:20AM -0800, Keith Busch wrote:
> From: Keith Busch <kbusch@kernel.org>
> 
> The data segment gaps the block layer tracks doesn't apply to bio's that
> don't have data. Skip calculating this to fix a NULL pointer access.
> 
> Fixes: 2f6b2565d43cdb5 ("block: accumulate memory segment gaps per bio")
> Reported-by: Matthew Wilcox <willy@infradead.org>
> Signed-off-by: Keith Busch <kbusch@kernel.org>

Thanks for the quick fix!

Tested-by: Matthew Wilcox (Oracle) <willy@infradead.org>
