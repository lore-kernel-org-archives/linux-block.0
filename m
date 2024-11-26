Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 001A327442
	for <linux-block@vger.kernel.org>; Tue, 26 Nov 2024 12:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732624971; cv=none; b=HqtYNk4svT+RRjxLs4kms1YPleOr3eQyRk4CqbBQXzhzRTQf1NtWwL5GI5oX5qpWmEkZJBzK+XXs6GsmKd6WGS08+dTkAt3E5ms5mgjE7e8WqOxnwFXxxB6MVDnIF523YEejqPbsDps970XYUIu63SwsWhPC9ZWHUZMK3YQiyP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732624971; c=relaxed/simple;
	bh=W0hr2u+OCoELdr9LSdCi8T7Qlo6djA0oJTS5lVa89wY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=temc9TyIQgkSXsxw6eGUoeW5nd4m89A8fxgkuNHycgtEBuS5fcpG46dXTlGDcknmPwEAQCcNvy9q6oD4Dacl0LcG47/jEfxH0UC3wJzKXxLkG8TNmPJ9gAI8rlXfdZerx8DoKTfUOsH9fP4JhotdihR9t2lPUFmRM8FyJv2iU+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=dxqanH+v; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=NaLNisZC; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=uKDMh2WP; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=stZa6brV; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="dxqanH+v";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="NaLNisZC";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="uKDMh2WP";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="stZa6brV"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 298A31F74B;
	Tue, 26 Nov 2024 12:42:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1732624968; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RWYQgGBlPjwADyty9JXPNBFaS02BPkZ3fBUHGg00k5Q=;
	b=dxqanH+v/e165knU/ws4o+T1/vq897t3F35vB9d07Ux3Ss4xSUonwi5vtoQBHFMdOncwwU
	qucI98OCc1mHUzOiiLxoe0jSTLkAhWep5aD66JIAuVAP7PbKHcn4rvyC7YLVzTd1PzGeWW
	1d9tHXjMDPTQENaTyARu8t9ISIHZJ1M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1732624968;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RWYQgGBlPjwADyty9JXPNBFaS02BPkZ3fBUHGg00k5Q=;
	b=NaLNisZC/9AC5nDbicwDufR+F0Hyiqczmp4wbquEX7rH5obeTkSx3s+w4odQlPmbmy+dQN
	Qxo22cGp14D62pAA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1732624967; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RWYQgGBlPjwADyty9JXPNBFaS02BPkZ3fBUHGg00k5Q=;
	b=uKDMh2WP9yW9nhjLNmNNC2JhTHSgszZRBqFDbSbAQgbBrK9ETVNfqnBGeFv4tRFQCapBpu
	0+01NYVjFww05thObGEADp6/vDYs2gfin1GIExYhmS73unsu735A5Nt2yweA3OfvSg4MXP
	9nt6vvZ0ZtVtCKkwxgm8xMCicTsTtE4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1732624967;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RWYQgGBlPjwADyty9JXPNBFaS02BPkZ3fBUHGg00k5Q=;
	b=stZa6brVzRWin90qgCaVLycwwK80bPK9IBwkS2v80LTNV2hUtq4i9/ebAIlG9DOlqOtip4
	/IftCBy/2DtdJRAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0623C139AA;
	Tue, 26 Nov 2024 12:42:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id +GbjAEfCRWe/UwAAD6G6ig
	(envelope-from <hare@suse.de>); Tue, 26 Nov 2024 12:42:47 +0000
Message-ID: <2f3dd703-f979-47e9-9952-e5777c31b255@suse.de>
Date: Tue, 26 Nov 2024 13:42:46 +0100
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] null_blk: Add rotational feature support
To: Damien Le Moal <dlemoal@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 linux-block@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>
References: <20241126000956.95983-1-dlemoal@kernel.org>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20241126000956.95983-1-dlemoal@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -4.30
X-Spam-Flag: NO

On 11/26/24 01:09, Damien Le Moal wrote:
> To facilitate testing of kernel functions related to the rotational
> feature (BLK_FEAT_ROTATIONAL) of a block device (e.g. NVMe rotational
> bit support), add the rotational boolean configfs attribute and module
> parameter to the null_blk driver. If set, a null block device will
> report being a rotational device through it queue limits features with
> the BLK_FEAT_ROTATIONAL flag.
> 
> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
> ---
>   drivers/block/null_blk/main.c     | 13 ++++++++++++-
>   drivers/block/null_blk/null_blk.h |  1 +
>   2 files changed, 13 insertions(+), 1 deletion(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich
