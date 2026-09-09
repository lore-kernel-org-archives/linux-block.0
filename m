Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F14DD470126;
	Wed,  9 Sep 2026 12:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788958186; cv=none; b=ofRAwXAcvFwmAMyYVlAQKatLQLpxL9WLwZgytUKGLmetCH19Ke5zoKfHURbD/mgxYARxZyxGXs+hrcy2GN9+/wa1vxRFB9MSY2AaJssa3lgCkJu+EIuIn3PtbHB0nfrzJFklXBhnK1zlUAOKpV1gaI4X7Gz0T9YTXdnxNR/ryrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788958186; c=relaxed/simple;
	bh=DBQWEHM3jrN2FVzsBxr3gsWXU+aylsZsZB+RFB3RsEs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rev29HWnX9NFN4PEk6aM04/uQkCia9mt5uI2LwH4pTm/0CR6WZ5QnGQQwZsNIDgv+nsOJiyxiNIreGPbcA3m1uuB4AZX4Nt+tqPXEsJ0aJyra4yWC1vsVBDt12G5yu5YwXll6qAAPEbDg+ixvOq6m1zL3jw9BHCV5oyQJ3pVufc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=QHljj4VD; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=UMTn0Azr; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=P9RWyaRk; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=bDqeb262; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="QHljj4VD";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="UMTn0Azr";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="P9RWyaRk";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="bDqeb262"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id CC9FE1FB1B;
	Wed,  9 Sep 2026 12:49:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1788958178; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zJ28I44WC1hV/fcazHq+zh9oF5Kw7tVrRZFS4+h4cIo=;
	b=QHljj4VDlP/zthNypyuOZgp5uQVAkNR2bS4FPsPD65WnSVkqy5z/Z0n2qaGp9DbhLnHbWE
	VMM6PkCHPE0+ZQxcgaQDEORJaTgsXSUE7jsoLOjOlGGYF8DaZWLK+v2Cs5m33qCt891DT/
	d9IkwmaCNrlZRbXfQR6tZKNE55JiQ+w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1788958178;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zJ28I44WC1hV/fcazHq+zh9oF5Kw7tVrRZFS4+h4cIo=;
	b=UMTn0AzrPC9x95UVUz7027vim/arTY1o2Xmsp2UCwvXBBD/6CnuE1xrs7LHexyHHxhlyfb
	6LroVzgY+KFUpkDA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=P9RWyaRk;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=bDqeb262
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1788958173; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zJ28I44WC1hV/fcazHq+zh9oF5Kw7tVrRZFS4+h4cIo=;
	b=P9RWyaRkvyLPw16YhLxAHejCRwsLfVqv7/3GPx3WGRjLnzPPi/npOA/WZymPjMfhXClIqz
	O9Rp9p/d6OmPg5ZMTvHFoVxX7P6zOixrf6kK8iMQTaGHzORwrgUGaBeC5x6qa+k4Hx/MZw
	RSJqNxWI7QRjP350AQqkyzJ4zWjLiRs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1788958173;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zJ28I44WC1hV/fcazHq+zh9oF5Kw7tVrRZFS4+h4cIo=;
	b=bDqeb262wWtjF3eaCVsPNY07h/1D0dJZg4AZbVWzuSJGYEpFtKvJ3m74dChlukwGVMbl8N
	t37clwbmpxWYXuAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A9FBC13185;
	Wed,  9 Sep 2026 12:49:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id WQ13Kd1VoWqZTQAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 09 Sep 2026 12:49:33 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 38AC5A1341; Wed, 09 Sep 2026 14:49:33 +0200 (CEST)
Date: Wed, 9 Sep 2026 14:49:33 +0200
From: Jan Kara <jack@suse.cz>
To: Julian Sun <sunjunchao@bytedance.com>
Cc: linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	gfs2@lists.linux.dev, linux-security-module@vger.kernel.org, jack@suse.cz, 
	agruenba@redhat.com, mic@digikod.net, gnoack@google.com, paul@paul-moore.com, 
	jmorris@namei.org, serge@hallyn.com, aleksa@amutable.com, legion@kernel.org, 
	djwong@kernel.org, ebiggers@kernel.org, sandeen@redhat.com
Subject: Re: [PATCH 0/7] fs: preserve superblock inode walk positions across
 lock drops
Message-ID: <pblp6tof6t6otp5kzelc3pyu2y2si4e7i62kp63c5symdaqrd3@q7drqoro2b73>
References: <20260909090112.790006-1-sunjunchao@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260909090112.790006-1-sunjunchao@bytedance.com>
X-Spam-Level: 
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: CC9FE1FB1B
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_TWELVE(0.00)[17];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.cz:dkim];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
	RCVD_COUNT_THREE(0.00)[3];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Spam-Flag: NO
X-Spam-Score: -4.01

On Wed 09-09-26 17:01:05, Julian Sun wrote:
> [Motivation]
> 
> We observed hung tasks in production during disk hotplug operations. A
> kernel thread spends a long time in evict_inodes() while holding s_umount,
> blocking other users of that lock and causing further stalls.
> 
> The problem is that evict_inodes() restarts its walk from the head of
> sb->s_inodes every time it reschedules. When a large number of referenced
> inodes remain near the head, each restart scans those inodes again without
> making progress through that part of the list. The repeated scans can
> delay eviction long enough to trigger hung-task reports. This is the same
> problem that [1] attempted to address.

Thanks fro the patch! What's really unexpected is that there are many
inodes with incremented refcount at the time when evict_inodes() is called.
Did you have a look who's holding those references? Or is evict_inodes()
called through the fs_bdev_mark_dead() call (as you mention "disk hotplug
operations")? There the filesystem is in fact in use so what you describe
makes some sense.

								Honza

> [Approach]
> 
> This series introduces sb_for_each_inodes() for two purposes:
> 
>   1. Consolidate open-coded s_inodes walks behind a common entry point.
>   2. Retain each walk's position across drops of s_inode_list_lock.
> 
> The iterator mechanism follows the approach used by cgroup task iteration,
> such as css_task_iter_next(). Active iterators are registered on a separate
> list, sb->s_inodes_iters. Before removing an inode from s_inodes, the
> removal path advances any iterator whose next position points to that
> inode. These updates are protected by s_inode_list_lock, so a walker can
> drop the lock and later resume from its saved position.
> 
> Existing walkers, such as drop_pagecache_sb() and add_dquot_ref(), already
> contain their own position-preserving logic: they carry an inode reference
> across iterations so that they can resume after dropping the list lock.
> Moving that responsibility into sb_for_each_inodes() simplifies these
> callers and lets their callbacks focus on the per-inode work.
> 
> Patch 1 removes trailing whitespace from include/linux/fs.h.
> Patch 2 introduces sb_for_each_inodes().
> The remaining patches convert existing walks to the new interface.
> remove_dquot_ref() and nr_blockdev_pages() are left unchanged: their
> walks are simple and do not require the inode->i_lock locking imposed
> by the callback interface. Converting them would add an unnecessary
> lock/unlock overhead for every inode.
> 
> [Testing]
> 
> I tested this series with approximately 20 hours of xfstests case
> execution, repeatedly running the auto group on ext4 and XFS, no new
> issues were observed. And with this patch applied, the hung task that
> previously occurred on every run no longer occurs.
> 
> [1] https://lore.kernel.org/all/20241118114508.1405494-1-yebin@huaweicloud.com/
> 
> Julian Sun (7):
>   fs: remove trailing whitespace from include/linux/fs.h
>   fs: introduce sb_for_each_inodes().
>   block: use sb_for_each_inodes() in sync_bdevs()
>   fs: use sb_for_each_inodes() API.
>   gfs2: use sb_for_each_inodes() for cooperative eviction
>   quota: use sb_for_each_inodes() in add_dquot_ref()
>   landlock: use sb_for_each_inodes() when detaching a superblock
> 
>  block/bdev.c                   |  85 +++++++++----------
>  fs/drop_caches.c               |  44 +++++-----
>  fs/gfs2/ops_fstype.c           |  38 ++++-----
>  fs/inode.c                     | 142 +++++++++++++++++++++++--------
>  fs/quota/dquot.c               |  72 ++++++----------
>  fs/super.c                     |   1 +
>  include/linux/fs.h             |  29 +++++--
>  include/linux/fs/super_types.h |   3 +-
>  security/landlock/fs.c         | 150 +++++++++++++--------------------
>  9 files changed, 295 insertions(+), 269 deletions(-)
> 
> -- 
> 2.39.5
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
