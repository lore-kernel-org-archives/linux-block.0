Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 959DB125D6
	for <linux-block@vger.kernel.org>; Mon, 30 Jun 2025 06:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751264659; cv=none; b=KLzgdjG2LSKMpPyzp1tqmkBcrik09XOfDUy80N7xm+HtidCPvkPI7/8yDeWsSHNahq8bf6eOavl38Op9ESaIId9GJSxRuEXON6Uv+WrRo60L2qQJsz+um7tFE+7F3RhVqokUKbA3frbf7UaTAeNXVD6SkCTNYh1bg3gSeYdfYd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751264659; c=relaxed/simple;
	bh=fynkFCbTyhp+lP2+wQiko2FnkMARYFUhSXftkbijdpE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VH/MGWSDKYq6WzJnyw0JL9z2JZDUdELu0apYKnIqLrwvF1f3JIlJP8f/G16g9cKQcInIPHNjM1G0WK+nZ7ynw3y8rMimwAEOhkpEB1/a28PdLJNYt3RS4mWpAGBkUVmrxPPZ2Q+9Bsa8mnK77bBlCH5SdZQ3AB498vKu3323/98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Eq23olir; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=UhW4OSsP; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Eq23olir; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=UhW4OSsP; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Eq23olir";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="UhW4OSsP";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Eq23olir";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="UhW4OSsP"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 9E33E1F38C;
	Mon, 30 Jun 2025 06:24:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1751264654; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=F21BaYNzY9dHjXTi1V+jan0WC/eOZUKoUd5jhdBGaug=;
	b=Eq23olirpL/FqBnHKwhFRI1Yf/Fgl2wIwBU2y4G/YgcUZuObe1fbu1u8oATNqCZOGASYyW
	vSoGsKplwvNOad/Qu9x3jDjCTWpdCnTxzk1sdmeorIwHA8ntWyTreD4LUGoehqErlnmF5H
	uk9zo/9xfKAMis9fmW9ufSpKsDiooBo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1751264654;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=F21BaYNzY9dHjXTi1V+jan0WC/eOZUKoUd5jhdBGaug=;
	b=UhW4OSsPdGY0jkLblRYJQLsT9NmZ/vCHWgeKLUtifCdix+o+xo5WB5wFKMDW8yfznmqjnD
	c9ml6gmITCwlxnDg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=Eq23olir;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=UhW4OSsP
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1751264654; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=F21BaYNzY9dHjXTi1V+jan0WC/eOZUKoUd5jhdBGaug=;
	b=Eq23olirpL/FqBnHKwhFRI1Yf/Fgl2wIwBU2y4G/YgcUZuObe1fbu1u8oATNqCZOGASYyW
	vSoGsKplwvNOad/Qu9x3jDjCTWpdCnTxzk1sdmeorIwHA8ntWyTreD4LUGoehqErlnmF5H
	uk9zo/9xfKAMis9fmW9ufSpKsDiooBo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1751264654;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=F21BaYNzY9dHjXTi1V+jan0WC/eOZUKoUd5jhdBGaug=;
	b=UhW4OSsPdGY0jkLblRYJQLsT9NmZ/vCHWgeKLUtifCdix+o+xo5WB5wFKMDW8yfznmqjnD
	c9ml6gmITCwlxnDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 473CB13983;
	Mon, 30 Jun 2025 06:24:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 05BVD44tYmh4VgAAD6G6ig
	(envelope-from <hare@suse.de>); Mon, 30 Jun 2025 06:24:14 +0000
Message-ID: <07d77cbb-f2fe-4193-b027-039166f5540f@suse.de>
Date: Mon, 30 Jun 2025 08:24:13 +0200
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv6 3/3] block: fix potential deadlock while running
 nr_hw_queue update
To: Nilay Shroff <nilay@linux.ibm.com>, linux-block@vger.kernel.org
Cc: hch@lst.de, ming.lei@redhat.com, axboe@kernel.dk, sth@linux.ibm.com,
 lkp@intel.com, gjoyce@ibm.com
References: <20250630054756.54532-1-nilay@linux.ibm.com>
 <20250630054756.54532-4-nilay@linux.ibm.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20250630054756.54532-4-nilay@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 9E33E1F38C
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
	DKIM_TRACE(0.00)[suse.de:+]
X-Spam-Score: -4.51
X-Spam-Level: 

On 6/30/25 07:21, Nilay Shroff wrote:
> Move scheduler tags (sched_tags) allocation and deallocation outside
> both the ->elevator_lock and ->freeze_lock when updating nr_hw_queues.
> This change breaks the dependency chain from the percpu allocator lock
> to the elevator lock, helping to prevent potential deadlocks, as
> observed in the reported lockdep splat[1].
> 
> This commit introduces batch allocation and deallocation helpers for
> sched_tags, which are now used from within __blk_mq_update_nr_hw_queues
> routine while iterating through the tagset.
> 
> With this change, all sched_tags memory management is handled entirely
> outside the ->elevator_lock and the ->freeze_lock context, thereby
> eliminating the lock dependency that could otherwise manifest during
> nr_hw_queues updates.
> 
> [1] https://lore.kernel.org/all/0659ea8d-a463-47c8-9180-43c719e106eb@linux.ibm.com/
> 
> Reported-by: Stefan Haberland <sth@linux.ibm.com>
> Closes: https://lore.kernel.org/all/0659ea8d-a463-47c8-9180-43c719e106eb@linux.ibm.com/
> Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
> ---
>   block/blk-mq-sched.c | 63 ++++++++++++++++++++++++++++++++++++++++++++
>   block/blk-mq-sched.h |  4 +++
>   block/blk-mq.c       | 11 +++++++-
>   block/blk.h          |  2 +-
>   block/elevator.c     |  4 +--
>   5 files changed, 80 insertions(+), 4 deletions(-)
> 
> diff --git a/block/blk-mq-sched.c b/block/blk-mq-sched.c
> index 2d6d1ebdd8fb..da802df34a8c 100644
> --- a/block/blk-mq-sched.c
> +++ b/block/blk-mq-sched.c
> @@ -427,6 +427,30 @@ void blk_mq_free_sched_tags(struct elevator_tags *et,
>   	kfree(et);
>   }
>   
> +void blk_mq_free_sched_tags_batch(struct xarray *et_table,
> +		struct blk_mq_tag_set *set)
> +{
> +	struct request_queue *q;
> +	struct elevator_tags *et;
> +
> +	lockdep_assert_held_write(&set->update_nr_hwq_lock);
> +
> +	list_for_each_entry(q, &set->tag_list, tag_set_list) {
> +		/*
> +		 * Accessing q->elevator without holding q->elevator_lock is
> +		 * safe because we're holding here set->update_nr_hwq_lock in
> +		 * the writer context. So, scheduler update/switch code (which
> +		 * acquires the same lock but in the reader context) can't run
> +		 * concurrently.
> +		 */
> +		if (q->elevator) {
> +			et = xa_load(et_table, q->id);
> +			if (et)
> +				blk_mq_free_sched_tags(et, set);
> +		}
> +	}
> +}
> +
Odd. Do we allow empty sched_tags?
Why isn't this an error (or at least a warning)?

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich
