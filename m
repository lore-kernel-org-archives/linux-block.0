Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.130
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794475056;
	b=SwDFzG6COcKqZUXgTAW4PID89NJw+CWgAmLLxS9robCZqsDKEdGkIz1966Ac04tqn4V5
	 Q7D9toGLrbSCKyQCsUkjr1o41sSfII/KCFEnL46926W0jrr+6DbSXfNK6+R8K6qIDKrsr
	 NFOeXwWDqbOPaG3UnAqiOE06WmhpNqUCGOG4s5VSz0zPjxauXoZvQYFAGEfsDbJrzCjfv
	 UJDavOoW7orZBpyclkInzX5Dfa1Rc7hxMYfQUtWKZahlAxL3axIRsvryZpHjVoAm9BO0P
	 NA5rfbz0iyv2QfB7TQpPLpubGONmqfVV2WLgQFO0JNgM+OWlm/u1YkYBfjdivL/txKA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794475056;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Spam-Flag:X-Spam-Level:X-Spamd-Result:X-Spam-Score;
	bh=29b4/rpGvhobptMw/kABM3APQ8tfqrxkqYMWKjuPMvI=;
	b=2lGAdtDIsAsnCwBGnEJYZRc7nTr+O8Hls8ZV88dYEQ0D5puaOe3oDrhPEBEb/L5IZFLM
	 3ozF6KIprvPLeG071QhknDiTBtDhfpcsoo7wjl255+/LbTdcy9e/opVfivdcDVJMl/TIp
	 Q51HtS2f0C/iiNWHm73oyTnn4iL67X6+g7jN83vwuKSth/9yhJiWwgSV1VCRMfPK/JLU4
	 rrvlMkCMxLCTV6FTf1mfbqH1Q15sY7QhAT2CwpYMVDhXC2Kr1z4uodqArwXEuWwqEq2Sa
	 cxOUryqCnfP5PcZu1KobBkPa/ZBjKEfOQNWVLh3jdRCTTPH84TupR7z8lYIS5yNgEZw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.de;
	spf=pass smtp.mailfrom=suse.de;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=KTGVIk5P;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=dQSUvYPP;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=KTGVIk5P;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=dQSUvYPP;
	arc=none smtp.remote-ip=195.135.223.130
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47E3F606A321
	for <linux-block@vger.kernel.org>; Thu, 12 Nov 2026 09:17:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 47E3F606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=KTGVIk5P;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=dQSUvYPP;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=KTGVIk5P;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=dQSUvYPP
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 6FC0E21E73;
	Thu, 12 Nov 2026 09:17:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1794475054; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=29b4/rpGvhobptMw/kABM3APQ8tfqrxkqYMWKjuPMvI=;
	b=KTGVIk5P0kN0zFMRP5qToi/IUI6jwaZvHPpksntaERfKWrj/fY7CEDKce0jvluwQHobnZM
	DhyfCY4laq90Cc9t5pHoVkwLKx/dIJPAO5TlxDTdx+awAEcgkcSGPHx8asA+C2lvTzO1pv
	+YyRSxvLAk66qBiEEkyztbVBMPlYqAU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1794475054;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=29b4/rpGvhobptMw/kABM3APQ8tfqrxkqYMWKjuPMvI=;
	b=dQSUvYPPz+VhJLwdjvyFbanGlHthSrmW1Yk8bDIVOHFoOp3UoDQxhIJgTrwiba+GIvJ7gD
	jvseyVwAK6hOYfBw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1794475054; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=29b4/rpGvhobptMw/kABM3APQ8tfqrxkqYMWKjuPMvI=;
	b=KTGVIk5P0kN0zFMRP5qToi/IUI6jwaZvHPpksntaERfKWrj/fY7CEDKce0jvluwQHobnZM
	DhyfCY4laq90Cc9t5pHoVkwLKx/dIJPAO5TlxDTdx+awAEcgkcSGPHx8asA+C2lvTzO1pv
	+YyRSxvLAk66qBiEEkyztbVBMPlYqAU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1794475054;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=29b4/rpGvhobptMw/kABM3APQ8tfqrxkqYMWKjuPMvI=;
	b=dQSUvYPPz+VhJLwdjvyFbanGlHthSrmW1Yk8bDIVOHFoOp3UoDQxhIJgTrwiba+GIvJ7gD
	jvseyVwAK6hOYfBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3D2F4134A0;
	Thu, 12 Nov 2026 09:17:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 6fFqBi6E9WogeQAAD6G6ig
	(envelope-from <dwagner@suse.de>); Thu, 12 Nov 2026 09:17:34 +0000
Date: Thu, 12 Nov 2026 10:17:29 +0100
From: Daniel Wagner <dwagner@suse.de>
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: Re: [PATCH blktests 09/10] nvme: skip the tests which need a feature
 the remote target lacks
Message-ID: <c170db9b-6659-4fb2-a465-9c4adee0471c@flourine.local>
References: <20261104-nvme-target-control-v1-0-b31b40537bb4@suse.de>
 <20261104-nvme-target-control-v1-9-b31b40537bb4@suse.de>
 <avRD23enUQ1UfQpj@shinmob>
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <avRD23enUQ1UfQpj@shinmob>
X-Spam-Flag: NO
X-Spam-Level: 
X-Spamd-Result: default: False [-13.30 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -13.30

On Wed, Nov 11, 2026 at 07:33:36PM +0900, Shin'ichiro Kawasaki wrote:
> > +	features=" $("${nvme_target_control}" config --show-features) "
> > +	for feature in "$@"; do
> > +		if [[ "${features}" != *" ${feature} "* ]]; then
> 
> The line above is a bit confusing for me. I guess the line can be simpler as
> follows:
> 
> 		if [[ "${features}" =~ " ${feature} " ]]; then
> 
> May I ask you to confirm it?

Agreed, Klaus likes complex stuff, after he is German. An a more serious
note: though to keep the logic consistent it would be

        if [[ ! "${features}" =~ " ${feature} " ]]; then

The original line checks if the feature is missing so that the function
can skip the test.

I'll change it. Thanks!
