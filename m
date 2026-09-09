Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55DA155C32E
	for <linux-block@vger.kernel.org>; Wed,  9 Sep 2026 13:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788959318; cv=pass; b=OGvhtNBfF2Tt5QBgyZ0xJPcyONfueM4StZbBPPU+I8+hKrErnWAmmV010AH6CjO7X1IhOEwVa7W5tGNfiGaw2wcVAyZ239A9EpEExBn5Zo8jsS48LXJRSNGclHYH84wUhWbP+uiMsvG61rqKmrKiFoovOaSfHb/aaOO88pZ6FIQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788959318; c=relaxed/simple;
	bh=ZfDt8S7Tc0KZXJPH2FTRtp7wfHfUNB5cPyGvFtf4FAk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JJF+77wfNkVoLZOaq0ktilJvkVL25ecGp2FmmPQ9x60vqrUniEwIqtydUKqao5/pMFELNzo9cc224OljooexWSv/qWMy91V3mvNXu/70LDaJ39QTt3LB82Vc/uSo9lfh89ene81CbX3a6co0hYmMw6LhRy4lwl1W0dEcQHeUClo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=Qb9UGjAV; arc=pass smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="Qb9UGjAV"
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-855c26cf490so42626627b3.0
        for <linux-block@vger.kernel.org>; Wed, 09 Sep 2026 06:08:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788959315; cv=none;
        d=google.com; s=arc-20260327;
        b=FR7bPaw9ARB44IJK30WW7U9vzikvU+OOQzjUOGfu82588oPePgsSz0AhGQjre8mCDa
         ZhIy103RyXhxgZY+imkRJ6sGMX4Uljjst4B0bj2sDZsSzKPmle6L6+9i/bcIdyd3xfjQ
         r7D5+Xg/eWdVmn//RCf8sbBWvTOmNrHuBKLk+z/GJru1+o7EKUMIo023q8CU1v4cKBp3
         W59ODPKl1JlBx6+vl9Yzn5wjA4qDXTgdOHiFbQIYxP4K59i7Jz6CliXN2GG4qa7l61e4
         T/7/N8gku0i/dtLOwvqIvRCUgnGOGip3hWwY/k2xgpgRBH/LU3DVNhikruyPQGLiKxhU
         Ji4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=UnhkoTwgBT+xmQamF4svidVUoLvRUKP0o6WY6qmR4PQ=;
        fh=e8sMW6CfF0wv192CNA+lBe9J3LwoxJQrAtLOk76RAmU=;
        b=LMfY5N0IjnobwfIcN0QKG/Bv3DJTHUqt5J6LZS1ChCdpqS7upqHx/ukFxvgs9UDqTO
         Z3deNs649Ip7KgJQCvhlaa1WWyFF/IcVepbc/asPSYdSWxCEOT3KX0USEWdNCEQOg1gZ
         QkJ/VElGL27MN6xvjMjaERflKqdaZrkDjcaGXoJ3DzDKjQ4yFbgw+zN07h1gELuw4PnV
         oTXl6SaxmxhsQaoHD991qx6D7BbOpwMTGIRJOxBLfVFgo3otB6yFBzpoEABry9ZXe7bI
         Fv095Buae/yieatm/6McwGRjyi8PmER7hQiGlUtim5ZlN1CFKNs3GcEPxmV5//Q8hW0w
         Affg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1788959315; x=1789564115; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=UnhkoTwgBT+xmQamF4svidVUoLvRUKP0o6WY6qmR4PQ=;
        b=Qb9UGjAVto1hqlABO50D88kOJF0JZ2dGlk6oXEXMhaHhOyBTMzGe5wv7wyrOooglE9
         vwpbR54BgoGDFnvTKeW+KClQ1zwSYP415Wc3zdeD2j55dVAALTg6r885+/Ie2XOMs2pE
         yn7ZN8i0MEY1zDTuu9s5e4a8V/sgXh0rasC/sFTe1pyyeg0E5hoZBZHPL68TKUrAKyhA
         xOkLUZzevL9+mcJwfF911jlDxInnL8k8M0R70yXPEhOzW/BM29DYFiexgYGgFu+Ys5un
         z8SdKYsvKiExUTWw8CSG5hcOgtmYRWDlfSGHdVJG2T94JuMxAd9xMy5zXQAcKYYxZ9et
         PWnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788959315; x=1789564115;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UnhkoTwgBT+xmQamF4svidVUoLvRUKP0o6WY6qmR4PQ=;
        b=Kr0u8gPqd+E+Y/LdltsU5ZTNpi6hagcQqF6DpFPRU2tMKvJGjbcb8JUKKbHIPDHs5Y
         z2iNzyBYiDwEB9jLUj5L/ojWrj9kNvRTyMhEgDH7sIwboaOFDRNi1m6nmqrawvfCMk1a
         BdfhR04R3i1tXXHtCjghrRuSRk+KliCWrWNbB4p/IrwBc2To5PHapEK4RF9hX98zSyK0
         tuYzdviBwA+0P3dSWm2Q4x9ZKneacMnhdJTuno4jmVLtpxnlXhNRrOhZUUPfIUlV4kLO
         fz6GdV0BG6UE3o1a6Tntch3YnNCpLxC+KehSas1gwyQOipp2CpFvaBiASzOeyZX+cNlN
         AboA==
X-Gm-Message-State: AFuF++kO/NSEKbFe6M17IEwiPjZlQCA2Uf2uPEzcHf/4HdsCojqEmr9W
	9EwyNqoFM3cEv/XM9Uj1i3AUXiMfdlxNbmvMUD2OzZqba0J5FCAwD51JWxF6i2vC5ozllXTEYx0
	M6DyBTRxnoz4QbgNrW+0P0K5SVhTTY9dz9vW+V5fdaQ==
X-Gm-Gg: AYBFou2DBpkELG3Fo3KlDWFrLp3Va3M+H4O19h1hKFRvuiT/6NnegRldFR3Lf89YUNT
	b5W177t3mShwih92+8XUf2CneyUVk9lX6NqHvX34vBx5+k+GA282hpauzIvWgnIK6w9oBpjz71o
	2i0HE9DjMuLugjbmSkWm6mmH7iShRYd9qd0hj3JjIeuwBWcgfzPjowX73uBneTAg7iFVXqMna8Q
	i8gv4hpR6EsTMbtHiFiNYXL1398Plr+p6dUuZk4CEBEeIkgiq94cj91kWyJqSArJw5skv88f+jv
	uyX/dZiWR2KrPStvS81teb0d7iB0dVlrkP1TNFIpBF0WIPJQ2T5SnR70VQ==
X-Received: by 2002:a05:690c:e64e:b0:870:7983:948a with SMTP id
 00721157ae682-8712259c772mr89107647b3.4.1788959314936; Wed, 09 Sep 2026
 06:08:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260909090112.790006-1-sunjunchao@bytedance.com> <pblp6tof6t6otp5kzelc3pyu2y2si4e7i62kp63c5symdaqrd3@q7drqoro2b73>
In-Reply-To: <pblp6tof6t6otp5kzelc3pyu2y2si4e7i62kp63c5symdaqrd3@q7drqoro2b73>
From: Julian Sun <sunjunchao@bytedance.com>
Date: Wed, 9 Sep 2026 21:08:23 +0800
X-Gm-Features: AcwNN1U41_g-qadIrai6fD3kTUCArV1yDblgph8PCD2WJC1KBtLwz2cU_4D4HKM
Message-ID: <CAHSKhteB4aK_EtuZOBsjN-tmyqS-ycGAP3gxMsdfU3pVAH+9JA@mail.gmail.com>
Subject: Re: [External] Re: [PATCH 0/7] fs: preserve superblock inode walk
 positions across lock drops
To: Jan Kara <jack@suse.cz>
Cc: linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	gfs2@lists.linux.dev, linux-security-module@vger.kernel.org, 
	agruenba@redhat.com, mic@digikod.net, gnoack@google.com, paul@paul-moore.com, 
	jmorris@namei.org, serge@hallyn.com, aleksa@amutable.com, legion@kernel.org, 
	djwong@kernel.org, ebiggers@kernel.org, sandeen@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 9, 2026 at 8:49=E2=80=AFPM Jan Kara <jack@suse.cz> wrote:
>
> On Wed 09-09-26 17:01:05, Julian Sun wrote:
> > [Motivation]
> >
> > We observed hung tasks in production during disk hotplug operations. A
> > kernel thread spends a long time in evict_inodes() while holding s_umou=
nt,
> > blocking other users of that lock and causing further stalls.
> >
> > The problem is that evict_inodes() restarts its walk from the head of
> > sb->s_inodes every time it reschedules. When a large number of referenc=
ed
> > inodes remain near the head, each restart scans those inodes again with=
out
> > making progress through that part of the list. The repeated scans can
> > delay eviction long enough to trigger hung-task reports. This is the sa=
me
> > problem that [1] attempted to address.
>
> Thanks fro the patch! What's really unexpected is that there are many
> inodes with incremented refcount at the time when evict_inodes() is calle=
d.
> Did you have a look who's holding those references? Or is evict_inodes()
> called through the fs_bdev_mark_dead() call (as you mention "disk hotplug
> operations")? There the filesystem is in fact in use so what you describe
> makes some sense.

Yes, the filesystem was still in use, and the disk was unplugged
directly without being unmounted. As a result, `fs_bdev_mark_dead()`
holds the `s_umount` lock and performs a large number of redundant
traversals, which takes a significant amount of time.
>
>                                                                 Honza
>
> > [Approach]
> >
> > This series introduces sb_for_each_inodes() for two purposes:
> >
> >   1. Consolidate open-coded s_inodes walks behind a common entry point.
> >   2. Retain each walk's position across drops of s_inode_list_lock.
> >
> > The iterator mechanism follows the approach used by cgroup task iterati=
on,
> > such as css_task_iter_next(). Active iterators are registered on a sepa=
rate
> > list, sb->s_inodes_iters. Before removing an inode from s_inodes, the
> > removal path advances any iterator whose next position points to that
> > inode. These updates are protected by s_inode_list_lock, so a walker ca=
n
> > drop the lock and later resume from its saved position.
> >
> > Existing walkers, such as drop_pagecache_sb() and add_dquot_ref(), alre=
ady
> > contain their own position-preserving logic: they carry an inode refere=
nce
> > across iterations so that they can resume after dropping the list lock.
> > Moving that responsibility into sb_for_each_inodes() simplifies these
> > callers and lets their callbacks focus on the per-inode work.
> >
> > Patch 1 removes trailing whitespace from include/linux/fs.h.
> > Patch 2 introduces sb_for_each_inodes().
> > The remaining patches convert existing walks to the new interface.
> > remove_dquot_ref() and nr_blockdev_pages() are left unchanged: their
> > walks are simple and do not require the inode->i_lock locking imposed
> > by the callback interface. Converting them would add an unnecessary
> > lock/unlock overhead for every inode.
> >
> > [Testing]
> >
> > I tested this series with approximately 20 hours of xfstests case
> > execution, repeatedly running the auto group on ext4 and XFS, no new
> > issues were observed. And with this patch applied, the hung task that
> > previously occurred on every run no longer occurs.
> >
> > [1] https://lore.kernel.org/all/20241118114508.1405494-1-yebin@huaweicl=
oud.com/
> >
> > Julian Sun (7):
> >   fs: remove trailing whitespace from include/linux/fs.h
> >   fs: introduce sb_for_each_inodes().
> >   block: use sb_for_each_inodes() in sync_bdevs()
> >   fs: use sb_for_each_inodes() API.
> >   gfs2: use sb_for_each_inodes() for cooperative eviction
> >   quota: use sb_for_each_inodes() in add_dquot_ref()
> >   landlock: use sb_for_each_inodes() when detaching a superblock
> >
> >  block/bdev.c                   |  85 +++++++++----------
> >  fs/drop_caches.c               |  44 +++++-----
> >  fs/gfs2/ops_fstype.c           |  38 ++++-----
> >  fs/inode.c                     | 142 +++++++++++++++++++++++--------
> >  fs/quota/dquot.c               |  72 ++++++----------
> >  fs/super.c                     |   1 +
> >  include/linux/fs.h             |  29 +++++--
> >  include/linux/fs/super_types.h |   3 +-
> >  security/landlock/fs.c         | 150 +++++++++++++--------------------
> >  9 files changed, 295 insertions(+), 269 deletions(-)
> >
> > --
> > 2.39.5
> >
> --
> Jan Kara <jack@suse.com>
> SUSE Labs, CR


Thanks,
--=20
Julian Sun <sunjunchao@bytedance.com>
