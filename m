Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A9D226AF5
	for <linux-block@vger.kernel.org>; Thu, 27 Jun 2024 10:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719483832; cv=none; b=YkBxIR7YfUPdSAZhLnIATAWA6HFafJbHUzrKLpxcQnctMr9N/2shcDKNMRXsCYj1uD5Yrf6cvkZen/qhcyT8sNk3dVWgzpcvZMTHqFjKh1/MylQQwGjNABXIfc6Y88DrBHIs1IJ93ZBUgJ4+k/gJxbRw1GLEZOSzMQOEPg03s9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719483832; c=relaxed/simple;
	bh=2VhZ1+6NRlfV8BGa+CFX70ZvHJBCHM8zZRPRlEjGo7Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S9j6iHIMQatJSEPIR/dzCq9/XWhNdC8z/l+Pj82eBYwRr0ue/cyiWdYFXWXW0Tiyv4OGf32QFpKT2tN7zheoguNEGaYCRNfN7f/O4mA9rCeSR79sdaVuibR+1Af/2+en63zjw5cDPzj1roob1L1Uz2XKOZCzhScLcxM42aKsZYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=AwSh7gf6; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Yhg9tlcA; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=AwSh7gf6; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Yhg9tlcA; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="AwSh7gf6";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Yhg9tlcA";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="AwSh7gf6";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Yhg9tlcA"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 2CA1E21B71;
	Thu, 27 Jun 2024 10:23:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1719483829; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DJFLfE5t4o2Bv++gGiHtjaxiUNT81/sigsZa/qgC/BI=;
	b=AwSh7gf6Zn2rkmWf8Yv6MIqYdwrgJ2YwUazOm086J2G3ByOTOk7tlmrE1c/QK83LpgVx5T
	8P0Ni/8hC1IWE0Hk3zDCZ4R6ES94HUuWOuG9f32IIY+PwqCmBOITuOtUeyYuVT/MjXrpOV
	Uhv5ez3dbUYjRDCYozbGXsK+R1qSGn8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1719483829;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DJFLfE5t4o2Bv++gGiHtjaxiUNT81/sigsZa/qgC/BI=;
	b=Yhg9tlcAXSzIkt+6kV0qJZe4+1xQT2I30vlPtUXvRDIk31vnl5TrjXV6IKBuzwY74YVQPs
	gD7v1tcxT4LuryBw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=AwSh7gf6;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=Yhg9tlcA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1719483829; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DJFLfE5t4o2Bv++gGiHtjaxiUNT81/sigsZa/qgC/BI=;
	b=AwSh7gf6Zn2rkmWf8Yv6MIqYdwrgJ2YwUazOm086J2G3ByOTOk7tlmrE1c/QK83LpgVx5T
	8P0Ni/8hC1IWE0Hk3zDCZ4R6ES94HUuWOuG9f32IIY+PwqCmBOITuOtUeyYuVT/MjXrpOV
	Uhv5ez3dbUYjRDCYozbGXsK+R1qSGn8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1719483829;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DJFLfE5t4o2Bv++gGiHtjaxiUNT81/sigsZa/qgC/BI=;
	b=Yhg9tlcAXSzIkt+6kV0qJZe4+1xQT2I30vlPtUXvRDIk31vnl5TrjXV6IKBuzwY74YVQPs
	gD7v1tcxT4LuryBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1DA8E137DF;
	Thu, 27 Jun 2024 10:23:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id zY5SBrU9fWalKwAAD6G6ig
	(envelope-from <dwagner@suse.de>); Thu, 27 Jun 2024 10:23:49 +0000
Date: Thu, 27 Jun 2024 12:23:44 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Hannes Reinecke <hare@suse.de>
Cc: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>, 
	Chaitanya Kulkarni <chaitanyak@nvidia.com>, linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: Re: [PATCH blktests v3 1/3] nvme/rc: introduce remote target support
Message-ID: <c4y3kfs5m6llmysgjpyicocgh2g2z2ri5k6vbtd3fw4z36dze3@dctq2xzrimid>
References: <20240627091016.12752-1-dwagner@suse.de>
 <20240627091016.12752-2-dwagner@suse.de>
 <c3475515-e776-41cd-8c60-e0f5fccea052@suse.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c3475515-e776-41cd-8c60-e0f5fccea052@suse.de>
X-Rspamd-Queue-Id: 2CA1E21B71
X-Spam-Score: -6.01
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-6.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	DWL_DNSWL_MED(-2.00)[suse.de:dkim];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:dkim];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org

On Thu, Jun 27, 2024 at 11:59:11AM GMT, Hannes Reinecke wrote:
 > +	if [[ -n "${nvme_target_control}" ]]; then
> > +		eval "${nvme_target_control}" cleanup \
> > +			--subsysnqn "${subsysnqn}" \
> > +			> /dev/null
> > +		return
> > +	fi
> > +
> >   	_get_nvmet_ports "${subsysnqn}" ports
> >   	for port in "${ports[@]}"; do
> 
> Hmm. This wasn't quite what I had in mind; I think it'd be simpler
> if we could just check if the requested controller is visible to the
> host already (ie checking sysfs here), and then skip all the setup
> steps at they are obviously not required anymore.
> That would save quite a lot of issues, and we wouldn't need to specify
> a target setup script (or whatever).

What I like at the current approach is that it allows to support the
use case where the external target can be configured. For example this
works with a remote VM running Linux pretty well. With your idea only
static setups are supported.

I don't know what you mean with 'quite a lot of issues'. I've running
this against a VM which gets dynamically configured and it works well.

> Quite a bit of churn, I agree, as that would mean we have to roll
>
> 	_setup_nvmet
>
> 	_nvmet_target_setup
>
> 	_nvme_connect_subsys
>
> all into one function. But it might be easier in the long run.
> Hmm?

Not all tests have this pattern, e.g. nvme/031. This test works with
the approach in the version of the series though.

Sure, I'll don't see a problem to refactor a bit more and reduce the
boiler plate even more but I see this a different task.
