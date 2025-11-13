Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 173B920C029
	for <linux-block@vger.kernel.org>; Thu, 13 Nov 2025 13:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763041467; cv=none; b=Nm5D3P+cHZIVguAKrtI2hykZoPYPGYuWxyKdd9RocXGP+u4ML6jkOWzangzw7gqx4YQ+Tru2X+PVHOPhCQMfJi5AojfdJpB6JMfuT0p5A29pniVO+eRimOgUCHHwP8fSCS+/x9i5bCPSi4TkrCaH2soK/Gxvotpc/w7TbkZMqZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763041467; c=relaxed/simple;
	bh=3Fl45ymwJwuXah0MNMAXmnrqo2XIzARnPaeZ5lkO5rU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SH4GH0gYcKrNH8q8pJBufY3WQHUyuhUbGkV8OjaWMbok50Rq7FesoW8IoDgJa64W1lYzxn8ZvYhlyQcigFsq0vsgVN2lAzX4izW3LPB4rB1gF51n7zjaD8pHuBk4FNd0BECDx8NDFIJRAmc2Rn/Ae77WX3+g0F5/bsoKQm8HwrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TSkjOteK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TSkjOteK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5BE6C4CEF1;
	Thu, 13 Nov 2025 13:44:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763041466;
	bh=3Fl45ymwJwuXah0MNMAXmnrqo2XIzARnPaeZ5lkO5rU=;
	h=From:To:Cc:Subject:Date:From;
	b=TSkjOteKQR+Yp3z9xf9DjLTVCmkCUqNAzM8QunoIA3of1/ma+v5yyn4Mq2Sr+Yccm
	 +EG0oCsNkkEclUrOC6FiqvUC4QNIwofydl35CF9/OsSx/UKbFNOrlFErrZ7acVLILM
	 RNnsK5sfIrEstaCOHa5bsE5/O7TiHJ70DKn6KrYJP1RdCIRwoWwxXXblDLMrCLP/yx
	 TaYzhm06z5NrVqoyBlcIzFNha2Y29WEVC3X3tNFxMiBlB3We0y92XZcGaehOGWXZvt
	 rFXw/RlbYPTrYj0ojU2hhdQiEmzlnCV+tTrPCMJSO+rAy0OVzYAdQP4Ho1oUGuGiMS
	 c1O+KeUxGabZQ==
From: Damien Le Moal <dlemoal@kernel.org>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	Christoph Hellwig <hch@lst.de>
Subject: [PATCH 0/3] Fixes for zoned changes in block/for-next
Date: Thu, 13 Nov 2025 22:40:25 +0900
Message-ID: <20251113134028.890166-1-dlemoal@kernel.org>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Jens,

Here are 3 patches to fix 2 oops (NULL pointer dereference) and a device
mapper regression all introduced by the recent changes to blk-zoned.c
that are in block/for-next.

These are relatively simple problems that should have been discovered
right away during development. I overlooked them due to some issues (now
fixed) with my test VM environment which was not always running the
correct kernel.

Damien Le Moal (3):
  block: fix NULL pointer dereference in blk_zone_reset_all_bio_endio()
  block: fix NULL pointer dereference in disk_report_zones()
  dm: fix zone reset all operation processing

 block/blk-zoned.c    | 23 +++++++++++++----------
 drivers/md/dm-zone.c |  9 +++++++++
 2 files changed, 22 insertions(+), 10 deletions(-)

-- 
2.51.1

