Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA9A833993
	for <linux-block@vger.kernel.org>; Sun,  3 Aug 2025 05:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754197916; cv=none; b=KvQHwQHKEyIsGMp+hscmHWfF8i/E5G8xXbotLbvGigHlLWllHfRns08PGJib8SyKE/5QsjTlypYbV10fV4nbjW6C4HS/eJPcEY3hotdnH4xsVslLZpOj2M1ZeUjxwh3OEnX06VtpjPx8LlhdnrS2VzoRkGFO+IcRHcfyWoKb3Fg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754197916; c=relaxed/simple;
	bh=/8sebOgOgONN5T2h+5tjrUNiuFKdd8V3LV3ltmXJYfs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DwgRF12qxAb/tfPJycc+KgusnAys3sOvi5cT/9lH0YOu+NyUD63FNwxNl5icHqcEgjpG5//TYSf04mU0bicgmaoTnjXQedPI0mmkvCe1MbAqL1C6DbXdt6eWiJZgC2V9MeKo95t7gTMMYqRHe9S5apZ+klPMjE3ETZfAq54FpFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MOdmWMGk; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MOdmWMGk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D147FC4CEEB;
	Sun,  3 Aug 2025 05:11:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754197916;
	bh=/8sebOgOgONN5T2h+5tjrUNiuFKdd8V3LV3ltmXJYfs=;
	h=From:To:Cc:Subject:Date:From;
	b=MOdmWMGkUdL5Sqlex+4U1BQJ26ayWNfWIZXHp9UAtCBZmFcTUTWB+Pocg30wbwyTc
	 y2q4jp5bGpmMBKwvAdCpx709dhsXGi/ahlzFIKiOT+LA8uxFwIfCy9ywB0hbQYlzAi
	 p7vzG54sOwB/KD7rNu5cP1NiaaMYO9qWgFLg0n9fGv1BVoJw3kye7lv029haGssdOs
	 VL8QuhTXId/ikx5yIPatkl0ajt2fkyT/VuYL6vwf/uIlz80v2ppZpiVTLbY+wfpjxw
	 K4qd/xfbkP8r5p81A+NQvCeWdxEHE2axee/+YZxntvEUxC8KwFWSCDgzhqCZEZdsTN
	 7txJ6hSZXTnDg==
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
	heming.zhao@suse.com,
	linan122@huawei.com,
	wangjinchao600@gmail.com
Subject: [GIT PULL] md-6.17-20250803 v2
Date: Sun,  3 Aug 2025 13:11:45 +0800
Message-ID: <20250803051145.2861-1-yukuai@kernel.org>
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

- mddev null-ptr-dereference fix, by Erkun
- md-cluster fail to remove the faulty disk regression fix, by Heming
- minor cleanup, by Li Nan and Jinchao
- mdadm lifetime regression fix reported by syzkaller, by Yu Kuai

The following changes since commit 5421681bc3ef13476bd9443379cd69381e8760fa:

  blk-ioc: don't hold queue_lock for ioc_lookup_icq() (2025-07-29 06:26:34 -0600)

are available in the Git repository at:

  git@gitolite.kernel.org:pub/scm/linux/kernel/git/mdraid/linux.git tags/md-6.17-20250803

for you to fetch changes up to 13017b427118f4311471ee47df74872372ca8482:

  md: make rdev_addable usable for rcu mode (2025-08-03 13:08:18 +0800)

----------------------------------------------------------------
Heming Zhao (1):
      md/md-cluster: handle REMOVE message earlier

Li Nan (1):
      md: rename recovery_cp to resync_offset

Wang Jinchao (2):
      md/raid1: change r1conf->r1bio_pool to a pointer type
      md/raid1: remove struct pool_info and related code

Yang Erkun (1):
      md: make rdev_addable usable for rcu mode

Yu Kuai (1):
      md: fix create on open mddev lifetime regression

 drivers/md/dm-raid.c           | 42 +++++++++++++++++------------------
 drivers/md/md-bitmap.c         |  8 +++----
 drivers/md/md-cluster.c        | 16 +++++++-------
 drivers/md/md.c                | 73 ++++++++++++++++++++++++++++++++++++-------------------------
 drivers/md/md.h                |  2 +-
 drivers/md/raid0.c             |  6 ++---
 drivers/md/raid1-10.c          |  2 +-
 drivers/md/raid1.c             | 94 ++++++++++++++++++++++++++++++-------------------------------------------------
 drivers/md/raid1.h             | 22 +------------------
 drivers/md/raid10.c            | 16 +++++++-------
 drivers/md/raid5-ppl.c         |  6 ++---
 drivers/md/raid5.c             | 30 ++++++++++++-------------
 include/uapi/linux/raid/md_p.h |  2 +-
 13 files changed, 145 insertions(+), 174 deletions(-)
