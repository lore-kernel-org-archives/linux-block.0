Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E90E6D1A7
	for <linux-block@vger.kernel.org>; Fri, 22 Aug 2025 06:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755842534; cv=none; b=Y6E/esmhhSsjloam6a0gcf5R5dC6V1Al9q6ftny2/Wu1N5nK2yDerresUCAjpjLPGzpVfFwLs2yzGkjAB1WvtBSVnU4kIQC02fijvZ/epoPIx+r/l8VKVPq85kRqaGh5qvqJxNVcVguBPqtgK71RLaPeG+oaqLYSrVApBshQjy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755842534; c=relaxed/simple;
	bh=1JVnNdfLBOnNIdeD7fGIkd3Ek5IwlzNdWJqqDUD85PY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VYaiWx6wXQjMnHatzQKGV72y2i6XaItkXUWUep+lMFbFUqZ/uts/k7Bv0/ZCsUtGjKmAzbmidTScs8btLuXpZQOh+VV242QiORbJrPOkd6DsiYUgXt5UzFJzCfq/SZFz/bwoVKbWxo7sVQM+0nESyn9B8+3T1hhW5IlNbTDvLOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=nG2Eu8/o; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=YP8DHY5q; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=HiJ569t/; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=uhxelTzC; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="nG2Eu8/o";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="YP8DHY5q";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="HiJ569t/";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="uhxelTzC"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id B7AE122202;
	Fri, 22 Aug 2025 06:02:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1755842530; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7eUujeOKuc9BAh2tTNWF7XLJsEkTgJ5OHByJJd6O2e4=;
	b=nG2Eu8/oyxLy1OVHKvkQYHuV7wBjB1La5BcHnm7pg4WW09QaEc0tcXIYbeDGJFztBaXBef
	HlShzB7sdix+e7vA/XO4AbiuSLPaLv5sem1s/o2PwCafXpaKzIpJRS6jmIdwmQjsp1crig
	4epfwFsmuMX+oZtfqjjXutzbi3HlVos=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1755842530;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7eUujeOKuc9BAh2tTNWF7XLJsEkTgJ5OHByJJd6O2e4=;
	b=YP8DHY5qwv3iXR2ZhnAmUB6ljcdz6w/QnYcmUUgvxjoCuEBVs+C8qgGy8qyn2N6sRwQkFY
	e6MQLpdzZcTWHYCw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b="HiJ569t/";
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=uhxelTzC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1755842529; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7eUujeOKuc9BAh2tTNWF7XLJsEkTgJ5OHByJJd6O2e4=;
	b=HiJ569t/RPETNNPazYgLljjfxZqESK/iOOC2sX9h8rOnUN+j3eWbUVwa7Nc1mC2roNyHSZ
	+R1Kc/4HmNDRW5/lsv1o23MYzAvxPmE/qNyP/9DWHLZp+lE2kkDXnWD/hVynHDp9SIFzLZ
	oOHnipGhzGVWUrZJRvOv/+mqLllYRXM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1755842529;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7eUujeOKuc9BAh2tTNWF7XLJsEkTgJ5OHByJJd6O2e4=;
	b=uhxelTzCzhhqPTkR7Fp0jW/ihbKHUq+tliWUV8yeYxVhlp5vbLph6KrYHkASHgDZEwIIAZ
	xubkytoFNCQQYCAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5430413931;
	Fri, 22 Aug 2025 06:02:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id nln2EuEHqGibbwAAD6G6ig
	(envelope-from <hare@suse.de>); Fri, 22 Aug 2025 06:02:09 +0000
Message-ID: <00421980-4602-4fe4-9f54-1345a7709d71@suse.de>
Date: Fri, 22 Aug 2025 08:02:08 +0200
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] blk-mq: fix blk_mq_tags double free while
 nr_requests grown
To: Yu Kuai <yukuai1@huaweicloud.com>, yukuai3@huawei.com, axboe@kernel.dk,
 bvanassche@acm.org, ming.lei@redhat.com, nilay@linux.ibm.com
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 yi.zhang@huawei.com, yangerkun@huawei.com, johnny.chenyi@huawei.com
References: <20250821060612.1729939-1-yukuai1@huaweicloud.com>
 <20250821060612.1729939-3-yukuai1@huaweicloud.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20250821060612.1729939-3-yukuai1@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:mid,suse.de:dkim,suse.de:email,huawei.com:email];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.de:+]
X-Spam-Flag: NO
X-Spam-Level: 
X-Rspamd-Queue-Id: B7AE122202
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.51

On 8/21/25 08:06, Yu Kuai wrote:
> From: Yu Kuai <yukuai3@huawei.com>
> 
> In the case user trigger tags grow by queue sysfs attribute nr_requests,
> hctx->sched_tags will be freed directly and replaced with a new
> allocated tags, see blk_mq_tag_update_depth().
> 
> The problem is that hctx->sched_tags is from elevator->et->tags, while
> et->tags is still the freed tags, hence later elevator exit will try to
> free the tags again, causing kernel panic.
> 
> Fix this problem by replacing et->tags with new allocated tags as well.
> 
> Noted there are still some long term problems that will require some
> refactor to be fixed thoroughly[1].
> 
> [1] https://lore.kernel.org/all/20250815080216.410665-1-yukuai1@huaweicloud.com/
> Fixes: f5a6604f7a44 ("block: fix lockdep warning caused by lock dependency in elv_iosched_store")
> 
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
> Reviewed-by: Ming Lei <ming.lei@redhat.com>
> Reviewed-by: Nilay Shroff<nilay@linux.ibm.com>
> ---
>   block/blk-mq-tag.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
> index d880c50629d6..5cffa5668d0c 100644
> --- a/block/blk-mq-tag.c
> +++ b/block/blk-mq-tag.c
> @@ -622,6 +622,7 @@ int blk_mq_tag_update_depth(struct blk_mq_hw_ctx *hctx,
>   			return -ENOMEM;
>   
>   		blk_mq_free_map_and_rqs(set, *tagsptr, hctx->queue_num);
> +		hctx->queue->elevator->et->tags[hctx->queue_num] = new;
>   		*tagsptr = new;
>   	} else {
>   		/*

Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich
