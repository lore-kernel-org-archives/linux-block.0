Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 437EF16BE2A
	for <linux-block@vger.kernel.org>; Thu, 17 Oct 2024 05:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729144634; cv=none; b=CloKtPHOjRa/P0F0Dy1BkT7+Qjob4Nxh7rzxhS9pcn4dJn07s50k7HczIcAGzcQKexYfAEdqXa7CRTGTrBmHnkwpcJJNOFHbGpui1uc3AmInQq4ezoHKF84HfSk5wNjTr9Wn8nfC5O24XKFt0ZMcXPXF/sSLHJuCEhKePMfnfwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729144634; c=relaxed/simple;
	bh=+VaN9HrMYAT1XMgMMVMcu77+KxKez4pI8yDgIAQKiIM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=anfltdzepCdevqNrEvJCE/kTZGxC36o2ZXbLbzEAQcSME0voJMxc1pZN4k5pkLMp/j73ruhIwl7YIemBCKv5qvQ8oHoMJolaw/pLmTjHINGpOSTxYyJYDOh83jDdWiLOcf4PgDZjZvuGFazZvjivyD7HeTr2asGgBbeajeb4ZqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id CEB10227A87; Thu, 17 Oct 2024 07:57:06 +0200 (CEST)
Date: Thu, 17 Oct 2024 07:57:06 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@meta.com>
Cc: hch@lst.de, axboe@kernel.dk, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org, anuj20.g@samsung.com,
	martin.petersen@oracle.com, Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH] blk-integrity: remove seed for user mapped buffers
Message-ID: <20241017055706.GA22880@lst.de>
References: <20241016201309.1090320-1-kbusch@meta.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241016201309.1090320-1-kbusch@meta.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Wed, Oct 16, 2024 at 01:13:09PM -0700, Keith Busch wrote:
> From: Keith Busch <kbusch@kernel.org>
> 
> The seed is only used for kernel generation and verification. That
> doesn't happen for user buffers, so passing the seed around doesn't
> accomplish anything.

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

