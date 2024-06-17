Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE06919007A
	for <linux-block@vger.kernel.org>; Mon, 17 Jun 2024 06:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718604386; cv=none; b=KPjVeiYFCChMgOjcvugcwVWSxIy9daDCFovvRRPDQm+WQr7LPIMq85lAE97Y0cc04gqndBd8UqDBWHVyyOyOkVsSuzP7dP/l5nBbAZggFoVKUSwXIHh36+7/h/KQub/ei7hDZ8yFaYh8B5cGMXp/YWpG31BLDSZiRhW5RHY9t2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718604386; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P4f8QV3J0Ybr6YHD9KtXJyvESxc+A5CUQH2WvQSB0SsprCJCbZW2shuJsOH5vnneVyMQUfX7tRDr+MOE1QKKL2DowScN9m5ZuNEM2yw3lQkro3b6yLbPwq7d910BankBLcp2l3AIOx9+cv8HxMEhY12cvUjrIsCi2EwvyYS8YpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id A0E8268D05; Mon, 17 Jun 2024 08:06:19 +0200 (CEST)
Date: Mon, 17 Jun 2024 08:06:19 +0200
From: Christoph Hellwig <hch@lst.de>
To: Kanchan Joshi <joshi.k@samsung.com>
Cc: axboe@kernel.dk, hch@lst.de, linux-block@vger.kernel.org
Subject: Re: [PATCH] block: cleanup flag_{show,store}
Message-ID: <20240617060619.GA17582@lst.de>
References: <CGME20240617045649epcas5p1763924a49c5182f30a9ae3ea013390ae@epcas5p1.samsung.com> <20240617044918.374608-1-joshi.k@samsung.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240617044918.374608-1-joshi.k@samsung.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

