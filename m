Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABCF61BD9F2
	for <linux-block@vger.kernel.org>; Tue, 21 Jan 2025 12:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737461074; cv=none; b=VhrKz32XeaUq9Ab9qTy934W9TYKORICkzGfhV8oMWlBfJYLqsqQkXIrZyQn1Mv8Zv6ixkzPFnHGFy18dpj2liEHUC8GeGGVH/+dFm6aI9c6XjxQgBCf7pJ12O8OX1i75Evr32eWD4D1iTLKNwbuxALXrNHLcE07rkeMzFFHFZjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737461074; c=relaxed/simple;
	bh=7dr6k0nbiBKFQnSfCdAq0MjDS6T+8gVFFrEdV8YxTb4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ISSczhQKJzESpUDTlFOIaf+ZnAcc0NHe0ceW+R5noUmjMa3rDUYPxuSFkoUO6sN8Ow/jXPbBLnV14qISojwYo+BDgw/nYfSg6pbs2fh9kRa/vIuZ0DaHqjbAzzlrGfkLiwQy7PRo8IUbAnVTVNgr1SOrxcBPMeJFEuTcmMs3ZW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=V5h/JSxu; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=O59fcrQa; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=V5h/JSxu; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=O59fcrQa; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="V5h/JSxu";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="O59fcrQa";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="V5h/JSxu";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="O59fcrQa"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id D33A51F45A;
	Tue, 21 Jan 2025 12:04:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1737461070; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jKyAXeNoSbeoBgrXwkVABcMlUfGxS1S/DIaREarxS8o=;
	b=V5h/JSxuz2qHscve7BQ0vxNbw/2oUNZ4j6Y/5XyG+HfNw6aEcdo8XtUkXT0J5slj3CmgXB
	ZlmHmuSaY8OPI25cHCfFPbySxrFWi3D8nro/rFQeSuLWv9kCtfzvXes+hhp/26WwjBY5Th
	COIX7G6YhwAnzrqpPB3imZO/s+lId4A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1737461070;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jKyAXeNoSbeoBgrXwkVABcMlUfGxS1S/DIaREarxS8o=;
	b=O59fcrQagjukx0VVvlZ96Ur75EuXfBT/Thwyz8E6qFzDzESvyogfZKRnW1KoKDf/H+aFvS
	Hbc5aOuzoptiuvAw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1737461070; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jKyAXeNoSbeoBgrXwkVABcMlUfGxS1S/DIaREarxS8o=;
	b=V5h/JSxuz2qHscve7BQ0vxNbw/2oUNZ4j6Y/5XyG+HfNw6aEcdo8XtUkXT0J5slj3CmgXB
	ZlmHmuSaY8OPI25cHCfFPbySxrFWi3D8nro/rFQeSuLWv9kCtfzvXes+hhp/26WwjBY5Th
	COIX7G6YhwAnzrqpPB3imZO/s+lId4A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1737461070;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jKyAXeNoSbeoBgrXwkVABcMlUfGxS1S/DIaREarxS8o=;
	b=O59fcrQagjukx0VVvlZ96Ur75EuXfBT/Thwyz8E6qFzDzESvyogfZKRnW1KoKDf/H+aFvS
	Hbc5aOuzoptiuvAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C85E513963;
	Tue, 21 Jan 2025 12:04:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id MEHmME6Nj2cnGQAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 21 Jan 2025 12:04:30 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 86BD6A0889; Tue, 21 Jan 2025 13:04:30 +0100 (CET)
Date: Tue, 21 Jan 2025 13:04:30 +0100
From: Jan Kara <jack@suse.cz>
To: Andreas Hindborg <a.hindborg@kernel.org>
Cc: lsf-pc@lists.linux-foundation.org, linux-block@vger.kernel.org, 
	Jens Axboe <axboe@kernel.dk>, Matthew Wilcox <willy@infradead.org>, 
	Luis Chamberlain <mcgrof@kernel.org>, Miguel Ojeda <ojeda@kernel.org>
Subject: Re: [Lsf-pc] [LSF/MM/BPF TOPIC] Rust block layer abstractions and
 benchmark strategies
Message-ID: <w4gsgpfgz335cvyjjk5oaykl3wav7d2q4robxuw73pqkkxznlx@hgap3lzl3vbs>
References: <871pwwctcj.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <871pwwctcj.fsf@kernel.org>
X-Spam-Score: -3.80
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_COUNT_THREE(0.00)[3];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email]
X-Spam-Flag: NO
X-Spam-Level: 

Hi!

On Tue 21-01-25 12:13:48, Andreas Hindborg via Lsf-pc wrote:
> I would like to propose that we have a session on Rust in the block
> layer again this year. Specifically I would like to discuss some rather
> puzzling results I observe when I benchmark the C and Rust null block
> drivers. I did a write up of the challenges I face at [1]. The
> observations are not tied to rust, they also manifest in the C driver.

The results are indeed somewhat curious. One factor I didn't see addressed
in your blog is CPU scheduling. I've seen in the past cases where IO tasks
were getting migrated across cores leading to jumps in perfomance. Did you
try binding fio jobs to one CPU each?

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
