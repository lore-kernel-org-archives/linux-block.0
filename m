Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB4742D0C63;
	Mon,  6 Jul 2026 09:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783331655; cv=none; b=Q6yXQ0lfj3TNaD3TX5cALPqe6cmdcIZO2pdROfYX/gjXKPe3U6NbKrOx7NcdysrWUOidKbxEnr3tYIibddmxLIZgt6IaoMUlLD3WWR+6aB10+gE9dCtPsR3xQ18DOkx8YdwPz4PLBYxsQ3vOLnnhFHS60tGNxot5h7bixcqK9KM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783331655; c=relaxed/simple;
	bh=88rZNE8H62mx4kkv9q3eZ1/Dp5y2P4DyFwj7L+eNNvQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SBsymRhFMU8MoSndrYCtYnCVEJV6EsA4GORd/2IvAil1wGI5NF+vFgHvHzrWkFp5p7cIrwvAoaOQ0rT+fw5VZ2x/oTcxYGNKOZMDqA2jyCyShSiMbAfTletuAQo+ZVKmbM+4/+W+Az8SABOSUwWOMTXHfIYtOlZGwI+IyLISfMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 7114168B05; Mon,  6 Jul 2026 11:54:07 +0200 (CEST)
Date: Mon, 6 Jul 2026 11:54:07 +0200
From: Christoph Hellwig <hch@lst.de>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, axboe@kernel.dk,
	linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-aio@kvack.org, linux-kernel@vger.kernel.org,
	io-uring@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH] block: split out a new blk_plug.h helper
Message-ID: <20260706095407.GA4420@lst.de>
References: <20260706041125.642097-1-hch@lst.de> <f389a101-2af1-4b18-a74b-031e6c1899bd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f389a101-2af1-4b18-a74b-031e6c1899bd@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, Jul 06, 2026 at 04:04:48PM +0900, Damien Le Moal wrote:
> > +#include <linux/sched.h>
> 
> struct blk_plug_cb has a list_head. So maybe also add
> 
> #include <linux/types.h>
> 
> ?

That already gets pulled in.

> > +
> > +struct blk_plug_cb;
> 
> Maybe add "struct request;" here too ?

No need for type forward declarations when the types are only used
for pointers in structs (or as pointer variables).  They are needed
only when pointers to the type are used in prototypes.

