Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B555E4C870D;
	Thu,  8 Jan 2026 13:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767880707; cv=none; b=Zpfpj0jaHvlNNWwI8nvojiKpFN6sB2rwrToWwBuyYyhxf+Bf7Yc9comZGWbi1VofAHXUy/ORF1h1dJeB5whwOPolmrz78P/AhD5y/eXsiOmTVK8DOaeQeZqVFSsWLFYucr41DSwSpX9tJpvkgu8M4KMBcPkEf9RosSVtEhRJEYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767880707; c=relaxed/simple;
	bh=mVDVp/XpkfFMLxjpzuhZbM9IvMM4Xol+e6l3g7M/PTw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cQ7ePCFbMMxwN0u26uq0GKhL9cc0tPPx/jseNLZukOsFnbgMB0vdIvjTfe4KM5ryJTJ+zrCzNl0S3UcrpGxyzc0tUzeK1qbSkgZ8gMvwK9h2EupuyWyNcxdfJ316gFVkanCk6oX8V6XNASOTXWzm1Za6/o6lihyOBVCV79YuAaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 0C63B6732A; Thu,  8 Jan 2026 14:58:22 +0100 (CET)
Date: Thu, 8 Jan 2026 14:58:21 +0100
From: Christoph Hellwig <hch@lst.de>
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] block: initialize auto integrity buffer opaque
Message-ID: <20260108135821.GA8886@lst.de>
References: <20260108090401.1091352-1-csander@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260108090401.1091352-1-csander@purestorage.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

The subject sounds a little weird.  From looking at the commit
message and the code change I'd expect it to be something like:

block: zero auto integrity buffer when not fully occupied by PI tuple

does that make sense?

> Switch the gfp_t variable to bool zero_buffer since it's only used to
> compute the zero_buffer argument to bio_integrity_alloc_buf().

Yeah, that also makes total sense now.  But maybe split it into a
separate cleanup patch to not detract from the bug fix?

