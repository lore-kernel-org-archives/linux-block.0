Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC07019C54E
	for <linux-block@vger.kernel.org>; Thu,  3 Apr 2025 05:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743658578; cv=none; b=SdNRgajNcy6qMNBysItjUGFWh2TpPKYwuKndEm6jXeX5XbKK4ZXXnSSqzjECXYc10vDgw7WWugMC/gaU+IwrM/8qxHX6bhOBUbcv5lGXJuvHK4s1hKHTyNT2M8JvntDNRm1Q0j1JjGlK+nPuz34HEbyMv4H+yJZgW5Bo8yDCHiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743658578; c=relaxed/simple;
	bh=9d9cjIkFuBtCbNmFv8jd+ZZLyAaB30T+SNwapgRhCqg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VnGm3MAvgbZbDlf9yl1L1BCErgzhIX5sakLrumjfCQDh8yZcOLIVYUcStLWJ6VZfaQyiD58WCfWho6Nx60a+weOigqzdQr0PLVp9ga3HBcTdFqkQlRJwXrzgWrWqXwobeTQx31WILwBi6RW7tv4zBXRHneekSqVGWcVn5BHLn+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 1017A68CFE; Thu,  3 Apr 2025 07:36:11 +0200 (CEST)
Date: Thu, 3 Apr 2025 07:36:10 +0200
From: Christoph Hellwig <hch@lst.de>
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Valdis =?utf-8?Q?Kl=C4=93tnieks?= <valdis.kletnieks@vt.edu>,
	Nilay Shroff <nilay@linux.ibm.com>, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH V2 2/3] block: don't call freeze queue in
 elevator_switch() and elevator_disable()
Message-ID: <20250403053610.GA24133@lst.de>
References: <20250403025214.1274650-1-ming.lei@redhat.com> <20250403025214.1274650-3-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250403025214.1274650-3-ming.lei@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Thu, Apr 03, 2025 at 10:52:09AM +0800, Ming Lei wrote:
> Both elevator_switch() and elevator_disable() are called from sysfs
> store and updating nr_hw_queue code paths only.
> 
> And in the two code paths, queue has been frozen already, so don't call
> freeze queue in the two functions.

This looks good, but please add asserts that the queue is in the
proper frozen state in both places.  Also please move it first as
it doesn't depend on the previous patch.

