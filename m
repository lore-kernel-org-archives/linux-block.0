Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 191F32F1FF1
	for <linux-block@vger.kernel.org>; Thu, 26 Jun 2025 13:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750943748; cv=none; b=sI0aRly5YHToRvazjiY1eJmmfPHsojNpoBIyeJhf8V84uNsybfIjh86KoFn9BUCEhvTgRRXX5koiR4qe3nQBymR8kKI1Grvz423GQR5BIQMZkwAp6GexIVYp5j4aFsmGj87Sf00K435SDwNCBCn+0RzMr3Wg0t4vNkr9nll9dIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750943748; c=relaxed/simple;
	bh=XAQ7KY0fglIm8n1j4XSSmF2XZl9vi19TF2J6AAZGqwA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=ichQpX/YL6k9SSV7ooSJKHK8deeJOGft3GRII7n3hevM/RDso9qhT8MmYiUhXDULZxWQUcD7wv6rETU+PNweeb62x/on4anIQN1PohcmuwIU8oOQICk+gwNDnnRX9DA8oadncag0G3fiu2Sr9TKcdL9BHge7j8VXXNoCz5tazFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Ikfzah+n; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Ikfzah+n"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Type:MIME-Version:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=Hl2AecGxpLcBXJzUH+GHlQKWZ1rBYMu0o0Q5xXYl65o=; b=Ikfzah+nin9iK0bNLhGw3AxF2+
	Kb38ErfGgXEMboQvE8yKJjj33ZvIGnxh+SYbnG1xUzkBeXleH2E3AVxfsWU4dCT1hZ5UKpjt/N8Yc
	mPbLCVz915MgB+7zH6C6/CYGxhkOM4nAb4OzCBZkqIb6XEAK6KWy42s1EaeE37bT1JRppAKlArQSB
	LfOnGeZWBX+NUAlv1IGxP7JjBsEcnu9QNljPo4ahnqEx6A2Ly/l1a97FrOMICIhjESuIZfQFojL4H
	orqAD2xOrxmeuOK3VeW5CKo0ZpJuJFqevXuwaNIKTu0PoWknPgFv/RPYml0N+m0S8m+1DKWlIYS9Y
	Sg70TWXg==;
Received: from 2a02-8389-2341-5b80-d601-7564-c2e0-491c.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:d601:7564:c2e0:491c] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uUmS9-0000000BdZH-49wO;
	Thu, 26 Jun 2025 13:15:46 +0000
Date: Thu, 26 Jun 2025 15:15:43 +0200
From: Christoph Hellwig <hch@infradead.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@fb.com>, Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>, linux-nvme@lists.infradead.org
Subject: [GIT PULL, resend] nvme updates for Linux 6.16
Message-ID: <aF1H_345SuVYxoCW@infradead.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

[note that the commit dates are very recent.  That is because somehow the
tree the ran through the build bot had me as the author for the commit
from Keith, so I did a metadata only rebase just now to fix that]

The following changes since commit 4c8a951787ffc4b61a547db9866196104971b5fd:

  ublk: setup ublk_io correctly in case of ublk_get_data() failure (2025-06-24 20:45:31 -0600)

are available in the Git repository at:

  git://git.infradead.org/nvme.git tags/nvme-6.16-2025-06-26

for you to fetch changes up to f46d273449ba65afd53f3dd8fe0182c9df877e08:

  nvme: fix atomic write size validation (2025-06-26 13:04:37 +0200)

----------------------------------------------------------------
nvme fixes for Linux 6.16

 - reset delayed remove_work after reconnect (Keith Busch)
 - fix atomic write size validation (Christoph Hellwig)

----------------------------------------------------------------
Christoph Hellwig (2):
      nvme: refactor the atomic write unit detection
      nvme: fix atomic write size validation

Keith Busch (1):
      nvme: reset delayed remove_work after reconnect

 drivers/nvme/host/core.c      | 87 +++++++++++++++++++++----------------------
 drivers/nvme/host/multipath.c |  2 +-
 drivers/nvme/host/nvme.h      |  3 +-
 3 files changed, 44 insertions(+), 48 deletions(-)
