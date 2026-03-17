Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AFB533556B
	for <linux-block@vger.kernel.org>; Tue, 17 Mar 2026 14:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773756541; cv=none; b=JUPC5vXTMAkjPqNc4r29wTfcizAs3J4C7v1QBzD1OU8A+fM0XI4HlWkg4f1fqBAU/GHNEJZ8w3dMNtiwM+/pyixFB5FwLMdesttGPcF1t65ioX1XRwsg0vM+GdiPna4qhNsA18Pu3Pq4jFGCAK638vstA55gWu+AvnxW3fTh3pQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773756541; c=relaxed/simple;
	bh=4tYV9P67k2q8Bdncd/iah/yQ62UgA0VPcdb7kkoDEjc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b5Q7Xh9+N7S+UM6zjToaGCLmF3honX1fKAkRELnEXjyq0tUcFVxN7uXBR31Jkb40xFe1g1Bvv0JHLV8em537AGvZWh8xkXrJlLNi0sq8U/4IkNTEBrnzkQ4z3quw6xDZoDTZyvI4xL1W+vk5ghtGPYdZgSz7jn7A217GmUrnya4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 471F268BFE; Tue, 17 Mar 2026 15:08:57 +0100 (CET)
Date: Tue, 17 Mar 2026 15:08:56 +0100
From: Christoph Hellwig <hch@lst.de>
To: Bart Van Assche <bvanassche@acm.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>, Damien Le Moal <dlemoal@kernel.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Justin Sanders <justin@coraid.com>,
	Philipp Reisner <philipp.reisner@linbit.com>,
	Lars Ellenberg <lars.ellenberg@linbit.com>,
	Christoph =?iso-8859-1?Q?B=F6hmwalder?= <christoph.boehmwalder@linbit.com>,
	"Md. Haris Iqbal" <haris.iqbal@ionos.com>,
	Jack Wang <jinpu.wang@ionos.com>,
	Roger Pau =?iso-8859-1?Q?Monn=E9?= <roger.pau@citrix.com>,
	Minchan Kim <minchan@kernel.org>
Subject: Re: [PATCH v2 12/12] block: Enable lock context analysis for all
 block drivers
Message-ID: <20260317140856.GF2670@lst.de>
References: <20260316200901.4111651-1-bvanassche@acm.org> <20260316200901.4111651-14-bvanassche@acm.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260316200901.4111651-14-bvanassche@acm.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, Mar 16, 2026 at 01:08:49PM -0700, Bart Van Assche wrote:
> Now that all locking functions in block drivers have been annotated,
> enable lock context analysis for all block drivers.

Please group the enablement with the drivers that your convert on a
per-subdirectory basis.

