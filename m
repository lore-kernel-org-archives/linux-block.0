Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75D9C17555
	for <linux-block@vger.kernel.org>; Mon,  4 Aug 2025 07:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754291399; cv=none; b=QsWaULBI8+HztrJG5J6bOuG0VBAfJV4hHXdBkrkpJZNTeIyWZXLM2w9t/Hn9KuOX9dTzseS6peo+GJKQeLQaIuBfeJcVlM8m2BEfzxhF9a9WkTQtq0golE0SRRT0X6Reb+6DbO3BV+XKhVZcEDqC/OaBotpPewZzhRUKJ7ox24M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754291399; c=relaxed/simple;
	bh=I/z8rmcoaV5DzCcADqUQD7Lz/fCtn6Zz1NPMJgPjp9o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZNnp0SA6205nOUrVkyB8Qvk7u/7X5FjQcEYuBzIquqoRG+e8BF7RHbhv2LEXGe/pfvu6X0TSAceFJNxyrdlHVZmv6mTC1sbeWAaptLMVZhC6f/p02jMSzr4G+xVzBcofuMU3jKqgQYxlJ9il4DsEciKPToj8iBRjhEhuONU0I1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=heibi4/6; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=c08jhDZ5; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=heibi4/6; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=c08jhDZ5; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="heibi4/6";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="c08jhDZ5";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="heibi4/6";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="c08jhDZ5"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id D495A1F387;
	Mon,  4 Aug 2025 07:09:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1754291395; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Negh4tHSiZMrp9bqxRcamim3dflYoy3ZG23RdVM2EBs=;
	b=heibi4/6pistdfrAwlIFAsJCYZd+sJIxIiWihL0BMrgXgVcUf0SVEHNZKlkjtwHYxQkPVN
	VxYtlcoSlNjCN7FoRyVVhhtFe3f69eCis5jEUCX7YmvUDsMYLjblON5R4WbWt6Lm1Y6PSN
	50P8eu1V8rK0T3Dn933RlJabtgUWUkE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1754291395;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Negh4tHSiZMrp9bqxRcamim3dflYoy3ZG23RdVM2EBs=;
	b=c08jhDZ5m2rcRcbKSmGVRSR0Xf2BMSQe89DDILRdDoJ8oq4nPTPHuIrtCY13Y6MF7A74rI
	iw+sIGNF6zda3bAA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b="heibi4/6";
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=c08jhDZ5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1754291395; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Negh4tHSiZMrp9bqxRcamim3dflYoy3ZG23RdVM2EBs=;
	b=heibi4/6pistdfrAwlIFAsJCYZd+sJIxIiWihL0BMrgXgVcUf0SVEHNZKlkjtwHYxQkPVN
	VxYtlcoSlNjCN7FoRyVVhhtFe3f69eCis5jEUCX7YmvUDsMYLjblON5R4WbWt6Lm1Y6PSN
	50P8eu1V8rK0T3Dn933RlJabtgUWUkE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1754291395;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Negh4tHSiZMrp9bqxRcamim3dflYoy3ZG23RdVM2EBs=;
	b=c08jhDZ5m2rcRcbKSmGVRSR0Xf2BMSQe89DDILRdDoJ8oq4nPTPHuIrtCY13Y6MF7A74rI
	iw+sIGNF6zda3bAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 91E8613A7E;
	Mon,  4 Aug 2025 07:09:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 360QIsNckGhkVAAAD6G6ig
	(envelope-from <hare@suse.de>); Mon, 04 Aug 2025 07:09:55 +0000
Message-ID: <ba73cffc-fd44-4129-bb9f-f54f49d0e6e6@suse.de>
Date: Mon, 4 Aug 2025 09:09:55 +0200
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/5] blk-mq: Defer freeing of tags page_list to SRCU
 callback
To: Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
 linux-block@vger.kernel.org
Cc: Yu Kuai <yukuai3@huawei.com>, John Garry <john.garry@huawei.com>,
 Sathya Prakash Veerichetty <sathya.prakash@broadcom.com>
References: <20250801114440.722286-1-ming.lei@redhat.com>
 <20250801114440.722286-4-ming.lei@redhat.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20250801114440.722286-4-ming.lei@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:dkim,suse.de:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Spam-Flag: NO
X-Spam-Level: 
X-Rspamd-Queue-Id: D495A1F387
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.51

On 8/1/25 13:44, Ming Lei wrote:
> Tag iterators can race with the freeing of the request pages(tags->page_list),
> potentially leading to use-after-free issues.
> 
> Defer the freeing of the page list and the tags structure itself until
> after an SRCU grace period has passed. This ensures that any concurrent
> tag iterators have completed before the memory is released. With this
> way, we can replace the big tags->lock in tags iterator code path with
> srcu for solving the issue.
> 
> This is achieved by:
> - Adding a new `srcu_struct tags_srcu` to `blk_mq_tag_set` to protect
>    tag map iteration.
> - Adding an `rcu_head` to `struct blk_mq_tags` to be used with
>    `call_srcu`.
> - Moving the page list freeing logic and the `kfree(tags)` call into a
>    new callback function, `blk_mq_free_tags_callback`.
> - In `blk_mq_free_tags`, invoking `call_srcu` to schedule the new
>    callback for deferred execution.
> 
> The read-side protection for the tag iterators will be added in a
> subsequent patch.
> 
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>   block/blk-mq-tag.c     | 24 +++++++++++++++++++++++-
>   block/blk-mq.c         | 26 +++++++++++++-------------
>   include/linux/blk-mq.h |  2 ++
>   3 files changed, 38 insertions(+), 14 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich
