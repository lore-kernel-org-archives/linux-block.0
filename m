Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC9F62D4816
	for <linux-block@vger.kernel.org>; Wed, 25 Feb 2026 19:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772046055; cv=none; b=g7EW0LbqVS83TdsbOUoNsf1O8C4NKZqQ+bb5hQuf1geJqnHMchvpL4GavQKmSUAZL4Yc9nbuYW/zYKl8PUbcZXrwa/fwBTc5dexUDoRF/YQJEs927M9yOUb3/5Jmvz4pgKAI/5XXIhQmHbLc4HBgriQo+9CCjXhQBhxw3viBsnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772046055; c=relaxed/simple;
	bh=tHcsOBGhiUC4T8djxCyTDvwPmeC9a2VcgMgEFhQoQGU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UdYlb1uHsiNuT3gJuc55o979/tSOfMvAlsainPKZajpzFzqr6tBHWyaXj1XboPrKfCjBJprWzbFakhG03i4M0uZHrW5bBxNJaQzAcnm6B98DYGW5reOCAwkHGj2Gdl8DA4cZZLkvWENY5utCG/IC0odyRMcWDkPG6oZkeX/b7iI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=RhCmi/C0; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=psuAICD5; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=fyny0vDI; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=btg4s59G; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="RhCmi/C0";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="psuAICD5";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="fyny0vDI";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="btg4s59G"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id DAE984D9D5;
	Wed, 25 Feb 2026 19:00:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1772046052; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IFFKRpEumM1HwUv5dfXUlm8sXVyMv0DqP69IpUB4fkg=;
	b=RhCmi/C0n2X5+ydduOZeawY7aQ6ynRvxb+rLYkOibBgAL7bahWz0bw/iyvRLjYs3ns5Pf8
	DizKJyZ0V250R1CoKfKGcu0k2J7GaFLwXPHmLPjhy6M5xw0W0Qpk3G5Oc0/tbc8wj4MSD2
	oGm8gCjk5EHw5do3Uhn4U8SWvMLmSP4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1772046052;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IFFKRpEumM1HwUv5dfXUlm8sXVyMv0DqP69IpUB4fkg=;
	b=psuAICD5N+3WZi0XoK0sZ8v93lHa+SfOw3xlNJ6K/EW1lV3z2LTDY7TytZhXulkB89a7eY
	e2MxQdSWBM6e3/AA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1772046050; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IFFKRpEumM1HwUv5dfXUlm8sXVyMv0DqP69IpUB4fkg=;
	b=fyny0vDI3cHJBIW5JN3j5uNuQXDjb8Xg9ZMU5ccl7YDEEPHdcxdQzZJSCX8jsYHbsg7FCs
	y1oSXk/qF1M26tFqWVNwjJMA9K8tE8Sx8UxQWL6NO+GQDCSV4YQ2QDlII9MXIUpQkwZeyB
	LbTklNMjG9kJHAOI7qOvmIZUEAuyih0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1772046050;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IFFKRpEumM1HwUv5dfXUlm8sXVyMv0DqP69IpUB4fkg=;
	b=btg4s59G0G35cuR83FMpYmuaPJiVpHAmFUwY/M9RsAnyDIwFQHxTM2vVtFmjb3kDurRSh6
	0paX/9MgjXICojBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BDFB63EA65;
	Wed, 25 Feb 2026 19:00:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id u38pLeJGn2l6cwAAD6G6ig
	(envelope-from <dwagner@suse.de>); Wed, 25 Feb 2026 19:00:50 +0000
Date: Wed, 25 Feb 2026 20:00:49 +0100
From: Daniel Wagner <dwagner@suse.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Bill Wendling <morbo@google.com>, linux-kernel@vger.kernel.org, 
	Kees Cook <kees@kernel.org>, Gogul Balakrishnan <bgogul@google.com>, 
	Arman Hasanzadeh <armanihm@google.com>, linux-block@vger.kernel.org
Subject: Re: [PATCH] blkdev: Annotate struct request_queue with
 __counted_by_ptr
Message-ID: <765dedf4-e144-4f8b-971b-b33c81c56047@flourine.local>
References: <20260219004940.2594201-1-morbo@google.com>
 <9b7a107e-bc07-4a75-86b0-2685d4c78bb9@flourine.local>
 <CAGG=3QXcA7et9LmZ+Cu8zn1yBXrPizL7BhYFvfFZpWA7aUR3xw@mail.gmail.com>
 <e3c0a209-56f7-4ac2-b089-e0600672cf25@flourine.local>
 <CAGG=3QVHKmZzL=C808qnigYDC1jiNSdwCODYdU6_2_yXSLAaSQ@mail.gmail.com>
 <466dd888-0910-4e39-8946-004ac7cd91d5@flourine.local>
 <CAGG=3QW22piyPN6ZCAEiNDHyrRg18OqqyYsy-2s6m2ois=Rorg@mail.gmail.com>
 <43fedaa5-b5b5-4c65-8048-48ffe01e9b15@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43fedaa5-b5b5-4c65-8048-48ffe01e9b15@kernel.dk>
X-Spam-Score: -4.30
X-Spam-Level: 
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RCVD_TLS_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_DN_SOME(0.00)[]
X-Spam-Flag: NO

On Wed, Feb 25, 2026 at 11:53:56AM -0700, Jens Axboe wrote:
> On 2/25/26 11:26 AM, Bill Wendling wrote:
> > Could you please change "Gemini" to "CodeMender" in the patch commit
> > message? If you like, I can send a v2.
> 
> Not sure how you think this works, but since Daniel isn't the one
> applying the patch, not sure how he'd change your patch for you.
> Just send a v2 if you want some random name change done in it.

I could do 'C-x M-x butterfly' :)

(https://xkcd.com/378/)
