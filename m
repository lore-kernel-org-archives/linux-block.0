Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A23E59151
	for <linux-block@vger.kernel.org>; Tue,  2 Apr 2024 10:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712052633; cv=none; b=Evgl2EbCXojFBj20E16Qbi11Gnfd2Y8bcm3IVYiex+Mk4Tw5YSw2Il1YY2SK7zCFnySX9kOk/M2DN34D0U0rJfDV0DTsPBDADALuE8PSxvcRLBRyLPh6y+pCAh3apLib5t+pBpHc78RkswzeAASmlbny3owBKYdVZjZ65Xoer1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712052633; c=relaxed/simple;
	bh=8fs1M7d7ioIXBebGKGv/5HJvAs7eam1w7lDzJnpbla4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PPslDK6C/Q89xnZRreEf8xyWfGkO/R5gQh9bXC2v7ZmRgr0PDmvbUxzgf60KuPXeCo3J0a1jTzwvyB3RWfuVB15wdIhd/z2KcJAo2OLHqa0B9klptYWmz+2VsDB2XXhZgXu/9NLN1+kR1L9Q1dINH+h0knvsaabwC9zAZdkVLjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=XSRAzSMj; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=rloNHqPU; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="XSRAzSMj";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="rloNHqPU"
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 28A0320F3C;
	Tue,  2 Apr 2024 10:10:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1712052629; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=I9Zn3/gNoGh//4HMyGrS1vSvGYLFlLL3O2YsbD2eBoQ=;
	b=XSRAzSMjOAYv/3eS4jFugpALwXjvn3fGjtHP7xEv8swD1o/v8h0Ze+8DcL/bLs2+4MLg5v
	NmZPrykqzirTWmsGni1yCz3CEYeKrVcl8gPDmRFiTou50LGxB6/pxAgn3NfD5+ycjnR3P6
	Wer05pKkSjqP9ccp1/K4LJVDvTkg/I8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1712052629;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=I9Zn3/gNoGh//4HMyGrS1vSvGYLFlLL3O2YsbD2eBoQ=;
	b=rloNHqPUH6jkIjici0r3YEFj3efDGuUoCdTCKrrGBMcstRYxeRByNavf5aCnutjEJqrGV9
	qPjC4Q1B1myn+iAw==
Authentication-Results: smtp-out2.suse.de;
	dkim=none
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 0BBA313A90;
	Tue,  2 Apr 2024 10:10:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id EidyAZXZC2ZgDAAAn2gu4w
	(envelope-from <dwagner@suse.de>); Tue, 02 Apr 2024 10:10:29 +0000
Date: Tue, 2 Apr 2024 12:10:28 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org, 
	Chaitanya Kulkarni <chaitanyak@nvidia.com>, Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH blktests v1 0/3] add blkdev type environment variable
Message-ID: <6i2vraf2ljq6rqwpblb5ukej4kwugxv7oz4sadfdzdezr5ypic@samrbrdegi35>
References: <20240402100322.17673-1-dwagner@suse.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240402100322.17673-1-dwagner@suse.de>
X-Rspamd-Queue-Id: 28A0320F3C
X-Spamd-Result: default: False [-2.22 / 50.00];
	BAYES_HAM(-2.42)[97.33%];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.993];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:98:from];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:98:from];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	R_DKIM_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap2.dmz-prg2.suse.org:rdns,imap2.dmz-prg2.suse.org:helo]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spam-Score: -2.22
X-Spam-Level: 
X-Spam-Flag: NO

On Tue, Apr 02, 2024 at 12:03:19PM +0200, Daniel Wagner wrote:
> The nvme/028 test with file backend is failing in my setup
                         ^^^^^^^^^^^^^
                         block device backend
