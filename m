Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A423015A8;
	Mon, 10 Jun 2024 14:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718028810; cv=none; b=hVIVLaBEVuGawFSp8Sc9DW1dHrkrLEkrhkgGmQFIROYadQkja5FsVnsDeITYgArtJC2NHzetjWmreVac/wJXyRH6z5IKU7u8nkbQl9McvMynRqFNiEPRIMILvBNzk3ik4peJ6esQ8DT7vlm6R8bTK10RJ/4LpdHBxhUOcxKyf/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718028810; c=relaxed/simple;
	bh=659iZLc6HgV20+vEs3FFtbeaJDyW0d2RAagxZHSB9E0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V1aUFipTxjZcScarUB37kWCdEPIh2eqAdF6mqX4SRQEH8HllpR4zkmnlFGY9nbO8jS05PnPt6fpf2DKDAZeKZA7gI7/rOXIotp52VSvT9jrfi/wE6YyS46qiz98da0kCm/0kCVyNApOGbaY8Z0n17jkblWgrDIAP9bpybbOEkMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=uUq+XjCV; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=8tOYvZPs; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=uUq+XjCV; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=8tOYvZPs; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="uUq+XjCV";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="8tOYvZPs";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="uUq+XjCV";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="8tOYvZPs"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id BABEB1F809;
	Mon, 10 Jun 2024 14:13:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1718028806; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=S24EjwAJXanrKH7TQomb+RV2l81bCGv/31nqUxjtpK0=;
	b=uUq+XjCVyrIRJBADPwQTyGVep+642Q0te+UmCUysLC2v4MvjuqAzIXmlTaAX6JmXBExhje
	w5962MXgQhc2PvuMwvcHioFl7EV00U8QB8pDuBSGkE1DDFaEK7pMufDHc8yRzfjaBur28k
	ayD3Z3Xu2VkMK6P11oI1ziR3KcouSZc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1718028806;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=S24EjwAJXanrKH7TQomb+RV2l81bCGv/31nqUxjtpK0=;
	b=8tOYvZPsguKvQo8jtyo9Q3fnpjsJd+8YnxkCDTfwjGEVAWErPDYLPIKQo0zEX9g4Cacr+W
	Iiqdhulm2aqGGrCA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1718028806; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=S24EjwAJXanrKH7TQomb+RV2l81bCGv/31nqUxjtpK0=;
	b=uUq+XjCVyrIRJBADPwQTyGVep+642Q0te+UmCUysLC2v4MvjuqAzIXmlTaAX6JmXBExhje
	w5962MXgQhc2PvuMwvcHioFl7EV00U8QB8pDuBSGkE1DDFaEK7pMufDHc8yRzfjaBur28k
	ayD3Z3Xu2VkMK6P11oI1ziR3KcouSZc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1718028806;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=S24EjwAJXanrKH7TQomb+RV2l81bCGv/31nqUxjtpK0=;
	b=8tOYvZPsguKvQo8jtyo9Q3fnpjsJd+8YnxkCDTfwjGEVAWErPDYLPIKQo0zEX9g4Cacr+W
	Iiqdhulm2aqGGrCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9A3D013A7F;
	Mon, 10 Jun 2024 14:13:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id n11gJAYKZ2blQQAAD6G6ig
	(envelope-from <chrubis@suse.cz>); Mon, 10 Jun 2024 14:13:26 +0000
Date: Mon, 10 Jun 2024 16:13:23 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Christoph Hellwig <hch@infradead.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, Jan Kara <jack@suse.cz>
Subject: Re: [PATCH] loop: Disable fallocate() zero and discard if not
 supported
Message-ID: <ZmcKA3zHsOYlyaiq@yuki>
References: <20240607091555.2504-1-chrubis@suse.cz>
 <ZmPvNu-YijbtJkeR@infradead.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZmPvNu-YijbtJkeR@infradead.org>
X-Spam-Flag: NO
X-Spam-Score: -3.80
X-Spam-Level: 
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:email]

Hi!
> > How to reproduce:
> > 
> > 1. make sure /tmp is mounted as tmpfs
> > 2. dd if=/dev/zero of=/tmp/disk.img bs=1M count=100
> > 3. losetup /dev/loop0 /tmp/disk.img
> > 4. mkfs.ext2 /dev/loop0
> > 5. dmesg |tail
> 
> Can you wire this up for blktests?

Will try.

> > +	if (ret == -EOPNOTSUPP) {
> > +		struct queue_limits lim = queue_limits_start_update(lo->lo_queue);
> > +
> > +		if (mode & FALLOC_FL_ZERO_RANGE)
> > +			lim.max_write_zeroes_sectors = 0;
> > +
> > +		if (mode & FALLOC_FL_PUNCH_HOLE) {
> > +			lim.max_hw_discard_sectors = 0;
> > +			lim.discard_granularity = 0;
> > +		}
> > +
> > +		queue_limits_commit_update(lo->lo_queue, &lim);
> 
> Please split this out into a separate helper to keep it out of the
> main fast path I/O handling.  A little comment that we are
> optimistically trying these if ->fallocate is support and might have
> to paddle back here would also be useful.

Will do.

Do we need noinline attribute for the function as well or unlikely() in
the if condition?

> (and maybe one day we figure out a way for the file system to
> advertise what fallocate modes it actually supports..)

One of my ideas was to try fallocate() with zero size in the
loop_reconfigure_limits() to see if we get EOPNOTSUPP but for that to
work we would have to make sure that we do not bail early on zero size
in the vfs layer...

-- 
Cyril Hrubis
chrubis@suse.cz
