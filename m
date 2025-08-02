Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D63813A3ED
	for <linux-block@vger.kernel.org>; Sat,  2 Aug 2025 17:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754155513; cv=none; b=uHc0PF7oTwPg61VeLe+wvyCJD21UDF3Sfjfgj43cVg3pKZ/LeMOxpbhru0njGnQ4vawNUngprKzJ76uVuBpEtm6BAI8DyKKIVq69PTs2HTqJiGJArodUeDTJ/rl95HpExskzyyJLwcoyv/6k7RnzNlpxdHgD5YcPgzdcTQ9XtEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754155513; c=relaxed/simple;
	bh=Bt9db7+gRuqZoKI0vwE6s7LADLy0G8QvlSEupth6Kro=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=k7eOiWAiHDDwnikzWkHiy75YmoSE5FBLLXnRyQd2uDaU46QjnTMDlOY9XEEBXmnx9Br0D49wwQy0YSU1OT8rLpdglTu5bNFMXUAJSj9WPTkPoLysjGHsfxoxzr4ZivbvLfX6NpCob6QMojKGnkJFmwO2t1/f8TN/1C00fj7t07Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d5UpSLnC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d5UpSLnC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 346BEC4CEEF;
	Sat,  2 Aug 2025 17:25:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754155512;
	bh=Bt9db7+gRuqZoKI0vwE6s7LADLy0G8QvlSEupth6Kro=;
	h=From:To:Cc:Subject:Date:From;
	b=d5UpSLnCrT8+H2N3dzNVaYuHfSHeetGpPg3qyRaohrp+fvXiZhDLSPOFtpwZPhygf
	 gqdaY+JintZbL5TVkjSzQ+DSGEA/JPvsoxrj/kmti82PvKYZxwIyw/pxJsXu1BV8AU
	 PDDDbCgVZMHgAEO7/y5pyT7Hd8s7bZ9O6Uwj8BCPsFrxxsNYxicsXsUjawVUYJjeFK
	 saAgn4PO5vKj3R44ACA/pyedHgw5h/H96tY+LTCBWGGmxSTrn8XQHrVEkZ1QnSx7jn
	 /3AquCVWm1gWnJzMsBXQqqMlSyfXaKDsgPpRmGi7J7EImSQq3VunGuVlV/mUAk0Rzy
	 Jux1eS8r6B2Sg==
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
	linan122@huawei.com
Subject: [GIT PULL] md-6.17-20250803
Date: Sun,  3 Aug 2025 01:25:07 +0800
Message-ID: <20250802172507.7561-1-yukuai@kernel.org>
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
- minor cleanup, by Li Nan
- mdadm lifetime regression fix reported by syzkaller, by Yu Kuai
- experimental feature: introduce new lockless bitmap, by Yu Kuai

The following changes since commit 5421681bc3ef13476bd9443379cd69381e8760fa:

  blk-ioc: don't hold queue_lock for ioc_lookup_icq() (2025-07-29 06:26:34 -0600)

are available in the Git repository at:

  git@gitolite.kernel.org:pub/scm/linux/kernel/git/mdraid/linux.git tags/md-6.17-20250803

for you to fetch changes up to 4577894894b9c94fdd2670e3a644a971e1cd6721:

  md/md-llbitmap: introduce new lockless bitmap (2025-08-03 01:02:00 +0800)

----------------------------------------------------------------
Heming Zhao (1):
      md/md-cluster: handle REMOVE message earlier

Li Nan (1):
      md: rename recovery_cp to resync_offset

Yang Erkun (1):
      md: make rdev_addable usable for rcu mode

Yu Kuai (27):
      md: fix create on open mddev lifetime regression
      md/raid1: change r1conf->r1bio_pool to a pointer type
      md/raid1: remove struct pool_info and related code
      md/md-bitmap: remove the parameter 'init' for bitmap_ops->resize()
      md/md-bitmap: merge md_bitmap_group into bitmap_operations
      md/md-bitmap: add a new parameter 'flush' to bitmap_ops->enabled
      md/md-bitmap: add md_bitmap_registered/enabled() helper
      md/md-bitmap: handle the case bitmap is not enabled before start_sync()
      md/md-bitmap: handle the case bitmap is not enabled before end_sync()
      md/raid1: check bitmap before behind write
      md/raid1: check before referencing mddev->bitmap_ops
      md/raid10: check before referencing mddev->bitmap_ops
      md/raid5: check before referencing mddev->bitmap_ops
      md/dm-raid: check before referencing mddev->bitmap_ops
      md: check before referencing mddev->bitmap_ops
      md/md-bitmap: introduce CONFIG_MD_BITMAP
      md: add a new parameter 'offset' to md_super_write()
      md: factor out a helper raid_is_456()
      md/md-bitmap: support discard for bitmap ops
      md: add a new mddev field 'bitmap_id'
      md/md-bitmap: add a new sysfs api bitmap_type
      md/md-bitmap: delay registration of bitmap_ops until creating bitmap
      md/md-bitmap: add a new method skip_sync_blocks() in bitmap_operations
      md/md-bitmap: add a new method blocks_synced() in bitmap_operations
      md: add a new recovery_flag MD_RECOVERY_LAZY_RECOVER
      md/md-bitmap: make method bitmap_ops->daemon_work optional
      md/md-llbitmap: introduce new lockless bitmap

 Documentation/admin-guide/md.rst |   86 +-
 drivers/md/Kconfig               |   29 +
 drivers/md/Makefile              |    4 +-
 drivers/md/dm-raid.c             |   60 +-
 drivers/md/md-bitmap.c           |   97 ++-
 drivers/md/md-bitmap.h           |  107 ++-
 drivers/md/md-cluster.c          |   18 +-
 drivers/md/md-llbitmap.c         | 1596 ++++++++++++++++++++++++++++++++++++++
 drivers/md/md.c                  |  418 +++++++---
 drivers/md/md.h                  |   26 +-
 drivers/md/raid0.c               |    6 +-
 drivers/md/raid1-10.c            |    4 +-
 drivers/md/raid1.c               |  173 ++---
 drivers/md/raid1.h               |   22 +-
 drivers/md/raid10.c              |   65 +-
 drivers/md/raid5-ppl.c           |    6 +-
 drivers/md/raid5.c               |   66 +-
 include/uapi/linux/raid/md_p.h   |    2 +-
 18 files changed, 2375 insertions(+), 410 deletions(-)
 create mode 100644 drivers/md/md-llbitmap.c
