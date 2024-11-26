Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C07DBEBE
	for <linux-block@vger.kernel.org>; Tue, 26 Nov 2024 04:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732596655; cv=none; b=q5h0iQpnQjkOQvWGVyKEFQp1yGkRE0vd9FBYACQUyyXk07fbTVlT9u5VAN0tGA8HEe84CCQvsvSk2bKEBRtxM6zF6qWOft5iZuGBz7/hKTrP+mAFgucSS9LBK07+lBpyWdl/3nYc+KGGh6ZJGoBtxSkwteL6WEADjbuGZ2z4xjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732596655; c=relaxed/simple;
	bh=xVg5H5+XsNruwrlr8nCMFDaU5q2z49slbnv2axFj+ek=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uxF5kFLFs+bXgcmuIGlNVx3Dx181KMV/GDgnOUc2itk6qPkuAV1P0mLMmZu3GFyo2JA3B8Oux2O+5EE6wHMAuu0M5qwkpF7PSCfcB0gvFqtK+KPBES9+8POiaI12UzOOgvIRupWidcbUwCTjrAl0GhiUTh1p65HQkvPnyrMTW1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id A01B568D80; Tue, 26 Nov 2024 05:50:47 +0100 (CET)
Date: Tue, 26 Nov 2024 05:50:47 +0100
From: Christoph Hellwig <hch@lst.de>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH] null_blk: Add rotational feature support
Message-ID: <20241126045047.GA30982@lst.de>
References: <20241126000956.95983-1-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241126000956.95983-1-dlemoal@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Tue, Nov 26, 2024 at 09:09:56AM +0900, Damien Le Moal wrote:
> To facilitate testing of kernel functions related to the rotational
> feature (BLK_FEAT_ROTATIONAL) of a block device (e.g. NVMe rotational
> bit support), add the rotational boolean configfs attribute and module
> parameter to the null_blk driver. If set, a null block device will
> report being a rotational device through it queue limits features with
> the BLK_FEAT_ROTATIONAL flag.

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

