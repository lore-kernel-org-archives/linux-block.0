Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 846D6524B8
	for <linux-block@vger.kernel.org>; Sat, 11 May 2024 09:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715418798; cv=none; b=kieFiPmfsm/rfrmJdQdB/yur4LhOr9E3j59i93+N4yMuv+uKk/TD3Lpn6xh9zFsWSb3WpFvGRNMJ2jniaaedYaKzWOZK75k3xKEPTnTPUfo6oDIXBQi4g/cA69uk0qKxYWD3o20BNlbitmDZdzBEz3uErLdxyP4X+6LBGJ0W5HU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715418798; c=relaxed/simple;
	bh=HDFGwBZ2Ix3R8SN6cB8bUbWKC/PI39Sy1OEc54SzdP0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=emiKPqLgqqopqCRISoQTAOOJNlcxnrl0cRZndyfHli8BYhvkRlAeIUHAaLkXA1X8t+IYO/6iT+ManBv8EAlk2WRAs4wl5oqyQ8ncJwfwu/q0ApNPQQjtsG9GsB7SwDtUHRgid/yN0YX+drsEAZFWSN1qwYNKcRWhyHSpNzGXd4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=OojacKkz; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=rimIeH5p; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=OojacKkz; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=rimIeH5p; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="OojacKkz";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="rimIeH5p";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="OojacKkz";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="rimIeH5p"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 862FC20B6A;
	Sat, 11 May 2024 09:13:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1715418795; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UE4InP61OxD+l8jmkYdUmsijattPNEVP+SewgNel8uk=;
	b=OojacKkzxvOiyzxIpsmZsH+AFH4mYHjQJCMDw5zGtTRSA7e74BDrt5mN+Tt5Ja66b5XH1N
	Q/eUKsa6F1kLYBnNiYGMa2/u23G+CX6/c9ZWJHdZl4LjKFszZeEwUReaHnNPmJy8UoOXKU
	cYoXyPoqKgDZkWQmI87ndWcb9T22fPM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1715418795;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UE4InP61OxD+l8jmkYdUmsijattPNEVP+SewgNel8uk=;
	b=rimIeH5pn1icjr5UoU3kF92Sf+tcdG83e5jdYYgk1rAg3lrambnOj9swvvj+ZxxVp9ZKvu
	wO1HpfHwq7nmzCAw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=OojacKkz;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=rimIeH5p
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1715418795; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UE4InP61OxD+l8jmkYdUmsijattPNEVP+SewgNel8uk=;
	b=OojacKkzxvOiyzxIpsmZsH+AFH4mYHjQJCMDw5zGtTRSA7e74BDrt5mN+Tt5Ja66b5XH1N
	Q/eUKsa6F1kLYBnNiYGMa2/u23G+CX6/c9ZWJHdZl4LjKFszZeEwUReaHnNPmJy8UoOXKU
	cYoXyPoqKgDZkWQmI87ndWcb9T22fPM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1715418795;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UE4InP61OxD+l8jmkYdUmsijattPNEVP+SewgNel8uk=;
	b=rimIeH5pn1icjr5UoU3kF92Sf+tcdG83e5jdYYgk1rAg3lrambnOj9swvvj+ZxxVp9ZKvu
	wO1HpfHwq7nmzCAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2552C13A3E;
	Sat, 11 May 2024 09:13:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 4NvgA6s2P2Y9JwAAD6G6ig
	(envelope-from <hare@suse.de>); Sat, 11 May 2024 09:13:15 +0000
Message-ID: <3e6bbc4a-c1ed-4460-a266-3d4b0fdbb9c6@suse.de>
Date: Sat, 11 May 2024 11:13:15 +0200
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] fs/mpage: avoid negative shift for large blocksize
Content-Language: en-US
To: Matthew Wilcox <willy@infradead.org>, hare@kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Pankaj Raghav <kernel@pankajraghav.com>, Luis Chamberlain
 <mcgrof@kernel.org>, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org
References: <20240510102906.51844-1-hare@kernel.org>
 <20240510102906.51844-3-hare@kernel.org>
 <Zj6ehjm1iVcc_x2m@casper.infradead.org>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <Zj6ehjm1iVcc_x2m@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -4.50
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 862FC20B6A
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.50 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	XM_UA_NO_VERSION(0.01)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_TLS_ALL(0.00)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MID_RHS_MATCH_FROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email];
	DKIM_TRACE(0.00)[suse.de:+]

On 5/11/24 00:24, Matthew Wilcox wrote:
> On Fri, May 10, 2024 at 12:29:03PM +0200, hare@kernel.org wrote:
>> -	block_in_file = (sector_t)folio->index << (PAGE_SHIFT - blkbits);
>> +	block_in_file = (sector_t)(((loff_t)folio->index << PAGE_SHIFT) >> blkbits);
> 
> 	block_in_file = folio_pos(folio) >> blkbits;
> 
> 
I know there was a better way. Will be fixing it up.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

