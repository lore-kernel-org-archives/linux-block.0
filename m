Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD068254AE7
	for <linux-block@vger.kernel.org>; Mon, 28 Jul 2025 09:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753695700; cv=none; b=LWMDnPe0hqLlfP4G9N28pFFwV/QqJYXwA+e5fNV1CaGLmHECyao6YF5g6HHClyKRchCcEallKd9CBmlxusrYIr/X71QDBWA+No5IvsdSPABKjLUnkL6BYuVQteQAUzj9lAsARltcUq1Vr5CQxnnmFF/P0Nwscq3XKhDAR+GyuQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753695700; c=relaxed/simple;
	bh=YzOqOoAb5ll7MuI2NZI2Ybcacxybc/qq9ue1qKQvf9U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gnalZRqgRyyN/wv+KmABizewmrzRPsPfmwOnkX8FOrtONmce3xkw5sA6yNG2397faW8w5XkvmBv6bSh7CkGmA7gbTJPF4E4BDOmqZ/3zI/4KhEqUp27KdGuhZQWMZTeEUR57EhEeiujH7FnDeiXfuu/WiennMezXzH6AY4v3i6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=AfQcMfin; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=SvdoSdb6; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=HcAg7keL; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=95QGSC0o; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="AfQcMfin";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="SvdoSdb6";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="HcAg7keL";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="95QGSC0o"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 012D41F460;
	Mon, 28 Jul 2025 09:41:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1753695697; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5nu2nCd7EmFb8+spdBw6kTJIrVlNqB2Suwmo+FBuk2g=;
	b=AfQcMfin+4kLagHqkWl+HWxK8RypyqfqEFpObMFXLFpBVKrqDEd1221KSzm8DuhTgIk7Le
	FFW4crdiA6WXt3tAaCYn+cv/dtkUPxcmBJWtIoBL1LhrDlI+GucfEsY0I5O7H/MD5bOKSr
	cg5aTjPCA3J83X/9xD4jHaDHdzNpuqU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1753695697;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5nu2nCd7EmFb8+spdBw6kTJIrVlNqB2Suwmo+FBuk2g=;
	b=SvdoSdb6tOnXrbosH0+bZRobFhRQ90ScUZFysEyQTYX1wF0fU3OTnf0eT6HYrPQbzobzkY
	e2+mAAlSKo9VrRCA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1753695696; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5nu2nCd7EmFb8+spdBw6kTJIrVlNqB2Suwmo+FBuk2g=;
	b=HcAg7keLI2UB/Gan5PIeoMu1qJttYCweoauF8RAyzWgf/Fx0as/z0d7NtEiJu7WVqVK2ez
	2pRId63SIc3LlbRB8CzkUFMFnunmkodNHqfEHCQvr+hTODmIiG20oYJRq2/vWSHGuWVUgb
	/O5z2d86Dkf3G8sdKYQx4I4VlZT+k58=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1753695696;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5nu2nCd7EmFb8+spdBw6kTJIrVlNqB2Suwmo+FBuk2g=;
	b=95QGSC0ouNoKT10LBm0hjkCfctpi5rfV5uUBP/rewILYQjXfZJ7vaAw/A6WsW/MVVoYjPf
	mIi/TeGXYH4pOnCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E596A1368A;
	Mon, 28 Jul 2025 09:41:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id pqAFOM9Fh2hlMgAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 28 Jul 2025 09:41:35 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 94AC4A09BE; Mon, 28 Jul 2025 11:41:27 +0200 (CEST)
Date: Mon, 28 Jul 2025 11:41:27 +0200
From: Jan Kara <jack@suse.cz>
To: Tang Yizhou <yizhou.tang@shopee.com>
Cc: axboe@kernel.dk, hch@lst.de, jack@suse.cz, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org, tangyeechou@gmail.com
Subject: Re: [PATCH v3 3/3] blk-wbt: doc: Update the doc of the wbt_lat_usec
 interface
Message-ID: <phu3rvr3gcok72z3g3tjxjgfzasfhv2qbevs7ydgzt7tc2kgmy@ocyvpumyjx3x>
References: <20250727173959.160835-1-yizhou.tang@shopee.com>
 <20250727173959.160835-4-yizhou.tang@shopee.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250727173959.160835-4-yizhou.tang@shopee.com>
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_COUNT_THREE(0.00)[3];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email,suse.cz:email,shopee.com:email];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_CC(0.00)[kernel.dk,lst.de,suse.cz,vger.kernel.org,gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:email,suse.com:email]
X-Spam-Flag: NO
X-Spam-Level: 
X-Spam-Score: -3.80

On Mon 28-07-25 01:39:59, Tang Yizhou wrote:
> From: Tang Yizhou <yizhou.tang@shopee.com>
> 
> The symbol wb_window_usec cannot be found. Update the doc to reflect the
> latest implementation, in other words, the debugfs interface
> 'curr_win_nsec'.
> 
> Signed-off-by: Tang Yizhou <yizhou.tang@shopee.com>

Looks good! Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  Documentation/ABI/stable/sysfs-block | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/ABI/stable/sysfs-block b/Documentation/ABI/stable/sysfs-block
> index 4ba771b56b3b..a3cf841ebdff 100644
> --- a/Documentation/ABI/stable/sysfs-block
> +++ b/Documentation/ABI/stable/sysfs-block
> @@ -731,7 +731,7 @@ Contact:	linux-block@vger.kernel.org
>  Description:
>  		[RW] If the device is registered for writeback throttling, then
>  		this file shows the target minimum read latency. If this latency
> -		is exceeded in a given window of time (see wb_window_usec), then
> +		is exceeded in a given window of time (see curr_win_nsec), then
>  		the writeback throttling will start scaling back writes. Writing
>  		a value of '0' to this file disables the feature. Writing a
>  		value of '-1' to this file resets the value to the default
> -- 
> 2.25.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
