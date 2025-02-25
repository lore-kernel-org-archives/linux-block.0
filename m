Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62FC8174EF0
	for <linux-block@vger.kernel.org>; Tue, 25 Feb 2025 07:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740470344; cv=none; b=uKlYgZ2jBKFR1lbZc72Ai32PNL0sLEKHSSRKlT0RAcPaL9tskQeMTZSPxM3ie4cbd6DK1eCJh3++Z0gd3xtGlTO7KBTtlH/ZruU2bKmkxFZdQ0KCKwXSIUG51cTqrzMgVozrwYXCSFAYaJJKA+qScfEbdLo4ryRux+JCz0QxOFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740470344; c=relaxed/simple;
	bh=ShkOK5pdqkbRtP0ouHDg682g/j/5We7teGwEzwSBwFE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pbjYH+jaaW+KbJkbL8Wc26YVlA3q+AP9xQQ/xO8RRiJbKZETfhB155jnd1Nn+tXEELjX1sG5n3QFojrngui2F1ec/y43JNihJN7eq4sCTTzxzeO5dsDJjDR+fJha9eURubZ8HQyfTnEWMnzw/v/lM0Q2ofi4hkT0u5NnV2MQ6Qs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Fhflh28k; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=p9Zm93Kh; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Fhflh28k; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=p9Zm93Kh; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Fhflh28k";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="p9Zm93Kh";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Fhflh28k";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="p9Zm93Kh"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 6F76321189;
	Tue, 25 Feb 2025 07:59:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1740470340; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YhctJXMVw6DuK62Mp1dauwG/Q1+zjup/bCekczzKHuc=;
	b=Fhflh28kK/ercjfNlN9OFz12/3DUZ9av52JLviKMOQziNxuQ/Oy3cXfrJgHlYtlpTFkaLv
	miFQ73FXgkyRWYfOZnOBQySsLBCf4ZYp7ZbabuWJ8aEQyaGWpgtHh+4dGVUQwnwAnaE1Gv
	8id+FYKN0TwpIvPKMadyvqIT9rYKdmw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1740470340;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YhctJXMVw6DuK62Mp1dauwG/Q1+zjup/bCekczzKHuc=;
	b=p9Zm93Kh/f+LIX1Krh8iV+LMTaaywKlWcfB548f7X5pozKcOZY4OnVM4QeqG76eR54z/Gc
	EgILG31PcOx8I7Bg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1740470340; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YhctJXMVw6DuK62Mp1dauwG/Q1+zjup/bCekczzKHuc=;
	b=Fhflh28kK/ercjfNlN9OFz12/3DUZ9av52JLviKMOQziNxuQ/Oy3cXfrJgHlYtlpTFkaLv
	miFQ73FXgkyRWYfOZnOBQySsLBCf4ZYp7ZbabuWJ8aEQyaGWpgtHh+4dGVUQwnwAnaE1Gv
	8id+FYKN0TwpIvPKMadyvqIT9rYKdmw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1740470340;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YhctJXMVw6DuK62Mp1dauwG/Q1+zjup/bCekczzKHuc=;
	b=p9Zm93Kh/f+LIX1Krh8iV+LMTaaywKlWcfB548f7X5pozKcOZY4OnVM4QeqG76eR54z/Gc
	EgILG31PcOx8I7Bg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3100913A61;
	Tue, 25 Feb 2025 07:59:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id XOBUCkR4vWdmdQAAD6G6ig
	(envelope-from <hare@suse.de>); Tue, 25 Feb 2025 07:59:00 +0000
Message-ID: <4e1feba0-e4c4-44fa-a6fa-437a927dbd60@suse.de>
Date: Tue, 25 Feb 2025 08:58:59 +0100
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv3 7/7] block: protect read_ahead_kb using q->limits_lock
To: Nilay Shroff <nilay@linux.ibm.com>, linux-block@vger.kernel.org
Cc: hch@lst.de, ming.lei@redhat.com, dlemoal@kernel.org, axboe@kernel.dk,
 gjoyce@ibm.com
References: <20250224133102.1240146-1-nilay@linux.ibm.com>
 <20250224133102.1240146-8-nilay@linux.ibm.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20250224133102.1240146-8-nilay@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Score: -4.30
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_DN_SOME(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 

On 2/24/25 14:30, Nilay Shroff wrote:
> The bdi->ra_pages could be updated under q->limits_lock because it's
> usually calculated from the queue limits by queue_limits_commit_update.
> So protect reading/writing the sysfs attribute read_ahead_kb using
> q->limits_lock instead of q->sysfs_lock.
> 
> Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
> ---
>   block/blk-sysfs.c | 16 ++++++++++------
>   1 file changed, 10 insertions(+), 6 deletions(-)
> 
> diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
> index 8f47d9f30fbf..228f81a9060f 100644
> --- a/block/blk-sysfs.c
> +++ b/block/blk-sysfs.c
> @@ -93,9 +93,9 @@ static ssize_t queue_ra_show(struct gendisk *disk, char *page)
>   {
>   	ssize_t ret;
>   
> -	mutex_lock(&disk->queue->sysfs_lock);
> +	mutex_lock(&disk->queue->limits_lock);
>   	ret = queue_var_show(disk->bdi->ra_pages << (PAGE_SHIFT - 10), page);
> -	mutex_unlock(&disk->queue->sysfs_lock);
> +	mutex_unlock(&disk->queue->limits_lock);
>   
>   	return ret;
>   }
> @@ -111,12 +111,15 @@ queue_ra_store(struct gendisk *disk, const char *page, size_t count)
>   	ret = queue_var_store(&ra_kb, page, count);
>   	if (ret < 0)
>   		return ret;
> -
> -	mutex_lock(&q->sysfs_lock);
> +	/*
> +	 * ->ra_pages is protected by ->limits_lock because it is usually
> +	 * calculated from the queue limits by queue_limits_commit_update.
> +	 */
> +	mutex_lock(&q->limits_lock);
>   	memflags = blk_mq_freeze_queue(q);
>   	disk->bdi->ra_pages = ra_kb >> (PAGE_SHIFT - 10);
> +	mutex_unlock(&q->limits_lock);
>   	blk_mq_unfreeze_queue(q, memflags);
> -	mutex_unlock(&q->sysfs_lock);
>   

Cf my comments to the previous patch: Ordering.

Here we take the lock _before_ 'freeze', with the previous patch we took
the lock _after_ 'freeze'.
Why?

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich
