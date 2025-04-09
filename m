Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14F5A26FD86
	for <linux-block@vger.kernel.org>; Wed,  9 Apr 2025 17:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744221585; cv=none; b=tYVfvnDty2zrI9ycsV7wOb+RUlxvBzivcpe9irSuLi5wrey+myS2YtR+ZZIPqLT70Ryw7YWyyfpnoEEGwyOtJYsFdnDRRioc4uTQImV1OLBp8TIO/Z2AHo8V3/Vf9dkTN4xhycrOAWg8v3ReDFS42lkKw+Rw6VEdA4jXifaG304=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744221585; c=relaxed/simple;
	bh=foPbQftCwid7nEeC2q1n/JJulAsrhauYfRD3fATL6QA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bt5X4Nx69gclCyuc5EYWlHlbLBfD+NLO42Ok9FvbBqAmYHcSWthI96riRhw+gxRrbysUfm7599IvhyueU6D9kxQ7jqK1s3Poo6EsPKWGimtYeBWcKWJW7AXFjiINk37fnwvJTKgKFFrWpKl09gg6WRxRNlYtTI6BztN37A+UXGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=GS5JVGES; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=PqHmCLbV; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=iYzwSlYo; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=x16m8ALg; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="GS5JVGES";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="PqHmCLbV";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="iYzwSlYo";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="x16m8ALg"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id E540F1F38D;
	Wed,  9 Apr 2025 17:59:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1744221581; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8uIjmt9EIXrrPV7ZfNiHCpT9Mu9CfLBQs+NakOf5it4=;
	b=GS5JVGESpF8IRTypl7/cyIQyOUPnpMjxqdi48AE99RrFrby1R32DXkwBwA1sxP+78wsF0O
	SeVButj4LPuL1e0+lTN6XUU9Guc5VUXcSuIh4Q7Rq4ij5pnljfRLnVkVQhJUPzORMLQmpr
	4GOiCBmauyy2/TUBmF0qkukhlaFB9So=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1744221581;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8uIjmt9EIXrrPV7ZfNiHCpT9Mu9CfLBQs+NakOf5it4=;
	b=PqHmCLbV+HONcEYXX2ZssPtEGKSBdGR6zr6z+T7t7MCOZJRQ7GY1ws6Nheo/ZDpcpjo9QE
	ohCZPPlRtvvSDWCg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1744221580; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8uIjmt9EIXrrPV7ZfNiHCpT9Mu9CfLBQs+NakOf5it4=;
	b=iYzwSlYolKCadtoib3hQqpYPGmDDduYp3MNUfV1gDLBlGOWwjndKAFXwkbjA9LplfAR01C
	vDRoWKRGSLzpnes36GxQG3ozTRVoPujr4Ie42xZQRM4I+DeXxD+GnFf1LXcjV5sMbB+/3U
	ROWKEQPx2mXe/KTgotpOK38GrZcof7Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1744221580;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8uIjmt9EIXrrPV7ZfNiHCpT9Mu9CfLBQs+NakOf5it4=;
	b=x16m8ALgiCffOeelURbinsYUpFSqXzcPSaVGfyysINhZq+yA7/L9NmFWvmXl2YIpOV+Wpd
	a1kBOKsxey0N0yDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D3D99137AC;
	Wed,  9 Apr 2025 17:59:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id vwZ1M4y19meWFAAAD6G6ig
	(envelope-from <dwagner@suse.de>); Wed, 09 Apr 2025 17:59:40 +0000
Date: Wed, 9 Apr 2025 19:59:36 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: Chaitanya Kulkarni <kch@nvidia.com>, linux-block@vger.kernel.org,
	"asewhichexercisesthisinterface."@fluorine
Subject: Re: [PATCH blktests v2 3/4] nvme/060: add test nvme fabrics target
 resetting during I/O
Message-ID: <4f62bf2f-1512-4d5d-808e-b257adf29eb4@flourine.local>
References: <20250408-test-target-v2-0-e9e2512586f8@kernel.org>
 <20250408-test-target-v2-3-e9e2512586f8@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250408-test-target-v2-3-e9e2512586f8@kernel.org>
X-Spam-Level: 
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_TLS_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	TO_DN_SOME(0.00)[]
X-Spam-Score: -4.30
X-Spam-Flag: NO

On Tue, Apr 08, 2025 at 06:25:59PM +0200, Daniel Wagner wrote:
> +requires() {
> +	_nvme_requires
> +	_have_loop
> +	_require_nvme_trtype_is_fabrics
> +	_have_kernel_option NVME_TARGET_DEBUGF

Typo: s/NVME_TARGET_DEBUGF/NVME_TARGET_DEBUGFS/
