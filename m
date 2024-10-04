Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 256E7156F53;
	Fri,  4 Oct 2024 14:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728051329; cv=none; b=jhcH0d5BJHGCUPnTuFPTfBWQY4pAlBMivkHxMf6jwUs/j+KkAcmhlc54msgYVtvvLFVZw5oRjwbO0PR+yx7FvZyDQU1oDbijospSSzNFY4YpE79Hr0k3ITAUgs2grTbYBPUc1LrWnETyifD3sr/Yd7+U5LQyZANUaO7eMEcN5os=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728051329; c=relaxed/simple;
	bh=f0CIDOic0aOSPv4Rhb8ws9vKJ2LlNOZ8BXzrfe1DNiU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fz2uE4tUAPxJAkiYjR4GBXAYZlb/T/o9A2BYio96glEFTVUiCEXiPidYfnB8aTtAuPbzUEeq/oJ28DUIYb6yUdUaqTOKzHxsb0Bb9WNYCSL9jdWTd91IhCuMjHh6KA3eA0h+CRzEknUuL52lY2PbX8YwFdCzXIMYBWsc231NllE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=SEKJF3tF; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=0KdTuOfy; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=SEKJF3tF; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=0KdTuOfy; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="SEKJF3tF";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="0KdTuOfy";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="SEKJF3tF";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="0KdTuOfy"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 3C70C21D5F;
	Fri,  4 Oct 2024 14:15:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1728051326; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Jubd/UlB1yY1O3O6FyQ5eLpMul/tBHAq/yP21hqjlBU=;
	b=SEKJF3tFNxke/7bupTLBkLU5JAsQOKwwrM3oPbBN7/V8FyG7JsAajI9yRXIMA73BZYMX0v
	ov4ePImL8iGFj7RvumbInI06UeDnme8zsgzgSmTKG1a10N9MuChjZojFKqF/+M6zovPh/p
	ecFheyRO7S8MaiIho3n1+9mBWChfRIY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1728051326;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Jubd/UlB1yY1O3O6FyQ5eLpMul/tBHAq/yP21hqjlBU=;
	b=0KdTuOfyQSfG6WbIudxiNmtswXW9OTHKyJjZz2J396CZ4490KH9tMObltqYcXKGdOnKemE
	1U/6tg6TVjZFkdBw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=SEKJF3tF;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=0KdTuOfy
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1728051326; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Jubd/UlB1yY1O3O6FyQ5eLpMul/tBHAq/yP21hqjlBU=;
	b=SEKJF3tFNxke/7bupTLBkLU5JAsQOKwwrM3oPbBN7/V8FyG7JsAajI9yRXIMA73BZYMX0v
	ov4ePImL8iGFj7RvumbInI06UeDnme8zsgzgSmTKG1a10N9MuChjZojFKqF/+M6zovPh/p
	ecFheyRO7S8MaiIho3n1+9mBWChfRIY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1728051326;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Jubd/UlB1yY1O3O6FyQ5eLpMul/tBHAq/yP21hqjlBU=;
	b=0KdTuOfyQSfG6WbIudxiNmtswXW9OTHKyJjZz2J396CZ4490KH9tMObltqYcXKGdOnKemE
	1U/6tg6TVjZFkdBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1AEF513A6E;
	Fri,  4 Oct 2024 14:15:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 7ZZjA374/2Z6ZAAAD6G6ig
	(envelope-from <hare@suse.de>); Fri, 04 Oct 2024 14:15:26 +0000
Message-ID: <99ab354d-b6b4-40e0-9f7a-d83b195e5719@suse.de>
Date: Fri, 4 Oct 2024 16:15:25 +0200
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Explanation on Uninitialized Variable bio in blk_rq_prep_clone
To: SurajSonawane2415 <surajsonawane0215@gmail.com>, hch@infradead.org
Cc: axboe@kernel.dk, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <Zv_eFIjstVns-ebG@infradead.org>
 <20241004141037.43277-1-surajsonawane0215@gmail.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20241004141037.43277-1-surajsonawane0215@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 3C70C21D5F
X-Spam-Score: -4.50
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.50 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.19)[-0.971];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_TLS_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,infradead.org];
	RCVD_COUNT_TWO(0.00)[2];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On 10/4/24 16:10, SurajSonawane2415 wrote:
> Explaination of how bio could be used uninitialized in this function:
> 
> In the function blk_rq_prep_clone, the variable bio is declared but can remain uninitialized
> if the allocation with bio_alloc_clone fails. This can lead to undefined behavior when the
> function attempts to free bio in the error handling section using bio_put(bio).
> By initializing bio to NULL at declaration, we ensure that the cleanup code will only
> interact with bio if it has been successfully allocated.
> 
Hate to say it, but it looks you are correct.
Care to send a patch?

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich
