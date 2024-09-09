Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35C9418C344
	for <linux-block@vger.kernel.org>; Mon,  9 Sep 2024 21:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725916708; cv=none; b=caUqKOf+jB7rDiZGj+CWv8dGn68ATURZNQepIcogBWsba3/Bonjy5kkM8Pzbhj/qAGHFfUSZ7lJsHRteo3So3pCpbDQeKPWpyzPo9eBqFd0kTvC3wzW47kqNcgyGZkjcElZ5AMJAoDoxI7PDFs5j4LJZRUxHq0PR0wQQy2GO/9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725916708; c=relaxed/simple;
	bh=Gc/YwiHHODlvggIsq2KBgaKqJiB4baQnROOVnTpxE7M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F87Q49yefLK7bs7juQ+EcyrcxEoXAhiPsTfKB91K3aYOz6iFzpg9RtD+CBimw4shnE+H2ltxnl2iiglq1Fs5DJ7jsnpNYWc98fVmmJZRXJffTVPjK2oQtN/CpE3gYWeT3ccEifMr6XkaRFJsAzIZPZQa8Rq2v1eazmm0inRf2G8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=jC6XMKun; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="jC6XMKun"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=TUHSRzSgUVf6tvEHutppKunpWzfJ5iVq2R9chUH2Ir8=; b=jC6XMKun6oz/m55xAOiTS7Oycj
	s2v0dLvoMEVptGovDUYOATX1bmt8SwgtPrPoyCIMKFLVlrUn1Mtfs3w1LSGc4aHUwpT7u4T+QDsei
	IxkSj8AQDQDfD3NtJNJOxUbMyGJsPijYPmHFPoTq2e6xB7lNqjWf3zs9Uqi+2dQ5i4HH7pAO/G0MQ
	WPyufzqTzuOsQaAX0kfyFYnurTz7ZVnr7RRwW6HKpoR2BsjM5ZTEAwNkNomKNNwEr8XABjBVlKGMm
	dq0v1liZft2gXSsS29FYtJXICV8C1a+R4M3z02YxecBMuSvinUNTpGk2cDNIxXKgLFyY3/Q1WeNYs
	6VMf2TFQ==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1snlmC-000000002gP-1Gz6;
	Mon, 09 Sep 2024 21:18:24 +0000
Date: Mon, 9 Sep 2024 22:18:24 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Kundan Kumar <kundan.kumar@samsung.com>
Cc: axboe@kernel.dk, hch@lst.de, kbusch@kernel.org,
	linux-block@vger.kernel.org, joshi.k@samsung.com, mcgrof@kernel.org,
	anuj20.g@samsung.com, nj.shetty@samsung.com, c.gameti@samsung.com,
	vishak.g@samsung.com, gost.dev@samsung.com
Subject: Re: [PATCH v9 3/4] mm: release number of pages of a folio
Message-ID: <Zt9mILDltr819jsg@casper.infradead.org>
References: <20240830075257.186834-1-kundan.kumar@samsung.com>
 <CGME20240830080056epcas5p40dc8e28fb3b0cc8314b2194d953191ef@epcas5p4.samsung.com>
 <20240830075257.186834-4-kundan.kumar@samsung.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240830075257.186834-4-kundan.kumar@samsung.com>

On Fri, Aug 30, 2024 at 01:22:56PM +0530, Kundan Kumar wrote:
> Add a new function unpin_user_folio() to put the refs of a folio by
> npages count.
> 
> The check for BIO_PAGE_PINNED flag is removed as it is already checked
> in bio_release_pages().
> 
> Signed-off-by: Kundan Kumar <kundan.kumar@samsung.com>
> Tested-by: Luis Chamberlain <mcgrof@kernel.org>

Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
