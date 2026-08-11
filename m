Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3921A47AF42;
	Tue, 11 Aug 2026 21:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786482344; cv=none; b=irfSeysZOZNj56NyGosDOOTMy2Zz4E8ulncqptgcQxI0JsU7MLromKcILJvyeC4VjK8YCtFZy6TYc3N6609SbADhYCcaFgYv/ZhXx++JvWebUHALJtWGaEMUKdu35tqq4+1+wAhd9BwcBo1LhWmUDd+8L+XxxkkwXhxu5zPX8AQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786482344; c=relaxed/simple;
	bh=3LYoFWVAgcwajeKCUCn4YPDil8ZHAI6/bmkEKoFKZ1M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IZKDfPcCdDYsOKyQoJOzmgniLZhBxd8xnW0PLdCzG1ZsSyZH6oqC3gidw+i1Vh0pDH+i8aCoj8vgHVg5MjwXiFqrDXAZAQDvef+qCW9BuOWHaw+GrH7/qZa5rNdzTc8uZAYuAusM2/Fwez5hZ++Jf+8NgYY3okJf8KHrvNqdbZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dRTp5jGh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dRTp5jGh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECF541F000E9;
	Tue, 11 Aug 2026 21:05:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786482342;
	bh=PZSOao2joRqEJx20atrUPtXJqFpwjWr2KvKcNUSXZR8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=dRTp5jGhcZrq3PiQy+mU2PFhEvyD397sOWwAGjACMvNOEFdJOOFreM8hJb67HYvmj
	 n5HW4ngMZxjeSyOCzOHNDuUue4vqyT0jlDR+PHWbmNTdVJXj/l2ROK+XeLuKBOGDA0
	 tvr24D5P793D4lebhFWsnO/kQkThIbvj0DYdjnRYChObpXg43n4p0a1jfpOc3/C/Im
	 2Z2hMLe9GcwvNi3tlaF4Nm2en3gaZA/efCFyU7eZcTJDfKhNwJsGifVxdFFDq/c+qD
	 3VUHRNqnbyQDd7pNMln8npaQQCsbLKSSsY8kSj/3/juPDgdQhWyngfAxR6qSuyEfxs
	 DtAEGUTNBM9Tw==
Date: Tue, 11 Aug 2026 14:03:38 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-block@vger.kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
	Vlastimil Babka <vbabka@kernel.org>, Harry Yoo <harry@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Hao Li <hao.li@linux.dev>, Christoph Lameter <cl@gentwo.org>,
	David Rientjes <rientjes@google.com>,
	Roman Gushchin <roman.gushchin@linux.dev>
Subject: Re: [PATCH 2/3] mm: support fallible mempool_alloc_bulk()
Message-ID: <20260811210338.GB1905@sol>
References: <20260806221031.79050-1-ebiggers@kernel.org>
 <20260806221031.79050-3-ebiggers@kernel.org>
 <ann1i5VjTmgChjs7@infradead.org>
 <20260810161404.GA1930@sol>
 <anoIiy0V-m-05yZc@infradead.org>
 <20260810182215.GA270444@google.com>
 <anuCcb-Cma6JOAb0@infradead.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <anuCcb-Cma6JOAb0@infradead.org>

On Tue, Aug 11, 2026 at 01:13:37PM -0700, Christoph Hellwig wrote:
> What is actually efficient is do skip the mempool entirely from the
> original submission context and do a non-mempool GFP_NOIO allocation,
> and only in the extremely unlikely case that this fails fall back to
> the rescruer thread.

It definitely is *not* more efficient to fall back to a kworker for a
small task (removing elements from a mempool that has them available)
that could just be done synchronously.  Scheduling overhead is a huge
problem for kernel features doing I/O pre or post-processing.  The idea
that scheduling a kworker is lightweight compared to the actual I/O is
quite outdated.

Sure, this case triggers only when the regular allocations fail anyway.
So it shouldn't be a big deal, and I'll send a patch that implements it
the less efficient way that you prefer.  But it's a little unfortunate
that you're not going to allow it to be implemented properly.

- Eric
