Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 966DB16C6A9
	for <linux-block@vger.kernel.org>; Fri, 10 May 2024 10:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715336972; cv=none; b=nfPJpILdsn+tH0F89zfT9py1tsqLZlUG52xdUVI9mv1wDij/SpJgOk1SX1YjlrzxigxrDOYP3e7dHP/To2Iszl4ZGIidofO7LiJQQTfqc/B4npb6T5mLVtckWGpzpaddTELAfFGix9YmJmyD0c4/X29raLo5IxXMi6psZ3tdkKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715336972; c=relaxed/simple;
	bh=8lGQFIvKfDwehzESNqCctgvMERNI8590PmNeL44Ggw4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=TuxSWBhqIpErupRPPS5lg+qPhkJqth547NbNCl3ULZvPFA/u9FUywT+7TWcdsUN0/7QynEKkTpJf5hrLxNJmCSWY5ckjxY9AO2OI+whXXxn7IOJYwEU8p4s0ghnWayHMfnm52jrlcxlylbqv+zDIfC4H+j7eblb3Fz7CysmA2iY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dsuabjDd; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dsuabjDd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DB50C32781;
	Fri, 10 May 2024 10:29:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715336971;
	bh=8lGQFIvKfDwehzESNqCctgvMERNI8590PmNeL44Ggw4=;
	h=From:To:Cc:Subject:Date:From;
	b=dsuabjDdR6iK8RvinEKBVFeGJ+bTIjD1UL3hRWTpI7EWgK4+2WRwQtkUBWzY4ixjO
	 7LWaYM3uKO0ek2gM1Vex/RTSpihMEc1yl67IF4Yb7ni7sDkJ8jQd3iOkArwZExIlod
	 cf26rjbkQm5Ov+p3tP5lZiOG89pT5LFNvFrrdguCDfw4So9ThhFAfmqOwmNuzwPXSF
	 bu5LudWZU7XJLJJTelchtuPfDFvdjnb027rQWukoLOFe33JXG7NhVjh+aFk48zS1Co
	 J9PPfm3DPDNFaKu1xT8ruZvTql2cy9KcM4eLSzg41v+FvY5QE/VVj0g3goVNU/2dwr
	 P03LRrecbSiEg==
From: hare@kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Matthew Wilcox <willy@infradead.org>,
	Pankaj Raghav <kernel@pankajraghav.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org,
	Hannes Reinecke <hare@kernel.org>
Subject: [PATCH 0/5] enable bs > ps for block devices
Date: Fri, 10 May 2024 12:29:01 +0200
Message-Id: <20240510102906.51844-1-hare@kernel.org>
X-Mailer: git-send-email 2.35.3
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Hannes Reinecke <hare@kernel.org>

Hi all,

based on the patch series from Pankaj '[PATCH v5 00/11] enable bs > ps in XFS'
it's now quite simple to enable support for block devices with block sizes
larger than page size even without having to disable CONFIG_BUFFER_HEAD.
The patchset really is just two rather trivial patches to fs/mpage,
and two patches to remove hardcoded restrictions on the block size.

As usual, comments and reviews are welcome.

Hannes Reinecke (4):
  fs/mpage: use blocks_per_folio instead of blocks_per_page
  fs/mpage: avoid negative shift for large blocksize
  block/bdev: lift restrictions on supported blocksize
  block/bdev: enable large folio support for large logical block sizes

Pankaj Raghav (1):
  nvme: enable logical block size > PAGE_SIZE

 block/bdev.c             | 10 ++++++---
 drivers/nvme/host/core.c |  7 +++----
 fs/mpage.c               | 44 ++++++++++++++++++++--------------------
 3 files changed, 32 insertions(+), 29 deletions(-)

-- 
2.35.3

