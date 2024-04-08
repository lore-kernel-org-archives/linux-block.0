Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F9C82260A
	for <linux-block@vger.kernel.org>; Mon,  8 Apr 2024 07:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712560654; cv=none; b=BF78qg6PC/HVsOvGX3Q6U5YNwlJt2Xfs+LeC0Qn9XeJNxzojFPY1u1xldGr7p6U8Zfcg9PKbdQ0IKzwsaWjNCEzwU2q/mJCwI/2l9ykemvIaROJYmAzZkvJAwq6ddF2S/nxT7TVL33GmUAfhHS8/4iyHu8/aLlXSkqoIBCGAG44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712560654; c=relaxed/simple;
	bh=TZ1ToEDP7w4Vc/bVEZMhqhuGwUwJd4h0e1llrDVL27Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IOfffCMGgeIK+DM5a8RQ5/5fXtDj6Ty9PPMtts1fxlG0dNT9LV4svp8cbyjmgCvhBxTRyJzanmqw/ob5kNS+ft1fMhfdUyRDphuXc6vdQg1ZZCu8FGL8sdOal28z8w8ynW6zfGS+Rjr+cycMtObyAJwokYEPxM9VW/VueSKeBVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ko38C+/h; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=qXce9Ycr; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ko38C+/h; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=qXce9Ycr; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ko38C+/h";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="qXce9Ycr";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ko38C+/h";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="qXce9Ycr"
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 4AD9B2257C;
	Mon,  8 Apr 2024 07:17:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1712560649; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tMOmSgPBwBpQB0j4PMtspk2iaIgyaahEJrJpPJL2yro=;
	b=ko38C+/heRpKaKD/xIPaXufvs2q64rZLYgRPJfAWjb9IEzGMYaHYams3KoIxgUZHqSR3sk
	q5M1dNz36ZGT5pB/6SRhstk2roOBQXnzUm/ccj4N9xtUWqJsqQ3tGSvUdSY4dhog/L92az
	g8lgXEsXcboH1U0y0dhJhts3OxguGkY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1712560649;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tMOmSgPBwBpQB0j4PMtspk2iaIgyaahEJrJpPJL2yro=;
	b=qXce9YcruaOQDcZ+HGBFjqs2ItXYLGPJTtToyWJFk+o0M3S2kPEWZX3YK2eCUOPrMW6b2x
	agGE71nnSqgarpDA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b="ko38C+/h";
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=qXce9Ycr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1712560649; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tMOmSgPBwBpQB0j4PMtspk2iaIgyaahEJrJpPJL2yro=;
	b=ko38C+/heRpKaKD/xIPaXufvs2q64rZLYgRPJfAWjb9IEzGMYaHYams3KoIxgUZHqSR3sk
	q5M1dNz36ZGT5pB/6SRhstk2roOBQXnzUm/ccj4N9xtUWqJsqQ3tGSvUdSY4dhog/L92az
	g8lgXEsXcboH1U0y0dhJhts3OxguGkY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1712560649;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tMOmSgPBwBpQB0j4PMtspk2iaIgyaahEJrJpPJL2yro=;
	b=qXce9YcruaOQDcZ+HGBFjqs2ItXYLGPJTtToyWJFk+o0M3S2kPEWZX3YK2eCUOPrMW6b2x
	agGE71nnSqgarpDA==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 34C8613A92;
	Mon,  8 Apr 2024 07:17:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id VDV6DAmaE2brEAAAn2gu4w
	(envelope-from <dwagner@suse.de>); Mon, 08 Apr 2024 07:17:29 +0000
Date: Mon, 8 Apr 2024 09:17:28 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: Yi Zhang <yi.zhang@redhat.com>, 
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH blktests 1/2] nvme/011: fix filename path
Message-ID: <abhsofvd6d4bsguc2m6zvl53i33vcnm5d2qve366ym6wzcofei@kn76k736ywxd>
References: <20240407031708.3945702-1-yi.zhang@redhat.com>
 <gawy4jjbt746lqhpeoouru4ent5wojuo3vcb52q2zxfxcyw756@2ecxcxkjzgbb>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <gawy4jjbt746lqhpeoouru4ent5wojuo3vcb52q2zxfxcyw756@2ecxcxkjzgbb>
X-Spam-Level: 
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-2.99)[99.96%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	FROM_HAS_DN(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:98:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	MISSING_XM_UA(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_TLS_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,imap2.dmz-prg2.suse.org:helo,imap2.dmz-prg2.suse.org:rdns]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 4AD9B2257C
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Score: -4.00


On Mon, Apr 08, 2024 at 04:02:51AM +0000, Shinichiro Kawasaki wrote:
> On Apr 07, 2024 / 11:17, Yi Zhang wrote:
> > Fixes: e55c4e0 ("nvme: don't assume namespace id")
> > Signed-off-by: Yi Zhang <yi.zhang@redhat.com>
> 
> Applied. Thank you for catching this.
> 
> I found same mistake in nvme/013 and 014 also. Fixed them as another commit.

Sorry about that. Hmm, but why did these test pass at all? I'll look
into it, hopefully we can make them a bit more robust.
