Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3477126BFF
	for <linux-block@vger.kernel.org>; Mon, 21 Apr 2025 12:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745238717; cv=none; b=Y8+6iMEBEybc/8NHYhuydvxlNeiTK3q0jg1s1uPdaUbLg55u25AJn/kNsOvA4JYUPWB5Gm7t9ppwjDMDBmO9xCviS0HwOBbVWWP3/LjrpU4lad/4UnjHGRTvEUwg/zINdq4nWdWy/x8x9l38UvpPGIc8kRUoVxv2dLnZs1LScGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745238717; c=relaxed/simple;
	bh=RnwnKj9fRyKKNIstgHlNV6X8lmn5TA+fmIuxFkFoXzk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mjgAWubLhBXX1fsMomIESQiQ5p6GvL/NoaweEPmKAnhUKbgfK27J8CE3K/40pDu4Fj/4/idk10MTWCTnZL02PfhaDeJsP/XiKcEV1q3sdXNTMtFRovMZm4888QkW4PJl7BBk1YtB6/NjzpDdaygQnfqCiMdKcChw8HnJ4wl1qe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 94EB968AFE; Mon, 21 Apr 2025 14:31:49 +0200 (CEST)
Date: Mon, 21 Apr 2025 14:31:49 +0200
From: Christoph Hellwig <hch@lst.de>
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Nilay Shroff <nilay@linux.ibm.com>,
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>,
	Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH V2 01/20] block: move blk_mq_add_queue_tag_set() after
 blk_mq_map_swqueue()
Message-ID: <20250421123149.GA24038@lst.de>
References: <20250418163708.442085-1-ming.lei@redhat.com> <20250418163708.442085-2-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250418163708.442085-2-ming.lei@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

Looks good (modulo the little commit log update):

Reviewed-by: Christoph Hellwig <hch@lst.de>

