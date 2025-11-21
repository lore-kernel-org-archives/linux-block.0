Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 321D82F1FD1
	for <linux-block@vger.kernel.org>; Fri, 21 Nov 2025 07:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763708982; cv=none; b=By05FbyETJBbSVqh8fUWftEhBja2Jl3gd4oeDTy+FnJqfFIteNhvBUgmH4mGQmC1Sw2SAf0eo58RLbuF59aVsTm4eiwxts6Bd7QCcfs0ccZGbYSlNIt5iOJ9z2dFfXPHV1SNKxMH/YAAdjUXy9oQUidKK7jT38m3sgAmXR9jDYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763708982; c=relaxed/simple;
	bh=wC+6btSS0Krm5+iwoRz0Rbf122DKbT7noFiwL/keFgE=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=dHe9tftvW+LeJOEVJaeTPcMwr19hxW9YQfMxhFR0SJMsuTx+z+BkuHhXXj/DuNPuYwqxzwZCGDU5s5IbuKhfOT1G83v/c8Ytqg1z4pOx/BQkcTlRHy2DI2nsq7hzJ0B1Fp9toxOYE5yINxvVsqB64dsVHJ5IoorAJF9ztY+H758=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=nr3IiISk; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=6z2N5tpC; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=nr3IiISk; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=6z2N5tpC; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="nr3IiISk";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="6z2N5tpC";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="nr3IiISk";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="6z2N5tpC"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 3A1012189C;
	Fri, 21 Nov 2025 07:09:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1763708978; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xjAp9ozt7wqK8M7Wx7/Wv+fJWEahVbkHnKlMzx+Cvaw=;
	b=nr3IiISkiwrUTqZQLOaPbvDw66NWyOTcTLyI/YGvBTMUvOei5QHV/L2JIS+6B34tdcYSQH
	gLzRq+SUMVoxTfOaYV2wLQtUB3sRGtpx2fDSknS8eJMTsxxQnYZkr15K08Aenw8Kwjt2dz
	gxX3KVBZh/IwV6aWGf6NqfqCymFwjdg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1763708978;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xjAp9ozt7wqK8M7Wx7/Wv+fJWEahVbkHnKlMzx+Cvaw=;
	b=6z2N5tpC85tLntGJg3ldGk5e79c/SCu4Lt1KAXg9GPi7yq+E0UxFfHLhUycpx37d0adnFB
	VdFVdtl9faoHEXDg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1763708978; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xjAp9ozt7wqK8M7Wx7/Wv+fJWEahVbkHnKlMzx+Cvaw=;
	b=nr3IiISkiwrUTqZQLOaPbvDw66NWyOTcTLyI/YGvBTMUvOei5QHV/L2JIS+6B34tdcYSQH
	gLzRq+SUMVoxTfOaYV2wLQtUB3sRGtpx2fDSknS8eJMTsxxQnYZkr15K08Aenw8Kwjt2dz
	gxX3KVBZh/IwV6aWGf6NqfqCymFwjdg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1763708978;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xjAp9ozt7wqK8M7Wx7/Wv+fJWEahVbkHnKlMzx+Cvaw=;
	b=6z2N5tpC85tLntGJg3ldGk5e79c/SCu4Lt1KAXg9GPi7yq+E0UxFfHLhUycpx37d0adnFB
	VdFVdtl9faoHEXDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 038553EA61;
	Fri, 21 Nov 2025 07:09:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id rUDsOjEQIGmLbwAAD6G6ig
	(envelope-from <hare@suse.de>); Fri, 21 Nov 2025 07:09:37 +0000
Message-ID: <4171e102-855b-43a2-bef0-dc0b42868827@suse.de>
Date: Fri, 21 Nov 2025 08:09:37 +0100
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 2/8] blk-mq-sched: unify elevators checking for async
 requests
To: Yu Kuai <yukuai@fnnas.com>, axboe@kernel.dk, nilay@linux.ibm.com,
 bvanassche@acm.org, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20251121052901.1341976-1-yukuai@fnnas.com>
 <20251121052901.1341976-3-yukuai@fnnas.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20251121052901.1341976-3-yukuai@fnnas.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.998];
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
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:email,fnnas.com:email]
X-Spam-Flag: NO
X-Spam-Score: -4.30
X-Spam-Level: 

On 11/21/25 06:28, Yu Kuai wrote:
> bfq and mq-deadline consider sync writes as async requests and only
> reserve tags for sync reads by async_depth, however, kyber doesn't
> consider sync writes as async requests for now.
> 
> Consider the case there are lots of dirty pages, and user use fsync to
> flush dirty pages. In this case sched_tags can be exhausted by sync writes
> and sync reads can stuck waiting for tag. Hence let kyber follow what
> mq-deadline and bfq did, and unify async requests checking for all
> elevators.
> 
> Signed-off-by: Yu Kuai <yukuai@fnnas.com>
> Reviewed-by: Nilay Shroff <nilay@linux.ibm.com>
> ---
>   block/bfq-iosched.c   | 2 +-
>   block/blk-mq-sched.h  | 5 +++++
>   block/kyber-iosched.c | 2 +-
>   block/mq-deadline.c   | 2 +-
>   4 files changed, 8 insertions(+), 3 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich
