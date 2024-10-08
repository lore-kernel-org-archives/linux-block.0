Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61B3E1DE88F;
	Tue,  8 Oct 2024 11:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728387209; cv=none; b=MFmxSyxG4bDX6llir7EGGEdDeHfm29k1LdjUu5AAYv7VGWgzLs+wgzS6aKE2HY0ZWuG83XldYRBabIRTe7ONqHCEWD7CA7G+lJtY+Hks0Xn7Lij6LmJfUUWVbXND2A4mlb/Sd58K9m668zJzrPudWpm6xgzxjgh/7kG86qjOkXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728387209; c=relaxed/simple;
	bh=umiJnaSgx5KeYV/NYoPOtX3HZdZvYwsTzuFtuBsn6Tk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JyF26t7Mh2+gpqlf+lwnjm8ZTLaEgCoo7wtMviBv60benqzMpJwQWsPRsePnxIbJaIVR+/+Zrb7tcjQzG2BzSICeongQdJtS5u7+0KJkK0WbjIdsUFQcJ0q28dU7OtJeuFivu83wi4ise2AWyiD546p83868wSQqLUxRXXDYqhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=aaxLXWkz; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="aaxLXWkz"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=OdwlxzeGhkCEHL52PNGpSB9t0Q+ESkxcv7YoMNWWIhk=; b=aaxLXWkzgvLW1U+zejH2Ilo4tT
	fl9W+BpYq0KXe2nc6sOih7YrDMz+2++T4X4Xy3plp2lzctiwVWpKj4Sr3svTgcSiDEyhHmRPno0rH
	QjVXyjXu5XectNZ4BQZbdSn+ZBUFLHaSjpEKyOWVmVp0OwSB+2qP4A+smdASH876GZY98tt+tDv+F
	VBABE72PRfZ7eUVhgRrAOOH2fBa02nTpsU3MJjih3YvWjxGg2rG3mcZa79zATQwmI78Fut9gDUdbK
	3DYzVTYw4nK0qhlR2yCfM6gCmKw3kqCTpvC8KrsMtS8H661norBq+3z3tOI9Ml5C1qzjnTwkwiQ1A
	nl9rvt4g==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1sy8T1-00000005djB-1kIp;
	Tue, 08 Oct 2024 11:33:27 +0000
Date: Tue, 8 Oct 2024 04:33:27 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Bart Van Assche <bvanassche@acm.org>
Cc: Christoph Hellwig <hch@infradead.org>, Ming Lei <ming.lei@redhat.com>,
	linux-block@vger.kernel.org, virtualization@lists.linux.dev,
	linux-nvme@lists.infradead.org
Subject: Re: [Report] requests are submitted to hardware in reverse order
 from nvme/virtio-blk queue_rqs()
Message-ID: <ZwUYh9uJgETHAXl2@infradead.org>
References: <ZbD7ups50ryrlJ/G@fedora>
 <ZbO9T_R4lN_7WkwQ@infradead.org>
 <1e0ad5fd-2d90-4a0a-bb5c-0b270dd8ddd8@acm.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1e0ad5fd-2d90-4a0a-bb5c-0b270dd8ddd8@acm.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Mon, Oct 07, 2024 at 03:39:42PM -0700, Bart Van Assche wrote:
> For my patch series that supports pipelining for zoned writes, I need
> the submission order to be preserved. Jens mentioned two possible
> solutions:
> - Either keep the approach that requests on plug->mq_list are in reverse
>   order and reverse the request order just before submitting requests.
> - Or change plug->mq_list into a doubly linked list.
> 
> The second approach seems the most interesting to me. I'm concerned that
> with the first approach it will be difficult to preserve the request
> order if a subset of the requests on plug->mq_list are submitted, e.g.
> because a queue full condition is encountered by
> blk_mq_dispatch_plug_list().

Note that you don't really need a full doubly linked, you just need a
tail pointer in the plug, i.g. the same scheme as struct bio_list.

