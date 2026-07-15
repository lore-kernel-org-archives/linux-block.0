Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAAB5434E55
	for <linux-block@vger.kernel.org>; Wed, 15 Jul 2026 12:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784117560; cv=none; b=cmyFBq/gVbpKaLrrrQ5U6cyx+/5Fx3cO8xkIUAs3sx8rAt49LzrhMgn0tcZFwYoYd4VPo4XGkaeKX3OXS4M/L843RBeEishLg1jArOs2Vdow/XtXcglcDOYWJxb2b4eIiHe/rqOgkTd5Xx+o5Ky0tZPdzXCKchs8qjrWpdZFWas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784117560; c=relaxed/simple;
	bh=vnJNlOBmMgTLgQMXG7JD+scDursCtir3KG1H5wgQNX8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N8aOQgKrYZtKwZQ1+3g5iKwFWjoDIGtX2GJlV7/3zP6zbxflglzCIUs13wcg1SAvAAWcOWRQ4ECBpbPeKhu0RDBalQVN2w4Fi6FPHdohEIgk/5bRz8M7P4zsPsfcnb678Iejfmk8x37mH/XvCUdL6/AwnRyhvtrEG4u4MVztGRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=1YRLsYo8; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=GBNJfTvp; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=1YRLsYo8; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=GBNJfTvp; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="1YRLsYo8";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="GBNJfTvp";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="1YRLsYo8";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="GBNJfTvp"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id C58C8783B9;
	Wed, 15 Jul 2026 12:12:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1784117556; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=h3qCa6h/Jvlmbl1Ys+5fQfN3jSZxZGaoGH61HxHQNew=;
	b=1YRLsYo8r79BCIWJoZfm9IieU5v6JggzVTxHo+mCiP8xjmtS/gy7V1QfdUGL1F4b5mINsK
	r6k84SYqV5UXfB6Hj2xQ15GrXf+M/0y2Rw7vBQento+AfHXl6/Osq1onWpfR1VjvfJgQkS
	MGBc0T6enwj0sgqyE6Evgt1rY1lXbiM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1784117556;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=h3qCa6h/Jvlmbl1Ys+5fQfN3jSZxZGaoGH61HxHQNew=;
	b=GBNJfTvpEf8RwkWdcKSaMFHyzF6IpiBxvNZBVE3t89FxrKune0xp0VDJQSGutGwO58ZtHG
	us2FWwFJ3PGEaxAQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1784117556; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=h3qCa6h/Jvlmbl1Ys+5fQfN3jSZxZGaoGH61HxHQNew=;
	b=1YRLsYo8r79BCIWJoZfm9IieU5v6JggzVTxHo+mCiP8xjmtS/gy7V1QfdUGL1F4b5mINsK
	r6k84SYqV5UXfB6Hj2xQ15GrXf+M/0y2Rw7vBQento+AfHXl6/Osq1onWpfR1VjvfJgQkS
	MGBc0T6enwj0sgqyE6Evgt1rY1lXbiM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1784117556;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=h3qCa6h/Jvlmbl1Ys+5fQfN3jSZxZGaoGH61HxHQNew=;
	b=GBNJfTvpEf8RwkWdcKSaMFHyzF6IpiBxvNZBVE3t89FxrKune0xp0VDJQSGutGwO58ZtHG
	us2FWwFJ3PGEaxAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AD9BF779AD;
	Wed, 15 Jul 2026 12:12:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id HM8YKjR5V2rvQwAAD6G6ig
	(envelope-from <dwagner@suse.de>); Wed, 15 Jul 2026 12:12:36 +0000
Date: Wed, 15 Jul 2026 14:12:31 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: Re: [PATCH blktests 0/4] misc fixes
Message-ID: <8fb8b561-77d2-4192-8180-8ffbe283665f@flourine.local>
References: <20260713003906.21153-1-shinichiro.kawasaki@wdc.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260713003906.21153-1-shinichiro.kawasaki@wdc.com>
X-Spam-Flag: NO
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:email]
X-Spam-Level: 
X-Spam-Score: -4.30

On Mon, Jul 13, 2026 at 09:39:02AM +0900, Shin'ichiro Kawasaki wrote:
> These are miscellaneous fixes. They do not affect test results, but worth
> fixing.
> 
> Shin'ichiro Kawasaki (4):
>   check: fix exit status code handling
>   nvme/rc: use _set_attr() in _create_nvmet_passthru()
>   CONTRIBUTING: clarify that GPL-2.0 is not applicable
>   new: guide long command options

Looks good to me.

Reviewed-by: Daniel Wagner <dwagner@suse.de>
