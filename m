Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A0FF230BD2
	for <linux-block@vger.kernel.org>; Mon,  4 Aug 2025 07:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754291469; cv=none; b=RCrIXMkfJjykwaVDhLjGNRe0JO+vRTlFjeCeOtKhWuITvfwim8ujYNMT59p37nh2ozxHDYI6SgvxYBZcWgwy8CKd5Nso04Gz5yydQm+LX9Zti/275FUtQ+95rJCnXj9YB4N62RPgWkByVHRxszhfwIXFLh3BKXCHlnUQdsmiHG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754291469; c=relaxed/simple;
	bh=1+f9F7TCvwxHitSIeMrhvPc/Dz8+uPRyMyFwrZz6PAY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hMY5B99Jh6g9wJELbs38bDkleFVU/n4Q+UOXwe1f5zS/I0PXaweNcZrQKCaQAiWp4y+fdOKWWw8pjHd4QWh2Cu3wRf/MbTtY7pj6+/rK4QvjaD4zyauURo3sAEJNIVWKlAgYZw9L9k4jRzp9vEwvlgILzF27eGECCOXkzfrdRow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=qmD/DK2s; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=qHQhwu+o; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=qmD/DK2s; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=qHQhwu+o; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="qmD/DK2s";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="qHQhwu+o";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="qmD/DK2s";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="qHQhwu+o"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 4F8BF1F38F;
	Mon,  4 Aug 2025 07:11:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1754291465; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0jlXo628qwu+qBXsSPr4s49uPsnClp+Tvpn8ev5G0qw=;
	b=qmD/DK2seHYnl6N/7ef/p58n24VUrx5vewQLYSCZXK9uS6xXVu3paSi3JrEfbyL8puLkIN
	562V//L7PGX+XoWnpDNEt4y+N4WuUoxmL5ohfnpKj8LoCRiWKaochJnkg+FdBRXFVdDDZ5
	4/srBNIIXMSlahQMmugdrA7h42eGsB4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1754291465;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0jlXo628qwu+qBXsSPr4s49uPsnClp+Tvpn8ev5G0qw=;
	b=qHQhwu+oX9DknQVdcli7Qv1Y7/GPl916Apy6FkEQcrIUmkXsuN2B3PrjsPZlXBimUlliav
	uhlgc1DaeRJ91wCQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b="qmD/DK2s";
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=qHQhwu+o
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1754291465; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0jlXo628qwu+qBXsSPr4s49uPsnClp+Tvpn8ev5G0qw=;
	b=qmD/DK2seHYnl6N/7ef/p58n24VUrx5vewQLYSCZXK9uS6xXVu3paSi3JrEfbyL8puLkIN
	562V//L7PGX+XoWnpDNEt4y+N4WuUoxmL5ohfnpKj8LoCRiWKaochJnkg+FdBRXFVdDDZ5
	4/srBNIIXMSlahQMmugdrA7h42eGsB4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1754291465;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0jlXo628qwu+qBXsSPr4s49uPsnClp+Tvpn8ev5G0qw=;
	b=qHQhwu+oX9DknQVdcli7Qv1Y7/GPl916Apy6FkEQcrIUmkXsuN2B3PrjsPZlXBimUlliav
	uhlgc1DaeRJ91wCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 05A5D13A7E;
	Mon,  4 Aug 2025 07:11:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id aPb7OghdkGi5VAAAD6G6ig
	(envelope-from <hare@suse.de>); Mon, 04 Aug 2025 07:11:04 +0000
Message-ID: <6aa29bbd-fc91-4443-9acd-2e8fd32c2b3a@suse.de>
Date: Mon, 4 Aug 2025 09:11:04 +0200
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] blk-mq: Defer freeing flush queue to SRCU callback
To: Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
 linux-block@vger.kernel.org
Cc: Yu Kuai <yukuai3@huawei.com>, John Garry <john.garry@huawei.com>,
 Sathya Prakash Veerichetty <sathya.prakash@broadcom.com>
References: <20250801114440.722286-1-ming.lei@redhat.com>
 <20250801114440.722286-5-ming.lei@redhat.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20250801114440.722286-5-ming.lei@redhat.com>
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
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:mid,suse.de:dkim,suse.de:email];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Spam-Flag: NO
X-Spam-Level: 
X-Rspamd-Queue-Id: 4F8BF1F38F
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.51

On 8/1/25 13:44, Ming Lei wrote:
> The freeing of the flush queue/request in blk_mq_exit_hctx() can race with
> tag iterators that may still be accessing it. To prevent a potential
> use-after-free, the deallocation should be deferred until after a grace
> period. With this way, we can replace the big tags->lock in tags iterator
> code path with srcu for solving the issue.
> 
> This patch introduces an SRCU-based deferred freeing mechanism for the
> flush queue.
> 
> The changes include:
> - Adding a `rcu_head` to `struct blk_flush_queue`.
> - Creating a new callback function, `blk_free_flush_queue_callback`,
>    to handle the actual freeing.
> - Replacing the direct call to `blk_free_flush_queue()` in
>    `blk_mq_exit_hctx()` with `call_srcu()`, using the `tags_srcu`
>    instance to ensure synchronization with tag iterators.
> 
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>   block/blk-mq.c | 11 ++++++++++-
>   block/blk.h    |  1 +
>   2 files changed, 11 insertions(+), 1 deletion(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich
