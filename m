Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82A2B368D64
	for <linux-block@vger.kernel.org>; Thu, 14 May 2026 10:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778754971; cv=none; b=tiTy6NdCR3HOierLcyglGX1DhHrKy4+Gu+/qFjrpPXrBaKm5BA5n6KOZSQfTg0QRSeJgbsh0frp+x5PSpSL43MZ+rJVYcweOSXwuocJM+uSfoqALxzFAnkdsFLdZhQZmAM4zQ8jTa2Cvgq/yDGITjjnhyaEJR0CqsCT2qnJIK5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778754971; c=relaxed/simple;
	bh=rKHpmPxYhFRHgkKexgek9cRFFXOhS4VXU66Zp2ml6zM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sZVJlrTZOrsrxiK2gYVE8Nl4vBzA7m4+phrWCKEPXCh0wlqEbZwWYdcuxqNo2Yw7idIsx0PDbOTRCEKEgR4Tv4sOFTLDN3KQVdkGe27CUA+Q3jA0DyFUTRlMfOZvw0eR8QTR/0vOZkqO96BvcmjBEQD5NF1Ise2AnqRK+b2NKD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=a9e1Uyxq; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=66a0tprP; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=a9e1Uyxq; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=66a0tprP; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="a9e1Uyxq";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="66a0tprP";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="a9e1Uyxq";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="66a0tprP"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 7F4795D20A;
	Thu, 14 May 2026 10:36:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1778754967; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VgqCevDZ+dMoMaMiYw8JCZe75b0ils6d78TIfdhDxnA=;
	b=a9e1UyxqvNxGg6NzRCDg7Zp8z+VY+PHkyB74OPw/A1rrHcrqvZAptDYtcKIDqFxASevvpH
	KGn4N29QfVgOsVOVLWo7J/2Xl+3hEH/IjOQK+hEV/6FHSUFLS9K3zUa8ovG0hmD8//YmhS
	M7sGiitTOB1TsKOXH/wmGvV6/TiFWJA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1778754967;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VgqCevDZ+dMoMaMiYw8JCZe75b0ils6d78TIfdhDxnA=;
	b=66a0tprPojvB5jAxoQ4JcnLGbDxd/LGAoj6nLqpXpS602otz5L6KdyVVxK4iq/nO70J25/
	UiInwBedPM/gloBQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=a9e1Uyxq;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=66a0tprP
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1778754967; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VgqCevDZ+dMoMaMiYw8JCZe75b0ils6d78TIfdhDxnA=;
	b=a9e1UyxqvNxGg6NzRCDg7Zp8z+VY+PHkyB74OPw/A1rrHcrqvZAptDYtcKIDqFxASevvpH
	KGn4N29QfVgOsVOVLWo7J/2Xl+3hEH/IjOQK+hEV/6FHSUFLS9K3zUa8ovG0hmD8//YmhS
	M7sGiitTOB1TsKOXH/wmGvV6/TiFWJA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1778754967;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VgqCevDZ+dMoMaMiYw8JCZe75b0ils6d78TIfdhDxnA=;
	b=66a0tprPojvB5jAxoQ4JcnLGbDxd/LGAoj6nLqpXpS602otz5L6KdyVVxK4iq/nO70J25/
	UiInwBedPM/gloBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6B60D593A9;
	Thu, 14 May 2026 10:36:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id FjyNGJelBWqbRwAAD6G6ig
	(envelope-from <dwagner@suse.de>); Thu, 14 May 2026 10:36:07 +0000
Date: Thu, 14 May 2026 12:36:02 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: Bart Van Assche <bvanassche@acm.org>, linux-block@vger.kernel.org, 
	Daniel Wagner <wagi@kernel.org>, John Meneghini <jmeneghi@redhat.com>
Subject: Re: [PATCH blktests 2/3] common/rc: add _echo() function to trace
 sysfs attribute writes
Message-ID: <089d3a05-d001-4614-b751-b840ea8e4d0a@flourine.local>
References: <20260513112326.584256-1-shinichiro.kawasaki@wdc.com>
 <20260513112326.584256-3-shinichiro.kawasaki@wdc.com>
 <a1668df1-a93a-442a-ae95-e015bcbeec17@flourine.local>
 <3ef4e2a4-c0ec-4040-a4c7-3687ed7e2d93@acm.org>
 <agWXr9Yntf4OiQ9e@shinmob>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <agWXr9Yntf4OiQ9e@shinmob>
X-Spam-Flag: NO
X-Spam-Score: -4.51
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 7F4795D20A
X-Spam-Level: 

On Thu, May 14, 2026 at 06:41:39PM +0900, Shin'ichiro Kawasaki wrote:
> Said that, this will not work when printf is used to write to
> sysfs/debugfs/configfs attributes. So, I'm tempted to Bart's idea to
> rename _echo() to _set_attr().

Indeed, my idea was to avoid prefixing all the echo with a _. Since this
doesn't work, Bart's idea to introduce explicit setters sounds like the
way to go. 
