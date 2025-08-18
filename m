Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C389226F299
	for <linux-block@vger.kernel.org>; Mon, 18 Aug 2025 17:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755536406; cv=none; b=GmxoIjEE1RUf6p0+IigxEF2sRk5MQWXt1naCwtWQl4OmfE2q4ZFOAX93iTh+hb5mRcGrItqep3HaTycCqQVG+kdsDB8ju88S/tWND268ubkTd8VcuJt5FbKjzgda5hXj2N4TjdHZilWk6pX1y5GkN8/8CmWI81//6HCINRXJhTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755536406; c=relaxed/simple;
	bh=+7tyVq9rAT3kUyEQvxIqHRAsaVe0bRqPYD3VfuMSFko=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mxor+cAxF+fTh3Sj/qiLMcFNFfdB2ddKOf0eufl/rHQufULZHHoKhlYlgYsYcPE0u4b3JLfC1HGzpVRl42nRemdX6YLbe5MxcJzU3CDXezWnrWuT6JPLrqskSv0/Awk6eqiM6K1mBvX+AGX5TgAK5v+n+uOv0WBdKt9GC5IGSC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nDKanoht; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nDKanoht"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2B53C4CEEB;
	Mon, 18 Aug 2025 17:00:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755536406;
	bh=+7tyVq9rAT3kUyEQvxIqHRAsaVe0bRqPYD3VfuMSFko=;
	h=From:To:Cc:Subject:Date:From;
	b=nDKanoht2AEfGvz8hdnxR1brZ6hOMooXoJKuzPYPpJSqtwTFISlJGAzpnlVOI5Cmw
	 CA5w2Ib83a44joh/Q9o62AuJHZq7cAeYnxN5q7xKCWqD5/R9LsRMtYbu9avKhgZpUZ
	 BbJ/Fc/WrEagDPq9VAOFg/n6yUdj2d3E0En7Zo3rLvUAab3ejwFA9FRe8n25WjMUIg
	 9J5tF487tILfCChdOq6MJ77baOKx1alf7zlIpXsQh0d2T4yVaDSFhiYYoBwQqEUHzK
	 8ITlFVuUbpo9AT30aNxNYwB+KJzgiisQKpr8WuEBG5tcpmql3ldJXKuUyB0/F7oHDf
	 ctgyKtN+X242A==
From: Yu Kuai <yukuai@kernel.org>
To: axboe@kernel.dk,
	linux-block@vger.kernel.org,
	inux-raid@vger.kernel.org,
	song@kernel.org
Cc: yukuai3@huawei.com,
	yangerkun@huawei.com,
	yi.zhang@huawei.com,
	johnny.chenyi@huawei.com,
	xni@redhat.com,
	zhengqixing@huawei.com
Subject: [GIT PULL] md-6.17-20250819
Date: Tue, 19 Aug 2025 00:59:59 +0800
Message-ID: <20250818165959.232541-1-yukuai@kernel.org>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi, Jens

Please consider pulling following changes on your block-6.17 branch,
this pull request contains:

- add a legacy_async_del_gendisk mode, to prevent user tools regression,
  new user tools release will not use such mode, the old release with new
  kernel now will have warning about deprecate behavior, and we prepare to
  remove this legacy mode after about a year later;
- the rename in kernel causing user tools build failure, revert the rename
  in mdp_superblock_s;
- fix a regression that interrupted resync can be shown as recover from
  mdstat or sysfs;

The following changes since commit 0452f08395f8e7d04fe3744443dad396b3330d0c:

  blk-wbt: doc: Update the doc of the wbt_lat_usec interface (2025-08-11 10:21:38 -0600)

are available in the Git repository at:

  git@gitolite.kernel.org:pub/scm/linux/kernel/git/mdraid/linux.git tags/md-6.17-20250819

for you to fetch changes up to b7ee30f0efd12f42735ae233071015389407966c:

  md: fix sync_action incorrect display during resync (2025-08-16 08:52:33 +0800)

----------------------------------------------------------------
Xiao Ni (2):
      md: add legacy_async_del_gendisk mode
      md: keep recovery_cp in mdp_superblock_s

Zheng Qixing (2):
      md: add helper rdev_needs_recovery()
      md: fix sync_action incorrect display during resync

 drivers/md/md.c                | 122 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++------------------------------
 include/uapi/linux/raid/md_p.h |   2 +-
 2 files changed, 93 insertions(+), 31 deletions(-)

