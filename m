Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F3EB4C96
	for <linux-block@vger.kernel.org>; Tue, 15 Apr 2025 08:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744704982; cv=none; b=gKeCthceWcnUcO+NhQjaPWutro8RVOlaQTHkAmZrK2gmjN7HwN3DAdLvAGKu3uqM3aG8tre2qUVUTVE1VHfvS7twPqKVGAH3Oiq5htYjSIiZhc8k7e+PnbfcX/WSHR17VfhD/Fx7P/2a8G9RMUWjz/fwzFt/sojQaCd+NU3w7M8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744704982; c=relaxed/simple;
	bh=5OoxoW3orsnaVnwtxT259mSMKM1XGKd+guHXCXtiOL0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UgxQXNAHrw6GuZ4IZoo3PrWiCUpYCBIn8T9i9BrceYB7WPtb+gZtqw0I6opw16KF40pCC8hDOfe1/nfPto84PkiJ/GA+qRp+5o4DfdCx+If6j/FByZ+SxsA1YLddE4hj1Uy5vSiiHz7IqEr6NEr3OBvdUvYpV9/hB0gFDhgKq74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=cXxkmjtS; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=28XXUxAO; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=cXxkmjtS; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=28XXUxAO; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="cXxkmjtS";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="28XXUxAO";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="cXxkmjtS";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="28XXUxAO"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 65FEF21172;
	Tue, 15 Apr 2025 08:16:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1744704979; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7Mp0ARAHq2WHkCUbVZuWedWjLysTtWize7COHMO2igY=;
	b=cXxkmjtS73KuthuXWAHYiSX+oPEVj9aNbm51Uy9kNoIdpabOtrdEXyyv8V/Gffytn/XzBr
	Zt5c6DeEaSplLrO+Lh+6RZBawcmlpXhnrKiNk8VgrVglhaZSK852DdsW4aEUgSdlqmbGS4
	SHHlqTu5CB0GtwmLwlbBUyPqMixBZ20=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1744704979;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7Mp0ARAHq2WHkCUbVZuWedWjLysTtWize7COHMO2igY=;
	b=28XXUxAOEN321IxKqKuxntK3P3R69ldQ7cte44IPlzf0hRniF/RwDerWrxsZPnONffDxS8
	VBXY97ljwOsT0XBQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=cXxkmjtS;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=28XXUxAO
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1744704979; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7Mp0ARAHq2WHkCUbVZuWedWjLysTtWize7COHMO2igY=;
	b=cXxkmjtS73KuthuXWAHYiSX+oPEVj9aNbm51Uy9kNoIdpabOtrdEXyyv8V/Gffytn/XzBr
	Zt5c6DeEaSplLrO+Lh+6RZBawcmlpXhnrKiNk8VgrVglhaZSK852DdsW4aEUgSdlqmbGS4
	SHHlqTu5CB0GtwmLwlbBUyPqMixBZ20=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1744704979;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7Mp0ARAHq2WHkCUbVZuWedWjLysTtWize7COHMO2igY=;
	b=28XXUxAOEN321IxKqKuxntK3P3R69ldQ7cte44IPlzf0hRniF/RwDerWrxsZPnONffDxS8
	VBXY97ljwOsT0XBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4D01F139A1;
	Tue, 15 Apr 2025 08:16:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id AdPOEdMV/mebPwAAD6G6ig
	(envelope-from <dwagner@suse.de>); Tue, 15 Apr 2025 08:16:19 +0000
Date: Tue, 15 Apr 2025 10:16:18 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: Daniel Wagner <wagi@kernel.org>, Chaitanya Kulkarni <kch@nvidia.com>, 
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH blktests v3 0/4] blktests: add target test cases
Message-ID: <f29df688-060d-4afa-9943-121c87988379@flourine.local>
References: <20250414-test-target-v3-0-024575fcec06@kernel.org>
 <e4227cqwlijfqvkquxk33p3frg7jbevkzsywkgvb45ol3oz4ps@yho4eeo5lzak>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e4227cqwlijfqvkquxk33p3frg7jbevkzsywkgvb45ol3oz4ps@yho4eeo5lzak>
X-Rspamd-Queue-Id: 65FEF21172
X-Spam-Level: 
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[99.98%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:dkim];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.51
X-Spam-Flag: NO

On Tue, Apr 15, 2025 at 07:37:40AM +0000, Shinichiro Kawasaki wrote:
> P.S. I noticed that some local variables are missing declarations, then I took
>      the liberty to add them.

Thanks!
