Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6048D34B1A6
	for <linux-block@vger.kernel.org>; Mon, 23 Feb 2026 12:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771849766; cv=none; b=exhMBneQ1i+QmIoJsj5E2e4oC4jMKwfsF/vlHZbKyu553y+GwaA8k+Z1aq+c2i4q9xQTwyucY5/QLiaVl1iaKe/9QuQo6NNeE848ULRoE887rKZH6nNzBm7TRJ795J9/W+Tv4V82lsfReRaJBbOupuo7qFNbVde9ws4s1z87Pr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771849766; c=relaxed/simple;
	bh=uswItn/TQUAwrTCy4qXmOgTaWAtTBZ6aATYgSkIOtVc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DibZyBUneJLVAe4gqzWqtlCc6G3lvFyUZR4yYnBj8J7FYy4gKjPdTuczJDNX6pPt9Rz1BjqssxN4c1ZPlh0K9UfV5U4822G8rfd1LKhuMBRb69fRW/+GyYV9PKxYqHwetozE6ulnUZC99zn7kkGYE6uiVB1SixOScOuQnMp9Z1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Zt19+w1d; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=fUCSmtJN; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=qurtkkxT; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=qu/S8OOV; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Zt19+w1d";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="fUCSmtJN";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="qurtkkxT";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="qu/S8OOV"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 582213EC83;
	Mon, 23 Feb 2026 12:29:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1771849762; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BogeCzlzElrloColHr/wWC6rvQ1cfKgoyvmzZdsv8ac=;
	b=Zt19+w1dV5dR8olHLEWq1+e/QHPMjkorl7+3CE2aNiowStSlKFeHuhIYCwR2kzupTuqjdq
	LfGO+eLqF/MdZjAQ88cEQK0mBT99zgbva2+eDKBBTaeJN3ZKuUul6IFT/InytXaOXuJuei
	0JFigLWa4/Lad1E4QjQOMClYbMdUn8c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1771849762;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BogeCzlzElrloColHr/wWC6rvQ1cfKgoyvmzZdsv8ac=;
	b=fUCSmtJNRJjKg624v7NG8FQASDqfbQ4DnVZaQ6CAOlb3L9eBYXdmulFSB8uKQVea6OCwss
	+nXVYMiiUlEwEbBg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=qurtkkxT;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="qu/S8OOV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1771849761; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BogeCzlzElrloColHr/wWC6rvQ1cfKgoyvmzZdsv8ac=;
	b=qurtkkxTw2AB1JWuqcUb5a/+JZVYpI0+K1I4h350IuorLiyk8DZdUA+qTTR77Ew/jSzRK9
	lyG7WWoatm6L650ZOqlQMhKRl8Q34j+jBZQoHUvPSQk+ka5G2jb+mGKyLdkCm5UG/RlKQJ
	BMcP0ue8qC/cyWZu++Q8rgaKzQ20vVs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1771849761;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BogeCzlzElrloColHr/wWC6rvQ1cfKgoyvmzZdsv8ac=;
	b=qu/S8OOVVU9ZTB+KW9XqXE7bakwPHQfuualBTR3mFe0OV2MO4oxGIcjgtugAcMKLRSDdqs
	XqyioMuYJGWCKHAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3CBAC3EA68;
	Mon, 23 Feb 2026 12:29:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id tghdDiFInGlJaAAAD6G6ig
	(envelope-from <hare@suse.de>); Mon, 23 Feb 2026 12:29:21 +0000
Message-ID: <6803eb55-cef8-433e-a849-5e10b7a1bf37@suse.de>
Date: Mon, 23 Feb 2026 13:29:20 +0100
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] ublk: cleanup flag handling and fix
 UBLK_F_NO_AUTO_PART_SCAN
To: Alexander Atanasov <alex@zazolabs.com>, Ming Lei <ming.lei@redhat.com>,
 Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org
References: <20260223121515.3296983-1-alex@zazolabs.com>
 <20260223121515.3296983-2-alex@zazolabs.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20260223121515.3296983-2-alex@zazolabs.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid,suse.de:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,zazolabs.com:email];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Queue-Id: 582213EC83
X-Spam-Flag: NO
X-Spam-Score: -4.51
X-Spam-Level: 

On 2/23/26 13:15, Alexander Atanasov wrote:
> Currently the code misuse GD_SUPPRESS_PART_SCAN flag
> as it tries to use it as a switch for the auto partition scan.
> To fully disable creation of partitions GENHD_FL_NO_PART must
> be used, switch code to use it instead GD_SUPPRESS_PART_SCAN.
> 
> Using the new flags rules for partitions become:
>   - Unprivileged daemons - never scan partitions, they have
> GENHD_FL_NO_PART always set - they are devices without partitions.
> 
>   - Trusted daemons - by default have partitions disabled.
> Partitions can be enabled via UBLK_F_PARTITIONS flag and
> automatic initial scan can be requested via UBLK_F_AUTO_PART_SCAN flag.
> 
> Rework the code to work as described above:
> - remove checks in ublk_partition_scan_work and rely on
> the caller to schedule the work only if it has to be done.
> - set GENHD_FL_NO_PART on unprivileged devices
> - set GENHD_FL_NO_PART depending on UBLK_F_PARTITIONS on trusted
> devices.
> 
> Fixes: 8443e2087e70 ("ublk: add UBLK_F_NO_AUTO_PART_SCAN feature flag")
> Signed-off-by: Alexander Atanasov <alex@zazolabs.com>
> ---
>   drivers/block/ublk_drv.c      | 34 +++++++++++++++++++---------------
>   include/uapi/linux/ublk_cmd.h |  7 +++++--
>   2 files changed, 24 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> index 3c918db4905c..d0c646eb9435 100644
> --- a/drivers/block/ublk_drv.c
> +++ b/drivers/block/ublk_drv.c
> @@ -81,7 +81,8 @@
>   		| (IS_ENABLED(CONFIG_BLK_DEV_INTEGRITY) ? UBLK_F_INTEGRITY : 0) \
>   		| UBLK_F_SAFE_STOP_DEV \
>   		| UBLK_F_BATCH_IO \
> -		| UBLK_F_NO_AUTO_PART_SCAN)
> +		| UBLK_F_PARTITIONS \
> +		| UBLK_F_AUTO_PART_SCAN)
>   
>   #define UBLK_F_ALL_RECOVERY_FLAGS (UBLK_F_USER_RECOVERY \
>   		| UBLK_F_USER_RECOVERY_REISSUE \
> @@ -2361,14 +2362,9 @@ static void ublk_partition_scan_work(struct work_struct *work)
>   	if (!disk)
>   		return;
>   
> -	if (WARN_ON_ONCE(!test_and_clear_bit(GD_SUPPRESS_PART_SCAN,
> -					     &disk->state)))
> -		goto out;
> -
>   	mutex_lock(&disk->open_mutex);
>   	bdev_disk_changed(disk, false);
>   	mutex_unlock(&disk->open_mutex);
> -out:
>   	ublk_put_disk(disk);
>   }
>   
> @@ -4409,9 +4405,13 @@ static int ublk_ctrl_start_dev(struct ublk_device *ub,
>   	 * wait while holding ub->mutex, which can deadlock with other
>   	 * operations that need the mutex. Defer partition scan to async
>   	 * work.
> -	 * For unprivileged daemons, keep GD_SUPPRESS_PART_SCAN set
> -	 * permanently.
> +	 * For unprivileged daemons, set GENHD_FL_NO_PART to
> +	 * disable partitions.
>   	 */
> +	if (ub->unprivileged_daemons)
> +		disk->flags |= GENHD_FL_NO_PART;
> +
> +	/* Disable partition scans */
>   	set_bit(GD_SUPPRESS_PART_SCAN, &disk->state);
>   
>   	ublk_get_device(ub);
> @@ -4429,13 +4429,17 @@ static int ublk_ctrl_start_dev(struct ublk_device *ub,
>   
>   	set_bit(UB_STATE_USED, &ub->state);
>   
> -	/* Skip partition scan if disabled by user */
> -	if (ub->dev_info.flags & UBLK_F_NO_AUTO_PART_SCAN) {
> -		clear_bit(GD_SUPPRESS_PART_SCAN, &disk->state);
> -	} else {
> -		/* Schedule async partition scan for trusted daemons */
> -		if (!ub->unprivileged_daemons)
> -			schedule_work(&ub->partition_scan_work);
> +	if (!ub->unprivileged_daemons) {
> +		if (!(ub->dev_info.flags & UBLK_F_PARTITIONS)) {
> +			/* disable partitions on trusted device */
> +			disk->flags |= GENHD_FL_NO_PART;
> +		} else {
> +			/* Enable partition scan on device */
> +			clear_bit(GD_SUPPRESS_PART_SCAN, &disk->state);
> +			/* Schedule auto partition scan if requested */
> +			if (ub->dev_info.flags & UBLK_F_AUTO_PART_SCAN)
> +				schedule_work(&ub->partition_scan_work);
> +		}
>   	}
>   
>   out_put_cdev:

Why is this done in two different locations?
Wouldn't it be better to keep them both together to make the code
more readable?

> diff --git a/include/uapi/linux/ublk_cmd.h b/include/uapi/linux/ublk_cmd.h
> index a88876756805..467ecaa20ac1 100644
> --- a/include/uapi/linux/ublk_cmd.h
> +++ b/include/uapi/linux/ublk_cmd.h
> @@ -367,8 +367,11 @@
>    */
>   #define UBLK_F_SAFE_STOP_DEV	(1ULL << 17)
>   
> -/* Disable automatic partition scanning when device is started */
> -#define UBLK_F_NO_AUTO_PART_SCAN (1ULL << 18)
> +/* Enable partitions on the device */
> +#define UBLK_F_PARTITIONS (1ULL << 18)
> +
> +/* Perform automatic partition scanning when device is started */
> +#define UBLK_F_AUTO_PART_SCAN (1ULL << 19)
>   
>   /* device state */
>   #define UBLK_S_DEV_DEAD	0

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich
