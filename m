Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0432816F909
	for <linux-block@vger.kernel.org>; Wed,  5 Jun 2024 21:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717622626; cv=none; b=ZzcWBWBA8/9FTafA9IQoavwxWfViFgP63o5GOkN6AwL4ufaTDdVMPDj94Fl5YrhAd00RI09KTPlGhB91dHUAI4c2WPZtFbLoiWsWBr8SkJcrgTzfwQHG2Fm6gF3sz0Zqsnl/CtEP31b2PJl+7xEgifNqEfwK8Dyt00kd9Jf58j8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717622626; c=relaxed/simple;
	bh=lI3dK5A0I/WVvIWtW/iXp2fK5mMudTlwVIJUdEogL7s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IFPxDZBn3BpLT4XpoLDzuzPIxSyXFUkBWaOKots4ZsDAZwV5ysrefMuuvAMBzKEZEjRXeNOgILRTjlycwgx8AwUQSFUGcrjsYnnioQEVAOt9qSPKWrYUwD+VQ0h1Y3IfkgT0pztMbyjwKRJpT2AW1gdSYBB+NroBi/100RTg41w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ArH0cJAY; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ArH0cJAY"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=NN5rQs7qFo1c/qLxBTsJcXtAYAbooWbhlqMzT5GtAS0=; b=ArH0cJAYURInDKayIKBFjUYeTU
	/FQv5Gxa7+SzWJl0jnXzUouY2o5ijh4UwdE/epdjo1k2i21ZWJtMQXVXaHURhquNeoX5+OjApHvvn
	ugkg4ZpWu6QLi8rrmwTpWuD0vn1ZavqVqUIP2bST7nz5hHWkawFzV1ZNvdH22csHrPyLaR4jujkhe
	400wil+2++P+bQvanTEoKyIC4Mbf+WJyg4j/3jsUy3UHPU5ObBf3xJoGEMSgKWB5WP2/uMTztE1vX
	yqEbTJMlakngvU+3wmQmQGXWNOJX9jI+M2DgXbWA1ZSCqcY4eenXZ6APh/g4Uhi+1BBRkuydrEu4t
	KY+SnrgQ==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sEy6f-00000004WNI-2kLO;
	Wed, 05 Jun 2024 21:23:41 +0000
Date: Wed, 5 Jun 2024 22:23:41 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Kundan Kumar <kundan.kumar@samsung.com>
Cc: axboe@kernel.dk, hch@lst.de, kbusch@kernel.org,
	linux-block@vger.kernel.org, joshi.k@samsung.com, mcgrof@kernel.org,
	anuj20.g@samsung.com, nj.shetty@samsung.com, c.gameti@samsung.com,
	gost.dev@samsung.com
Subject: Re: [PATCH v4 1/2] block: add folio awareness instead of looping
 through pages
Message-ID: <ZmDXXQCfHsvL-NPS@casper.infradead.org>
References: <20240605092455.20435-1-kundan.kumar@samsung.com>
 <CGME20240605093225epcas5p335664b9185c99a8fe1d661227d3f4f1a@epcas5p3.samsung.com>
 <20240605092455.20435-2-kundan.kumar@samsung.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240605092455.20435-2-kundan.kumar@samsung.com>

On Wed, Jun 05, 2024 at 02:54:54PM +0530, Kundan Kumar wrote:
> +			/*
> +			 * Check if pages are contiguous and belong to the
> +			 * same folio.
> +			 */

Oh, a useful comment here would be *why* we do this, not *what* we do.

			/*
			 * We might COW a single page in the middle of
			 * a large folio, so we have to check that all
			 * pages belong to the same folio.
			 */

for example.

> +			for (j = i + 1; j < i + num_pages; j++) {
> +				size_t next = min_t(size_t, PAGE_SIZE, bytes);
> +
> +				if (page_folio(pages[j]) != folio ||
> +				    pages[j] != pages[j - 1] + 1) {
> +					break;
> +				}
> +				contig_sz += next;
> +				bytes -= next;
> +			}
> +			num_pages = j - i;
> +			len = contig_sz;
> +		}
