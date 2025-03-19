Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F0C1211486
	for <linux-block@vger.kernel.org>; Wed, 19 Mar 2025 09:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742376416; cv=none; b=YCZU5xock2Xmlek2Uwqo/LxOuR9tonM8s5w+WjIIHNBeSdfsmYEVsG/+5pUxzMvb2xagyA9foL2LJV1p6JJq3nQ3CL/110ExO/Bn7AVwHMqQUgu/MhJrokylni5s6yrj8YNRVJYNWJ2W/o4PPyND9FAjczdgWemqD/sBZDl2NMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742376416; c=relaxed/simple;
	bh=w21dImFrtX1DINiluvUquo6qN8kylDdGE3ulSIODhYA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i48bXAKAezsaFdPIzPWVHuUpoN/9m8JaSkHsmZHCsCW0XHaXKYcndtnXpCwLFPzwFb+MZAu1D0i6ZTs4K3myA0sFZ5QkK08XZHt9fXjomt12PpgJF0Yk0FWqUaoMcYZZMTtw5/CPdIiMsRubgX0RCdWCVEgx/n+hRfbdl266lzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=iOHv+HoM; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=jaEinwYq; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=iOHv+HoM; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=jaEinwYq; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="iOHv+HoM";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="jaEinwYq";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="iOHv+HoM";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="jaEinwYq"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 3CBCB1F82C;
	Wed, 19 Mar 2025 09:26:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1742376406; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YqoSFwhtbq+C2XQkjDBZC2+qlGYM+kj1RrUAXmprqRk=;
	b=iOHv+HoMl64eWn2cguNS3Nvj5qRgb24c/IBRqtQloWgPYevJuKkSzeI9RHJbCWAkY7rDHS
	Mqju2b32RJ4VunefqN2i+93PL6A3YSACFbPGCzQk0ZOp+bF5vTjvuostsyZzJT03h8QSP5
	f6srDZLDGyts5ojkVJDhHl1yjT5dRuI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1742376406;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YqoSFwhtbq+C2XQkjDBZC2+qlGYM+kj1RrUAXmprqRk=;
	b=jaEinwYq48BCVjqG2+3Ynai8s39pb8i/yerQU+PHPL3XnyyVaIcO9iGcfejRaDSCPKQQDq
	QjwHiWeLuGJZtKDQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1742376406; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YqoSFwhtbq+C2XQkjDBZC2+qlGYM+kj1RrUAXmprqRk=;
	b=iOHv+HoMl64eWn2cguNS3Nvj5qRgb24c/IBRqtQloWgPYevJuKkSzeI9RHJbCWAkY7rDHS
	Mqju2b32RJ4VunefqN2i+93PL6A3YSACFbPGCzQk0ZOp+bF5vTjvuostsyZzJT03h8QSP5
	f6srDZLDGyts5ojkVJDhHl1yjT5dRuI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1742376406;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YqoSFwhtbq+C2XQkjDBZC2+qlGYM+kj1RrUAXmprqRk=;
	b=jaEinwYq48BCVjqG2+3Ynai8s39pb8i/yerQU+PHPL3XnyyVaIcO9iGcfejRaDSCPKQQDq
	QjwHiWeLuGJZtKDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 22FC013726;
	Wed, 19 Mar 2025 09:26:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id P7MQBtaN2mdnSgAAD6G6ig
	(envelope-from <dwagner@suse.de>); Wed, 19 Mar 2025 09:26:46 +0000
Date: Wed, 19 Mar 2025 10:26:41 +0100
From: Daniel Wagner <dwagner@suse.de>
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc: Daniel Wagner <wagi@kernel.org>, 
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>, "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH blktests 2/3] nvme/060: add test nvme fabrics target
 resetting during I/O
Message-ID: <040089eb-aee4-4311-b1d1-d8d11d242804@flourine.local>
References: <20250318-test-target-v1-0-01e01142cf2b@kernel.org>
 <20250318-test-target-v1-2-01e01142cf2b@kernel.org>
 <4b2433c7-5291-4b44-b7c7-ec4521b0a3d8@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4b2433c7-5291-4b44-b7c7-ec4521b0a3d8@nvidia.com>
X-Spam-Level: 
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MISSING_XM_UA(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_COUNT_TWO(0.00)[2];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -4.30
X-Spam-Flag: NO

On Tue, Mar 18, 2025 at 08:40:39PM +0000, Chaitanya Kulkarni wrote:
> On 3/18/25 03:39, Daniel Wagner wrote:
> > Newer kernel support to reset the target via the debugfs. Add a new test
> > case which exercises this interface.
> >
> > Signed-off-by: Daniel Wagner<wagi@kernel.org>
> 
> Looks useful to me given that its a different code path in the target.

One thing I forgot to add a check if the feature is available. I think
the only way is to setup a target and see if the relevant file shows
up...

> do we have any testcaes similar for non-debugfs code path ?
> (don't remember at this point)

There is not direct way to trigger a target reset via a nvme command
yet. The upcoming TP8028 brings cross controller reset.

We have an indirect way to trigger a reset, via changing the number of
queues the target supports (this test case is already there).
