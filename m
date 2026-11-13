Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=101.204.27.37
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794571062;
	b=M1PAkO6Ov5CBOGk/XQ6NSDvJM9MapwalCk5bbSKSxjXuulFZgvEt7uqOQrsscbpQzA0P
	 gV0ggmgH36D5UiKMoMlymmkwrFZjECjgII7ytaBs9QIRve6G7jCfBMqJ9hfP4XfCHIKid
	 zEQihR04UK8SAJrMo8nqqGb9p/jWRAARQ4IQq9ajT+xYtN+yV6JLN+HKOa9pKaYQQqQHF
	 Lmb8IBLFmMtaTT30IBHsHTDGgQZ581664zqKVLKjbwtJl2/6hapK50vRnV9/2Pc79c7oO
	 rFYshjS57bSSOpJJrHCnj51pHx/ZJQJhkpTDMNMm4dNwDspso6X1+1zL5rnvJolE2Sw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794571062;
	h=DMARC-Filter:Received:Received:Received:Received:From:To:CC:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 Content-Type:X-Originating-IP:X-ClientProxiedBy;
	bh=YHpzHEdUDZ5SvCxvkjenerDSoX95H+RemwkThqVSCZg=;
	b=GeHz1fQrcrUCjvU3l4qyZ67J50xB3Odi6FfpmhmTb5BCxyEaHD3cPnUsAshKonI362Dk
	 89mcpmncxvqz31plg7KZa4qPxckpFZHt8vfa0//oM3jBhQL+vPz0oUu8qCKSzu6lJDK+h
	 Y7YGR8F6lxowCGw0LqHmoVLYveBFJav8MKhJ/GDDGRoJ2in3OBzpn/E/B2oZyfZAqAPli
	 Pq7GOAwcWf0OEW5+FPPFPkjuUOqu9wp46VB+b83HrK9OH0YbHydQtcJeQCV380J0ttZdI
	 mZTP1hxbbU6i+boCcZqxYaMyl+W7uSMg9A4jitqWZj9FDEM2QQsOmeEeIHKrp0xXSrw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=hygon.cn;
	spf=pass smtp.mailfrom=hygon.cn;
	arc=none smtp.remote-ip=101.204.27.37
Received: from spam01.hygon.cn (unknown [101.204.27.37])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 873CF606A32D;
	Fri, 13 Nov 2026 11:57:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 873CF606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hygon.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hygon.cn
Received: from maildlp2.hygon.cn (unknown [127.0.0.1])
	by spam01.hygon.cn (Postfix) with ESMTP id 4jQwjg2LbCzVcB5;
	Fri, 13 Nov 2026 19:57:27 +0800 (CST)
Received: from maildlp2.hygon.cn (unknown [172.23.18.61])
	by spam01.hygon.cn (Postfix) with ESMTP id 4jQwjf25jzzVcB5;
	Fri, 13 Nov 2026 19:57:26 +0800 (CST)
Received: from cncheex04.Hygon.cn (unknown [172.23.18.114])
	by maildlp2.hygon.cn (Postfix) with ESMTPS id AFA0C30004D3;
	Fri, 13 Nov 2026 19:56:35 +0800 (CST)
Received: from hsj-2U-Workstation.hygon.cn (172.19.24.226) by
 cncheex04.Hygon.cn (172.23.18.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Fri, 13 Nov 2026 19:57:24 +0800
From: Huang Shijie <huangsj@hygon.cn>
To: <axboe@kernel.dk>, <viro@zeniv.linux.org.uk>, <brauner@kernel.org>,
	<jack@suse.cz>
CC: <zhongyuan@hygon.cn>, <fangbaoshun@hygon.cn>, <yingzhiwei@hygon.cn>,
	<agruenba@redhat.com>, <mic@digikod.net>, <gnoack@google.com>,
	<paul@paul-moore.com>, <jmorris@namei.org>, <serge@hallyn.com>,
	<aleksa@amutable.com>, <legion@kernel.org>, <david@kernel.org>,
	<sandeen@redhat.com>, <ebiggers@kernel.org>, <linux-block@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
	<gfs2@lists.linux.dev>, <linux-security-module@vger.kernel.org>,
	<sunjunchao@bytedance.com>, <shijie8@gmail.com>, Huang Shijie
	<huangsj@hygon.cn>
Subject: [PATCH v2 0/3] vfs: add inode iteration methods
Date: Fri, 13 Nov 2026 19:56:59 +0800
Message-ID: <20261113115702.586594-1-huangsj@hygon.cn>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: cncheex05.Hygon.cn (172.23.18.115) To cncheex04.Hygon.cn
 (172.23.18.114)

This series adds two superblock inode iteration helpers:
super_iter_inodes()/super_iter_inodes_unsafe(), and converts the open-coded
sb->s_inodes walks in the VFS to it. The design is based on Dave Chinner's
patch set:
  "vfs: improving inode cache iteration scalability"
  https://lore.kernel.org/all/20241002014017.3801899-1-david@fromorbit.com/

About the two helpers:  
  int super_iter_inodes(struct super_block *sb,
                        struct inode_iter_context *ctx);

  int super_iter_inodes_unsafe(struct super_block *sb,
                               struct inode_iter_context *ctx);

  - super_iter_inodes() runs @ctx->iter_fn() with a referenced inode
    and with sb->s_inode_list_lock dropped, so the callback is free to
    block and to do whatever it wants with the inode except drop the
    reference the iterator holds.  
    It is exported because GFS2 can be built as a module.

  - super_iter_inodes_unsafe() keeps sb->s_inode_list_lock and
    rcu_read_lock() held for the whole walk and takes no inode
    references at all.  Its callback therefore only has an existence
    guarantee: it must not block and must do its own inode state
    checks and its own reference handling.  
    It is internal to the VFS, being declared in fs/internal.h.

  - %INO_ITER_F_REFERENCED additionally restricts the safe iterator to
    inodes that still have a reference.  This preserves the "only
    handle referenced inodes" rule of landlock's sb-delete walk.

  - @ctx->prev is the resume point of the unsafe iterator: a caller
    which has to drop the list lock in the middle of a walk stores the
    inode to continue from, and the next call starts after that inode
    instead of at the head.

   Patch 1 adds the two iterators.

   Patch 2 converts the callers that cannot use referenced inodes
           (dquot removal, inode eviction, nr_blockdev_pages() and the
           generic_shutdown_super() poisoning loop) to
           super_iter_inodes_unsafe().

   Patch 3 converts the remaining callers (sync_bdevs,
           drop_pagecache_sb, gfs2_kill_sb, add_dquot_ref and
           landlock's hook_sb_delete).


BTW:
  This patch set depends a small patch:
  "fs/drop_caches: skip filesystems without fs writeback"
  https://lkml.org/lkml/2026/9/23/675

v1-->v2:
   -split the super_iter_inodes_unsafe from super_iter_inodes.
   -add ->eligible() before calling the __iget().
   -others
   
   v1: https://lore.kernel.org/all/20261015093854.2082600-1-huangsj@hygon.cn/

Huang Shijie (3):
  vfs: add inode iteration methods
  vfs: convert inode iterators to super_iter_inodes_unsafe()
  vfs: convert sb->s_inodes iteration to super_iter_inodes()

 block/bdev.c                   | 111 ++++++++++++------------
 fs/drop_caches.c               |  49 +++++------
 fs/gfs2/ops_fstype.c           |  33 +++----
 fs/inode.c                     |  83 ++++++++++--------
 fs/internal.h                  |  34 ++++++++
 fs/quota/dquot.c               | 149 +++++++++++++++++---------------
 fs/super.c                     |  88 +++++++++++++++++--
 include/linux/fs/super_types.h |  25 ++++++
 security/landlock/fs.c         | 153 +++++++++++++--------------------
 9 files changed, 413 insertions(+), 312 deletions(-)

-- 
2.53.0


