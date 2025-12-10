Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E168630AAA6
	for <linux-block@vger.kernel.org>; Wed, 10 Dec 2025 11:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765366104; cv=none; b=jVohCZLWrE95BHhPkAGK9chMtrOA8Bb1/vApcXT3AMc4k17fXYGEo+sbXQJzWSw5HBw+I8zOPIxt2zPimI3x4pBjxsZ9JMqXr7AS19l29OK1/40SPdjAj1L8nszwL6+PRqAHY7QWoOyOevuodvvQRhQP4ifV/KuRq4+rY/wfjkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765366104; c=relaxed/simple;
	bh=gg8hl7nTHDakoQLZv6QxgPTOn2zhObCa9+AvPzyKdXs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f2PZG13NtzZoIxtr9jCY65PAIp6bSV6YlaO8V/dcMoMkw11P2HME+WdVo32oNVuKw/vak5PHou42R6IinE8ykCeS0gYu2b/p59H5EnHTQcJwbKWJWpBnKVXIDgZZmcXyxIqm5NI5UffczvKrwVDaUGSkAzg9+wx+IXtgvCEUwf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SGqk9OWi; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SGqk9OWi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D4FAC19421;
	Wed, 10 Dec 2025 11:28:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765366103;
	bh=gg8hl7nTHDakoQLZv6QxgPTOn2zhObCa9+AvPzyKdXs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SGqk9OWiUeYLcSid5N2CFDeHMDLKlbx3Xthod0DimM1ITfI21ZX8DeGD4RFD98wqh
	 n1TGpk0/J9DS1V42TVy5abFvhp3bMvb9hV5xWmTv//ZuxY9my0DiIy+f17p1Nm6iQw
	 Sd16TyqbtNDf8cf0SYXDZPJ3GZaW2kTwy5/BLPvOj9ySS7QCVEB/Af/ZkUdlCQzrsH
	 8W7Dbhp0oEFgtwy+YjkofXApmpkZWkfDB3EJbtIqHz7B8hE/pgP0HWnpDPw3PqYpMH
	 DwtuaFQkTxUwH5CvkhX4dKfF2YMOT2FiXtby6DIsKpdIr8qZNoAt2I0RfTn/XUkphB
	 Eq57rP7w9vN6w==
Date: Wed, 10 Dec 2025 20:28:19 +0900
From: Keith Busch <kbusch@kernel.org>
To: Max Gurtovoy <mgurtovoy@nvidia.com>
Cc: Christoph Hellwig <hch@lst.de>, sagi@grimberg.me,
	linux-nvme@lists.infradead.org, kch@nvidia.com, axboe@kernel.dk,
	linux-block@vger.kernel.org
Subject: Re: [PATCH 1/1] nvme-pci: set virt boundary according to capability
Message-ID: <aTlZU_2SqgajJ64v@kbusch-mbp>
References: <20251208222620.13882-1-mgurtovoy@nvidia.com>
 <20251209064015.GC27728@lst.de>
 <6649eb8e-ae68-460d-95db-deece134e9d1@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6649eb8e-ae68-460d-95db-deece134e9d1@nvidia.com>

On Tue, Dec 09, 2025 at 01:31:21PM +0200, Max Gurtovoy wrote:
> dma_set_min_align_mask(dev->dev, NVME_CTRL_PAGE_SIZE - 1);
> 
> and
> 
> lim->dma_alignment = 3;
> 
> to ease the restriction for capable devices with NVME_CTRL_SGLS_BYTE_ALIGNED
> support ?

Yeah, the dma_alignment is the limit you'd need to change. Note, you
can't actually set the dma_alignment to be byte aligned as it's a mask,
so you'd want the value to be 0 to allow any alignment, but the block
layer currently won't let it be 0, so you'd have to set it to 1, for
word alignment.

But I'm surprised to hear of a device that can do byte aligned SGLs, as
PCIe fundamentally can't do byte aligned DMA. It's all dword based, so
if you have a device that does report byte alignment, it's still sending
dwords over the wire. It's just using the "byte enable" fields in the
TLP header to have the receiver strip off preceding and/or trailing
bytes, so it is a bit inefficient way to transfer data.
