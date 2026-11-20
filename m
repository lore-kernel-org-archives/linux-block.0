Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=170.10.133.124
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795186767;
	b=ff8BBUxsxcgDZJkxfRbh/SCgBL4W5h8upB4NAFe7Lt7sBGx3op3+PjTb2jTaLqzden7o
	 NyImm8f+cxsGBezBdTEL9t4/ufT5o/DpvZIF5J3cYiF/k7slCVZMOkNtvvGqEXBTQNQJa
	 ldX+/nJ1cwgdBNLU0EK6j3/HuJGnNfoDIlhYMQ7SXVu7ulyFcuwtto0W7jR9dA90xHB9H
	 7/UyU7wNCVItZ2xRnPKMiAiguIeBO1cPRVR2CT0NARyamxK9cLnecTTdqyQVfuXh2QXGT
	 psTRI520thtPkEzhduRRJZ1mjUMWl0wtAB3hCqPnajYC+MZz0OfWhEMQSzzWD2n6jaA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795186767;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 Content-Transfer-Encoding;
	bh=Vz/9X/xDs27LNeUzfwpYSxQHLLpaMzHuDFNMaboauyg=;
	b=BEpJSGz+A6S8Bx2DZCMmbxRtgsyla6ik7xg0a+ST2uRW1j9twvEyNBGIgetrYivy9Rvn
	 NoAI5UVqc81q1GoUi03/hMUsd0bNDZOxXjOcqypwoufTXM+7z1VqGmpIKfKIWWjruiljJ
	 rFmwLuNskN5hSBbS/dLxVFWHqwoskfWsbdFdgpKU8Is7gtSMoHAZlIeLQoAuWp/+lvVU+
	 2/6obg9gonkB+QN6WfbxkPBKoBhklxZzPrK02zo+RlLmDE50WlgmOGGPAR04wsB5OKMth
	 8WzMmW/9ds6A8t5XZ2QVaMEBjF2Uex7t/fMOd2zOY7OUSMqquMPx8+RuculvIR1C6wg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Z89hm29S;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=B0zBjARr;
	arc=pass header.oldest-pass=0 smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CC80606A332
	for <linux-block@vger.kernel.org>; Fri, 20 Nov 2026 14:59:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5CC80606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Z89hm29S;
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=B0zBjARr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1795186765;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Vz/9X/xDs27LNeUzfwpYSxQHLLpaMzHuDFNMaboauyg=;
	b=Z89hm29S5CRJTe7acG6K64lxDlw9xcGkpan2I3lFQ3cjGeNWOeTzeosu6UAtq3sKx2015+
	/QXmSToKPlRJBLvsUeURhVQJ4d72cR/Qc6jv8zK8euPwt3xop8GkRRopXODfwMJaB5sEg4
	yp3X1QTYRupI30Bfe/LdDi0czKb7xpU=
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-690-Bf3Md-cqMwWZmyv3fwfnzw-1; Fri, 20 Nov 2026 14:59:23 +0000
X-MC-Unique: Bf3Md-cqMwWZmyv3fwfnzw-1
X-Mimecast-MFC-AGG-ID: Bf3Md-cqMwWZmyv3fwfnzw_1795186763
Received: by mail-yw1-f200.google.com with SMTP id 00721157ae682-8b3342f229bso30194107b3.1
        for <linux-block@vger.kernel.org>; Fri, 20 Nov 2026 06:59:23 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795186763; cv=none;
        d=google.com; s=arc-20260327;
        b=cl3m3Frah2+z3F+7qRZltwa2uS8+nouUUK6gqm4+SHiLMO4XczXni5c/o2e1i234PO
         upwYcXT5h2EOVb5/Px+3SdEOzvTlEhoZ2d7vRAaPUamsW0TaJGlc7xoDJCCRNJC+TSof
         s6rsSQgG+dKg69xjznIqf0EtQN6IcQJgRj+ghZ296Q6uMBgEtRmi7FYkKUealM76wlMH
         adTNCIJLaM4WIGO0ukVzSp/jWK6EZIOIGAKMGalYPBY5yPVq+8n+lO9Cke87sYGrKsY6
         mD/8ExW0CgL75F/Glako6635c2DEeOyl7bAxFL9kS6i3woeG+pjVqY4fN8JH4Az+kq6x
         mzKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Vz/9X/xDs27LNeUzfwpYSxQHLLpaMzHuDFNMaboauyg=;
        fh=nKRPRr/JknA6FGWCqegjny2R/XBql0Dw1XL18QiO5Kw=;
        b=EwImHO7MkQzGkdVDrTlq43y8oDUsNEs1rBkMWE8CQnfZLFGtn9512ub88Qm3LFpZ11
         5cqaDDAf5ovnzGEDae190PI/01f8dsG7YAJkbtL/HtF21cWpzMW/6mxh71DQeNY4h2F3
         VGXvH1LzQY4QZ4wyUp2vy0H4NvStq+DYbzptPFKd0KJuwNI/Y+EKdKkNjMSY+tIj5uZb
         gyZiJruhSwXbH4UxOIW+Xz1/V966jjtL/uvlTBpUJ3dthCXdR0t48e6zfn7gpLAEpI++
         ctp2SZgU3oUS5jzS6qP+BdCG+rp8IWIAyGXM931xF7QvMj5bfBeOwlCQS0jGZ5WPdzKC
         rS0Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1795186763; x=1795791563; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Vz/9X/xDs27LNeUzfwpYSxQHLLpaMzHuDFNMaboauyg=;
        b=B0zBjARrRRH2r0deOfQjVsuOqCKgolcPVXf+fD+/upNOm1SI2J0Fj+8hY+BByh77wi
         wIo6WP2LnzMYME0yMogIOBTnsGlCbXTUWkqCLZN/JjBfYyGQDmkk6dem+2zXSG4IUPU3
         sND/wM0H9VP8wTirnvgOKk/zDLalvg4W6C811EM3SZHhOhR26YoOGkQGlXbr8vBxl0Tz
         eVd24Zbi2NKaHoSIjtsPBgsJlBRlh4Hg2qkwO08OMdkfbZkDKRyTfNWChbo+Mqrw60e3
         PhGL+twPKIBOEX4iy9sNF7fJMakMUXlyuUxULFZvbAglQSPDpBzodxHyQ1ofF8MysWpW
         nSfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795186763; x=1795791563;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Vz/9X/xDs27LNeUzfwpYSxQHLLpaMzHuDFNMaboauyg=;
        b=tIR5vHnfLFE9IhfZsdhAP9HPXshdeMkXX5TjfSNpRyQTlT7Aw8roC8BpR3q6mSnQ8N
         9sbo8G/GmYnRT3MsTQxTP/B4hjoGBPBQ1QpHISS+Z95O7OAF0WG2xKdmnz2KGH65jUxz
         /JYCC4wcdyRCpOVvst9Nx/bvZG4u4Y7gVQcKINpbyrgXryEj+C3TTp4/x9CGlRLKe9F+
         XBuzEwcS43/6xp/HfJ4iR/0hSfxSvVm3SNdXOouE1gtLJ3kBeVWpN+Nbj4LuYeRodcVv
         CxemVCYAQMAYGbdF81UnWjzr9n8cMpYzpZoxMzcb36IUSdez6TnFF1qrU92tvpF1Lxpp
         mfnw==
X-Forwarded-Encrypted: i=1; AL+hErGI6tz0Z42mUsrzLKG6bCPJ1GtWWFEqwQ+G8e7Cqo4x9jKrDcF6SV9i8yI/scomtUb9zQCaHLzN2OUeUw==@vger.kernel.org
X-Gm-Message-State: APuU4Z/WyXgYBjhjdQ7e4M1EsLZ1cwYRAQwTp3KKqKOiz6HMkM9vBOMu
	Ms++V73Gs/JtFccaFUk8iC1Ssd4iC2oAvnqrV/jACeCCKZclL9y+YoMCipcTwN8I1qT3TkBZvRl
	G3GvyR+b18SvSxc0mz3AYRJMEtT0YzglRnDdaeioBisU9RsYBjS0Ll9r/JyZOmU5paQ9XzvMbWP
	aGV5EC54PPjXCYdOAi4r/AbMLKo29ZcAj1261lWdY=
X-Gm-Gg: AZFdTZdDxNeaAsjQefzQ2ot/RQPF9Q5HnhJikS13S2BRlo4hDBPVR9EmQI7c1dgKRA0
	S+plJkcsVKbxdn/oEsrMX9kPK5AWqf+A2yt/tTIy1anLjP7d2pLnHvEshjC6yoyQMDCHvykIiMP
	lsqZXGzYFPnXPGu8YyLqdtUrNOUfgK3MEdRSwTtg0xJIi7fgj0j5S/bmO7MX/NzK3X75lxfhTf3
	z5VSuiUfd5FlPPdZ0b8nibW7Qdr9wT5VSbmJRFA9NcjAA==
X-Received: by 2002:a05:690c:6893:b0:8b0:8a77:e9b8 with SMTP id 00721157ae682-8b518d25cadmr18702417b3.4.1795186762631;
        Fri, 20 Nov 2026 06:59:22 -0800 (PST)
X-Received: by 2002:a05:690c:6893:b0:8b0:8a77:e9b8 with SMTP id
 00721157ae682-8b518d25cadmr18702267b3.4.1795186761947; Fri, 20 Nov 2026
 06:59:21 -0800 (PST)
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261120031305.3561045-1-huangsj@hygon.cn>
In-Reply-To: <20261120031305.3561045-1-huangsj@hygon.cn>
From: Andreas Gruenbacher <agruenba@redhat.com>
Date: Fri, 20 Nov 2026 15:59:10 +0100
X-Gm-Features: AclHuK92MT1vYW09O4Urhd7Yf7t3vir7SJ2k6LlnKDbNPNtVZYsZ96-h_yHunoE
Message-ID: <CAHc6FU7URHetBU9XgP0DSEGjWQfq0tX+ohK8xRVZLEYzgJBeEw@mail.gmail.com>
Subject: Re: [PATCH v3 0/11] vfs: add inode iteration methods
To: Huang Shijie <huangsj@hygon.cn>
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz, 
	hch@infradead.org, mic@digikod.net, axboe@kernel.dk, gnoack@google.com, 
	paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com, legion@kernel.org, 
	aleksa@amutable.com, libaokun@linux.alibaba.com, ebiggers@kernel.org, 
	djwong@kernel.org, sandeen@redhat.com, zhongyuan@hygon.cn, 
	fangbaoshun@hygon.cn, yingzhiwei@hygon.cn, wujianyong@hygon.cn, 
	shijie8@gmail.com, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, 
	gfs2@lists.linux.dev, linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 20, 2026 at 4:13=E2=80=AFAM Huang Shijie <huangsj@hygon.cn> wro=
te:
> This series adds two superblock inode iteration helpers,
> super_iter_inodes() and super_iter_inodes_locked(), and converts the
> open-coded sb->s_inodes walks in the VFS to them.  The design is based on
> Dave Chinner's patch set:
>   "vfs: improving inode cache iteration scalability"
>   https://lore.kernel.org/all/20241002014017.3801899-1-david@fromorbit.co=
m/
>
> About the two helpers:
>
>   int super_iter_inodes(struct super_block *sb, ino_iter_fn iter_fn,
>                         ino_iter_eligible_fn eligible, void *priv,
>                         int flags);
>
>   static inline int super_iter_inodes_locked(struct super_block *sb,
>                                              ino_iter_fn iter_fn,
>                                              void *priv);
>
>   - super_iter_inodes() runs @iter_fn with a referenced inode and with
>     sb->s_inode_list_lock __dropped__, so the callback is free to block a=
nd
>     to do whatever it wants with the inode except drop the reference the
>     iterator holds.  The iterator releases that one reference per inode
>     itself, so the callback cannot leave a dangling inode behind.
>     It is exported because GFS2 can be built as a module.
>
>   - super_iter_inodes_locked() keeps sb->s_inode_list_lock held for the
>     whole walk and takes no inode references at all.  Its callback
>     therefore only has an existence guarantee: it must not block and
>     must do its own inode state checks and its own reference handling.
>     It is internal to the VFS, being declared in fs/internal.h.
>
>   - The callback is separate from the caller's data, so a caller keeps
>     its state in its own structure instead of filling in a shared
>     context:
>
>       typedef int (*ino_iter_fn)(struct inode *inode, void *priv);
>
>   - %INO_ITER_F_REFERENCED restricts the safe iterator to inodes that
>     still have a reference.  It preserves the "only handle referenced
>     inodes" rule of landlock's sb-delete walk.
>
>   - %INO_ITER_F_NOREF does the opposite: only inodes whose reference
>     count has already reached zero are handed out.  %INO_ITER_F_NOIGET
>     suppresses the reference.  Neither keeps the inode alive, so the
>     caller must make it unclaimable itself.
>
>    Patch 1 adds super_iter_inodes().
>    Patch 2 adds super_iter_inodes_locked().
>    Patch 3-5 convert the callers which cannot use referenced inodes
>            (dquot removal, nr_blockdev_pages() and the
>            generic_shutdown_super() poisoning loop).
>    Patch 6-11 convert the remaining callers (inode eviction, sync_bdevs,
>            drop_pagecache_sb, add_dquot_ref, landlock's hook_sb_delete
>            and gfs2_evict_inodes()).
>
>
> BTW:
>   This patch set depends a small patch:
>   "fs/drop_caches: skip filesystems without fs writeback"
>   https://lkml.org/lkml/2026/9/23/675

That link doesn't work for me. When referring to other postings, can
you please use lore links?

There also is no posting of a patch with that title from that day on
https://lore.kernel.org/linux-fsdevel/. You may be referring to
https://lore.kernel.org/linux-fsdevel/20260920072811.2064247-2-huangsj@hygo=
n.cn/,
but that patch queue no longer applies. So please post patch queues in
a state that applies and optionally, make a git branch available.

(Also, enabling "git config --global format.useAutoBase whenAble" is a
possibility, but it wouldn't have helped in this case.

> v2-->v3:
>    -the callers' state no longer goes through a shared struct, the
>     callback now takes the caller's own @priv.
>
>    -super_iter_inodes() takes @eligible directly, so a caller can reject
>     an inode before the reference is paid for.
>
>    -rename super_iter_inodes_unsafe() to super_iter_inodes_locked() and
>     drop the rcu_read_lock(), which the list lock already covers.
>
>    -drop @ctx->prev; the resume point is gone with the unsafe iterator.
>
>    -evict_inodes() no longer goes through the locked iterator.
>     it now uses the unlocked iterator with INO_ITER_F_NOREF | INO_ITER_F_=
NOIGET.
>
>    -each caller gets its own patch.
>
>    v2: https://lore.kernel.org/all/20261113115702.586594-1-huangsj@hygon.=
cn/
>    v1: https://lore.kernel.org/all/20261015093854.2082600-1-huangsj@hygon=
.cn/
>
> Huang Shijie (11):
>   vfs: add super_iter_inodes()
>   vfs: add super_iter_inodes_locked()
>   fs/quota: convert remove_dquot_ref() to super_iter_inodes_locked()
>   block: convert nr_blockdev_pages() to super_iter_inodes_locked()
>   fs: convert generic_shutdown_super() poison loop
>   fs/inode: convert evict_inodes() to super_iter_inodes()
>   block: convert sync_bdevs() to super_iter_inodes()
>   fs/drop_caches: convert drop_pagecache_sb() to super_iter_inodes()
>   fs/quota: convert add_dquot_ref() to super_iter_inodes()
>   landlock: convert hook_sb_delete() to super_iter_inodes()
>   gfs2: convert gfs2_evict_inodes() to super_iter_inodes()
>
>  block/bdev.c                   | 101 ++++++++++--------------
>  fs/drop_caches.c               |  45 ++++-------
>  fs/gfs2/ops_fstype.c           |  29 ++-----
>  fs/inode.c                     |  61 ++++++---------
>  fs/internal.h                  |  31 ++++++++
>  fs/quota/dquot.c               | 139 ++++++++++++++++-----------------
>  fs/super.c                     | 106 ++++++++++++++++++++++---
>  include/linux/fs/super_types.h |  29 +++++++
>  security/landlock/fs.c         | 138 ++++++++++++--------------------
>  9 files changed, 370 insertions(+), 309 deletions(-)
>
> --
> 2.53.0

Thanks,
Andreas

