Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46B111422DD;
	Wed, 12 Mar 2025 16:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741796473; cv=none; b=X+GiAEHnwJPfwU3yTJuJ2J8HIqeKD4vnVWkYROx9Q/XyL+TlK4nNMNBsxc4rr8PtlBGcWBq7v+WUJw+Eu4/mQ+W5Xcu4GbCMlkBa5g1HK3Bj68bn6RLJmf0Yr1sITNvUxoOxFKiyd0dsHz27l0h1YZPq92LuFGO6U19aSxPRJZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741796473; c=relaxed/simple;
	bh=Dc+zwomVFPomvxQGWavZde5MGx1opu1C/2LjqMLtCv0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VY7l5wE9dfWHLXMj9p7vZi/v0cmrRElFBcmyB7O3ZXBjYyq5hpfEO6eAdKCSifbrXEOfEqlKo6rL/tdPEa2QZhjCaQehvWGmLRu4+5bE1xjsRb+oaUds/T4zFwVreVPqJFw1Gs7FlcBk48X8WkBHHsVOaH6FEpVyG1ka9Rc861g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=RJUJj0Zs; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="RJUJj0Zs"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=mHKYNwmZLDPs2lstGBfQN00eNokieZO2KadeeVHtI9g=; b=RJUJj0ZsLjRFWboYON7273OO0w
	gd41QRXUGa62CJqAvq+YdyF3rVOKmBYMVZFz/vOt6ShuB/v/0Ayu7A5TJx72KJBNnuoS3BcgKesYx
	fmIhBcnNk+AgouJQ6tz5VieBDysBDoo+uNCv6aJ4P5AzN2RU7LAlKU3ucZI9pVedVCwz/r500fERv
	zmQoS7ZcFWQRdjKmNfWR62ExQJLFHhGxKe4fEQbhOGpuv1mfTeySgEV2VjY661SrKI9qfE5t5rC9A
	BUsoLmYtggTbwqMPgnpxCJ1rUhSuHUIKy0wNpG7ngvuOEto/7rUyUhSqToZT7Zo2ewAmkuzrYBw5h
	LXexPaFg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tsOpS-000000090vh-1ZX5;
	Wed, 12 Mar 2025 16:21:10 +0000
Date: Wed, 12 Mar 2025 09:21:10 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Suren Baghdasaryan <surenb@google.com>
Cc: Christoph Hellwig <hch@infradead.org>, Sooyong Suk <s.suk@samsung.com>,
	Jaewon Kim <jaewon31.kim@gmail.com>, viro@zeniv.linux.org.uk,
	linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
	linux-mm@kvack.org, spssyr@gmail.com, axboe@kernel.dk,
	linux-block@vger.kernel.org, dhavale@google.com
Subject: Re: [RFC PATCH] block, fs: use FOLL_LONGTERM as gup_flags for direct
 IO
Message-ID: <Z9G0dm3bPgnM3AMa@infradead.org>
References: <Z8m-vJ6mP1Sh2pt3@infradead.org>
 <CAJrd-UuLvOPLC2Xr=yOzZYvOw9k8qwbNa0r9oNjne31x8Pmnhw@mail.gmail.com>
 <848301db8f05$a1d79430$e586bc90$@samsung.com>
 <CAJuCfpHjV=nRmkAGrf-tyCxEEygZ0CuW-PRp+F_vHwFbfYS8dA@mail.gmail.com>
 <Z9Gld_s3XYic8-dG@infradead.org>
 <CAJuCfpGa43OQHG9BmnvxROX1AneCvkuLxFwM+TdxAdR1v9kWSg@mail.gmail.com>
 <Z9GnUaUD-iaFre_i@infradead.org>
 <CAJuCfpEpWQV8y1RKb3hH+-kxczTUvpvCBNNzGJufsAxpkhB4_A@mail.gmail.com>
 <Z9Gty3Ax-2RslqDX@infradead.org>
 <CAJuCfpHG9EWAC9p7hcOH6oPMWMMSDr91HDt7ZuX2M7=j6bxuGw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJuCfpHG9EWAC9p7hcOH6oPMWMMSDr91HDt7ZuX2M7=j6bxuGw@mail.gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Wed, Mar 12, 2025 at 09:06:02AM -0700, Suren Baghdasaryan wrote:
> > Any file or anonymous folio can be temporarily pinned for I/O and only
> > moved once that completes.  Direct I/O is one use case for that but there
> > are plenty others.  I'm not sure how you define "beforehand", but the
> > pinning is visible in the _pincount field.
> 
> Well, by "beforehand" I mean that when allocating for Direct I/O
> operation we know this memory will be pinned,

Direct I/O is performed on anonymous (or more rarely) file backed pages
that are allocated from the normal allocators.  Some callers might know
that they are eventually going to perform direct I/O on them, but most
won't as that information is a few layers removed from them or totally
hidden in libraries.

The same is true for other pin_user_pages operations.  If you want memory
that is easily available for CMA allocations it better not be given out
as anonymous memory, and probably also not as file backed memory.  Which
just leaves you with easily migratable kernel allocations, i.e. not much.
