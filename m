Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3EAD2701B1
	for <linux-block@vger.kernel.org>; Thu, 24 Apr 2025 11:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745493804; cv=none; b=c9maEP0iNcjlRJvYSsgrJpIrl7Qc0EqCw+VsV4s3mjMTCkf6DhLwCXcJZ3vmJNn5nZQGHbZhUFBLXZv4kFAJq13tfloisevWACv84Tpx4LIj2LTL4qtVFGkrdVRKQ7PVWmbgBvKIxccaFkCdsx8PVQF2S0PI2FUk8iKiBdDmYxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745493804; c=relaxed/simple;
	bh=pKs316zorQ2pc4u2/pwFKu1jqelQxO4Ro91M2RxFeFU=;
	h=From:Date:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=BWSefwnHM22rYpYBKjRSpNUz6sRzRj8jvxM3jPBd5hWD6e3fBiQnrZZBx3/duRg1DG3bWuzT/9sXSwBU3kHb5gzTGmcGU7BDU6jKfLl7UPwx/CxHChJF67Inr7+pU3kjHhg2+gTQVihUl3Wi8jplr+NdBF0kZCa3eS/HDmiOJV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=oWoKJT57; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="oWoKJT57"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Type:MIME-Version:Message-ID:
	Subject:Cc:To:Date:From:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=WVBr/Ghbog4PLk/aG+exb7ALAkQhCwEw3ntq1YdW8UY=; b=oWoKJT57paM4/pIy5fWK8yQOqk
	bq5i62Ku7Brj+j8BlZs3SwXLlYLYiBu0dVz2kmAxhAD3rhe9FWQJrfaM06vzMkT3d6ffZ+eETuVfu
	I8HgetOY0suKk/u3AhlG6n5TyQkbO/ySWn5/oe4CKQTerUeGWRTG8A6qL4b/Ac1CAhrl8DT4T/AvV
	RVna+3NII1D9zzYe3zZCVLQU8cG49GqtTbb12nymiWII7s6rWg2TYGW3p2eMo3cSRo/nDPANHJMZI
	/ZwdArkfyvyryWb+EKtf9+ijQRygGYZas3xCpD5TrMezUtcetoOwX2k3kQ52VUq6oQ1s1A4zGW5J/
	1laeLOnw==;
Received: from [2001:4bb8:2a7:ccbe:8b0f:ffa1:e482:eff5] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u7ufp-0000000DqGL-19zn;
	Thu, 24 Apr 2025 11:23:21 +0000
From: hch@infradead.org
Date: Thu, 24 Apr 2025 13:23:16 +0200
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@fb.com>, Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>, linux-nvme@lists.infradead.org
Subject: [GIT PULL] nvme fixes for Linux 6.15
Message-ID: <aAofJOcb2NzkXsP9@infradead.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

The following changes since commit 81dd1feb19c7a812e51fa6e2f988f4def5e6ae39:

  Merge tag 'nvme-6.15-2025-04-17' of git://git.infradead.org/nvme into block-6.15 (2025-04-17 06:18:49 -0600)

are available in the Git repository at:

  git://git.infradead.org/nvme.git tags/nvme-6.15-2025-04-24

for you to fetch changes up to 3d7aa0c7b4e96cd460826d932e44710cdeb3378b:

  nvmet: fix out-of-bounds access in nvmet_enable_port (2025-04-22 09:50:28 +0200)

----------------------------------------------------------------
nvme fixes for Linux 6.15

 - fix an out-of-bounds access in nvmet_enable_port (Richard Weinberger)

----------------------------------------------------------------
Richard Weinberger (1):
      nvmet: fix out-of-bounds access in nvmet_enable_port

 drivers/nvme/target/core.c | 3 +++
 1 file changed, 3 insertions(+)
