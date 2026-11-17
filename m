Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794928774;
	b=q9Xog5AHhbtx7cBMuT+m897O2BRg261n4QgOqisVyS5FivlFmJk6pmFqy45U+wlJDiqy
	 lX85/9RKWdZJ8XGxkLIV4HzudZPzUKS7OhnrYUwE4Qm/SsajKaW5X1NxU11uS6EbLmG36
	 MWE3FZwJxsvZAJW5Vc/KfnAlo8N74iGDc+Lj+wlaYUZBXsznAKlsi+FrpD3h+A359RfPf
	 Zy6LlQCQlt4KgoAz09+EPs0myk/yuk23hO/d1v0N5PJre6KrAniKIpOHqOi0MxkS6RO18
	 eHU+ocffTgTdTNE+MFXxCPOEZNPANlORG5t7k48sX5m3FHaFCikUmojgZtO8es5Hqvg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794928774;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Rspamd-Queue-Id:X-Spam-Level:
	 X-Rspamd-Server:X-Rspamd-Action:X-Spam-Flag:X-Spamd-Result:
	 X-Spam-Score;
	bh=SLxX9cBUMsfysM0uF3hHPfTjkK/3YTq6mJ/05AhlM7A=;
	b=Kxuqzair+DhhWpJnK3yRUnN16AbBMLGVsTZ9ct66hEhjgBSNaxO0kCR0r88Bv0CYGW/E
	 rlDVWPLPmPCr8wthF/KPdN3PL8Fwjx3kx0BFNo6F0jnHNHoxtrKDHT3e0KE6EgXgwFMXd
	 1IZP9VO12Wt79tYGoIEeTDjVJetA338UBWL9MzO9MBpLaqd1HOyaHf1JAWU/te4IF6Y5Y
	 t7/1eWckHKu9E65wOr+sNenRUXjKyCbkQwAXOu7s+UsoXdJExJutmMm7VhgmQXbF0rlq9
	 LytRkeXq5NRLg/1Z1P7Kv628KQT5RCqYP5yzPuQ1ihdRGISjUwFvkVwGDSRwuuQQCtw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.de;
	spf=pass smtp.mailfrom=suse.de;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=tgHtkwJB;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=VCZ6q+xG;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=mtOdb5iU;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b="56DER/uZ";
	arc=none smtp.remote-ip=195.135.223.131
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6E31606A31C;
	Tue, 17 Nov 2026 15:19:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E6E31606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=tgHtkwJB;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=VCZ6q+xG;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=mtOdb5iU;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=56DER/uZ
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id DFFDA1F78F;
	Tue, 17 Nov 2026 15:19:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1794928772; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SLxX9cBUMsfysM0uF3hHPfTjkK/3YTq6mJ/05AhlM7A=;
	b=tgHtkwJBCnag/jNmquBSqxQ1M8ZmClCPTxHXvKyECTIQab2PPqnhtxJ5O6PxFxhWJAzpNB
	82qGKnXKhVCY/54L34veyV+Vn8NKgBqbuwTo/ks5vBOjRBtUIwbgMAaadQR+QX2rgu96FB
	1n3BQCnk9uXe+sQU6jvc8zLBY2C1530=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1794928772;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SLxX9cBUMsfysM0uF3hHPfTjkK/3YTq6mJ/05AhlM7A=;
	b=VCZ6q+xGv0x9hdh9MODQ66qRQ5K5Ow55Msquyw3/3YgdSyNaufTqHrIstEJMUoHh8xl72m
	yaf+iOJGCRsJNACw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=mtOdb5iU;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="56DER/uZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1794928771; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SLxX9cBUMsfysM0uF3hHPfTjkK/3YTq6mJ/05AhlM7A=;
	b=mtOdb5iUDqARfREPbPXUjquaOhW2T+w5glX/bU2+kirSOVugwR64JIeUVApz8ZeyOwQZPT
	U5ItAJ6asKt25CTsC/3EahyEWVVtZpS7Rj1OEKrZ+lnHgNryyOR7lhgyMjfRSFyVQLJ1WL
	0uANqg97ZAwtaoTwuVa56H7peWbSZxI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1794928771;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SLxX9cBUMsfysM0uF3hHPfTjkK/3YTq6mJ/05AhlM7A=;
	b=56DER/uZduSbDcAOr5sz+PfgoMEb5F3ULphnupYRPqK/dzRyxJEg9zmyzkWjGeJt5ukkGy
	7nf1a7ZCfo6ZnUDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7F8761334C;
	Tue, 17 Nov 2026 15:19:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id LeW/EoNw/GpOcQAAD6G6ig
	(envelope-from <hare@suse.de>); Tue, 17 Nov 2026 15:19:31 +0000
Message-ID: <3d134488-d8ab-404b-bd0e-c9e68d6fad47@suse.de>
Date: Tue, 17 Nov 2026 16:19:30 +0100
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] block: don't request a module for the none
 elevator
To: Qiliang Yuan <qiliang.yuan@linux.dev>, Jens Axboe <axboe@kernel.dk>,
 Damien Le Moal <dlemoal@kernel.org>, Ming Lei <tom.leiming@gmail.com>,
 Nilay Shroff <nilay@linux.ibm.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 Christoph Hellwig <hch@lst.de>
References: <20261116-bug-block-elevator-unchanged-v3-0-cb4dda2dadf4@linux.dev>
 <20261116-bug-block-elevator-unchanged-v3-1-cb4dda2dadf4@linux.dev>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20261116-bug-block-elevator-unchanged-v3-1-cb4dda2dadf4@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: DFFDA1F78F
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spamd-Result: default: False [-12.00 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	XM_UA_NO_VERSION(0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FREEMAIL_TO(0.00)[linux.dev,kernel.dk,kernel.org,gmail.com,linux.ibm.com];
	MIME_TRACE(0.00)[0:+];
	URIBL_BLOCKED(0.00)[suse.de:dkim,suse.de:email,linux.dev:email,lst.de:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,lst.de:email,linux.dev:email]
X-Spam-Score: -12.00

On 11/17/26 3:56 AM, Qiliang Yuan wrote:
> elv_iosched_store() calls elv_iosched_load_module() for the requested
> name before anything else, and loads "<name>-iosched" if no elevator
> type of that name is registered. "none" never is, so every write of
> "none" to queue/scheduler ends up in request_module("none-iosched").
> 
> That runs a modprobe helper which can never find the module, and adds
> several milliseconds to every switch to "none", including rewrites of
> it by udev rules or tuning tools that set the scheduler on each disk.
> 
> Return early for "none", like elevator_change() did before the module
> loading moved into elv_iosched_load_module().
> 
> Writing queue/scheduler of a null_blk disk 20 times takes (median):
> 
>    operation             before (ms)  after (ms)  change
>    none -> none                13.10        9.11    -30%
>    mq-deadline -> none         13.00        7.97    -39%
> 
> Fixes: 734e1a8603128 ("block: Prevent deadlocks when switching elevators")
> Signed-off-by: Qiliang Yuan <qiliang.yuan@linux.dev>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Nilay Shroff <nilay@linux.ibm.com>
> ---
>   block/elevator.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/block/elevator.c b/block/elevator.c
> index 66edf1a5768a8..9d9b2e84a1288 100644
> --- a/block/elevator.c
> +++ b/block/elevator.c
> @@ -775,6 +775,9 @@ static void elv_iosched_load_module(const char *elevator_name)
>   {
>   	struct elevator_type *found;
>   
> +	if (!strncmp(elevator_name, "none", 4))
> +		return;
> +
>   	spin_lock(&elv_list_lock);
>   	found = __elevator_find(elevator_name);
>   	spin_unlock(&elv_list_lock);
> 

Reviewed-by: Hannes Reinecke <hare@kernel.org>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich
