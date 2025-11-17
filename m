Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7391191F91;
	Mon, 17 Nov 2025 20:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763409703; cv=none; b=UhhLqpO6Mwx4g6QXtIKALeCuPjxsLzj+Ikfwq7NpuTcTP75eQlh2QD69X4hrdqiRVafLe4RHNwIvKQ2HmWua+wM6os4UlV0qJ9tVyjbQ1EaJr/Db99i8LF/0gh5DRj6YVnE9Di6hXmcx8k0SWjTd0ULRLW6r3xTG3+OuRe1Odg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763409703; c=relaxed/simple;
	bh=lHKjnHmwld4J7UpdFKFeqpdnk+sIlNnF2boW1e9EfYw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nP5Ant4V1qOhBtZbSFdNemjBJbfn8s2ZJ20kMIcaqmz7lSGG70RZYGV30n21D/Eb2DuvbZKhY7l8S3WR9iSINybOC7zH2dOdYN2lMWgdbc+wA9Eu37+DI7WNnYt+Sh/6h7mO4pB99GiD/ybbqAaWThcZ5epJBU4+iuD5a/NQclg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jxz27avf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jxz27avf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD1A4C4AF0B;
	Mon, 17 Nov 2025 20:01:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763409703;
	bh=lHKjnHmwld4J7UpdFKFeqpdnk+sIlNnF2boW1e9EfYw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jxz27avfTpyBV3WFr9fOPyqhVvxz89VNv4Hiz8xg+q0g/Mekwy2Z+jeba4zQFsNJ4
	 XkmcRiEONR14SZwWBRhhj8ydjJCsDypBS6V4zm+PK2xoDPCcZ+gTRicF/wmJpkzLu7
	 YwCRujVaWY60OGCR+6TvWC1oIDnHLdmqf0iZFUSSk5DmQc6/W3Z/IAfi9n8ycsx4/o
	 EWCCP/PVZjf9r3DEHKpU9tG4mBcZ8p7IEWo5uzxoV5iRAhJKqgQBn8maIwEIgsW44J
	 4zm/2rHXw5z6uavy31Cimy8EhB4sI0pURkBMd55PXbOHOInjA99pZH5gv2annPwy0s
	 CItIkgbfMqiCA==
Date: Mon, 17 Nov 2025 22:01:38 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Keith Busch <kbusch@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
	Chaitanya Kulkarni <kch@nvidia.com>
Subject: Re: [PATCH v2 1/2] nvme-pci: Use size_t for length fields to handle
 larger sizes
Message-ID: <20251117200138.GE147495@unreal>
References: <20251117-nvme-phys-types-v2-0-c75a60a2c468@nvidia.com>
 <20251117-nvme-phys-types-v2-1-c75a60a2c468@nvidia.com>
 <aRt5DPnMwzDw8_dF@kbusch-mbp>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aRt5DPnMwzDw8_dF@kbusch-mbp>

On Mon, Nov 17, 2025 at 12:35:40PM -0700, Keith Busch wrote:
> On Mon, Nov 17, 2025 at 09:22:43PM +0200, Leon Romanovsky wrote:
> > diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> > index e5ca8301bb8b..b61ec62b0ec6 100644
> > --- a/drivers/nvme/host/pci.c
> > +++ b/drivers/nvme/host/pci.c
> > @@ -290,14 +290,14 @@ struct nvme_iod {
> >  	u8 flags;
> >  	u8 nr_descriptors;
> >  
> > -	unsigned int total_len;
> > +	size_t total_len;
> 
> Changing the generic phys_vec sounds fine, but the nvme driver has a 8MB
> limitation on how large an IO can be, so I don't think the driver's
> length needs to match the phys_vec type.

I'm big fan of keeping same types in all places, but can drop nvme changes,
if you think that it is right thing to do.

Thanks
