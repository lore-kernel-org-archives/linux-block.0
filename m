Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74DBB20EB
	for <linux-block@vger.kernel.org>; Tue, 17 Dec 2024 04:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734409452; cv=none; b=G8IPXZVSGoXYbOaO9G8+VPHu4nVGHGNCSdCllEx40CPtIrDjJ7JlOySHWwzwe8Oef7iar5VEO4UyWmMLjXNLw8a/2g/2XuqgOettTZ0cvxpKqrrUeAcR4hR15iZDh5IdHNHB0ItjrKOmlIDdve3K++H6dRTgVH9YVecsXKVGICE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734409452; c=relaxed/simple;
	bh=6Ald7/zGBae4ZH8H58TJzpn0LxsQ+dAL/fagPN1jyF0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T/3ck6DE191WiEyx9pUodlhJBWSJJZ9FRP6Mtu7EMq7t79ax7giYZ4tzU4VPPAWEwR+x1r8NEKbeXINE1rTVXe1QGOFdBUdXuggJ6rtYhyiD6ACiZqAXDQ2cc5fAP8/RQma6fDFBrFVev9oDJ8pd4vaV+dPLcy5NpJD5fg6Uu5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 44A8368BEB; Tue, 17 Dec 2024 05:24:07 +0100 (CET)
Date: Tue, 17 Dec 2024 05:24:07 +0100
From: Christoph Hellwig <hch@lst.de>
To: Bart Van Assche <bvanassche@acm.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>, Damien Le Moal <dlemoal@kernel.org>
Subject: Re: [PATCH 5/6] blk-zoned: Uninline functions that are not in the
 hot path
Message-ID: <20241217042407.GE15358@lst.de>
References: <20241216210244.2687662-1-bvanassche@acm.org> <20241216210244.2687662-6-bvanassche@acm.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241216210244.2687662-6-bvanassche@acm.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, Dec 16, 2024 at 01:02:43PM -0800, Bart Van Assche wrote:
> Apply the convention that is followed elsewhere in the block layer: only
> declare functions inline if these are in the hot path. This patch makes it
> easier to debug the code in blk-zoned.c with trace_printk(). trace_printk()
> only displays the function name correctly for functions that are not
> inlined.

The other convention is to mark them as inline if they are so tiny
that force inlinining is guaranteed to generate smaller code.
disk_need_zone_resources seems a pretty clear case of that, while for
the blk_zone_wplug_bio_io_error the forced inlining is indeed a bit
questionable.  I'm still not sure what the sudden urge to change it is?

