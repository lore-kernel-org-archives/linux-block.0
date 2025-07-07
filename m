Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78F5B33993
	for <linux-block@vger.kernel.org>; Mon,  7 Jul 2025 06:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751868378; cv=none; b=jk89zBQRFPbv6tCBFuB2XwMts9HmIe3ciTNb9rDqvr3Ir+sIyDAge7oZZofTXZgJUcfeb8qnouzf2DC5fqPYnFWPWN2CeS2jZp4cH5o+vISK6LHsCjKdnIUCmYdfaBpSJoM6McMLt/6GCd1mqmQ9mTaqRhd+bIh38Wg89pV/mbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751868378; c=relaxed/simple;
	bh=JpvNM43L/EayG/41IE1/A/AQ4z/Gko47AN3imBJUM3c=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=R1YWNchGbkCrSKMh6j1SbhBv+NQw0t9XNHnvluZvOuKTcqX2bfr3EuH7ClloNxMEt6+f+oM30a8Q09hYGOhnPbxUlyuuMUrwA//ZwoqIlQTN7IdrlLcw2QP7TeSfdCAAbnksb6EwobN5T2T1kGEEDk3t1b1+u1xchU7G21QMNc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=wtrkAoxW; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=d5YYig9t; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=RGDrB4cG; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=G1n/63r6; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="wtrkAoxW";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="d5YYig9t";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="RGDrB4cG";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="G1n/63r6"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 4BCA621168;
	Mon,  7 Jul 2025 06:06:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1751868374; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9jQoZ3h34iT4lM0EDYPVkLNZ3ikUlsV4Mn6UQjoGTh8=;
	b=wtrkAoxWj7YdFyvQbOXM/ZIHJwRSlQRGWyDr55o9XAS39DPk1OqIiSjDOMs7+FH3jEY02x
	+NvaL2FQRS7Sq+8qH8k/taVxagZS/ZjVtJEFC9ZfTSJ1Ssi1I2Th35/0qGdR9XfhJmrcL0
	5h7wc0MPc2juQE40+KThAlBVVpSeFUI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1751868374;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9jQoZ3h34iT4lM0EDYPVkLNZ3ikUlsV4Mn6UQjoGTh8=;
	b=d5YYig9t0ub4KVfQZ5g1gUPtqiXV9TIbjz+r6M1TWSytJBLHJxEL8MzL2ty1TBkQ9wXW76
	Rc3JEDCJRt9LwgCQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1751868373; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9jQoZ3h34iT4lM0EDYPVkLNZ3ikUlsV4Mn6UQjoGTh8=;
	b=RGDrB4cGCrsC9GstV+7pFct7Pn+bVWpkMeQhqDwurJxZ+cr1svhMe5C5L58GEkpdaA3MJ/
	IQBSr0z1Pgja/A0fmBL/LgMKVAoGX5K97YC1GlJa0GbxHY2nzmz9mghUqikds81bS6xK3I
	tHkMbVTMmKy3WXxPpAL00Z9vuundt7w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1751868373;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9jQoZ3h34iT4lM0EDYPVkLNZ3ikUlsV4Mn6UQjoGTh8=;
	b=G1n/63r6OkjIH2hVOhfeUQXQZCS7AjM84M/TGe8Q/l+o4wNRvIin6+08Fej9H4MaBzWORX
	Ph5O25G9G+JGX3BA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1040013797;
	Mon,  7 Jul 2025 06:06:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id v954O9Rja2ihCQAAD6G6ig
	(envelope-from <hare@suse.de>); Mon, 07 Jul 2025 06:06:12 +0000
Message-ID: <069d95d7-5a76-4255-a75a-22d1d68e6047@suse.de>
Date: Mon, 7 Jul 2025 08:06:12 +0200
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block: remove pktcdvd driver
To: Jens Axboe <axboe@kernel.dk>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <dcc4836e-6da9-4208-ad27-bbd44b3a2063@kernel.dk>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <dcc4836e-6da9-4208-ad27-bbd44b3a2063@kernel.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,kernel.dk:email,suse.de:mid,suse.de:email]
X-Spam-Flag: NO
X-Spam-Level: 
X-Spam-Score: -4.30

On 7/7/25 01:23, Jens Axboe wrote:
> This driver has long outlived it's utility, and it's broken and unloved.
> The main use case for this was direct mount with UDF of cd-rw drives
> that required 32kb packets. It would collect writes into that size and
> write them out in multiples of that. That's not a common use case
> anymore, the world has moved on from those kinds of media. To make
> matters worse, it's actively breaking setups where it's not even
> required or useful.
> 
> Link: https://lore.kernel.org/linux-block/fxg6dksau4jsk3u5xldlyo2m7qgiux6vtdrz5rywseotsouqdv@urcrwz6qtd3r/
> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> 
Reviewed-by: Hannes Reinecke <hare@kernel.org>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich
