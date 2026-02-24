Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88D2436827F
	for <linux-block@vger.kernel.org>; Tue, 24 Feb 2026 08:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771923349; cv=none; b=Xjg0PtjmJxAbdrc4xlUet3Q8Aq9vcoSNdp1a6mfZy4LJQHdg4KVvmqL99Zicc4NAloqt05KFwUjbTZdqrLOy61XNWjFmchNPHo0qUH7eJBnP9vw+obuFgGndkrSFgBiofY2naVqJzx8dx3fxy0cij4T/6c9HC580CFdLGLvlUkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771923349; c=relaxed/simple;
	bh=mRFzDiVZ186OM7Q2DASX1aPJ6sfyQyaJnUNaznvfJj0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gyTAUmdKBHhiEffjv1gP8GOq/60rjh9a4/iABvOnE9s0kfgQrNIEoRWEeG+Yef+o7C9Y/T2zYp6Au8lHsVt893ricaA5+bjVENHFDmhXr6QbsyDnN0gUrKG9I8O/kSglGPXfscqnqgJcVh5vOo7JWRKkg+GQAHz9w5MwapQ2J6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=iEBsE3Sm; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=eOPSKZdA; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=iEBsE3Sm; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=eOPSKZdA; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="iEBsE3Sm";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="eOPSKZdA";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="iEBsE3Sm";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="eOPSKZdA"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id A83805BCD5;
	Tue, 24 Feb 2026 08:55:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1771923346; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mRFzDiVZ186OM7Q2DASX1aPJ6sfyQyaJnUNaznvfJj0=;
	b=iEBsE3SmyXQLSDTW4b0KCSuFX7QPIL/BZxCG5PBmLY+l54DGJHSP6Q3AovM3LkFs/LLdFm
	WkVonL/sxFJsZ1OVMtI8y9mhkaJgsv5vj88qdsj56SwDo7nJgYit7N4RPS/ck7QrZwjY55
	ey7rEhP2KERwjT4ItbhbdR3ktvByxno=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1771923346;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mRFzDiVZ186OM7Q2DASX1aPJ6sfyQyaJnUNaznvfJj0=;
	b=eOPSKZdAICEcJlw4VtXuTMrF43x8orIdgd/rnhm2+LzM3d8lZZkQOe5U9fVsHgS+LuWsph
	xFeDCVR4NhvmNsBw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1771923346; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mRFzDiVZ186OM7Q2DASX1aPJ6sfyQyaJnUNaznvfJj0=;
	b=iEBsE3SmyXQLSDTW4b0KCSuFX7QPIL/BZxCG5PBmLY+l54DGJHSP6Q3AovM3LkFs/LLdFm
	WkVonL/sxFJsZ1OVMtI8y9mhkaJgsv5vj88qdsj56SwDo7nJgYit7N4RPS/ck7QrZwjY55
	ey7rEhP2KERwjT4ItbhbdR3ktvByxno=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1771923346;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mRFzDiVZ186OM7Q2DASX1aPJ6sfyQyaJnUNaznvfJj0=;
	b=eOPSKZdAICEcJlw4VtXuTMrF43x8orIdgd/rnhm2+LzM3d8lZZkQOe5U9fVsHgS+LuWsph
	xFeDCVR4NhvmNsBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8BECE3EA68;
	Tue, 24 Feb 2026 08:55:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 1ZvvIJJnnWm7XQAAD6G6ig
	(envelope-from <dwagner@suse.de>); Tue, 24 Feb 2026 08:55:46 +0000
Date: Tue, 24 Feb 2026 09:55:45 +0100
From: Daniel Wagner <dwagner@suse.de>
To: Bill Wendling <morbo@google.com>
Cc: linux-kernel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>, 
	Kees Cook <kees@kernel.org>, Gogul Balakrishnan <bgogul@google.com>, 
	Arman Hasanzadeh <armanihm@google.com>, linux-block@vger.kernel.org
Subject: Re: [PATCH] blkdev: Annotate struct request_queue with
 __counted_by_ptr
Message-ID: <466dd888-0910-4e39-8946-004ac7cd91d5@flourine.local>
References: <20260219004940.2594201-1-morbo@google.com>
 <9b7a107e-bc07-4a75-86b0-2685d4c78bb9@flourine.local>
 <CAGG=3QXcA7et9LmZ+Cu8zn1yBXrPizL7BhYFvfFZpWA7aUR3xw@mail.gmail.com>
 <e3c0a209-56f7-4ac2-b089-e0600672cf25@flourine.local>
 <CAGG=3QVHKmZzL=C808qnigYDC1jiNSdwCODYdU6_2_yXSLAaSQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGG=3QVHKmZzL=C808qnigYDC1jiNSdwCODYdU6_2_yXSLAaSQ@mail.gmail.com>
X-Spam-Score: -4.30
X-Spam-Level: 
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	URIBL_BLOCKED(0.00)[flourine.local:mid,suse.de:email,imap1.dmz-prg2.suse.org:helo];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO

On Mon, Feb 23, 2026 at 02:47:47PM -0800, Bill Wendling wrote:
> Okay. I successfully ran the tests you indicated above and they passed.

Ah great. Thanks a lot!

Reviewed-by: Daniel Wagner <dwagner@suse.de>
