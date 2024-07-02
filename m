Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDB1F82488
	for <linux-block@vger.kernel.org>; Tue,  2 Jul 2024 12:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719922169; cv=none; b=QZZHSqyIYLYcy73qyMsglop+T1HJ9yV9eRCeV+tneQzl2m1TgFjuyrepZywRs0RQPMV7lfLRkRD8QShze1MvBG/PP41j/cERtxJcI1R0Kcn8Cw0hweJ40FdAR+59I0iGrxZZhIvWdO2SGtfJOxvDqOo60eTOIKNeIfavVtL9mas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719922169; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gos9oPSmKP3sHdMKaeBuc8cL9kHlprOUbCFGV/b1Cr6kbhuwBKaKDxjFhChhBcxSA6pVmNewdTHWC/6ogRvyZgvzVb9HzcMhcDLjo/JzKtOnbr3wkIOF4adhOmNl0SkuoVGH1VbXG95lP4YTUSMYbI1k8iF89nfvVLOJg4dI9cY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id CF44968BEB; Tue,  2 Jul 2024 14:09:24 +0200 (CEST)
Date: Tue, 2 Jul 2024 14:09:24 +0200
From: Christoph Hellwig <hch@lst.de>
To: Bart Van Assche <bvanassche@acm.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>, Damien Le Moal <dlemoal@kernel.org>,
	Zhiguo Niu <zhiguo.niu@unisoc.com>
Subject: Re: [PATCH v2 2/2] block/mq-deadline: Fix the tag reservation code
Message-ID: <20240702120924.GB17584@lst.de>
References: <20240509170149.7639-1-bvanassche@acm.org> <20240509170149.7639-3-bvanassche@acm.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240509170149.7639-3-bvanassche@acm.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

