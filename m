Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C24FC231C91
	for <linux-block@vger.kernel.org>; Thu,  7 Aug 2025 07:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754551168; cv=none; b=uHUoqnf6mGr+4mrRgeJsJaxNeNKa8E31cFKhm0r1b698gziHBzxGDW/r2owPfGX2jX6nzhJ63jGhm6lRFgLTbcHZx/0/xz3aPl4FmiWs9h50ikxRypc7+uftFmQRDLrCkN/YGvLUzGojGBIq+S01Z6cur1H5+kUgFm8qFRFBtjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754551168; c=relaxed/simple;
	bh=P2gSR1aLw59U4sqMXOhZY6Vgfj7g8iKPjxIPsUuA0P8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dWOhcNVSjj6iZs0OgcXbaf+6NI8Bzrs5O4WauSLEHNvsgEH1IwAVhQV3vtaM22ukmuGDEdO3AnCMzc6CndmlhwyWy8p4UGalqpCXi0cwAmx9C5eHpiL6x3FRYaneg17hWkRf74bzApt85z5c1RDMiWFLflf9pAyQpjN7coFk/MQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=FOJxSC7z; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=QZg+PxFg; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=RAfJhFuC; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=lY2gJQbn; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="FOJxSC7z";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="QZg+PxFg";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="RAfJhFuC";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="lY2gJQbn"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id B4A1B33C79;
	Thu,  7 Aug 2025 07:19:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1754551163; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eLTKkM9X+h1vSlLK1ga+n6ZzEZYUtbam/CrQYcayB5w=;
	b=FOJxSC7zGyCrvj8vxuhgICa+/ruIOTxJiTJsAUH9+L0qIhuj72AifnM6qa0L/7mCs78RBw
	t/UTmAVt5cAgrzmTsWRnrZWVpLXF9HTeHIhCLLXQ8jrX5eQfrDdW6sEbKJlccEq4+mgbBB
	SX4Zhy65i01jH8WWgqkn1X9KnGvnhTs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1754551163;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eLTKkM9X+h1vSlLK1ga+n6ZzEZYUtbam/CrQYcayB5w=;
	b=QZg+PxFgXQw9Um9Xh9/LwUwACUTD2IhUJcpoi9gBZnCwMXh0YPciUjq55oA47mP53gq2w4
	u04wtZEP8dCFCYBg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1754551162; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eLTKkM9X+h1vSlLK1ga+n6ZzEZYUtbam/CrQYcayB5w=;
	b=RAfJhFuCEq8++cmJU6YyWtl/iL/79g0/W5fcUDyMphuR5wW0+s/6YMu5clCzcgQI/h5Ei1
	jhLCnG/umEjg9/ff4eKHCZmoXcpSrgKLILattR5OC1o6vbT5MU4e0JavqwB9fqIh72BZlz
	HDP/4Rknt6eCYMAaJ0aN1Uq5ntIL9AU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1754551162;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eLTKkM9X+h1vSlLK1ga+n6ZzEZYUtbam/CrQYcayB5w=;
	b=lY2gJQbnPkglW94gaAuw5FPWa/DsnU5Wn9ntzCqBFSFmJBxZwP6YXhfZ9Jw3Zbm2T2MoLW
	35d9N77Y/OmI53Dw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A1F9413969;
	Thu,  7 Aug 2025 07:19:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id einYJnpTlGhKEwAAD6G6ig
	(envelope-from <dwagner@suse.de>); Thu, 07 Aug 2025 07:19:22 +0000
Date: Thu, 7 Aug 2025 09:19:22 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Mohamed Khalfella <mkhalfella@purestorage.com>
Cc: Yi Zhang <yi.zhang@redhat.com>, Christoph Hellwig <hch@lst.de>, 
	Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>, 
	Keith Busch <kbusch@kernel.org>, Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>, 
	Hannes Reinecke <hare@kernel.org>, Maurizio Lombardi <mlombard@redhat.com>, 
	Jens Axboe <axboe@kernel.dk>, Randy Jennings <randyj@purestorage.com>, 
	linux-nvme@lists.infradead.org, linux-block <linux-block@vger.kernel.org>, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvmet: exit debugfs after discovery subsystem exits
Message-ID: <3f440533-8feb-49bb-8dde-6ae520b81d39@flourine.local>
References: <20250807053507.2794335-1-mkhalfella@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250807053507.2794335-1-mkhalfella@purestorage.com>
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:email,flourine.local:mid,purestorage.com:email]
X-Spam-Flag: NO
X-Spam-Level: 
X-Spam-Score: -4.30

On Wed, Aug 06, 2025 at 10:35:07PM -0700, Mohamed Khalfella wrote:
> Commit 528589947c180 ("nvmet: initialize discovery subsys after debugfs
> is initialized") changed nvmet_init() to initialize nvme discovery after
> "nvmet" debugfs directory is initialized. The change broke nvmet_exit()
> because discovery subsystem now depends on debugfs. Debugfs should be
> destroyed after discovery subsystem. Fix nvmet_exit() to do that.
> 
> Reported-by: Yi Zhang <yi.zhang@redhat.com>
> Closes: https://lore.kernel.org/all/CAHj4cs96AfFQpyDKF_MdfJsnOEo=2V7dQgqjFv+k3t7H-=yGhA@mail.gmail.com/
> Fixes: 528589947c180 ("nvmet: initialize discovery subsys after debugfs is initialized")
> Signed-off-by: Mohamed Khalfella <mkhalfella@purestorage.com>

Reviewed-by: Daniel Wagner <dwagner@suse.de>
