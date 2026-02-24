Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 576C71799F
	for <linux-block@vger.kernel.org>; Tue, 24 Feb 2026 16:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771951237; cv=none; b=nj5xXnR4RBemEKMWVRTquG6zWmL/HRArMXVLCvMXvV9+fMHXvSvQ8LtbhkwgH7O2dZaAPws4PTUIQ1bqTG3npry/rrFG4+r3aHP8vTnxJvw67Qg6ImDC2bz5d6C9nhZcW7Iay5FMGkQaaUjJ8yT2diXxkt/2bO9jbptcimHEOWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771951237; c=relaxed/simple;
	bh=6pN0yizzF/Qj/+2ybCWsowaP4R2f8Ldyi/pDnmRsfg0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y5tcjwHkVGkyp7OMqNJTFiCp0vaTOuTJMBmKMIvGlSApDwUrc6e2pE6huQaFTxn6MNTVvXyhC5MmTRTeSlYX2/inkEypztKCjo9mktXw+Of4jMn0ZhnwTgK5m2pthmiKb+JqADxnvqarEOVzHyf/JGOhb+VqXkFSRkzBhSZmxow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=oXPIb6YQ; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=wpXVfrxY; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=oXPIb6YQ; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=wpXVfrxY; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="oXPIb6YQ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="wpXVfrxY";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="oXPIb6YQ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="wpXVfrxY"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 9B5BA5BD8B;
	Tue, 24 Feb 2026 16:40:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1771951234; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ttbHm5RTO/Dzl7qCo7SvH4Km/2zZmWiCTwCtb7uTuzA=;
	b=oXPIb6YQaaoSuquJ2dgOazaYfr9RJMkpHL/cJpX+F6O3Rvkcnc4tp1d539mOj8oU1YGmXi
	GtmoclFTnrbShjmUGpwkYmrEWqtxHrTErJQJTSIv/tXFGpcgoo2N3wY3UhmVWcmWMWYt7y
	jHGLaMkkNyYT7mjpJ/m+opIymq2y8G4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1771951234;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ttbHm5RTO/Dzl7qCo7SvH4Km/2zZmWiCTwCtb7uTuzA=;
	b=wpXVfrxYlXxN7LkA2dr1FU/Sv4e22p8syLbGskBZgPjMWpcNscwTZlLN5WAm7/yTkFTGSZ
	HOdqv0cjvQF6cuAA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1771951234; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ttbHm5RTO/Dzl7qCo7SvH4Km/2zZmWiCTwCtb7uTuzA=;
	b=oXPIb6YQaaoSuquJ2dgOazaYfr9RJMkpHL/cJpX+F6O3Rvkcnc4tp1d539mOj8oU1YGmXi
	GtmoclFTnrbShjmUGpwkYmrEWqtxHrTErJQJTSIv/tXFGpcgoo2N3wY3UhmVWcmWMWYt7y
	jHGLaMkkNyYT7mjpJ/m+opIymq2y8G4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1771951234;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ttbHm5RTO/Dzl7qCo7SvH4Km/2zZmWiCTwCtb7uTuzA=;
	b=wpXVfrxYlXxN7LkA2dr1FU/Sv4e22p8syLbGskBZgPjMWpcNscwTZlLN5WAm7/yTkFTGSZ
	HOdqv0cjvQF6cuAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 82BA63EA68;
	Tue, 24 Feb 2026 16:40:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id LbO1HoLUnWlKWQAAD6G6ig
	(envelope-from <dwagner@suse.de>); Tue, 24 Feb 2026 16:40:34 +0000
Date: Tue, 24 Feb 2026 17:40:33 +0100
From: Daniel Wagner <dwagner@suse.de>
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: Re: [PATCH blktests 0/3] fix module unload failures
Message-ID: <ad4c1108-8604-4a09-b3fb-e8f77a4abbcf@flourine.local>
References: <20260223035023.21902-1-shinichiro.kawasaki@wdc.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260223035023.21902-1-shinichiro.kawasaki@wdc.com>
X-Spam-Score: -4.30
X-Spam-Level: 
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email]
X-Spam-Flag: NO

On Mon, Feb 23, 2026 at 12:50:20PM +0900, Shin'ichiro Kawasaki wrote:
> Since the recent commit 7c3ad92d3d8f ("check: check reference count for
> modprobe --remove --wait success case"), the test case nvme/060 started
> printing the error message below:
> 
>   modprobe with --wait option succeeded but still nvmet has references
> 
> This error indicates that the nvmet modules failed to unload as
> expected. While the root cause has existed for a long time, the trigger
> commit exposed the problem. I took a look in the failure, and observed
> the failure scenario as follows:
> 
> - The failure occurs when the test case is executed multiple times for
>   different transport types. At the first step, nvme/060 is executed for
>   the loop transport. Although nvme/060 was not designed to run for this
>   transport type, its requirement check leaves two modules loaded: nvmet
>   and nvme-loop.
> 
> - At the second step, when nvme/060 is executed for the rdma transport,
>   the helper function _setup_nvmet() loads the nvmet-rdma module for
>   testing. After the test completes, the helper function
>   _cleanup_nvmet() attempts to unload the nvmet-rdma and nvmet modules.
>   While it succeeds to unload the nvmet-rdma module, it fails to unload
>   the nvmet module because the nvme-loop module is still using the nvmet
>   module. Hence the error message.
> 
> From these observations, I identified two problems below.
> 
> 1) The requirement check for the loop transport left the nvmet and nvme-
>    loop modules loaded and it affected the following test. In the
>    current implementation, the helper function _unload_modules() is
>    called once, only after nvme/060 has been executed for all specified
>    transport types. Instead, _unload_modules() should be called after
>    each run of test test case for every transport. This ensures that the
>    modules loaded for the requirement check are unloaded.
> 
> 2) When _setup_nvmet() does not load the nvmet module, there is no need
>    for _cleanup_nvmet() to attempts to unload it. _cleanup_nvmet()
>    should unload a module only if it was loaded by _setup_nvmet().
> 
> This series addresses these two problems. The first patch fixes the
> first problem. The other two patches fix the second problem.

Looks good to me.

Reviewed-by: Daniel Wagner <dwagner@suse.de>
