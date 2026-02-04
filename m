Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CB1D28980E
	for <linux-block@vger.kernel.org>; Wed,  4 Feb 2026 01:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770170234; cv=none; b=Sqscg6eozDNPGafNwU1MFhV/yxU54U7nGrxxEShJnQ0RhHQnUssS40BkgVb6Ua0foKOi4XpWh97bRlrSpiBO0kYvtorlIsMMBIEH2sROfWScyEzNwuVVAIpMS8YFdit4Tv0/fwJgL7XUqH220mzVhv5kM3htBJ1dZ+7eiSrUJj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770170234; c=relaxed/simple;
	bh=/ah7LDUQtqgsr7xbw+EGEVsQpj5hiTIlsg4EVjQ/fmI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QhCAWVwYLaiCuf0Xcx/JmLQb6wVy/LMNGgNTSsGOwRXxuU0wjlN48AtbqYh4qtFYwFP8s+BKLtxZTF9s2TWC+bWFojCe7+wlc2xntZPFXpPCduqePui+sXL0wPppDVFMBTWBuukRQYNc2KPYA0+bm9ecjzqyL6c0QIaNtS36BA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Uzvw+DI0; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=jubW67Ef; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=a/ZOIVw2; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=t1I+K6zk; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Uzvw+DI0";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="jubW67Ef";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="a/ZOIVw2";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="t1I+K6zk"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id BE0863E6D1;
	Wed,  4 Feb 2026 01:57:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1770170230; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xnSMeo7BkObWxCRlIg/TwQeVFgmNV0F/WQTC2+Vjn9I=;
	b=Uzvw+DI0Curq1r+ckxEgsDjMo9fVJfElv7e68QXgwz/sDfWAXNstQNMBQ0Ljt3Q3Vd3dtc
	l5tecISeHWzwgeVvhUeTWEfITO43aD4FRp34o8FUuWmGjgTNAMjx1SPz7fOUjHgc6tEyrJ
	uLesfY8JhHU5CcLQHcDP6f9ZagnCUn4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1770170230;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xnSMeo7BkObWxCRlIg/TwQeVFgmNV0F/WQTC2+Vjn9I=;
	b=jubW67Ef0nvqptd5zhsa8HTo5oDEeOQ9qmW4GXU3Jq0xwNOwB+bzuNQbydkwHFteQp4z3l
	LpiitAXzc2P4sQDg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1770170229; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xnSMeo7BkObWxCRlIg/TwQeVFgmNV0F/WQTC2+Vjn9I=;
	b=a/ZOIVw2e4b5fOHfqrmE9qUYpy6qew9vromEGwlLTibcv9N4w3AyiZD2ogNGLaFdWCZ4C0
	XuvIdqfvI2JEuzzCq4yIQRRKbEboT60a3VcV7QP0vtJnkLIOv3zxrlapsy7+EWThgbtXht
	BJJscAf3A7fE71EYJaA6hPCJMtbIpM0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1770170229;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xnSMeo7BkObWxCRlIg/TwQeVFgmNV0F/WQTC2+Vjn9I=;
	b=t1I+K6zkQ8aDui/MkSso9lqcY1lw3TfUUrgQzaNfxcjtGe281+RxtCOQb0Xw/BaWrcUL1h
	hIbORhgLWT43XZBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 361FC3EA63;
	Wed,  4 Feb 2026 01:57:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 6HqfOHKngmmNWQAAD6G6ig
	(envelope-from <hare@suse.de>); Wed, 04 Feb 2026 01:57:06 +0000
Message-ID: <2934c711-9d5c-4563-b453-e46a5c0e0513@suse.de>
Date: Wed, 4 Feb 2026 02:57:04 +0100
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 6/8] mq-deadline: covert to use
 request_queue->async_depth
To: Yu Kuai <yukuai@fnnas.com>, axboe@kernel.dk, linux-block@vger.kernel.org,
 tj@kernel.org, nilay@linux.ibm.com, ming.lei@redhat.com
Cc: bvanassche@acm.org
References: <20260203081952.732210-1-yukuai@fnnas.com>
 <20260203081952.732210-7-yukuai@fnnas.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20260203081952.732210-7-yukuai@fnnas.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.29 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.19)[-0.966];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:email]
X-Spam-Flag: NO
X-Spam-Score: -4.29
X-Spam-Level: 

On 2/3/26 09:19, Yu Kuai wrote:
> In downstream kernel, we test with mq-deadline with many fio workloads, and
> we found a performance regression after commit 39823b47bbd4
> ("block/mq-deadline: Fix the tag reservation code") with following test:
> 
> [global]
> rw=randread
> direct=1
> ramp_time=1
> ioengine=libaio
> iodepth=1024
> numjobs=24
> bs=1024k
> group_reporting=1
> runtime=60
> 
> [job1]
> filename=/dev/sda
> 
> Root cause is that mq-deadline now support configuring async_depth,
> although the default value is nr_request, however the minimal value is
> 1, hence min_shallow_depth is set to 1, causing wake_batch to be 1. For
> consequence, sbitmap_queue will be waken up after each IO instead of
> 8 IO.
> 
> In this test case, sda is HDD and max_sectors is 128k, hence each
> submitted 1M io will be splited into 8 sequential 128k requests, however
> due to there are 24 jobs and total tags are exhausted, the 8 requests are
> unlikely to be dispatched sequentially, and changing wake_batch to 1
> will make this much worse, accounting blktrace D stage, the percentage
> of sequential io is decreased from 8% to 0.8%.
> 
> Fix this problem by converting to request_queue->async_depth, where
> min_shallow_depth is set each time async_depth is updated.
> 
> Noted elevator attribute async_depth is now removed, queue attribute
> with the same name is used instead.
> 
> Fixes: 39823b47bbd4 ("block/mq-deadline: Fix the tag reservation code")
> Signed-off-by: Yu Kuai <yukuai@fnnas.com>
> Reviewed-by: Nilay Shroff <nilay@linux.ibm.com>
> Reviewed-by: Bart Van Assche <bvanassche@acm.org>
> ---
>   block/mq-deadline.c | 39 +++++----------------------------------
>   1 file changed, 5 insertions(+), 34 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich
