Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D89C17BED0
	for <linux-block@vger.kernel.org>; Tue, 13 Jan 2026 16:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768322076; cv=none; b=gH/kfg6FGY2prc1CqSq5EwnpTh/sfl5BjdMyYNLw8a61A6eROoGeh7k/z7stdSkYsO1cqAquotpgV/q2rH3EQg5DrE/tM2Id31K9RGfc+gdb63uwP1093Eg1lQamHPEZGr1FfyCUKMnbq2vZG2vsSe//18UNQ/nVkw5wi8xMZVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768322076; c=relaxed/simple;
	bh=SR1ll+za/ItqGEEW7Gr9NxUxSz3pK8k678ErpIfAKi8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=clEY6dvofB7c2Yk/fF/eWAMlCkvzEBi6ulP70Q90NMAZVeqqxxRIfgHw3gl/vNO+Vez4cSMX0ZqOJWxYf4jlEI/715lWPYe9Ok4DvVnvxLRthnVA0RPSA+54utkuDKuBV8nNifibRQUi9PbGhjSLZ92RslCT/wiE6BvqTvHaRQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=G4mJ4ZxF; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="G4mJ4ZxF"
Date: Tue, 13 Jan 2026 11:34:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1768322062;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gOAMAdCQyAqdI6Qeoapp+TyKnQv5z0cYHCbTYrmHX1E=;
	b=G4mJ4ZxF2WfHTgs7+Cw9ZE6igHAKRjKOw7tHkQB4EquAjZAL4abzT6zs6WZcpPsa1sQzzR
	Kjb1GIORFJAafQIQvP3FRVKf18clYOkqS5JD749hzQ2ZwHOlXxIPIAIh5TLRYfOXFdDE9+
	h/DA87VwV/LcIAs5iiBcyHRd64oUXZc=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Christoph Hellwig <hch@infradead.org>
Cc: Coly Li <colyli@fnnas.com>, axboe@kernel.dk, 
	linux-block@vger.kernel.org, linux-bcache@vger.kernel.org, 
	Shida Zhang <zhangshida@kylinos.cn>
Subject: Re: [PATCH] Revert "bcache: fix improper use of bi_end_io"
Message-ID: <aWZyWJiOi9hZgtqo@moria.home.lan>
References: <20260113060940.46489-1-colyli@fnnas.com>
 <aWX9WmRrlaCRuOqy@infradead.org>
 <aWYCe-MJKFaS__vi@moria.home.lan>
 <aWYDnKOdpT6gwL5b@infradead.org>
 <aWYDySBBmQ01JQOk@moria.home.lan>
 <aWYJRsxQcLfEXJlu@infradead.org>
 <aWZwBZaVVBC0otPd@studio.local>
 <aWZyHz_eZWN-yQiD@infradead.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aWZyHz_eZWN-yQiD@infradead.org>
X-Migadu-Flow: FLOW_OUT

On Tue, Jan 13, 2026 at 08:26:07AM -0800, Christoph Hellwig wrote:
> On Wed, Jan 14, 2026 at 12:18:45AM +0800, Coly Li wrote:
> > Hi Christoph,
> > 
> > This cloned bio method looks good. Could you please post a formal patch?
> > Then I may replace the revert commit with your patch.
> 
> As usual with bcache I don't really know how to test it to confidently
> submit it.  Is there an official test suite I can run now.

Coly and I were just on a call discussing updating my old test suite. I
haven't used the bcache tests in > 10 years so they do need to be
updated, but the harness and related tooling is well supported both for
local development and has full CI.

https://evilpiepirate.org/git/ktest.git/tree/README.md
https://evilpiepirate.org/git/ktest.git/tree/tests/bcache/

There's fio verify testing in various modes, reboot tests - there was
fault injection when I was using it but the fault injection code never
got merged into mainline.

I wish I could do the updating myself, but I'm neck deep in my own code,
but as I was just telling Coly I'm always available on IRC to answer
questions - irc.oftc.net #bcache.
