Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1D1F2F532C
	for <linux-block@vger.kernel.org>; Tue, 17 Jun 2025 23:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750202713; cv=none; b=Y5/0ijiUFEHR47YWm1YbqAlDx8gipDQB9XdUfrPm/t6B453iaoGmQfs9R5s6tNUXSaVSv3XkCxXgW4yBm7kb9C0BRb/J5oB0v4fpJnIQv1+dg2oZOYQmnJjVJJwfiqkQn3pdB6gdmYc0Fd2Z3BYkkHkKooIITS4moiZX7MXWINM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750202713; c=relaxed/simple;
	bh=qqFswnpIxhYZQgewi5QxadeBTH00J2KIIOkErfxrV+A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KPE4mDCcd88eNx5be8mtAkOtWLmSZSBiCR6iyZOsz6ctrOusAFSbZAFs0PFi5akkmXvFfSP8TsfBNC5FzByuwm5BokpGF70M88vlbcKbczdr10BzQiYCmO8G102Jc9HeJk9Jmjpgb+fZyxiopXdAmpfKeJFE7agm4xwtqmTqDUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i86wVHcg; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i86wVHcg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 641ABC4CEE3;
	Tue, 17 Jun 2025 23:25:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750202713;
	bh=qqFswnpIxhYZQgewi5QxadeBTH00J2KIIOkErfxrV+A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=i86wVHcgdAqNEzrlwzGF2mkErWaNlK1OhryWPWbZ71omd+6A7vevw/Dn2hz850Rdk
	 vHyQlXwtxpRVzENHvJeqxUJvJyAbPs6imrPnx9GdAgolw4mGOSrLtVJqUIJYfsK2ru
	 WjsSUWs6QkgHvRJVuoNCuSkhYQ1EjDi4WtYwahj+mB2QNXbUGGtBpzaR3suOWDVANL
	 xSqK/ZbvtRsJHIl6rsGFgs6K0NjoQzizqEU2tI+nfIpUP2tiBXDmnZ6O9TaA0I2JNn
	 MNEz4P3N32uiTq+vNfhDoN9jFIariP8Rcr95ObyCND02D1ahf+mmUEEJOwAaigcFVh
	 W0K9pD2KkhC0w==
Date: Tue, 17 Jun 2025 17:25:09 -0600
From: Keith Busch <kbusch@kernel.org>
To: Daniel Gomez <da.gomez@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Kanchan Joshi <joshi.k@samsung.com>,
	Leon Romanovsky <leon@kernel.org>,
	Nitesh Shetty <nj.shetty@samsung.com>,
	Logan Gunthorpe <logang@deltatee.com>, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH 7/9] nvme-pci: convert the data mapping blk_rq_dma_map
Message-ID: <aFH5VXKwoWE3Eq5V@kbusch-mbp>
References: <20250610050713.2046316-1-hch@lst.de>
 <20250610050713.2046316-8-hch@lst.de>
 <5c4f1a7f-b56f-4a97-a32e-fa2ded52922a@kernel.org>
 <20250612050256.GH12863@lst.de>
 <4af8a37c-68ca-4098-8572-27e4b8b35649@kernel.org>
 <20250616113355.GA21945@lst.de>
 <500dedd7-4e66-49d2-8c63-91d6a07f2e43@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <500dedd7-4e66-49d2-8c63-91d6a07f2e43@kernel.org>

On Tue, Jun 17, 2025 at 07:33:46PM +0200, Daniel Gomez wrote:
> On 16/06/2025 13.33, Christoph Hellwig wrote:
> > On Mon, Jun 16, 2025 at 09:41:15AM +0200, Daniel Gomez wrote:
> >> Also, if host segments are between 4k and 16k, PRPs would be able to support it
> >> but this limit prevents that use case. I guess the question is if you see any
> >> blocker to enable this path?
> > 
> > Well, if you think it's worth it give it a spin on a wide variety of
> > hardware.
> 
> I'm not sure if I understand this. Can you clarify why hardware evaluation would
> be required? What exactly?

This is about chaining SGL's so I think the request is benchmarking if
that's faster than splitting commands. Splitting hand been quicker for
much hardware because they could process SQE's in parallel easier than
walking a single command's SG List.

On a slightly related topic, NVMe SGL's don't need the
"virt_boundary_mask". So for devices are optimized for SGL, then that
queue limit could go away, and I've recently heard use cases for the
passthrough interface where that would be useful on avoiding kernel copy
bounce buffers (sorry for the digression).
