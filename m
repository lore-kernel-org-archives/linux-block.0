Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0BA223C8C5
	for <linux-block@vger.kernel.org>; Tue,  9 Sep 2025 08:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757406576; cv=none; b=lAhJ78eEEmjDHEKmsdVV0AMmSah2114luiwV+gDUoDabbrTv9kXdfiTECqQv48hDTcX6X8wUwtFpuDnRlLp07EfRsn3iyvy9dQrgBzw9VpRlPuZceHdqTpINOqDSLIXp+Wv50SArsnaDWGHXjx5dlqNcNX85TnFGhiGPgWNco2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757406576; c=relaxed/simple;
	bh=UpoCA8s0Bh3yBA1TF/TRG1rkvoCDyfYWncHgYjrz6/g=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=gWE0+73PRQkrrIQyLiEX67s7IUlkfjoNcpaF12EcNbuapEeshvIZvVeHv534PomfjLlMS0dqSiUyDLXXgCin4Apmqm/sYJLv47KHSPmOinp0SO/sBRyweCAiKqDeS0vWbgK4UyXcH4VQqWrM8xPLhZS66muBJp9ln80aXNEux4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4cLcS902skzKHN1C;
	Tue,  9 Sep 2025 16:29:29 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 2B0951A1838;
	Tue,  9 Sep 2025 16:29:29 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP4 (Coremail) with SMTP id gCh0CgCX4o5l5b9oNiugBw--.25078S4;
	Tue, 09 Sep 2025 16:29:26 +0800 (CST)
From: Yu Kuai <yukuai1@huaweicloud.com>
To: axboe@kernel.dk,
	linux-block@vger.kernel.org,
	inux-raid@vger.kernel.org,
	song@kernel.org
Cc: linan122@huawei.com,
	xni@redhat.com,
	colyli@kernel.org,
	yukuai3@huawei.com,
	yukuai1@huaweicloud.com,
	yi.zhang@huawei.com,
	yangerkun@huawei.com,
	johnny.chenyi@huawei.com
Subject: [GIT PULL] md-6.17-20250909
Date: Tue,  9 Sep 2025 16:20:05 +0800
Message-Id: <20250909082005.3005224-1-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgCX4o5l5b9oNiugBw--.25078S4
X-Coremail-Antispam: 1UD129KBjvJXoWxAr48XF45CFWDWF1kZFWxCrg_yoW5Aw13pa
	9xt343Ww15JF47XF13JFyUAF1Fqr1ktF9xKr97Gw4rWFyDZFn8Jr48GF18A34jgry7JF1D
	Jr15Jr1UWr1UXaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9014x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
	6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628v
	n2kIc2xKxwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7x
	kEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E
	67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCw
	CI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1x
	MIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIda
	VFxhVjvjDU0xZFpf9x0JUd-B_UUUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

Hi, Jens

Please consider pulling following changes on your for-6.18/block branch,
this pull request contains:

 - add kconfig for internal bitmap;
 - introduce new experimental feature lockless bitmap;

Thanks,
Kuai

The following changes since commit ba28afbd9eff2a6370f23ef4e6a036ab0cfda409:

  blk-mq: fix blk_mq_tags double free while nr_requests grown (2025-09-05 13:52:52 -0600)

are available in the Git repository at:

  https://kernel.googlesource.com/pub/scm/linux/kernel/git/mdraid/linux.git tags/md-6.18-20250909

for you to fetch changes up to 5ab829f1971dc99f2aac10846c378e67fc875abc:

  md/md-llbitmap: introduce new lockless bitmap (2025-09-06 17:27:51 +0800)

----------------------------------------------------------------
Yu Kuai (24):
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

 Documentation/admin-guide/md.rst |   86 +++++---
 drivers/md/Kconfig               |   29 +++
 drivers/md/Makefile              |    4 +-
 drivers/md/dm-raid.c             |   18 +-
 drivers/md/md-bitmap.c           |   89 ++++----
 drivers/md/md-bitmap.h           |  107 +++++++++-
 drivers/md/md-cluster.c          |    2 +-
 drivers/md/md-llbitmap.c         | 1626 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 drivers/md/md.c                  |  378 +++++++++++++++++++++++++++-------
 drivers/md/md.h                  |   24 ++-
 drivers/md/raid1-10.c            |    2 +-
 drivers/md/raid1.c               |   79 ++++---
 drivers/md/raid10.c              |   49 ++---
 drivers/md/raid5.c               |   64 ++++--
 14 files changed, 2313 insertions(+), 244 deletions(-)
 create mode 100644 drivers/md/md-llbitmap.c

