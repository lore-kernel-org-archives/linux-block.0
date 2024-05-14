Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BEFE181319
	for <linux-block@vger.kernel.org>; Tue, 14 May 2024 17:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715708356; cv=none; b=fftgBPnFripvEQbySuYpblIzGnM9GA8PVAw32Lq8zuA+EcRG7tK5iEb3X2peP6Q+qGoEi4qRV5a7ywd7UZ+XnvlQLA7KkzRNHHYGQtkDKC8OZx7zWDS6cFpWzDk21NraFEjJNStk9Jvztpwp5qnxVNW9b85SSp66hLUdZkaC+3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715708356; c=relaxed/simple;
	bh=/peSAZG0cb3BX+DST69d3XDZ+Ks8vx/0fVqM+mOIwq8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Q5/ET566k/Hh0xpPFnkwa3YaoZdwLmZLCOHhiUlXWIYpr9jJupIuXK4Ef09XNbpWPntJg09zp5Cu0FhBqomr8s7n/FgoBwuuUmxEbb+WEeE4ZgTQwIpdho7LtoRLIdBegvjOteCTwV06INfgLek4zlYE1di68kRaGX1JeoJ2zWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZaranJIs; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZaranJIs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91018C2BD10;
	Tue, 14 May 2024 17:39:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715708356;
	bh=/peSAZG0cb3BX+DST69d3XDZ+Ks8vx/0fVqM+mOIwq8=;
	h=From:To:Cc:Subject:Date:From;
	b=ZaranJIsD3CjnPayI//xhe97b/b2Wuro5rws+anPjSrkaC8btmIs/aL0HXe+tHE2Z
	 ga0kl4ua0ml4wksoeydFJARI/R94Dh5TEJ8kecxqW1oCjmiWRT8w6wq2um59f6JDGe
	 tyxpDWZN1MIv6hI6uqMIwyzrqMXnDOZtMWWN8OzwWM+H2uhMOdV9mK3Wg1g/9AD80n
	 atlUEQnN1JUdN9JAslIK3k9VKXwoWwE4YDMn9a6kSgDOTtaBwjsiKOJcGe+ztbrFOy
	 8V6jIrwM1mctqPOTC3kCgVy1TcxPh2ku2MWZZusVJaJ2wjd81nSlrrDYJumFvPPB1k
	 Pm7bPN5OI4Yqg==
From: Hannes Reinecke <hare@kernel.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: Matthew Wilcox <willy@infradead.org>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Pankaj Raghav <p.raghav@samsung.com>,
	linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@kernel.org>
Subject: [PATCHv2 0/6] enable bs > ps for block devices
Date: Tue, 14 May 2024 19:38:54 +0200
Message-Id: <20240514173900.62207-1-hare@kernel.org>
X-Mailer: git-send-email 2.35.3
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi all,

based on the patch series from Pankaj '[PATCH v5 00/11] enable bs > ps in XFS'
it's now quite simple to enable support for block devices with block sizes
larger than page size even without having to disable CONFIG_BUFFER_HEAD.
The patchset really is just two rather trivial patches to fs/mpage,
and two patches to remove hardcoded restrictions on the block size.

As usual, comments and reviews are welcome.

Changes to the original submission:
- Include reviews from Matthew
- Include reviews from Luis
- Fixup crash in bio_split()

Hannes Reinecke (5):
  fs/mpage: avoid negative shift for large blocksize
  fs/mpage: use blocks_per_folio instead of blocks_per_page
  blk-merge: split bio by max_segment_size, not PAGE_SIZE
  block/bdev: enable large folio support for large logical block sizes
  block/bdev: lift restrictions on supported blocksize

Pankaj Raghav (1):
  nvme: enable logical block size > PAGE_SIZE

 block/bdev.c             | 11 ++++++---
 block/blk-merge.c        |  3 ++-
 drivers/nvme/host/core.c |  8 +++----
 fs/mpage.c               | 49 +++++++++++++++++++---------------------
 4 files changed, 37 insertions(+), 34 deletions(-)

-- 
2.35.3

