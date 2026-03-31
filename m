Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EDB53E122D
	for <linux-block@vger.kernel.org>; Tue, 31 Mar 2026 15:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774971558; cv=none; b=e92TIG4uDkX3LFNH0M6EXB2ytiMwpTyFY4lx9uIRBFveVbrMIZuo5Jk2NzLGEM71tGelHkAl1fB7uyZT9Y34W/alcr1PU5VpopRV+e76fibdhkFUKKM6wtvmx53l4Vmfl8e9c9GYqwKcUPGd2oLnuWi6yTM05lt0znSKlAuzWCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774971558; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Aa82kXQLMEkC+gYwPTcfVMyyg7sljENsrolh29bR3wAjWLff2iYpq6ZmmjdqUiOaNkDeERC6GuSM7GQNbJTTNwUT46z6a/R5H2V1CwNFey0GTQnVKdTa/+jiy5kYA45NgRB+/WOiaZyVySDIy2DzApI74KVMl5zY3B9qKJmnzng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id C349068BFE; Tue, 31 Mar 2026 17:39:14 +0200 (CEST)
Date: Tue, 31 Mar 2026 17:39:14 +0200
From: Christoph Hellwig <hch@lst.de>
To: Bart Van Assche <bvanassche@acm.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>, Damien Le Moal <dlemoal@kernel.org>,
	Ming Lei <ming.lei@redhat.com>
Subject: Re: [PATCH v3 3/6] block: Fix the DMA segment boundary mask check
Message-ID: <20260331153914.GB8470@lst.de>
References: <20260327211349.2239633-1-bvanassche@acm.org> <20260327211349.2239633-4-bvanassche@acm.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260327211349.2239633-4-bvanassche@acm.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

