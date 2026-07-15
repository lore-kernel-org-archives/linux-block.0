Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE5A63AFB0C
	for <linux-block@vger.kernel.org>; Wed, 15 Jul 2026 16:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784132486; cv=none; b=utsg880tf+bJAnT82dd0Yg9SES4mlGnkCnPa1zefTkLJUOdJ5GOiUrcGSR4F1fplFiru2h6t66QO1bqDFostghAkugeN/sUhMnwV0g0jpQpy3iWK3w1O0W8GojtdveJiYglKHLS04PjiMwlZXBd3IuAF8LpvVM4bKQEDoWXJMvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784132486; c=relaxed/simple;
	bh=D9eUJAoVQO42ob2SYIni4Z4Z5kpPvoc1fgpKgJ7anrY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HGPW5uEVTuBQHx8fIDvPVAGTsv+dTjw8vAInyWIn6+hSmClHDtgLUCntMvXNVItu+5X7D3/hUbeCHSojS6t9LwXkPkHTpxWFrYWibLv0WvfhUV8bh7FKD31km+XoYFhIofh5ES2GPEohXnj0gkVn9EbS67GNTuZH8DpZA89sjD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ruu3dXqn; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=a6sxY0KL; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=EaOodu+q; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=q14cGpL6; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ruu3dXqn";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="a6sxY0KL";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="EaOodu+q";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="q14cGpL6"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 7EC5F7849E;
	Wed, 15 Jul 2026 16:21:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1784132482; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8A+qnwoHbjA587BcSxezq7X4w5raOP090pcKdJlzmqY=;
	b=ruu3dXqnJNiGFdA4AxQVjypbl1C+c8X0nj8DK8c2dPoeotAb4W3Nd9m2WB9aWe3b2LvG7I
	yAS7E5ALgcpeO+Qm+PbBFanw1zXPw4f3NeRrph/2Hvkt/LNFC0mE8T8pBFse/Eqzfcqa8j
	5etTr1nMuK6glwaUkX0N1lK5mKtePr4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1784132482;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8A+qnwoHbjA587BcSxezq7X4w5raOP090pcKdJlzmqY=;
	b=a6sxY0KLG0w45aiUP93KAvEahw9qyMC6KqbBchAIs/EbOK3rIGMrmSo70uAabrPCdLqmXp
	DpF5F6vEsugHU7AQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=EaOodu+q;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=q14cGpL6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1784132481; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8A+qnwoHbjA587BcSxezq7X4w5raOP090pcKdJlzmqY=;
	b=EaOodu+q9n5G1r5Mt9EqCoFKYoQc8TYqJ5FKzbxWV8gKd4Rj2ubw3zAFAnJCb2E2uCoMKO
	d2h83Ogg0NhD8rh19FTvSMHdPXJHgLfiU61+f+UG29wqzSd0jWzwM71QYXBfEqrxqHGyAq
	Kskr+7ZVPW4ZQeJhMxYlcCr5YRCqQ24=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1784132481;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8A+qnwoHbjA587BcSxezq7X4w5raOP090pcKdJlzmqY=;
	b=q14cGpL63AQxTba3CzFylFtGFufk02KTg6m6gM/DJfRdciCaY46m+Rs/LPqhgdbKndVsyC
	mwUfUOhMhMF2xnDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6BA6A779AD;
	Wed, 15 Jul 2026 16:21:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id B/7DGIGzV2plQQAAD6G6ig
	(envelope-from <dwagner@suse.de>); Wed, 15 Jul 2026 16:21:21 +0000
Date: Wed, 15 Jul 2026 18:21:20 +0200
From: Daniel Wagner <dwagner@suse.de>
To: John Garry <john.g.garry@oracle.com>
Cc: shinichiro.kawasaki@wdc.com, linux-block@vger.kernel.org, hch@lst.de, 
	linux-nvme@lists.infradead.org, John Garry <john.garry@linux.dev>
Subject: Re: [PATCH v3] nvme/069: add a test for multipath cdev lifetime
Message-ID: <56d237df-baf9-4541-a785-fdc0499ad27f@flourine.local>
References: <20260715155531.3811457-1-john.g.garry@oracle.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260715155531.3811457-1-john.g.garry@oracle.com>
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 7EC5F7849E
X-Spam-Flag: NO
X-Spam-Score: -4.51
X-Spam-Level: 
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:email,linux.dev:email,flourine.local:mid,suse.de:email,suse.de:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org

On Wed, Jul 15, 2026 at 03:55:31PM +0000, John Garry wrote:
> From: John Garry <john.garry@linux.dev>
> 
> In [0], a fix was proposed for the NS and NS head (multipath) cdev
> lifetime.
> 
> The issue was that fds for the nvme-generic cdev may exist after we tear
> down the nvme-subsystem. Issuing an ioctl on that cdev may expose a
> use-after-free.
> 
> This test recreates the method described in [0] to expose this issue
> for NS head cdev.
> 
> First a fd is created by opening the nvme-generic cdev. Next we tear down
> the nvme-subsystem. Finally we try to issue an ioctl on the cdev - without
> the kernel fix in [0], this should trigger a KASAN warn.
> 
> [0] https://lore.kernel.org/linux-nvme/20260713104238.3034640-1-john.g.garry@oracle.com/T/#me118851584fbcbb960795d0f04e2262e5a295613
> 
> Signed-off-by: John Garry <john.g.garry@oracle.com>

Looks good to me! Thanks!

Reviewed-by: Daniel Wagner <dwagner@suse.de>
