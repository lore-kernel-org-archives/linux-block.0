Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AF922EAD06
	for <linux-block@vger.kernel.org>; Fri, 25 Jul 2025 15:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753458589; cv=none; b=ZNRO7/3TWFhPZCjrFECGxyr3+DQvDIbNOgo3+6QwWuWRmkNtDVPL3TKsN6QYcO/udMQsNldiTTDXGYeIH4QYc7hB8eAQZ1oAdLEe8cwlsSOVKsyemIkHO19KeMLkba6j4ZZoqe12kMZhvZNTWQI6fqFjXWHIo33LMsTd7cFJukM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753458589; c=relaxed/simple;
	bh=0MiGNRbMt9UPkNDmUPmLjtW+subEJQZXvyM1r4NDsOI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e6UDtwqz+SFwQJ4TRxh1+YBarAslGnnBYlfKFqtZjvLaTUb/TKHo2lh7OAq+BkfsPx5gHUs8h4h82iepdbYKgpFxNC0yjj7MDDmVSsaXKUBhbcp34LUSpyDJ/I1D/FkJo5ylxYAa/XmtGAJ7W9saeox5cVvqzaawJaPlbaSkDso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=T9h1Bn54; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=qwhp6lcl; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Rl25kktq; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=vZm6EcrB; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="T9h1Bn54";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="qwhp6lcl";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Rl25kktq";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="vZm6EcrB"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id DA9902199D;
	Fri, 25 Jul 2025 15:49:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1753458586; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=E2pVs42u9yk8m/q1NF9Jm9oePQ3u0IxGU3VYuHo7mfc=;
	b=T9h1Bn54iI2EdCkD0TZb+nPjAJfJCh7PeJQDyufQ09dN46whHATCUoOeiMfDGVSbtAoV4+
	BaXyxOfIKYKdWBgLUzv5F/LGPVK20k+UNCOrpwNodkRUiWTjRh9VGy5zrKlRL3b7LNXioi
	n2BUQq3Q9TcyVjmtccmZVMAwjr/DO2Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1753458586;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=E2pVs42u9yk8m/q1NF9Jm9oePQ3u0IxGU3VYuHo7mfc=;
	b=qwhp6lclOr8bzh1Anc/yY/DapVvjSq45uLGCxfx5y7/lbL2tFWAxG0r5mSY5qqw5LDesTW
	WD3JAUcWhKeLNVAg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=Rl25kktq;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=vZm6EcrB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1753458584; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=E2pVs42u9yk8m/q1NF9Jm9oePQ3u0IxGU3VYuHo7mfc=;
	b=Rl25kktqPcQ2a9/Eschx2Eo358KGNQ1tInV0DGjG4rPyD8M30TQUycqMqBPMZJvUjLShBB
	/E5b0xJhreZe0TSR9wnOvYtrKqt5vpvwB6z2kG4yp6ffYabOeVxBWc4WSPpOtyBLJI3QhL
	WAaC76M53yLv7Iku3iXGEZDdJE8Lbrg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1753458584;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=E2pVs42u9yk8m/q1NF9Jm9oePQ3u0IxGU3VYuHo7mfc=;
	b=vZm6EcrBxiwH+1p6rU/mhKqk4GJA2l3VM5rXTF/+0/wETpq4NK1E5B3OCt0EbeYJ8hq7Kf
	MIVfVYjvyiwkUYCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CE57D1373A;
	Fri, 25 Jul 2025 15:49:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id DbkYMping2hEbAAAD6G6ig
	(envelope-from <jack@suse.cz>); Fri, 25 Jul 2025 15:49:44 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 4E7F2A29BE; Fri, 25 Jul 2025 17:49:44 +0200 (CEST)
Date: Fri, 25 Jul 2025 17:49:44 +0200
From: Jan Kara <jack@suse.cz>
To: Tang Yizhou <yizhou.tang@shopee.com>
Cc: axboe@kernel.dk, hch@lst.de, jack@suse.cz, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org, tangyeechou@gmail.com
Subject: Re: [PATCH 3/3] blk-wbt: doc: Update the doc of the wbt_lat_usec
 interface
Message-ID: <nk2qqgxickxelo6a7ywxwan2fshjkfygzdb6sooe3v4cl5f3ob@kvejyp5t2cmf>
References: <20250724083001.362882-1-yizhou.tang@shopee.com>
 <20250724083001.362882-4-yizhou.tang@shopee.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250724083001.362882-4-yizhou.tang@shopee.com>
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	ARC_NA(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_CC(0.00)[kernel.dk,lst.de,suse.cz,vger.kernel.org,gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[shopee.com:email]
X-Spam-Flag: NO
X-Spam-Level: 
X-Rspamd-Queue-Id: DA9902199D
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.01

On Thu 24-07-25 16:30:01, Tang Yizhou wrote:
> From: Tang Yizhou <yizhou.tang@shopee.com>
> 
> The symbol wb_window_usec cannot be found. Update the doc to reflect the
> latest implementation, in other words, the cur_win_nsec member of struct
> rq_wb.
> 
> Signed-off-by: Tang Yizhou <yizhou.tang@shopee.com>

I think the name should be actually 'curr_win_nsec' because that's the name
of this value shown in debugfs.

								Honza

> ---
>  Documentation/ABI/stable/sysfs-block | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/Documentation/ABI/stable/sysfs-block b/Documentation/ABI/stable/sysfs-block
> index 4ba771b56b3b..7bb4dce73eca 100644
> --- a/Documentation/ABI/stable/sysfs-block
> +++ b/Documentation/ABI/stable/sysfs-block
> @@ -731,11 +731,11 @@ Contact:	linux-block@vger.kernel.org
>  Description:
>  		[RW] If the device is registered for writeback throttling, then
>  		this file shows the target minimum read latency. If this latency
> -		is exceeded in a given window of time (see wb_window_usec), then
> -		the writeback throttling will start scaling back writes. Writing
> -		a value of '0' to this file disables the feature. Writing a
> -		value of '-1' to this file resets the value to the default
> -		setting.
> +		is exceeded in a given window of time (see the cur_win_nsec
> +		member of struct rq_wb), then the writeback throttling will
> +		start scaling back writes. Writing a value of '0' to this file
> +		disables the feature. Writing a value of '-1' to this file
> +		resets the value to the default setting.
>  
>  
>  What:		/sys/block/<disk>/queue/write_cache
> -- 
> 2.25.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
