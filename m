Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B8221C6FF2
	for <linux-block@vger.kernel.org>; Wed, 30 Apr 2025 06:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745994835; cv=none; b=TLj5k/iCnPYqGaHqzBnjzLGXM/mq6e5LIO77nzBrME+sUFArouyjirJPA4QkZgMZNl/J1Mrw9xXZq0yz5YaanAAoSNcgmZJa920T7QEwUE1ilIWphVWKevFkH3hpTLOMnQ4mF3fc0w6/js/Mu7pUFAeIBAAyu2uGJ3J5StaMe88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745994835; c=relaxed/simple;
	bh=b7sWOoeaFLs/Vm8RUItqrqrHu+MG/qntAZ6jZl/bn+k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CYJNDgKxBryFlnFvppvXow81DQ9oX35AtUrB1KlydZ7ry5ReM7cwNRZknkRvT0pY4bc22PFjdZNgWjOov28e1C1sMYyVlHndtH5Y77jeCWdENE5X6PgyGIatDl2c0x3h+0V3Kyx8UEJZRzJbCy27gmt6vfRxXRRPywCmWrO5bVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=TmJFYt70; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=JLFAsazb; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=TmJFYt70; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=JLFAsazb; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="TmJFYt70";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="JLFAsazb";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="TmJFYt70";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="JLFAsazb"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 848F81F7BF;
	Wed, 30 Apr 2025 06:33:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1745994831; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=F7gkMt4PdXyq3A6eCbiJHG5s01uzdhIy823TC/1jCtE=;
	b=TmJFYt70ASwmnygTsWC8tTNIdSX/4teFK5HI3+pC/MLWY/8CECOfFXH0Our88ti3FZBEdP
	mnZy/f3bfbOzIjQRoS666yvketsBgAQAjhHOFqwLWX6xitEdJOaKtY+l2C/ahgPmGmR450
	RUuvEvbL6h5mwU5KNjnD5YxTKMjFcug=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1745994831;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=F7gkMt4PdXyq3A6eCbiJHG5s01uzdhIy823TC/1jCtE=;
	b=JLFAsazbVa5zirLq+l4xwACBeP2MFW+Y1koOSqA3P4Hb6kvMAivtjR/DcV4g5R2vs1WDEh
	CaDVSATR4kpJTVAA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1745994831; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=F7gkMt4PdXyq3A6eCbiJHG5s01uzdhIy823TC/1jCtE=;
	b=TmJFYt70ASwmnygTsWC8tTNIdSX/4teFK5HI3+pC/MLWY/8CECOfFXH0Our88ti3FZBEdP
	mnZy/f3bfbOzIjQRoS666yvketsBgAQAjhHOFqwLWX6xitEdJOaKtY+l2C/ahgPmGmR450
	RUuvEvbL6h5mwU5KNjnD5YxTKMjFcug=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1745994831;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=F7gkMt4PdXyq3A6eCbiJHG5s01uzdhIy823TC/1jCtE=;
	b=JLFAsazbVa5zirLq+l4xwACBeP2MFW+Y1koOSqA3P4Hb6kvMAivtjR/DcV4g5R2vs1WDEh
	CaDVSATR4kpJTVAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3AB10139E7;
	Wed, 30 Apr 2025 06:33:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id llazDE/EEWjOawAAD6G6ig
	(envelope-from <hare@suse.de>); Wed, 30 Apr 2025 06:33:51 +0000
Message-ID: <a74b1d2b-40b6-4ac9-9c89-29ebec188dc6@suse.de>
Date: Wed, 30 Apr 2025 08:33:50 +0200
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V4 24/24] block: move wbt_enable_default() out of queue
 freezing from sched ->exit()
To: Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
 linux-block@vger.kernel.org
Cc: Nilay Shroff <nilay@linux.ibm.com>,
 Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Christoph Hellwig <hch@lst.de>
References: <20250430043529.1950194-1-ming.lei@redhat.com>
 <20250430043529.1950194-25-ming.lei@redhat.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20250430043529.1950194-25-ming.lei@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:mid,imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -4.30
X-Spam-Flag: NO

On 4/30/25 06:35, Ming Lei wrote:
> scheduler's ->exit() is called with queue frozen and elevator lock is held, and
> wbt_enable_default() can't be called with queue frozen, otherwise the
> following lockdep warning is triggered:
> 
> 	#6 (&q->rq_qos_mutex){+.+.}-{4:4}:
> 	#5 (&eq->sysfs_lock){+.+.}-{4:4}:
> 	#4 (&q->elevator_lock){+.+.}-{4:4}:
> 	#3 (&q->q_usage_counter(io)#3){++++}-{0:0}:
> 	#2 (fs_reclaim){+.+.}-{0:0}:
> 	#1 (&sb->s_type->i_mutex_key#3){+.+.}-{4:4}:
> 	#0 (&q->debugfs_mutex){+.+.}-{4:4}:
> 
> Fix the issue by moving wbt_enable_default() out of bfq's exit(), and
> call it from elevator_change_done().
> 
> Meantime add disk->rqos_state_mutex for covering wbt state change, which
> matches the purpose more than ->elevator_lock.
> 
> Reviewed-by: Nilay Shroff <nilay@linux.ibm.com>
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>   block/bfq-iosched.c    |  2 +-
>   block/blk-sysfs.c      | 10 ++++------
>   block/blk-wbt.c        |  6 ++++++
>   block/elevator.c       |  5 +++++
>   block/elevator.h       |  1 +
>   block/genhd.c          |  1 +
>   include/linux/blkdev.h |  2 ++
>   7 files changed, 20 insertions(+), 7 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich
