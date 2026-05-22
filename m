Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FCC21E1E16
	for <linux-block@vger.kernel.org>; Fri, 22 May 2026 01:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779414294; cv=none; b=L2CLncbvID2bch2pU7loPqFmXGzmDWwQDj756Xmh+4g2lQxYgYBwPag9dDU9Gs0T58YUjZ+tP1oROXKmFWx8KwCbzfgwSN+fOM8yp+vbiH1sIu0FXtwSGU6l40aEJTiuX8LJWQkO/VsUVVXJaID0/XJQzFvvigWykD0Xn0T4N4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779414294; c=relaxed/simple;
	bh=2m5T6efYkKmpfVB9uSNzhTcIt5bZTT7qc9yXVbNo9NQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JnTRXBr9OSE2k+dgz/e7CJ0Z9ln2/E6FFtUoxObQtdLqVgGbVFPzv1+s69q06SFNcpGqd/mN4Ek0EXBDbwJ3qIO8rp7zVOnEeb3uJB4gUOHnHRtf3WqdygnTWXmJV2tfzpzuLSQW1BQGmz584OkJMjFLdptUS6ppfZRRIRfANMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YwfJFnS5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YwfJFnS5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F93E1F000E9;
	Fri, 22 May 2026 01:44:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779414292;
	bh=1ZYkm7+N2CWiRgm7ZE87xIbOLsXWrisPBaCjIdO3bic=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=YwfJFnS5Xqr+DAUZgx/82VU+LOksv8K6rAm5EVo6GQorWHBskmMLGTqecAYmffsxp
	 sSpZT6Dut+x1k2oyfq/22KLoQG+Qe6wHLPNqfwhEEY33gr9d8MApRdH74K82dvAcUO
	 omkg/9a0Rj+wboglINbfOsZRSkeSiL4ZfonF2gAVahPv0nlchunsHHkDI/1fLWxt+V
	 TquZv+JWxgqghV5G5xwlVSFdwFyJuYRupSKp8kgtBQNHcj0fzGuW9CJYJJxyTo2dFv
	 lhP+yGFFvty6lAMYu5tiraFjYpKf0T0m7P2jetliX0WETYP94vEiEF5MqjyV1dTd8n
	 vwZF8g8RYispw==
Date: Thu, 21 May 2026 19:44:50 -0600
From: Keith Busch <kbusch@kernel.org>
To: Ming Lei <tom.leiming@gmail.com>
Cc: Keith Busch <kbusch@meta.com>, axboe@kernel.dk, hch@lst.de,
	linux-block@vger.kernel.org
Subject: Re: [PATCHv3] blk-mq: pop cached request if it is usable
Message-ID: <ag-1EoopSdp0JZR5@kbusch-mbp>
References: <20260521190253.242065-1-kbusch@meta.com>
 <ag-WUymW2vwVyMJB@fedora>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ag-WUymW2vwVyMJB@fedora>

On Fri, May 22, 2026 at 07:33:39AM +0800, Ming Lei wrote:
> 
> BTW, as mentioned in v2, the request may be added back in case of merge,
> but seems not a big deal given blk_mq_free_plug_rqs() doesn't free requests
> in batch.

We could introduce a special goto label for the merge case to push it
back to the cached requests, but it's not clear that it's worth it. The
cached requests are preallocated to match what is about to be dispatched
(up to a limit), so if a merge happens, there may not be another
subsequent bio submissions to use it, so it would just get freed as an
unused request later anyway. And if we block on the split bio allocation
such that it frees the cached rq list, I think we've already lost the
optimization battle, so no need to complicate things.
