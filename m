Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE0551D5CDE
	for <linux-block@vger.kernel.org>; Tue,  1 Jul 2025 10:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751367132; cv=none; b=hRivmb6sEBcZ3AOCv0cOixEPsqT5U0B4HG+JV8XVald72UPRlAqh5eVuEgD6VEc8jRZc9ZtXCDyeTLgEmLI7cdThUwsmz1ZzFX/slHJ57Hm48cBXfu9FYHL2jDvDDC1CHMuxSgFnSK8JNtQ972tKFs4j262PE5d8vD6bkJmidZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751367132; c=relaxed/simple;
	bh=yu6/a/2cTa3U7zrV9fuwU7U/yrDoUesDwtbIAndA0nM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Wy2ChUtv7UXKpZezknxj8ChBr62FrNGDuZKuIN88OF1YuSVFxiO/5clbERQ8UOmwvRnwXHnQw+W51t9L9dX0Zm0bqtYFIUSprP/59z7LwT5H2bsitumMP1uwP1jsG2QuqRPX4inHcXX5rLmtsE9wYCDCBnW4da0eIXBOTxxvhlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=b8pAV1gp; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=wTYAv7fK; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=WvLtB9oU; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=jQSVvc1i; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="b8pAV1gp";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="wTYAv7fK";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="WvLtB9oU";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="jQSVvc1i"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id E69661F74D;
	Tue,  1 Jul 2025 10:52:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1751367129; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=csSZwySBY3T22+wQNOSpXUjejrrhDnh2qNkfyl5BMzY=;
	b=b8pAV1gpkX4i/sICDJFQq9kh9IYuh/IyVNrkJTiESrsjfxKY5YBxzN/eaS3lk4JddA6vDn
	wAcGaHdqYXWl3fSkEqOk1zMiHs5vq89zNAbfhrU9u431dHUeRtkACDnA6zlf2FTff3SexF
	kzWI0Kzfg0O+0ypA+VV3FOD09Cc9oJg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1751367129;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=csSZwySBY3T22+wQNOSpXUjejrrhDnh2qNkfyl5BMzY=;
	b=wTYAv7fKeZpaox8YsK+XeRK7+a5KSM0yeqJmp/GSYlejGx6BpqN2mDP3IceTn6J1Ci9QhI
	LF7bqu8b0djAvTDw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=WvLtB9oU;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=jQSVvc1i
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1751367128; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=csSZwySBY3T22+wQNOSpXUjejrrhDnh2qNkfyl5BMzY=;
	b=WvLtB9oUVccaYKrSlEWFLkh+6eY0TgaM9slgPZHzlYnvmiN8b9GW7JJC2Z9jBNXFXYaDxO
	4ZLV6k9Y+e989Y5mEblr9RtUMpvDEeqBg5zndBjdrBEVA/x/tBcZDteL4nR7E7e/DyVvS9
	Lf0wVndsMhvmGPtXCLuPhL0jq56r1Pw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1751367128;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=csSZwySBY3T22+wQNOSpXUjejrrhDnh2qNkfyl5BMzY=;
	b=jQSVvc1iIsDLED4ca/Gh/NBVVv7ahzx8QI2rqK5wN9YdM9x+FuRTjBLbBsvosir4F0MPEA
	QUAWBS4D6h+5hECw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9CFF613890;
	Tue,  1 Jul 2025 10:52:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id iAlWJNi9Y2hjSAAAD6G6ig
	(envelope-from <hare@suse.de>); Tue, 01 Jul 2025 10:52:08 +0000
Message-ID: <caf4e390-a9e2-4ad5-8bb6-ca6b59053b84@suse.de>
Date: Tue, 1 Jul 2025 12:52:08 +0200
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv7 2/3] block: fix lockdep warning caused by lock
 dependency in elv_iosched_store
To: Nilay Shroff <nilay@linux.ibm.com>, linux-block@vger.kernel.org
Cc: hch@lst.de, ming.lei@redhat.com, axboe@kernel.dk, sth@linux.ibm.com,
 gjoyce@ibm.com
References: <20250701081954.57381-1-nilay@linux.ibm.com>
 <20250701081954.57381-3-nilay@linux.ibm.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20250701081954.57381-3-nilay@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_TLS_ALL(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MID_RHS_MATCH_FROM(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid,suse.de:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: E69661F74D
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Score: -4.51

On 7/1/25 10:18, Nilay Shroff wrote:
> Recent lockdep reports [1] have revealed a potential deadlock caused by a
> lock dependency between the percpu allocator lock and the elevator lock.
> This issue can be avoided by ensuring that the allocation and release of
> scheduler tags (sched_tags) are performed outside the elevator lock.
> Furthermore, the queue does not need to be remain frozen during these
> operations.
> 
> To address this, move all sched_tags allocations and deallocations outside
> of both the ->elevator_lock and the ->freeze_lock. Since the lifetime of
> the elevator queue and its associated sched_tags is closely tied, the
> allocated sched_tags are now stored in the elevator queue structure. Then,
> during the actual elevator switch (which runs under ->freeze_lock and
> ->elevator_lock), the pre-allocated sched_tags are assigned to the
> appropriate q->hctx. Once the elevator switch is complete and the locks
> are released, the old elevator queue and its associated sched_tags are
> freed.
> 
> This commit specifically addresses the allocation/deallocation of sched_
> tags during elevator switching. Note that sched_tags may also be allocated
> in other contexts, such as during nr_hw_queues updates. Supporting that
> use case will require batch allocation/deallocation, which will be handled
> in a follow-up patch.
> 
> This restructuring ensures that sched_tags memory management occurs
> entirely outside of the ->elevator_lock and ->freeze_lock context,
> eliminating the lock dependency problem seen during scheduler updates.
> 
> [1] https://lore.kernel.org/all/0659ea8d-a463-47c8-9180-43c719e106eb@linux.ibm.com/
> 
> Reported-by: Stefan Haberland <sth@linux.ibm.com>
> Closes: https://lore.kernel.org/all/0659ea8d-a463-47c8-9180-43c719e106eb@linux.ibm.com/
> Reviewed-by: Ming Lei <ming.lei@redhat.com>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
> ---
>   block/blk-mq-sched.c | 155 +++++++++++++++++++++++--------------------
>   block/blk-mq-sched.h |   8 ++-
>   block/elevator.c     |  47 +++++++++++--
>   block/elevator.h     |  14 +++-
>   4 files changed, 144 insertions(+), 80 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich
