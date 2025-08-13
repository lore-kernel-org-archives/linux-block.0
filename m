Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B3AD2D63F1
	for <linux-block@vger.kernel.org>; Wed, 13 Aug 2025 06:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755067916; cv=none; b=sycTPjxgWVmL1bpkulBTl4yDhNmoAv7EAh5YNEbHd//ulnRS52v3BLIXmnsXigJ4TSC51aOebhQ45CWu37hoVO8b3P3gh2QTE4K6yrgIj/fy0PFwCtqKCRRjaO5o1eS16Vt+FYYaRxlzVR9Kt9F6XlQCNeBuT23qMcLAWSHWMgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755067916; c=relaxed/simple;
	bh=4jgIZv2CRDGoiNDC9yv7q4ns41qLs0gnoZVxNvgNp/s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eeKcCYo8qfXG/cU30Euk9wBJtypJCSRQUUQtbbhEvclqLxHQNQsTae1Gyf/ucFe3l84YCZlqTLWE8X5R5pCouyeHVwAosIxYeARX4rrnLCd03/uZq/3alSG0rtQpOlU5wY7YPypWFMGfD/M4zwi5u3WP0rxXYJS1vrMFno4W4js=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 9992668AA6; Wed, 13 Aug 2025 08:51:50 +0200 (CEST)
Date: Wed, 13 Aug 2025 08:51:50 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@meta.com>
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org, hch@lst.de,
	axboe@kernel.dk, joshi.k@samsung.com,
	Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCHv6 7/8] nvme-pci: create common sgl unmapping helper
Message-ID: <20250813065150.GA12473@lst.de>
References: <20250812135210.4172178-1-kbusch@meta.com> <20250812135210.4172178-8-kbusch@meta.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250812135210.4172178-8-kbusch@meta.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Tue, Aug 12, 2025 at 06:52:09AM -0700, Keith Busch wrote:
> +static void nvme_free_sgls(struct request *req)
> +{
> +	struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
> +	struct nvme_sgl_desc *sg_list = iod->descriptors[0];
> +	struct nvme_sgl_desc *sge = &iod->cmd.common.dptr.sgl;
> +
> +	__nvme_free_sgls(req, sge, sg_list);

No real need for the local variables for sg_list and sge.

And I'd just kill this function and rename __nvme_free_sgls to
nvme_free_sgls.  But if you think that's just noise right now I'd
be happy to do a clean up pass later.

Reviewed-by: Christoph Hellwig <hch@lst.de>

