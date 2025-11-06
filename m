Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BA2D30EF6F
	for <linux-block@vger.kernel.org>; Thu,  6 Nov 2025 11:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762429950; cv=none; b=VEtJNHFR0Kuq1E+VnCXGFRxAJwfWnN8Wqy1ynxthyw86+dhAr91DrSEtODdN6TCFvN5Fj69uFJsULzFn2qW09RzNr3KE+m6XTMf1KGbS0PHG45UWL2zg0FV39Foq43kJUV3+xqEfeuyF/oHpRgp8dhlhKRc77iJOns3fahC7Rmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762429950; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZhDsTyg0nI/ASmPc4qnl7F2UW6ialSWkKb5XHjYKI5hHFvLhckkU3Z8VLSaWWWZjo8b29SQA9mWqEBFHQrg5NqeMvgMWUbnFRKrupZHuce+4O1RSKRzE4q+0Omcw3qA0ZaIosFm9CwCBKI/3fjwuYEQZeIUm6DOx5OO0xaPFFts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id E83DE227A87; Thu,  6 Nov 2025 12:52:25 +0100 (CET)
Date: Thu, 6 Nov 2025 12:52:25 +0100
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@meta.com>
Cc: linux-block@vger.kernel.org, hch@lst.de, axboe@kernel.dk,
	dlemoal@kernel.org, hans.holmberg@wdc.com,
	Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCHv2 2/4] null_blk: consistently use blk_status_t
Message-ID: <20251106115225.GB2002@lst.de>
References: <20251106015447.1372926-1-kbusch@meta.com> <20251106015447.1372926-3-kbusch@meta.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251106015447.1372926-3-kbusch@meta.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

