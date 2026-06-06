Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5729072622
	for <linux-block@vger.kernel.org>; Sat,  6 Jun 2026 07:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780730691; cv=none; b=V5SlRFgyktGKTyU1QqmNEYUsIMqBhxyVLp4an5KiDaZD8q8tXhTjfBJELNcTvspq/r1zoPC4z85qoB4QA/5eB7qRlKsT3hSBQeW86geqXeIUBVRv+cMiVNtLa0RM5oZx93u9nrm03K7uyMsm0rRHuYQVdP4wxl74u6F9AkhtHoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780730691; c=relaxed/simple;
	bh=2bbs28Pr3gpXiNQTJFIPOnL+UL/yhNQ2XVGbdRGuOaI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=U7hDgWxC2ABnkQzHbHNqaHKZQgxLbhdHRhtcMVa+uo0DuHscioZ7q8DHWG14mVFsQWp2nwF11Jmw86PfXIL/U9p8HvHbcpUIxz5Ov/GPUcPsz3eSclSKOP3WL54OrBatPcb2IyH+Wx4eXP6WiirCawOV5gcjR4WI1wmCLRitcco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=0pGy84Nb; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=pMoZN/vj; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=0pGy84Nb; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=pMoZN/vj; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="0pGy84Nb";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="pMoZN/vj";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="0pGy84Nb";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="pMoZN/vj"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id B83946B34B;
	Sat,  6 Jun 2026 07:24:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1780730682; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ifzahJ7Xg5c6d27lOYsWbT11uB3nSjqUzNFY/CJvKf8=;
	b=0pGy84NbUYBPm+D/BqXVO8PGFyJ79To6PAJGANaQY2c0riwurPrSXOCUuhDmFq8TbxU1Pz
	kSCZRmSB5WgszdCl523Y8O2/tGaqoJn8jE657C56RXpYQyNgr2vdf7eG0dgt91oqh9CVgY
	ddpoIQk1aqRm+IExeH8fIlL1UIlHinE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1780730682;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ifzahJ7Xg5c6d27lOYsWbT11uB3nSjqUzNFY/CJvKf8=;
	b=pMoZN/vjAZSMxkjLUt54dkt2PlsLvGc4UTjYW118i1JLCFpgN7lRPNLLkbjc/ZjMnMQEXM
	RgifHouggWiet5CQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=0pGy84Nb;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="pMoZN/vj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1780730682; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ifzahJ7Xg5c6d27lOYsWbT11uB3nSjqUzNFY/CJvKf8=;
	b=0pGy84NbUYBPm+D/BqXVO8PGFyJ79To6PAJGANaQY2c0riwurPrSXOCUuhDmFq8TbxU1Pz
	kSCZRmSB5WgszdCl523Y8O2/tGaqoJn8jE657C56RXpYQyNgr2vdf7eG0dgt91oqh9CVgY
	ddpoIQk1aqRm+IExeH8fIlL1UIlHinE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1780730682;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ifzahJ7Xg5c6d27lOYsWbT11uB3nSjqUzNFY/CJvKf8=;
	b=pMoZN/vjAZSMxkjLUt54dkt2PlsLvGc4UTjYW118i1JLCFpgN7lRPNLLkbjc/ZjMnMQEXM
	RgifHouggWiet5CQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9F693779A7;
	Sat,  6 Jun 2026 07:24:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id S5vJATfLI2rXCAAAD6G6ig
	(envelope-from <hare@suse.de>); Sat, 06 Jun 2026 07:24:39 +0000
Message-ID: <8d5d56c1-8514-4132-9618-544b1b106536@suse.de>
Date: Sat, 6 Jun 2026 09:24:34 +0200
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] block: add a macro to initialize the status table
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc: Jonathan Corbet <corbet@lwn.net>, linux-block@vger.kernel.org,
 linux-doc@vger.kernel.org, Keith Busch <kbusch@kernel.org>
References: <20260605184441.590927-1-hch@lst.de>
 <20260605184441.590927-2-hch@lst.de>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20260605184441.590927-2-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: B83946B34B
X-Spam-Flag: NO
X-Spam-Score: -4.51
X-Spam-Level: 
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	DWL_DNSWL_BLOCKED(0.00)[suse.de:dkim];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email,suse.de:mid];
	URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,lst.de:email];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org

On 6/5/26 20:44, Christoph Hellwig wrote:
> Prepare for adding a new value to the error table by adding a macro
> to fill it.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Keith Busch <kbusch@kernel.org>
> ---
>   block/blk-core.c | 45 +++++++++++++++++++++++++--------------------
>   1 file changed, 25 insertions(+), 20 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@kernel.org>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich
