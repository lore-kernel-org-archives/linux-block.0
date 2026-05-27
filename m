Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EB0940DFA5
	for <linux-block@vger.kernel.org>; Wed, 27 May 2026 13:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779887703; cv=none; b=Hn4q76H/fW/bYQvLbqbhLC8J/BNz6e+UQDuqZTCxZgg+z0WBkn/L9gRpx9BGzPEXycoB+tCmrSe2cXDtwwvbkbQqjJqd6q/lP/b0Ijt5Ot1/ZqkOpAw1J1bZvgTYYn/DQoWdKW/NXfEntQBHXt9looGSIh1/2Z30ApLDkQZd5PQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779887703; c=relaxed/simple;
	bh=s1SVk2Z63sfG24tBMH4ci6kwepnIdTfGdXJj6luuxqw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e/jGbg2TYnc3nEwv7f1lxX033Br00LEi5eqDdyoOPtpwGWzdh1r0gfV8CXOo+rYxXKuyc3ZXYwRradPTHPMgyFc2NLnN3rqk+DjZVvmVZ5WolFjPt+DOwpjFyflTEdeQcotgDIWdv4Q8vUVyY+c1S3xXqL9Dw+0lWCx5FO7vXOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 8EE4468BEB; Wed, 27 May 2026 15:14:58 +0200 (CEST)
Date: Wed, 27 May 2026 15:14:58 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@meta.com>
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
	axboe@kernel.dk, hch@lst.de, nilay@linux.ibm.com,
	Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCHv2 1/2] block: export passthrough stats enabled
Message-ID: <20260527131458.GA10351@lst.de>
References: <20260526153921.2402015-1-kbusch@meta.com> <20260526153921.2402015-2-kbusch@meta.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260526153921.2402015-2-kbusch@meta.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

> +static inline bool blk_rq_passthrough_stats(struct request *req,
> +					    struct request_queue *q)

The kerneldoc requested last time would be really nice to have.
Also, now that this is a public API killing the q argument and
just using req->q would make the API easier to understand.

