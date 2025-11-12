Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FB24199949
	for <linux-block@vger.kernel.org>; Wed, 12 Nov 2025 03:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762916911; cv=none; b=MYLTsbSIkuV8DUZqTdVNFcTo1jXv7rQAqg0gdvqeneXRbMaCU5FirHgBncbFMmR2/X7XVb7ur+kmeiEo/wT1ZJg6n+/LqcLcM0Vs9G9JHcoRpcX1zJd3iMz5k0IMiurbumgj4aDJNikFdVmW/OD4JF24KO4fhEKMnGvLvOzj12M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762916911; c=relaxed/simple;
	bh=gYtQard0X1ou+0a3UcE6HQP7fHKzVlRelPhLNsmBQ/I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dZQFMS8MZptXonFPml9/TFlqlUqHRQn7ZKpbPRSGKtMt1XIAGo8QgajbSWfzhvGT5aX/XmyK4uUJqm88yTG5N3o/ifBIvov/MOhb/wRYN+iepghopG2KzVQna4IFk2P1L79Rskob33fUsU9Dlsi8sQHOe/aqIsCk0E9KXrmUtB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oTZHqEZd; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oTZHqEZd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5961C116B1;
	Wed, 12 Nov 2025 03:08:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762916910;
	bh=gYtQard0X1ou+0a3UcE6HQP7fHKzVlRelPhLNsmBQ/I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oTZHqEZd02WcQls8oz9DpPfJj8hN47SuXirlHVUOHhZuW4tkcf32QWXF2jN1+9fWm
	 WOtX52ah5DeDrOcP2xW6z0tJpVADZXfGc5FuVPoNc1mgMB6WlgPNej+fbvY0gxL+hX
	 L3mnMofbshMWeyKj57WiEXDVx3o4R4bY+QJvmhleWnhHoScwBzdoUuf+tFfU3sMhMQ
	 dtyNeRGij4uwlBnffystD1a+3k/cWsvXrv8AI6Wq77LhC/8Mdbe9WNFfHtha7Q173y
	 Bt1O+PbHkALs4gRgsVbbRnTRNDCmDn5hXesZZUCWqucOwqyceg/4YAnYgrwkdfPdE6
	 pBIrPkBmG3jJQ==
Date: Tue, 11 Nov 2025 22:08:25 -0500
From: Keith Busch <kbusch@kernel.org>
To: Chaitanya Kulkarni <ckulkarnilinux@gmail.com>
Cc: linux-block@vger.kernel.org, axboe@kernel.dk, hch@lst.de,
	kch@nvidia.com, dlemoal@kernel.org
Subject: Re: [PATCH V2] blk-mq: add blk_rq_nr_bvec() helper
Message-ID: <aRP6KdADdbnhwwrj@kbusch-mbp>
References: <20251111232252.24941-1-ckulkarnilinux@gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251111232252.24941-1-ckulkarnilinux@gmail.com>

On Tue, Nov 11, 2025 at 03:22:52PM -0800, Chaitanya Kulkarni wrote:
> This patch also provides a clear API to avoid any potential misuse of
> blk_nr_phys_segments() for calculating the bvecs since, one bvec can
> have more than one segments and use of blk_nr_phys_segments() can
> lead to extra memory allocation :-

Perhaps blk_nr_phys_segments is misnamed as it represents device
segments, not physical host memory segments. Instead of rewalking to
calculate physical segments, maybe just introduce a new field into the
request so that we can save both the physical and device segments to
avoid having to repeatedly rewalk the same list. There is an ongoing
effort to avoid such repeated work.
