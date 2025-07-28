Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E719422FF35
	for <linux-block@vger.kernel.org>; Mon, 28 Jul 2025 09:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753694943; cv=none; b=oUNX9O9kP72w7z/i/s+eEK0CbyaAvcU6HMbN+nRvcG5WludLF3/EkaTCajaPuVrbJPxTyDocFXfzEK4+qCsXSYV2aYpAC0O1sjUrHHtesl5C+S012FH0PYUX8uB0TM4sRzb+7AbhniGMDk2dsjvJFv4/VRA5/5VmPO5iUC5mZz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753694943; c=relaxed/simple;
	bh=ipGjN5GwQxN2Uosq4k/gXtAfMKQ7uSaD2P1eQ+woUII=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tyYWMf3cwFJMwd8yN9GACpiBkuFgSKHSFEawTmtHe0eUfa1shHY4bDJt2nGI9MVYfKywNEJCfwTIqm/k7mnn5gQsHZeqOzpkgLRHmBzBViUdMoMvdUGUDIhOWCIRhkklc4wxLr9EVDaiqgYB4airHyHVUPBBH3kMN7GVECkVzrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=XhU+nFMx; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=lxPix4xk; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=XhU+nFMx; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=lxPix4xk; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="XhU+nFMx";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="lxPix4xk";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="XhU+nFMx";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="lxPix4xk"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 255BA2117C;
	Mon, 28 Jul 2025 09:29:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1753694940; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=o6bWuZUG4ep5oT8RNr8NTk+O09dTLi9Vqdh56x9MzXg=;
	b=XhU+nFMxz+Nx5o866XvzIerDc+FFcsW5Ab7ntRMyNeaqLvP6HhUUsRt93mufCgQNMivmhK
	K0jz2OgP5ocBWvHemfLdA49DGR7jqHDNCL7PxBBWbZqMWEKEACQeiIUlM36H33Y228DYUN
	VcMJen94WGuQENwUjDF/GYl20+kJne4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1753694940;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=o6bWuZUG4ep5oT8RNr8NTk+O09dTLi9Vqdh56x9MzXg=;
	b=lxPix4xkk17VaNo/qF99WSJfzaUtnMvsItufqIdyud5c3bNTMmFg4qW1epSFEic1BjnfUM
	AanmdWNTuXsW/ABw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1753694940; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=o6bWuZUG4ep5oT8RNr8NTk+O09dTLi9Vqdh56x9MzXg=;
	b=XhU+nFMxz+Nx5o866XvzIerDc+FFcsW5Ab7ntRMyNeaqLvP6HhUUsRt93mufCgQNMivmhK
	K0jz2OgP5ocBWvHemfLdA49DGR7jqHDNCL7PxBBWbZqMWEKEACQeiIUlM36H33Y228DYUN
	VcMJen94WGuQENwUjDF/GYl20+kJne4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1753694940;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=o6bWuZUG4ep5oT8RNr8NTk+O09dTLi9Vqdh56x9MzXg=;
	b=lxPix4xkk17VaNo/qF99WSJfzaUtnMvsItufqIdyud5c3bNTMmFg4qW1epSFEic1BjnfUM
	AanmdWNTuXsW/ABw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 193411368A;
	Mon, 28 Jul 2025 09:29:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id eboiBtxCh2gMLgAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 28 Jul 2025 09:29:00 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id CE641A09BE; Mon, 28 Jul 2025 11:28:59 +0200 (CEST)
Date: Mon, 28 Jul 2025 11:28:59 +0200
From: Jan Kara <jack@suse.cz>
To: Yu Kuai <yukuai@kernel.org>
Cc: jack@suse.cz, dlemoal@kernel.org, axboe@kernel.dk, 
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, yukuai3@huawei.com, 
	yi.zhang@huawei.com, yangerkun@huawei.com, johnny.chenyi@huawei.com
Subject: Re: [PATCH v2] blk-ioc: don't hold queue_lock for ioc_lookup_icq()
Message-ID: <64sbgvovtubkm2zelenee6pjkdciqlgqmri3bmycce6y265sy4@uptdqvz7g2lk>
References: <20250725180334.40187-1-yukuai@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250725180334.40187-1-yukuai@kernel.org>
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	FROM_HAS_DN(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	URIBL_BLOCKED(0.00)[suse.com:email,huawei.com:email,imap1.dmz-prg2.suse.org:helo,suse.cz:email];
	RCVD_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:email,suse.com:email]
X-Spam-Flag: NO
X-Spam-Level: 
X-Spam-Score: -3.80

On Sat 26-07-25 02:03:34, Yu Kuai wrote:
> From: Yu Kuai <yukuai3@huawei.com>
> 
> Currently issue io can grab queue_lock three times from bfq_bio_merge(),
> bfq_limit_depth() and bfq_prepare_request(), the queue_lock is not
> necessary if icq is already created because both queue and ioc can't be
> freed before io issuing is done, hence remove the unnecessary queue_lock
> and use rcu to protect radix tree lookup.
> 
> Noted this is also a prep patch to support request batch dispatching[1].
> 
> [1] https://lore.kernel.org/all/20250722072431.610354-1-yukuai1@huaweicloud.com/
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>

Looks good! Just one small comment below. With that fixed feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

> diff --git a/block/blk-ioc.c b/block/blk-ioc.c
> index ce82770c72ab..ea9c975aaef7 100644
> --- a/block/blk-ioc.c
> +++ b/block/blk-ioc.c
> @@ -308,19 +308,18 @@ int __copy_io(unsigned long clone_flags, struct task_struct *tsk)
>  
>  #ifdef CONFIG_BLK_ICQ
>  /**
> - * ioc_lookup_icq - lookup io_cq from ioc
> + * ioc_lookup_icq - lookup io_cq from ioc in io issue path
>   * @q: the associated request_queue
>   *
>   * Look up io_cq associated with @ioc - @q pair from @ioc.  Must be called
> - * with @q->queue_lock held.
> + * from io issue path, either return NULL if current issue io to @q for the
> + * first time, or return a valid icq.
>   */
>  struct io_cq *ioc_lookup_icq(struct request_queue *q)
>  {
>  	struct io_context *ioc = current->io_context;
>  	struct io_cq *icq;
>  
> -	lockdep_assert_held(&q->queue_lock);
> -
>  	/*
>  	 * icq's are indexed from @ioc using radix tree and hint pointer,
>  	 * both of which are protected with RCU.  All removals are done

In this comment there's still reference to holding 'q lock'. I think you
should replace that with justification why when called from IO issue path
we are guaranteed found pointer is safe to use. 

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
