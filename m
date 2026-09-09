Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B36C486E68
	for <linux-block@vger.kernel.org>; Wed,  9 Sep 2026 09:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788944485; cv=none; b=O2kA+mKclRUTQm6TyZZLxrSMcnZQCnm62lOZVtIeDOCGnJdJxUBTbzNMMTyU4QrSlW8DTjPl/9TAZ7mpfArZbIeOanjDRV5mYGHjRIgx5On7ako4OdEkenXrm1FTTWKio2aqk0fRpSICDvfxVIDrFcLy+0ClaT4nGKlveoESAZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788944485; c=relaxed/simple;
	bh=qIa/OOPRF8eUOfN7emCsEmTA8N7RP5NPcMNXTb2hiYo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=diiYfoSkqrtyfm28scexcoUCP7S1MFYhIJMeicjdilLcdm2gubGvnDFgBSdnSBT2nDeSPv/jkyMYQVkNeKWut1GDF9Mep0PsPoybU+suWKwFx7+ZZ5I6fVJAcId+XUcTFZICquTzyzifdHsO8jEJzow8pXZ67KQfxosNdYCbbBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=HtFswz1y; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="HtFswz1y"
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-cc328b43a56so4501297a12.2
        for <linux-block@vger.kernel.org>; Wed, 09 Sep 2026 02:01:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1788944476; x=1789549276; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=oiZZoK2m1udHvSG78cGXbZoP5Fh5l1Q4IJu628L6gi0=;
        b=HtFswz1yOfJXqfBH8NnPwExVeCh/+X6eCs9ZxzqgwCEp6qLM16g8aCUUNKLfaq7UkQ
         LX6OwkO+9z67LUuTLgMokPufOBJ4/QZZb2sjBcAIFOavlXy8XEaXJcmBg3k2ZZy3C+kr
         DEHDbOHXyecNJBpnGpk5jrOhREll8DXiaN7+U9HxKkTNn6OoEHNshYscnQfSavMZYyLP
         IR9jS/hNfeWyRW1PQw2yhBnit5aldlUMtcSqcnXXht4tYH7lClES2V3ibLO8ZpCP6YQi
         apRGjyCTXC5RZztrKgrlQwDVSKyyg73fusL5R02+/O83BBBEymCG7R+BvlZ6DKduamPJ
         /24g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788944476; x=1789549276;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=oiZZoK2m1udHvSG78cGXbZoP5Fh5l1Q4IJu628L6gi0=;
        b=CQV4NFOmhAxlvcJ1etYoX/ijNfNwhvQrW1FCYLIZgJZ8Cts0XoELOlW5KH742TEItk
         qZ7Uc5jKjGcZxp/YK05UjRAq0L3Px40v+fUGxecC4ljhHdRksF8MPB/k+YlMS7X+gTfk
         Gr5M/ffPm7zovYX5ynfoQd6MORpOQBkPZDuhSZmTfanzqeU49ZAbf8soBrPK5a2M4u7s
         wiEZP3zDn/dsZO8wJ0hEFNVsvHq/P1mL5GiYc8H1PZYhUEaHw0Bd+to79p0bfdHfNxkb
         FAncwTOPxwWdHAeRSPN/KokpMf6856371QSGzn8G1uzk3YUV4vGx3XsShugfqdG/DH9K
         T3lg==
X-Gm-Message-State: AFuF++lzPuu2voCwIBX0VxVNJDIxS6VmUVBo3yKJYpYxqZ3prS5J+dup
	q/Mu7FFz22tOIodPk0yeqv97SOOqxpajQUR6BUVOrekYdl5gsHEQta+eAPVW9XlTEcxOxBZzdf6
	tNg39mPo=
X-Gm-Gg: AYBFou1Qip+lr6NFE6Dpywc4X9w8YVE/gK206Tm4ND0NzM9sSDf7zwnfcoKkqfHz3b2
	dg0hpZJIAPJ+RRfD3PnxaTpT8m64GeqZ9gf3rCXr5p8yZiW2ufXnIY/eiUsZypqkNd6Vzi6USHz
	muLtKTs5MBYPBrdgFoDiHslskJ//EZ+NiH2a11fKYQIN2M2b9fcFDeyXYini6EYiKYI1nxXF4lA
	SaJvilvvr6C0mjMjTnVhqsP/eTYrFd3lvFLIK04ZwZ816/e8TSnZOikNz870i07uf427Xo61rsQ
	h7fPQYE962aJOFPQyOZAKeH/6GAAdhSO0NBmlg5KCNYLrcWyC7wKlMxUNfSK/uncKBJbG39KS82
	Np9Jhm68W2KiqIbo9lzCOv/bzxA5/MAbJGID3IG5hR4hm+rpS0E7F9WnfMMesz5kakxKFV4s/uC
	KM+Fhzl/fqbCx6eG9CaJWLsbWAo8YOBYEzluMr+on6jAnrmpZjaVMBPL7g/1D1/JS1R8dagWBPV
	yo=
X-Received: by 2002:a17:90b:528e:b0:38e:ad9d:1161 with SMTP id 98e67ed59e1d1-39b25ee67f0mr51440982a91.0.1788944476217;
        Wed, 09 Sep 2026 02:01:16 -0700 (PDT)
Received: from localhost ([106.38.226.102])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39b2612d3f1sm30763517a91.13.2026.09.09.02.01.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 02:01:15 -0700 (PDT)
From: Julian Sun <sunjunchao@bytedance.com>
To: linux-block@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	gfs2@lists.linux.dev,
	linux-security-module@vger.kernel.org
Cc: jack@suse.cz,
	agruenba@redhat.com,
	mic@digikod.net,
	gnoack@google.com,
	paul@paul-moore.com,
	jmorris@namei.org,
	serge@hallyn.com,
	aleksa@amutable.com,
	legion@kernel.org,
	djwong@kernel.org,
	ebiggers@kernel.org,
	sandeen@redhat.com
Subject: [PATCH 0/7] fs: preserve superblock inode walk positions across lock drops
Date: Wed,  9 Sep 2026 17:01:05 +0800
Message-Id: <20260909090112.790006-1-sunjunchao@bytedance.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

[Motivation]

We observed hung tasks in production during disk hotplug operations. A
kernel thread spends a long time in evict_inodes() while holding s_umount,
blocking other users of that lock and causing further stalls.

The problem is that evict_inodes() restarts its walk from the head of
sb->s_inodes every time it reschedules. When a large number of referenced
inodes remain near the head, each restart scans those inodes again without
making progress through that part of the list. The repeated scans can
delay eviction long enough to trigger hung-task reports. This is the same
problem that [1] attempted to address.

[Approach]

This series introduces sb_for_each_inodes() for two purposes:

  1. Consolidate open-coded s_inodes walks behind a common entry point.
  2. Retain each walk's position across drops of s_inode_list_lock.

The iterator mechanism follows the approach used by cgroup task iteration,
such as css_task_iter_next(). Active iterators are registered on a separate
list, sb->s_inodes_iters. Before removing an inode from s_inodes, the
removal path advances any iterator whose next position points to that
inode. These updates are protected by s_inode_list_lock, so a walker can
drop the lock and later resume from its saved position.

Existing walkers, such as drop_pagecache_sb() and add_dquot_ref(), already
contain their own position-preserving logic: they carry an inode reference
across iterations so that they can resume after dropping the list lock.
Moving that responsibility into sb_for_each_inodes() simplifies these
callers and lets their callbacks focus on the per-inode work.

Patch 1 removes trailing whitespace from include/linux/fs.h.
Patch 2 introduces sb_for_each_inodes().
The remaining patches convert existing walks to the new interface.
remove_dquot_ref() and nr_blockdev_pages() are left unchanged: their
walks are simple and do not require the inode->i_lock locking imposed
by the callback interface. Converting them would add an unnecessary
lock/unlock overhead for every inode.

[Testing]

I tested this series with approximately 20 hours of xfstests case
execution, repeatedly running the auto group on ext4 and XFS, no new
issues were observed. And with this patch applied, the hung task that
previously occurred on every run no longer occurs.

[1] https://lore.kernel.org/all/20241118114508.1405494-1-yebin@huaweicloud.com/

Julian Sun (7):
  fs: remove trailing whitespace from include/linux/fs.h
  fs: introduce sb_for_each_inodes().
  block: use sb_for_each_inodes() in sync_bdevs()
  fs: use sb_for_each_inodes() API.
  gfs2: use sb_for_each_inodes() for cooperative eviction
  quota: use sb_for_each_inodes() in add_dquot_ref()
  landlock: use sb_for_each_inodes() when detaching a superblock

 block/bdev.c                   |  85 +++++++++----------
 fs/drop_caches.c               |  44 +++++-----
 fs/gfs2/ops_fstype.c           |  38 ++++-----
 fs/inode.c                     | 142 +++++++++++++++++++++++--------
 fs/quota/dquot.c               |  72 ++++++----------
 fs/super.c                     |   1 +
 include/linux/fs.h             |  29 +++++--
 include/linux/fs/super_types.h |   3 +-
 security/landlock/fs.c         | 150 +++++++++++++--------------------
 9 files changed, 295 insertions(+), 269 deletions(-)

-- 
2.39.5

