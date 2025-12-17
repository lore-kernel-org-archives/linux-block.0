Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C29F3359F96
	for <linux-block@vger.kernel.org>; Wed, 17 Dec 2025 17:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765993733; cv=none; b=poK2PvbHuqUy552jPSX5+CO9AgAWSqteOa7GRmR3hMAXw4hLscdkZISDD9ojqMxbIETShlH7o5O546hG/zorK+BfH14Zw4KjJlGOTJ5djWiU7d60I45aLq68e9lRnoO/Qg07ozNix82eu+kn/UI7vbdiFImcVdU/R5kk1B0lmOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765993733; c=relaxed/simple;
	bh=LFDtB0r86QEKLFsnS02ZL6NTbx2AKlKYiF5fTNtX9hk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t8HO3kEgBh2Jew84iHTqUFePYPgvx6yghGQuKri/d+06b0pbbs5aEHoJATgI+IKjFiReCgbFZEpNSaBZOux11Wm/bv9r8Ll6rIjYJ6t3dITW+Yw4eVQSnYlMHXPdO/06oYYrxrEBIgZlUjvcUuhW0PkWUHTyQJSghQi0a4JSBJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=1adiwEVo; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=OLcqSrYR; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=oTVzYNkj; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=zdd+NOOS; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="1adiwEVo";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="OLcqSrYR";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="oTVzYNkj";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="zdd+NOOS"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 890E633686;
	Wed, 17 Dec 2025 17:48:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1765993728; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ACjv9YCYwXqfRo0SpAmCwomizfuUlLcU/KB0MDUNKfM=;
	b=1adiwEVopiVVjqYDezacgJ9Uphut5A8jes7HizS0ZJAubfNV2Kyebi4EFkDnHydwDXLJNb
	pykcbq+KHEcBLsNAx+Y4i5JZ4cK/0LwLCMHJO9qOqEcTcl/YJM09LWQjrC4wdQ1Ah/3p+q
	3cVWqnZ7v5sq02BduQz/2Eos7/ny9Gg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1765993728;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ACjv9YCYwXqfRo0SpAmCwomizfuUlLcU/KB0MDUNKfM=;
	b=OLcqSrYROCIftQl5nWPNZqQiFcIfzt02zdXs+Nr2KliFSTPtlUp1hiztgi522XhxqKzCt3
	O1+NwzHcvmpkULAQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1765993727; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ACjv9YCYwXqfRo0SpAmCwomizfuUlLcU/KB0MDUNKfM=;
	b=oTVzYNkjQO1eR75xxqdzn1xwVa+JFuA+vx1spimLbdxT0zLzsRdMOVfuk8DYO6tGu3s0m6
	bL1+7q2JyoPH3saAFCoo0kKeVT7vfAy/pmRjmLuLx7nN/lJ0mdONvFUxt5jRADAFNrKIzB
	6fHv+p/9XI6o0R6hW7HsNh/qnbN1ihI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1765993727;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ACjv9YCYwXqfRo0SpAmCwomizfuUlLcU/KB0MDUNKfM=;
	b=zdd+NOOSsF3cw571GOEYzZBxeoKvujJWstHnG32OGu1p/YQ6/sR2y4zfyZGMNolURml7uC
	S9+hLWPew5iBoFCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7AAB43EA63;
	Wed, 17 Dec 2025 17:48:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id dBFpHf/sQmlJSAAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 17 Dec 2025 17:48:47 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 23D2DA08CC; Wed, 17 Dec 2025 18:48:47 +0100 (CET)
Date: Wed, 17 Dec 2025 18:48:47 +0100
From: Jan Kara <jack@suse.cz>
To: Raphael Pinsonneault-Thibeault <rpthibeault@gmail.com>
Cc: axboe@kernel.dk, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org, jack@suse.cz, cascardo@igalia.com, 
	linux-kernel-mentees@lists.linux.dev, skhan@linuxfoundation.org, 
	syzbot+3ee481e21fd75e14c397@syzkaller.appspotmail.com
Subject: Re: [PATCH] loop: don't change loop device under exclusive opener in
 loop_set_status
Message-ID: <2crvwmytxw5splvtauxdq6o3dt4rnnzuy22vcub45rjk354alr@6m66k3ucoics>
References: <20251114144204.2402336-2-rpthibeault@gmail.com>
 <i5xuxe6prso72euxxo4jludbb5fb2juh2ofbgf32ts7aruyesc@na6btym6jats>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <i5xuxe6prso72euxxo4jludbb5fb2juh2ofbgf32ts7aruyesc@na6btym6jats>
X-Spam-Flag: NO
X-Spam-Score: -2.30
X-Spam-Level: 
X-Spamd-Result: default: False [-2.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	MISSING_XM_UA(0.00)[];
	TAGGED_RCPT(0.00)[3ee481e21fd75e14c397];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	URIBL_BLOCKED(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo,appspotmail.com:email,suse.cz:email,syzkaller.appspot.com:url]

On Tue 02-12-25 11:07:06, Jan Kara wrote:
> On Fri 14-11-25 09:42:05, Raphael Pinsonneault-Thibeault wrote:
> > loop_set_status() is allowed to change the loop device while there
> > are other openers of the device, even exclusive ones.
> > 
> > In this case, it causes a KASAN: slab-out-of-bounds Read in
> > ext4_search_dir(), since when looking for an entry in an inlined
> > directory, e_value_offs is changed underneath the filesystem by
> > loop_set_status().
> > 
> > Fix the problem by forbidding loop_set_status() from modifying the loop
> > device while there are exclusive openers of the device. This is similar
> > to the fix in loop_configure() by commit 33ec3e53e7b1 ("loop: Don't
> > change loop device under exclusive opener") alongside commit ecbe6bc0003b
> > ("block: use bd_prepare_to_claim directly in the loop driver").
> > 
> > Reported-by: syzbot+3ee481e21fd75e14c397@syzkaller.appspotmail.com
> > Closes: https://syzkaller.appspot.com/bug?extid=3ee481e21fd75e14c397
> > Tested-by: syzbot+3ee481e21fd75e14c397@syzkaller.appspotmail.com
> > Signed-off-by: Raphael Pinsonneault-Thibeault <rpthibeault@gmail.com>
> 
> This patch looks mostly good to me. Just one comment:
> 
> > -loop_set_status(struct loop_device *lo, const struct loop_info64 *info)
> > +loop_set_status(struct loop_device *lo, blk_mode_t mode,
> > +		struct block_device *bdev, const struct loop_info64 *info)
> >  {
> >  	int err;
> >  	bool partscan = false;
> >  	bool size_changed = false;
> >  	unsigned int memflags;
> >  
> > +	/*
> > +	 * If we don't hold exclusive handle for the device, upgrade to it
> > +	 * here to avoid changing device under exclusive owner.
> > +	 */
> > +	if (!(mode & BLK_OPEN_EXCL)) {
> > +		err = bd_prepare_to_claim(bdev, loop_set_status, NULL);
> > +		if (err)
> > +			goto out_reread_partitions;
> > +	}
> > +
> 
> So now any LOOP_SET_STATUS call will fail for device that is already
> exclusively open. There are some operations (like modifying the AUTOCLEAR
> flag or loop device name) that are safe even for a device with a mounted
> filesystem. I wouldn't probably bother with that now but I wanted to note
> that there may be valid uses of LOOP_SET_STATUS even for an exclusively
> open loop device and if there are users of that out there we might need to
> refine this a bit. Anyway for now feel free to add:
> 
> Reviewed-by: Jan Kara <jack@suse.cz>

Raphael, this patch seems to have fallen through the cracks. Can you please
resend it to Jens with by Reviewed-by tag so that he picks it up? Thanks!

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
