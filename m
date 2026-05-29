Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68E913A75A7
	for <linux-block@vger.kernel.org>; Fri, 29 May 2026 06:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780036554; cv=none; b=aA4UvuN4uZfFxo9ziSNaEB+z1VBqPOS93TLRk0qiz3GLIn5parRH13XWTx9IRjrFQwJWkDz0hPvKjb76n1B9G02GC0gSjhFpTzr7T86jxonrCZurh6H1BmIHyNF9DDPylTIEg9qJxMCRj00A5WlY+y2DUWP3BFD23/jqfmCRjzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780036554; c=relaxed/simple;
	bh=HxZWcc2lm2rlH3+/nuhVfL6eRjN4ohayA7H1k1jD2t0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=p7WUcSwqAh5WmOzikV0HCvu7NGMIOOusCC3udinAp49D8jFFt8Huh/5bz3qkHZ0lYwQjoLLnWEqZaaj1UGCplGKQtYwQVSoC494NmV8ryKPD7bz/oxaUKLau7LBcEa1jP8IX3KVEwOrNC34wkruWbNU/JS89ShXaJvuWs0055S0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=wFcj2aJb; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=h9jsCQ2s; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=wFcj2aJb; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=h9jsCQ2s; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="wFcj2aJb";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="h9jsCQ2s";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="wFcj2aJb";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="h9jsCQ2s"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id C32A96AA2D;
	Fri, 29 May 2026 06:35:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1780036551; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tXFEJ1lE6U92KWVJZ9o860KrhpeToaYx8CMHzNsCycc=;
	b=wFcj2aJbhSd3zsLFA2Op9Psjj1cHiGgRAXmwNhTv3stxphl8hkFX/li4nmIH8LB/b1/nt0
	iFNy6i7pp7+B1fDWmk7laDCAGvvEtQTLQqp+dLzCOB4aG5KLo7DXmc4MEXXHxBjInrUxNm
	s8Wuax2GBwtXVCQZ5yyt/vnjeP8tyZw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1780036551;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tXFEJ1lE6U92KWVJZ9o860KrhpeToaYx8CMHzNsCycc=;
	b=h9jsCQ2sBm36twHFOUT/DGnt2viGVhr8q0DcJqIrsUU22Ci9EVXwILG6i/90MPNenRAVc5
	UubCvTi/eFW2iBDQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1780036551; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tXFEJ1lE6U92KWVJZ9o860KrhpeToaYx8CMHzNsCycc=;
	b=wFcj2aJbhSd3zsLFA2Op9Psjj1cHiGgRAXmwNhTv3stxphl8hkFX/li4nmIH8LB/b1/nt0
	iFNy6i7pp7+B1fDWmk7laDCAGvvEtQTLQqp+dLzCOB4aG5KLo7DXmc4MEXXHxBjInrUxNm
	s8Wuax2GBwtXVCQZ5yyt/vnjeP8tyZw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1780036551;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tXFEJ1lE6U92KWVJZ9o860KrhpeToaYx8CMHzNsCycc=;
	b=h9jsCQ2sBm36twHFOUT/DGnt2viGVhr8q0DcJqIrsUU22Ci9EVXwILG6i/90MPNenRAVc5
	UubCvTi/eFW2iBDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 956465B1D8;
	Fri, 29 May 2026 06:35:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id U7dbI8czGWo+JgAAD6G6ig
	(envelope-from <hare@suse.de>); Fri, 29 May 2026 06:35:51 +0000
Message-ID: <a6ec9507-d88d-4878-946b-9b9195acdda8@suse.de>
Date: Fri, 29 May 2026 08:35:51 +0200
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 11/12] block/mq-deadline: Make the lock context
 annotations compatible with Clang
To: Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
 Damien Le Moal <dlemoal@kernel.org>, Nathan Chancellor <nathan@kernel.org>
References: <cover.1779997063.git.bvanassche@acm.org>
 <be44a8b8ed93792d33b07de74c971d1a8a5703f8.1779997063.git.bvanassche@acm.org>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <be44a8b8ed93792d33b07de74c971d1a8a5703f8.1779997063.git.bvanassche@acm.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -4.30
X-Spam-Level: 
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.996];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_TWO(0.00)[2];
	URIBL_BLOCKED(0.00)[suse.de:email,suse.de:mid,imap1.dmz-prg2.suse.org:helo,acm.org:email];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:mid,imap1.dmz-prg2.suse.org:helo,acm.org:email]

On 5/28/26 21:45, Bart Van Assche wrote:
> While sparse ignores the __acquires() and __releases() arguments, Clang
> verifies these. Make the arguments of __acquires() and __releases()
> acceptable for Clang.
> 
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
> ---
>   block/mq-deadline.c | 12 ++++++++----
>   1 file changed, 8 insertions(+), 4 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@kernel.org>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich
