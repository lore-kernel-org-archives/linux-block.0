Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AF64215F4E
	for <linux-block@vger.kernel.org>; Mon,  9 Dec 2024 12:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733748077; cv=none; b=YWOge+e8lkaxTtj+9r9c1vhl8eNuOJ01qyl6c3DSvWZMJLaeL8ZmGPdghBg78HzXdVwahUUozZb6iy48VrzSDPoiT3jUZA/7blPQRnjLwnOIHK8/Z4h9MG85eM9vkvuaMg1ZW7NOtOrRjialSMAhM40Wk1WjzJ/si1dJkqZSAfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733748077; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XLj/YxSU8M5JtBZDQ0V7Y3l0St5gVkpWsOul6TAgNx33n73zKBPRL9/49le5juHjhIiIuzZwJII2zp5CiIGqEGz5ORabzWSMdG5dOt+75lDH8eBZlApLlRHzTh6TGo9rIe+ntKJuhOnBue1DZXkVbBSdFrH6q6V1w3eseqey2Ms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id E00A368D09; Mon,  9 Dec 2024 13:41:09 +0100 (CET)
Date: Mon, 9 Dec 2024 13:41:09 +0100
From: Christoph Hellwig <hch@lst.de>
To: Yang Erkun <yangerkun@huaweicloud.com>
Cc: axboe@kernel.dk, hch@lst.de, linux-block@vger.kernel.org,
	yangerkun@huawei.com
Subject: Re: [PATCH v2] block: retry call probe after request_module in
 blk_request_module
Message-ID: <20241209124109.GA13869@lst.de>
References: <20241209110435.3670985-1-yangerkun@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241209110435.3670985-1-yangerkun@huaweicloud.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

