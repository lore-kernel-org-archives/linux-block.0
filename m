Received: from sg-1-11.ptr.blmpb.com (sg-1-11.ptr.blmpb.com [118.26.132.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC7A860B8A
	for <linux-block@vger.kernel.org>; Tue, 11 Nov 2025 03:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=118.26.132.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762832153; cv=none; b=eXCot91mu3n0B/3fG1h/9IjJT8Ju2cum8V7QzZ9gfzGsJjxppZ8wAylvfb8CsJsosiCuoe4E/AmPC1nYbmR7wyPnW2BbzK5r3A2XD7kQpKuG3fyGvXyl0o49xiU7wCWTu/sKqfGGfBjtxUxQE5Fq/LkyG6aP5dXVpBblSylAvgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762832153; c=relaxed/simple;
	bh=p6aYua9kJxOLKWhrpeXWKWUipFf2jbmyS+Z7gjvk6Mk=;
	h=Subject:Date:Message-Id:Content-Type:To:Cc:From:Mime-Version; b=N8IsW35tadkczVJUcmbiUn+Os3Uu+HIibtxtIAa+tAXDTMu4ig3jHgL589eHNxNYF6FOM4tjKZqQUfDJFSHHHNHiOrcJonO9arLXg5wfwC9Chcc82vjA9htgxODqjhgdQvzOa+JQT1EIShyV45bzily6HS5iUh0JJOkLQIXM2sU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fnnas.com; spf=none smtp.mailfrom=fnnas.com; dkim=pass (2048-bit key) header.d=fnnas-com.20200927.dkim.feishu.cn header.i=@fnnas-com.20200927.dkim.feishu.cn header.b=DdAepbAy; arc=none smtp.client-ip=118.26.132.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fnnas.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=fnnas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fnnas-com.20200927.dkim.feishu.cn header.i=@fnnas-com.20200927.dkim.feishu.cn header.b="DdAepbAy"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=s1; d=fnnas-com.20200927.dkim.feishu.cn; t=1762832139;
  h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=sY2AGwyPnUFx1ZWNLbYpUBJOjEJIvg2hMRs/X0DaAyI=;
 b=DdAepbAyaskBc7DD3bi0h0ymCqffvv/X9yWa0M+Qz5GIgvMKh4FskYLlXZJu+I4ESSrqp4
 iR5VIhshwtZ3G3A9g3SPLxOnZdtD1w1B7rxNr/orryws4YYKUV7RJ0AFv4U9OdlZCp3XUQ
 UOBovn+9uv/QG4EmIX2mQ3E8bebJ/ZYctZ4Gx40kL+/ol/aSCPzawG9XrYaO50239uwZlp
 Jgx1u1FvHrtcxxPfHZlTYE/eC95pBpbcF6cYdgqTpYG9V+XgxeEq3WswPS4IxhWq8W+AYT
 NCKQPycOOruYZ/MRIHTiZTRxNMUR80y1qHjEFuIHHoljZsTayEdzx3+EzyCiqQ==
Subject: [GIT PULL] md-6.19-20251111
Date: Tue, 11 Nov 2025 11:35:29 +0800
Message-Id: <20251111033529.2178410-1-yukuai@fnnas.com>
Received: from linux ([39.182.0.168]) by smtp.feishu.cn with ESMTPS; Tue, 11 Nov 2025 11:35:36 +0800
X-Lms-Return-Path: <lba+26912af09+473410+vger.kernel.org+yukuai@fnnas.com>
X-Original-From: Yu Kuai <yukuai@fnnas.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=UTF-8
To: <axboe@kernel.dk>, <linux-block@vger.kernel.org>, 
	<linux-raid@vger.kernel.org>
Cc: <yukuai@fnnas.com>, <linan122@huawei.com>, <hehuiwen@kylinos.cn>, 
	<xni@redhat.com>, <nichen@iscas.ac.cn>, <john.g.garry@oracle.com>, 
	<wuguanghao3@huawei.com>, <yun.zhou@windriver.com>
From: "Yu Kuai" <yukuai@fnnas.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0

Hi, Jens

Please consider pulling following changes on your for-6.19/block branch,
this pull request contain:

- change maintainer's email address (Yu Kuai)
- data can be lost if array is created with different lbs devices, fix
  this problem and record lbs of the array in metadata (Li Nan)
- fix rcu protection for md_thread (Yun Zhou)
- fix mddev kobject lifetime regression (Xiao Ni)
- enable atomic writes for md-linear (John Garry)
- some cleanups (Chen Ni, Huiwen He, Wu Guanghao)

Thanks,
Kuai

The following changes since commit 25976c314f6596254c9b1e2291d94393b7d5ae81:

  block: introduce bdev_zone_start() (2025-11-07 09:28:08 -0700)

are available in the Git repository at:

  git@gitolite.kernel.org:pub/scm/linux/kernel/git/mdraid/linux.git tags/md-6.19-20251111

for you to fetch changes up to 62ed1b58224636185fa689db81224b8c8af46473:

  md: allow configuring logical block size (2025-11-11 11:20:15 +0800)

----------------------------------------------------------------
Chen Ni (1):
      md/md-llbitmap: Remove unneeded semicolon

Huiwen He (1):
      md/raid5: remove redundant __GFP_NOWARN

John Garry (1):
      md/md-linear: Enable atomic writes

Li Nan (6):
      md: prevent adding disks with larger logical_block_size to active arrays
      md: delete md_redundancy_group when array is becoming inactive
      md: init bioset in mddev_init
      md/raid0: Move queue limit setup before r0conf initialization
      md: add check_new_feature module parameter
      md: allow configuring logical block size

Wu Guanghao (1):
      Factor out code into md_should_do_recovery()

Xiao Ni (2):
      md: delete mddev kobj before deleting gendisk kobj
      md: avoid repeated calls to del_gendisk

Yu Kuai (1):
      MAINTAINERS: Update Yu Kuai's E-mail address

Yun Zhou (1):
      md: fix rcu protection in md_wakeup_thread

 Documentation/admin-guide/md.rst |  10 ++++++++
 MAINTAINERS                      |   4 +--
 drivers/md/md-linear.c           |   2 ++
 drivers/md/md-llbitmap.c         |   2 +-
 drivers/md/md.c                  | 247 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-------------------------------------------
 drivers/md/md.h                  |  10 +++++++-
 drivers/md/raid0.c               |  17 ++++++-------
 drivers/md/raid1.c               |   1 +
 drivers/md/raid10.c              |   1 +
 drivers/md/raid5-cache.c         |   2 +-
 drivers/md/raid5.c               |   1 +
 include/uapi/linux/raid/md_p.h   |   3 ++-
 12 files changed, 225 insertions(+), 75 deletions(-)
