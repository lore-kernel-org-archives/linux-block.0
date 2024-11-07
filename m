Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF82215B0F2
	for <linux-block@vger.kernel.org>; Thu,  7 Nov 2024 06:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730961782; cv=none; b=EDo4vPPexQCJxGp2FTSsTolGt5r1Pmj6Cc9D38OsPeY6ECuKQQqOOh6Hu2rGAFdFg3+WEOfkZMV8bGIFI0MUkJLLv9IQzo3gGfVZETD7p3Zu9oriL5RED8ZMSEJAQliBLEcedYPnENnkuGIjfRZ/1f3sIWGzAbVJw/ca2GAsSbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730961782; c=relaxed/simple;
	bh=MHIJKBmWlYF45oYlY43KDIkcOJg42F3YxFPwupWR6Hc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=t3s1x4OEW+sOEG8Jq3kOJhEKkimHniq4HmE+OkYdTyNHPRUGNlQEf5WPnDzXAit+Gi91R9rwjgqZ1UZ0TGtiw3S9NjXGbLmV82cqlbF1Xjoo8qPNiqY7QETE+8UMV8OE8PvW/DLrWs8VbShX611jDnmQSysps4ozVgj22+eU8n4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QnYKuiOh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QnYKuiOh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C8F7C4CECC;
	Thu,  7 Nov 2024 06:43:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730961781;
	bh=MHIJKBmWlYF45oYlY43KDIkcOJg42F3YxFPwupWR6Hc=;
	h=From:To:Cc:Subject:Date:From;
	b=QnYKuiOhSI45IDFJ0+onr3ukA1JAeU/k3GL1LfZ3Sfn0xbNjOsJcYHwrw1lB1Vw3d
	 OnrOnALRKQAhJ2wwNLo0UGYvZZtuxy3DWw6K0nxZTAOnmdbObPk6VgsdNlc9IcIoRV
	 BC0eyvMkL+PaDB8cXbpTK6WkwWl0Z/p4wWRjdnYKcZsnRAbwaOvPik36IXpLAlOmDo
	 P31VjRKaAaHfMombbQm5yY2B7HajN3kS98W6K37yB5Q0BOKBE/ovuJ68AEd1GTvr0n
	 oKAF/jOmRHX6sOBMSxH2m5EUimhtgY9hzpJUwY77tP3a6LUPQQ+qnVoO7lqx8t0RFW
	 JSVwazH95Qojg==
From: Damien Le Moal <dlemoal@kernel.org>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>
Subject: [PATCH v2 0/2] Introduce bdev_zone_is_seq()
Date: Thu,  7 Nov 2024 15:42:58 +0900
Message-ID: <20241107064300.227731-1-dlemoal@kernel.org>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Allow file systems to safely access a block device gendisk bitmap of
conventional zones to determine a zone type by:
1) Patch 1 - changing the gendisk conv_zones_bitmap to be RCU protected
2) Patch 2 - Introducing the helper function bdev_zone_is_seq()

This is in preparation for use in btrfs to remove the btrfs-managed
bitmap of conventional zones and in zoned support for xfs.

Changes from v1:
 - Use rcu_dereference() in disk_zone_is_conv() (patch 1) and rebase
   patch 2, as suggested by Christoph.

Damien Le Moal (2):
  block: RCU protect disk->conv_zones_bitmap
  block: Add a public bdev_zone_is_seq() helper

 block/blk-zoned.c      | 42 ++++++++++++++++++++++++------------------
 include/linux/blkdev.h | 29 ++++++++++++++++++++++++++++-
 2 files changed, 52 insertions(+), 19 deletions(-)

-- 
2.47.0

