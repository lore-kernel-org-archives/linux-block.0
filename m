Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C649E1EB2F
	for <linux-block@vger.kernel.org>; Tue, 21 Jan 2025 13:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737465515; cv=none; b=sQwmddiwc/uuyFlyv6mkJr7cO4F7rHkgRjT/hIkzTDX08bNQhYUebkWXGn8tHUq/dexfKaCvyWyQRrgl1dPDJ7BmVEia6KUi6MiXpoAvlOVwvn2ZSGC9DOuciv2GaSleTqH+ZRMqbSIlf38XLwL7mIYg6KgmIejW6AFf7ZZzCjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737465515; c=relaxed/simple;
	bh=uUcimig+9qvCXH7qormcU+iazZHaPQ+h9ZmO0JFjUZM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dBzN2lMWAqUj/38a29qaVDxTK4LGnWKN0kIjcLWYhHul2sIOHfuSELIZ8jBCp5nDfs4dMUkvXoQeFdr0ghLD2KHnuKbvfCPhMQnQVLSS/5zrDpKOguZ8tnTsV+iSl45NktX0Og0ow0/pYVHHAliIzCAG5Hbyy/biINee9uq/EK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=pQ9bQ27z; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=AG7/MDxv; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=pQ9bQ27z; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=AG7/MDxv; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="pQ9bQ27z";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="AG7/MDxv";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="pQ9bQ27z";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="AG7/MDxv"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id C4677211D4;
	Tue, 21 Jan 2025 13:18:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1737465511; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HIvrTZWK1gMSrcX/RsefTQejgOSRIpKJco3yHQS7tV0=;
	b=pQ9bQ27zPMfSNwbTWrLjWbCqrF//WyemngA/9JAeZzr7iRIpolYfYdgFhTFvnhsAYMcgKO
	kd4+zEjzKisVZii/YnMYHhz/lWsqxPpWcjKED+9X9lN+OnZmkOBZfCAi/KJEuXCteWukxp
	gQ8PdiE3FPOXdQBRWdh6YCMSe201G5I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1737465511;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HIvrTZWK1gMSrcX/RsefTQejgOSRIpKJco3yHQS7tV0=;
	b=AG7/MDxvEgHRuWiQeCg7euLFfMCiMd/lHt6SfQBKKMLxhaM6gs0G70WL7Vg/OfizgaXatr
	e/tHXZH7Yimph3BQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1737465511; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HIvrTZWK1gMSrcX/RsefTQejgOSRIpKJco3yHQS7tV0=;
	b=pQ9bQ27zPMfSNwbTWrLjWbCqrF//WyemngA/9JAeZzr7iRIpolYfYdgFhTFvnhsAYMcgKO
	kd4+zEjzKisVZii/YnMYHhz/lWsqxPpWcjKED+9X9lN+OnZmkOBZfCAi/KJEuXCteWukxp
	gQ8PdiE3FPOXdQBRWdh6YCMSe201G5I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1737465511;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HIvrTZWK1gMSrcX/RsefTQejgOSRIpKJco3yHQS7tV0=;
	b=AG7/MDxvEgHRuWiQeCg7euLFfMCiMd/lHt6SfQBKKMLxhaM6gs0G70WL7Vg/OfizgaXatr
	e/tHXZH7Yimph3BQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B3B241387C;
	Tue, 21 Jan 2025 13:18:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id pkXbK6eej2cwDgAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 21 Jan 2025 13:18:31 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 533EEA0889; Tue, 21 Jan 2025 14:18:31 +0100 (CET)
Date: Tue, 21 Jan 2025 14:18:31 +0100
From: Jan Kara <jack@suse.cz>
To: Andreas Hindborg <a.hindborg@kernel.org>
Cc: Jan Kara <jack@suse.cz>, lsf-pc@lists.linux-foundation.org, 
	linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>, 
	Matthew Wilcox <willy@infradead.org>, Luis Chamberlain <mcgrof@kernel.org>, 
	Miguel Ojeda <ojeda@kernel.org>
Subject: Re: [Lsf-pc] [LSF/MM/BPF TOPIC] Rust block layer abstractions and
 benchmark strategies
Message-ID: <v7yipdb5avbikov3xx3ipzroc4gvspjbga73mfm6omf4iv2233@glnhjelpl3gf>
References: <871pwwctcj.fsf@kernel.org>
 <pAX6FrMK2jF3_7cYCG-6vidZEz1v2Gey8Qwq1QJ18zbttR5hgHP7ziCajIo3_Gok8strlNhWaOLX0o5jIKDFCw==@protonmail.internalid>
 <w4gsgpfgz335cvyjjk5oaykl3wav7d2q4robxuw73pqkkxznlx@hgap3lzl3vbs>
 <87sepcba9s.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87sepcba9s.fsf@kernel.org>
X-Spam-Score: -3.80
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_COUNT_THREE(0.00)[3];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email,suse.cz:email]
X-Spam-Flag: NO
X-Spam-Level: 

On Tue 21-01-25 13:51:11, Andreas Hindborg wrote:
> "Jan Kara" <jack@suse.cz> writes:
> > On Tue 21-01-25 12:13:48, Andreas Hindborg via Lsf-pc wrote:
> >> I would like to propose that we have a session on Rust in the block
> >> layer again this year. Specifically I would like to discuss some rather
> >> puzzling results I observe when I benchmark the C and Rust null block
> >> drivers. I did a write up of the challenges I face at [1]. The
> >> observations are not tied to rust, they also manifest in the C driver.
> >
> > The results are indeed somewhat curious. One factor I didn't see addressed
> > in your blog is CPU scheduling. I've seen in the past cases where IO tasks
> > were getting migrated across cores leading to jumps in perfomance. Did you
> > try binding fio jobs to one CPU each?
> 
> Yes, I am pinning the io jobs to cores with fio options `cpus_allowed=0-<jobs>`
> and `--cpus_allowed_policy=split` so I get 1 job per core.
> 
> The kernel is configured with PREEMPT_NONE=y.

Ah, OK. In that case no great ideas from me. Since you've mentioned that
when you get to slow / fast case the performance tends to stay there,
perhaps you could use perf to profile the slow / fast case and see where's
the difference?

									Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
