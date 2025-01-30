Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F01F13FEE;
	Thu, 30 Jan 2025 15:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738250740; cv=none; b=lXmKn/UcE5W/IbkHk9PtONIV/PGf4t1BXt77bGZRffP01vyjJ64azbb9LodGNkkqDS9oqZnM4Ml9Mnco/z1cuXyWU7aJqKKC6x+nAdM8zC8hxyW3G4o9G4Fs/3o55WsQZC2OZEvHLxg103R+2GW1ycNSYbW68vfczW+irMLNW1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738250740; c=relaxed/simple;
	bh=5jPWKLNesjifMXdgjs+g2wuSE6mSbvzJyPlTCh9k4bs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fnEdHnmcstH+F4xqitff8xyWU3IiEl7RV8l7VrNBgmeRVMi15BhNb46xM+Pu+7JRYt2JvrzHPEogu4JXn0bP7VkTRG6/64cKjFNb8ScYGmrwYkwJhEztKV/1ncPwJ3tx/YL+oLSAhkC1zWbSb9ldTgqetfeD3B5CzCL8JeEF/mY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=G/S331RP; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=BeuH8oCI; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=G/S331RP; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=BeuH8oCI; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="G/S331RP";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="BeuH8oCI";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="G/S331RP";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="BeuH8oCI"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 479892117F;
	Thu, 30 Jan 2025 15:25:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1738250736; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QXqnGoRaI66tmMlBOUK4wmzdfIDwO2FaFNK6NEuhUPU=;
	b=G/S331RPzqeN8RLclPgCZBvBthOz9gB0ZitX2Gu7+lqZBITnB+iVcui5MiN0z6054kMZBJ
	Y0w3l7l4GvrqnG9F10YFNzG1AomoaKlytP4D/FkYjh/G8Xo7s07rmyaUPealClXSDO+Apy
	mcblW5qFWlKL7U7Ik2gyZpv3NQK+3qg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1738250736;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QXqnGoRaI66tmMlBOUK4wmzdfIDwO2FaFNK6NEuhUPU=;
	b=BeuH8oCIrs5fkeTJQo5zyGo2q6mVspG5ylgU7tjnLP6tQ9TxyUfBBvZkA1p2+pIaWKDzrW
	Me9Q9u8TRgnZbbAg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b="G/S331RP";
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=BeuH8oCI
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1738250736; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QXqnGoRaI66tmMlBOUK4wmzdfIDwO2FaFNK6NEuhUPU=;
	b=G/S331RPzqeN8RLclPgCZBvBthOz9gB0ZitX2Gu7+lqZBITnB+iVcui5MiN0z6054kMZBJ
	Y0w3l7l4GvrqnG9F10YFNzG1AomoaKlytP4D/FkYjh/G8Xo7s07rmyaUPealClXSDO+Apy
	mcblW5qFWlKL7U7Ik2gyZpv3NQK+3qg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1738250736;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QXqnGoRaI66tmMlBOUK4wmzdfIDwO2FaFNK6NEuhUPU=;
	b=BeuH8oCIrs5fkeTJQo5zyGo2q6mVspG5ylgU7tjnLP6tQ9TxyUfBBvZkA1p2+pIaWKDzrW
	Me9Q9u8TRgnZbbAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3477B1366F;
	Thu, 30 Jan 2025 15:25:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id /PP1C/CZm2cXBQAAD6G6ig
	(envelope-from <dwagner@suse.de>); Thu, 30 Jan 2025 15:25:36 +0000
Date: Thu, 30 Jan 2025 16:25:35 +0100
From: Daniel Wagner <dwagner@suse.de>
To: Christoph Hellwig <hch@lst.de>
Cc: Daniel Wagner <wagi@kernel.org>, Keith Busch <kbusch@kernel.org>, 
	Jens Axboe <axboe@kernel.dk>, Sagi Grimberg <sagi@grimberg.me>, Ming Lei <ming.lei@redhat.com>, 
	James Smart <james.smart@broadcom.com>, Hannes Reinecke <hare@suse.de>, linux-nvme@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org
Subject: Re: [PATCH 1/3] nvme-tcp: rate limit error message in send path
Message-ID: <216ab5ef-1c8b-4f3e-8a1a-f11e28994620@flourine.local>
References: <20250128-nvme-misc-fixes-v1-0-40c586581171@kernel.org>
 <20250128-nvme-misc-fixes-v1-1-40c586581171@kernel.org>
 <20250129060534.GA29266@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250129060534.GA29266@lst.de>
X-Rspamd-Queue-Id: 479892117F
X-Spam-Level: 
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	MISSING_XM_UA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.51
X-Spam-Flag: NO

On Wed, Jan 29, 2025 at 07:05:34AM +0100, Christoph Hellwig wrote:
> On Tue, Jan 28, 2025 at 05:34:46PM +0100, Daniel Wagner wrote:
> > If a lot of request are in the queue, this message is spamming the logs,
> > thus rate limit it.
> 
> Are in the queue when what happens?  Not that I'm against this,
> but if we have a known condition where this error is printed a lot
> we should probably skip it entirely for that?

The condition is that all the elements in the queue->send_list could fail as a
batch. I had a bug in my patches which re-queued all the failed command
immediately and semd them out again, thus spamming the log.

This behavior doesn't exist in upstream. I just thought it might make
sense to rate limit as precaution. I don't know if it is worth the code
churn.
