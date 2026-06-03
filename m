Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA08038F658
	for <linux-block@vger.kernel.org>; Wed,  3 Jun 2026 01:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780451932; cv=none; b=VI7pg8a0FNQXikZ8y/Q8G+ThnYvSPR1Lbvta37PaYyfPlF/xYRMlgMB3LFhrP4cfiP2jFh+kcnJKDcGJSLG1vQTco/VQylv/lZz4fq1gpq1koa6SvKX8jhswPaXXGZH9ksHvFjQyG8A0FMgzZyvPZFblEJ6IWMJ19Ibx8qRT9Jw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780451932; c=relaxed/simple;
	bh=RyPNYPZyR/9INVNBTu4A5AtNMOJLkoQCcTuKtgwT11I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dnmYR3kkBSAeb+2/S7eU7Kl9r7O0IEUOzgO8LpF11pJv1zryc9oIKTejK/yqijsQdiWseM0M8/pWOzGTquyOD80Wc/jxWoqz8g6+EtHXj0D6xsCQHtEYEQhtteDo44IfII4mOV5HRkbDkvtt9oY0aVmCH2woZF9PJsprsyWULwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=WgSewGBo; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=I2IEJ4yq; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=VvYf2ebq; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=BRWq5sl2; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="WgSewGBo";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="I2IEJ4yq";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="VvYf2ebq";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="BRWq5sl2"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id D875866F90;
	Wed,  3 Jun 2026 01:58:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1780451926; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fL+iWe2gx7ikhuUlAxQQfyuOyOcHZaz8+JPJWQChtrM=;
	b=WgSewGBov3YTmR3suX/tk5LsK/6RueN94iF2k9mi/7pMduJCroCOXe3er2BdxjsRctZ/ui
	0aTON5kzsuvBIAJPfVr2mwM0NNsCOn6WTzG31GnCE/Prev+OR2YO4GqdC0GaPOfAHZrR0/
	6XlbJkEP/dhNZji31GH0hHxSf7KHgYQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1780451926;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fL+iWe2gx7ikhuUlAxQQfyuOyOcHZaz8+JPJWQChtrM=;
	b=I2IEJ4yqwGwP4u8XCQhIRETH0mD5ZB6fS1eKfpRwJmPpDErG8UM+6e4gtOtY7KGAAH9GU4
	dUSMTKH8fwFgxLDw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1780451925; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fL+iWe2gx7ikhuUlAxQQfyuOyOcHZaz8+JPJWQChtrM=;
	b=VvYf2ebqJnxRiwFClIUc53xsRaP0CeFjkHRRCflswcVXyF9Mx32MFQveLSVwI5DVbhcCSf
	fRR4mglZcgBIjhsCmBpe5a32CkyxyjHD6Qi6I5rxqoF+5PtMJ87EfbI9HK2GjAVWrgM013
	u5Ovp2+Hp6VcosAkjIZX6ucLmrSb1yc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1780451925;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fL+iWe2gx7ikhuUlAxQQfyuOyOcHZaz8+JPJWQChtrM=;
	b=BRWq5sl2zkadrEdF5xZtDfJGBwFNNI8/w7iz7qc4NN2DJvDFyLLDcJWKGyXxm2uiGv0yRb
	KHm0/nmV0x6sGVBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1EB8F779A7;
	Wed,  3 Jun 2026 01:58:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id vAnHMFOKH2rxdgAAD6G6ig
	(envelope-from <hare@suse.de>); Wed, 03 Jun 2026 01:58:43 +0000
Message-ID: <1b8d378d-503d-4b9b-9bfa-304e13be571a@suse.de>
Date: Wed, 3 Jun 2026 03:58:38 +0200
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 11/14] block/blk-mq-debugfs: Improve lock context
 annotations
To: Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
 Hannes Reinecke <hare@kernel.org>, Damien Le Moal <dlemoal@kernel.org>,
 Nathan Chancellor <nathan@kernel.org>
References: <cover.1780419600.git.bvanassche@acm.org>
 <66eff9a5e488fbe0b79db3a54518fe5d181a31ec.1780419600.git.bvanassche@acm.org>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <66eff9a5e488fbe0b79db3a54518fe5d181a31ec.1780419600.git.bvanassche@acm.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -4.30
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:mid,imap1.dmz-prg2.suse.org:helo,acm.org:email]
X-Spam-Level: 

On 6/2/26 19:07, Bart Van Assche wrote:
> Make the existing lock context annotations compatible with Clang. Add
> the lock context annotations that are missing.
> 
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
> ---
>   block/blk-mq-debugfs.c | 24 ++++++++++++++++++------
>   block/blk.h            |  4 ++++
>   2 files changed, 22 insertions(+), 6 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@kernel.org>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich
