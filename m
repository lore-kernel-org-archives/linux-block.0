Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F36C331A551;
	Tue, 25 Nov 2025 11:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764069156; cv=none; b=YlR94DD5TI5Yy+sJfDvpa0OOrpdQp/7mlOs0zVrDFfRMsBj1GKDX1a9r5wZd8v0/mMbhKk4F8D7cIV5rc91Inq4Z+bNdXJ1pZOCkm2NnkOqdlsL/x1DHSdypFPfwRIo28FTts2Aot9qzMDxK4z/nMlVhSLdR6Ie4tx+JDmLwo8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764069156; c=relaxed/simple;
	bh=iAErf39p3AX6eGxLSVNpmuvC45IONrSfDYRpaZQe9Hk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tjaT34J8vkD5In2aVgblKSukNF7B6PamOSTCC1mT5DgzgwiQzjvukZfvRvw//bwA6T7FVK+wtfIJ6D8wKI4ffzQwyDIaiOvo9irBglhu0bZTaJJ5vo1lJz8brIN7cwTezpXiz8ElBGBai8+evnwmgAcpGPBcNLtQdYfEhWxZGc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=beWpo/xB; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="beWpo/xB"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=zsYASuSdm6fiN8PfcizlrjHJIdi0d6jEuw1PppFhVdw=; b=beWpo/xBmw2m0IC0i7afNs6NNI
	wWd9Po4sk771KFnSBKYGDuiowi3mrZH+GNwFGhb2ssuGAnQk+KOCJ7ifEIqanDrsTNbfKmAaPeJ84
	P0WHkBaQjd2/UrfsWSO2FdST2IJInsSBzgKulxVmjZfhLAQ8d0whd9zwpHk2Ex6z0563mZ8bYx9H3
	sVvESW4vZb+LSU/xWRZJQj4icfYFL31et+8xRBxHCj6gJY06ozTsFiI6zwYPs2Z3wCivZRaVC+9hF
	9yGFJNAJTHuaKqzvP3GhqwryHQu0EXVFQWv1RgaNXVdvMoThaq4HGjf14kfrfZ2H8bxgX0+Swundy
	QPE/0ArA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vNqyF-0000000DC4k-3PuP;
	Tue, 25 Nov 2025 11:12:31 +0000
Date: Tue, 25 Nov 2025 03:12:31 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Huiwen He <hehuiwen@kylinos.cn>
Cc: Jens Axboe <axboe@kernel.dk>, Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH] blk-trace: Fix potential buffer overflow in
 blk_trace_setup()
Message-ID: <aSWPH51A8NvoD9cm@infradead.org>
References: <20251125082420.856030-1-hehuiwen@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251125082420.856030-1-hehuiwen@kylinos.cn>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Tue, Nov 25, 2025 at 04:24:20PM +0800, Huiwen He wrote:
> The legacy struct blk_user_trace_setup has a 32-byte name field,
> while buts2->name is a 64-byte buffer (BLKTRACE_BDEV_SIZE2).
> 
> Since commit 113cbd62824a ("blktrace: pass blk_user_trace2 to setup
> functions"), blk_trace_setup() copied buts2->name into buts->name
> using strcpy(). strcpy() performs no bounds checking on the destination
> buffer, which can overflow if the source string exceeds 31 characters.
> 
> Replace deprecated [1] strcpy() with strscpy() to ensure proper bounds
> checking and prevent potential buffer overflow.

At this point all this has been checked as part of the setup.  If you
hatr strcpy with passing, just doing a memcpy of BLKTRACE_BDEV_SIZE2
is the saner alternative.

