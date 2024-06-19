Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BA7427733
	for <linux-block@vger.kernel.org>; Wed, 19 Jun 2024 07:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718783442; cv=none; b=MJK0Z6aoqCCv8VxSnxbGDGvAILCCb4iC0/ZUqs6SdSvY/dbHKh1Jz8cD7kcvPpr8KHmbgtwTgMWoZXKb7oFpBaSht4JJ0xCvG0FyLYaY+WIk78jc/sRhbGGiBoOXNERSa7RNnXm+WwyfTt5RkaiHSAxSIQAsMTSPN+Qz8mhW7j8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718783442; c=relaxed/simple;
	bh=LgYz5O4XW7Q2YmR7XlFxaGSDZ6nE/K/Nl/55aPyrZwY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uQBsPTCu2XoxidPpvgeZS0P7yh4h3dmF40aN9E50sJPxbma4W1DYPXYzwrqqJ1Ull+9u/VzsX8bqmX4n9LRz25hrabZmhSrcJ1H1ClqfUfA+61ZG0gP/yS3nt6bSU/ZjmNCKW8mHKHbuLTGunEIFzwJyr0gxBFeBDD3dLlgw6HU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=YWK3yr/T; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=BKYFxQVY; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=YWK3yr/T; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=BKYFxQVY; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="YWK3yr/T";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="BKYFxQVY";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="YWK3yr/T";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="BKYFxQVY"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 4EBC021A4A;
	Wed, 19 Jun 2024 07:50:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1718783439; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+grG+X7FxGviqcbpjqGlVt1qctrZryb5alP6+YdLM9o=;
	b=YWK3yr/TWOgKqZrR4UrzRDEc2aYeksWOeZUfg+RAns2WdJWrPepECiMv0s4vuMBxZZo/31
	vGO606UNCsF5v5UMwCk3JvjGB+97Ond0f1eVY8taXXNnsNNkbkL3NZ19PhJsQcKS43GKjG
	w6H2Ll3lu0De/h9qZDzWaePzUGkDdso=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1718783439;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+grG+X7FxGviqcbpjqGlVt1qctrZryb5alP6+YdLM9o=;
	b=BKYFxQVYBI2Veip2oXpvIBPMN8OVL1vtayD7gO6AsdG6IRsDyEWLWQ20mCRuVxAhcnIH7B
	a+24GgTh7hr8/eAg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b="YWK3yr/T";
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=BKYFxQVY
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1718783439; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+grG+X7FxGviqcbpjqGlVt1qctrZryb5alP6+YdLM9o=;
	b=YWK3yr/TWOgKqZrR4UrzRDEc2aYeksWOeZUfg+RAns2WdJWrPepECiMv0s4vuMBxZZo/31
	vGO606UNCsF5v5UMwCk3JvjGB+97Ond0f1eVY8taXXNnsNNkbkL3NZ19PhJsQcKS43GKjG
	w6H2Ll3lu0De/h9qZDzWaePzUGkDdso=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1718783439;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+grG+X7FxGviqcbpjqGlVt1qctrZryb5alP6+YdLM9o=;
	b=BKYFxQVYBI2Veip2oXpvIBPMN8OVL1vtayD7gO6AsdG6IRsDyEWLWQ20mCRuVxAhcnIH7B
	a+24GgTh7hr8/eAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 134E613ABD;
	Wed, 19 Jun 2024 07:50:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id LSHPAs+NcmYqEAAAD6G6ig
	(envelope-from <hare@suse.de>); Wed, 19 Jun 2024 07:50:39 +0000
Message-ID: <69d3bca7-0bdb-43cc-9181-a733ec495810@suse.de>
Date: Wed, 19 Jun 2024 09:50:38 +0200
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block: check bio alignment in blk_mq_submit_bio
Content-Language: en-US
To: Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
 linux-block@vger.kernel.org
Cc: Yi Zhang <yi.zhang@redhat.com>, Christoph Hellwig <hch@infradead.org>,
 Ye Bin <yebin10@huawei.com>
References: <20240619033443.3017568-1-ming.lei@redhat.com>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20240619033443.3017568-1-ming.lei@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.50 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	XM_UA_NO_VERSION(0.01)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DWL_DNSWL_BLOCKED(0.00)[suse.de:dkim];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 4EBC021A4A
X-Spam-Flag: NO
X-Spam-Score: -4.50
X-Spam-Level: 

On 6/19/24 05:34, Ming Lei wrote:
> IO logical block size is one fundamental queue limit, and every IO has
> to be aligned with logical block size because our bio split can't deal
> with unaligned bio.
> 
> The check has to be done with queue usage counter grabbed because device
> reconfiguration may change logical block size, and we can prevent the
> reconfiguration from happening by holding queue usage counter.
> 
> logical_block_size stays in the 1st cache line of queue_limits, and this
> cache line is always fetched in fast path via bio_may_exceed_limits(),
> so IO perf won't be affected by this check.
> 
> Cc: Yi Zhang <yi.zhang@redhat.com>
> Cc: Christoph Hellwig <hch@infradead.org>
> Cc: Ye Bin <yebin10@huawei.com>
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>   block/blk-mq.c | 24 ++++++++++++++++++++++++
>   1 file changed, 24 insertions(+)
> 
Is this still an issue after the atomic queue limits patchset from 
Christoph?
One of the changes there is that we now always freeze the queue before
changing any limits.
So really this check should never trigger.

Hmm?

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

