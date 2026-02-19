Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A56B1ADFE4
	for <linux-block@vger.kernel.org>; Thu, 19 Feb 2026 12:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771503248; cv=none; b=q8Id2FIu6gEsG5t42XMtlBGLj6Qam+SlisLjQZR0XDf0DbiOgygnlfyUxicVrriIw8wcnUpeaZCzpcfG5eRJmc8FU4Xoa9pnEsjB5K4eTXq8MEnjTtHk92t9N9zd92vckS0kw5mh1zORtwaliMsB8K86nQnDvqecwXyiFoYdVEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771503248; c=relaxed/simple;
	bh=RQu4tJs60xdq+FxNO6ebyC/5Rq7HEk9/2uiSa/HFxLo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bkvSsV576Sw3oS8VaPkQhDtDaI5BLiyvlCkkqO3TNG12+GfL5Kc0JbtRIjJeNWiF8FbrGnIavn+Zqmwum6ubHTcfrSNK8xVfz3aKVBp+sEdqeE8cZtntKtkYBkNVhQp+Vg9qGggWMXbaA/syJGlo8OU5msBi0xIX92EYv7YP4rk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=MB22uO6+; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=nYuJPTUV; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=MB22uO6+; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=nYuJPTUV; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="MB22uO6+";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="nYuJPTUV";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="MB22uO6+";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="nYuJPTUV"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 86E5E5BCC2;
	Thu, 19 Feb 2026 12:14:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1771503245; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=t/LsYCD3enNA3e7pg5JiZKUIaUCCeWE1kDbPEQWvagU=;
	b=MB22uO6+BR6AMSd509qrQCUNTUIidQxKdSreFST2BN8KNdATxcc47+m9am4KYGkpmTelss
	RE2DJGDU9mUklxnM8DMxJk96hhGCOdY63jSqgAGeuxH+sX9pl6/wYxdZ4Hd5rXUjtqHzCm
	kAx2rKHc/a6pmUE8/NIIe2KvQTTcsM4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1771503245;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=t/LsYCD3enNA3e7pg5JiZKUIaUCCeWE1kDbPEQWvagU=;
	b=nYuJPTUVXSiY6WwEiW0jTSP90WFHkydjZ2g32S11CW0hyQDDJCRWQnJUeQBjk9JZToWJFv
	NzF9WCet+54zWgCA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=MB22uO6+;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=nYuJPTUV
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1771503245; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=t/LsYCD3enNA3e7pg5JiZKUIaUCCeWE1kDbPEQWvagU=;
	b=MB22uO6+BR6AMSd509qrQCUNTUIidQxKdSreFST2BN8KNdATxcc47+m9am4KYGkpmTelss
	RE2DJGDU9mUklxnM8DMxJk96hhGCOdY63jSqgAGeuxH+sX9pl6/wYxdZ4Hd5rXUjtqHzCm
	kAx2rKHc/a6pmUE8/NIIe2KvQTTcsM4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1771503245;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=t/LsYCD3enNA3e7pg5JiZKUIaUCCeWE1kDbPEQWvagU=;
	b=nYuJPTUVXSiY6WwEiW0jTSP90WFHkydjZ2g32S11CW0hyQDDJCRWQnJUeQBjk9JZToWJFv
	NzF9WCet+54zWgCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6D5A93EA65;
	Thu, 19 Feb 2026 12:14:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id GS6tGo3+lmmbXwAAD6G6ig
	(envelope-from <dwagner@suse.de>); Thu, 19 Feb 2026 12:14:05 +0000
Date: Thu, 19 Feb 2026 13:14:00 +0100
From: Daniel Wagner <dwagner@suse.de>
To: Bill Wendling <morbo@google.com>
Cc: linux-kernel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>, 
	Kees Cook <kees@kernel.org>, Gogul Balakrishnan <bgogul@google.com>, 
	Arman Hasanzadeh <armanihm@google.com>, linux-block@vger.kernel.org
Subject: Re: [PATCH] blkdev: Annotate struct request_queue with
 __counted_by_ptr
Message-ID: <9b7a107e-bc07-4a75-86b0-2685d4c78bb9@flourine.local>
References: <20260219004940.2594201-1-morbo@google.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260219004940.2594201-1-morbo@google.com>
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -4.51
X-Spam-Level: 
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 86E5E5BCC2

On Thu, Feb 19, 2026 at 12:49:35AM +0000, Bill Wendling wrote:
> The queue_hw_ctx field in struct request_queue is an array of pointers to
> struct blk_mq_hw_ctx. The number of elements in this array is tracked by
> the nr_hw_queues field.
> 
> The array is allocated in __blk_mq_realloc_hw_ctxs() using kcalloc_node()
> with set->nr_hw_queues elements. q->nr_hw_queues is subsequently updated
> to set->nr_hw_queues.
> 
> When growing the array, the new array is assigned to queue_hw_ctx before
> nr_hw_queues is updated. This is safe because nr_hw_queues (the old
> smaller count) is used for bounds checking, which is within the new
> larger allocation.
> 
> When shrinking the array, nr_hw_queues is updated to the smaller value,
> while queue_hw_ctx retains the larger allocation. This is also safe as
> the count is within the allocation bounds.
> 
> Annotating queue_hw_ctx with __counted_by_ptr(nr_hw_queues) allows the
> compiler (with kSAN) to verify that accesses to queue_hw_ctx are within
> the valid range defined by nr_hw_queues.
> 
> This patch was generated by Gemini and reviewed by Bill Wendling.
> Tested with bootup and running selftests.

There are some tests in blktests nvme/* which do change the number of
queues during runtime. Not sure if selftests have anything which is
related to this code path.

