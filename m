Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADDB42AF11
	for <linux-block@vger.kernel.org>; Wed, 30 Apr 2025 06:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745994667; cv=none; b=W7GqveO8xY1se2AVJynQ+qd+yXXlwX7yVsdjGF/UUEyjwJ0T6zah24a5rH1GV8yKmayn9UAfdo6eyLAL8Y2fzBtOi5guERV0K7VswhIsZjspxzb9jdEazq7STadhZ/grv2WQ+izM3bd6bBc29y4NVIIU5+fvuMKTEQZN8bsit2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745994667; c=relaxed/simple;
	bh=UxZwUZNmMdVCoCG54fMt9nbkoZgDczPW09lDNEMAX7Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nCWDD2E3NLvV293JeUNRwCXaF9Yvfvjqy8gxovKaPP2CYeGRdQJAk+X75WWkqf7VdO7P25+l/H3FUGXk/nlWv7U27Kjo2BKxqiVh//tXbHRpHvkSsH/pWdzA29zIj7xf+MTrs9pF2/zJ0HZUXP9lfOjxXwI/kA6xXo/aLzyChwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=mo07ZWFE; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=rT1pIJp8; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=mo07ZWFE; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=rT1pIJp8; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="mo07ZWFE";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="rT1pIJp8";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="mo07ZWFE";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="rT1pIJp8"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 2A11E21240;
	Wed, 30 Apr 2025 06:31:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1745994662; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TMdNC1RDPnEO5ClrMjbn7l01/J3jDeusgzYU9dmko1o=;
	b=mo07ZWFEWfdJb09cjiK0m41BEAo2ESu2Y9TSWcF9XXzSZRORFlzrHcrdyk88ysRwr4OSJM
	4hMUm0CtwDZjTB8s9sS0m1W6DqjIDT8HdQDv/6WeldARcSGYRX6v5oUUhSrlWc2ePq3csy
	RABtWpHKUvC7IHT4CMS9wVbptwqGgqE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1745994662;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TMdNC1RDPnEO5ClrMjbn7l01/J3jDeusgzYU9dmko1o=;
	b=rT1pIJp8aH/Q+2b+cgIfNginGY9KgJNWg2lElMbSjsoh5UNX9z0ogFgs+Ckf8ffG48/041
	cZncNrFXWiEBkNAw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=mo07ZWFE;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=rT1pIJp8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1745994662; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TMdNC1RDPnEO5ClrMjbn7l01/J3jDeusgzYU9dmko1o=;
	b=mo07ZWFEWfdJb09cjiK0m41BEAo2ESu2Y9TSWcF9XXzSZRORFlzrHcrdyk88ysRwr4OSJM
	4hMUm0CtwDZjTB8s9sS0m1W6DqjIDT8HdQDv/6WeldARcSGYRX6v5oUUhSrlWc2ePq3csy
	RABtWpHKUvC7IHT4CMS9wVbptwqGgqE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1745994662;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TMdNC1RDPnEO5ClrMjbn7l01/J3jDeusgzYU9dmko1o=;
	b=rT1pIJp8aH/Q+2b+cgIfNginGY9KgJNWg2lElMbSjsoh5UNX9z0ogFgs+Ckf8ffG48/041
	cZncNrFXWiEBkNAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D5C53139E7;
	Wed, 30 Apr 2025 06:31:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id BvcxMqXDEWgBawAAD6G6ig
	(envelope-from <hare@suse.de>); Wed, 30 Apr 2025 06:31:01 +0000
Message-ID: <c4694029-f8c9-46fd-ba2a-b486a48d615b@suse.de>
Date: Wed, 30 Apr 2025 08:31:01 +0200
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V4 18/24] block: fail to show/store elevator sysfs
 attribute if elevator is dying
To: Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
 linux-block@vger.kernel.org
Cc: Nilay Shroff <nilay@linux.ibm.com>,
 Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Christoph Hellwig <hch@lst.de>
References: <20250430043529.1950194-1-ming.lei@redhat.com>
 <20250430043529.1950194-19-ming.lei@redhat.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20250430043529.1950194-19-ming.lei@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 2A11E21240
X-Spam-Level: 
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	TO_DN_SOME(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MID_RHS_MATCH_FROM(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:dkim,suse.de:mid,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.51
X-Spam-Flag: NO

On 4/30/25 06:35, Ming Lei wrote:
> Prepare for moving elv_register[unregister]_queue out of elevator_lock
> & queue freezing, so we may have to call elv_unregister_queue() after
> elevator ->exit() is called, then there is small window for user to
> call into ->show()/store(), and user-after-free can be caused.
> 
> Fail to show/store elevator sysfs attribute if elevator is dying by
> adding one new flag of ELEVATOR_FLAG_DYNG, which is protected by
> elevator ->sysfs_lock.
> 
> Reviewed-by: Nilay Shroff <nilay@linux.ibm.com>
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>   block/blk-mq-sched.c |  1 +
>   block/elevator.c     | 10 ++++++----
>   block/elevator.h     |  1 +
>   3 files changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/block/blk-mq-sched.c b/block/blk-mq-sched.c
> index 336a15ffecfa..55a0fd105147 100644
> --- a/block/blk-mq-sched.c
> +++ b/block/blk-mq-sched.c
> @@ -551,5 +551,6 @@ void blk_mq_exit_sched(struct request_queue *q, struct elevator_queue *e)
>   	if (e->type->ops.exit_sched)
>   		e->type->ops.exit_sched(e);
>   	blk_mq_sched_tags_teardown(q, flags);
> +	set_bit(ELEVATOR_FLAG_DYING, &q->elevator->flags);
>   	q->elevator = NULL;
>   }

set_bit() is unordered; don't you need to take ->sysfs_lock here?

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich
