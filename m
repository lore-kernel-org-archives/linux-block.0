Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71A1635FF50
	for <linux-block@vger.kernel.org>; Thu, 26 Feb 2026 18:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772129054; cv=none; b=KQRM3IGj2fpZLegkng2El9HKQVskVbR2e26iukAJqTD2aJi9HpkVhy+TkW6cpBBQ9IQC+YNyuQ9GIslF1uriN5J41Orcix9SBMEqPkp/FamvSPEwgeV6LGH79RPN0eH3d9r4rVLpIYXq1JAC05lS5AIfQW+IONplJYf15hPzJh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772129054; c=relaxed/simple;
	bh=fKuMQg0ldtZHKTse9XiKRNDeaT11C/n6qWR3+E4swRw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l7BGhzdhtowRz0vkpgyxhhAG3mnko6y89E8HgCVvnYnHtWNdnOKbFwQryKcJd9fHnQ96szrOVTcCFFe5RmZdQ26U7dfZn5q6+ki1e8Yvf0WyIrqmNRZ1b1D/G8TK+CZao2lhsutrPBKrP17DjOwJcpKJro4KmDYWlgPpxSj3xVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ABg26jN5; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=yxK92OaI; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ABg26jN5; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=yxK92OaI; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ABg26jN5";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="yxK92OaI";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ABg26jN5";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="yxK92OaI"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id A6A0A4D372;
	Thu, 26 Feb 2026 18:04:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1772129050; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Bw/pxMCs3PGZ3t1xDbLU2eOlXd2FRM6wCa/DdIh9vIw=;
	b=ABg26jN5sboOiEbl5mP+ymHsjVlzRkzTWU3bUObNqTlzwN3AvDMtymW7EOU6+A0WAT/Xz3
	bn2QUhGjXnjp9DtTQr7G+ZucZ7cTITq8CtiR1F+OEU9HtAMG84jWnw4gi6ffjtUW2tPq0h
	Cbi5zVZRytmf/6jYXpkGdjlXGE7jI34=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1772129050;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Bw/pxMCs3PGZ3t1xDbLU2eOlXd2FRM6wCa/DdIh9vIw=;
	b=yxK92OaIInZOuWsYJVe12akQvMahjC0j0h1rnulH/CXOsA3ISY/56bvMtNLVX7NAn80XCP
	YhNS71eeOaKifODw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=ABg26jN5;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=yxK92OaI
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1772129050; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Bw/pxMCs3PGZ3t1xDbLU2eOlXd2FRM6wCa/DdIh9vIw=;
	b=ABg26jN5sboOiEbl5mP+ymHsjVlzRkzTWU3bUObNqTlzwN3AvDMtymW7EOU6+A0WAT/Xz3
	bn2QUhGjXnjp9DtTQr7G+ZucZ7cTITq8CtiR1F+OEU9HtAMG84jWnw4gi6ffjtUW2tPq0h
	Cbi5zVZRytmf/6jYXpkGdjlXGE7jI34=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1772129050;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Bw/pxMCs3PGZ3t1xDbLU2eOlXd2FRM6wCa/DdIh9vIw=;
	b=yxK92OaIInZOuWsYJVe12akQvMahjC0j0h1rnulH/CXOsA3ISY/56bvMtNLVX7NAn80XCP
	YhNS71eeOaKifODw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8C0A53EA62;
	Thu, 26 Feb 2026 18:04:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id PXyWHhmLoGk6fQAAD6G6ig
	(envelope-from <pfalcato@suse.de>); Thu, 26 Feb 2026 18:04:09 +0000
Date: Thu, 26 Feb 2026 18:04:07 +0000
From: Pedro Falcato <pfalcato@suse.de>
To: syzbot <syzbot+709f5ab0e03871dec50a@syzkaller.appspotmail.com>
Cc: Liam.Howlett@oracle.com, akpm@linux-foundation.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, lorenzo.stoakes@oracle.com, 
	shakeel.butt@linux.dev, surenb@google.com, syzkaller-bugs@googlegroups.com, 
	vbabka@suse.cz, netdev@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>, 
	linux-block@vger.kernel.org, Eric Dumazet <edumazet@google.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Jakub Kicinski <kuba@kernel.org>
Subject: Re: [syzbot] [mm?] possible deadlock in lock_mm_and_find_vma (4)
Message-ID: <btgotj7xgnzgoqwkfwk3pviof4cd6dnhxes3g32ncxz5ogcslk@epki2rug5yor>
References: <69a05ea3.050a0220.305b49.0022.GAE@google.com>
 <ibhdm4y3cwmornxfyxckosbznmtx3hi37tdp4xvha7a7wyaktp@rkrjyxdqmgb2>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ibhdm4y3cwmornxfyxckosbznmtx3hi37tdp4xvha7a7wyaktp@rkrjyxdqmgb2>
X-Spamd-Result: default: False [-2.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[709f5ab0e03871dec50a];
	DKIM_TRACE(0.00)[suse.de:+];
	MISSING_XM_UA(0.00)[];
	SUBJECT_HAS_QUESTION(0.00)[]
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -2.51
X-Spam-Level: 
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: A6A0A4D372

On Thu, Feb 26, 2026 at 05:40:26PM +0000, Pedro Falcato wrote:
> +Cc netdev, block, nbd people
> 
> On Thu, Feb 26, 2026 at 06:54:27AM -0800, syzbot wrote:
> <snip>
> > 
> > Chain exists of:
> >   fs_reclaim --> k-sk_lock-AF_INET6 --> &mm->mmap_lock
> > 
> >  Possible unsafe locking scenario:
> > 
> >        CPU0                    CPU1
> >        ----                    ----
> >   rlock(&mm->mmap_lock);
> >                                lock(k-sk_lock-AF_INET6);
> >                                lock(&mm->mmap_lock);
> >   lock(fs_reclaim);
> > 
> >  *** DEADLOCK ***
> > 
> > 2 locks held by syz.3.3387/17804:
> >  #0: ffffffff905e2228 (br_ioctl_mutex){+.+.}-{4:4}, at: br_ioctl_call+0x34/0xa0 net/socket.c:1225
> >  #1: ffff88807ad4b440 (&mm->mmap_lock){++++}-{4:4}, at: mmap_read_trylock include/linux/mmap_lock.h:611 [inline]
> >  #1: ffff88807ad4b440 (&mm->mmap_lock){++++}-{4:4}, at: get_mmap_lock_carefully mm/mmap_lock.c:441 [inline]
> >  #1: ffff88807ad4b440 (&mm->mmap_lock){++++}-{4:4}, at: lock_mm_and_find_vma+0x35/0x6f0 mm/mmap_lock.c:501
> >
> 
> It looks to me like the issue is:
>  setsockopt(nbd_sock) -> takes sk_lock -> copy_from_user -> page fault ->
>    mmap_lock -> allocation needs reclaim -> fs_reclaim -> fs does IO -> nbd
>    grabs sk_lock -> deadlock
> 

Another funny case that came to me just now:
sendmsg(nbd_sock) -> lock_sock(nbd_sock) -> tcp_sendmsg_locked(nbd_sock) ->
copy_from_user() -> if VMA is backed by file on nbd bdev -> ... ->
lock_sock(nbd_sock)

Right? Is there something extremely crucial that I'm missing?

-- 
Pedro
