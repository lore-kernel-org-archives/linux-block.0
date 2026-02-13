Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 939535464D
	for <linux-block@vger.kernel.org>; Fri, 13 Feb 2026 06:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770965807; cv=none; b=K+EVbTR4D41dvqSOqSg5NHxwHkfe1SOz7FuIZF63H7hsqFWdGhlUc3gjRIJy4GCD3ugdFmuF/no2Arq2hnaE5poA/1lQRUoVc5lp6CmE291ZQ6D8O5BJ4VvhcbKkSFGNii4R7hbSP9btE5pdHbs4LoOFrJsgNM2KWLNML83aa6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770965807; c=relaxed/simple;
	bh=NdhD4U0MWGPytrmPURxMcWeGcpmAu/wx+N2X+MTaPXo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=I0/jRHeAZ9oMvbm48aCEjSJuzARq0JFdnLrd79B3JSZTuBPTuz6UeQHq5c3pru0pH6XISBp/0ohufaE2HyANnETYEMK0ffWcUBqzTk/OPk3gzURf77pRn/95k2V4Gt6lrXKX9rSKd3gvGfI0TfpzGn375r0H4+iJYVIApe6zx1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=EMAYcn3M; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=94mMgXl0; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=EMAYcn3M; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=94mMgXl0; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="EMAYcn3M";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="94mMgXl0";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="EMAYcn3M";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="94mMgXl0"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 4DA383E6D4;
	Fri, 13 Feb 2026 06:56:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1770965798; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9Hs0m4tQy+Y6qVNqriNvxsK/fyXGkDeJFdqBjApZIic=;
	b=EMAYcn3MN9KFgJNkOCGxqGxInWQ7Z6ctsxaUq9nUkwQPPFjTkTb+jKuzsZb7Ykw7opMfiH
	nYSVnXzwpF8ASWpJhLKs7Wuwf+gAw0+CPO3b/YOwVioYlH428iac5/NanAZFG1I8RSqg+t
	kkz07OupKvPexCmS7IPUCJRE6Ge4JYs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1770965798;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9Hs0m4tQy+Y6qVNqriNvxsK/fyXGkDeJFdqBjApZIic=;
	b=94mMgXl0FV/PiJj+BadN7nmmGGMHQeaRU1EjywmIvRKQLx2xf7ZyWF0jM2UPNkFVxJ8WPU
	5xQXATTpghcqOsDA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1770965798; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9Hs0m4tQy+Y6qVNqriNvxsK/fyXGkDeJFdqBjApZIic=;
	b=EMAYcn3MN9KFgJNkOCGxqGxInWQ7Z6ctsxaUq9nUkwQPPFjTkTb+jKuzsZb7Ykw7opMfiH
	nYSVnXzwpF8ASWpJhLKs7Wuwf+gAw0+CPO3b/YOwVioYlH428iac5/NanAZFG1I8RSqg+t
	kkz07OupKvPexCmS7IPUCJRE6Ge4JYs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1770965798;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9Hs0m4tQy+Y6qVNqriNvxsK/fyXGkDeJFdqBjApZIic=;
	b=94mMgXl0FV/PiJj+BadN7nmmGGMHQeaRU1EjywmIvRKQLx2xf7ZyWF0jM2UPNkFVxJ8WPU
	5xQXATTpghcqOsDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1C3C93EA62;
	Fri, 13 Feb 2026 06:56:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id U+mFBSbLjmlUTAAAD6G6ig
	(envelope-from <hare@suse.de>); Fri, 13 Feb 2026 06:56:38 +0000
Message-ID: <bf9fb99d-fa41-40cd-906d-0f8029c7f03a@suse.de>
Date: Fri, 13 Feb 2026 07:56:37 +0100
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ublk: cleanup flag handling and fix
 UBLK_F_NO_AUTO_PART_SCAN
To: Ming Lei <ming.lei@redhat.com>, Alexander Atanasov <alex@zazolabs.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
 Yoav Cohen <yoav@nvidia.com>
References: <20260212152553.1737373-1-alex@zazolabs.com>
 <aY6fAlXmzQZCKwmM@fedora>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <aY6fAlXmzQZCKwmM@fedora>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Score: -4.30
X-Spam-Level: 

On 2/13/26 04:48, Ming Lei wrote:
> On Thu, Feb 12, 2026 at 03:25:52PM +0000, Alexander Atanasov wrote:
>> Currently the code misuse GD_SUPPRESS_PART_SCAN flag
>> as it tries to use it as a switch for the auto partition scan.
>> When UBLK_F_NO_AUTO_PART_SCAN is not passed a proper
>> auto partition scanning is not done because the first
>> call to ublk_partition_scan_work will clear the bit
>> GD_SUPPRESS_PART_SCAN but not actually load the partitions.
>>
>> How it should work:
>> Unprivileged daemons - never scan partitions, they have
>> GD_SUPPRESS_PART_SCAN always set - they are marked as devices
>> without partitions. While ioctl(BLKRRPART) does require
>> CAP_SYS_ADMIN, block layer have its own a check in
>> disk_has_partscan(...) if partitions are supported.
>>
>> Trusted daemons - auto scan partitions by default
>> and they do not have the bit set, so they do have partitions.
>>
>> For trusted daemons auto partitions scan is performed but it can
>> be skipped if user have set UBLK_F_NO_AUTO_PART_SCAN flag.
>>
>> Rework the code to work as described above:
>> - remove checks in ublk_partition_scan_work and rely on
>> the caller to schedule the work only if it has to be done.
>> - keep GD_SUPPRESS_PART_SCAN always set on unprivileged
>> - keep GD_SUPPRESS_PART_SCAN always clear on trusted
>> - Properly handle user request to skip auto partitioning scanning
>>
>> Fixes: 8443e2087e70 ("ublk: add UBLK_F_NO_AUTO_PART_SCAN feature flag")
>> Signed-off-by: Alexander Atanasov <alex@zazolabs.com>
>> ---
>>   drivers/block/ublk_drv.c | 14 ++++----------
>>   1 file changed, 4 insertions(+), 10 deletions(-)
>>
>> Cc: Yoav Cohen <yoav@nvidia.com>
>>
>> diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
>> index 3c918db4905c..e662c6e8e722 100644
>> --- a/drivers/block/ublk_drv.c
>> +++ b/drivers/block/ublk_drv.c
>> @@ -2361,14 +2361,9 @@ static void ublk_partition_scan_work(struct work_struct *work)
>>   	if (!disk)
>>   		return;
>>   
>> -	if (WARN_ON_ONCE(!test_and_clear_bit(GD_SUPPRESS_PART_SCAN,
>> -					     &disk->state)))
>> -		goto out;
>> -
> 
> It is wrong to remove clearing GD_SUPPRESS_PART_SCAN, otherwise ioctl(BLKRRPART)
> can't succeed.
> 
>>   	mutex_lock(&disk->open_mutex);
>>   	bdev_disk_changed(disk, false);
>>   	mutex_unlock(&disk->open_mutex);
>> -out:
>>   	ublk_put_disk(disk);
>>   }
>>   
>> @@ -4429,12 +4424,11 @@ static int ublk_ctrl_start_dev(struct ublk_device *ub,
>>   
>>   	set_bit(UB_STATE_USED, &ub->state);
>>   
>> -	/* Skip partition scan if disabled by user */
>> -	if (ub->dev_info.flags & UBLK_F_NO_AUTO_PART_SCAN) {
>> +	if (!ub->unprivileged_daemons) {
>> +		/* Enable partition scanning for trusted daemons */
>>   		clear_bit(GD_SUPPRESS_PART_SCAN, &disk->state);
>> -	} else {
>> -		/* Schedule async partition scan for trusted daemons */
>> -		if (!ub->unprivileged_daemons)
>> +		/* Skip auto partition scan if requested by user */
>> +		if (!(ub->dev_info.flags & UBLK_F_NO_AUTO_PART_SCAN))
>>   			schedule_work(&ub->partition_scan_work);
> 
> We may switch to disallow partition scan permanently for UBLK_F_NO_AUTO_PART_SCAN
> per discussion in the following thread:
> 
> https://lore.kernel.org/linux-block/0535f4dd-ada3-414a-84c6-7abc232aa670@kernel.dk/
> 
> So the change may can be simplified as below, meantime
> selftests/ublk/test_part_01.sh need to be updated.
> 
> Alexander, please let us know if you'd like work this way?
> 
> diff --git a/include/uapi/linux/ublk_cmd.h b/include/uapi/linux/ublk_cmd.h
> index a88876756805..d6f479fff75b 100644
> --- a/include/uapi/linux/ublk_cmd.h
> +++ b/include/uapi/linux/ublk_cmd.h
> @@ -367,8 +367,8 @@
>    */
>   #define UBLK_F_SAFE_STOP_DEV   (1ULL << 17)
> 
> -/* Disable automatic partition scanning when device is started */
> -#define UBLK_F_NO_AUTO_PART_SCAN (1ULL << 18)
> +/* Disable partition scanning */
> +#define UBLK_F_NO_PART_SCAN    (1ULL << 18)
> 
>   /* device state */
>   #define UBLK_S_DEV_DEAD        0
> [root@ktest-40 linux]# git diff
> diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> index c13cda58a7c6..f1a104222fb1 100644
> --- a/drivers/block/ublk_drv.c
> +++ b/drivers/block/ublk_drv.c
> @@ -81,7 +81,7 @@
>                  | (IS_ENABLED(CONFIG_BLK_DEV_INTEGRITY) ? UBLK_F_INTEGRITY : 0) \
>                  | UBLK_F_SAFE_STOP_DEV \
>                  | UBLK_F_BATCH_IO \
> -               | UBLK_F_NO_AUTO_PART_SCAN)
> +               | UBLK_F_NO_PART_SCAN)
> 
>   #define UBLK_F_ALL_RECOVERY_FLAGS (UBLK_F_USER_RECOVERY \
>                  | UBLK_F_USER_RECOVERY_REISSUE \
> @@ -4438,14 +4438,13 @@ static int ublk_ctrl_start_dev(struct ublk_device *ub,
> 
>          set_bit(UB_STATE_USED, &ub->state);
> 
> -       /* Skip partition scan if disabled by user */
> -       if (ub->dev_info.flags & UBLK_F_NO_AUTO_PART_SCAN) {
> -               clear_bit(GD_SUPPRESS_PART_SCAN, &disk->state);
> -       } else {
> -               /* Schedule async partition scan for trusted daemons */
> -               if (!ub->unprivileged_daemons)
> -                       schedule_work(&ub->partition_scan_work);
> -       }
> +       /*
> +        * Only schedule async partition scan in case of
> +        * !UBLK_F_NO_PART_SCAN and trusted daemons
> +        */
> +       if (!(ub->dev_info.flags & UBLK_F_NO_PART_SCAN) &&
> +                       !ub->unprivileged_daemons)
> +               schedule_work(&ub->partition_scan_work);
> 
>   out_put_cdev:
>          if (ret) {
> diff --git a/include/uapi/linux/ublk_cmd.h b/include/uapi/linux/ublk_cmd.h
> index a88876756805..d6f479fff75b 100644
> --- a/include/uapi/linux/ublk_cmd.h
> +++ b/include/uapi/linux/ublk_cmd.h
> @@ -367,8 +367,8 @@
>    */
>   #define UBLK_F_SAFE_STOP_DEV   (1ULL << 17)
> 
> -/* Disable automatic partition scanning when device is started */
> -#define UBLK_F_NO_AUTO_PART_SCAN (1ULL << 18)
> +/* Disable partition scanning */
> +#define UBLK_F_NO_PART_SCAN    (1ULL << 18)
> 
>   /* device state */
>   #define UBLK_S_DEV_DEAD        0
> 
> 
Thanks, that is precisely what I had in mind.

You can add:

Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich
