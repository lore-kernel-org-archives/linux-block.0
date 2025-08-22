Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23CFF12BF24
	for <linux-block@vger.kernel.org>; Fri, 22 Aug 2025 06:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755842445; cv=none; b=CNpEflZvG7vvAlsLHYVgs5vpB9Wvv1/IdHROjh2dgff5DcW/0LOIwGKRcjvVKvkIbeNmxlKwTvLi0+kR2um4HFC7Fzw59lH3cohYFfMhinayzXnjjCrOYkan/MoUxqECVC54ojYA6/unOhM4K3EHedyOTsNoV9fbQiOmF3l3TwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755842445; c=relaxed/simple;
	bh=Hsu28x6IzRCXcaHUWtubLBpihWbp0i6OCTk0hUYfHV4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=r2B+AF6P5KcZLOME2arZQw/kxRE0a73kViY8gT2BOBuE/WbfDmZyszAeiXt9wEEIRIkZeytGkBK90NbNO1DcuZ1rXmJtioIkjzjrF55ZRaI/3FG+XtfN5K8fh73h8VdfLwBhXBj5S24+ixBHuaezRnAhjfT3U0kXL2kkXaB+bDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ZGNvSHHL; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=CcF/Cs48; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ZGNvSHHL; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=CcF/Cs48; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ZGNvSHHL";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="CcF/Cs48";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ZGNvSHHL";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="CcF/Cs48"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 526A021C62;
	Fri, 22 Aug 2025 06:00:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1755842435; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2fhi49797Kp+yXv4y3ZtIic0AEP4kzxNiP6xfvFNhXc=;
	b=ZGNvSHHLHhRnMq36vWyzx8bSITdgZCCQJz+oqjL12Y8zi8zJRV8S5hTsSuiQ6Q30bvUIEF
	Ez1a2jWla9WJYUCKTHayeeHTzDTA4qlz65CiXDVk01tERDjgsENN/g/Iy60uxYPeX6Ul3C
	vpC3BWnsA67oC1dVH5jfGgwogVBWJhI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1755842435;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2fhi49797Kp+yXv4y3ZtIic0AEP4kzxNiP6xfvFNhXc=;
	b=CcF/Cs483g4IrxO1fxAVrJztZRAsNZ+5cNqPv3PQYc1C4nVUj0pblF5Q0f+ol0tftnm0UV
	037WPIpqqh/XK4CQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1755842435; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2fhi49797Kp+yXv4y3ZtIic0AEP4kzxNiP6xfvFNhXc=;
	b=ZGNvSHHLHhRnMq36vWyzx8bSITdgZCCQJz+oqjL12Y8zi8zJRV8S5hTsSuiQ6Q30bvUIEF
	Ez1a2jWla9WJYUCKTHayeeHTzDTA4qlz65CiXDVk01tERDjgsENN/g/Iy60uxYPeX6Ul3C
	vpC3BWnsA67oC1dVH5jfGgwogVBWJhI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1755842435;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2fhi49797Kp+yXv4y3ZtIic0AEP4kzxNiP6xfvFNhXc=;
	b=CcF/Cs483g4IrxO1fxAVrJztZRAsNZ+5cNqPv3PQYc1C4nVUj0pblF5Q0f+ol0tftnm0UV
	037WPIpqqh/XK4CQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DEE3F13931;
	Fri, 22 Aug 2025 06:00:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id suGjM4IHqGg2bwAAD6G6ig
	(envelope-from <hare@suse.de>); Fri, 22 Aug 2025 06:00:34 +0000
Message-ID: <6aa22a6d-a037-4b4b-b403-1e36838602a1@suse.de>
Date: Fri, 22 Aug 2025 08:00:34 +0200
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] blk-mq: fix elevator depth_updated method
To: Yu Kuai <yukuai1@huaweicloud.com>, yukuai3@huawei.com, axboe@kernel.dk,
 bvanassche@acm.org, ming.lei@redhat.com, nilay@linux.ibm.com
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 yi.zhang@huawei.com, yangerkun@huawei.com, johnny.chenyi@huawei.com
References: <20250821060612.1729939-1-yukuai1@huaweicloud.com>
 <20250821060612.1729939-2-yukuai1@huaweicloud.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20250821060612.1729939-2-yukuai1@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.998];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid,suse.de:email]
X-Spam-Flag: NO
X-Spam-Level: 
X-Spam-Score: -4.30

On 8/21/25 08:06, Yu Kuai wrote:
> From: Yu Kuai <yukuai3@huawei.com>
> 
> Current depth_updated has some problems:
> 
> 1) depth_updated() will be called for each hctx, while all elevators
> will update async_depth for the disk level, this is not related to hctx;
> 2) In blk_mq_update_nr_requests(), if previous hctx update succeed and
> this hctx update failed, q->nr_requests will not be updated, while
> async_depth is already updated with new nr_reqeuests in previous
> depth_updated();
> 3) All elevators are using q->nr_requests to calculate async_depth now,
> however, q->nr_requests is still the old value when depth_updated() is
> called from blk_mq_update_nr_requests();
> 
> Those problems are first from error path, then mq-deadline, and recently
> for bfq and kyber, fix those problems by:
> 
> - pass in request_queue instead of hctx;
> - move depth_updated() after q->nr_requests is updated in
>    blk_mq_update_nr_requests();
> - add depth_updated() call inside init_sched() method to initialize
>    async_depth;
> - remove init_hctx() method for mq-deadline and bfq that is useless now;
> 
> Fixes: 77f1e0a52d26 ("bfq: update internal depth state when queue depth changes")
> Fixes: 39823b47bbd4 ("block/mq-deadline: Fix the tag reservation code")
> Fixes: 42e6c6ce03fd ("lib/sbitmap: convert shallow_depth from one word to the whole sbitmap")
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
> ---
>   block/bfq-iosched.c   | 22 +++++-----------------
>   block/blk-mq-sched.h  | 11 +++++++++++
>   block/blk-mq.c        | 23 ++++++++++++-----------
>   block/elevator.h      |  2 +-
>   block/kyber-iosched.c | 19 +++++++++----------
>   block/mq-deadline.c   | 16 +++-------------
>   6 files changed, 41 insertions(+), 52 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich
