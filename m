Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 310A527A119
	for <linux-block@vger.kernel.org>; Tue, 15 Apr 2025 10:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744712714; cv=none; b=eJaTNzbyy/LSPlwVk7FWaH6g4vuQ1wgmGjOVGUXsOBj2kwVYEafd8IXEvbepBuptka5dfL9TCf7YAhZe19cpqSt8VIp9UHXbrk9K6tsj+xrSXWcY9lb+mSmmP+nsd3qoG1vo35EGfxc9EygdyEzKQ/Tq1w4yJehNoGm5rJWDXEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744712714; c=relaxed/simple;
	bh=TJRgZdxP99DFlfc8ZhBkSmhdCwYr+dFZne62wSeOQhk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qcPsKASIo5v5dpcsVk3micg6mLMhepGzVB1svaLqxu4rzku1r0e4Os7+5zynWc3BTdxcNaPuIiOSSMXRTh2zIcMVjc83G0O+ehGEOYqrDj/SRaXc4CCc5KI9D2l7sopoR+8zyvr3Rg4F0fJl37pZIy2Z4Gs1W6wnNEiFZSdAvTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=x/x0o6zP; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=hujRY87b; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=x/x0o6zP; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=hujRY87b; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="x/x0o6zP";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="hujRY87b";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="x/x0o6zP";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="hujRY87b"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 2E9601F38A;
	Tue, 15 Apr 2025 10:25:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1744712711; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yNVApuVII9pfaOeKMoDkV9qafu5t1tFv6hF1DzoBwcA=;
	b=x/x0o6zPkvFOd19+AxQVHjUxT1n3yxkRkiQMCmzi+DqV7I2JlU9F+/rXo+UhTsijRoiukm
	uAZQP6knbV+zGwcRCcFq6VZ8cpAY93LJQK/QXHztXUAooBGIKAAE2TbSduShwsxm3/wbmC
	EqnHSm+9ZMqm64UvrPMPL3dK3Si3kUM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1744712711;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yNVApuVII9pfaOeKMoDkV9qafu5t1tFv6hF1DzoBwcA=;
	b=hujRY87bJvWnh8zH9L2kwQkx1I1nWVxDwwJzF8ZE8iH+7q3b7RvseFrzSKrfKRkMdMzWs/
	EvoQ9oITxmJmfxAw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="x/x0o6zP";
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=hujRY87b
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1744712711; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yNVApuVII9pfaOeKMoDkV9qafu5t1tFv6hF1DzoBwcA=;
	b=x/x0o6zPkvFOd19+AxQVHjUxT1n3yxkRkiQMCmzi+DqV7I2JlU9F+/rXo+UhTsijRoiukm
	uAZQP6knbV+zGwcRCcFq6VZ8cpAY93LJQK/QXHztXUAooBGIKAAE2TbSduShwsxm3/wbmC
	EqnHSm+9ZMqm64UvrPMPL3dK3Si3kUM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1744712711;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yNVApuVII9pfaOeKMoDkV9qafu5t1tFv6hF1DzoBwcA=;
	b=hujRY87bJvWnh8zH9L2kwQkx1I1nWVxDwwJzF8ZE8iH+7q3b7RvseFrzSKrfKRkMdMzWs/
	EvoQ9oITxmJmfxAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2129B139A1;
	Tue, 15 Apr 2025 10:25:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id FssTCAc0/mduaQAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 15 Apr 2025 10:25:11 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id CD2D2A0947; Tue, 15 Apr 2025 12:24:55 +0200 (CEST)
Date: Tue, 15 Apr 2025 12:24:55 +0200
From: Jan Kara <jack@suse.cz>
To: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
Cc: Jens Axboe <axboe@kernel.dk>, Martijn Coenen <maco@android.com>, 
	Alyssa Ross <hi@alyssa.is>, Christoph Hellwig <hch@lst.de>, Greg KH <greg@kroah.com>, 
	Jan Kara <jack@suse.cz>, John Ogness <john.ogness@linutronix.de>, 
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] loop: properly send KOBJ_CHANGED uevent for disk
 device
Message-ID: <tbypgsknfpqyx3xbrpz7jlpthlybcdxhr7b3oz4vq5u6izwdqp@q3wo6zpqicp7>
References: <20250415-loop-uevent-changed-v2-1-0c4e6a923b2a@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250415-loop-uevent-changed-v2-1-0c4e6a923b2a@linutronix.de>
X-Rspamd-Queue-Id: 2E9601F38A
X-Spam-Score: -4.01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.com:email,linutronix.de:email];
	RCVD_COUNT_THREE(0.00)[3];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Tue 15-04-25 10:51:47, Thomas Weiﬂschuh wrote:
> The original commit message and the wording "uncork" in the code comment
> indicate that it is expected that the suppressed event instances are
> automatically sent after unsuppressing.
> This is not the case, instead they are discarded.
> In effect this means that no "changed" events are emitted on the device
> itself by default.
> While each discovered partition does trigger a changed event on the
> device, devices without partitions don't have any event emitted.
> 
> This makes udev miss the device creation and prompted workarounds in
> userspace. See the linked util-linux/losetup bug.
> 
> Explicitly emit the events and drop the confusingly worded comments.
> 
> Link: https://github.com/util-linux/util-linux/issues/2434
> Fixes: 498ef5c777d9 ("loop: suppress uevents while reconfiguring the device")
> Cc: stable@vger.kernel.org
> Signed-off-by: Thomas Weiﬂschuh <thomas.weissschuh@linutronix.de>

Thanks for the fix! When reading the code, I'm a bit curious: What is
actually generating events for partitions with loop_change_fd() call?
Because there loop_reread_partitions() still happens with uevents
supressed... I suspect event supressing there should be shorter.

								Honza

> ---
> Changes in v2:
> - Use correct Fixes tag
> - Rework commit message slightly
> - Rebase onto v6.15-rc1
> - Link to v1: https://lore.kernel.org/r/20250317-loop-uevent-changed-v1-1-cb29cb91b62d@linutronix.de
> ---
>  drivers/block/loop.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/block/loop.c b/drivers/block/loop.c
> index 674527d770dc669e982a2b441af1171559aa427c..09a725710a21171e0adf5888f929ccaf94e98992 100644
> --- a/drivers/block/loop.c
> +++ b/drivers/block/loop.c
> @@ -667,8 +667,8 @@ static int loop_change_fd(struct loop_device *lo, struct block_device *bdev,
>  
>  	error = 0;
>  done:
> -	/* enable and uncork uevent now that we are done */
>  	dev_set_uevent_suppress(disk_to_dev(lo->lo_disk), 0);
> +	kobject_uevent(&disk_to_dev(lo->lo_disk)->kobj, KOBJ_CHANGE);
>  	return error;
>  
>  out_err:
> @@ -1129,8 +1129,8 @@ static int loop_configure(struct loop_device *lo, blk_mode_t mode,
>  	if (partscan)
>  		clear_bit(GD_SUPPRESS_PART_SCAN, &lo->lo_disk->state);
>  
> -	/* enable and uncork uevent now that we are done */
>  	dev_set_uevent_suppress(disk_to_dev(lo->lo_disk), 0);
> +	kobject_uevent(&disk_to_dev(lo->lo_disk)->kobj, KOBJ_CHANGE);
>  
>  	loop_global_unlock(lo, is_loop);
>  	if (partscan)
> 
> ---
> base-commit: 0af2f6be1b4281385b618cb86ad946eded089ac8
> change-id: 20250307-loop-uevent-changed-aa3690f43e03
> 
> Best regards,
> -- 
> Thomas Weiﬂschuh <thomas.weissschuh@linutronix.de>
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
