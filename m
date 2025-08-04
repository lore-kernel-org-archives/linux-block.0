Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0F683D3B3
	for <linux-block@vger.kernel.org>; Mon,  4 Aug 2025 07:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754291238; cv=none; b=Uc2k8i+rhgwCjD6p+x37QmQnKpjqwIEC8mFvQoax1OitY5ZkZ8m9cO97HU3XT9WtNwrEDEiZWN2mNINIAHvdW+VAEBA88QDdzrd3bBbzxAl7wVJ1AO/SHghvGcqFrOtbCWctbGw7KkhhDTMf4gBGJzzW4AoDDWSbbqJfVwHK+fE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754291238; c=relaxed/simple;
	bh=4Fz45A78sMtvlOxXLzkuWr/SXco1KE5MhkfqfzJTCxM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IGM3BJV1lVEXvOA04iPlcTzkxf/Cvry0d+40c/1aJMAsPKFxgbQBUJFelMPAvN1LdSRHJMDq/Ql7/ACYHrVx9WFLbzJQcpClFN2XSPYb4mmQefDz6OzFi9f7jOJX1yCd1ip3XO2HFP3halMFcZrF6JbhGYHE34H0ILyaiEhzNyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=HqZ1LxKM; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=DvsGN6dR; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=HqZ1LxKM; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=DvsGN6dR; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="HqZ1LxKM";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="DvsGN6dR";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="HqZ1LxKM";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="DvsGN6dR"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 2FE2C1F387;
	Mon,  4 Aug 2025 07:07:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1754291234; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8c/voVsn5+AslFD/VMlaeTPOPFANeh1O2fQozpW1UWs=;
	b=HqZ1LxKMs3A3C6sENtb4X9D2HxRUGAJIMkBKF8xVniIE2cMO6icU0eqT5Lpn9ERqm0oLQn
	/zfizwP7GoGLgSydklWYRNAgRiB49NBxuivBu81vEbCMu/osmTSY1aj3GIhxKOLsHJbL82
	sxFOnvaVlGGqcrlDCTqIG/eorCHl7ek=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1754291234;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8c/voVsn5+AslFD/VMlaeTPOPFANeh1O2fQozpW1UWs=;
	b=DvsGN6dRVHHEwW+XfUOGjJUo3OSHEjxztTdwu2MiAPR1tzK1MXwVn/PSnpalxeEfZqE0rV
	xHp7kHfi53FYAOCQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1754291234; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8c/voVsn5+AslFD/VMlaeTPOPFANeh1O2fQozpW1UWs=;
	b=HqZ1LxKMs3A3C6sENtb4X9D2HxRUGAJIMkBKF8xVniIE2cMO6icU0eqT5Lpn9ERqm0oLQn
	/zfizwP7GoGLgSydklWYRNAgRiB49NBxuivBu81vEbCMu/osmTSY1aj3GIhxKOLsHJbL82
	sxFOnvaVlGGqcrlDCTqIG/eorCHl7ek=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1754291234;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8c/voVsn5+AslFD/VMlaeTPOPFANeh1O2fQozpW1UWs=;
	b=DvsGN6dRVHHEwW+XfUOGjJUo3OSHEjxztTdwu2MiAPR1tzK1MXwVn/PSnpalxeEfZqE0rV
	xHp7kHfi53FYAOCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E1CB113A7E;
	Mon,  4 Aug 2025 07:07:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 8UoiNSFckGiUUwAAD6G6ig
	(envelope-from <hare@suse.de>); Mon, 04 Aug 2025 07:07:13 +0000
Message-ID: <594e8fa8-76dc-473c-a036-0eabb0de7acb@suse.de>
Date: Mon, 4 Aug 2025 09:07:13 +0200
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] blk-mq: Move flush queue allocation into
 blk_mq_init_hctx()
To: Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
 linux-block@vger.kernel.org
Cc: Yu Kuai <yukuai3@huawei.com>, John Garry <john.garry@huawei.com>,
 Sathya Prakash Veerichetty <sathya.prakash@broadcom.com>
References: <20250801114440.722286-1-ming.lei@redhat.com>
 <20250801114440.722286-2-ming.lei@redhat.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20250801114440.722286-2-ming.lei@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Level: 
X-Spam-Score: -4.30

On 8/1/25 13:44, Ming Lei wrote:
> Move flush queue allocation into blk_mq_init_hctx() and its release into
> blk_mq_exit_hctx(), and prepare for replacing tags->lock with SRCU to
> draining inflight request walking. blk_mq_exit_hctx() is the last chance
> for us to get valid `tag_set` reference, and we need to add one SRCU to
> `tag_set` for freeing flush request via call_srcu().
> 
> It is safe to move flush queue & request release into blk_mq_exit_hctx(),
> because blk_mq_clear_flush_rq_mapping() clears the flush request
> reference int driver tags inflight request table, meantime inflight
> request walking is drained.
> 
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>   block/blk-mq-sysfs.c |  1 -
>   block/blk-mq.c       | 20 +++++++++++++-------
>   2 files changed, 13 insertions(+), 8 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich
