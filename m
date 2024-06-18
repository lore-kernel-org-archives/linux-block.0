Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 147621E53A
	for <linux-block@vger.kernel.org>; Tue, 18 Jun 2024 06:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718692001; cv=none; b=Xexi5wpUBhH7MGKBqGr6sLLsEGZY1mV2BMdug6iiDWjF9QKlvMMwZXUQjCte/qNW00H2Et6aAJX0PFgxmgqQnRDX1rAU1xX+mGvZGL32mPoc6bSKAHxdJnV/od2xRbhjr1awRaOcFN3vOe7s82eLBzBCDiWsHNywCcHnKC2w9t8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718692001; c=relaxed/simple;
	bh=ORrXPEfpl2xfCsPTesnMVcBVAmnwwqciKq5ebwjAytY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dwjUH9qvEC7wvYKDHeIGzmV6TSNixNZCBCm042N2pI+bQlwpz83mNDl/j6nrXtVGCD6b7OC1IVGWQihCuGC4w6jcZzrPrwvvE9BCpBHXlXaQh5qbqVK4augA7RoAEp0KKxEnPr9NA0DxpfoGYs/Poq/fgYo82CUga4zBlXeOuys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Va/xqwod; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=I39Jev6E; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Va/xqwod; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=I39Jev6E; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Va/xqwod";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="I39Jev6E";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Va/xqwod";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="I39Jev6E"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 3B5DA227A2;
	Tue, 18 Jun 2024 06:26:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1718691998; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3tfX5tiJZsH1uIItuRiPycHAkawcZY4G245vsmcwEcM=;
	b=Va/xqwodyVllk0jjTYOcPyrmLhuZeqSn2inhTZr+CzHfhWkxcc4fcgtq2D3M0Tw6vWZhz5
	kexBKf4IPHQjeyczWG7MaSkm/k5Ahz5OBtNsbYGVIWzPdrpgnJCJ+OVRxY6iewbvi1qv/U
	6MXxhQITnDsl7kTvut390fTrFPWIYWU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1718691998;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3tfX5tiJZsH1uIItuRiPycHAkawcZY4G245vsmcwEcM=;
	b=I39Jev6EpvEKA2c0PSUfrB7GqCUxq1jmpteZz4MFo64a5Ts8fM80TKKahzcqAPMEAo+CkG
	fXyX/Yr2TQrroCCQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1718691998; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3tfX5tiJZsH1uIItuRiPycHAkawcZY4G245vsmcwEcM=;
	b=Va/xqwodyVllk0jjTYOcPyrmLhuZeqSn2inhTZr+CzHfhWkxcc4fcgtq2D3M0Tw6vWZhz5
	kexBKf4IPHQjeyczWG7MaSkm/k5Ahz5OBtNsbYGVIWzPdrpgnJCJ+OVRxY6iewbvi1qv/U
	6MXxhQITnDsl7kTvut390fTrFPWIYWU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1718691998;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3tfX5tiJZsH1uIItuRiPycHAkawcZY4G245vsmcwEcM=;
	b=I39Jev6EpvEKA2c0PSUfrB7GqCUxq1jmpteZz4MFo64a5Ts8fM80TKKahzcqAPMEAo+CkG
	fXyX/Yr2TQrroCCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 288E01369F;
	Tue, 18 Jun 2024 06:26:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 3sOaCZ4ocWadXgAAD6G6ig
	(envelope-from <dwagner@suse.de>); Tue, 18 Jun 2024 06:26:38 +0000
Date: Tue, 18 Jun 2024 08:26:37 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>, 
	Ofir Gal <ofir.gal@volumez.com>, "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, 
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH blktests] md: add regression test for "md/md-bitmap: fix
 writing non bitmap pages"
Message-ID: <tu77vp6rzu6spahkzost65igv22bmg24x5l5npgyljwdekbn45@hsswq7akbdpo>
References: <20240613123019.3983399-1-ofir.gal@volumez.com>
 <cnaunh75p4p45e4hgdaeaqry6whwdc2pqatil5v3oxjitwobda@p2oqftzlwv2r>
 <34ee55e8-a23c-4e7e-b897-cfbcc8337136@volumez.com>
 <zbeftlk6oti6uh5wx6m5ijvlvjv3xpxoqa6pj6mlasdr32eqfm@vyc5i3gyyj3s>
 <1f245507-fc7d-4361-8f65-0015fe0de239@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1f245507-fc7d-4361-8f65-0015fe0de239@nvidia.com>
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.995];
	MIME_GOOD(-0.10)[text/plain];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Score: -3.80
X-Spam-Level: 

On Tue, Jun 18, 2024 at 04:41:22AM GMT, Chaitanya Kulkarni wrote:
> On 6/17/2024 6:24 PM, Shinichiro Kawasaki wrote:
> >> nvme-tcp is used as the network device, I'm not sure it's related to
> >> the nvme test group. What do you think?
> > I see... The bug is in md sub-system, then it's the better to have the new test
> > case in the new md test group. To avoid the cross reference, the nvmet related
> > helper functions should move from tests/nvme/rc to common/nvmet, so that this
> > test/md/001 can refer them. This will be another separated, preparation patch.
> > 
> > To nvme experts: If you have comments on this, please chime in.
> 
> no cross references please, above suggestion seems reasonable, however
> I'd like to see actual prep patch before I comment further ..

Splitting the host from the target code in rc kind makes sense to me. I
am fine with moving the nvmet code to common.
