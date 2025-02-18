Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A20C11B6D18
	for <linux-block@vger.kernel.org>; Tue, 18 Feb 2025 16:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739896364; cv=none; b=h0xpf96CO2ByRvUlWcqJQ05hpTJBlkljr9ztzvVx/fnLh87JFQ1AjGY5JB5x6KU+pPyTQl6Li+omL4ijJ5DNfB3KG0L3opad0eX8qdzj7zcm4ZyMSXb0zP308pE9UFZpyqd6qvsoW9+PicGzxm3s4Twa2djIs9tIqr3G6EojElA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739896364; c=relaxed/simple;
	bh=d5qm7BFsH0ADcDX+Q4M7SlfhfAOz8Yv8kSPGi9W8nss=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nKzDPoRLC5/UJzuDuz/y9BMF4F3vTN1Ic1tGhcBbM7ggkg5Nqp08ka9+JSNfVToDQqLawhLqtwBj/DPzrecV92L8dRrWs+DcdVGl32JGv/39ZsFOxGVEeQZ95G8rK/0vpomzW9EfM74TgzjxYRa0cnixPtYNzTiHp26/41NwXcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id CEA8068D07; Tue, 18 Feb 2025 17:32:35 +0100 (CET)
Date: Tue, 18 Feb 2025 17:32:35 +0100
From: Christoph Hellwig <hch@lst.de>
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: Christoph Hellwig <hch@lst.de>, linux-block@vger.kernel.org,
	ming.lei@redhat.com, dlemoal@kernel.org, axboe@kernel.dk,
	gjoyce@ibm.com
Subject: Re: [PATCHv2 3/6] block: Introduce a dedicated lock for protecting
 queue elevator updates
Message-ID: <20250218163235.GB16439@lst.de>
References: <20250218082908.265283-1-nilay@linux.ibm.com> <20250218082908.265283-4-nilay@linux.ibm.com> <20250218090516.GA12269@lst.de> <e54fc76f-2bb8-4d22-b297-7cd1c94b7e88@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e54fc76f-2bb8-4d22-b297-7cd1c94b7e88@linux.ibm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Tue, Feb 18, 2025 at 04:44:44PM +0530, Nilay Shroff wrote:
> So now if you suggest keeping only ->store and do away with ->store_nolock
> method then we have to move feeze-lock inside each attributes' corresponding 
> store method as we can't keep freeze-lock under ->store in queue_attr_store().

Yes, that's what I suggested in my previous mail:

"So I think part of that prep patch should
also be moving the queue freezing into ->store and do away with
the separate ->store_nolock"

