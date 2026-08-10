Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EC933D7D8E;
	Mon, 10 Aug 2026 16:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786378568; cv=none; b=tr0P3qWhW6ZLrQnscdPZEFZtvGIeq4CXFiD6T7TPelYtpO+951UOLqJ3Ajtth+ON6oiXNLeK8qmeKcXeg/k0E81PAMQuoBqgJU9wze5H+CVIrYpqNVwUv+b6Fj6lNpyI1+Pw7S41JIy6vFWH5L873pDAETP/UqWSS/vCyY15Vek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786378568; c=relaxed/simple;
	bh=6YgOh4T1ngsn6Wkr+zwOdAFXM78a5rt+eJRtMTIu7YM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rpSJvkeaqrQD3P6mjUQmEz6cUXsTANAWc/T0tc6hndtwPAcEf5QuQ7UU7paM0RPUyPde3Fz3GwpUy0ETEba3APjJ68cdYvsI11kXSqtwxDbzPYH5YzH7wweiQ+cDuK0vsWQXLeu/sXc8eYXG8c6kK+ZQl04AyMXW7U25BlZw4EM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S9NHwTND; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S9NHwTND"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0D851F000E9;
	Mon, 10 Aug 2026 16:16:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786378567;
	bh=BlVAueKovJSaHcWrWN4BTIc7QYuuIT53QjtjPZuWPck=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=S9NHwTNDd9FQ7nrl98XA7oP4Xhhu9sW1p80y37Wvsam2MFSlFDytGjYX3OIkStyo7
	 p/eIxc7hR5jr2cbZSwWmhxbgkjBzYLTO6LvWXTJbV7+snMR67wQ0U1HNS9oFJ32wjw
	 7sU+MOjodVdh2R0vtbjB/aIIOtnk91e8foUNXT4fOlRLv4wg8Ys3wLl485NPfz+0wU
	 Rd7Qb0/MG6//xCyA6jZeM8iCaSWF61OaxIfh64qEzZCouvk9Zx9765Icn/gjxsFDSv
	 1MdwCH+mN0HGa1n0dOoAExjIEb2LBKn48i4fdPQc4BE80KpoCJxc/f8pqA6DlHlBrH
	 etCJDghhLcyTw==
Date: Mon, 10 Aug 2026 09:14:04 -0700
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
Message-ID: <20260810161404.GA1930@sol>
References: <20260806221031.79050-1-ebiggers@kernel.org>
 <20260806221031.79050-3-ebiggers@kernel.org>
 <ann1i5VjTmgChjs7@infradead.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ann1i5VjTmgChjs7@infradead.org>

On Mon, Aug 10, 2026 at 09:00:11AM -0700, Christoph Hellwig wrote:
> On Thu, Aug 06, 2026 at 03:10:30PM -0700, Eric Biggers wrote:
> > To fix a deadlock, blk-crypto-fallback needs to be able to make fallible
> > mempool_alloc_bulk() allocations.
> 
> It doesn't.  fallible mempool allocations are a concept that doesn't
> make much sense.  Please just go straight to the backing page allocator
> instead for callers that do not need the mempool guarantees.

It does make sense.  When alloc_pages_bulk() doesn't completely succeed,
there still might be pages available in the mempool.
blk_crypto_alloc_enc_bio() should try to take them before falling back
to scheduling the rescuer kworker.  The rescuer encounters scheduling
overhead and is single-threaded, so it's slow and should be used only
when absolutely necessary.

- Eric
