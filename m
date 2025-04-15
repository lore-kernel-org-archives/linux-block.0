Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C68927A93C
	for <linux-block@vger.kernel.org>; Tue, 15 Apr 2025 16:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744735366; cv=none; b=dAO8wT6rhS6tr1cL9lNoIzXE7fzl6P1M/sYiI3qKWjsMe9NkwFwY8trn4cx4ko2iPDM6Qld05yFefTaKQ/R0LxmjjLo2FBW61Qv6ipwGpjJGWnnsY/UBfTBtFgAM8cTNpNe7aYPSDVit6lSYY6R2z3NOX/POmJbsG6WPKfpkQnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744735366; c=relaxed/simple;
	bh=7guA22Z/jVIhTId3TiU3XjIQwgyWBjZKeRgCg5KS4MA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aDLuoqw3MPF9PVl5wg83RT5jyDxMCUHpG5U1NECy32z4yptXy2vn1OXCN06tG+KO1UAkTsXR/sgHJbEWcmqlxDGJXCgPPhuAfPYR8F+JGJtw7itAFgCdIBkoh6BRFFnsjkmctQLR2DHOsbfq7IOUP7wnCC4KZHP5Ag9BeCCa60I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=sFtX3Hjl; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=iMqvCkzi; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=sFtX3Hjl; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=iMqvCkzi; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="sFtX3Hjl";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="iMqvCkzi";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="sFtX3Hjl";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="iMqvCkzi"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id C02BB1F461;
	Tue, 15 Apr 2025 16:42:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1744735362; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uYXbDnEVw6T3gFBR1xGBJ2FVAU/2FayUDTj0+2zKHis=;
	b=sFtX3Hjlx1wOA1FTuoTIpaVVg+kPH1ZDX/PiG2f5KPK2R0WOWf3i0d+6ZGvERhAUFyTauW
	sKpMtvqWfTWyQoC+C+tqyH8Sbl8yD5IgoJ+9mb8C6KOHW0nFnlgBn4o2Skrrlv1A3h25H9
	5cxWdGxrV/h58/r7z7+ZDLGoYMXuG/Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1744735362;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uYXbDnEVw6T3gFBR1xGBJ2FVAU/2FayUDTj0+2zKHis=;
	b=iMqvCkziOv6yRDVxHSqu2D65vGD1SOJL+/mbf57m7xxMKydTRf63ng8sVgHtnhD6xbMf+W
	avZl3LJdSRIvoQCQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1744735362; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uYXbDnEVw6T3gFBR1xGBJ2FVAU/2FayUDTj0+2zKHis=;
	b=sFtX3Hjlx1wOA1FTuoTIpaVVg+kPH1ZDX/PiG2f5KPK2R0WOWf3i0d+6ZGvERhAUFyTauW
	sKpMtvqWfTWyQoC+C+tqyH8Sbl8yD5IgoJ+9mb8C6KOHW0nFnlgBn4o2Skrrlv1A3h25H9
	5cxWdGxrV/h58/r7z7+ZDLGoYMXuG/Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1744735362;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uYXbDnEVw6T3gFBR1xGBJ2FVAU/2FayUDTj0+2zKHis=;
	b=iMqvCkziOv6yRDVxHSqu2D65vGD1SOJL+/mbf57m7xxMKydTRf63ng8sVgHtnhD6xbMf+W
	avZl3LJdSRIvoQCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B1BBF137A5;
	Tue, 15 Apr 2025 16:42:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id yqxZK4KM/mdeZgAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 15 Apr 2025 16:42:42 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 3A5D5A0947; Tue, 15 Apr 2025 18:42:42 +0200 (CEST)
Date: Tue, 15 Apr 2025 18:42:42 +0200
From: Jan Kara <jack@suse.cz>
To: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
Cc: Jens Axboe <axboe@kernel.dk>, Martijn Coenen <maco@android.com>, 
	Alyssa Ross <hi@alyssa.is>, Christoph Hellwig <hch@lst.de>, Greg KH <greg@kroah.com>, 
	Jan Kara <jack@suse.cz>, John Ogness <john.ogness@linutronix.de>, 
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v3] loop: LOOP_SET_FD: send uevents for partitions
Message-ID: <2wzcj4odajfsvubribqetasj26pp5u3wnusnowwwjiwy4lj5p5@vpa7vwwseyq2>
References: <20250415-loop-uevent-changed-v3-1-60ff69ac6088@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250415-loop-uevent-changed-v3-1-60ff69ac6088@linutronix.de>
X-Spam-Level: 
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_COUNT_THREE(0.00)[3];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:email]
X-Spam-Score: -3.80
X-Spam-Flag: NO

On Tue 15-04-25 16:55:06, Thomas Weiﬂschuh wrote:
> Remove the suppression of the uevents before scanning for partitions.
> The partitions inherit their suppression settings from their parent device,
> which lead to the uevents being dropped.
> 
> This is similar to the same changes for LOOP_CONFIGURE done in
> commit bb430b694226 ("loop: LOOP_CONFIGURE: send uevents for partitions").
> 
> Fixes: 498ef5c777d9 ("loop: suppress uevents while reconfiguring the device")
> Cc: stable@vger.kernel.org
> Signed-off-by: Thomas Weiﬂschuh <thomas.weissschuh@linutronix.de>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
> Changes in v3:
> - Rebase onto block/block-6.15
> - Drop already applied patch "loop: properly send KOBJ_CHANGED uevent for disk device"
> - Add patch to fix partition uevents for LOOP_SET_FD
> - Link to v2: https://lore.kernel.org/r/20250415-loop-uevent-changed-v2-1-0c4e6a923b2a@linutronix.de
> 
> Changes in v2:
> - Use correct Fixes tag
> - Rework commit message slightly
> - Rebase onto v6.15-rc1
> - Link to v1: https://lore.kernel.org/r/20250317-loop-uevent-changed-v1-1-cb29cb91b62d@linutronix.de
> ---
>  drivers/block/loop.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/block/loop.c b/drivers/block/loop.c
> index 3be7f00e7fc740da2745ffbccfcebe53eef2ddaa..e9ec7a45f3f2d1dd2a82b3506f3740089a20ae05 100644
> --- a/drivers/block/loop.c
> +++ b/drivers/block/loop.c
> @@ -662,12 +662,12 @@ static int loop_change_fd(struct loop_device *lo, struct block_device *bdev,
>  	 * dependency.
>  	 */
>  	fput(old_file);
> +	dev_set_uevent_suppress(disk_to_dev(lo->lo_disk), 0);
>  	if (partscan)
>  		loop_reread_partitions(lo);
>  
>  	error = 0;
>  done:
> -	dev_set_uevent_suppress(disk_to_dev(lo->lo_disk), 0);
>  	kobject_uevent(&disk_to_dev(lo->lo_disk)->kobj, KOBJ_CHANGE);
>  	return error;
>  
> @@ -675,6 +675,7 @@ static int loop_change_fd(struct loop_device *lo, struct block_device *bdev,
>  	loop_global_unlock(lo, is_loop);
>  out_putf:
>  	fput(file);
> +	dev_set_uevent_suppress(disk_to_dev(lo->lo_disk), 0);
>  	goto done;
>  }
>  
> 
> ---
> base-commit: 7ed2a771b5fb3edee9c4608181235c30b40bb042
> change-id: 20250307-loop-uevent-changed-aa3690f43e03
> 
> Best regards,
> -- 
> Thomas Weiﬂschuh <thomas.weissschuh@linutronix.de>
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
