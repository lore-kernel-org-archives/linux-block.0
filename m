Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86D972139AF;
	Thu, 27 Jun 2024 05:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719464451; cv=none; b=prL1BlgJTp/68v8nA0+xfpaqnHGF7wx2F7z0By/N271UsrGtohXnqACQJpa6SoHyxLj5JIME+7Y6jTf7Vs3yruuMdvPcGXHNWAjROfKb2gh5CXMA7fpTpNlml5pZPOCVJvUsiHYSh1F6gAxZ0OdCLE75vMu7wxW/vkNXkVpBhmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719464451; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QVoQBRT4oG/fo4tWw8N4YtTJKWA6R7s4HoSFbjmZhpPjaOkg8p0wFCIFJhW8e98uENM5FSC3OhdmZCOk93QM/1bXyH3/jAESgoHInVAWX7TyuBeD5/CEu6x7ifDSWvrBzCu5S4H/DtbJ0MF6wj5eBejD6SB8fT6pOZbMDBZDF7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 9843F68C4E; Thu, 27 Jun 2024 06:54:38 +0200 (CEST)
Date: Thu, 27 Jun 2024 06:54:38 +0200
From: Christoph Hellwig <hch@lst.de>
To: linan666@huaweicloud.com
Cc: axboe@kernel.dk, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, hch@lst.de, yukuai3@huawei.com,
	yi.zhang@huawei.com, houtao1@huawei.com, yangerkun@huawei.com
Subject: Re: [PATCH] block: clean up the check in blkdev_iomap_begin()
Message-ID: <20240627045438.GA14101@lst.de>
References: <20240625115517.1472120-1-linan666@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240625115517.1472120-1-linan666@huaweicloud.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
