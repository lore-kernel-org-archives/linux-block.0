Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 182863A1D2;
	Sun,  4 Jan 2026 15:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767539723; cv=none; b=pO5Tb8Va1oISIquHXiWmWY7vZ6+oAIcPoWOVuuWBU99g+jcIPqg+iztz/uA5a9IkNR9Q+4OVfKoiya5CrJQ5scorjqhl7aw0V34mHlu7KQVwSa+N4hN8rGH198NEy2ZO3bS3NdRJ0xYLKr42WyG9A0vVgN5YdR5P85+XLoFseHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767539723; c=relaxed/simple;
	bh=KwyBr6ZNhjpDSvllOYbZp4V3CNJuKep94TyiPfnFVJM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gc8PY0Jw+GfMUhsp/Gz2mknVFpDky7zyZ6cTRwNQ6EMv0uIVs2gaz0lps8WQdiQ8wUg3k26HhvT4WAU4UR51WIk3am9VSWNb9uO3dXeWX1y6gbavzopCc9ffChtfrDnywceZuu1UkO8W3fJx+6Fhde9KInx9bmQHzUaHk7xHU/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AOyBtXP5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AOyBtXP5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2718CC4CEF7;
	Sun,  4 Jan 2026 15:15:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767539722;
	bh=KwyBr6ZNhjpDSvllOYbZp4V3CNJuKep94TyiPfnFVJM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AOyBtXP5QALAHoberi2uTNUqvdvL5sqflEYt5769XwMwb/I0hnqAwnVXOB+xdtYYz
	 CbTbmWPQjo81mFDzERgMya+LJbHbhr7bnA5HUTfprjfve799dyQBBS0ruKoV7bbfFT
	 9ZUe/1M4YwSUQ5NtDr1xNM3a0lR+F0RlDpq9t+z0BYEm2RG4DRsj6uYHVRt4zXxFul
	 xW6AVbP+CxIwhs3yJsTZK7euEbJP83INr6qRKgE/POi8rZgaZHLRJov3Z0TmHxR4Y/
	 221b8Miml4ElJePHhhvT08rUsE239UBIwtKyFDDWRt5dlgyJh+1D0ctZqeokPDrgUx
	 lSeiHP2vkBLxQ==
Date: Sun, 4 Jan 2026 17:15:17 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org, Chaitanya Kulkarni <kch@nvidia.com>
Subject: Re: [PATCH v3 0/2] block: Generalize physical entry definition
Message-ID: <20260104151517.GA563680@unreal>
References: <20251217-nvme-phys-types-v3-0-f27fd1608f48@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251217-nvme-phys-types-v3-0-f27fd1608f48@nvidia.com>

On Wed, Dec 17, 2025 at 11:41:22AM +0200, Leon Romanovsky wrote:
> Jens,
> 
> I would like to ask you to put these patches on some shared branch based
> on v6.19-rcX tag, so I will be able to reuse this general type in VFIO
> and DMABUF code.

Jens,

Can we please progress with this simple series?

Thanks
