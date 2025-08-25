Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E64628137A
	for <linux-block@vger.kernel.org>; Mon, 25 Aug 2025 19:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756151413; cv=none; b=uSn1rjUgT8lt+vQb8vI7HbMaW1wfKUxF6WbmPo9+/nDEwpxe6dzkxRGqmvzbEsk0j7JfYHbWNUcWziqJXdKMRlBddImP8ttt0U958sd3qxG3IWHEoCfalUiiKEJbcVICzdCjj1/V0w3FKe4fuctHtYWg0Y33XW0uf5Kp1v/FV6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756151413; c=relaxed/simple;
	bh=gj1KwYBNA90PRcWI18MIPRqVXbd8BeZ96ly+qLHdH78=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=po2liyqe5kNtH1pAfCFA3aVX1fISlwxM0I/vkXThXNaF+h4fjaMTJncYgAAXBlw+DWvMV0yATAEZM2jVp+t94U24ebLBerRk9UR1bruq/wD25emPpDBjWjyjqXkexLelEY0po9vEGNL+D4zdDzrD+lovwQACY2u1wJpigNGOWp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=INbPibKq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="INbPibKq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 695E0C4CEED;
	Mon, 25 Aug 2025 19:50:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756151412;
	bh=gj1KwYBNA90PRcWI18MIPRqVXbd8BeZ96ly+qLHdH78=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=INbPibKq5Xj4VgFbrS6s/DR0tlAlWlR3vhnsVHmmnskstuXHsdERVnU3gvcHntogI
	 p8uAQIqXd+K5s4h5fuFH6ATb7JgTOerl32Hm8Vg+/b8DOKWJtjOc73lV2cXmYMKi73
	 Qg/NUq6M/CBqJRg4D5d3UfUcsBSu/HoVF0COm5DTR59Svkw1LucZ6ENUYDlLooNdg9
	 k2FH3cZbJssJdtsufeBl3+wD+sdjXPYUSVtq8pX25KhfYrES6NDCj/PVCHlRwsIXkn
	 0+6X/xfYKZqHWRMlAvKxvj2nfThmm/lTFi98QJW1FIVrPdYqZqccCkiIzxq9it5qgn
	 akdWqnCx9iArw==
Date: Mon, 25 Aug 2025 13:50:09 -0600
From: Keith Busch <kbusch@kernel.org>
To: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: Christoph Hellwig <hch@infradead.org>, Keith Busch <kbusch@meta.com>,
	axboe@kernel.dk, linux-block@vger.kernel.org, ming.lei@redhat.com
Subject: Re: [PATCH] block: rename min_segment_size
Message-ID: <aKy-cfmAckSnbrvG@kbusch-mbp>
References: <20250822171038.1847867-1-kbusch@meta.com>
 <aKwtMbB0LQGURNMF@infradead.org>
 <yq1h5xvqkij.fsf@ca-mkp.ca.oracle.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yq1h5xvqkij.fsf@ca-mkp.ca.oracle.com>

On Mon, Aug 25, 2025 at 03:18:43PM -0400, Martin K. Petersen wrote:
> 
> Christoph,
> 
> > But max_aligned_segment also feels wrong for that. It's not really the
> > maximum alignmnet, it is the fast path alignment. Maybe something like
> > fast_segment_granularity or nosplit_segment_granularity?
> 
> Maybe just segment_granularity to match the other granularities we have?

I'm not sure I like granularity for this limit. That sounds like it
defines segments to be sized to some multiple of that value, but it's
perfectly fine to use smaller segments.

The limit defines the largest aligned segment the block layer can know
for certain won't need to be split. This allows a short cut while
counting segments without checking against any other limits.

  max_aligned_unsplittable_segment_size

That's pretty verbose, but this limit is kind of unique in its purpose.
