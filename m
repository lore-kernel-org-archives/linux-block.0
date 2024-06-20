Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CFE11946F
	for <linux-block@vger.kernel.org>; Thu, 20 Jun 2024 06:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718865360; cv=none; b=Lg3tOhYjlbh+GBLUnVoAqQZHSAHvbCTg8bz5HYjUUQe8Mms6/bf+Oc3fEnpYTeAl12azhyZLwtRRmYKdVSNd7d+AHUCi7V2mmaLSQFr8x9vHQUZ+o7hMvkUN7SeUdYQ4QNOgOxxUHfpcrXY8ZhR9o8HQhJ3ycOPFHzbLMpCoVgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718865360; c=relaxed/simple;
	bh=YrZdGP36brf10LZZAH3ynivpVa2l08u5AJJKCR631Kk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dTVusuJEAxlbD8VzdCUVFX+R004bpw/Eq+nqh8nCei3HQ5xwnEs+15Oy4mAjZ2KtkoqYLGD1UtF0f8CeJirvIIUYlTyAHeQQyNlzA05M5trOUovfyTySc0hvz39jsJu7HfNJq05j23hFTcznNB/WAaqmHnjuqdL/GqTVEkzU/f0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=VUvEirpI; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=cEDEkc7n; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=VUvEirpI; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=cEDEkc7n; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="VUvEirpI";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="cEDEkc7n";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="VUvEirpI";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="cEDEkc7n"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 2860B21A93;
	Thu, 20 Jun 2024 06:35:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1718865356; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=g2pgPTlCKPAPvO4GsArfFhSZ2SLNTihNRuzVg6k4aFQ=;
	b=VUvEirpI+Pa/KqY5Bt7oRq7PkepCup39LDxxT8YBnk51HOWUZC+SMCWw0teh1CZIxacO64
	mg8BHgdwIRB3BSgiPFyTkDNgtm3vfXQzlWj5ps8+HVZAqcRWlQ2zkOJLcUmw/9t3QkB/Fd
	iDblrDaSAIszPymysNtW1aY/83xJtoM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1718865356;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=g2pgPTlCKPAPvO4GsArfFhSZ2SLNTihNRuzVg6k4aFQ=;
	b=cEDEkc7nafqb32PtxqQXv+H5wbOfBhr/icF0d5J+WTfsw0ex75z9dJAQqK3FVZPERj2DSb
	clojvTHOLYuhJuAA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=VUvEirpI;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=cEDEkc7n
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1718865356; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=g2pgPTlCKPAPvO4GsArfFhSZ2SLNTihNRuzVg6k4aFQ=;
	b=VUvEirpI+Pa/KqY5Bt7oRq7PkepCup39LDxxT8YBnk51HOWUZC+SMCWw0teh1CZIxacO64
	mg8BHgdwIRB3BSgiPFyTkDNgtm3vfXQzlWj5ps8+HVZAqcRWlQ2zkOJLcUmw/9t3QkB/Fd
	iDblrDaSAIszPymysNtW1aY/83xJtoM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1718865356;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=g2pgPTlCKPAPvO4GsArfFhSZ2SLNTihNRuzVg6k4aFQ=;
	b=cEDEkc7nafqb32PtxqQXv+H5wbOfBhr/icF0d5J+WTfsw0ex75z9dJAQqK3FVZPERj2DSb
	clojvTHOLYuhJuAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 162101369F;
	Thu, 20 Jun 2024 06:35:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Dm50BMzNc2YsPgAAD6G6ig
	(envelope-from <dwagner@suse.de>); Thu, 20 Jun 2024 06:35:56 +0000
Date: Thu, 20 Jun 2024 08:35:55 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: shinichiro.kawasaki@wdc.com, chaitanyak@nvidia.com, kbusch@kernel.org, 
	sagi@grimberg.me, hch@lst.de, linux-nvme@lists.infradead.org, 
	linux-block@vger.kernel.org, venkat88@linux.vnet.ibm.com, sachinp@linux.vnet.ibm.com, 
	gjoyce@linux.ibm.com
Subject: Re: [PATCHv4 blktests] nvme: add test for creating/deleting file-ns
Message-ID: <rxeyn6susgjlguqg3jk7ntthjvhn6gt3meu4dcb5kchynz3b2e@uznnvlner6ri>
References: <20240619172556.2968660-1-nilay@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240619172556.2968660-1-nilay@linux.ibm.com>
X-Rspamd-Queue-Id: 2860B21A93
X-Spam-Score: -6.01
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-6.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	DWL_DNSWL_MED(-2.00)[suse.de:dkim];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org

On Wed, Jun 19, 2024 at 10:55:02PM GMT, Nilay Shroff wrote:
> +		truncate -s "${NVME_IMG_SIZE}" "$(_nvme_def_file_path).$i"
> +		uuid="$(uuidgen -r)"

This adds a new dependency on an external tool. It should be mentioned
in the README and added to the list of tools to check for:
_check_dependencies(). Alternatively you could skip the test if the tool
is not available. Anyway the rest looks good.

Reviewed-by: Daniel Wagner <dwagner@suse.de>
