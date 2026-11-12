Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794474589;
	b=LzfZ6Rtrd0Ly89hPO2J8xURxJMbwltofREf2a/MunBpcl0Lko8pUh7M8rL4F/X4I2MjQ
	 T5jIY2mlrBfw/IZJtYEDpUQHCiwzB5h1qiQqM6FiaxZdvTk9HTc4dGOmaNogoqsaqjzTZ
	 9PZ8BtOPEZ02ScNPuxFS/vSRf2tJpzfungfxMF2Z7lKWWNeYJwCeaoEqX95AOqcRy/+4S
	 szj6n+HovRWYsyh+RYlWSqIBpti7Kohad7gdoz2xUDc0O6Mu0xETSPARvBIW+zsDwxwKA
	 CRDn5ZYqOnnVc3bH/sqriYmtDI/NTqe9361DOlTJLmo8MnXNJgEep0lUQVayFbwVueg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794474589;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Spamd-Result:X-Rspamd-Server:X-Rspamd-Action:X-Spam-Flag:
	 X-Spam-Score:X-Spam-Level:X-Rspamd-Queue-Id;
	bh=uCDrkEYxV2ULCH5YyNEcivwL1pA4Zyk7Fz79VpMLnvA=;
	b=Fztb/N6NGpn23GAaBChJre3fqic9C151DVxd9HfBiCznA+WqRrZu1W88gfiHDEV4U6xW
	 jJ4z1fHdauL4roE8JkGObpbg6iE3ZwGDd7XUVFz0D7qgLlS87d9nt+jro+hpaEQlpcmzz
	 Gbi3GdGZu9mWul0330+CTedW+ykpExfntngKEf7ck9QH7Jx5rsqEJBBz5LAQ72nJcCbXT
	 50VDBMmVya5DlKJRkD3UJBWv5i1q54Hm8MYe0UXcfi5v6qyS9cC4U3/jR+GEYgRFeATwN
	 11ZrMozs3b2jR/brya4GnuAA6awNBiQPLawRndYMZJ5550y2uzgg7ENDgbOHSv9iWWg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.de;
	spf=pass smtp.mailfrom=suse.de;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=OwYUwF+T;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=0mhjkOKZ;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=OwYUwF+T;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=0mhjkOKZ;
	arc=none smtp.remote-ip=195.135.223.131
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B755606A335;
	Thu, 12 Nov 2026 09:09:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1B755606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=OwYUwF+T;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=0mhjkOKZ;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=OwYUwF+T;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=0mhjkOKZ
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 3854B1F390;
	Thu, 12 Nov 2026 09:09:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1794474587; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uCDrkEYxV2ULCH5YyNEcivwL1pA4Zyk7Fz79VpMLnvA=;
	b=OwYUwF+ThKZk+4PAeOfovoKumVG42D4uOCNPDwI5m+lj+VPAGvAGMjdZeHUTtkhReCXLGe
	ko3Xt9hw5UIVNwbUJ/oEZArmXoFj5JwlhMgkNcJTp8jQnkURJLUIZlol3nuGyIV9xsEINt
	wBnu2Gbf1dWUVjObsbyBCHGsEkQkMEM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1794474587;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uCDrkEYxV2ULCH5YyNEcivwL1pA4Zyk7Fz79VpMLnvA=;
	b=0mhjkOKZdj37Nev2rjX+G2XzkaBUF1DfkKh/T9yga2ENd3vdfgHoZDBspb1nBpWJCWT95Q
	r/bwQdrwYKi9ItCQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=OwYUwF+T;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=0mhjkOKZ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1794474587; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uCDrkEYxV2ULCH5YyNEcivwL1pA4Zyk7Fz79VpMLnvA=;
	b=OwYUwF+ThKZk+4PAeOfovoKumVG42D4uOCNPDwI5m+lj+VPAGvAGMjdZeHUTtkhReCXLGe
	ko3Xt9hw5UIVNwbUJ/oEZArmXoFj5JwlhMgkNcJTp8jQnkURJLUIZlol3nuGyIV9xsEINt
	wBnu2Gbf1dWUVjObsbyBCHGsEkQkMEM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1794474587;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uCDrkEYxV2ULCH5YyNEcivwL1pA4Zyk7Fz79VpMLnvA=;
	b=0mhjkOKZdj37Nev2rjX+G2XzkaBUF1DfkKh/T9yga2ENd3vdfgHoZDBspb1nBpWJCWT95Q
	r/bwQdrwYKi9ItCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id F216C134A0;
	Thu, 12 Nov 2026 09:09:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ejR1M1qC9WoocQAAD6G6ig
	(envelope-from <dwagner@suse.de>); Thu, 12 Nov 2026 09:09:46 +0000
Date: Thu, 12 Nov 2026 10:09:31 +0100
From: Daniel Wagner <dwagner@suse.de>
To: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>
Cc: Ming Lei <ming.lei@redhat.com>, Surabhi Gogte <sgogte@purestorage.com>, 
	Hannes Reinecke <hare@kernel.org>, Nilay Shroff <nilay@linux.ibm.com>, 
	Frederic Weisbecker <frederic@kernel.org>, Aaron Tomlin <atomlin@atomlin.com>, 
	Maurizio Lombardi <mlombard@redhat.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	linux-block@vger.kernel.org, linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] blk-mq: use a housekeeping CPU for passthrough
 requests on isolated hctxs
Message-ID: <a979c78b-40f9-4777-b76f-fb257120a93c@flourine.local>
References: <20261103-nvme-fabrics-isolcpu-v2-1-95ec70d58254@suse.de>
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261103-nvme-fabrics-isolcpu-v2-1-95ec70d58254@suse.de>
X-Spamd-Result: default: False [-13.51 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_TWELVE(0.00)[15];
	MISSING_XM_UA(0.00)[];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:email,suse.de:dkim];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -13.51
X-Spam-Level: 
X-Rspamd-Queue-Id: 3854B1F390

On Tue, Nov 03, 2026 at 03:57:22PM +0100, Daniel Wagner wrote:
> blk_mq_alloc_request_hctx uses the first online CPU in hctx->cpumask to
> select the software context for a request.
> 
> Since commit a46c27026da1 ("blk-mq: don't schedule block kworker on
> isolated CPUs"), hctx->cpumask excludes isolated CPUs. If a hardware
> context is mapped only to isolated CPUs, the mask is empty and
> blk_mq_alloc_request_hctx fails with -EXDEV.
> 
> The NVMe fabrics transports use blk_mq_alloc_request_hctx to allocate
> the Connect command for each I/O queue. As a result, connecting to a
> controller can fail when using isolcpus=domain or an isolated cpuset
> partition.
> 
> Passthrough requests bypass the software queues and go directly to
> hctx->dispatch. Their software context is only used to select the
> completion CPU and as a hint when freeing the tag.
> 
> Use the software context of an online housekeeping CPU for passthrough
> requests.
> 
> Fixes: a46c27026da1 ("blk-mq: don't schedule block kworker on isolated CPUs")
> Tested-by: Maurizio Lombardi <mlombard@redhat.com>
> Signed-off-by: Daniel Wagner <dwagner@suse.de>
> ---
> Connecting a fabrics controller fails when all CPUs of a hardware
> context are isolated with isolcpus=domain or an isolated cpuset
> partition. Since commit a46c27026da1 ("blk-mq: don't schedule block
> kworker on isolated CPUs") the CPU mask of such a hardware context is
> empty and blk_mq_alloc_request_hctx() fails the Connect command with
> -EXDEV. This patch lets passthrough requests use the software context
> of a housekeeping CPU instead.
> 
> The nvme fabrics fixes from v1 (patches 1 and 3-5) are in nvme-7.4, so
> only the blk-mq patch is left. The blktest for this patch is nvme/070,
> posted separately.

Keith, Jens: any chance to get this one picked up?

Thanks,
Daniel
