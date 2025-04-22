Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24115201261
	for <linux-block@vger.kernel.org>; Tue, 22 Apr 2025 09:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745314220; cv=none; b=et3e0pQ8WnhDdciw/6GIHuuwABS1YU3X/wuPgUgUoxjcsQG6E7rq0Mn6fUGlLn9IjTPoAdK0LJysWFlqk967kgFEwRswDfuwI15KYsdd29j6bT9o63Gd/zeMZzUKcVQ2cYDK+/6xR7ij5lkVJQzfqasr207xq9iubqLZXsCw+Tw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745314220; c=relaxed/simple;
	bh=F4xj8uFItZXngYyRxK4Om6c/Df+Jde5SIdIKlsdLQ5E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Zo1jxTQm10XxF7vYnD3gytPr1pFPCWsIX8YIagoYB5VKTUToSuvdJZg1KKgI2Y0mKbhTVf3W1ZmlNKRekhZqrZODD7kKN0v787ZM2pZFxZnBTsfe2epb23xSDZ00SPow+3H48jccM8BZllKzNx3gzmwXXKAJG+y/QfNEH+gXx9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=t8uY9qr3; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=v3Y67OK8; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=t8uY9qr3; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=v3Y67OK8; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="t8uY9qr3";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="v3Y67OK8";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="t8uY9qr3";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="v3Y67OK8"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 396AC1F38D;
	Tue, 22 Apr 2025 09:30:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1745314215; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Gvnq7RRpbANJOQulWb2Jv++b6xT4uB29m5w8D0xJrds=;
	b=t8uY9qr3k3PwZ9kkOjnxDh2XX6kjmRLamiw1jfMHW64xLN4Y8qufG/7UZB21+Vc4dS0/yy
	VwYAXlnzybeo841LTvqvHqyTe0y+V2eZKzwUskgl7J5k4dDcpYdEqLyR8UlCB0KnjNW4nC
	hGk8i/6+F9/B4GPeeCQgvgYxvYTkA5Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1745314215;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Gvnq7RRpbANJOQulWb2Jv++b6xT4uB29m5w8D0xJrds=;
	b=v3Y67OK8NpAechMkLS6yZKC4ZDHhBG3d7Ui9Z7y931kp9hSltbM23BYG6zpz1Hm91aQxQV
	19FsMwxBtzkNNhCg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=t8uY9qr3;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=v3Y67OK8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1745314215; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Gvnq7RRpbANJOQulWb2Jv++b6xT4uB29m5w8D0xJrds=;
	b=t8uY9qr3k3PwZ9kkOjnxDh2XX6kjmRLamiw1jfMHW64xLN4Y8qufG/7UZB21+Vc4dS0/yy
	VwYAXlnzybeo841LTvqvHqyTe0y+V2eZKzwUskgl7J5k4dDcpYdEqLyR8UlCB0KnjNW4nC
	hGk8i/6+F9/B4GPeeCQgvgYxvYTkA5Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1745314215;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Gvnq7RRpbANJOQulWb2Jv++b6xT4uB29m5w8D0xJrds=;
	b=v3Y67OK8NpAechMkLS6yZKC4ZDHhBG3d7Ui9Z7y931kp9hSltbM23BYG6zpz1Hm91aQxQV
	19FsMwxBtzkNNhCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1E238139D5;
	Tue, 22 Apr 2025 09:30:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 3EjkBqdhB2h/ZAAAD6G6ig
	(envelope-from <hare@suse.de>); Tue, 22 Apr 2025 09:30:15 +0000
Message-ID: <21f5f86b-f524-410b-a839-25cb6356e411@suse.de>
Date: Tue, 22 Apr 2025 11:30:14 +0200
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] brd: split I/O at page boundaries
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
 Yu Kuai <yukuai1@huaweicloud.com>
Cc: linux-block@vger.kernel.org
References: <20250421072641.1311040-1-hch@lst.de>
 <20250421072641.1311040-5-hch@lst.de>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20250421072641.1311040-5-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 396AC1F38D
X-Spam-Score: -4.51
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	MIME_TRACE(0.00)[0:+];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid,suse.de:email,lst.de:email];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On 4/21/25 09:26, Christoph Hellwig wrote:
> A lot of complexity in brd stems from the fact that it tries to handle
> I/O spanning two backing pages.  Instead limit the size of a single
> bvec iteration so that it never crosses a page boundary and remove all
> the now unneeded code.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   drivers/block/brd.c | 116 +++++++++++++-------------------------------
>   1 file changed, 34 insertions(+), 82 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich
