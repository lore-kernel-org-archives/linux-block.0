Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31A7E31ED68;
	Fri, 16 Oct 2026 01:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792113425; cv=none; b=oOPJ/Ul44WPZLDEeP+4sOTZVdQF9OUPISMeHUZS9U+I82QkUKoa89Algmak2IIBczN53N3PlFsRmLLEmfDaHqTbolT5qr0QPQ6FNwIC7CO3UHhbMakoyH+eDTQuwyCAzJdlI2wrkZpFyEJglHLKTTmA1terDfg+tWh+bHp4g1q8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792113425; c=relaxed/simple;
	bh=1scJFACnBmbNEsXwlYuaZrcm0794g6oM/QsOZNr+0as=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=RVIzoPiYWmzpj3453smrcHXIlf5acuf5bDpBTsjLvuPgqi66mFzBapav9TnAWzvjgz2iWkwTaHgaMz1ppnAu+vbLQhLklaDrZinpK44SIhcVcIJ6mcGj03DTN+mUvGNxBwA4clVMFGST4XulPMbMS1z2s5rAprvORh4hZtT6PRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=V0DqwKpX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="V0DqwKpX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53B241F000C4;
	Fri, 16 Oct 2026 01:17:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1792113423;
	bh=xIo6mzYdEAiiL/ZMVN+2Q/zC7idur198sCpxMY9k37s=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=V0DqwKpXdIDNPaBrCC3KXQ0VhclNpPzpp+5TTC64P5DJfKDDF6Ttwice1fN7heKk9
	 eXBsGcl314mei3NlZ8A4okdPPb2Cs7QOhlcFMARAXg7RLWgNv+jbwHL4iCauMJAFEa
	 RYmYJ8Y74519EH6xiwcTSkSeawiYdfD5wQI4C7Y8=
Date: Thu, 15 Oct 2026 18:17:02 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Daehyeon Ko <4ncienth@gmail.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jens Axboe <axboe@kernel.dk>,
 Keith Busch <kbusch@kernel.org>, Hannes Reinecke <hare@kernel.org>,
 linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] iov_iter: validate extracted segment for bvec
 alignment
Message-Id: <20261015181702.21329d323eb40d145a6d0c9d@linux-foundation.org>
In-Reply-To: <20261015061907.2713943-1-4ncienth@gmail.com>
References: <20261015061907.2713943-1-4ncienth@gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 15 Oct 2026 15:19:07 +0900 Daehyeon Ko <4ncienth@gmail.com> wrote:

> iov_iter_extract_bvecs() validates iter_iov_addr() and iter_iov_len()
> before iov_iter_extract_pages() selects the first nonempty segment and
> limits it by iter->count.  The checks can therefore cover a different range
> after a leading empty segment or iov_iter_truncate().
> 
> An unprivileged O_DIRECT preadv() reproduced the empty-segment case: an
> aligned empty segment followed by a misaligned one completed 4096 bytes
> instead of returning -EINVAL.  A truncated iterator has the same mismatch
> when its full segment length is aligned but its remaining count is not.
> 
> Bound the normal fast-path length by iter->count.  Keep
> first_iovec_segment() for leading empty segments so validation covers the
> remaining portion of the segment available for extraction.

Thanks.

I'd like to understand the worst-case userspace-visible runtime effects
of this bug.  As far as I understand, the existing bug can result in
misaligned DMA requests getting all the way down to the device driver,
yes?

If so, hopefully the driver and the hardware will handle this elegantly
(hah), but there are so many drivers and they aren't the best code
we've ever produced.

Your patch has cc:stable and I agree with that decision.  Jens?

