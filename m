Received: from mailgw1.hygon.cn (unknown [101.204.27.37])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99E8C503BD1;
	Thu, 15 Oct 2026 09:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=101.204.27.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792057254; cv=none; b=gBiB5S9h3JlvGsr28UHCAO0Dydo10uqnPAvQzsL43pYC0QbiFZr3CiElWmZb9RECd2oRNM+wlxRCDUlWTGgVHQOiWaIi1cxms8WodZWPJvQ1BwukVJ3FWcgCcA9UIzW3YUquHvgmxC50J7bd/msstV2GPUnK1JkCxiY7bpQcF+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792057254; c=relaxed/simple;
	bh=QUmDIO21lFFlSts5XSmRSWXXX2WSM1FZf+XFYrY7P70=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=iPDohncIAAijOeqYUFoOLhucgsRxm5AKMRFh1LazY7+4ts4QBpWJI0dnGyAoLHw74ZLe2LFymJpAPnhLrTeFQRCLR7GkgWGk5y5b98IaFlQLSktnDurmnQqx4MpIJvUo961RWI0jCZeZty7DnpYQehjvgFPnPs1xa/L8dG4xiGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hygon.cn; spf=pass smtp.mailfrom=hygon.cn; arc=none smtp.client-ip=101.204.27.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hygon.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hygon.cn
Received: from maildlp2.hygon.cn (unknown [127.0.0.1])
	by mailgw1.hygon.cn (Postfix) with ESMTP id 4j532y6DhDzCWwYc;
	Thu, 15 Oct 2026 17:40:26 +0800 (CST)
Received: from maildlp2.hygon.cn (unknown [172.23.18.61])
	by mailgw1.hygon.cn (Postfix) with ESMTP id 4j532w2G0ZzCWwYX;
	Thu, 15 Oct 2026 17:40:24 +0800 (CST)
Received: from cncheex04.Hygon.cn (unknown [172.23.18.114])
	by maildlp2.hygon.cn (Postfix) with ESMTPS id 9CCC930008F0;
	Thu, 15 Oct 2026 17:35:14 +0800 (CST)
Received: from hsj-2U-Workstation.hygon.cn (172.19.24.226) by
 cncheex04.Hygon.cn (172.23.18.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Thu, 15 Oct 2026 17:40:20 +0800
From: Huang Shijie <huangsj@hygon.cn>
To: <axboe@kernel.dk>, <viro@zeniv.linux.org.uk>, <brauner@kernel.org>
CC: <zhongyuan@hygon.cn>, <fangbaoshun@hygon.cn>, <yingzhiwei@hygon.cn>,
	<jack@suse.cz>, <agruenba@redhat.com>, <mic@digikod.net>,
	<gnoack@google.com>, <paul@paul-moore.com>, <jmorris@namei.org>,
	<serge@hallyn.com>, <aleksa@amutable.com>, <legion@kernel.org>,
	<david@kernel.org>, <sandeen@redhat.com>, <ebiggers@kernel.org>,
	<linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-fsdevel@vger.kernel.org>, <gfs2@lists.linux.dev>,
	<linux-security-module@vger.kernel.org>, <sunjunchao@bytedance.com>, Huang
 Shijie <huangsj@hygon.cn>
Subject: [PATCH 0/3] vfs: add inode iteration method super_iter_inodes
Date: Thu, 15 Oct 2026 17:38:51 +0800
Message-ID: <20261015093854.2082600-1-huangsj@hygon.cn>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: cncheex05.Hygon.cn (172.23.18.115) To cncheex04.Hygon.cn
 (172.23.18.114)

This series adds a single superblock inode iteration helper,
super_iter_inodes(), and converts the open-coded sb->s_inodes walks in
the VFS to it.  The design is based on Dave Chinner's patch set:
  "vfs: improving inode cache iteration scalability"
  https://lore.kernel.org/all/20241002014017.3801899-1-david@fromorbit.com/

The helper takes a callback, a private data pointer and flags:

  int super_iter_inodes(struct super_block *sb, ino_iter_fn iter_fn,
                        void *private_data, int flags);

  - Without a flag, @iter_fn runs with a valid, referenced inode and may
    block; the iterator owns the inode lifecycle and filters out
    I_NEW/I_FREEING/I_WILL_FREE inodes.

  - %INO_ITER_F_REFERENCED additionally restricts the iteration to
    inodes that still have a reference.  This preserves the "only handle
    referenced inodes" rule of landlock's sb-delete walk.

  - %INO_ITER_F_UNSAFE runs @iter_fn in atomic context (rcu_read_lock()
    plus sb->s_inode_list_lock) without taking a reference.  The
    callback must do its own state checks, must not block and must do its
    own rescheduling by returning %INO_ITER_RET_ABORT.

   Patch 1 adds the iterator.  
   Patch 2 converts the callers that cannot use
           referenced inodes (dquot removal, inode eviction, nr_blockdev_pages and
           the generic_shutdown_super() poisoning loop) to %INO_ITER_F_UNSAFE.
   Patch 3 converts the remaining callers (sync_bdevs, drop_pagecache_sb,
           gfs2_kill_sb, add_dquot_ref and landlock's hook_sb_delete).

BTW:
  This patch set depends a small patch:
  "fs/drop_caches: skip filesystems without fs writeback"
  https://lkml.org/lkml/2026/9/23/675
  

Huang Shijie (3):
  vfs: add inode iteration method super_iter_inodes
  vfs: convert inode iterators to the unsafe super_iter_inodes()
  vfs: convert sb->s_inodes iteration to super_iter_inodes()

 block/bdev.c                   |  84 ++++++++-----------
 fs/drop_caches.c               |  36 ++-------
 fs/gfs2/ops_fstype.c           |  68 +++++-----------
 fs/inode.c                     |  68 ++++++++--------
 fs/quota/dquot.c               | 132 ++++++++++++++----------------
 fs/super.c                     | 131 +++++++++++++++++++++++++++---
 include/linux/fs/super_types.h |  14 ++++
 security/landlock/fs.c         | 142 +++++++++++----------------------
 8 files changed, 340 insertions(+), 335 deletions(-)

-- 
2.34.1


