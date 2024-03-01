Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E7DD3A27E
	for <linux-block@vger.kernel.org>; Fri,  1 Mar 2024 19:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709321202; cv=none; b=SrTt/66NgrlDvaIDO+9TPPOBLDo6rlPM+bR+sEfY99v/nH2hANzSot+/isB2zDr0BC2drh/kaK7tKu7OJrQ7h02oTeoDB3IG9LuGWpX1XvIwWt82tT1atfOhY/em1Cn1YbcbuioJePbkR6g9Q0MA+OSxs4s46Je1CrRO+02Wd5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709321202; c=relaxed/simple;
	bh=p3sdLKm4ZiHOkPeygm00kdzpL0rgjgOP67p7xkruR8c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nlrDdM0KIh76FlV075IOFodzJG1/WAAgAHujxXlHXwAEcTRSA9Mbp480WvCoXiFfH1FX6BL3Bs3gbFqL7e257iq3bJue5shGlQgZQzOH49BvEbV5mFe4eDe2pl1ebaLsOiWAPJW70jX1gvyiS/TnRByTYDEpXemHTul+QGM4rqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I8/9/QDv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I8/9/QDv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33CBAC433C7;
	Fri,  1 Mar 2024 19:26:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709321201;
	bh=p3sdLKm4ZiHOkPeygm00kdzpL0rgjgOP67p7xkruR8c=;
	h=From:To:Cc:Subject:Date:From;
	b=I8/9/QDvT/zm6ItyXlyOP17th6dNSd+WhNRwupBbOswIguebvBuy0OZZg8NNLQbVp
	 xCHl/ywig0ToypkJtSzJg1zEJM2DArTuat3PncjQ8ZjtbryDtlZLejZMwKfZj7y7Iq
	 WqHVmJKNRHYu5ChJgW3OHOtYsshqKOwy9a9lXniRE09OaOi5+PJ932KcGOfvJnsb88
	 QRmxUJUupmSOmRzZnB8W7WjaiqapYeqXWLK/YrgdQn0yLysOG82aveF4WDSiYkfmkB
	 PM+cguEKcquZiw2SxTYghpXGKWxVAVaiPALtMRUeaOJ81wekqACm9izCA2EciFH6ni
	 kmnrLpZa6w3BQ==
From: Damien Le Moal <dlemoal@kernel.org>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 0/3] queue limits cleanup
Date: Sat,  2 Mar 2024 04:26:36 +0900
Message-ID: <20240301192639.410183-1-dlemoal@kernel.org>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

One fix and 2 cleanups to go on top of Christoph's queue limits work.

Damien Le Moal (3):
  virtio_blk: Do not use disk_set_max_open/active_zones()
  block: Rename disk_set_zoned()
  block: Rename disk_set_max_open/active_zones()

 block/blk-settings.c       | 10 ++++------
 drivers/block/virtio_blk.c |  4 ++--
 drivers/nvme/host/zns.c    |  6 +++---
 drivers/scsi/sd.c          |  2 +-
 drivers/scsi/sd_zbc.c      |  6 +++---
 include/linux/blkdev.h     | 30 ++++++++++++++++--------------
 6 files changed, 29 insertions(+), 29 deletions(-)

-- 
2.44.0

