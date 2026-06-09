Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D258E2E3AF1;
	Tue,  9 Jun 2026 07:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780990731; cv=none; b=aA/KogzU3YpHbrFCFuvl1xt5jBBQXZks1/4fWySH3pwYEnszbbryb5fCtbB+0IFwC8m2drcf7lIwgGvTT2To3sDUSaJHSFaPIhc/u7iQqXnjra5uXojGrXjXEHHZd3ZVCy4vs6JXZqQT206k7X+tWOlU5wPlXCgymLrQdsy7QEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780990731; c=relaxed/simple;
	bh=dx/YWXaYtJNXgPc+DgbHhOFPqc5yX6IAKn3EOmU+ECE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kVUim+SwbRRV5SFSUZquJ35zeMcifNtl8nwFFDhkJNHIVeBBXDwDG8XV65Z6SjznYkPrhPFc7z4W3qy1muDI60SmqfBk0doyDAsBmotXFXqUT7sSSM800y8Yc20IiK2S0xiEOIYhC2i8NA8pmA40+VDSFV3JVDZDgqKQkATKipk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ZfbgS8bM; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ZfbgS8bM"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Transfer-Encoding
	:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=aClVatHCQA7pw1RtzcleqkIQlnRxUZuwBo71mpBZpjc=; b=ZfbgS8bMjSDA4HVfT4zcE/5udS
	+BQibK9IqDTc7eQOD2HGmwxwXp7gjaDUdQAnG6Jm4hKnLWld9cXoiqBx1NCO6EDUwsNwMtsk5Uzcr
	aCbKb7wN42IX+lCpAky9kzBkpOiGvxko05bObOtamyVvwZsErdA7u//2tgLnEMocGbpPSW/lcfXW0
	MXlPM5WPa6PpFvq23wxk11Gj6dQgfbJQBD+xzsq0htVO11bnX06wLlkuZd9ry/2ipOMg2eybpcaeW
	b2TyhDgcfRU+7rJ6o5ToPeKM0UX8+Dd9JI8rxHzv5wFRNW+oAioMDhr/FQr//p/c2OqKsr+VNREhL
	g4GZxKuQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wWr2t-00000004ykU-49vm;
	Tue, 09 Jun 2026 07:38:47 +0000
Date: Tue, 9 Jun 2026 00:38:47 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Steven Feng <steven@joint-cloud.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] block: optimize I/O merge hot path with unlikely() hints
Message-ID: <aifDBykDgb59AIRh@infradead.org>
References: <tencent_79B652BD0CC23E093F27914380F161E7E505@qq.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <tencent_79B652BD0CC23E093F27914380F161E7E505@qq.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Sat, Jun 06, 2026 at 10:42:18AM +0800, Steven Feng wrote:
> Remove redundant '== false' comparisons and add unlikely() branch
> prediction hints in block I/O merge path functions.
> 
> These functions (ll_new_hw_segment, ll_merge_requests_fn, and
> blk_rq_merge_ok) are executed on every I/O request merge attempt,
> making them critical hot paths. Data integrity check failures are
> rare events, so marking these conditions as unlikely() helps the
> CPU optimize the common case by improving branch prediction.

Umm, these are not failures.  Just conditions to not merge because
of this, and not merging, both because of these conditions and others,
it the most common case for most workloads.

With your patch the object file size of blk-merge.o increases slightly
 for me on x86_64:

   text	   data	    bss	    dec	    hex	filename
  12299	    577	      0	  12876	   324c	block/blk-merge.o.old
  12331	    577	      0	  12908	   326c	block/blk-merge.o

and looking at the assembly this is due to worse code generation
because it now splits different error returns.

What kind of optimization are you attempting and how did you measure
the results of this "optimizatіon"?
