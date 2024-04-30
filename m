Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51D96127E3F
	for <linux-block@vger.kernel.org>; Tue, 30 Apr 2024 09:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714469198; cv=none; b=KGwGLE0Zp8ueVYcW/+Uhu6Rm7DSJ7Lxia3OokW7NeLPBm5uekzPSWUr6tlH2sE5iLz4GFu8+Cxm6KzrUBgoeLvr49x/V66E6Cv9liMDFFqmy/cTMHFbnzhym+tCUp3x9jivYbLXyFn/KpdWv6hn6/0D0rGOvNV5zOLITQqJi7YI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714469198; c=relaxed/simple;
	bh=TTubVACS0LLkDjqSWLCcgxLZWnuUvQtG4r74brO7f98=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VVI2uUexL9BzeZ809y3/dtv3audPVWQ4d41LNPB90uSJxqxFsKiaVlDy8KXH/9aJGhSCBLvR8H6pBPRgpaL8E6u+i+WhiCZ3h4hU6kUz+OeuYCxLo404dWWmT5kwrCZmjY103SjylnN0+n4ndbF0ygT+yxDhy68tLqjqbHEFcwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=f/QCIhWZ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=GEkEf9Jp; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=f/QCIhWZ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=GEkEf9Jp; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="f/QCIhWZ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="GEkEf9Jp";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="f/QCIhWZ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="GEkEf9Jp"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 52F161F7B4;
	Tue, 30 Apr 2024 09:26:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1714469194;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xO4k9nXPK+IndlDMk8BQ0nzkGaUH7xSxSdK3nRCQV+8=;
	b=f/QCIhWZho7tjnkJG96Nirz0xav8b4sNO7+tLpJuo659ea711Mwn23u9GLdKaQXBisvF0d
	zuVV0J5t0ltBDCAnDqCi5Q2Uj9DILXzcWr5dcUoiBxE8Z6jcKfcWiNJludMssalqHrZsef
	iY2SgZWknQmAzTdtZKpnPRYHy0q9fvw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1714469194;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xO4k9nXPK+IndlDMk8BQ0nzkGaUH7xSxSdK3nRCQV+8=;
	b=GEkEf9JpxbJ0aQ359eixjn7NPDBOCRWGk0saL3rlduLe/wCRQVSza+bi14crSyea/dU1Ke
	bNs8VcHj/ska7PDg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="f/QCIhWZ";
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=GEkEf9Jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1714469194;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xO4k9nXPK+IndlDMk8BQ0nzkGaUH7xSxSdK3nRCQV+8=;
	b=f/QCIhWZho7tjnkJG96Nirz0xav8b4sNO7+tLpJuo659ea711Mwn23u9GLdKaQXBisvF0d
	zuVV0J5t0ltBDCAnDqCi5Q2Uj9DILXzcWr5dcUoiBxE8Z6jcKfcWiNJludMssalqHrZsef
	iY2SgZWknQmAzTdtZKpnPRYHy0q9fvw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1714469194;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xO4k9nXPK+IndlDMk8BQ0nzkGaUH7xSxSdK3nRCQV+8=;
	b=GEkEf9JpxbJ0aQ359eixjn7NPDBOCRWGk0saL3rlduLe/wCRQVSza+bi14crSyea/dU1Ke
	bNs8VcHj/ska7PDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 35CBF133A7;
	Tue, 30 Apr 2024 09:26:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id O6iYDEq5MGYOXgAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Tue, 30 Apr 2024 09:26:34 +0000
Date: Tue, 30 Apr 2024 11:19:19 +0200
From: David Sterba <dsterba@suse.cz>
To: Jens Axboe <axboe@kernel.dk>
Cc: Matthew Wilcox <willy@infradead.org>,
	Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
	linux-block@vger.kernel.org
Subject: Re: [PATCH] bio: Export bio_add_folio_nofail to modules
Message-ID: <20240430091919.GL2585@suse.cz>
Reply-To: dsterba@suse.cz
References: <20240425163758.809025-1-willy@infradead.org>
 <aba5fed0-9f0c-4857-927d-d2cdccf8ca88@kernel.dk>
 <Ziu0But3Q6kc1DhK@casper.infradead.org>
 <3604bf42-16a9-438e-a68a-05f3c81383a4@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3604bf42-16a9-438e-a68a-05f3c81383a4@kernel.dk>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Flag: NO
X-Spam-Score: -4.21
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 52F161F7B4
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.21 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DWL_DNSWL_BLOCKED(0.00)[suse.cz:dkim];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]

On Fri, Apr 26, 2024 at 08:03:56AM -0600, Jens Axboe wrote:
> On 4/26/24 8:02 AM, Matthew Wilcox wrote:
> > On Fri, Apr 26, 2024 at 07:41:29AM -0600, Jens Axboe wrote:
> >> On 4/25/24 10:37 AM, Matthew Wilcox (Oracle) wrote:
> >>> Several modules use __bio_add_page() today and may need to be converted
> >>> to bio_add_folio_nofail().
> >>
> >> Confused, we don't have any modular users of this. A change like this
> >> should be submitted with a conversion.
> > 
> > Thank you for reinforcing my point.
> > 
> > https://lore.kernel.org/linux-fsdevel/ZiqHIH3lIzcRXCkU@casper.infradead.org/
> > 
> > Can I have an Acked-by so David can take it through the btrfs tree?
> 
> Yeah that's fine, makes more sense now than the standalone one:
> 
> Reviewed-by: Jens Axboe <axboe@kernel.dk>

Thanks, I'll add it to Matthew's series in my patch queue and it'll
appear in linux-next soon.
