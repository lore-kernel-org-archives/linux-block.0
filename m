Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6A6B1C02
	for <linux-block@vger.kernel.org>; Fri, 21 Jun 2024 09:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718960998; cv=none; b=UeblXEtRrauyFE3U4wLG9ITQeRm03DfYKIYK0qvRoaw2cKoSmmEcJKvSD94e0cHNzTNbTmrKLt5CNBJLllh4C3mXUwHo3ylHSdXSPqSeAqNOr5xMv7n5ZER8mJHqVGeFlcWfOkDCEEk2QrjmmTwA5RVf1NBv6xxQxnD8OcZjBxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718960998; c=relaxed/simple;
	bh=zz3W7kOKOYNHffsUavA01vacdfKRjeFjZizv8K2zYzM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mbRZhZ1zLIpKTc02W31qPDSssMpo0I0UNwv4Cd9xITPXuObEXKe3x1yo9/+BL5TfN8iQvewF5Z2/TKrrTYlqxyDuczVLro+bpadd4EjDxC7E6EZc/tJNTBQ5dUizxfYecQIFXPKuF9l63iMm7gCe/mOanJ+v0RWNyNLBb99z6Oo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=qhHzXf4x; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=SNgEplNz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=AZ1tYp5T; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=7+MIeMEs; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="qhHzXf4x";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="SNgEplNz";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="AZ1tYp5T";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="7+MIeMEs"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id E675821A82;
	Fri, 21 Jun 2024 09:09:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1718960994; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=T0SmtAQYtq2KOB6ZyuB4tl3X3fitLgtpUhCYx74pumE=;
	b=qhHzXf4xXYl6d7xkMDUCzYuTMBidDrEKhTnFS0r/RhTVzZIHJcB7gCCtlx9hfe1mejAcnf
	ja1yl71geJHLwzaJ92V+zd1Uu2/NA33vkmNlRWolsSbC0JuFCMrRGqzTKudX9u8hInGvNE
	Wcop/0JR/HnOjDU26G8Y+4JVD4OGcCA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1718960994;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=T0SmtAQYtq2KOB6ZyuB4tl3X3fitLgtpUhCYx74pumE=;
	b=SNgEplNzPYCEiuRFMK+X2l6xZ4Ce1f+RMDJMaBtp4FJHzVVoMhEJLtcazltG2RBBNk1JGZ
	ZLVS5roc0ErIl6BQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=AZ1tYp5T;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=7+MIeMEs
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1718960993; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=T0SmtAQYtq2KOB6ZyuB4tl3X3fitLgtpUhCYx74pumE=;
	b=AZ1tYp5Temg9xDzocvZ6GPmOcIYW7chbXz67McF7ZZ4D8WIjf6xfZ80LHaY7PhLXmyQOQv
	Ct7PL2NPJr1oB4g08jAR4pv3QFGKY49Vc+dF28+pmZFN8R8Wu51haP+uNZgXRH3iLZEJLH
	RDsiJD9ebN5zxRiBMGYdwDVKFKbhOCA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1718960993;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=T0SmtAQYtq2KOB6ZyuB4tl3X3fitLgtpUhCYx74pumE=;
	b=7+MIeMEsDF1UggXny1PjOy1Ex7gvFkj377vYEaAfZF+PNHILxHR/aeefc2w8P7aGzFlSV2
	WXU1kyRyRbXHZRDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CED2A13AAA;
	Fri, 21 Jun 2024 09:09:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id EsVNMWFDdWasOAAAD6G6ig
	(envelope-from <chrubis@suse.cz>); Fri, 21 Jun 2024 09:09:53 +0000
Date: Fri, 21 Jun 2024 11:09:42 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"hch@infradead.org" <hch@infradead.org>,
	Chaitanya Kulkarni <chaitanyak@nvidia.com>
Subject: Re: [PATCH v2] loop: Add regression test for unsupported backing
 file fallocate
Message-ID: <ZnVDVuYfY9MsWnQ2@yuki>
References: <20240617120018.13832-1-chrubis@suse.cz>
 <rpr4g5wgntrp2fcux4dpyfoqdvzi7mcvgwl6rrkxpvdkeanmg7@bu2vdyj4imvf>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <rpr4g5wgntrp2fcux4dpyfoqdvzi7mcvgwl6rrkxpvdkeanmg7@bu2vdyj4imvf>
X-Rspamd-Queue-Id: E675821A82
X-Spam-Score: -3.95
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-3.95 / 50.00];
	BAYES_HAM(-2.94)[99.76%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org

Hi!
> Of note is that I folded in the changes below:
> 
> - Added some descriptions to the commit message and the test file header.
> - The created loop device file path was hard coded as "/dev/loop0", which does
>   not work when the test environment has the device before the test case run.
>   I replaced it with "$loop_dev".

That was actually a copy&paste error sorry for that and thanks for fixing it!

-- 
Cyril Hrubis
chrubis@suse.cz
