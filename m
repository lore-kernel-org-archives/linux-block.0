Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E23727FB3F
	for <linux-block@vger.kernel.org>; Thu,  8 May 2025 15:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746716872; cv=none; b=hzymrwG+J4NhsRjJe2wmbv6LrkytHgXZ+CtptNarQdi5spRkgAdDsCE0euB15VkdJ/EW6h4vKT0Fp6zDfLDqf0UGq3jay3uHasxRycYo/kwWtytQg38Hgm0FDQBMeiw/scTmVRKuCIyHXu7auaIxOMiqvzjRwHeV6eYlxCJuI+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746716872; c=relaxed/simple;
	bh=Lt2rp1D0BNXgE1ZUtOs3ZaJA7yevGjecpak++R3zPJA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=hFcWP04pKyLdMJ7xaIfoCB4J5+KOpRtJAgn+WgTGJfNZaEC0luDdE2TGf6V/6L8Y+rVIqh5zBpqITDT/fZoEBearhQ3xc83zEVsB1H9DyDtwICP74zan2sIGCAUAYVwKgc/3j13w4E8iDtYgvUqGatBjXq0SOd5cab4f3rZYb8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=T8vfXNZg; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="T8vfXNZg"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Type:MIME-Version:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=Ko4pauh3uuh5Q1D4+7Jf3X67t3Uv+0ATxrGei1xV+6k=; b=T8vfXNZggAFgGxVN+rNBsIM4Br
	TGVksME3DmHZZpPkvOifWX01fWwIkJ21mo+dYu/qTwq1HW47Nqe1oBxZ7gEO2S7w5d12ZCi4TbUt3
	BY5E/RVz8KfRhL3yo4RM8JHx3ysZHxTKNCgRoUjR3ltrENGW+gMV9Fn7COSAaPWHJADncsV9rjLoB
	1bQFNW7W+gQqFZO1X1vei2b3N/u3npJby5Vnqc8S+LsZ+vtQOXZzHnvTJ/ew9dHKyWxRopDNLwbcr
	2/DqFEi1W5Wo/6U/87FipjZ+/I/KwTZ33J4c7HVkhpIwy3uPyuCt0WyGUoqQbJk+TMfSMkFZiMtfx
	bbWycTWQ==;
Received: from 2a02-8389-2341-5b80-263b-3d6a-277e-2269.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:263b:3d6a:277e:2269] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uD2qk-000000013Xj-1Qkv;
	Thu, 08 May 2025 15:07:50 +0000
Date: Thu, 8 May 2025 17:07:47 +0200
From: Christoph Hellwig <hch@infradead.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@fb.com>, Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>, linux-nvme@lists.infradead.org
Subject: [GIT PULL] nvme fixes for Linux 6.15
Message-ID: <aBzIw5ojzLmaen2g@infradead.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

The following changes since commit db492e24f9b05547ba12b4783f09c9d943cf42fe:

  block: only update request sector if needed (2025-05-06 07:45:59 -0600)

are available in the Git repository at:

  git://git.infradead.org/nvme.git tags/nvme-6.15-2025-05-08

for you to fetch changes up to 650415fca0a97472fdd79725e35152614d1aad76:

  nvme: unblock ctrl state transition for firmware update (2025-05-07 09:01:20 +0200)

----------------------------------------------------------------
nvme fixes for linux 6.15

 - unblock ctrl state transition for firmware update (Daniel Wagner)

----------------------------------------------------------------
Daniel Wagner (1):
      nvme: unblock ctrl state transition for firmware update

 drivers/nvme/host/core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)
