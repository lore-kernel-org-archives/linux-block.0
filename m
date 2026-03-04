Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A715F3B3C06;
	Wed,  4 Mar 2026 14:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772635432; cv=none; b=Lcm9Ho/VPzoz/sS6vtBkPvU61D55lTJqephw7MUnwmsmdAFY4AoTcbFjmhPzL9M2aRdiAU6eV7/RCU0czFExUV5+fPXdLqcz9EFhDtUhsY6hfaP+pYizKV2ruOtWF1RK9jLCSeGcKlvmEBKnzGefO8+fNipxunXYTnLe+ny2cIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772635432; c=relaxed/simple;
	bh=aifmAPotaeUEGgUuNKdbDqn1jJtLYUEr8f7yJpRTgtY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eKcHDg49RbEa8BCRiLyNqPgzNZlQ8DH0srG4BYI3pBnNt/sApkw/KDanD8FPYc/kbQBC9bSu1VTrGjt9iPP4fKwfWkk3HwEENMYmE14WHc5f8bYIpISSIGtt6fzHUSDZkvpLOJ3f42ZO/SCRSpqXOaKdX2HuaRwPjDm9SrXnFXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=QHFVEnKx; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="QHFVEnKx"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=VcVUA57Ia+lepH55XziYgvy59JWtfGIF7+/AtB87m8A=; b=QHFVEnKxSphuRim6nJ5AcGmLlb
	SpxJpXgu7dvFkORTjEhgF77N05uUuao6Rra0B84ofOFi1i8bu/4uzLEl5IkiZwzQu/9ofdXn1J1in
	aLc3I2JHcnuEJPz/VT1RalOGVmLzdMHtDRXF4E/t7uUWVv68SuS1jSUdZsTF6/pAMs2EGLTklrDdX
	0cQVe6MhQVryZ9jubR8qiVlyRsNslRlbXwAif1k0NhMGzk5Xvww929JdN9rceO2B1bYNK/AkE9LIg
	HMxA9APy0M2+f8KIFrEOUPV63hELOaPHETm6HuxcwFXf99rGfAXrlxn7UvlzBwwObL//MJvwK5Tdw
	F0RCYqDQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vxnS0-0000000HR2h-3jMC;
	Wed, 04 Mar 2026 14:43:48 +0000
Date: Wed, 4 Mar 2026 06:43:48 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@infradead.org>,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC] zram: sleepable async read bio completion
Message-ID: <aahFJM-8VhAjq_IT@infradead.org>
References: <brqb2utojkegjv3vz542y6fz5pnkxngknaofz6ll4tviy5ljpx@fjvdjtr3tzfv>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <brqb2utojkegjv3vz542y6fz5pnkxngknaofz6ll4tviy5ljpx@fjvdjtr3tzfv>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Wed, Mar 04, 2026 at 02:15:03PM +0900, Sergey Senozhatsky wrote:
> that async read back is not trivial anymore - zram needs to decompress
> the page upon bio completion.  The problem is that bio completion is
> called from atomic context, while zram decompression is sleepable.
> So at this point we have to deffer the decompression to a workqueue,
> which adds (painful) latency to the read path.  We clearly would like
> to avoid that workquque offloading.  What can we do about it?

Nothing.  bi_end_io is called from hard/softirq context usually.

