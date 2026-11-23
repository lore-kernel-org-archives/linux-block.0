Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=101.204.27.37
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795401110;
	b=zRbLC/wRmj2km/B20AjoUkzqP1y0gj53BGbqqDlK1PhlwZJtuhsd90xfgQAwyYfSsuEo
	 EWakmeT+2Vn0XL5nmOyS2p5ROsxlf9j+uWHPXOfs5BftJXaPnGvKsV7k784escaOkJCsy
	 eB+K3lofgMAkfBoyeJr8RQTZhX8DYuVEE6W98gVQ/OM2rtYZMa7qrh5F0jjD/8uriy9Sy
	 2Y0QbfwYYwE8kD+UERKQu4Z5iF323Hj9TWYJyhp8z0YQfcMxNcWcxFaW+EU3s1PDipDKX
	 TFHdPopBnJ7K/5Ovx88Y4WWNVTyRuVOtR8hRwzQoUJot+3PCmGNQpX4bLCmNwMwHPkw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795401110;
	h=DMARC-Filter:Received:Received:Received:Received:Date:From:To:CC:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:Content-Transfer-Encoding:In-Reply-To:
	 X-Originating-IP:X-ClientProxiedBy;
	bh=DubBYw11u39hDCHP507B0e3hI2K38GChIQfRTnxdD6k=;
	b=VSstbkwALkaobamdDa3lJtNZO9oGXsTgC5UCPpfKda7m8RCna9R+9w6jFDsaKRMGsYjj
	 KN0xmhbPEosTn6DErdBk/Q/epBkKsmqJ9UqzeaJFEkXomlX9YD3RDTF4sHRNMKcKwb4uY
	 QCtwfmL1gGClQISnSj1XS6XT8pEqzwZN44a10q7LXhRsLiv+IQAs9ak5KdsdlcntUgjZR
	 oNwPqWimARBQb1lzcji1Ul70yRNlIF3T26gC9L2NR4nfEXYVBNtrGnJGLHG8REglTJBIO
	 pZ5PdBbO0cUPQmlBqkiN6g87U7i04Z0ePZ0cNiaEANEFXHKjMrs4in5/5hYFyE7yxhg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=hygon.cn;
	spf=pass smtp.mailfrom=hygon.cn;
	arc=none smtp.remote-ip=101.204.27.37
Received: from spam01.hygon.cn (unknown [101.204.27.37])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87528606A31A;
	Mon, 23 Nov 2026 02:31:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 87528606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hygon.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hygon.cn
Received: from maildlp1.hygon.cn (unknown [127.0.0.1])
	by spam01.hygon.cn (Postfix) with ESMTP id 4jXqh34zJCzVcB5;
	Mon, 23 Nov 2026 10:31:31 +0800 (CST)
Received: from maildlp1.hygon.cn (unknown [172.23.18.60])
	by spam01.hygon.cn (Postfix) with ESMTP id 4jXqh073qvzVcB9;
	Mon, 23 Nov 2026 10:31:28 +0800 (CST)
Received: from cncheex04.Hygon.cn (unknown [172.23.18.114])
	by maildlp1.hygon.cn (Postfix) with ESMTPS id 95C6216DB;
	Mon, 23 Nov 2026 10:31:26 +0800 (CST)
Received: from hsj-2U-Workstation (172.19.24.226) by cncheex04.Hygon.cn
 (172.23.18.114) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Mon, 23 Nov
 2026 10:31:26 +0800
Date: Mon, 23 Nov 2026 10:31:24 +0800
From: Huang Shijie <huangsj@hygon.cn>
To: Andreas Gruenbacher <agruenba@redhat.com>
CC: <viro@zeniv.linux.org.uk>, <brauner@kernel.org>, <jack@suse.cz>,
	<hch@infradead.org>, <mic@digikod.net>, <axboe@kernel.dk>,
	<gnoack@google.com>, <paul@paul-moore.com>, <jmorris@namei.org>,
	<serge@hallyn.com>, <legion@kernel.org>, <aleksa@amutable.com>,
	<libaokun@linux.alibaba.com>, <ebiggers@kernel.org>, <djwong@kernel.org>,
	<sandeen@redhat.com>, <zhongyuan@hygon.cn>, <fangbaoshun@hygon.cn>,
	<yingzhiwei@hygon.cn>, <wujianyong@hygon.cn>, <shijie8@gmail.com>,
	<linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-block@vger.kernel.org>, <gfs2@lists.linux.dev>,
	<linux-security-module@vger.kernel.org>
Subject: Re: [PATCH v3 0/11] vfs: add inode iteration methods
Message-ID: <awOlfBGNgQoassIt@hsj-2U-Workstation>
References: <20261120031305.3561045-1-huangsj@hygon.cn>
 <CAHc6FU7URHetBU9XgP0DSEGjWQfq0tX+ohK8xRVZLEYzgJBeEw@mail.gmail.com>
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHc6FU7URHetBU9XgP0DSEGjWQfq0tX+ohK8xRVZLEYzgJBeEw@mail.gmail.com>
X-ClientProxiedBy: cncheex06.Hygon.cn (172.23.18.116) To cncheex04.Hygon.cn
 (172.23.18.114)

在 Fri, Nov 20, 2026 at 03:59:10PM +0100，Andreas Gruenbacher 写道：
> On Fri, Nov 20, 2026 at 4:13 AM Huang Shijie <huangsj@hygon.cn> wrote:
> > This series adds two superblock inode iteration helpers,
> > super_iter_inodes() and super_iter_inodes_locked(), and converts the
> > open-coded sb->s_inodes walks in the VFS to them.  The design is based on
> > Dave Chinner's patch set:
> >   "vfs: improving inode cache iteration scalability"
> >   https://lore.kernel.org/all/20241002014017.3801899-1-david@fromorbit.com/
> >
> > About the two helpers:
> >
> >   int super_iter_inodes(struct super_block *sb, ino_iter_fn iter_fn,
> >                         ino_iter_eligible_fn eligible, void *priv,
> >                         int flags);
> >
> >   static inline int super_iter_inodes_locked(struct super_block *sb,
> >                                              ino_iter_fn iter_fn,
> >                                              void *priv);
> >
> >   - super_iter_inodes() runs @iter_fn with a referenced inode and with
> >     sb->s_inode_list_lock __dropped__, so the callback is free to block and
> >     to do whatever it wants with the inode except drop the reference the
> >     iterator holds.  The iterator releases that one reference per inode
> >     itself, so the callback cannot leave a dangling inode behind.
> >     It is exported because GFS2 can be built as a module.
> >
> >   - super_iter_inodes_locked() keeps sb->s_inode_list_lock held for the
> >     whole walk and takes no inode references at all.  Its callback
> >     therefore only has an existence guarantee: it must not block and
> >     must do its own inode state checks and its own reference handling.
> >     It is internal to the VFS, being declared in fs/internal.h.
> >
> >   - The callback is separate from the caller's data, so a caller keeps
> >     its state in its own structure instead of filling in a shared
> >     context:
> >
> >       typedef int (*ino_iter_fn)(struct inode *inode, void *priv);
> >
> >   - %INO_ITER_F_REFERENCED restricts the safe iterator to inodes that
> >     still have a reference.  It preserves the "only handle referenced
> >     inodes" rule of landlock's sb-delete walk.
> >
> >   - %INO_ITER_F_NOREF does the opposite: only inodes whose reference
> >     count has already reached zero are handed out.  %INO_ITER_F_NOIGET
> >     suppresses the reference.  Neither keeps the inode alive, so the
> >     caller must make it unclaimable itself.
> >
> >    Patch 1 adds super_iter_inodes().
> >    Patch 2 adds super_iter_inodes_locked().
> >    Patch 3-5 convert the callers which cannot use referenced inodes
> >            (dquot removal, nr_blockdev_pages() and the
> >            generic_shutdown_super() poisoning loop).
> >    Patch 6-11 convert the remaining callers (inode eviction, sync_bdevs,
> >            drop_pagecache_sb, add_dquot_ref, landlock's hook_sb_delete
> >            and gfs2_evict_inodes()).
> >
> >
> > BTW:
> >   This patch set depends a small patch:
> >   "fs/drop_caches: skip filesystems without fs writeback"
> >   https://lkml.org/lkml/2026/9/23/675
> 
> That link doesn't work for me. When referring to other postings, can
> you please use lore links?
Okay. No problem.

> 
> There also is no posting of a patch with that title from that day on
> https://lore.kernel.org/linux-fsdevel/. You may be referring to
> https://lore.kernel.org/linux-fsdevel/20260920072811.2064247-2-huangsj@hygon.cn/,
> but that patch queue no longer applies. So please post patch queues in
> a state that applies and optionally, make a git branch available.
> 
I will add the kernel version in next version.

Thanks
Huang Shijie

