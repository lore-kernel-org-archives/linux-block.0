Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E00454F8D
	for <linux-block@vger.kernel.org>; Wed, 24 Apr 2024 12:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713961631; cv=none; b=tqtL+Fm4aIFo/wGkqx+n0xRYEYn7/DppvKTLvAG8hJiw5eqfq+YLdWFqwt/W/rw7lRFoucpiMu3xU39qX9B0vSbFFUfaMhdXj9Vxf2pwTouwbyuK0yiqmerKA8jUSIH+h/lwg/YztSHDK9spiWLkxtAYWCtdJF22Z/+njSIPv+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713961631; c=relaxed/simple;
	bh=iFT1P+KkfF7gYlBLH6YgqwxBg3kt3pWZCaZsCHxOPWI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T270f3+vqefAWKUxWpElUO1QcmXgQWbpnbdC3EtYC1E4XEaroHzi5Px+oXmqy9NO7tGEOyNKCHoKmYThGBJnNRxxmnaL0PpXI5CPR8CkNdcd41bjm89T2ipRvraWjCSDaICLkG6qEPka4VgfslR4UApFnsFf5dbd4luae29fLmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=LRY1JJAh; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=FrEzMpz4; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=LRY1JJAh; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=FrEzMpz4; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="LRY1JJAh";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="FrEzMpz4";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="LRY1JJAh";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="FrEzMpz4"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 1A9C63487F;
	Wed, 24 Apr 2024 12:27:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1713961627; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gkgcaQ0YFyTksYfTa/+pmIIo5echmxDVgyJAWq5qzZQ=;
	b=LRY1JJAhur+UzdQg1yOGsqr3qz5hQ0R5HgDpAghVbljhQYGPwmghGAojWXU8KlOP01Jea/
	PrH+PaFfnaUYA9OJLpH1n1oyk6fdk5AMGP9TA5BQu/B0ojbeVT+tWnthuJUcKxFhiV956r
	ShaZDHxyXvll3foZkZasS/y19Y1JOMs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1713961627;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gkgcaQ0YFyTksYfTa/+pmIIo5echmxDVgyJAWq5qzZQ=;
	b=FrEzMpz42eGas1H1fw35XlO0BjTbxUWvY2bOJjfLY3Dd9BiX8hrSD0vm77APfo+YjAozZw
	XgDS5niF7GtLr+CA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1713961627; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gkgcaQ0YFyTksYfTa/+pmIIo5echmxDVgyJAWq5qzZQ=;
	b=LRY1JJAhur+UzdQg1yOGsqr3qz5hQ0R5HgDpAghVbljhQYGPwmghGAojWXU8KlOP01Jea/
	PrH+PaFfnaUYA9OJLpH1n1oyk6fdk5AMGP9TA5BQu/B0ojbeVT+tWnthuJUcKxFhiV956r
	ShaZDHxyXvll3foZkZasS/y19Y1JOMs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1713961627;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gkgcaQ0YFyTksYfTa/+pmIIo5echmxDVgyJAWq5qzZQ=;
	b=FrEzMpz42eGas1H1fw35XlO0BjTbxUWvY2bOJjfLY3Dd9BiX8hrSD0vm77APfo+YjAozZw
	XgDS5niF7GtLr+CA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0F9941393C;
	Wed, 24 Apr 2024 12:27:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id L0WSA5v6KGZObgAAD6G6ig
	(envelope-from <dwagner@suse.de>); Wed, 24 Apr 2024 12:27:07 +0000
Date: Wed, 24 Apr 2024 14:27:06 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org, 
	Chaitanya Kulkarni <kch@nvidia.com>, Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH blktests v3 05/15] common/rc: introduce
 _check_conflict_and_set_default()
Message-ID: <aamzlwv36dlc4oaz67locs5iblwoaze33dri74mj7ch57rp7tj@4ad3642cuo3p>
References: <20240424075955.3604997-1-shinichiro.kawasaki@wdc.com>
 <20240424075955.3604997-6-shinichiro.kawasaki@wdc.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240424075955.3604997-6-shinichiro.kawasaki@wdc.com>
X-Spam-Level: 
X-Spamd-Result: default: False [-3.59 / 50.00];
	BAYES_HAM(-2.79)[99.10%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:email]
X-Spam-Score: -3.59
X-Spam-Flag: NO

On Wed, Apr 24, 2024 at 04:59:45PM +0900, Shin'ichiro Kawasaki wrote:
> Following commits are going to rename some config option parameters from
> lowercase letters to uppercase. The old lowercase options will be
> deprecated but still be kept usable to not cause confusions. When these
> changes are made, it will be required to check that both new and old
> parameters are not set at once and ensure they do not have two different
> values.
> 
> To simplify the code to check the two parameters, introduce the helper
> _check_conflict_and_set_default(). If the both two parameters are
> set, it errors out. If the old option is set, it propagates the old
> option value to the new option. Also, when neither of them is set, it
> sets the default value to the new option.
> 
> Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>

Reviewed-by: Daniel Wagner <dwagner@suse.de>
