Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFA073D8105
	for <linux-block@vger.kernel.org>; Thu, 16 Jul 2026 10:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784196319; cv=none; b=oG/zH4ISzFW3ju4wV7Rb1pFNM640HQs0maa5JjbhcPQXJvK89l74u6Pn17NSb4F4NwmnxNDZ8oJzxkI8T2ZlnSvTsDnwzxK4v54H54Rt/cqipzAIcuLMo6xaLaPl504Jl/io8GZq2cJfzTY0Pc4kp1+Ki6xL063D4N77nrzvIJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784196319; c=relaxed/simple;
	bh=qSu3gPKksFRhj1Cstq8qkDwPWy18V+UgvxFZK3FyHUI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HYiyHpek746HE+nI4GdamvkG5pt1xtQg/2DE3NRKjN5ah56SFBbTXg+xK+twuHtaBMV9t//JFAWRwl6scSWTz+35xzHoxCHiMMDTyvnktYWzqgg2UG9WwpHjkTk8iVHTMt6vuEg0YrvrHUiUf1ITox3a/KKj8dRX4b1HwH1/kAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=JBM+13FN; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=evYwm3P7; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=JBM+13FN; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=evYwm3P7; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="JBM+13FN";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="evYwm3P7";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="JBM+13FN";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="evYwm3P7"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id CA7083E2F;
	Thu, 16 Jul 2026 10:05:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1784196309; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eh+8G6NgKXlA7paarlAqWn/uw+w+/RNg1uQzYNLNfms=;
	b=JBM+13FNQ7XOXJbkyIlsyQuYJNCwjRvXWsU/6BTSp4mzPLL2tSvBCjO8MChXzwWbA0X7bk
	GDr1jcnSeQcU2hWJSi1jJvrRJk1HACgBNw1eUwtf93wqpzUirGqWh8k6JDwz2e6nC87E6V
	LZzbdSqqYFnVzk7VMZB3B49cXb++T5s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1784196309;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eh+8G6NgKXlA7paarlAqWn/uw+w+/RNg1uQzYNLNfms=;
	b=evYwm3P7Ra2omjZnO1InTWy0Bgef6mXGrxz0nTPtZBtBXo3ON8ibbZYHf3r8pbRd5sjTEE
	NvrwIYYMa4+q4UAQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1784196309; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eh+8G6NgKXlA7paarlAqWn/uw+w+/RNg1uQzYNLNfms=;
	b=JBM+13FNQ7XOXJbkyIlsyQuYJNCwjRvXWsU/6BTSp4mzPLL2tSvBCjO8MChXzwWbA0X7bk
	GDr1jcnSeQcU2hWJSi1jJvrRJk1HACgBNw1eUwtf93wqpzUirGqWh8k6JDwz2e6nC87E6V
	LZzbdSqqYFnVzk7VMZB3B49cXb++T5s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1784196309;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eh+8G6NgKXlA7paarlAqWn/uw+w+/RNg1uQzYNLNfms=;
	b=evYwm3P7Ra2omjZnO1InTWy0Bgef6mXGrxz0nTPtZBtBXo3ON8ibbZYHf3r8pbRd5sjTEE
	NvrwIYYMa4+q4UAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B818E779AD;
	Thu, 16 Jul 2026 10:05:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 7HVPK9WsWGr9OQAAD6G6ig
	(envelope-from <dwagner@suse.de>); Thu, 16 Jul 2026 10:05:09 +0000
Date: Thu, 16 Jul 2026 12:05:09 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Sebastian Chlad <sebastianchlad@gmail.com>
Cc: linux-block@vger.kernel.org, 
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>, Sebastian Chlad <sebastian.chlad@suse.com>
Subject: Re: [PATCH 1/2] common/rc: add _have_debugfs()
Message-ID: <0b2138b2-cd91-465c-82df-5c4909b94050@flourine.local>
References: <20260716090626.27558-1-sebastian.chlad@suse.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260716090626.27558-1-sebastian.chlad@suse.com>
X-Spam-Flag: NO
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_TLS_ALL(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Spam-Level: 
X-Spam-Score: -4.30

On Thu, Jul 16, 2026 at 11:06:25AM +0200, Sebastian Chlad wrote:
> Kernel options like FAULT_INJECTION_DEBUG_FS being enabled does not
> guarantee debugfs is actually mounted at /sys/kernel/debug: on
> systemd systems, sys-kernel-debug.mount may not be started by
> default (e.g. SLE).
> 
> Add _have_debugfs(), mirroring the existing _have_configfs() and
> _have_tracefs() checks, so tests that depend on debugfs-backed
> interfaces can skip cleanly with a clear reason instead of failing.

Looks good. Could you need to add your SoB to both patches?
Thanks!
