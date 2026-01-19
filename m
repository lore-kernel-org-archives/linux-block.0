Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F5322737E0
	for <linux-block@vger.kernel.org>; Mon, 19 Jan 2026 10:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768816921; cv=none; b=ZpdreS8hi05sit5wRIeTOvR11J/gxBZS62MZ9peEou2niDPv1Fgu3VtlFIRBc+5zTPs++O8qMsEYsPVSK1Cbg3dkNGo28KnbHHGVKaRSgbM/FXEMFo9h6zoCCrc7o4fKBseWbHlHfUFd4lTVuejn5HQoRwCDMtwR632aOx4J9G8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768816921; c=relaxed/simple;
	bh=WSmYbOUaIBlunB2QqGY16S7KJYbVnAatwJow2aU7mko=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bynGPCoig0h99JUDkZl5V2OPABaZy04QhmzYmG0PSetwnBo6rioQoD7rtnY/qlTTuk+HxgiD5CW5d4d9L09J9lRmasNvGe3U41tFByau0Fx+kyMRqpV0BLX75KSejFrl1xxM1z2o4nnr0dE8E98QwWwp4pOSe6M1YhyXdUewrfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=oC0WQuxw; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=64JiAPzm; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=oC0WQuxw; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=64JiAPzm; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="oC0WQuxw";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="64JiAPzm";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="oC0WQuxw";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="64JiAPzm"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 20A8C33716;
	Mon, 19 Jan 2026 10:01:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1768816918; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qPiR7EMAph86l7lxYrvcRes0ZUcQsVEzr0BjIxKI5Oc=;
	b=oC0WQuxwrvyknR7v/jU8newiEKLr/CKx2aK0DGMVdsj59JmPA1lyXzCLLuJjrxrGjIkOy5
	AzN+Jbj6cYOlOVD7uPtaBA0XY1qqlG+Qi3oMzChzUuBT/MA8oBLH1CadrwFWTFeTihFdtE
	HP9+pELHCFvgzZd/4zn7hMjsSTZ2Xo0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1768816918;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qPiR7EMAph86l7lxYrvcRes0ZUcQsVEzr0BjIxKI5Oc=;
	b=64JiAPzm+i66ar+E7Fffj7X2SXZE6X0dzldidn9Gr2BlOmdhV32e6ffJG1xwdZmQ0nL24i
	IFyQSg+UMUsGIJDQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=oC0WQuxw;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=64JiAPzm
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1768816918; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qPiR7EMAph86l7lxYrvcRes0ZUcQsVEzr0BjIxKI5Oc=;
	b=oC0WQuxwrvyknR7v/jU8newiEKLr/CKx2aK0DGMVdsj59JmPA1lyXzCLLuJjrxrGjIkOy5
	AzN+Jbj6cYOlOVD7uPtaBA0XY1qqlG+Qi3oMzChzUuBT/MA8oBLH1CadrwFWTFeTihFdtE
	HP9+pELHCFvgzZd/4zn7hMjsSTZ2Xo0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1768816918;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qPiR7EMAph86l7lxYrvcRes0ZUcQsVEzr0BjIxKI5Oc=;
	b=64JiAPzm+i66ar+E7Fffj7X2SXZE6X0dzldidn9Gr2BlOmdhV32e6ffJG1xwdZmQ0nL24i
	IFyQSg+UMUsGIJDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 129143EA63;
	Mon, 19 Jan 2026 10:01:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id bVSQAxYBbmm+dAAAD6G6ig
	(envelope-from <dwagner@suse.de>); Mon, 19 Jan 2026 10:01:58 +0000
Date: Mon, 19 Jan 2026 11:01:57 +0100
From: Daniel Wagner <dwagner@suse.de>
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: linux-block@vger.kernel.org, mcgrof@kernel.org, sw.prabhu6@gmail.com, 
	bvanassche@acm.org, Chaitanya Kulkarni <kch@nvidia.com>
Subject: Re: [PATCH blktests v7 0/3] replace module removal with patient
 module removal
Message-ID: <ccc54b24-d06b-480d-88fa-78c1b9a3cd68@flourine.local>
References: <20260115091101.70464-1-shinichiro.kawasaki@wdc.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260115091101.70464-1-shinichiro.kawasaki@wdc.com>
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,gmail.com,acm.org,nvidia.com];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:dkim,suse.de:email]
X-Spam-Flag: NO
X-Spam-Score: -3.01
X-Rspamd-Queue-Id: 20A8C33716
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spam-Level: 

On Thu, Jan 15, 2026 at 06:10:58PM +0900, Shin'ichiro Kawasaki wrote:
> This patch series was originally authored by Luis Chamberlain [0][1]. I
> reworked and post it as this series.
> 
> [0] https://lore.kernel.org/all/20221220235324.1445248-2-mcgrof@kernel.org/T/#u
> [1] https://lore.kernel.org/linux-block/20251126171102.3663957-1-mcgrof@kernel.org/
> 
> Original cover letter:
> 
> We now have the modprobe --wait upstream so use that if available.
> 
> The patient module remover addresses race conditions where module removal
> can fail due to userspace temporarily bumping the refcount (e.g., via
> blkdev_open() calls). If your version of kmod supports modprobe --wait,
> we use that. Otherwise we implement our own patient module remover.

Looks good to me.

Reviewed-by: Daniel Wagner <dwagner@suse.de>
