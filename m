Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6894579E0
	for <linux-block@vger.kernel.org>; Mon,  8 Apr 2024 05:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712555914; cv=none; b=NnvJLUq5cddJ4rcWmoGrKQY3F+TfSQPMx/WpqMMAtO7LFuU8hbdWXZZMkSgmywP7vdMD36fW1mBytNNYBLKfZB69FK3CmhdLC24isYlCtDimonWT9bwZTT3Jbk7SUA6gzX3F1bY+oeSSUfGXIiYDB4F9qBZLX9e5BVSOXX5ilW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712555914; c=relaxed/simple;
	bh=yn+a5a95Va1kVfIsnlQJki0hyJvV5PgEz6GTIxw6Bqc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lXu750v7gWgCOxw7LaY/7L5tW66GurWiS5FEwZaRGLptO2oAkWaxwjpJ72jMyAkvQzjmA41CU19zA6SueKUAcCjeRRNF93funutt0u5iRztWo6sfdCHu/nVweNEfZJerSds3KNDKDijByRnR/uAjAzwMPuY3n7KlkHgcqaBh8yk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=XahdWbTS; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="XahdWbTS"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=UXXxkcYNJ9HQ20krV2DrxDjIoqRY0zOvBJ/1LDEd2xw=; b=XahdWbTSa7T6ktPbzMUliayrNF
	J5ZrwXv+QcumnJs1VMneJTKOfct9kmAzdtWe1I7YtlioPwNrFSkSvlDEEQx3f+9dUfMMxn0E3pMIU
	1kVZYobWXZZmTeHHAFPVCgChF76oeVtrR9XzlJ6IMXoBsK1M0Tv4FluxjsN1TEj+6CgGY3oXM/x5o
	KhBRRG1G9IU3BhS40wbb0nbgPTd8jq+IchitnqkiVSwptQCoUTh57GlJngxw7CBtaVrRnKIAxj7Yc
	u8ty4qcq8b7LC2iFaJRp6TBaAXaQFnqesAbJYLrmbKn6DdX89F/8M1SNw/v2GUy8+Za+YV+YtZS+b
	Vm0dxeug==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rti1V-0000000ERzD-39y3;
	Mon, 08 Apr 2024 05:58:29 +0000
Date: Sun, 7 Apr 2024 22:58:29 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Yu Kuai <yukuai3@huawei.com>, Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] block: fix q->blkg_list corruption during disk rebind
Message-ID: <ZhOHhVlfgj7ngHjH@infradead.org>
References: <20240407125910.4053377-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240407125910.4053377-1-ming.lei@redhat.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Sun, Apr 07, 2024 at 08:59:10PM +0800, Ming Lei wrote:
> Multiple gendisk instances can allocated/added for single request queue
> in case of disk rebind. blkg may still stay in q->blkg_list when calling
> blkcg_init_disk() for rebind, then q->blkg_list becomes corrupted.
> 
> Fix the list corruption issue by:

The right fix is to move the blkgs to the gendisk as there is no use
for them on a request_queue without a gendisk.

