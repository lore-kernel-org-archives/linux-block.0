Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A26C31EEE6
	for <linux-block@vger.kernel.org>; Wed, 29 Jan 2025 06:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738130589; cv=none; b=D9N7Otab4aHuaAIw8P4CGGjJZA9ccM6/9v43zgCgeb0tvdsZbAW9x4PjKeZdTFWfmsPdipFX2u4hJq2ecKicRO7ScRK8j++bZA5mw/IaHJvf5jkr9KNDFU+CY107wbOhstK7TQ+Y6L1/9jhhH6dG2w7ruWmj8hp8WRmRvyr5MGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738130589; c=relaxed/simple;
	bh=6Bn92NSr4CMCPxUwU0F8vv3bKvTpSeWMgOZcLQn5kAI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VCgbzU5Cq2KB1m1QOQGO0DL+Vi8EBjZ1/56ShhJJg6LlJ8YpHj8IYqebt+SsqPHiYHDCvWeaGiQkaY+nLmsBMtuvKjjtXE/6qbSepeVUh5Pet4Dug3U7bOuftVDwOsnQMhLeRMH/N6gcFv/WjEZhtKqQqvC4UkfpUdFdIGO6Cn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=mZ7y9Fk4; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="mZ7y9Fk4"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=hiq1uScUML6Rsu2S+zgxlNvLPyp4iGtnsMkJjdwAtNQ=; b=mZ7y9Fk4dGIXhI5NWhZA3+Aio+
	o3LrzoIz+L+Kp1Q6445Ua0/YG78zDtSGdZ4XWofQ+taJODq42y1iQuspFwKsyPnOUUvhIwvtCOjmP
	IDXE+sJtD+4fme0fDjZHGRGX+4aeNrL76R+os4ZtF+GfVnsbFh4SiGyxC8ssmJNyqqfFlR5hzRDPV
	TwGXwCP+8IDfms3STsUnfrsdN5CsCvpk0fS+akdoR/ju79FK+rGEZ0xyw8oL0S63rAG5Aney917RA
	bNeQegGWl6bVULcQFBwNXaLNbDYrE6nw3j2Yf5LK43/WqCjz0JUgXrc1qYUvglVYRFhy23G/fYZAw
	V8BkieFA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1td1AI-00000006Ngg-2eT6;
	Wed, 29 Jan 2025 06:03:06 +0000
Date: Tue, 28 Jan 2025 22:03:06 -0800
From: Christoph Hellwig <hch@infradead.org>
To: David Hildenbrand <david@redhat.com>
Cc: Christoph Hellwig <hch@infradead.org>,
	Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
	linux-block@vger.kernel.org, Muchun Song <muchun.song@linux.dev>,
	Jane Chu <jane.chu@oracle.com>
Subject: Re: Direct I/O performance problems with 1GB pages
Message-ID: <Z5nEmo3ggTuRu2yX@infradead.org>
References: <Z5WF9cA-RZKZ5lDN@casper.infradead.org>
 <Z5hxnRqbvi7KiXBW@infradead.org>
 <d2471b37-15bf-4d67-932c-7e25c226db79@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d2471b37-15bf-4d67-932c-7e25c226db79@redhat.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Tue, Jan 28, 2025 at 10:47:12AM +0100, David Hildenbrand wrote:
> Yes, I did that renaming as part of that series after the name was suggested
> during review. I got confused myself reading this report.
> 
> 	internal_get_user_pages_fast() -> gup_fast_fallback()
> 
> Was certainly an improvement. Naming is hard, we want to express "try fast,
> but fallback to slow if it fails".
> 
> Maybe "gup_fast_with_fallback" might be clearer, not sure.

gup_common?

