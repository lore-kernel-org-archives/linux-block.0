Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77DCC2BE7C6;
	Tue, 18 Nov 2025 06:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763446103; cv=none; b=F4SQ5K8jjL/Nt2Iar01zPfu9ksBIXdEeNIJD6Fk8N6lNThiZcGuxSZjsDqz6Ju7E3YpLch9RZmWMB1sKUoJXGlJCOP1cvjrBLPIE/N+X4Z55sP7D0T8O3MjnQ8aUmB1Tm/bzvM+rHFAXUnU+DWo/IjypjkllSh4jOtTG5Zdvjtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763446103; c=relaxed/simple;
	bh=CbZx8YEwJUzclw/KytHLse5BJRxBQSukCWOajeKSEEg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rLXmUCU6c0yLxPqurEW+QpMwloaMmCtX1wbgYb9U7BvNtotfod2eWzXDAO0AaXLU5fUdlsWrlq3dLF2cYC/4ZGB/Pe6/5UKn803iOqitxIJjy2L9PFSI7kfzwnyrn2+GcEAxcsgIGXbqPnJ9fnzo/a80IsOBisSs+1J/ddZ3tjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=u9p1gI4n; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="u9p1gI4n"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=qcvfGe/4cnhfPgrsqDpQy3JpdSZFpjYH0wz/dFjI5qo=; b=u9p1gI4n1P8RyF2urYjdaBiX7i
	ZDkjaK22yGZwZRQXaji2iKpH/gJGR+9y4m5uVCM7Wfw9UtWRL4LD00X77veM+RpdhGrhGnGiRhW6T
	8dh0FRmVNum3RQ5CJ9hvJZveeaxw3+hHifQpduZr3Ucx3WQ+mAGoHRdAysWmLPuNTowamUGd/avQd
	IOd+Ml5HwSd2zB2mo8vR6uyzVwAYuK7e2oLZIxKcHwGtahj5dobUZ5pJN1fP9jCyqDpDtGKx9ZHy0
	7DXp/kqtnyrVJPBncAowC5+geCrhzf9CiJOiW0Awzzbb9h9gQ1ZsdhwWv4aLBtzloP/kK/DmPLrw8
	sp+koXsQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vLEt2-0000000HTEM-2R4D;
	Tue, 18 Nov 2025 06:08:20 +0000
Date: Mon, 17 Nov 2025 22:08:20 -0800
From: Christoph Hellwig <hch@infradead.org>
To: chengkaitao <pilgrimtao@gmail.com>
Cc: axboe@kernel.dk, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, Chengkaitao <chengkaitao@kylinos.cn>
Subject: Re: [PATCH v2] block/mq-deadline: Remove redundant hctx pointer
 dereferencing operation
Message-ID: <aRwNVAk1dnoJwYSZ@infradead.org>
References: <20251118012539.61711-1-pilgrimtao@gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251118012539.61711-1-pilgrimtao@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Tue, Nov 18, 2025 at 09:25:39AM +0800, chengkaitao wrote:
> From: Chengkaitao <chengkaitao@kylinos.cn>
> 
> The value of 'hctx->queue' is already stored in '*q' within
> dd_insert_requests, we can directly reuse the result instead of
> dereferencing hctx again in the dd_insert_request function. This
> patch removes the redundant operation and modifies the function's
> parameters accordingly. We can eliminate an LDR instruction.

But you pass additional parameters on the stack.  Aka you're causing
churn here with bogus arguments.

