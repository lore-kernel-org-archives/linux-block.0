Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C30002C85D
	for <linux-block@vger.kernel.org>; Mon, 18 Mar 2024 11:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710760921; cv=none; b=ja+s1roATjrquGIgA0BQkxTp2rlcrP7QZEYkYaWrKA39yxB147OdQjspervR76tZEoJ5j4cP4Zhng+NFYvp8MZARcogyzBWGU1n0SgqLiXCM9SDWuebmpWR24OLi5Pf26IppP8mGxHy6tQmc6qSRojpssKGdx28Tg+exkMw1uDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710760921; c=relaxed/simple;
	bh=xyDiAoO1HQWO4tJreiq3N0r6YS1UZX2dwO6bh5L6qhY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KkBWYUyTbIh+9HY++2Ec8U10sa2q8axVW0ciGyvFOXVXX24I4m40KDLSqv0WRK2u3ZmuXwIq087tDW9Io7PY0kMwwuxbvy7XR57dZKNMx4K8pnJnlua4fo7uRiPEU3iC9OZbx8ycmhepClmjntgSLIgg2A5PX8AH5gMXq8VOoCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Olz9khKr; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=MN9oiW/+; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Olz9khKr; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=MN9oiW/+; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Olz9khKr";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="MN9oiW/+";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Olz9khKr";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="MN9oiW/+"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id F34055C45E;
	Mon, 18 Mar 2024 11:21:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1710760918; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xyDiAoO1HQWO4tJreiq3N0r6YS1UZX2dwO6bh5L6qhY=;
	b=Olz9khKrXFnF9txCih6MQ95RWJzqLlYSK+ZcOI8SPlZBZLX5etRL4C39D70rV/kIOFnvcx
	/FBuqej3G1EMsxWdnHsQDpb7V46V9NmfOEwHxvT4XE1kJR1WDxaVe+mWApvOHAAp4QEbYe
	JECp8PI1dyEuf/BKrpdkYYvmklfaAss=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1710760918;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xyDiAoO1HQWO4tJreiq3N0r6YS1UZX2dwO6bh5L6qhY=;
	b=MN9oiW/+FDRFZACWRmG8yJ67lVFwqibh4jCa50abYV0OPESR0+gbmXLiKKu59Luwdbthph
	xWw8IXGEGgyp6iBg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1710760918; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xyDiAoO1HQWO4tJreiq3N0r6YS1UZX2dwO6bh5L6qhY=;
	b=Olz9khKrXFnF9txCih6MQ95RWJzqLlYSK+ZcOI8SPlZBZLX5etRL4C39D70rV/kIOFnvcx
	/FBuqej3G1EMsxWdnHsQDpb7V46V9NmfOEwHxvT4XE1kJR1WDxaVe+mWApvOHAAp4QEbYe
	JECp8PI1dyEuf/BKrpdkYYvmklfaAss=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1710760918;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xyDiAoO1HQWO4tJreiq3N0r6YS1UZX2dwO6bh5L6qhY=;
	b=MN9oiW/+FDRFZACWRmG8yJ67lVFwqibh4jCa50abYV0OPESR0+gbmXLiKKu59Luwdbthph
	xWw8IXGEGgyp6iBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A92061349D;
	Mon, 18 Mar 2024 11:21:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id VwTgJ9Uj+GWkdAAAD6G6ig
	(envelope-from <dwagner@suse.de>); Mon, 18 Mar 2024 11:21:57 +0000
Date: Mon, 18 Mar 2024 12:21:57 +0100
From: Daniel Wagner <dwagner@suse.de>
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org, 
	Chaitanya Kulkarni <chaitanyak@nvidia.com>, Hannes Reinecke <hare@suse.de>
Subject: Re: [RFC blktests v1 00/10] Add support to run against real target
Message-ID: <bve2fx5ywd2efqgakhgtzhyc6tbthfoiqjcsgurdoapv6qisgr@5r4bus3ipqnh>
References: <20240318093856.22307-1-dwagner@suse.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240318093856.22307-1-dwagner@suse.de>
X-Spam-Score: 5.92
X-Spamd-Result: default: False [5.92 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_SPAM_SHORT(3.00)[0.999];
	 MIME_GOOD(-0.10)[text/plain];
	 RCPT_COUNT_FIVE(0.00)[5];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 NEURAL_SPAM_LONG(3.50)[1.000];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.97)[86.87%]
X-Spam-Level: *****
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Flag: NO

On Mon, Mar 18, 2024 at 10:38:45AM +0100, Daniel Wagner wrote:
> [1] https://lore.kernel.org/linux-nvme/23fhu43orn5yyi6jytsyez3f3d7liocp4cat5gfswtan33m3au@iyxhcwee6wvk/
> [2] https://github.com/hreinecke/nvmetcli/tree/rpc

The series is also available here:

https://github.com/igaw/blktests/commits/ext-hw/

which includes the mentioned Python script. As indicated it's just a WIP:

https://github.com/igaw/blktests/commit/ca1fe59b5ed67198228bcc017cfbbd25b797b868
