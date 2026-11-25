Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=101.204.27.37
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795597941;
	b=VC4N5S5hbLSQwwVgjLAbyx0NG7EglCitey3xiVHyXEdDV3os51/xJMhvDySjlv4rKIJJ
	 EEqrAlk/TsbPhbv0iOSY323ntSgnL3laF41nk6Mg2wZzyx7hFseepgyjzzrd8W9drw8Ll
	 edey4P6FKy3LQ05YajeZHrV6laFN5ZD9w+8HDFSKh9XraRkrJo3ma82R48HifEknovqiN
	 XC676AUxBQma/bHo4NkdwjU6JtnHGI9T69E3fwi1aj3B2pY5LbLEa1uU9F/+pj9g6a8kN
	 0XZFJHBgS8jl79xHhi/90q3I+2XvdhRsF11MZPJYT/mN1kyEEoWIulLlFkPiq5CGsnA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795597941;
	h=DMARC-Filter:Received:Received:Received:Received:From:To:CC:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 Content-Type:X-Originating-IP:X-ClientProxiedBy;
	bh=PoDUmL89J9kwKXxxu04mqcDBvGz9q2h1SGMDm/ZaSOU=;
	b=feuTia6SmchY9ZjsuNDQgxSY6xOKNZEAJsKzgxQ2jUmjKr+QWOFdC1FKy/3h9ytvqk4U
	 TJf7Vyq3agqfiui1LcQ5cngNH0K5yIX22cWYU33kOgzfrwkCU/2UY8kR8pBU2AuwzGKPr
	 8Ns6pVFjXrd3+r/dqeh09X37mQx1yjTZWiWqFIBzdbUXQCBWUkb2EuRZc0njQxiafMGSW
	 i1u4XFvuRBOny0yt6H1lUJ1H2wCf8/QonYx7lxx/tEyEx4LruPdZT6x8N80/RWkuYeTg/
	 DxNhZdtpIafIrGuYTCpFBljlMJW+LruWpu6Gh1Cfn6xQDjxzHrDH+ZIXqHO9C0n6rdQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=hygon.cn;
	spf=pass smtp.mailfrom=hygon.cn;
	arc=none smtp.remote-ip=101.204.27.37
Received: from spam01.hygon.cn (unknown [101.204.27.37])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D10E606A31E;
	Wed, 25 Nov 2026 09:12:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2D10E606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hygon.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hygon.cn
Received: from maildlp1.hygon.cn (unknown [127.0.0.1])
	by spam01.hygon.cn (Postfix) with ESMTP id 4jZDTP28wtzVcB9;
	Wed, 25 Nov 2026 17:12:09 +0800 (CST)
Received: from maildlp1.hygon.cn (unknown [172.23.18.60])
	by spam01.hygon.cn (Postfix) with ESMTP id 4jZDTM1JV8zVhfS;
	Wed, 25 Nov 2026 17:12:07 +0800 (CST)
Received: from cncheex04.Hygon.cn (unknown [172.23.18.114])
	by maildlp1.hygon.cn (Postfix) with ESMTPS id 81A051662;
	Wed, 25 Nov 2026 17:12:00 +0800 (CST)
Received: from hsj-2U-Workstation.hygon.cn (172.19.24.226) by
 cncheex04.Hygon.cn (172.23.18.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Wed, 25 Nov 2026 17:12:04 +0800
From: Huang Shijie <huangsj@hygon.cn>
To: <viro@zeniv.linux.org.uk>, <brauner@kernel.org>, <jack@suse.cz>,
	<hch@infradead.org>, <agruenba@redhat.com>, <mic@digikod.net>,
	<axboe@kernel.dk>
CC: <gnoack@google.com>, <paul@paul-moore.com>, <jmorris@namei.org>,
	<serge@hallyn.com>, <legion@kernel.org>, <aleksa@amutable.com>,
	<libaokun@linux.alibaba.com>, <ebiggers@kernel.org>, <djwong@kernel.org>,
	<sandeen@redhat.com>, <zhongyuan@hygon.cn>, <fangbaoshun@hygon.cn>,
	<yingzhiwei@hygon.cn>, <wujianyong@hygon.cn>, <shijie8@gmail.com>,
	<linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-block@vger.kernel.org>, <gfs2@lists.linux.dev>,
	<linux-security-module@vger.kernel.org>, Huang Shijie <huangsj@hygon.cn>
Subject: [PATCH v4 00/11] vfs: add inode iteration methods
Date: Wed, 25 Nov 2026 17:11:46 +0800
Message-ID: <20261125091157.1822521-1-huangsj@hygon.cn>
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

This series adds a superblock inode iterator and converts the open-coded
sb->s_inodes walks in the VFS to it.  The design follows the cursor-based
construct proposed by Christian Brauner:

  https://lore.kernel.org/all/20261120-mitverantwortlich-drehbaren-kantholz-241300d20168@brauner/

and is the same direction as Dave Chinner's patch set:

  "vfs: improving inode cache iteration scalability"
  https://lore.kernel.org/all/20241002014017.3801899-1-david@fromorbit.com/

The caller owns the iterator state and drives the walk itself:

  CLASS(sb_inode_iter, iter)(sb, eligible, priv, flags);
  while ((inode = sb_inode_iter_next(&iter)))
          /* do stuff */;

The lock does not span iterations.  sb_inode_iter_next() takes
sb->s_inode_list_lock, takes a reference on the next inode, drops the lock
again and hands the inode out; the reference is what keeps the cursor on
sb->s_inodes so that the next call can resume from it.  As the iterator
is a cleanup class, a caller that breaks out early does not have to call
sb_inode_iter_end() explicitly.

Two optional channels let a caller keep its own state instead of filling in
a shared context:

  - iter->eligible is called with inode->i_lock held, so that a caller can
    reject an inode before a reference is paid for.

  - iter->status carries an error out of the walk.  Setting it to a
    negative value makes sb_inode_iter_next() return NULL.

Most callers just want a referenced inode and use no flags at all.  Three
flags cover the walks that need something else:

  - %INO_ITER_F_REFERENCED restricts the walk to inodes that still have a
    reference, preserving the "only handle referenced inodes" rule of
    landlock's sb-delete walk.

  - %INO_ITER_F_NOREF hands out only inodes whose reference count has
    already reached zero, and %INO_ITER_F_NOIGET suppresses the reference.
    Neither keeps the inode alive, so the caller has to make the inode
    unclaimable itself.

A second, internal iterator covers the walks that must not take a
reference at all:

  static inline int sb_inode_iter_locked(struct super_block *sb,
                                         int (*iter_fn)(struct inode *,
                                                        void *),
                                         void *priv);

  - It keeps sb->s_inode_list_lock held for the whole walk and takes no
    inode reference, so @iter_fn only has an existence guarantee: it must
    not block, and it must do its own inode state checks and its own
    reference handling.  A callback returns a negative value to stop the
    walk with that error, and 0 to continue.

  - It lives in fs/internal.h as a static inline rather than being
    exported: it is a VFS internal facility, and the small callbacks
    inline into their callers.

  It serves the three walks that cannot use sb_inode_iter_next():

  - nr_blockdev_pages() is reached from si_meminfo(), which kdb calls, and
    the iput() that the referenced iterator would do can sleep.

  - remove_dquot_ref() has to scan I_NEW inodes as well, which the
    referenced iterator filters out; it only touches the quota pointers,
    and those have their own locking in dq_data_lock.

  - the generic_shutdown_super() poisoning loop has to touch every inode
    still on the list, including the I_NEW, I_FREEING and I_WILL_FREE
    ones that sb_inode_iter_next() filters out, and it must not bounce
    them through __iget()/iput(): the loop overwrites i_sb with
    VFS_PTR_POISON, and evict() dereferences i_sb->s_op on the way out.

  Patch 1 adds sb_inode_iter_next().
  Patch 2 adds sb_inode_iter_locked().
  Patch 3-5 convert the callers which cannot use referenced inodes
          (nr_blockdev_pages(), dquot removal and the
          generic_shutdown_super() poisoning loop).
  Patch 6-11 convert the remaining callers (inode eviction, sync_bdevs,
          drop_pagecache_sb, add_dquot_ref, landlock's hook_sb_delete
          and gfs2_evict_inodes()).


BTW:
  This series is based on v7.4-rc2, and applies on top of the last commit
  of that base, which is the small patch this series depends on:

      v7.4-rc2-22-ga02161f70fcf
      commit a02161f70fcf ("fs/drop_caches: skip filesystems without page cache writeback")

  That patch was posted as:
      https://lore.kernel.org/all/20260923070116.3226846-1-huangsj@hygon.cn/

v3-->v4:
   -the interface is redone as a caller-owned cursor, following Christian's
    sb_inode_iter construct: sb_inode_iter_next() returns a referenced
    inode with sb->s_inode_list_lock dropped, and the reference keeps the
    cursor on sb->s_inodes.  The callback-based interface of v3, with its
    ino_iter_fn and INO_ITER_RET_* return values, is gone.

   -the iterator is wrapped in a cleanup class, so a caller that breaks out
    of the walk does not have to call sb_inode_iter_end().

   -an inode can be rejected before a reference is paid for: @eligible is
    called with inode->i_lock held.

   -the error channel is now iter->status rather than a three-valued
    callback return.

   -super_iter_inodes() and super_iter_inodes_locked() are renamed to
    sb_inode_iter_next() and sb_inode_iter_locked(), and the latter stays
    in fs/internal.h for the three walks that must not take a reference.

   -evict_inodes() uses INO_ITER_F_NOREF | INO_ITER_F_NOIGET: it only
    takes inodes whose reference count has reached zero, pins each one by
    setting I_FREEING and dropping it from the LRU, and runs dispose_list()
    with the list lock dropped.

   v3: https://lore.kernel.org/all/20261120031305.3561045-1-huangsj@hygon.cn/
   v2: https://lore.kernel.org/all/20261113115702.586594-1-huangsj@hygon.cn/
   v1: https://lore.kernel.org/all/20261015093854.2082600-1-huangsj@hygon.cn/

Huang Shijie (11):
  vfs: add sb_inode_iter_next()
  vfs: add sb_inode_iter_locked()
  block: convert nr_blockdev_pages() to sb_inode_iter_locked()
  fs/quota: convert remove_dquot_ref() to sb_inode_iter_locked()
  fs: convert generic_shutdown_super() poison loop
  fs/inode: convert evict_inodes() to sb_inode_iter
  block: convert sync_bdevs() to sb_inode_iter
  fs/drop_caches: convert drop_pagecache_sb() to sb_inode_iter
  fs/quota: convert add_dquot_ref() to sb_inode_iter
  landlock: convert hook_sb_delete() to sb_inode_iter
  gfs2: convert gfs2_evict_inodes() to sb_inode_iter

 block/bdev.c                   |  58 ++++++----------
 fs/drop_caches.c               |  36 ++++------
 fs/gfs2/ops_fstype.c           |  26 ++-----
 fs/inode.c                     |  33 +++------
 fs/internal.h                  |  25 +++++++
 fs/quota/dquot.c               | 120 +++++++++++++++-----------------
 fs/super.c                     | 121 ++++++++++++++++++++++++++++++---
 include/linux/fs/super_types.h |  40 +++++++++++
 security/landlock/fs.c         |  67 +++++-------------
 9 files changed, 297 insertions(+), 229 deletions(-)

-- 
2.53.0


