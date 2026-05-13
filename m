Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69CE01F872D
	for <linux-block@vger.kernel.org>; Wed, 13 May 2026 14:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778681153; cv=none; b=fatIkB40Q+kYjOrcEiNtwE8cz6XY7VDfOt1tbh186EEspIaAlgLCmJm6VivPhs+FqSw/ifqPN2OjV1uOqPBQhbEPtqW2sLbvNj4B34CamSySEAtvMFokGcMzzGh+zTpXwt0yiugT3ykUfb6jGyGX6vVJOe0XNEshc1SXbRA8990=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778681153; c=relaxed/simple;
	bh=vLGBJzAqmwOFjcv5+diSGOX8Q0q90KRq+/B7+i4H118=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JOjOI3TQHv1vqcDPmUbmjcDODGg1lhd+pbP/2ZFPWP8mprL3V/76GAa1YkNcCaIZpGtMA080Djg0vuC5N991XazYFe608E4XfAdQm5l5lEJCd7qgN/0hhNAUnlX/PxPhrxc/rM8jcCKk75oBAfqiNX0wuy7dFb+/pKOaaci7RTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=aOtDYk2p; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=tvCnm7rO; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=aOtDYk2p; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=tvCnm7rO; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="aOtDYk2p";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="tvCnm7rO";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="aOtDYk2p";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="tvCnm7rO"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id AE1B075C9D;
	Wed, 13 May 2026 14:05:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1778681150; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=02zsox/KaQqS6cDGrLy26INXRjwBxe3jTONzBR3RF+4=;
	b=aOtDYk2po3pWyJU0I3bCfR36DkQLxAKfpM6QWaUJo8ADXvLYA4+VCjS+BWm0pDKrkdLZaw
	yIEa0bhETWWF3zrZXO4mGlekBIA3+XeaLAf9q/QrsFwFACWMSAHVXY6gMeV5734rEwNP+K
	wO0Ym3+IUItDGUNVqUEVjDbfTUCY8OU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1778681150;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=02zsox/KaQqS6cDGrLy26INXRjwBxe3jTONzBR3RF+4=;
	b=tvCnm7rOge7zAWYMwYRI7u84NjY4wZk6vA8leca0aV0+WxW8QZVsTmsTOluFEfQiYZauWm
	eF7JSOdt6+ERP6Dg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1778681150; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=02zsox/KaQqS6cDGrLy26INXRjwBxe3jTONzBR3RF+4=;
	b=aOtDYk2po3pWyJU0I3bCfR36DkQLxAKfpM6QWaUJo8ADXvLYA4+VCjS+BWm0pDKrkdLZaw
	yIEa0bhETWWF3zrZXO4mGlekBIA3+XeaLAf9q/QrsFwFACWMSAHVXY6gMeV5734rEwNP+K
	wO0Ym3+IUItDGUNVqUEVjDbfTUCY8OU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1778681150;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=02zsox/KaQqS6cDGrLy26INXRjwBxe3jTONzBR3RF+4=;
	b=tvCnm7rOge7zAWYMwYRI7u84NjY4wZk6vA8leca0aV0+WxW8QZVsTmsTOluFEfQiYZauWm
	eF7JSOdt6+ERP6Dg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9A257593A9;
	Wed, 13 May 2026 14:05:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id r2bmIz6FBGqLBQAAD6G6ig
	(envelope-from <dwagner@suse.de>); Wed, 13 May 2026 14:05:50 +0000
Date: Wed, 13 May 2026 16:05:49 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: linux-block@vger.kernel.org, Daniel Wagner <wagi@kernel.org>, 
	John Meneghini <jmeneghi@redhat.com>
Subject: Re: [PATCH blktests 2/3] common/rc: add _echo() function to trace
 sysfs attribute writes
Message-ID: <a1668df1-a93a-442a-ae95-e015bcbeec17@flourine.local>
References: <20260513112326.584256-1-shinichiro.kawasaki@wdc.com>
 <20260513112326.584256-3-shinichiro.kawasaki@wdc.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260513112326.584256-3-shinichiro.kawasaki@wdc.com>
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
	RCPT_COUNT_THREE(0.00)[4];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,flourine.local:mid]
X-Spam-Flag: NO
X-Spam-Score: -4.30

On Wed, May 13, 2026 at 08:23:25PM +0900, Shin'ichiro Kawasaki wrote:
> +# Echo a value to a file. This wrapper is used to trace sysfs attribute writes
> +# when the --cmd-trace option is enabled.
> +_echo() {
> +	echo "$1" > "$2"
> +}

Stupid question, can't we override the echo function, something like this:

echo() {
    builtin echo "$@"
    builtin echo "$@" >> "/tmp/debug_log.txt"
}
