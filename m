Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 589BA1F4CB6
	for <linux-block@vger.kernel.org>; Tue, 29 Jul 2025 18:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753815416; cv=none; b=ocmMpxm1YpDnxEnJdDw52W6pCp3NYiKBPwX18KqlSrA6KFUs0KTjq3fox9/Eg3g9DvEivd8e+bOA8u0AierL39t2QoIMUIONzFQcmTgYNWEDdV5l2hLAQsH/KiDzCSvVz8p1muUH2q8P0Dpg9zXaqAnBPUOmuyQAXV0orDid6zE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753815416; c=relaxed/simple;
	bh=CQGSkI20W+HN63X3iLtCJ1iKuS8FkLgWUNEb0f4fBRY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fVUeV3apAAT4S7slXN2ufAPHKOh+vAemtk97Jsg0n2BmfWZXMiK8LNNQ8k2Y2dEQsCjmR/t+h+pYeIgZ0weri/ILAKS+MzKs2K3hOUB7U5NitYbommRpyVx6MCr1/Yv6b7siz6O1gsnOQQd+JKIPrhyniSeuvPrQjv+PW1CyAjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O2bPIs4i; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O2bPIs4i"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A909C4CEF6;
	Tue, 29 Jul 2025 18:56:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753815415;
	bh=CQGSkI20W+HN63X3iLtCJ1iKuS8FkLgWUNEb0f4fBRY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=O2bPIs4iErYenC6ehlVME22t+EXDPAKi6PbUGgZ49jGWnTA52eUl3Ymt+ttQ1rLH+
	 tLK06bR82F46F4xAsasRbO+rlT3pxH+82vz79oF2LPW+M7oD+DyQ2FaAz0jOaU+F6s
	 NNK9M2nUiLiy4V4XTVo+6pYmyDzudIKHk+VYdnUzXWgcLmZKi4r1CeIihnk5o521fB
	 fiEbqrQodGpe01gVdQKIxFACGg3gwdcd5z7wpQqL2nvdUW4W/jI6U1qhx517jxjLRE
	 N4dQwqj6cwSM5iFVIYrVCQt+pbL5XS6AdZ4b8EyItEbu9YEwMnU5Lxk16mFvVJWV8X
	 By0RL8IXXEiFw==
Date: Tue, 29 Jul 2025 12:56:53 -0600
From: Keith Busch <kbusch@kernel.org>
To: Keith Busch <kbusch@meta.com>
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org, hch@lst.de,
	axboe@kernel.dk, leonro@nvidia.com
Subject: Re: [PATCHv3 7/7] nvme: convert metadata mapping to dma iter
Message-ID: <aIkZdfFOKLtet-Kg@kbusch-mbp>
References: <20250729143442.2586575-1-kbusch@meta.com>
 <20250729143442.2586575-8-kbusch@meta.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250729143442.2586575-8-kbusch@meta.com>

On Tue, Jul 29, 2025 at 07:34:42AM -0700, Keith Busch wrote:
> +static blk_status_t nvme_map_metadata(struct request *req)
>  {

...

> +	nvme_pci_sgl_set_seg(sg_list, sgl_dma, i);

This needs an error check and unmap if so, just like data prp/sgl setup:

	if (unlikely(iter->status))
		nvme_unmap_metadata(req);

> +	return iter.status;
>  }
